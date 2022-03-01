Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4D14C9985
	for <lists+linux-arch@lfdr.de>; Wed,  2 Mar 2022 00:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiCAX4o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 18:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiCAX4n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 18:56:43 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3350C70075
        for <linux-arch@vger.kernel.org>; Tue,  1 Mar 2022 15:56:01 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id v22so9609ljh.7
        for <linux-arch@vger.kernel.org>; Tue, 01 Mar 2022 15:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4H0hy1V+vsSL/J4iRHU98fs6Ghx9E/bawvPg5OjXQmQ=;
        b=A1xSV6w+mnGI8KddmZFT+SVp47UhRqZlj7dZE7Ue1BgWjGw2+QCc51Zb6PIPvKiXuh
         /TGd1P3o63R0kiFyLwVU+kzDBf6Kt9wFSZwwJYnrWAqavu9szp3nfmKm0Qe68N3l8Mdl
         bWvesgtwBf4BWRSm4aUiCmj0pmAaHYwmzAjUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4H0hy1V+vsSL/J4iRHU98fs6Ghx9E/bawvPg5OjXQmQ=;
        b=IdAQ8MfZaIswISaytGd6KueuAsCc/SCJ+uA1kRh72640oHf9C0DrcFO3ZxSCaa9/mF
         WfXVOs2WQPQUQhTNMjjQkeXHbzvo+oUg14KVDoromf4fj5qoWhQ58YJQPMm1vmLS3Vpc
         Q0zS2WLXQaiBzvW7lRFxnb9bAliapsJeGfRFxE2rctGTcmS59xcmgXcKplis1rmp7mQI
         xEQoJbr33Vo/Is2Iwvju/VF4SJXOgQSB+UKoViyo/ucZTfyYIrHGgk+DbUwyu3lTEDoq
         DCUeqCwonYBVLO3+9b18riqs9Bf0kGjnCtfuLu/fMJ3OE9fW5ziRbtasXgtfgAm0J42B
         7bBw==
X-Gm-Message-State: AOAM530LWaa915JPXZMv8sX+A+C34XlOxwYKx4P68rGzB/1mFK4VXf9m
        zejM4sNH8vlE6P6gyhBAJVtD6Cpaktfjgljou9A=
X-Google-Smtp-Source: ABdhPJw43UWqpEF6UJubMNRgur9IUazuL+Y+tdPgnkA/nWrCFiFHKpZlylcJ493+zTuHphpFXFIwGg==
X-Received: by 2002:a2e:96c8:0:b0:246:df5:e8c5 with SMTP id d8-20020a2e96c8000000b002460df5e8c5mr19439018ljj.431.1646178959379;
        Tue, 01 Mar 2022 15:55:59 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id n13-20020a056512388d00b00443ecf806c5sm1728659lft.104.2022.03.01.15.55.58
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 15:55:59 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id g39so29546578lfv.10
        for <linux-arch@vger.kernel.org>; Tue, 01 Mar 2022 15:55:58 -0800 (PST)
X-Received: by 2002:a05:6512:3042:b0:437:96f5:e68a with SMTP id
 b2-20020a056512304200b0043796f5e68amr17643498lfb.449.1646178958685; Tue, 01
 Mar 2022 15:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com> <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com> <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
 <7D0C2A5D-500E-4F38-AD0C-A76E132A390E@kernel.org> <73fa82a20910c06784be2352a655acc59e9942ea.camel@HansenPartnership.com>
 <CAHk-=wiT5HX6Kp0Qv4ZYK_rkq9t5fZ5zZ7vzvi6pub9kgp=72g@mail.gmail.com>
 <7dc860874d434d2288f36730d8ea3312@AcuMS.aculab.com> <CAHk-=whKqg89zu4T95+ctY-hocR6kDArpo2qO14-kV40Ga7ufw@mail.gmail.com>
 <0ced2b155b984882b39e895f0211037c@AcuMS.aculab.com>
In-Reply-To: <0ced2b155b984882b39e895f0211037c@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Mar 2022 15:55:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wix0HLCBs5sxAeW3uckg0YncXbTjMsE-Tv8WzmkOgLAXQ@mail.gmail.com>
Message-ID: <CAHk-=wix0HLCBs5sxAeW3uckg0YncXbTjMsE-Tv8WzmkOgLAXQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To:     David Laight <David.Laight@aculab.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        KVM list <kvm@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>,
        "linux1394-devel@lists.sourceforge.net" 
        <linux1394-devel@lists.sourceforge.net>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergman <arnd@arndb.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        dma <dmaengine@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mike Rapoport <rppt@kernel.org>
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

On Tue, Mar 1, 2022 at 3:19 PM David Laight <David.Laight@aculab.com> wrote:
>
> Having said that there are so few users of list_entry_is_head()
> it is reasonable to generate two new names.

Well, the problem is that the users of list_entry_is_head() may be few
- but there are a number of _other_ ways to check "was that the HEAD
pointer", and not all of them are necessarily correct.

IOW, different places do different random tests for "did we walk the
whole loop without breaking out". And many of them happen to work. In
fact, in practice, pretty much *all* of them happen to work, and you
have to have the right struct layout and really really bad luck to hit
a case of "type confusion ended up causing the test to not work".

And *THAT* is the problem here. It's not the "there are 25ish places
that current use list_entry_is_head()".

It's the "there are ~480 places that use the type-confused HEAD entry
that has been cast to the wrong type".

And THAT is why I think we'd be better off with that bigger change
that simply means that you can't use the iterator variable at all
outside the loop, and try to make it something where the compiler can
help catch mis-uses.

Now, making the list_for_each_entry() thing force the iterator to NULL
at the end of the loop does fix the problem. The issue I have with it
is really just that you end up getting no warning at all from the
compiler if you mix old-style and new-style semantics. Now, you *will*
get an oops (if using a new-style iterator with an old-style check),
but many of these things will be in odd driver code and may happen
only for error cases.

And if you use a new-style check with an old-style iterator (ie some
backport problem), you will probably end up getting random memory
corruption, because you'll decide "it's not a HEAD entry", and then
you'll actually *use* the HEAD that has the wrong type cast associated
with it.

See what my worry is?

With the "don't use iterator outside the loop" approach, the exact
same code works in both the old world order and the new world order,
and you don't have the semantic confusion. And *if* you try to use the
iterator outside the loop, you'll _mostly_ (*) get a compiler warning
about it not being initialized.

             Linus

(*) Unless somebody initializes the iterator pointer pointlessly.
Which clearly does happen. Thus the "mostly". It's not perfect, and
that's most definitely not nice - but it should at least hopefully
make it that much harder to mess up.
