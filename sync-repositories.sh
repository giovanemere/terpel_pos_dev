#!/bin/bash

# Script para sincronizar cambios con GitHub y Azure DevOps
# Fecha: $(date +%Y%m%d)

echo "🔄 Sincronizando repositorios GitHub y Azure DevOps..."

# Variables
FECHA=$(date +%Y%m%d_%H%M%S)
COMMIT_MESSAGE="feat: Reportes completos MS POS Sincronización + IA Enterprise - $FECHA

- ✅ Análisis completo 4 arquitecturas (Node.js, Go, Python, Rust)
- 🤖 Modelo IA Enterprise para desarrollo acelerado
- 📊 Reportes PDF, Excel y HTML generados
- 💰 Presupuesto detallado con ROI IA (189% vs 1,198% sin IA)
- 🎯 Recomendación: Go + IA Enterprise ($258K, 1.8 semanas, 95% cobertura)
- 📈 Métricas y cronogramas actualizados
- 🛠️ Herramientas IA: Copilot, GPT-4, Claude, SonarQube AI
- 📋 Decision matrix y análisis 3 años incluidos"

# Verificar que estamos en el directorio correcto
if [ ! -d ".git" ]; then
    echo "❌ Error: No estamos en un repositorio Git"
    echo "📁 Directorio actual: $(pwd)"
    exit 1
fi

echo "📁 Directorio actual: $(pwd)"

# Verificar estado del repositorio
echo "📋 Estado actual del repositorio:"
git status --porcelain

# Agregar todos los archivos nuevos y modificados
echo "➕ Agregando archivos al staging..."
git add .

# Verificar qué se va a commitear
echo "📝 Archivos a commitear:"
git diff --cached --name-only

# Hacer commit
echo "💾 Creando commit..."
git commit -m "$COMMIT_MESSAGE"

if [ $? -ne 0 ]; then
    echo "⚠️  No hay cambios para commitear o error en commit"
    echo "📋 Estado actual:"
    git status
else
    echo "✅ Commit creado exitosamente"
fi

# Verificar remotes configurados
echo "🔗 Remotes configurados:"
git remote -v

# Función para push con manejo de errores
push_to_remote() {
    local remote_name=$1
    local remote_url=$2
    
    echo "🚀 Pushing a $remote_name ($remote_url)..."
    
    # Intentar push
    git push $remote_name main 2>&1
    
    if [ $? -eq 0 ]; then
        echo "✅ Push exitoso a $remote_name"
    else
        echo "❌ Error en push a $remote_name"
        echo "🔄 Intentando pull y merge..."
        
        # Intentar pull y merge
        git pull $remote_name main --no-edit 2>&1
        
        if [ $? -eq 0 ]; then
            echo "🔄 Pull exitoso, intentando push nuevamente..."
            git push $remote_name main 2>&1
            
            if [ $? -eq 0 ]; then
                echo "✅ Push exitoso a $remote_name después de merge"
            else
                echo "❌ Push falló definitivamente a $remote_name"
                return 1
            fi
        else
            echo "❌ Pull falló para $remote_name"
            return 1
        fi
    fi
    
    return 0
}

# Verificar si existe remote 'origin' (GitHub)
if git remote get-url origin >/dev/null 2>&1; then
    GITHUB_URL=$(git remote get-url origin)
    echo "🐙 GitHub detectado: $GITHUB_URL"
    push_to_remote "origin" "$GITHUB_URL"
else
    echo "⚠️  Remote 'origin' no configurado para GitHub"
fi

# Verificar si existe remote 'azure' (Azure DevOps)
if git remote get-url azure >/dev/null 2>&1; then
    AZURE_URL=$(git remote get-url azure)
    echo "☁️  Azure DevOps detectado: $AZURE_URL"
    push_to_remote "azure" "$AZURE_URL"
else
    echo "⚠️  Remote 'azure' no configurado"
    echo "🔧 Para configurar Azure DevOps:"
    echo "   git remote add azure https://periferiaitgrouptfs.visualstudio.com/TERPEL/_git/terpel_dev"
fi

# Verificar si hay otros remotes
OTHER_REMOTES=$(git remote | grep -v -E '^(origin|azure)$')
if [ ! -z "$OTHER_REMOTES" ]; then
    echo "🔗 Otros remotes detectados:"
    for remote in $OTHER_REMOTES; do
        remote_url=$(git remote get-url $remote)
        echo "   $remote: $remote_url"
        read -p "¿Hacer push a $remote? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            push_to_remote "$remote" "$remote_url"
        fi
    done
fi

# Resumen final
echo ""
echo "📊 RESUMEN DE SINCRONIZACIÓN:"
echo "================================"
echo "📅 Fecha: $(date)"
echo "💾 Commit: $COMMIT_MESSAGE"
echo ""

# Mostrar último commit
echo "📝 Último commit:"
git log --oneline -1

echo ""
echo "🎯 ARCHIVOS PRINCIPALES SINCRONIZADOS:"
echo "• 📋 Reportes PDF con análisis completo"
echo "• 📊 Excel con 7 hojas de datos IA"
echo "• 🌐 HTML con diagramas embebidos"
echo "• 🤖 Presupuesto IA Enterprise detallado"
echo "• 🏗️ Diagramas de arquitectura (4 opciones)"
echo "• 📈 Análisis ROI 3 años con IA"
echo ""

# Verificar estado final
echo "📋 Estado final del repositorio:"
git status

echo "✅ Sincronización completada"
