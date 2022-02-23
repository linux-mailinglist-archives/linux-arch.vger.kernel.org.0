Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ABE4C1B8B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 20:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiBWTMq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 14:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBWTMp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 14:12:45 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3164B31213
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 11:12:17 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a23so54305715eju.3
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 11:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mL0nR+ziEzThvzLITlZK1PYh9ofonS5DJNnVhGA9cEk=;
        b=ZxfU9J7Sv2Cr5l8MpDBHBUZBrVW4RtmdXoajMkfvwL5M7gMkck9lVPP17E6o9PJ3/z
         ETsUPxqKeXn2I8IImb0calaYlReEIGEV8iHd0/zOMfzCOmOYGI7/nX2ky2VlME1H418/
         TnIcjdzbSuOjm67cwnrFkZVsdsAAO/6HIThdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mL0nR+ziEzThvzLITlZK1PYh9ofonS5DJNnVhGA9cEk=;
        b=NIq3kUQk+HaKokepXldFPGLISdhC9Bfx1QzNHIHSer159uJ+AwiWBNZDTr4BCeZuf9
         CGWIiAyoOxedNCnpuNAxtQhmG0p/Fu6hndIcKHlBCH+4VJ1a6Gu76zG/v9q+7abLAfCi
         jGATnuG1asCkbW4EDjRYcgT+dRqIUSezSjU1wRyYI4MYGzeZji397h7DUByUdrYZ7AZE
         lwZGLlelNyG55Y9qswLSZ5Dnk4J9AKvRuTqcRuI0JAJAQZRaqEDN6CUGuxS/TNm96Vgn
         ejo/Xyuw48sVZsmK/cCUJKgdaAgnRBAnThmX9q3lgOBN0QCax+YPQCEK++U/Xe8t4FHv
         ixcA==
X-Gm-Message-State: AOAM532lpIFd5T8S5diMTPbW3kODEID2UtKZYFf9Y1sRVrk+5l7eaMBy
        WO8ByoDx7mSFXm7iGD7MaoLGFwjbzkSKmRVs2lc=
X-Google-Smtp-Source: ABdhPJyewqeBbsGr6vOW2KL0VpAU+DYWPhowW4UbUFrXxlfXPNAQMqeFMRoOdsVYwSrpqT1OG2hqCw==
X-Received: by 2002:a17:906:3adb:b0:6b7:876c:d11b with SMTP id z27-20020a1709063adb00b006b7876cd11bmr899890ejd.250.1645643535415;
        Wed, 23 Feb 2022 11:12:15 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id l1sm216229ejb.81.2022.02.23.11.12.15
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 11:12:15 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id x15so6842679wrg.8
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 11:12:15 -0800 (PST)
X-Received: by 2002:a2e:80c6:0:b0:246:3334:9778 with SMTP id
 r6-20020a2e80c6000000b0024633349778mr543364ljg.443.1645643179121; Wed, 23 Feb
 2022 11:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-5-jakobkoschel@gmail.com> <20220218151216.GE1037534@ziepe.ca>
 <6BA40980-554F-45E2-914D-5E4CD02FF21C@gmail.com>
In-Reply-To: <6BA40980-554F-45E2-914D-5E4CD02FF21C@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 11:06:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wir=xabJ73Upk1dsuoMKWTTjTfeLFJ=p2S0yRYYaxW4fA@mail.gmail.com>
Message-ID: <CAHk-=wir=xabJ73Upk1dsuoMKWTTjTfeLFJ=p2S0yRYYaxW4fA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/13] vfio/mdev: remove the usage of the list
 iterator after the loop
To:     Jakob <jakobkoschel@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
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

On Wed, Feb 23, 2022 at 6:18 AM Jakob <jakobkoschel@gmail.com> wrote:
>
> However, in this example, 'tmp' will be a out-of-bounds pointer
> if the loop did finish without hitting the break, so the check past the
> loop *could* match 'mdev' even though no break was ever met.

So just as context for others, since I was hit with the same confusion
and didn't see what the relevance was for type speculation, when these
patches seemed to be not about speculation at all.

The background for this is that the list_for_each_entry() will set the
iterator variable (here 'tmp') to be not the actual internal list
pointer, but the pointer to the containing type (which is the whole
'entry' part of the name, of course).

And that is all good and true, but it's true only *WITHIN* that loop.
At the exit condition, it will have hit the 'head' of the list, and
the type that contains the list head is *not* necessarily the same
type as the list entries.

So that's where the type confusion comes from: if you access the list
iterator outside the loop, and it could have fallen off the end of the
loop, the list iterator pointer is now not actually really a valid
pointer of that 'entry' type at all.

And as such, you not only can't dereference it, but you also shouldn't
even compare pointer values - because the pointer arithmetic that was
valid for loop entries is not valid for the HEAD entry that is
embedded in another type. So the pointer arithmetic might have turned
it into a pointer outside the real container of the HEAD, and might
actually match something else.

Now, there are a number of reasons I really dislike the current RFC
patch series, so I'm not claiming the patch is something we should
apply as-is, but I'm trying to clarify why Jakob is doing what he's
doing (because clearly I wasn't the only one taken  by surprise by
it).

The reasons I don't like it is:

 - patches like these are very random. And very hard to read (and very
easy to re-introduce the bug).

 - I think it conflates the non-speculative "use pointer of the wrong
type" issue like in this patch with the speculation

 - I'm not even convinced that 'list_for_each_entry()' is that special
wrt speculative type accesses, considering that we have other uses of
doubly linked list *everywhere* - and it can happen in a lot of other
situations anyway, so it all seems to be a bit ad hoc.

but I do think the problem is real.

So elsewhere I suggested that the fix to "you can't use the pointer
outside the loop" be made to literally disallow it (using C99 for-loop
variables seems the cleanest model), and have the compiler refuse to
touch code that tries to use the loop iterator outside.

And that is then entirely separate from the issue of actual
speculative accesses (but honestly, I think that's a "you have to
teach the compiler not to do them" issue, not a "let's randomly change
*one* of our loop walkers).

                Linus
