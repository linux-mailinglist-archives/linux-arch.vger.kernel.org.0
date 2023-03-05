Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0DB6AAECA
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 10:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCEJaH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sun, 5 Mar 2023 04:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCEJaH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 04:30:07 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D897AB7;
        Sun,  5 Mar 2023 01:30:06 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id z6so7651640qtv.0;
        Sun, 05 Mar 2023 01:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678008605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgd0m+/MCaDvNZBjSvDtubD53Qmudtg807BEeMSQ1f0=;
        b=TgJfpiw6bQwfYRwu06aJLoVRQ9AE57Buw1rCCjqjSdej4lOQnY/ypZTNIoWmAIBmcL
         Em++mWom34GrU4QJQSgXF15ULPCUPb/4v1xcaXvnK9adWv2o5WO+jsV3qcZoB8fq8cfP
         C16Vo+nmsMlH81ypwR1gf6WQQy9AkmOpWRKfzAlTSoIbNgpsw/iN/XJstKm/VTV/m6b5
         C+HM8MgMUDoy1HBaNpfW5TVDjg9M8IVRtorxSvyjfJmcknHNOnqDYSicmwfJKT7Dqr7R
         3437uLqqzIs8lQEydVsYcHvZjyo0Tl6HMuhYm+VtBJ3heeCQzANIYFy08q5c7pVDG8bT
         6Dmw==
X-Gm-Message-State: AO0yUKWT0vT+HQ+ETIXCy0EYolndTCyiDe3PUOsB2M6jqQWUa9Y1hNma
        CRGZCzcwa0nO3eBfdnE778jrRQ07yhEs+Q==
X-Google-Smtp-Source: AK7set/Qet7Y2xObux9A9+h42PzkaHtV04/tBNVDpaZLXtJ4Bp9Tna6wIAKORhr1xA+Wc7IjPVmuMw==
X-Received: by 2002:a05:622a:19a7:b0:3b8:2e92:94e7 with SMTP id u39-20020a05622a19a700b003b82e9294e7mr13025765qtc.44.1678008605119;
        Sun, 05 Mar 2023 01:30:05 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id l11-20020a37f90b000000b0071ddbe8fe23sm5221567qkj.24.2023.03.05.01.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 01:30:04 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-536be69eadfso128890197b3.1;
        Sun, 05 Mar 2023 01:30:04 -0800 (PST)
X-Received: by 2002:a81:af0c:0:b0:52f:1c23:ef1 with SMTP id
 n12-20020a81af0c000000b0052f1c230ef1mr4669025ywh.5.1678008604127; Sun, 05 Mar
 2023 01:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20230303102817.212148-1-bhe@redhat.com> <20230303102817.212148-3-bhe@redhat.com>
 <87sfej1rie.fsf@mpe.ellerman.id.au>
In-Reply-To: <87sfej1rie.fsf@mpe.ellerman.id.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 5 Mar 2023 10:29:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXoM24uAZGcjBtscNMOSY_+4u08PEOR7gOfCH7jvCceDg@mail.gmail.com>
Message-ID: <CAMuHMdXoM24uAZGcjBtscNMOSY_+4u08PEOR7gOfCH7jvCceDg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arch/*/io.h: remove ioremap_uc in some architectures
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        mcgrof@kernel.org, hch@infradead.org, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Michael,

On Sun, Mar 5, 2023 at 10:23 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Baoquan He <bhe@redhat.com> writes:
> > ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> > extension, and on ia64 with its slightly unconventional ioremap()
> > behavior, everywhere else this is the same as ioremap() anyway.
> >
> > Here, remove the ioremap_uc() definition in architecutures other
> > than x86 and ia64. These architectures all have asm-generic/io.h
> > included and will have the default ioremap_uc() definition which
> > returns NULL.
> >
> > Note: This changes the existing behaviour and could break code
> > calling ioremap_uc(). If any ARCH meets this breakage and really
> > needs a specific ioremap_uc() for its own usage, one ioremap_uc()
> > can be added in the ARCH.
>
> I see one use in:
>
> drivers/video/fbdev/aty/atyfb_base.c:        par->ati_regbase = ioremap_uc(info->fix.mmio_start, 0x1000);
>
>
> Which isn't obviously x86/ia64 specific.
>
> I'm pretty sure some powermacs (powerpc) use that driver.

I originally wrote that driver for CHRP, so yes.

> Maybe that exact code path is only reachable on x86/ia64? But if so
> please explain why.
>
> Otherwise it looks like this series could break that driver on powerpc
> at least.

Indeed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
