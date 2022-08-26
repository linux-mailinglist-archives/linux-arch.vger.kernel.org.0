Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C3F5A302F
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiHZTt4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 15:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242176AbiHZTtz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 15:49:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F47479A55
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 12:49:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z2so3350479edc.1
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qH9fXuLG/2N7XJd2Ax6mCY7hEPgeeICD6t/tT+e4ZA0=;
        b=OpNlxqMQbRgNEJYIapLZRyQ8QLwCr73YGaTNiV0QC490OmZqzOw8r4qyVuMJ9681dr
         No7PNh11cqUCQ6/tlGADYZyVLggenKnKCbhwK3EhhA7NtQAfrR6gJfRDHAKdwOLHx5t8
         vBiepUa6W5cge4oVs0JpvJo51S3Adxw2YNf3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qH9fXuLG/2N7XJd2Ax6mCY7hEPgeeICD6t/tT+e4ZA0=;
        b=eMeepj/UZC+RISuLuK0LSphdw+1jH17aAVJ9EoMEzlzxMzW27KWPbkQL+5jHzT3QbW
         bUGqaRisUOPSf6XuVqpLkXoYz8KUSLatiSg4zfVBwGrwWiJaQsfh2iK+ao01KhKCt8AL
         BkTiOq+uQfzAYfE27DifXC6IfmJwEwTY+fI3Y7WidThAqwbeOp1gZJ4nc8bm4VaqR9sC
         Lc1v+fDvGNis/F/4VxM4U04F0byoDbiAhx30H5KCymB2b7TXoumwEXjm5OlWLui2W/SU
         Ft0xLAA8rb6OFUZVPkb0ou/HYZi2+0ICNl91guisF0rjciw0nLn0Ro0msNjzNFkFNh5w
         Po0A==
X-Gm-Message-State: ACgBeo0rk4BL3biN3Hei73rkCKm8So3SqjtAM9VkZ0I1n0/+pqMgtZsl
        3GLdGEc5MY+ILJfEma7rLmOnM3vh1YRjyAHk1iQ=
X-Google-Smtp-Source: AA6agR76lO6lPS3A7cfb9evlnkUtQoMkNKtvbGBcHzAJ1j0UeJU2Pkjtet2M2YyCrYILZPthrDARug==
X-Received: by 2002:a50:a6c5:0:b0:448:40b:6c51 with SMTP id f5-20020a50a6c5000000b00448040b6c51mr2002924edc.78.1661543391811;
        Fri, 26 Aug 2022 12:49:51 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id g24-20020a50d0d8000000b0044786c2c5c1sm1750825edf.3.2022.08.26.12.49.51
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 12:49:51 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id e20so2929714wri.13
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 12:49:51 -0700 (PDT)
X-Received: by 2002:a5d:4052:0:b0:225:8b55:67fd with SMTP id
 w18-20020a5d4052000000b002258b5567fdmr600450wrp.281.1661542902549; Fri, 26
 Aug 2022 12:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-45-glider@google.com>
 <YsNIjwTw41y0Ij0n@casper.infradead.org> <CAG_fn=VbvbYVPfdKXrYRTq7HwmvXPQUeUDWZjwe8x8W=ttq6KA@mail.gmail.com>
 <CAHk-=wg-LXL4ZDMveCf9M7gWWwCMDG1dHCjD7g1u_vUXsU6Bzw@mail.gmail.com> <20220825215754.GI25951@gate.crashing.org>
In-Reply-To: <20220825215754.GI25951@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 12:41:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_nfiLk_bzjD8GWFFzm17syvOYqS=Y7BOarMSTkMiamQ@mail.gmail.com>
Message-ID: <CAHk-=wj_nfiLk_bzjD8GWFFzm17syvOYqS=Y7BOarMSTkMiamQ@mail.gmail.com>
Subject: Re: [PATCH v4 44/45] mm: fs: initialize fsdata passed to
 write_begin/write_end interface
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Matthew Wilcox <willy@infradead.org>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 25, 2022 at 3:10 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> But UB is defined in terms of the abstract machine (like *all* of C),
> not in terms of the generated machine code.  Typically things will work
> fine if they "become invisible" by inlining, but this does not make the
> program a correct program ever.  Sorry :-(

Yeah, and the abstract machine model based on "abstract syntax" is
just wrong, wrong, wrong.

I really wish the C standard people had the guts to just fix it.  At
some point, relying on tradition when the tradition is bad is not a
great thing.

It's the same problem that made all the memory ordering discussions
completely untenable. The language to allow the whole data dependency
was completely ridiculous, because it became about the C language
syntax and theory, not about the actual code generation and actual
*meaning* that the whole thing was *about*.

Java may be a horrible language that a lot of people hate, but it
avoided a lot of problems by just making things about an actual
virtual machine and describing things within a more concrete model of
a virtual machine.

Then you can just say "this code sequence generates this set of
operations, and the compiler can optimize it any which way it likes as
long as the end result is equivalent".

Oh well.

I will repeat: a paper standard that doesn't take reality into account
is less useful than toilet paper. It's scratchy and not very
absorbent.

And the kernel will continue to care more about reality than about a C
standard that does bad things.

Inlining makes the use of the argument go away at the call site and
moves the code of the function into the body. That's how things
*work*. That's literally the meaning of inlining.

And inlining in C is so important because macros are weak, and other
facilities like templates don't exist.

But in the kernel, we also often use it because the actual semantics
of "not a function call" in terms of code generation is also important
(ie we have literal cases where "not generating the 'call'
instruction" is a correctness issue).

If the C standard thinks "undefined argument even for inlining use is
UB", then it's a case of that paperwork that doesn't reflect reality,
and we'll treat it with the deference it deserves - is less than
toilet paper.

We have decades of history of doing that in the kernel. Sometimes the
standards are just wrong, sometimes they are just too far removed from
reality to be relevant, and then it's just not worth worrying about
them.

          Linus
