Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7941E575C8D
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jul 2022 09:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiGOHnQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jul 2022 03:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiGOHnP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jul 2022 03:43:15 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA067C1A3
        for <linux-arch@vger.kernel.org>; Fri, 15 Jul 2022 00:43:14 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l11so7130990ybu.13
        for <linux-arch@vger.kernel.org>; Fri, 15 Jul 2022 00:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wow5GwZUq1ephtzdcsWQKNRsHibDh8Of4LJkNVIGZKs=;
        b=Ke0eisTSZGPbvx05SZjplrvc8C0ps+HhylKVr+trNqEhKwHq+FokvjgLJvRoKLkAuH
         RD2HYioVCFb24lhQ3XcFHhusrC5pH5T7Qj0KZP8v8x1rprcWNS0c6WzBy+Nf5rTMGtpK
         TeL6rUbgbp52mBHpAZsxK+zJro+L7RGvte7pTNctGhTQTJBr2NlJmL9/FkHsRcKAvXEB
         tFNAHIKrBq7jWQqcdb9SJ6Qh9qsshjr5Smwo0Y8fNPp+StwDYbSlwGv0kGslv2fgJ9C9
         cVt4zngbnfJ9x8wrWx+K0j5AmmPw8IFf/FPHi6jmlGRf0y62N9BNz5KNjSMBeQtKXvLw
         fJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wow5GwZUq1ephtzdcsWQKNRsHibDh8Of4LJkNVIGZKs=;
        b=NOKEO7DwuEb32+npZaWMElVNWOLjt93dINjVCADJ8QU7YJ5ab46PX5mW1XKOSfoJJu
         usO7+Ra1zSO25PaOTvh8MdV8xYfSozcBbIiCIMWjHFvnnVS53WHFwlNlRjuTuXHUi//x
         HGFywlNtfDjjAAZsgGL5QPZ+Xc0Vnc7g94L8uVYmXA31P0G+uS93aDw/AGLzlBgCvo22
         IB+U415K8zc4t8knU56xHQ8KkX8XmeAizR4ajbPW2idG+U9vLaTzP+WfDj+ykrxClUUC
         CYGrPQcHec2Hi9aOCtAZWttS2N3gS0iEUsqRafA1400+tVsKOVXsdx3hgADPfpV7WxYQ
         Rphw==
X-Gm-Message-State: AJIora8teMVwTpEdhs1EQmtS/NmrLnB0igq5gMLoZ49oWRLlyBj8Im+9
        BwS6FC+VFoiGHeS5by+fqLujpENiOhy4HeQOs1+H6w==
X-Google-Smtp-Source: AGRyM1tscrvzEdkwMdJTGf/7hU0rpmIPG1IpGhQ3bkblbX9MB1wpw8oOOH54vUDQHR0mEaBRLxiUvqdvy/KJh//vzBU=
X-Received: by 2002:a25:d78c:0:b0:66f:5acb:d3bf with SMTP id
 o134-20020a25d78c000000b0066f5acbd3bfmr12396195ybg.307.1657870993486; Fri, 15
 Jul 2022 00:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-7-glider@google.com>
 <CANpmjNN=XO=6rpV-KS2xq=3fiV1L3wCL1DFwLes-CJsi=6ZmcQ@mail.gmail.com>
In-Reply-To: <CANpmjNN=XO=6rpV-KS2xq=3fiV1L3wCL1DFwLes-CJsi=6ZmcQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Jul 2022 09:42:37 +0200
Message-ID: <CAG_fn=X5w5F1rwHuQqQ9GRYT4MiNGQLh71FRN16Wy3rGJLX_AA@mail.gmail.com>
Subject: Re: [PATCH v4 06/45] kmsan: add ReST documentation
To:     Marco Elver <elver@google.com>
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
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> To be consistent with other tools, I think we have settled on "The
> Kernel <...> Sanitizer (K?SAN)", see
> Documentation/dev-tools/k[ac]san.rst. So this will be "The Kernel
> Memory Sanitizer (KMSAN)".

Done (will appear in v5).


> -> "The third stack trace ..."
> (Because it looks like there's also another stack trace in the middle
> and "lower" is ambiguous)

Done

>
> > +where this variable was created.
> > +
> > +The upper stack shows where the uninit value was used - in
>
> -> "The first stack trace shows where the uninit value was used (in
> ``test_uninit_kmsan_check_memory()``)."
Done

> > +KMSAN and Clang
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The KASAN documentation has a section on "Support" which lists
> architectures and compilers supported. I'd try to mirror (or improve
> on) that.

Renamed this section to "Support", added a line about supported
architectures (x86_64)

>
> > +In order for KMSAN to work the kernel must be built with Clang, which =
so far is
> > +the only compiler that has KMSAN support. The kernel instrumentation p=
ass is
> > +based on the userspace `MemorySanitizer tool`_.
> > +
> > +How to build
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I'd call it "Usage", like in the KASAN and KCSAN documentation.
Done

>
> > +In order to build a kernel with KMSAN you will need a fresh Clang (14.=
0.0+).
> > +Please refer to `LLVM documentation`_ for the instructions on how to b=
uild Clang.
> > +
> > +Now configure and build the kernel with CONFIG_KMSAN enabled.
>
> I would move build/usage instructions right after introduction as
> that's most likely what users of KMSAN will want to know about first.

Done

> > +How KMSAN works
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +KMSAN shadow memory
> > +-------------------
> > +
> > +KMSAN associates a metadata byte (also called shadow byte) with every =
byte of
> > +kernel memory. A bit in the shadow byte is set iff the corresponding b=
it of the
> > +kernel memory byte is uninitialized. Marking the memory uninitialized =
(i.e.
> > +setting its shadow bytes to ``0xff``) is called poisoning, marking it
> > +initialized (setting the shadow bytes to ``0x00``) is called unpoisoni=
ng.
> > +
> > +When a new variable is allocated on the stack, it is poisoned by defau=
lt by
> > +instrumentation code inserted by the compiler (unless it is a stack va=
riable
> > +that is immediately initialized). Any new heap allocation done without
> > +``__GFP_ZERO`` is also poisoned.
> > +
> > +Compiler instrumentation also tracks the shadow values with the help f=
rom the
> > +runtime library in ``mm/kmsan/``.
>
> This sentence might still be confusing. I think it should highlight
> that runtime and compiler go together, but depending on the scope of
> the value, the compiler invokes the runtime to persist the shadow.

Changed to:
"""
Compiler instrumentation also tracks the shadow values as they are used alo=
ng
the code. When needed, instrumentation code invokes the runtime library in
``mm/kmsan/`` to persist shadow values.
"""

> > +
> > +
>
> There are 2 blank lines here, which is inconsistent with the rest of
> the document.

Fixed

> > +Origin tracking
> > +---------------
> > +
> > +Every four bytes of kernel memory also have a so-called origin assigne=
d to
>
> Is "assigned" or "mapped" more appropriate here?

I think initially this was more about origin values that exist in SSA
as well as memory, so not all of them were "mapped".
On the other hand, we're talking about bytes in the memory, so "mapped" is =
fine.

> > +them. This origin describes the point in program execution at which th=
e
> > +uninitialized value was created. Every origin is associated with eithe=
r the
> > +full allocation stack (for heap-allocated memory), or the function con=
taining
> > +the uninitialized variable (for locals).
> > +
> > +When an uninitialized variable is allocated on stack or heap, a new or=
igin
> > +value is created, and that variable's origin is filled with that value=
.
> > +When a value is read from memory, its origin is also read and kept tog=
ether
> > +with the shadow. For every instruction that takes one or more values t=
he origin
>
> s/values the origin/values, the origin/
Done, thanks!


> > +
> > +If ``a`` is initialized and ``b`` is not, the shadow of the result wou=
ld be
> > +0xffff0000, and the origin of the result would be the origin of ``b``.
> > +``ret.s[0]`` would have the same origin, but it will be never used, be=
cause
>
> s/be never/never be/
Done

> > +Passing uninitialized values to functions
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +KMSAN instrumentation pass has an option, ``-fsanitize-memory-param-re=
tval``,
>
> "KMSAN instrumentation pass" -> "Clang's instrumentation support" ?
> Because it seems wrong to say that KMSAN has the instrumentation pass.
How about "Clang's MSan instrumentation pass"?

> > +
> > +Sometimes the pointers passed into inline assembly do not point to val=
id memory.
> > +In such cases they are ignored at runtime.
> > +
> > +Disabling the instrumentation
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> It would be useful to move this section somewhere to the beginning,
> closer to usage and the example, as this is information that a user of
> KMSAN might want to know (but they might not want to know much about
> how KMSAN works).

I restructured the TOC as follows:

=3D=3D The Kernel Memory Sanitizer (KMSAN)
=3D=3D Usage
--- Building the kernel
--- Example report
--- Disabling the instrumentation
=3D=3D Support
=3D=3D How KMSAN works
--- KMSAN shadow memory
--- Origin tracking
~~~~ Origin chaining
--- Clang instrumentation API
~~~~ Shadow manipulation
~~~~ Handling locals
~~~~ Access to per-task data
~~~~ Passing uninitialized values to functions
~~~~ String functions
~~~~ Error reporting
~~~~ Inline assembly instrumentation
--- Runtime library
~~~~ Per-task KMSAN state
~~~~ KMSAN contexts
~~~~ Metadata allocation
=3D=3D References


> > +Another function attribute supported by KMSAN is ``__no_sanitize_memor=
y``.
> > +Applying this attribute to a function will result in KMSAN not instrum=
enting it,
> > +which can be helpful if we do not want the compiler to mess up some lo=
w-level
>
> s/mess up/interfere with/
Done

> > +code (e.g. that marked with ``noinstr``).
>
> maybe "... (e.g. that marked with ``noinstr``, which implicitly adds
> ``__no_sanitize_memory``)."

Done

> otherwise people might think that it's necessary to add
> __no_sanitize_memory explicitly to noinstr.

Good point!

> > +    ...
> > +    struct kmsan_context kmsan;
> > +    ...
> > +  }
> > +
> > +
>
> 1 blank line instead of 2?
Done

> > +This means that in general for two contiguous memory pages their shado=
w/origin
> > +pages may not be contiguous. So, if a memory access crosses the bounda=
ry
>
> s/So, /Consequently, /
Done


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
