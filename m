Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7671556A216
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jul 2022 14:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiGGMfI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 08:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiGGMfH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 08:35:07 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDE824097
        for <linux-arch@vger.kernel.org>; Thu,  7 Jul 2022 05:35:03 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p129so2484981yba.7
        for <linux-arch@vger.kernel.org>; Thu, 07 Jul 2022 05:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qsjbGp6N76YoiYSProJ/COUIJjHNWME7B8sXsdbKrEc=;
        b=l1+wDBvQS2dGbaRa732kp5mr0+FONVerQq2q7T75A9PWhP7NpGmEG+8uksryCHltvL
         5Co8wuh2X+SfMO/KVpdkkEvLdGAQYXzaImxDGoDO7dCVtYmuHx4U5Ble9yY9Q1rLfU+r
         qpuZZi6P0KZ7FEXjvq4L2foivoC0WQVJxMJfC0T9butXn8e3NJUuwhv5gznBRZooLhrH
         OkwtcdgACKmDE9ZO7jgBWtllOAcQY7oBSjgZpJHlPPrE1jSnfdl5yGf5nOO6bvJFojAs
         uaHCfQL9ILHPTS1PASM44QmsZexOJF6pC21bim2AyTOGuRRYh+/w5gE1OWVh8I+UcGaj
         glIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qsjbGp6N76YoiYSProJ/COUIJjHNWME7B8sXsdbKrEc=;
        b=IqLJu8OkBft+PqvbjwC727OQrKkENl+x/d8YG89qN+T6rMaKQQMj9viPSw0DYz/4Pp
         0f5RBF23/c3LXN8XEt/D89LBP2ZGi0HOnYKQiS420ZnJw/3Vi6J+sRwK+hQgOedTWdrP
         yIaC1XLTQCNmAtfC4qDsFzbuziB0II5kZ3WXifKquTVWkz1/0edd82msrKEvrJUAD1U7
         Xv9vM20YRfHRgcyAYl3kwER3qxzHyVXzaIBXuk+fk57U+y+FqUSaWEUrtQKFQh/1BVWe
         L58SLA07T/dKpaeBtG/yztad7REwy+jd6iyavf6icnIF3OiNuBb/ElkkbAbYVZzLki6f
         qENg==
X-Gm-Message-State: AJIora8kNQvsOzgZOsNDR9ADyrOIjZoT8qDUIK6OV+M3ywXufJmsNyVC
        UWCCtICMS4iyCvvIvOlAyYoEuYZGrlHl6ZjxgOSQJA==
X-Google-Smtp-Source: AGRyM1sCTQb3JlYHxNJAkwAhTIByIyJLVfwWlQsn15n4iGyzG2AcsQOiogjvNY/D2n2hxO/OR7S359oDFgQm8b+c3Jk=
X-Received: by 2002:a25:abc5:0:b0:66e:3983:3ca7 with SMTP id
 v63-20020a25abc5000000b0066e39833ca7mr25654868ybi.168.1657197302330; Thu, 07
 Jul 2022 05:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-7-glider@google.com>
In-Reply-To: <20220701142310.2188015-7-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 7 Jul 2022 14:34:26 +0200
Message-ID: <CANpmjNN=XO=6rpV-KS2xq=3fiV1L3wCL1DFwLes-CJsi=6ZmcQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/45] kmsan: add ReST documentation
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
>
> Add Documentation/dev-tools/kmsan.rst and reference it in the dev-tools
> index.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> v2:
>  -- added a note that KMSAN is not intended for production use
>
> v4:
>  -- describe CONFIG_KMSAN_CHECK_PARAM_RETVAL
>  -- drop mentions of cpu_entry_area
>  -- add SPDX license
>
> Link: https://linux-review.googlesource.com/id/I751586f79418b95550a83c6035c650b5b01567cc
> ---
>  Documentation/dev-tools/index.rst |   1 +
>  Documentation/dev-tools/kmsan.rst | 422 ++++++++++++++++++++++++++++++
>  2 files changed, 423 insertions(+)
>  create mode 100644 Documentation/dev-tools/kmsan.rst
>
> diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
> index 4621eac290f46..6b0663075dc04 100644
> --- a/Documentation/dev-tools/index.rst
> +++ b/Documentation/dev-tools/index.rst
> @@ -24,6 +24,7 @@ Documentation/dev-tools/testing-overview.rst
>     kcov
>     gcov
>     kasan
> +   kmsan
>     ubsan
>     kmemleak
>     kcsan
> diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tools/kmsan.rst
> new file mode 100644
> index 0000000000000..3fa5d7fb222c9
> --- /dev/null
> +++ b/Documentation/dev-tools/kmsan.rst
> @@ -0,0 +1,422 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright (C) 2022, Google LLC.
> +
> +=============================
> +KernelMemorySanitizer (KMSAN)
> +=============================

To be consistent with other tools, I think we have settled on "The
Kernel <...> Sanitizer (K?SAN)", see
Documentation/dev-tools/k[ac]san.rst. So this will be "The Kernel
Memory Sanitizer (KMSAN)".

> +KMSAN is a dynamic error detector aimed at finding uses of uninitialized
> +values. It is based on compiler instrumentation, and is quite similar to the
> +userspace `MemorySanitizer tool`_.
> +
> +An important note is that KMSAN is not intended for production use, because it
> +drastically increases kernel memory footprint and slows the whole system down.
> +
> +Example report
> +==============
> +
> +Here is an example of a KMSAN report::
> +
> +  =====================================================
> +  BUG: KMSAN: uninit-value in test_uninit_kmsan_check_memory+0x1be/0x380 [kmsan_test]
> +   test_uninit_kmsan_check_memory+0x1be/0x380 mm/kmsan/kmsan_test.c:273
> +   kunit_run_case_internal lib/kunit/test.c:333
> +   kunit_try_run_case+0x206/0x420 lib/kunit/test.c:374
> +   kunit_generic_run_threadfn_adapter+0x6d/0xc0 lib/kunit/try-catch.c:28
> +   kthread+0x721/0x850 kernel/kthread.c:327
> +   ret_from_fork+0x1f/0x30 ??:?
> +
> +  Uninit was stored to memory at:
> +   do_uninit_local_array+0xfa/0x110 mm/kmsan/kmsan_test.c:260
> +   test_uninit_kmsan_check_memory+0x1a2/0x380 mm/kmsan/kmsan_test.c:271
> +   kunit_run_case_internal lib/kunit/test.c:333
> +   kunit_try_run_case+0x206/0x420 lib/kunit/test.c:374
> +   kunit_generic_run_threadfn_adapter+0x6d/0xc0 lib/kunit/try-catch.c:28
> +   kthread+0x721/0x850 kernel/kthread.c:327
> +   ret_from_fork+0x1f/0x30 ??:?
> +
> +  Local variable uninit created at:
> +   do_uninit_local_array+0x4a/0x110 mm/kmsan/kmsan_test.c:256
> +   test_uninit_kmsan_check_memory+0x1a2/0x380 mm/kmsan/kmsan_test.c:271
> +
> +  Bytes 4-7 of 8 are uninitialized
> +  Memory access of size 8 starts at ffff888083fe3da0
> +
> +  CPU: 0 PID: 6731 Comm: kunit_try_catch Tainted: G    B       E     5.16.0-rc3+ #104
> +  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> +  =====================================================
> +
> +
> +The report says that the local variable ``uninit`` was created uninitialized in
> +``do_uninit_local_array()``. The lower stack trace corresponds to the place

-> "The third stack trace ..."
(Because it looks like there's also another stack trace in the middle
and "lower" is ambiguous)

> +where this variable was created.
> +
> +The upper stack shows where the uninit value was used - in

-> "The first stack trace shows where the uninit value was used (in
``test_uninit_kmsan_check_memory()``)."

> +``test_uninit_kmsan_check_memory()``. The tool shows the bytes which were left
> +uninitialized in the local variable, as well as the stack where the value was
> +copied to another memory location before use.
> +
> +A use of uninitialized value ``v`` is reported by KMSAN in the following cases:
> + - in a condition, e.g. ``if (v) { ... }``;
> + - in an indexing or pointer dereferencing, e.g. ``array[v]`` or ``*v``;
> + - when it is copied to userspace or hardware, e.g. ``copy_to_user(..., &v, ...)``;
> + - when it is passed as an argument to a function, and
> +   ``CONFIG_KMSAN_CHECK_PARAM_RETVAL`` is enabled (see below).
> +
> +The mentioned cases (apart from copying data to userspace or hardware, which is
> +a security issue) are considered undefined behavior from the C11 Standard point
> +of view.
> +
> +KMSAN and Clang
> +===============

The KASAN documentation has a section on "Support" which lists
architectures and compilers supported. I'd try to mirror (or improve
on) that.

> +In order for KMSAN to work the kernel must be built with Clang, which so far is
> +the only compiler that has KMSAN support. The kernel instrumentation pass is
> +based on the userspace `MemorySanitizer tool`_.
> +
> +How to build
> +============

I'd call it "Usage", like in the KASAN and KCSAN documentation.

> +In order to build a kernel with KMSAN you will need a fresh Clang (14.0.0+).
> +Please refer to `LLVM documentation`_ for the instructions on how to build Clang.
> +
> +Now configure and build the kernel with CONFIG_KMSAN enabled.

I would move build/usage instructions right after introduction as
that's most likely what users of KMSAN will want to know about first.

> +How KMSAN works
> +===============
> +
> +KMSAN shadow memory
> +-------------------
> +
> +KMSAN associates a metadata byte (also called shadow byte) with every byte of
> +kernel memory. A bit in the shadow byte is set iff the corresponding bit of the
> +kernel memory byte is uninitialized. Marking the memory uninitialized (i.e.
> +setting its shadow bytes to ``0xff``) is called poisoning, marking it
> +initialized (setting the shadow bytes to ``0x00``) is called unpoisoning.
> +
> +When a new variable is allocated on the stack, it is poisoned by default by
> +instrumentation code inserted by the compiler (unless it is a stack variable
> +that is immediately initialized). Any new heap allocation done without
> +``__GFP_ZERO`` is also poisoned.
> +
> +Compiler instrumentation also tracks the shadow values with the help from the
> +runtime library in ``mm/kmsan/``.

This sentence might still be confusing. I think it should highlight
that runtime and compiler go together, but depending on the scope of
the value, the compiler invokes the runtime to persist the shadow.

> +The shadow value of a basic or compound type is an array of bytes of the same
> +length. When a constant value is written into memory, that memory is unpoisoned.
> +When a value is read from memory, its shadow memory is also obtained and
> +propagated into all the operations which use that value. For every instruction
> +that takes one or more values the compiler generates code that calculates the
> +shadow of the result depending on those values and their shadows.
> +
> +Example::
> +
> +  int a = 0xff;  // i.e. 0x000000ff
> +  int b;
> +  int c = a | b;
> +
> +In this case the shadow of ``a`` is ``0``, shadow of ``b`` is ``0xffffffff``,
> +shadow of ``c`` is ``0xffffff00``. This means that the upper three bytes of
> +``c`` are uninitialized, while the lower byte is initialized.
> +
> +

There are 2 blank lines here, which is inconsistent with the rest of
the document.

> +Origin tracking
> +---------------
> +
> +Every four bytes of kernel memory also have a so-called origin assigned to

Is "assigned" or "mapped" more appropriate here?

> +them. This origin describes the point in program execution at which the
> +uninitialized value was created. Every origin is associated with either the
> +full allocation stack (for heap-allocated memory), or the function containing
> +the uninitialized variable (for locals).
> +
> +When an uninitialized variable is allocated on stack or heap, a new origin
> +value is created, and that variable's origin is filled with that value.
> +When a value is read from memory, its origin is also read and kept together
> +with the shadow. For every instruction that takes one or more values the origin

s/values the origin/values, the origin/

> +of the result is one of the origins corresponding to any of the uninitialized
> +inputs. If a poisoned value is written into memory, its origin is written to the
> +corresponding storage as well.
> +
> +Example 1::
> +
> +  int a = 42;
> +  int b;
> +  int c = a + b;
> +
> +In this case the origin of ``b`` is generated upon function entry, and is
> +stored to the origin of ``c`` right before the addition result is written into
> +memory.
> +
> +Several variables may share the same origin address, if they are stored in the
> +same four-byte chunk. In this case every write to either variable updates the
> +origin for all of them. We have to sacrifice precision in this case, because
> +storing origins for individual bits (and even bytes) would be too costly.
> +
> +Example 2::
> +
> +  int combine(short a, short b) {
> +    union ret_t {
> +      int i;
> +      short s[2];
> +    } ret;
> +    ret.s[0] = a;
> +    ret.s[1] = b;
> +    return ret.i;
> +  }
> +
> +If ``a`` is initialized and ``b`` is not, the shadow of the result would be
> +0xffff0000, and the origin of the result would be the origin of ``b``.
> +``ret.s[0]`` would have the same origin, but it will be never used, because

s/be never/never be/

> +that variable is initialized.
> +
> +If both function arguments are uninitialized, only the origin of the second
> +argument is preserved.
> +
> +Origin chaining
> +~~~~~~~~~~~~~~~
> +
> +To ease debugging, KMSAN creates a new origin for every store of an
> +uninitialized value to memory. The new origin references both its creation stack
> +and the previous origin the value had. This may cause increased memory
> +consumption, so we limit the length of origin chains in the runtime.
> +
> +Clang instrumentation API
> +-------------------------
> +
> +Clang instrumentation pass inserts calls to functions defined in
> +``mm/kmsan/instrumentation.c`` into the kernel code.
> +
> +Shadow manipulation
> +~~~~~~~~~~~~~~~~~~~
> +
> +For every memory access the compiler emits a call to a function that returns a
> +pair of pointers to the shadow and origin addresses of the given memory::
> +
> +  typedef struct {
> +    void *shadow, *origin;
> +  } shadow_origin_ptr_t
> +
> +  shadow_origin_ptr_t __msan_metadata_ptr_for_load_{1,2,4,8}(void *addr)
> +  shadow_origin_ptr_t __msan_metadata_ptr_for_store_{1,2,4,8}(void *addr)
> +  shadow_origin_ptr_t __msan_metadata_ptr_for_load_n(void *addr, uintptr_t size)
> +  shadow_origin_ptr_t __msan_metadata_ptr_for_store_n(void *addr, uintptr_t size)
> +
> +The function name depends on the memory access size.
> +
> +The compiler makes sure that for every loaded value its shadow and origin
> +values are read from memory. When a value is stored to memory, its shadow and
> +origin are also stored using the metadata pointers.
> +
> +Handling locals
> +~~~~~~~~~~~~~~~
> +
> +A special function is used to create a new origin value for a local variable and
> +set the origin of that variable to that value::
> +
> +  void __msan_poison_alloca(void *addr, uintptr_t size, char *descr)
> +
> +Access to per-task data
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +At the beginning of every instrumented function KMSAN inserts a call to
> +``__msan_get_context_state()``::
> +
> +  kmsan_context_state *__msan_get_context_state(void)
> +
> +``kmsan_context_state`` is declared in ``include/linux/kmsan.h``::
> +
> +  struct kmsan_context_state {
> +    char param_tls[KMSAN_PARAM_SIZE];
> +    char retval_tls[KMSAN_RETVAL_SIZE];
> +    char va_arg_tls[KMSAN_PARAM_SIZE];
> +    char va_arg_origin_tls[KMSAN_PARAM_SIZE];
> +    u64 va_arg_overflow_size_tls;
> +    char param_origin_tls[KMSAN_PARAM_SIZE];
> +    depot_stack_handle_t retval_origin_tls;
> +  };
> +
> +This structure is used by KMSAN to pass parameter shadows and origins between
> +instrumented functions (unless the parameters are checked immediately by
> +``CONFIG_KMSAN_CHECK_PARAM_RETVAL``).
> +
> +Passing uninitialized values to functions
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +KMSAN instrumentation pass has an option, ``-fsanitize-memory-param-retval``,

"KMSAN instrumentation pass" -> "Clang's instrumentation support" ?
Because it seems wrong to say that KMSAN has the instrumentation pass.

> +which makes the compiler check function parameters passed by value, as well as
> +function return values.
> +
> +The option is controlled by ``CONFIG_KMSAN_CHECK_PARAM_RETVAL``, which is
> +enabled by default to let KMSAN report uninitialized values earlier.
> +Please refer to the `LKML discussion`_ for more details.
> +
> +Because of the way the checks are implemented in LLVM (they are only applied to
> +parameters marked as ``noundef``), not all parameters are guaranteed to be
> +checked, so we cannot give up the metadata storage in ``kmsan_context_state``.
> +
> +String functions
> +~~~~~~~~~~~~~~~~
> +
> +The compiler replaces calls to ``memcpy()``/``memmove()``/``memset()`` with the
> +following functions. These functions are also called when data structures are
> +initialized or copied, making sure shadow and origin values are copied alongside
> +with the data::
> +
> +  void *__msan_memcpy(void *dst, void *src, uintptr_t n)
> +  void *__msan_memmove(void *dst, void *src, uintptr_t n)
> +  void *__msan_memset(void *dst, int c, uintptr_t n)
> +
> +Error reporting
> +~~~~~~~~~~~~~~~
> +
> +For each use of a value the compiler emits a shadow check that calls
> +``__msan_warning()`` in the case that value is poisoned::
> +
> +  void __msan_warning(u32 origin)
> +
> +``__msan_warning()`` causes KMSAN runtime to print an error report.
> +
> +Inline assembly instrumentation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +KMSAN instruments every inline assembly output with a call to::
> +
> +  void __msan_instrument_asm_store(void *addr, uintptr_t size)
> +
> +, which unpoisons the memory region.
> +
> +This approach may mask certain errors, but it also helps to avoid a lot of
> +false positives in bitwise operations, atomics etc.
> +
> +Sometimes the pointers passed into inline assembly do not point to valid memory.
> +In such cases they are ignored at runtime.
> +
> +Disabling the instrumentation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It would be useful to move this section somewhere to the beginning,
closer to usage and the example, as this is information that a user of
KMSAN might want to know (but they might not want to know much about
how KMSAN works).

> +A function can be marked with ``__no_kmsan_checks``. Doing so makes KMSAN
> +ignore uninitialized values in that function and mark its output as initialized.
> +As a result, the user will not get KMSAN reports related to that function.
> +
> +Another function attribute supported by KMSAN is ``__no_sanitize_memory``.
> +Applying this attribute to a function will result in KMSAN not instrumenting it,
> +which can be helpful if we do not want the compiler to mess up some low-level

s/mess up/interfere with/

> +code (e.g. that marked with ``noinstr``).

maybe "... (e.g. that marked with ``noinstr``, which implicitly adds
``__no_sanitize_memory``)."

otherwise people might think that it's necessary to add
__no_sanitize_memory explicitly to noinstr.

> +
> +This however comes at a cost: stack allocations from such functions will have
> +incorrect shadow/origin values, likely leading to false positives. Functions
> +called from non-instrumented code may also receive incorrect metadata for their
> +parameters.
> +
> +As a rule of thumb, avoid using ``__no_sanitize_memory`` explicitly.
> +
> +It is also possible to disable KMSAN for a single file (e.g. main.o)::
> +
> +  KMSAN_SANITIZE_main.o := n
> +
> +or for the whole directory::
> +
> +  KMSAN_SANITIZE := n
> +
> +in the Makefile. Think of this as applying ``__no_sanitize_memory`` to every
> +function in the file or directory. Most users won't need KMSAN_SANITIZE, unless
> +their code gets broken by KMSAN (e.g. runs at early boot time).
> +
> +Runtime library
> +---------------
> +
> +The code is located in ``mm/kmsan/``.
> +
> +Per-task KMSAN state
> +~~~~~~~~~~~~~~~~~~~~
> +
> +Every task_struct has an associated KMSAN task state that holds the KMSAN
> +context (see above) and a per-task flag disallowing KMSAN reports::
> +
> +  struct kmsan_context {
> +    ...
> +    bool allow_reporting;
> +    struct kmsan_context_state cstate;
> +    ...
> +  }
> +
> +  struct task_struct {
> +    ...
> +    struct kmsan_context kmsan;
> +    ...
> +  }
> +
> +

1 blank line instead of 2?

> +KMSAN contexts
> +~~~~~~~~~~~~~~
> +
> +When running in a kernel task context, KMSAN uses ``current->kmsan.cstate`` to
> +hold the metadata for function parameters and return values.
> +
> +But in the case the kernel is running in the interrupt, softirq or NMI context,
> +where ``current`` is unavailable, KMSAN switches to per-cpu interrupt state::
> +
> +  DEFINE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
> +
> +Metadata allocation
> +~~~~~~~~~~~~~~~~~~~
> +
> +There are several places in the kernel for which the metadata is stored.
> +
> +1. Each ``struct page`` instance contains two pointers to its shadow and
> +origin pages::
> +
> +  struct page {
> +    ...
> +    struct page *shadow, *origin;
> +    ...
> +  };
> +
> +At boot-time, the kernel allocates shadow and origin pages for every available
> +kernel page. This is done quite late, when the kernel address space is already
> +fragmented, so normal data pages may arbitrarily interleave with the metadata
> +pages.
> +
> +This means that in general for two contiguous memory pages their shadow/origin
> +pages may not be contiguous. So, if a memory access crosses the boundary

s/So, /Consequently, /

> +of a memory block, accesses to shadow/origin memory may potentially corrupt
> +other pages or read incorrect values from them.
> +
> +In practice, contiguous memory pages returned by the same ``alloc_pages()``
> +call will have contiguous metadata, whereas if these pages belong to two
> +different allocations their metadata pages can be fragmented.
> +
> +For the kernel data (``.data``, ``.bss`` etc.) and percpu memory regions
> +there also are no guarantees on metadata contiguity.
> +
> +In the case ``__msan_metadata_ptr_for_XXX_YYY()`` hits the border between two
> +pages with non-contiguous metadata, it returns pointers to fake shadow/origin regions::
> +
> +  char dummy_load_page[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
> +  char dummy_store_page[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
> +
> +``dummy_load_page`` is zero-initialized, so reads from it always yield zeroes.
> +All stores to ``dummy_store_page`` are ignored.
> +
> +2. For vmalloc memory and modules, there is a direct mapping between the memory
> +range, its shadow and origin. KMSAN reduces the vmalloc area by 3/4, making only
> +the first quarter available to ``vmalloc()``. The second quarter of the vmalloc
> +area contains shadow memory for the first quarter, the third one holds the
> +origins. A small part of the fourth quarter contains shadow and origins for the
> +kernel modules. Please refer to ``arch/x86/include/asm/pgtable_64_types.h`` for
> +more details.
> +
> +When an array of pages is mapped into a contiguous virtual memory space, their
> +shadow and origin pages are similarly mapped into contiguous regions.
> +
> +References
> +==========
> +
> +E. Stepanov, K. Serebryany. `MemorySanitizer: fast detector of uninitialized
> +memory use in C++
> +<https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/43308.pdf>`_.
> +In Proceedings of CGO 2015.
> +
> +.. _MemorySanitizer tool: https://clang.llvm.org/docs/MemorySanitizer.html
> +.. _LLVM documentation: https://llvm.org/docs/GettingStarted.html
> +.. _LKML discussion: https://lore.kernel.org/all/20220614144853.3693273-1-glider@google.com/
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
