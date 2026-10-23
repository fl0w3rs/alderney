let mix = require('laravel-mix');
let fs = require('fs')

const { exec } = require('child_process');
 
exec('rm -rf public/dist/*', (err, stdout, stderr) => {});

mix.sass('assets/css/bundle.scss', 'public/dist/css/bundle.css')
    .sass('assets/css/toggles.scss', 'public/dist/css/toggles.css')
    .js('assets/js/main.js', 'public/dist/js/bundle.js')
    .js('assets/js/authentication.js', 'public/dist/js/ath.js')
    .js('assets/js/home.js', 'public/dist/js/hm.js')
    .js('assets/js/test.js', 'public/dist/js/test.js')
    .js('assets/js/admin/test_edit.js', 'public/dist/js/adm/testedt.js')
    .js('assets/js/admin/test_create.js', 'public/dist/js/adm/testcrt.js')
    .js('assets/js/admin/question_edit.js', 'public/dist/js/adm/qstnedt.js')
    .js('assets/js/admin/question_create.js', 'public/dist/js/adm/qstncrt.js')
    .copy('assets/mdb/compiled.css', 'public/dist/css/mdb.css')
    .copy('assets/mdb/compiled.js', 'public/dist/js/mdb.js')
    .copyDirectory('assets/images', 'public/dist/img');
    
fs.readFile('core/config.php', 'utf8', function (err, data) {
    if (err) {
        return console.log(err);
    }
    let rand_hash =  Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
    let result = data.replace(/'asset_version' => '.*',/g, `'asset_version' => '${rand_hash}',`);
    
    fs.writeFile('core/config.php', result, 'utf8', function (err) {
        if (err) return console.log(err);
    });
});

exec('rm -rf cache/*', (err, stdout, stderr) => {});
