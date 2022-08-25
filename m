Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6015A16BC
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 18:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbiHYQdt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 12:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiHYQds (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 12:33:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7915CB8A43
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 09:33:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r4so26810264edi.8
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4kxSioqpPleGpZIZkkWOJIrDSHemVIWhFh1D4qTNMMk=;
        b=NQdfXYryhBWr+N3PJU06t0oQ4lc7CgVyo3TcFiyRIk4CHatVXVTSn10rQYt/VJlpXo
         LGThVX0JBX37Gketuzyx64A18LV9xMpey8uidDsTEiKkgCxa9zRszgiZgCMlPF80koQr
         EwVPdmre7iSz8fqkh6ENGdiOp2RDRJzDuAgj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4kxSioqpPleGpZIZkkWOJIrDSHemVIWhFh1D4qTNMMk=;
        b=v95GRSg5qB98/+9b+z045O5B8Bgrv7W7ErI5RM4uZEaBiyGtN5ULKNrfkVh7SpmW4W
         hF+3JvcdOBNf5EIcDF3oYVCzScGRPo2nhl4ljbXXrPXR9JgVsPptGp5HZDb5CPcVF5pg
         e51EwRDtQm/tiTk1+fmLYyGE+OLA9m78/c5PSMnUDYCZVtnCetqawl8nVh90AMlUBwjE
         qKYIiRHxadW2Zcn6zLmem/YKMBE4jt6Iy1imMka3RFbsmARIMU3Jjw3bReyzp6RIoHny
         1Tw4X6Zp0k36mXVSaSgvgkM59ZIr+Xy1N5bHi+yjuN5zm0Uel6NyC7TIam/6f7EbORSX
         HHRg==
X-Gm-Message-State: ACgBeo36GN5iLE5LX/WVf+8laKg8Gv5M+r2j0z+qkntbsx5+BUy+E5rn
        P7qVX5R3pPwjdwx64nCFAxkS1/jCOPsb8GD5lII=
X-Google-Smtp-Source: AA6agR6Z80UdBmLmcC4ElgZRpiRotQLrorha1qr5ZnZ/FxoNcLtkQjXF4nihRLe31/PVQ1xCvEACJQ==
X-Received: by 2002:a05:6402:2744:b0:446:ab07:eb52 with SMTP id z4-20020a056402274400b00446ab07eb52mr3733919edd.83.1661445225707;
        Thu, 25 Aug 2022 09:33:45 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id c6-20020aa7d606000000b004478be33bddsm2653535edr.15.2022.08.25.09.33.45
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 09:33:45 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id h22so30363813ejk.4
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 09:33:45 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr2662375wri.442.1661445214833; Thu, 25
 Aug 2022 09:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-45-glider@google.com>
 <YsNIjwTw41y0Ij0n@casper.infradead.org> <CAG_fn=VbvbYVPfdKXrYRTq7HwmvXPQUeUDWZjwe8x8W=ttq6KA@mail.gmail.com>
In-Reply-To: <CAG_fn=VbvbYVPfdKXrYRTq7HwmvXPQUeUDWZjwe8x8W=ttq6KA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Aug 2022 09:33:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-LXL4ZDMveCf9M7gWWwCMDG1dHCjD7g1u_vUXsU6Bzw@mail.gmail.com>
Message-ID: <CAHk-=wg-LXL4ZDMveCf9M7gWWwCMDG1dHCjD7g1u_vUXsU6Bzw@mail.gmail.com>
Subject: Re: [PATCH v4 44/45] mm: fs: initialize fsdata passed to
 write_begin/write_end interface
To:     Alexander Potapenko <glider@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 25, 2022 at 8:40 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Mon, Jul 4, 2022 at 10:07 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > ... wait, passing an uninitialised variable to a function *which doesn't
> > actually use it* is now UB?  What genius came up with that rule?  What
> > purpose does it serve?
> >
>
> There is a discussion at [1], with Segher pointing out a reason for
> this rule [2] and Linus requesting that we should be warning about the
> cases where uninitialized variables are passed by value.

I think Matthew was actually more wondering how that UB rule came to be.

Personally, I pretty much despise *all* cases of "undefined behavior",
but "uninitialized argument" across a function call is one of the more
understandable ones.

For one, it's a static sanity checking issue: if function call
arguments can be uninitialized random garbage on the assumption that
the callee doesn't necessarily _use_ them, then any static checker is
going to be unhappy because it means that it can never assume that
incoming arguments have been initialized either.

Of course, that's always true for any pointer passing, but hey, at
least then it's pretty much explicit. You're passing a pointer to some
memory to another function, it's always going to be a bit ambiguous
who is supposed to initialize it - the caller or the callee.

Because one very important "static checker" is the person reading the
code. When I read a function definition, I most definitely have the
expectation that the caller has initialized all the arguments.

So I actually think that "human static checker" is a really important
case. I do not think I'm the only one who expects incomping function
arguments to have values.

But I think the immediate cause of it on a compiler side was basically
things like poison bits. Which are a nice debugging feature, even
though (sadly) I don't think they are usually added the for debugging.
It's always for some other much more nefarious reason (eg ia64 and
speculative loads weren't for "hey, this will help people find bugs",
but for "hey, our architecture depends on static scheduling tricks
that aren't really valid, so we have to take faults late").

Now, imagine you're a compiler, and you see a random incoming integer
argument, and you can't even schedule simple arithmetic expressions on
it early because you don't know if the caller initialized it or not,
and it might cause some poison bit fault...

So you'd most certainly want to know that all incoming arguments are
actually valid, because otherwise you can't do even some really simple
and obvious optimziations.

Of course, on normal architectures, this only ever happens with FP
values, and it's often hard to trigger there too. But you most
definitely *could* see it.

I personally was actually surprised compilers didn't warn for "you are
using an uninitialized value" for a function call argument, because I
mentally consider function call arguments to *be* a use of a value.

Except when the function is inlined, and then it's all different - the
call itself goes away, and I *expect* the compiler to DTRT and not
"use" the argument except when it's used inside the inlined function.

Because hey, that's literally the whole point of inlining, and it
makes the "static checking" problem go away at least for a compiler.

                     Linus
