module.exports = function(grunt) {

    // Configurable paths for the application
    var appConfig = {
            app: 'dev',
            dist: '../../static/#{STATIC_ROOT}',
            hlp: {
                bowerPath: './bower_components',
                bowerJS: [
                    'bootstrap-sass/assets/javascripts/bootstrap.js',
                    'jquery/dist/jquery.js',
                    'owl.carousel/dist/owl.carousel.js',
                    'slick-carousel/slick/slick.js',
                    'jquery-ui/jquery-ui.js',
                    'jquery.mb.ytplayer/dist/jquery.mb.YTPlayer.js',
                    'magnific-popup/dist/jquery.magnific-popup.js'
                ],
                pathRemove: [
                  'bootstrap-sass/assets/fonts', '/fonts','owl.carousel/',
                  'font-awesome/fonts','slick-carousel/slick/fonts'
                ],
                pathIgnore: [
                    '!font-awesome/**/*.css',
                    '!jcf/**/*.{png,jpg,gif,ico,jpeg,css}',
                    '!owl.carousel/dist/**/*.css',
                    '!owl.carousel/docs/**/**/*.css',
                    '!owl.carousel/docs/**/**/**/*.css',
                    '!owl.carousel/docs/assets/img/*.{png,jpg,gif,ico,jpeg}',
                    '!owl.carousel/docs/assets/owlcarousel/assets/*.{png,jpg,gif,ico,jpeg}',
                    '!owl.carousel/docs_src/assets/img/*.{png,jpg,gif,ico,jpeg}',
                    '!owl.carousel/src/img/*.{png,jpg,gif,ico,jpeg}',
                    '!owl.carousel/dist/**/*.{png,jpg,gif,ico,jpeg}',
                    '!owl.carousel/docs/**/*.{png,jpg,gif,ico,jpeg}',
                    '!slick-carousel/slick/*.css',
                    '!jquery-ui/themes/**/*.css',
                    '!jquery-ui/themes/**/*.{png,jpg,gif,ico,jpeg}',
                    '!slick-carousel/slick/*.{png,jpg,gif,ico,jpeg}',
                    '!magnific-popup/dist/*.css'
                ]
            },
            currentAbsPath: process.cwd(),
        },
        // remove unnecessary subdirectories
        removePath = function (dest, src) {
            var paths = appConfig.hlp.pathRemove;

            paths.map(function(element, index, array) {
                if (src.indexOf(element) > -1) {
                    // The `src` is being renamed; the `dest` remains the same
                    src = src.replace(element, '');
                }
            });
            return dest + src;
        };

    // Project configuration.
    grunt.initConfig({

        pkg: grunt.file.readJSON('package.json'),

        // Project settings
        conf: appConfig,


        // Coffee plugin
        coffee: {
            compile: {
                files: {
                    'js/script/coffee.js': ['_coffee/*.coffee', '_coffee/**/*.coffee']
                }
            }
        },

        // Compass plugin
        compass: {
            // Build the minified css
            dist: {
                options: {
                    banner: '/*!\n' +
                    ' * <%= pkg.name %>\n' +
                    ' * <%= pkg.url %>\n' +
                    ' * @author <%= pkg.author %>\n' +
                    ' * @author-url <%= pkg.authorUrl %>\n' +
                    ' * @version <%= pkg.version %>\n' +
                    ' */\n',
                    relativeAssets: true,
                    sassDir: '_sass',
                    cssDir: '<%= conf.dist %>/css',
                    imagesDir: '_assets/',
                    fontsDir: '<%= conf.dist %>/fonts/',
                    generatedImagesDir: "<%= conf.dist %>/img/",
                    httpGeneratedImagesPath: "../img",
                    environment: 'production',
                    specify: '_sass/*.min.scss'
                }
            },
            // Build not minified css
            build: {
                options : {
                    // banner: '<%= compass.dist.options.banner %>',
                    relativeAssets: '<%= compass.dist.options.relativeAssets %>',
                    sassDir: '<%= compass.dist.options.sassDir %>',
                    cssDir: '<%= compass.dist.options.cssDir %>',
                    imagesDir: '<%= compass.dist.options.imagesDir %>',
                    fontsDir: '<%= compass.dist.options.fontsDir %>',
                    generatedImagesDir: '<%= compass.dist.options.generatedImagesDir %>',
                    httpGeneratedImagesPath: '<%= compass.dist.options.httpGeneratedImagesPath %>',
                    noLineComment: true,
                    environment: 'development',
                    specify: '_sass/*.scss'
                }
            }
        },

        // fonts-face generator
        fontface: {
            dist: {
                options: {
                    fontDir: 'fonts',
                    outputFile: '_sass/_quarks/fonts.scss',
                    template:
                    '@include font-face("' +
                    '{{font}}", font-files(' +
                    '"{{font}}.woff", ' +
                    '"{{font}}.ttf", ' +
                    '"{{font}}.svg#{{font}}"), ' +
                    '"{{font}}.eot");'
                }
            }
        },

        // Concat plugin
        concat: {
            compact: {
                options: {
                    separator: ';'
                },
                // Uncomment if you want to get compact.js that contains all js files from folder
                src: ['!js/libs/**/*.js', '!js/script/!**!/!*.js', 'js/assets/!**/!*.js', 'js/!*.js'],
                dest: 'js/built/compact.js'
            },
            js: {
                src: ['js/script/*.js'],
                dest: 'js/app.js'
            }
        },


        // Uglify plugin
        uglify: { // Minify files with UglifyJS.
            options: {
                /*mangle: {
                    except: ['jQuery']
                },*/
                banner: '/*!\n' +
                ' * <%= pkg.name %>\n' +
                ' * <%= pkg.url %>\n' +
                ' * @author <%= pkg.author %>\n' +
                ' * @author-url <%= pkg.authorUrl %>\n' +
                ' * @version <%= pkg.version %>\n' +
                ' * @updated <%= grunt.template.today("yyyy-mm-dd") %> */\n'
            },
            build: {
                files: [
                    {
                        expand: true,
                        cwd: 'js',
                        src: ['libs/*.js', 'assets/*.js', 'built/*.js', '*.js'],
                        // src: ['libs/*.js', 'assets/*.js', '!built/*.js', '*.js'],
                        dest: '<%= conf.dist %>/js/min/',
                        ext: '.min.js'
                    }
                ]
            }
        },


        // Bower copy plugin
        copy: {
            bower: {
                files: [
                    {
                        expand: true,
                        cwd: '<%= conf.hlp.bowerPath %>/',
                        src: ['**/*.css', '<%= conf.hlp.pathIgnore %>'],
                        dest: '<%= conf.dist %>/css/',
                        flatten: true,
                        filter: 'isFile'
                    },
                    {
                        expand: true,
                        cwd: '<%= conf.hlp.bowerPath %>/',
                        src: '**/*.{svg,eot,ttf,woff,woff2,otf}',
                        dest: '<%= conf.dist %>/fonts/',
                        //flatten: true,
                        filter: 'isFile',
                        rename: removePath
                    },
                    {
                        expand: true,
                        cwd: '<%= conf.hlp.bowerPath %>/',
                        src: ['**/*.{png,jpg,gif,ico,jpeg}', '<%= conf.hlp.pathIgnore %>'],
                        dest: '<%= conf.dist %>/img/',
                        //flatten: true,
                        filter: 'isFile',
                        rename: removePath
                    },
                    {
                        expand: true,
                        cwd: '<%= conf.hlp.bowerPath %>/',
                        src: '<%= conf.hlp.bowerJS %>',
                        dest: 'js/assets/',
                        flatten: true,
                        filter: 'isFile'
                    }
                ]
            },
            js: {
                files: [
                    {
                        expand: true,
                        cwd: 'js/',
                        src: '**/*.js',
                        dest: '<%= conf.dist %>/js/',
                        flatten: true,
                        filter: 'isFile'
                    }
                ]
            },
            fonts: {
                files: [
                    {
                        expand: true,
                        cwd: 'fonts/',
                        src: '**/*.{svg,eot,ttf,woff,woff2,otf}',
                        dest: '<%= conf.dist %>/fonts/',
                        filter: 'isFile'
                    }
                ]
            },
            images: {
                files: [
                    {
                        expand: true,
                        cwd: '_assets/images/',
                        src: '**/*.{svg,jpg,jpeg,png,gif}',
                        dest: '<%= conf.dist %>/img/',
                        filter: 'isFile'
                    }
                ]
            }
        },


        // Jshint plugin
        jshint: { // Validate files with JSHint.
            all: ['Gruntfile.js', 'js/**/*.js', '!js/built/compact.js', '!js/assets/**/*.js']
        },

        // SVG Sprite
        svg_sprite: {
            basic: {
                // Target basics
                // expand: true,
                cwd: '_assets/svg',
                src: '**/*.svg',
                dest: '<%= conf.dist %>',

                // Target options
                options: {
                    mode: {
                        css: {     // Activate the «css» mode
                            render: {
                                css: false,  // Activate CSS output (with default options)
                                scss: {
                                    dest: '<%= conf.currentAbsPath %>/_sass/_molecules/svg-sprite.scss',
                                    template: './__lib/templates/svg-sprite.mustache'
                                }
                            },
                            prefix: ".svg--%s",
                            dimensions : "--size",
                            // dest: '',
                            sprite: "../img/sprite.svg"
                        }
                    }
                }
            }
        },


        // Assemble template html
        assemble: {
            options: {
                flatten: true,
                partials: ['_templates/_includes/**/*.hbs'],
                layoutdir: '_templates/_layouts',
                layout: 'default.hbs',
                staticPath: '..',
                helpers: ['./__lib/handlebars-helpers/**/*.js'],
                data: ['<%= conf.currentAbsPath %>/__data/**/*.{json,yml}']
            },
            site: {
                files: {'../public/': ['_templates/_pages/*.hbs']}
            }
        },


        // Injector (for including js/css files to html dynamically)
        injector: {
            options: {
                addRootSlash: false,
                ignorePath: '<%= conf.dist %>'
            },
            local_dependencies: {
                files: {
                    '_templates/_includes/head.hbs': [
                        '<%= conf.dist %>/js/min/assets/**/jquery.min.js',
                        '<%= conf.dist %>/js/min/assets/**/*.min.js',
                        '<%= conf.dist %>/js/min/**/*.min.js',
                        '!<%= conf.dist %>/js/min/**/compact.min.js',
                        '<%= conf.dist %>/css/**/*.min.css',
                        '!<%= conf.dist %>/css/**/bootstrap.min.css'
                    ]
                }
            }
        },

        // clean unnecessary files
        clean: {
            options: { force: true },
            svg_sprite: {
                src: [
                    "<%= conf.dist %>/img/**/sprite-*.svg"
                ]
            },
            images: {
                src: [
                    "<%= conf.dist %>/img/**/*.{png,jpg,jpeg,svg}",
                    "!<%= conf.dist %>/img/**/sprite-*.svg",
                    "!<%= conf.dist %>/img/**/pico-*.png"
                ]
            }
        },


        // Watch plugin
        watch: {
            options: {
                livereload: true // <script src="//localhost:35729/livereload.js"></script>
            },

            // Watch css
            css: {
                files: ['_sass/*.scss', '_sass/**/*.scss'],
                tasks: ['compass:dist']
            },

            // Watch js
            js: {
                files: ['js/**/*.js', 'js/*.js', 'Gruntfile.js' ],
                tasks: ['concat:js', 'jshint', 'newer:uglify']
            },

            // Watch HandleBarScript
            hbs: {
                files: ['_templates/**/*.hbs', '_templates/*.hbs', '<%= assemble.options.data %>'],
                tasks: ['assemble']
            },

            // Watch coffee
            scripts: {
                files: ['_coffee/*.coffee'],
                tasks: [ 'newer:coffee' ]
            },

            // Watch SVG
            svg: {
                files: ['<%= svg_sprite.basic.cwd %>/<%= svg_sprite.basic.src %>'],
                tasks: ['svg']
            },

            // Watch images
            images: {
                files: ['_assets/images/**/*'],
                tasks: ['clean:images', 'copy:images']
            }
        }

    });


    // NPM tasks
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-compass');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-newer');
    grunt.loadNpmTasks('grunt-assemble');
    grunt.loadNpmTasks('grunt-injector');
    grunt.loadNpmTasks('grunt-fontface');
    grunt.loadNpmTasks('grunt-svg-sprite');



    // Default tasks on running.
    grunt.registerTask('default', ['coffee', 'uglify', 'injector', 'assemble']);

    // Task for build fonts
    grunt.registerTask('fonts', ['fontface', 'copy:fonts']);

    // Task for inject to html js/css files
    grunt.registerTask('inject', ['injector']);

    // Task for sprite svg file
    grunt.registerTask('svg', ['clean:svg_sprite', 'svg_sprite']);

    // Task for build bower components
    grunt.registerTask('bower:update', ['copy:bower']);

    // Task for build public version of js
    grunt.registerTask('build', ['fontface', 'clean:images', 'copy', 'svg', 'compass', 'concat', 'jshint', 'uglify', 'assemble']);

};

