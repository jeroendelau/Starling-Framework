Starling: Changelog
===================

version 1.7 - 2015-07-02
------------------------

- added support for stencil masking of all display objects via new 'mask' property
- added 'Polygon' class for describing closed two-dimensional shapes
- added 'Canvas' class for basic vector drawing functionality (main use right now: masking)
- added support for video textures via 'Texture.fromNetStream' and 'Texture.fromCamera'
- added 'property hints' to tweening methods (providing easier handling of color and angle)
- added 'ArrayUtil' + 'VectorUtil' classes (for insertion & removal of objects without allocations)
- added 'reverseFrames' method to MovieClip class
- added 'leading' property to TextField class
- added 'scaleWhenOver' property to Button class
- added 'alphaWhenDown' property to Button class
- added better touch handling for buttons (restoring downstate after rollout & -in)
- added 'isCubeMap' property to 'ATFData' class
- added support for enqueuing 'URLRequest' objects in AssetManager (thanks to SamYStudiO)
- added 'standardConstrained' profile to 'auto' profile selection (thanks to Andras Csizmadia)
- added 'standardExtended' profile to 'auto' profile selection (thanks to Andras Csizmadia)
- added 'MathUtil.clamp()'
- added optimized internal 'Polygon' implementations for circle, ellipse, and rectangle
- added a warning message when 'frame' rectangle is used in an unsupported way.
- added a warning message when using masks, but 'depthAndStencil' is deactivated in app descriptor
- added support for 'AssetManager.transformData' to return 'null'
- added 'complete' method to 'DelayedCall'
- added support for bigger TTF text fields by lowering resolution (thanks to Haruka Kataoka)
- added better parameter checks for 'BitmapFont' constructor
- added 'Texture.maxSize' property to find out maximum texture dimensions on current device
- added latest 'AGALMiniAssembler' with support for new profiles ('standardConstrained/Extended')
- added null reference check to 'Juggler.tween'
- added support for assigning Starling root class after constructor
- added support for negative indices to 'DisplayObjectContainer.getChildAt'
- added BlendMode 'mask' for RenderTexture drawing (thanks to Łukasz Łazarecki)
- added 'Event.RENDER' event, dispatched by Starling right before rendering is about to start
- added support for latest ATF format updates (coming with AIR 18)
- optimized state changes caused by tinting, reducing draw calls in 'baselineExtened' or higher
- optimized temporary object allocations of DisplayObjectContainer (avoiding 'splice')
- optimized temporary object allocations in bitmap font registration
- changed default of 'handleLostContext' to 'true'
- fixed that 'autoScale' did not work for html text
- fixed calculation of UV coordinates in DisplacementMapFilter in case of conflicting scale factors
- fixed missing application of 'repeat' parameter in DisplacementMapFilter constructor
- fixed accessibility of atlas and bitmap font textures in AssetManager (reverting to old behavior)
- fixed error when calling 'clear' within 'RenderTexture.drawBundled'
- fixed that 'mNextTween' was not set to null in 'Tween.reset' method (thanks to Sebastien Flory)
- fixed possible memory leak when using async ATF texture upload (thanks to Vladimir Atamanov)
- fixed that 'Button' state textures did not support frames
- fixed that AssetManager failed loading when enqueued file contained non-ASCII path string
- fixed that losing Stage3D context could result in runtime exception (thanks to Andras Csizmadia)
- fixed that ATF textures were added to AssetManager prior to their 'onComplete' callback
- fixed problems with TravisCI tests (thanks to Andras Csizmadia)
- fixed that flattened filtered objects caused GPU memory to leak
- fixed that DropShadow produced weird results in combination with 'clipRect'
- fixed that 'RenderTexture.draw' did not restore original render target
- fixed that lost context was not recognized from empty 'driverInfo' string
- fixed that sound of a MovieClip's last frame was played twice
- fixed that sound of a MovieClip's first frame was not played in first cycle
- fixed that 'SoundTransform' object was not always used by MovieClip
- fixed that 'HOVER' event was sometimes dispatched on devices that do not support mouse cursors
- fixed null-reference error in AssetManager caused by io-error while restoring textures
- fixed possible problems caused by 'getTimer' overflow

version 1.6 - 2014-12-12
------------------------

- added 'Sprite3D' class for simple 3D transformations
- added 3D transformation methods to DisplayObject, RenderSupport and MatrixUtil classes
- added 3D camera properties to Stage class ('fieldOfView', 'focalLength', 'projectionOffset')
- added 'is3D' property to DisplayObject class
- added parallel asset loading to AssetManager class (via 'numConnections' property)
- added build scripts for Gradle and Maven (thanks to Andras Csizmadia & Honza Břečka)
- added automatic TravisCI integration tests (thanks to Andras Csizmadia & Honza Břečka)
- added 'RenderTexture.optimizePersistentBuffers' to enable single-buffered render textures
- added support for nested filters (thanks to AIR 15)
- added support for drawing filtered objects to render textures
- added support for HTML text to 'TextField' class (TrueType fonts only)
- added 'color' property to Button class
- added 'over' and 'disabled' states to Button class
- added 'overlay' property to Button class
- added 'readjustSize' method to Button class
- added 'hasChars' utility method to BitmapFont class
- added 'getCharIDs' utility method to BitmapFont class
- added 'texture' property to BitmapFont class
- added 'textureFormat' property to AssetManager class
- added 'isLoading' property to AssetManager class
- added 'textureRepeat' property to AssetManager class
- added 'IO_ERROR' event to AssetManager class (when loading from URLLoader fails)
- added 'PARSE_ERROR' event to AssetManager class (thanks to Thomas Lefevre)
- added 'SECURITY_ERROR' event to AssetManager class (thanks to Honza Břečka)
- added some 'protected' qualifiers to AssetManager methods, for better extensibility
- added 'FATAL_ERROR' event to Starling class (thanks to Andras Csizmadia)
- added 'stopWithFatalError' method to Starling class
- added 'backBufferPixelsPerPoint' property to Starling class
- added 'ignoreChildOrder' parameter to 'Sprite.flatten()' (thanks to vync79)
- added 'cleanMasterString' utility method (thanks to Jackson Dunstan)
- added ByteArray-fallback if AssetManager can't parse XML or JSON
- added ability to chain ColorMatrixFilter functions (thanks to Tim Conkling)
- added 'standard' profile to automatic profile selection
- added 'supportsRelaxedTargetClearRequirement' property to SystemUtil class
- added 'format' and 'repeat' arguments to RenderTexture constructor
- added 'soundTransform' property to MovieClip class (thanks to Kawika Heftel)
- added 'setQuad' method to QuadBatch class
- added MathUtil class
- added project and module files for IntelliJ IDEA
- added helper script 'copy_resources.rb' for IntelliJ IDEA
- optimized: persistent render textures no longer require double buffering (thanks to AIR 15)
- optimized all internal XML parsing (thanks to JohnHeart & Andrew Pellerano)
- optimized BitmapFont composition - now pooling all temporary objects
- optimized memory management for some internally used BitmapData (TextField, MiniBitmapFont)
- optimized 'TextureAtlas.getNames' by caching sorted list of names
- optimized 'TextureAtlas.getTexture' by always returning the same SubTexture instances
- optimized 'DisplayObject.removeEventListeners' (thanks to Fraggle)
- optimized 'AssetManager.loadQueue' by processing font/atlas XMLs in separate steps
- optimized 'advanceTime' method in MovieClip class
- optimized 'execute' function by avoiding 'Array.slice'
- optimized handling of pass textures in FragmentFilter (avoiding chance of null reference)
- optimized AOT performance by avoiding 'Array.push' in several places
- optimized Scaffold and Demo projects so that they no longer need an embedded background texture
- fixed 'auto' profile selection so that it explicitly avoids software rendering if possible
- fixed: now conserving 'onReady' texture option when loading ATF texture
- fixed: more reliable 'context' property in shared context situations (if runtime supports it)
- fixed handling of invalid image data in AssetLoader
- fixed how fragment filter reuses pass textures (thanks to ludddd)
- fixed how errors are caught while loading 'AssetManager' queue (moved try/catch)
- fixed that 'Texture.empty' sometimes did not return the requested size
- fixed that blend mode was not reset after drawing into RenderTexture (thanks to Łukasz Łazarecki)
- fixed that QuadBatch did not throw error when maximum size was exceeded
- fixed that onRepeat(Args) was not cleared with 'Tween.reset()' (thanks to divillysausages)
- fixed that touch events were dispatched continuously after an uncaught error in the listener
- fixed wrong BitmapData size in 'drawToBitmapData' when using HiDPI displays
- fixed: 'AssetManager.verbose' is now enabled by default, so that it's not overlooked
- fixed: 'this' pointer within tween callbacks now point to the tween (thanks to Luke Hutscal)
- fixed that 'clear' call with color/alpha on RenderTexture did not work when done before drawing
- fixed: missing dispose call in 'drawToBitmapData' of Stage class
- fixed: missing dispose call in internal 'compile' method of FragmentFilter class
- fixed: 'ColorMatrixFilter.tint' did not return 'this' (thanks to Simon Rodriguez)

version 1.5.1 - 2014-05-26
--------------------------

- exchanged references to 'HTTPStatusEvent.HTTP_RESPONSE_STATUS' with custom constant,
  to avoid problems in pure Flash projects

version 1.5 - 2014-05-21
------------------------

- added support for automatic Context3D profile selection
- added automatic usage of RectangleTextures when possible, to save memory
- added support for rotated SubTextures (for tools like 'TexturePacker')
- added support for 'File' instances to 'AssetManager.enqueueWithName'
- added support for per-texture options to 'AssetManager.enqueueWithName'
- added support for multiple Starling instances when using AssetManager
- added support for 'background execution' to AssetManager
- added support for latest ATF file format
- added support for Antialiasing in RenderTextures (coming with AIR 13)
- added automatic pooling of delayed calls in 'Juggler.delayCall'
- added 'repeatCall' convenience function to Juggler
- added 'touchGroup' property to containers, similar to 'mouseChildren' in classic Flash
- added 'SystemUtil' class to simplify platform-dependent tasks
- added 'offsetX/Y' properties to BitmapFont
- added 'transparent' parameter to 'Stage.drawToBitmapData'
- added 'Texture.fromData' method
- added 'rgb' and 'alpha' arguments to 'RenderTexture.clear'
- added static 'defaultTextureFormat' property to TextField
- added more dispose calls to AssetManager (e.g. when replacing existing objects)
- added transformation matrix property to 'SubTexture' class
- added 'RectangleUtil.getBounds' method
- added a check if clearing a non-POT RectangleTexture works (workaround for iPad 1 AIR bug)
- added additional context-validity checks for more reliable context loss handling
- added 'ColorMatrix.tint' method for Flash-like tinting (thanks to esdebon)
- added 'BlendMode.BELOW' to draw below objects on RenderTextures
- added protected 'transformData' method to AssetManager, enabling preprocessing of raw byte data
- added 'execute' utility function
- added protected property to Juggler that allows access to the objects vector
- added 'muted' property to MovieClip
- added 'keepAtlasXmls' and 'keepFontXmls' properties to AssetManager
- added static 'all' property to Starling, allowing access to all instances (thanks to Josh)
- added support for HTTP 'content-type' to AssetManager, used if no file extension is found
- added property 'numCurrentTouches' to TouchProcessor
- added check if context is valid before dispatching 'RESIZE' events
- optimized Start-up time immensely by lazily creating AGAL programs (thanks to ajwfrost)
- optimized performance of 'DisplayObject.rotation' setter by avoiding loop (thanks to zeh)
- optimized Bitmap Font rendering by reducing object allocations massively (thanks to Jeff)
- optimized 'Quad.setColor' (thanks to IonSwitz)
- optimized 'DisplayObject.transformationMatrix' setter
- optimized capacity change of QuadBatch instance
- optimized 'removeEventListener'
- optimized 'Texture.frame' getter by avoiding allocation
- fixed parsing of filename and extension of AssetManager object
- fixed null reference on lost context after changing a font from TrueType to BMP
- fixed compiler warning in Flash CC
- fixed multiple dispatching of 'addedTo'- and 'removedFromStage' events
- fixed RenderTexture closure allocations (thanks to Jonathan Hart)
- fixed timing issues when calling 'purgeQueue' and 'loadQueue' in succession
- fixed that 'advanceTime' was called after context was lost
- fixed occasional null reference within TextField class after context loss
- fixed maximum size of QuadBatch
- fixed missing TextField disposal in Button
- fixed text alignment getter in TextField
- fixed error when context loss occurred while processing AssetManager queue
- fixed support for restoring cached filters on a context loss (at least partially)
- fixed clipping of 'nativeFilters' on TextField
- fixed 'deactivate' event handlers of TouchProcessor
- fixed potential division through zero on 'DisplayObject.transformationMatrix' setter
- fixed that BitmapFonts with 'autoSize' enabled would split words in half
- fixed that touch queue was not purged on App interruption
- fixed 'mapPoint' of DisplacementMapFilter (now taking scale factor into account)
- fixed overloading of time-based animations by clamping 'passedTime' to a maximum of 1 second

version 1.4.1 - 2013-10-15
--------------------------

- added public 'AssetManager.numQueuedAssets' property
- added protected 'AssetManager.queue' property
- added 'Starling.registerProgramFromSource' method
- optimized text rendering on buttons by enabling their 'batchable' property
- optimized fragment filter construction by caching shader programs (thanks to IonSwitz)
- optimized 'VertexData.numVertices' setter (thanks to hamidhomatash)
- fixed erroneous 'clipRect' when it was completely outside the stage bounds
- fixed error in 'AssetManager.loadQueue' when 'purgeQueue' was called during active timeout
- fixed anonymous function for FDT compatibility of Scaffold project

version 1.4 - 2013-09-23
------------------------

- added 'Sprite.clipRect' property for simple rectangular masking (thanks to Tim Conkling)
- added 'DisplacementMapFilter'
- added support for 'HiDPI' (i.e. retina MacBooks)
- added support for RectangleTextures introduced in AIR 3.8
- added support for updated ATF file format
- added 'Texture.root.onRestore()' for manual texture restoration on context loss
- added 'Texture.fromEmbeddedAsset()'
- added 'TextField.autoSize' (thanks to Tim Conkling)
- added 'AssetManager.enqueueWithName()' for custom naming of assets
- added protected 'AssetManager.getName()' for custom naming rules in subclasses
- added protected 'TextField.formatText()' for subclassing (thanks to Grant Mathews)
- added support for generic XML, ByteArrays and JSON data to AssetManager
- added 'Stage.drawToBitmapData()' method for game screenshots
- added 'TextureAtlas.texture' property
- added 'Tween.getEndValue()' (thanks to Josh Tynjala)
- added 'Tween.getProgress()'
- added 'Quad.premultipliedAlpha' (for consistency)
- added 'AssetManager.checkPolicyFile'
- added 'AssetManager.purgeQueue()' method: empties the queue & stops all pending load operations
- added Event.TEXTURES_RESTORED, dispatched by AssetManager after context loss
- added 'TextField.redraw()' method to force immediate drawing of contents
- added 'DisplayObject.alignPivot()' for simple object alignment
- added optional 'id' parameter to 'TouchEvent.getTouch()' method
- added optional QuadBatch batching via 'QuadBatch.batchable'
- added 'RenderSupport.getTextureLookupFlags()'
- added 'Image.setTexCoordsTo()' method
- added 'Texture.adjustTexCoords()' method
- added support for all new Stage3D texture formats (including runtime compression on Desktop)
- added support for custom TouchProcessors (thanks to Tim Conkling)
- added 'suspendRendering' argument to 'Starling.stop()' method (for AIR 3.9 background execution)
- added more vertex & quad manipulation methods to QuadBatch
- optimized broadcast of ENTER_FRAME event
- optimized rendering by doing copy-transform simultaneously
- optimized 'DisplayObject.transformationMatrix' calculations (thanks to Ville Koskela)
- optimized hidden object allocations on iOS (thanks to Nisse Bryngfors & Adobe Scout)
- optimized handling of texture recreation in case of a context loss (requires much less memory)
- optimized usage of QuadBatches used during rendering (now trimming them)
- optimized 'Button' by removing TextField when text is empty String
- optimized 'DisplayObjectContainer.setChildIndex()' (thanks to Josh Tynjala)
- updated filename / URL parsing of AssetManager to be more robust (thanks to peerobo)
- updated Keyboard events: they are now broadcasted to all display objects
- updated 'transporter_chief.rb' to use 'iOS-deploy' instead of 'fruitstrap'
- updated the region a filter draws into (now limited to object bounds + margin)
- updated bitmap font registration to be case insensitive
- updated AssetManager to use texture file name as name for bitmap font
- updated QuadBatch: 'QuadBatch.mVertexData' is now protected, analog to 'Quad'
- updated Ant build-file to include ASDoc data in starling SWC
- fixed multitouch support on devices with both mouse and touch screen
- fixed that AssetManager sometimes never finished loading the queue
- fixed 'MovieClip.totalTime' calculations to avoid floating point errors
- fixed some problems with special cases within 'MovieClip.advanceTime()'
- fixed layout of monospace bitmap fonts
- fixed unwanted context3D-recreation in 'Starling.dispose()' (thanks to Sebastian Marketsmüller)
- fixed various errors in VertexData (thanks to hamidhomatash)
- fixed missing pivotX/Y-updates in 'DisplayObject.transformationMatrix' setter
- fixed native TextField padding value
- fixed that small filtered objects would cause frequent texture uploads
- fixed that 'DisplayObjectContainer.sortChildren()' used an unstable sorting algorithm
- fixed 'VertexData.getBounds()' for empty object
- fixed recursion error when applying filter on flattened object
- fixed dispatching of ADDED events when child was re-added to the same parent
- fixed missing HOVER event after ended Touches (caused hand-cursor to appear only after movement)
- fixed that clipping rectangle sometimes did not intersect framebuffer, leading to an error
- fixed TextField errors when the TextField-area was empty
- fixed UTF-8/16/32 recognition in AssetManager

version 1.3 - 2013-01-14
------------------------

- added FragmentFilter class for filter effects
- added BlurFilter for blur, drop shadow and glow effects
- added ColorMatrixFilter for color effects
- added experimental 'AssetManager' class to scaffold and demo projects
- added convenience method 'Juggler.tween'
- added 'repeatDelay' property to Tween class
- added 'onRepeat' and 'onRepeatArgs' callback to Tween class
- added 'repeatCount' and 'reverse' properties to Tween class
- added 'nextTween' property to Tween class
- added support for custom transition functions without string reference
- added 'TextureAtlas.getNames' method
- added text alignment properties to the Button class (thanks to piterwilson)
- added workaround for viewport limitations in constrained mode (thanks to jamikado)
- added setting of correct stage scale mode and align to Starling constructor
- added 'RectangleUtil' class with Rectangle helper methods
- added support for asynchronous loading of ATF textures
- added 'renderTarget' property to RenderSupport class
- added 'scissorRect' property to RenderSupport class
- added 'nativeWidth' & 'nativeHeight' properties to Texture classes
- added 'Juggler.contains' method (thanks to Josh Tynjala)
- added support for directly modifying Starling viewPort rectangle (without re-assigning)
- added option to ignore mip maps of ATF textures
- added 'reset' method to 'DelayedCall' class (thanks to Oldes)
- added support for infinite 'DelayedCall' repetitions
- added 'pressure' and 'size' properties to Touch
- added optional 'result' argument to 'Touch.getTouches' (thanks to Josh Tynjala)
- added optional 'result' argument to 'TextureAtlas.getTextures/getNames'
- added support for carriage return char in BitmapFont (thanks to marcus7262)
- added arguments for mipmaps and scale to 'fromBitmap' method (thanks to elsassph)
- added preloader to demo project
- added scale parameter to 'Starling.showStatsAt'
- added support for Event.MOUSE_LEAVE on native stage (thans to jamikado)
- added support for Maven builds (thanks to bsideup)
- added 'contextData' property on Starling instance
- added 'RenderSupport.assembleAgal'
- updated mobile scaffold and demo projects, now using the same startup class for Android & iOS
- updated methods in 'Transitions' class to be protected
- updated 'DisplayObject.hasVisibleArea' method to be public
- updated MovieClip.fps setter for better performance (thanks to radamchin)
- updated handling of shared context situations (now also supporting context loss)
- removed embedded assets to avoid dependency on 'mx.core' library
- fixed display list rendering when Starling is stopped (thanks to jamikado)
- fixed 'DisplayObject.transformationMatrix' setter
- fixed skewing to work just like in Flash Pro (thanks to tconkling)
- fixed 'Touch.get(Previous)Location' (threw error when touch target was no longer on the stage)
- fixed wrong x-offset on first bitmap char of a line (thanks to Calibretto)
- fixed bug when creating a SubTexture / calling 'Texture.fromTexture()' from a RenderTexture
- fixed disruptive left-over touches on interruption of AIR app
- fixed multiply blend mode for ATF textures
- fixed error when juggler purge was triggered from advanceTime
- fixed: bubble chain is now frozen when touch reaches phase "BEGAN"
- fixed: now disposing children in reverse order
- fixed: now forcing correct depth test and stencil settings
- fixed: stats display now remembers previous position

version 1.2 - 2012-08-15
------------------------

- added enhanced event system with automatic event pooling and new 'dispatchEventWith' method
- added support for Context3D profiles (available in AIR 3.4)
- added support for final ATF file format
- added support for skewing through new properties 'skewX' and 'skewY' on DisplayObjects
  (thanks to aduros, tconkling, spmallick and groves)
- added support for manually assigning a transformation matrix to a display object
  (thanks to spmallick)
- added new 'DRW' value in statistics display, showing the number of draw calls per frame
- added 'BitmapFont.createSprite' method, useful for simple text effects
- added support for a shared context3D (useful for combining Starling with other frameworks)
- added 'Starling.root' property to access the root class instance
- added 'BitmapFont.getBitmapFont' method
- added support for custom bitmap font names
- added support for batching QuadBatch instances
- added check that MovieClip's fps value is greater than zero
- added 'MatrixUtil' class containing Matrix helper methods
- added more optional 'result*'-parameters to avoid temporary object creation
- added native filter support to TextField class (thanks to RRAway)
- added 'getRegion' and 'getFrame' methods to TextureAtlas
- added new 'DisplayObject.base' property that replaces old 'DisplayObject.root' functionality.
- now, 'DisplayObject.root' returns the topmost object below the stage, just as in classic Flash.
- now determining bubble chain before dispatching event, just as in classic Flash
- now returning the removed/added child in remove/add methods of DisplayObject
- now returning the name of the bitmap font in 'registerBitmapFont' method
- moved 'useHandCursor' property from Sprite to DisplayObject
- updated AGALMiniAssembler to latest version
- optimized performance by using 2D matrices (instead of Matrix3D) almost everywhere
- optimized performance by caching transformation matrices of DisplayObjects
- optimized handling of empty batches in 'RenderSupport.finishQuadBatch' method
- optimized temporary object handling, avoiding it at even more places
- optimized localToGlobal and globalToLocal methods
- optimized bitmap char arrangement by moving color assignment out of the loop
- optimized bitmap char arrangement by pooling char location objects
- optimized abstract class check (now only done in debug player)
- optimized 'advanceTime' method in Juggler
- optimized MovieClip constructor
- fixed wrong char arrangement when last bitmap char is missing (thanks to qoolbox)
- fixed handling of touches that begin outside the viewport
- fixed wrong 'tinted' value when setting color to white
- fixed scaling implementation (did not take cached transformation matrix into account)
- fixed handling of duplicate event listeners
- fixed handling of duplicate tweens in juggler (thanks to bsideup)
- fixed bitmap font line position when text is truncated
- fixed memory leak when using Juggler.purge (thanks to vync79)
- fixed leak when computing display object's transformation matrix (thanks to Fraggle)
- fixed error caused by removal of sibling in REMOVED_FROM_STAGE event (thanks to Josh)
- fixed that ROOT_CREATED was sometimes dispatched in wrong situations (thanks to Alex and Marc)

version 1.1 - 2012-05-06
------------------------

- added support for multi-resolution development through 'contentScaleFactor'
- added demo project for mobile devices
- added scaffold project for mobile devices
- added blend modes
- added Flash Builder project files
- added ability to erase content from a render texture (through 'BlendMode.ERASE')
- added 'toString' method to Touch class
- added 'getBounds' utility method to VertexData class and using it in Quad class
- added ability to use 'QuadBatch' class as a display object
- added 'Starling.showStats' method for FPS and MEM monitoring
- added minimal Bitmap Font 'mini'
- added 'baseline' property to BitmapFont class
- added ability to use multiples of 'BitmapFont.NATIVE_SIZE'
- added 'Touch.getMovement' property
- added 'Transport Chief' script to deploy iOS apps via the terminal
- added reset method to tween class to support instance pooling (thanks to pchertok!)
- added 'Event.ROOT_CREATED', dispatched when the root object is ready (thanks to fogAndWhisky!)
- optimized shaders for iPad and comparable devices, leading to a much better performance
- optimized vertex buffer uploading for faster iPad 1 performance
- optimized 'Quad.getBounds' method
- optimized Bitmap Font rendering greatly
- optimized 'DisplayObjectContainer.contains' method greatly (thanks to joshtynjala!)
- optimized some matrix and rendering code (thanks to jSandhu!)
- fixed error when TextField text property was set to 'null'
- fixed wrong error output in 'Image.smoothing' setter
- fixed: pausing and restarting Starling now resets passed time
- fixed exception when child of flattened sprite had zero scaleX- or scaleY-value
- fixed exception on mipmap creation when texture was only one pixel high/wide
- fixed lost color data when pma vertex data was set to 'alpha=0' (thanks to Tomyail!)
- fixed: mouse, touch & keyboard events are now ignored when Starling is stopped
- fixed: native overlay is now still updated when Starling is stopped
- fixed possible blurring of persistent render texture (thanks to grahamma!)
- fixed drawing errors in render texture that occured with certain scale factors
- fixed error when MovieClip was manipulated from a COMPLETE handler

version 1.0 - 2012-02-24
------------------------

- reduced memory consumption a LOT by getting rid of many temporary objects
- added numerous performance enhancements (by inlining methods, removing closures, etc.)
- added 'sortChildren' method to DisplayObjectContainer, for easy child arrangement
- added 'useHandCursor' property to Sprite class
- added 'useHandCursor' activation to Button class
- added 'stage3D' property to Starling class
- added hover phase for both cursors in multitouch simulation
- added support to handle a lost device context
- added check for display tree recursions (a child must not add a parent)
- added support for having multiple Starling instances simultaneously
- added 'Event.COMPLETE' and using it in MovieClip class
- added Ant build file (thanks to groves!)
- added new artwork to demo project
- optimized MovieClip 'advanceTime' method
- changed IAnimatable interface:
    - removed 'isComplete' method
    - instead, the Juggler listens to the new event type REMOVE_FROM_JUGGLER
- fixed 'isComplete' method of various classes (possible due to IAnimatable change)
- fixed null reference exception in BitmapFont class that popped up when a kerned character
  was not defined (thanks to jamieowen!)
- fixed handling of platforms that have both mouse and a multitouch device
- fixed reliability of multitouch simulation
- fixed dispose method of main Starling class
- fixed bounds calculation on empty containers (thanks to groves!)
- fixed SubTextures: they are now smart enough to dispose unused base textures.
- fixed right mouse button issues in AIR (now only listening to left mouse button)

version 0.9.1 - 2011-12-11
--------------------------

- added property to access native stage from Starling class
- added property to access Starling stage from Starling class
- added exception when render function is not implemented
- moved touch marker image into src directory for better portability
- added bubbling for Event.ADDED and Event.REMOVED
- added 'readjustSize' method to Image
- added major performance enhancements:
    - created QuadBatch class as a replacement for the QuadGroup class, and using it for all quad
      rendering
    - optimized VertexData class
    - removed many Matrix allocations in RenderSupport class
    - removed many temporary object allocations
    - accelerated re-flattening of flattened sprites
    - replaced performance critical 'for each' loops with faster 'for' loops
- demo now automatically uses 30 fps in Software mode
- fixed center of rotation in multitouch demo
- fixed mouse/touch positions when stage size is changed
- fixed alpha propagation in flattened sprites
- fixed ignored bold property in TextField constructor
- fixed code to output fewer warnings in FDT

version 0.9 - 2011-09-11
------------------------

- first public version
