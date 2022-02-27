Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42B44C5EF6
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 22:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiB0VGI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Feb 2022 16:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiB0VFr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Feb 2022 16:05:47 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187F828E02
        for <linux-arch@vger.kernel.org>; Sun, 27 Feb 2022 13:05:09 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id o6so14807417ljp.3
        for <linux-arch@vger.kernel.org>; Sun, 27 Feb 2022 13:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSHr3nTbnOhAHHvD9gcRuzb7Z+l/28mCvr6FBYKx3Jg=;
        b=cz5eFf016k8zCL008IYZ3R+cQOb1ZLSrvaH9TuTcK33seJTFNea2L6f1v/f6Q3Jdy5
         NFzHYU5pSElShwGf1W+/92sNTVXqYzefCxivdNt4eI+wHqItKzpbafgD6tz2sVbC8Sed
         xc12WaBJOXbs9pLvKFyf1hV8Upui8mPhoKcY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSHr3nTbnOhAHHvD9gcRuzb7Z+l/28mCvr6FBYKx3Jg=;
        b=N6gsoxt/m2K5/Jfx/vkuwVn4QNDanedWIwDhC8tepbmq8uOtRuE6k9wXKXumd/Exy3
         vfV8/GbSUid3u65UO4G6a9Ji68OXhoV9rrUcFEtVogz/NAwxTEMe0DY6YymC5XmTu+uv
         RZx9iDdMVE960XC9Pt5LjqIs9pVvMUeDaCH58kDnXhShwtoc9cAc2R505jlx/q+7dGxV
         i2q8jGj1AxtpKWgwtPHS+FYhlZwd0oAYqX/5bnDkdbaJb3MIKXK1+7KhAvwMK86jCu5c
         Qi8fY6rE8L5LYY8xJslTquCETMwZfVxX6fra15D/epDA4AzQGd+BS4gkLNWu20l6LNxJ
         UNWg==
X-Gm-Message-State: AOAM530RNfvDnaOoHW6Ka9ZINZgfGWDscnK6pFR1qOVJsAmHCr28isTY
        UcmTmEv35gw782SOluKtQU5EmjIx1AHbBA9KBmk=
X-Google-Smtp-Source: ABdhPJyvEyToDkhpWeueVGIMnzWCJPloGxteo4ssrH8Wjj+DDZk0XmidYQmoRr3G+jCYRJiUQqtI/A==
X-Received: by 2002:a05:651c:307:b0:23b:1de6:5376 with SMTP id a7-20020a05651c030700b0023b1de65376mr12035203ljp.261.1645995907088;
        Sun, 27 Feb 2022 13:05:07 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id p9-20020a19f109000000b00443a79313a8sm732306lfh.271.2022.02.27.13.05.04
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 13:05:05 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id v22so14805339ljh.7
        for <linux-arch@vger.kernel.org>; Sun, 27 Feb 2022 13:05:04 -0800 (PST)
X-Received: by 2002:a2e:924d:0:b0:246:370c:5618 with SMTP id
 v13-20020a2e924d000000b00246370c5618mr12174195ljg.358.1645995904456; Sun, 27
 Feb 2022 13:05:04 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
 <20220226124249.GU614@gate.crashing.org> <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com>
 <20220227010956.GW614@gate.crashing.org> <7abf3406919b4f0c828dacea6ce97ce8@AcuMS.aculab.com>
 <20220227113245.GY614@gate.crashing.org> <CANiq72m28WrjVHkcg5Y0LDa51Ur4OCpFbGdcq+v4gqiC0Wi6zg@mail.gmail.com>
 <20220227201724.GZ614@gate.crashing.org>
In-Reply-To: <20220227201724.GZ614@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Feb 2022 13:04:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijh=SQ_9_-H6O08HgmXrWz37_vcdm55oECo+31LUs2EQ@mail.gmail.com>
Message-ID: <CAHk-=wijh=SQ_9_-H6O08HgmXrWz37_vcdm55oECo+31LUs2EQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@arndb.de>, Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
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

On Sun, Feb 27, 2022 at 12:22 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Requiring to annotate every place that has UB (or *can* have UB!) by the
> user is even less friendly than having so much UB is already :-(

Yeah, I don't think that's the solution. In fact, I don't think that's
even practically the _issue_.

Honestly, a lot of "undefined behavior" in C is quite often of the
kind "the programmer knows what he wants".

Things like word size or byte order issues etc are classic "undefined
behavior" in the sense that the C compiler really doesn't understand
them. The C compiler won't silently fix any silly behavior you get
from writing files in native byte order, and them not working on other
platforms.

Same goes for things like memory allocators - they often need to do
things that the standard doesn't really cover, and shouldn't even
*try* to cover. It's very much a core example of where people do odd
pointer arithmetic and change the type of pointers.

The problem with the C model of "undefined behavior" is not that the
behavior ends up being architecture-specific and depending on various
in-memory (or in-register) representation of the data. No, those
things are often very much intentional (even if in the case of byte
order, the "intention" may be that the programmer simply does not
care, and "knows" that all the world is little endian).

If the C compiler just generates reliable code that can sanely be
debugged - including very much using tools that look for "hey, this
behavior can be surprising", ie all those "look for bad patterns at
run-time", then that would be 100% FINE.

But the problem with the C notion of undefined behavior is NOT that
"results can depend on memory layout and other architecture issues
that the compiler doesn't understand".

No, the problem is that the C standards people - and compiler people -
have then declared that "because this can be surprising, and the
compiler doesn't understand what is going on, now the compiler can do
something *else* entirely".

THAT is the problem.

The classic case - and my personal "beat a dead horse" - is the
completely broken type-based aliasing rules. The standards people
literally said "the compiler doesn't understand this, it can expose
byte order dependencies that shouldn't be explained, SO THE COMPILER
CAN NOW DO SOMETHING COMPLETELY INSANE INSTEAD".

And compiler people? They rushed out to do completely broken garbage -
at least some of them did.

You can literally find compiler people who see code like this (very
traditional, traditionally very valid and common, although):

   // Return the least significant 16 bits of 'a' on LE machines
  #define low_16_bits(x) (*(unsigned short *)&(x))

and say "oh, because that's undefined, I can now decide to not do what
the programmer told me to do AT ALL".

Note that the above wasn't actually even badly defined originally. It
was well-defined, it was used, and it was done by programmers that
knew what they were doing.

And then the C standards people decided that "because our job isn't to
describe all the architectural issues you can hit, we'll call it
undefined, and in the process let compiler people intentionally break
it".

THAT is a problem.

Undefined results are are often intentional in system software - or
they can be debugged using smart tools (including possibly very
expensive run-time code generation) that actively look for them.

But compilers that randomly do crazy things because the standard was
bad? That's just broken.

If compilers treated "undefined" as the same as
"implementation-defined, but not explicitly documented", then that
would be fine. But the C standards people - and a lot of compiler
people - really don't seem to understand the problems they caused.

And, btw, caused for no actual good reason. The HPC people who wanted
Fortran-style aliasing could easily have had that with an extension.
Yes, "restrict" is kind of a crappy one, but it could have been
improved upon. Instead, people said "let's just break the language".

Same exact thing goes for signed integer overflow.

               Linus
