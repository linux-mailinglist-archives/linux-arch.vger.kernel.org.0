Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CD94C7F81
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 01:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiCAAqL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 19:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiCAAqK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 19:46:10 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69CB2DE3
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 16:45:30 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id o6so19749432ljp.3
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 16:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BlmDHl6uq7o6y8aC/cJk7fo5oLGvHdeOO4XUoHPiZHY=;
        b=CuWkmdhnuqYUPLlFfSW5kqvLG+/BaUYxswQvwT5TlbeMKdgX0f6Tdop/2MomIxMIWT
         P4yfskuo3sOir2HSEC5b7N//0EkwPlLVbS+ffho6xWO2QaHJfy0oi9bnLtClO4bSDX+r
         dQzBghLtont2uRRAhfDOfzUglX2wpO3DzhpXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BlmDHl6uq7o6y8aC/cJk7fo5oLGvHdeOO4XUoHPiZHY=;
        b=2JYcjUGsr7QXteGtfn+yY9mlPUvAc2YKlQTVPQ+lg+bLHkyLh4eailiqnYMaLMyC5k
         g0fYek+uDDaFCROjw1FitcQIMUqGb5yjlID2+/SJKEfG3/TPSaBW2y+Qc3b+GRS7eq2y
         o2x9Ik31kkNW2OAtbjWToISggQS/AFrIj2ptS4Z8XwY7SCwkNk+PYwmfs3cq9DgpIARK
         tgqLnQx0ZzzCHAw5EAjBCeXxcoNKHCtne8/YiiUntvQphviIFo3CUjmnB5HV/ZdyOnLH
         C8phVqwJPzGDAkI4PKOxQZghjZ6UKgdJ4Uhb0ZGhbO7sMh61S37BxNSbv/3JjRLIXq4y
         4/Yg==
X-Gm-Message-State: AOAM530InrbGTXARMdlzrj2akejfZfE2feymwtRdn9p3Dewle39O0uhg
        m22WVCdj6089pr+D5WW27qn9qdES3MLiwDO5Uto=
X-Google-Smtp-Source: ABdhPJyHnqc8TR9BiXyD6CwtyWiZs4EWGHPnXYE8/Fd8Aj5aP4SGGKhZBek1Xx/iKeKcX+V6ftUxbA==
X-Received: by 2002:a2e:8053:0:b0:23c:fa2a:5d3e with SMTP id p19-20020a2e8053000000b0023cfa2a5d3emr15611527ljg.96.1646095529002;
        Mon, 28 Feb 2022 16:45:29 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r6-20020a19ac46000000b004433cbb7ef9sm1207318lfc.137.2022.02.28.16.45.27
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 16:45:27 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id y24so24289107lfg.1
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 16:45:27 -0800 (PST)
X-Received: by 2002:a05:6512:3042:b0:437:96f5:e68a with SMTP id
 b2-20020a056512304200b0043796f5e68amr14778245lfb.449.1646095527444; Mon, 28
 Feb 2022 16:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com> <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
 <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
 <Yh0tl3Lni4weIMkl@casper.infradead.org> <CAHk-=wgBfJ1-cPA2LTvFyyy8owpfmtCuyiZi4+um8DhFNe+CyA@mail.gmail.com>
 <Yh1aMm3hFe/j9ZbI@casper.infradead.org>
In-Reply-To: <Yh1aMm3hFe/j9ZbI@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Feb 2022 16:45:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi0gSUMBr2SVF01Gy1xC1w1iGtJT5ztju9BPWYKjdh+NA@mail.gmail.com>
Message-ID: <CAHk-=wi0gSUMBr2SVF01Gy1xC1w1iGtJT5ztju9BPWYKjdh+NA@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
        Kees Cook <keescook@chromium.org>,
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

On Mon, Feb 28, 2022 at 3:26 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> #define ___PASTE(a, b)  a##b
> #define __PASTE(a, b) ___PASTE(a, b)
> #define _min(a, b, u) ({         \

Yeah, except that's ugly beyond belief, plus it's literally not what
we do in the kernel.

Really. The "-Wshadow doesn't work on the kernel" is not some new
issue, because you have to do completely insane things to the source
code to enable it.

Just compare your uglier-than-sin version to my straightforward one.
One does the usual and obvious "use a private variable to avoid the
classic multi-use of a macro argument". And the other one is an
abomination.

              Linus
