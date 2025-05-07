# 1. 清理之前的构建文件
npx ts-node ./.erb/scripts/clean.js dist

# 2. 安装依赖
npm install

# 3. 执行后安装脚本
npx ts-node .erb/scripts/check-native-dep.js && \
npx electron-builder install-app-deps && \
npx cross-env NODE_ENV=development TS_NODE_TRANSPILE_ONLY=true npx webpack --config ./.erb/configs/webpack.config.renderer.dev.dll.ts

# 4. 构建应用
# 4.1 构建主进程
npx cross-env NODE_ENV=production TS_NODE_TRANSPILE_ONLY=true npx webpack --config ./.erb/configs/webpack.config.main.prod.ts

# 4.2 构建渲染进程
npx cross-env NODE_ENV=production TS_NODE_TRANSPILE_ONLY=true npx webpack --config ./.erb/configs/webpack.config.renderer.prod.ts

# 5. 打包并发布
npx electron-builder build --mac