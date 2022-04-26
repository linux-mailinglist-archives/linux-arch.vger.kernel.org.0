Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D813E51040B
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353136AbiDZQrw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353154AbiDZQrt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:47:49 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B496E1971D3
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:39 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id s24-20020a05640217d800b00425e19e7deaso3804173edy.3
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p8FEo7s+Y/rcqoYNHQMIRhiXb9XntJYZxdO4j/h094A=;
        b=FN0NXTYm/4DM3BzRomEJlLBOdDZK2QtkvjCrwnxNu7ZCzEOc/oVhFdK4WXlDEVdirQ
         YuVhb8aZBGQP/vHgAYsLyv76/O97zW2Bf51WKCp789tm4Qjtf9zFBL3j57QvVDLDhnFw
         JWzYQwqOtyltmmcl+Arw6lRAwK/B1u8ETn2mV8K4IqKpBj4vuVhQCOItYU3wYbkHWE2J
         Z7jF6oHs4JLz+HXwY+ciXQdsTbDClhb4iTf+PvyW2JhTxjOung+RoUV/ib2RrncC3xwe
         fZCF7gC3F71l0WI97t3oSVGvki3Zm/4NN0wR3vTDsvenqe+v77M7MJ77kmQUAWJZ0U7L
         iRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p8FEo7s+Y/rcqoYNHQMIRhiXb9XntJYZxdO4j/h094A=;
        b=hydNw/B+OUrIhYiX8EPCa759Q6z0ltQkOL6fQea7PNVAcXHHKvs5AzKkicMvyWJR2O
         6D4AfeYgQu2kJ+PPR1tctSQe1ipgNqAXXlXOGshK9TYX3FBwU1HbN1L3J2j7lW6iekGz
         GmABj6WgHBYyEaihaq3nMcmIh4T2Cl5+nP7Ic7EHZWL1ht/ApNYDwbStUTVE45W9lfX2
         YW7AMwW73gUCT7F4dmLDXAPWhEedMhQkKUkQkdKS1G44XsZwD2397Et7zNFB/7qEPmRs
         TOi6cE0x5mgMXmjJevW252RmbKQ+9123BZIiib66VX3p/kPedT/F5PvA+fRAhoI6H8QI
         gzwQ==
X-Gm-Message-State: AOAM533F3KA6IPEZDSFJJ9YwJk6XGantN8A6G0E+C/fj4O3KWm8FkU8T
        6Y92kr7NvTXO9+9Ci4HcDLBTcPSLYuY=
X-Google-Smtp-Source: ABdhPJyCCyIfUafFOfp5MPZnTGpX5q6s2bnIOjoI2eskQhmcqE76RefRNF30puIR6F21nZAoW9kp50iu4zg=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:3553:b0:424:20d3:ae78 with SMTP id
 f19-20020a056402355300b0042420d3ae78mr25923509edd.290.1650991478143; Tue, 26
 Apr 2022 09:44:38 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:36 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-8-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 07/46] kmsan: add ReST documentation
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add Documentation/dev-tools/kmsan.rst and reference it in the dev-tools
index.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- added a note that KMSAN is not intended for production use

Link: https://linux-review.googlesource.com/id/I751586f79418b95550a83c6035c650b5b01567cc
---
 Documentation/dev-tools/index.rst |   1 +
 Documentation/dev-tools/kmsan.rst | 414 ++++++++++++++++++++++++++++++
 2 files changed, 415 insertions(+)
 create mode 100644 Documentation/dev-tools/kmsan.rst

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 4621eac290f46..6b0663075dc04 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -24,6 +24,7 @@ Documentation/dev-tools/testing-overview.rst
    kcov
    gcov
    kasan
+   kmsan
    ubsan
    kmemleak
    kcsan
diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tools/kmsan.rst
new file mode 100644
index 0000000000000..e116889da79d5
--- /dev/null
+++ b/Documentation/dev-tools/kmsan.rst
@@ -0,0 +1,414 @@
+=============================
+KernelMemorySanitizer (KMSAN)
+=============================
+
+KMSAN is a dynamic error detector aimed at finding uses of uninitialized
+values. It is based on compiler instrumentation, and is quite similar to the
+userspace `MemorySanitizer tool`_.
+
+An important note is that KMSAN is not intended for production use, because it
+drastically increases kernel memory footprint and slows the whole system down.
+
+Example report
+==============
+
+Here is an example of a KMSAN report::
+
+  =====================================================
+  BUG: KMSAN: uninit-value in test_uninit_kmsan_check_memory+0x1be/0x380 [kmsan_test]
+   test_uninit_kmsan_check_memory+0x1be/0x380 mm/kmsan/kmsan_test.c:273
+   kunit_run_case_internal lib/kunit/test.c:333
+   kunit_try_run_case+0x206/0x420 lib/kunit/test.c:374
+   kunit_generic_run_threadfn_adapter+0x6d/0xc0 lib/kunit/try-catch.c:28
+   kthread+0x721/0x850 kernel/kthread.c:327
+   ret_from_fork+0x1f/0x30 ??:?
+
+  Uninit was stored to memory at:
+   do_uninit_local_array+0xfa/0x110 mm/kmsan/kmsan_test.c:260
+   test_uninit_kmsan_check_memory+0x1a2/0x380 mm/kmsan/kmsan_test.c:271
+   kunit_run_case_internal lib/kunit/test.c:333
+   kunit_try_run_case+0x206/0x420 lib/kunit/test.c:374
+   kunit_generic_run_threadfn_adapter+0x6d/0xc0 lib/kunit/try-catch.c:28
+   kthread+0x721/0x850 kernel/kthread.c:327
+   ret_from_fork+0x1f/0x30 ??:?
+
+  Local variable uninit created at:
+   do_uninit_local_array+0x4a/0x110 mm/kmsan/kmsan_test.c:256
+   test_uninit_kmsan_check_memory+0x1a2/0x380 mm/kmsan/kmsan_test.c:271
+
+  Bytes 4-7 of 8 are uninitialized
+  Memory access of size 8 starts at ffff888083fe3da0
+
+  CPU: 0 PID: 6731 Comm: kunit_try_catch Tainted: G    B       E     5.16.0-rc3+ #104
+  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
+  =====================================================
+
+
+The report says that the local variable ``uninit`` was created uninitialized in
+``do_uninit_local_array()``. The lower stack trace corresponds to the place
+where this variable was created.
+
+The upper stack shows where the uninit value was used - in
+``test_uninit_kmsan_check_memory()``. The tool shows the bytes which were left
+uninitialized in the local variable, as well as the stack where the value was
+copied to another memory location before use.
+
+Please note that KMSAN only reports an error when an uninitialized value is
+actually used (e.g. in a condition or pointer dereference). A lot of
+uninitialized values in the kernel are never used, and reporting them would
+result in too many false positives.
+
+KMSAN and Clang
+===============
+
+In order for KMSAN to work the kernel must be built with Clang, which so far is
+the only compiler that has KMSAN support. The kernel instrumentation pass is
+based on the userspace `MemorySanitizer tool`_.
+
+How to build
+============
+
+In order to build a kernel with KMSAN you will need a fresh Clang (14.0.0+).
+Please refer to `LLVM documentation`_ for the instructions on how to build Clang.
+
+Now configure and build the kernel with CONFIG_KMSAN enabled.
+
+How KMSAN works
+===============
+
+KMSAN shadow memory
+-------------------
+
+KMSAN associates a metadata byte (also called shadow byte) with every byte of
+kernel memory. A bit in the shadow byte is set iff the corresponding bit of the
+kernel memory byte is uninitialized. Marking the memory uninitialized (i.e.
+setting its shadow bytes to ``0xff``) is called poisoning, marking it
+initialized (setting the shadow bytes to ``0x00``) is called unpoisoning.
+
+When a new variable is allocated on the stack, it is poisoned by default by
+instrumentation code inserted by the compiler (unless it is a stack variable
+that is immediately initialized). Any new heap allocation done without
+``__GFP_ZERO`` is also poisoned.
+
+Compiler instrumentation also tracks the shadow values with the help from the
+runtime library in ``mm/kmsan/``.
+
+The shadow value of a basic or compound type is an array of bytes of the same
+length. When a constant value is written into memory, that memory is unpoisoned.
+When a value is read from memory, its shadow memory is also obtained and
+propagated into all the operations which use that value. For every instruction
+that takes one or more values the compiler generates code that calculates the
+shadow of the result depending on those values and their shadows.
+
+Example::
+
+  int a = 0xff;  // i.e. 0x000000ff
+  int b;
+  int c = a | b;
+
+In this case the shadow of ``a`` is ``0``, shadow of ``b`` is ``0xffffffff``,
+shadow of ``c`` is ``0xffffff00``. This means that the upper three bytes of
+``c`` are uninitialized, while the lower byte is initialized.
+
+
+Origin tracking
+---------------
+
+Every four bytes of kernel memory also have a so-called origin assigned to
+them. This origin describes the point in program execution at which the
+uninitialized value was created. Every origin is associated with either the
+full allocation stack (for heap-allocated memory), or the function containing
+the uninitialized variable (for locals).
+
+When an uninitialized variable is allocated on stack or heap, a new origin
+value is created, and that variable's origin is filled with that value.
+When a value is read from memory, its origin is also read and kept together
+with the shadow. For every instruction that takes one or more values the origin
+of the result is one of the origins corresponding to any of the uninitialized
+inputs. If a poisoned value is written into memory, its origin is written to the
+corresponding storage as well.
+
+Example 1::
+
+  int a = 42;
+  int b;
+  int c = a + b;
+
+In this case the origin of ``b`` is generated upon function entry, and is
+stored to the origin of ``c`` right before the addition result is written into
+memory.
+
+Several variables may share the same origin address, if they are stored in the
+same four-byte chunk. In this case every write to either variable updates the
+origin for all of them. We have to sacrifice precision in this case, because
+storing origins for individual bits (and even bytes) would be too costly.
+
+Example 2::
+
+  int combine(short a, short b) {
+    union ret_t {
+      int i;
+      short s[2];
+    } ret;
+    ret.s[0] = a;
+    ret.s[1] = b;
+    return ret.i;
+  }
+
+If ``a`` is initialized and ``b`` is not, the shadow of the result would be
+0xffff0000, and the origin of the result would be the origin of ``b``.
+``ret.s[0]`` would have the same origin, but it will be never used, because
+that variable is initialized.
+
+If both function arguments are uninitialized, only the origin of the second
+argument is preserved.
+
+Origin chaining
+~~~~~~~~~~~~~~~
+
+To ease debugging, KMSAN creates a new origin for every store of an
+uninitialized value to memory. The new origin references both its creation stack
+and the previous origin the value had. This may cause increased memory
+consumption, so we limit the length of origin chains in the runtime.
+
+Clang instrumentation API
+-------------------------
+
+Clang instrumentation pass inserts calls to functions defined in
+``mm/kmsan/instrumentation.c`` into the kernel code.
+
+Shadow manipulation
+~~~~~~~~~~~~~~~~~~~
+
+For every memory access the compiler emits a call to a function that returns a
+pair of pointers to the shadow and origin addresses of the given memory::
+
+  typedef struct {
+    void *shadow, *origin;
+  } shadow_origin_ptr_t
+
+  shadow_origin_ptr_t __msan_metadata_ptr_for_load_{1,2,4,8}(void *addr)
+  shadow_origin_ptr_t __msan_metadata_ptr_for_store_{1,2,4,8}(void *addr)
+  shadow_origin_ptr_t __msan_metadata_ptr_for_load_n(void *addr, uintptr_t size)
+  shadow_origin_ptr_t __msan_metadata_ptr_for_store_n(void *addr, uintptr_t size)
+
+The function name depends on the memory access size.
+
+The compiler makes sure that for every loaded value its shadow and origin
+values are read from memory. When a value is stored to memory, its shadow and
+origin are also stored using the metadata pointers.
+
+Origin tracking
+~~~~~~~~~~~~~~~
+
+A special function is used to create a new origin value for a local variable and
+set the origin of that variable to that value::
+
+  void __msan_poison_alloca(void *addr, uintptr_t size, char *descr)
+
+Access to per-task data
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+At the beginning of every instrumented function KMSAN inserts a call to
+``__msan_get_context_state()``::
+
+  kmsan_context_state *__msan_get_context_state(void)
+
+``kmsan_context_state`` is declared in ``include/linux/kmsan.h``::
+
+  struct kmsan_context_state {
+    char param_tls[KMSAN_PARAM_SIZE];
+    char retval_tls[KMSAN_RETVAL_SIZE];
+    char va_arg_tls[KMSAN_PARAM_SIZE];
+    char va_arg_origin_tls[KMSAN_PARAM_SIZE];
+    u64 va_arg_overflow_size_tls;
+    char param_origin_tls[KMSAN_PARAM_SIZE];
+    depot_stack_handle_t retval_origin_tls;
+  };
+
+This structure is used by KMSAN to pass parameter shadows and origins between
+instrumented functions.
+
+String functions
+~~~~~~~~~~~~~~~~
+
+The compiler replaces calls to ``memcpy()``/``memmove()``/``memset()`` with the
+following functions. These functions are also called when data structures are
+initialized or copied, making sure shadow and origin values are copied alongside
+with the data::
+
+  void *__msan_memcpy(void *dst, void *src, uintptr_t n)
+  void *__msan_memmove(void *dst, void *src, uintptr_t n)
+  void *__msan_memset(void *dst, int c, uintptr_t n)
+
+Error reporting
+~~~~~~~~~~~~~~~
+
+For each pointer dereference and each condition the compiler emits a shadow
+check that calls ``__msan_warning()`` in the case a poisoned value is being
+used::
+
+  void __msan_warning(u32 origin)
+
+``__msan_warning()`` causes KMSAN runtime to print an error report.
+
+Inline assembly instrumentation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+KMSAN instruments every inline assembly output with a call to::
+
+  void __msan_instrument_asm_store(void *addr, uintptr_t size)
+
+, which unpoisons the memory region.
+
+This approach may mask certain errors, but it also helps to avoid a lot of
+false positives in bitwise operations, atomics etc.
+
+Sometimes the pointers passed into inline assembly do not point to valid memory.
+In such cases they are ignored at runtime.
+
+Disabling the instrumentation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+A function can be marked with ``__no_kmsan_checks``. Doing so makes KMSAN
+ignore uninitialized values in that function and mark its output as initialized.
+As a result, the user will not get KMSAN reports related to that function.
+
+Another function attribute supported by KMSAN is ``__no_sanitize_memory``.
+Applying this attribute to a function will result in KMSAN not instrumenting it,
+which can be helpful if we do not want the compiler to mess up some low-level
+code (e.g. that marked with ``noinstr``).
+
+This however comes at a cost: stack allocations from such functions will have
+incorrect shadow/origin values, likely leading to false positives. Functions
+called from non-instrumented code may also receive incorrect metadata for their
+parameters.
+
+As a rule of thumb, avoid using ``__no_sanitize_memory`` explicitly.
+
+It is also possible to disable KMSAN for a single file (e.g. main.o)::
+
+  KMSAN_SANITIZE_main.o := n
+
+or for the whole directory::
+
+  KMSAN_SANITIZE := n
+
+in the Makefile. Think of this as applying ``__no_sanitize_memory`` to every
+function in the file or directory. Most users won't need KMSAN_SANITIZE, unless
+their code gets broken by KMSAN (e.g. runs at early boot time).
+
+Runtime library
+---------------
+
+The code is located in ``mm/kmsan/``.
+
+Per-task KMSAN state
+~~~~~~~~~~~~~~~~~~~~
+
+Every task_struct has an associated KMSAN task state that holds the KMSAN
+context (see above) and a per-task flag disallowing KMSAN reports::
+
+  struct kmsan_context {
+    ...
+    bool allow_reporting;
+    struct kmsan_context_state cstate;
+    ...
+  }
+
+  struct task_struct {
+    ...
+    struct kmsan_context kmsan;
+    ...
+  }
+
+
+KMSAN contexts
+~~~~~~~~~~~~~~
+
+When running in a kernel task context, KMSAN uses ``current->kmsan.cstate`` to
+hold the metadata for function parameters and return values.
+
+But in the case the kernel is running in the interrupt, softirq or NMI context,
+where ``current`` is unavailable, KMSAN switches to per-cpu interrupt state::
+
+  DEFINE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
+
+Metadata allocation
+~~~~~~~~~~~~~~~~~~~
+
+There are several places in the kernel for which the metadata is stored.
+
+1. Each ``struct page`` instance contains two pointers to its shadow and
+origin pages::
+
+  struct page {
+    ...
+    struct page *shadow, *origin;
+    ...
+  };
+
+At boot-time, the kernel allocates shadow and origin pages for every available
+kernel page. This is done quite late, when the kernel address space is already
+fragmented, so normal data pages may arbitrarily interleave with the metadata
+pages.
+
+This means that in general for two contiguous memory pages their shadow/origin
+pages may not be contiguous. So, if a memory access crosses the boundary
+of a memory block, accesses to shadow/origin memory may potentially corrupt
+other pages or read incorrect values from them.
+
+In practice, contiguous memory pages returned by the same ``alloc_pages()``
+call will have contiguous metadata, whereas if these pages belong to two
+different allocations their metadata pages can be fragmented.
+
+For the kernel data (``.data``, ``.bss`` etc.) and percpu memory regions
+there also are no guarantees on metadata contiguity.
+
+In the case ``__msan_metadata_ptr_for_XXX_YYY()`` hits the border between two
+pages with non-contiguous metadata, it returns pointers to fake shadow/origin regions::
+
+  char dummy_load_page[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
+  char dummy_store_page[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
+
+``dummy_load_page`` is zero-initialized, so reads from it always yield zeroes.
+All stores to ``dummy_store_page`` are ignored.
+
+2. For vmalloc memory and modules, there is a direct mapping between the memory
+range, its shadow and origin. KMSAN reduces the vmalloc area by 3/4, making only
+the first quarter available to ``vmalloc()``. The second quarter of the vmalloc
+area contains shadow memory for the first quarter, the third one holds the
+origins. A small part of the fourth quarter contains shadow and origins for the
+kernel modules. Please refer to ``arch/x86/include/asm/pgtable_64_types.h`` for
+more details.
+
+When an array of pages is mapped into a contiguous virtual memory space, their
+shadow and origin pages are similarly mapped into contiguous regions.
+
+3. For CPU entry area there are separate per-CPU arrays that hold its
+metadata::
+
+  DEFINE_PER_CPU(char[CPU_ENTRY_AREA_SIZE], cpu_entry_area_shadow);
+  DEFINE_PER_CPU(char[CPU_ENTRY_AREA_SIZE], cpu_entry_area_origin);
+
+When calculating shadow and origin addresses for a given memory address, KMSAN
+checks whether the address belongs to the physical page range, the virtual page
+range or CPU entry area.
+
+Handling ``pt_regs``
+~~~~~~~~~~~~~~~~~~~~
+
+Many functions receive a ``struct pt_regs`` holding the register state at a
+certain point. Registers do not have (easily calculatable) shadow or origin
+associated with them, so we assume they are always initialized.
+
+References
+==========
+
+E. Stepanov, K. Serebryany. `MemorySanitizer: fast detector of uninitialized
+memory use in C++
+<https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/43308.pdf>`_.
+In Proceedings of CGO 2015.
+
+.. _MemorySanitizer tool: https://clang.llvm.org/docs/MemorySanitizer.html
+.. _LLVM documentation: https://llvm.org/docs/GettingStarted.html
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

