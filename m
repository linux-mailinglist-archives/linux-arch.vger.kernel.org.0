Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA674C9382
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 19:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiCASsV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 13:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiCASsV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 13:48:21 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FE71C907
        for <linux-arch@vger.kernel.org>; Tue,  1 Mar 2022 10:47:38 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v28so23060508ljv.9
        for <linux-arch@vger.kernel.org>; Tue, 01 Mar 2022 10:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZw99KMpsKBs3Ab/LBNeIPMebXALTITXobBfJpN/EsI=;
        b=ZEWbFFu3eWrZxUgaaScwD4ZJ//Z7mV4SGMyACB20WwCKEMFGKIBMMEXVkM4kZXdOyd
         EokMKBVyAcoYChV/SvtOh5q5h0Yafm3wlsC3jCGOeoM0h4pn550KTbE+/sUn3z3m8p0V
         ZL0gG9ZTrYCOlyUURTCDAGrluijISoqXbB1wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZw99KMpsKBs3Ab/LBNeIPMebXALTITXobBfJpN/EsI=;
        b=vemmxTs//GnLpneLRzLymYD34ljpTFHoS6CCh9Cky5xTbw6TJ4+uYCLUSYB14eD7v0
         t8srMkDTr39DlvNwnocgKnREICLoUyqt43MS49TtJ7Iiz63U6hqc8JcS1/7BHjcTsboq
         U5jJ6p9kdtu1gLWoO1D8/+QRqR9VpF3CIVcfdJdcBT1+b4E/Cx/PDJSYF+kT4XAD1uEt
         4jonAu9sTjuV8AZNk3IODAqYkwD4mgfZFqkrO5EwddOB1Tammzb0p0yKl6gjeArdGEsy
         WWcfciMSKDaDGcvzYRhFUr6OvWsvF7VPl7tI0mEMiNUreRAcncUeeQ+9clsk9k6N+OjN
         HhHQ==
X-Gm-Message-State: AOAM532isOyYCnoB3oncJZXwHsX5NvKUswa3g4G47TU1ZsINcbxNNJL6
        dftLoX5+wGfYkTBII7aCCHWEQCP0bSDVvVr5YKE=
X-Google-Smtp-Source: ABdhPJzmtdbNGXE8PDciDIMivB7jP87WU0km1o2s9UouGjUvnIYjLgA3/Yy90MpHieCrdh/QJ/x7XQ==
X-Received: by 2002:a2e:9c94:0:b0:233:82df:a3b8 with SMTP id x20-20020a2e9c94000000b0023382dfa3b8mr18313478lji.229.1646160455996;
        Tue, 01 Mar 2022 10:47:35 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id l11-20020a2e834b000000b00246308690e2sm2114862ljh.85.2022.03.01.10.47.32
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 10:47:33 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id g39so28373734lfv.10
        for <linux-arch@vger.kernel.org>; Tue, 01 Mar 2022 10:47:32 -0800 (PST)
X-Received: by 2002:a05:6512:2033:b0:443:3d49:dac with SMTP id
 s19-20020a056512203300b004433d490dacmr16440784lfs.52.1646160451271; Tue, 01
 Mar 2022 10:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com> <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
 <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
 <Yh0tl3Lni4weIMkl@casper.infradead.org> <CAHk-=wgBfJ1-cPA2LTvFyyy8owpfmtCuyiZi4+um8DhFNe+CyA@mail.gmail.com>
 <Yh1aMm3hFe/j9ZbI@casper.infradead.org> <CAHk-=wi0gSUMBr2SVF01Gy1xC1w1iGtJT5ztju9BPWYKjdh+NA@mail.gmail.com>
 <202203011008.AA0B5A2D@keescook>
In-Reply-To: <202203011008.AA0B5A2D@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Mar 2022 10:47:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whccSm8HKANQbomYrF8cqBa1wUi1dvUEUc3Nf=WoX3WHQ@mail.gmail.com>
Message-ID: <CAHk-=whccSm8HKANQbomYrF8cqBa1wUi1dvUEUc3Nf=WoX3WHQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        samba-technical@lists.samba.org,
        linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
        linux-arch <linux-arch@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        intel-wired-lan@lists.osuosl.org,
        kgdb-bugreport@lists.sourceforge.net,
        bcm-kernel-feedback-list@broadcom.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Arnd Bergman <arnd@arndb.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        v9fs-developer@lists.sourceforge.net,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sgx@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        tipc-discussion@lists.sourceforge.net,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

On Tue, Mar 1, 2022 at 10:14 AM Kees Cook <keescook@chromium.org> wrote:
>
> The first big glitch with -Wshadow was with shadowed global variables.
> GCC 4.8 fixed that, but it still yells about shadowed functions. What
> _almost_ works is -Wshadow=local.

Heh. Yeah, I just have long memories of "-Wshadow was a disaster". You
looked into the details.

> Another way to try to catch misused shadow variables is
> -Wunused-but-set-varible, but it, too, has tons of false positives.

That on the face of it should be an easy warning to get technically
right for a compiler.

So I assume the "false positives" are simply because we end up having
various variables that really don't end up being used - and
"intentionally" so).

Or rather, they might only be used under some config option - perhaps
the use is even syntactically there and parsed, but the compiler
notices that it's turned off under some

        if (IS_ENABLED(..))

option? Because yeah, we have a lot of those.

I think that's a common theme with a lot of compiler warnings: on the
face of it they sound "obviously sane" and nobody should ever write
code like that.

A conditional that is always true? Sounds idiotic, and sounds like a
reasonable thing for a compiler to warn about, since why would you
have a conditional in the first place for that?

But then you realize that maybe the conditional is a build config
option, and "always true" suddenly makes sense. Or it's a test for
something that is always true on _that_architecture_ but not in some
general sense (ie testing "sizeof()"). Or it's a purely syntactic
conditional, like "do { } while (0)".

It's why I'm often so down on a lot of the odd warnings that are
hiding under W=1 and friends. They all may make sense in the trivial
case ("That is insane") but then in the end they happen for sane code.

And yeah, -Wshadow has had tons of history with macro nesting, and
just being badly done in the first place (eg "strlen" can be a
perfectly fine local variable).

That said, maybe people could ask the gcc and clan people for a way to
_mark_ the places where we expect to validly see shadowing. For
example, that "local variable in a macro expression statement" thing
is absolutely horrendous to fix with preprocessor tricks to try to
make for unique identifiers.

But I think it would be much more syntactically reasonable to add (for
example) a "shadow" attribute to such a variable exactly to tell the
compiler "yeah, yeah, I know this identifier could shadow an outer
one" and turn it off that way.

               Linus
