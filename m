Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221D26F530F
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 10:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjECIWM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 3 May 2023 04:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjECIWH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 04:22:07 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993584C11;
        Wed,  3 May 2023 01:22:05 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-55a829411b5so24084707b3.1;
        Wed, 03 May 2023 01:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683102124; x=1685694124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yf0nQOOKHL0GEtmAgACXt9/1DKDkHK6ft7tmYSYGTKo=;
        b=CJ5U/HXNXyC/cc3ae4K8hgvtdQUlrZV+z98m9/QvAG6EG5lJe1inzgr1MXQ3yAuWyu
         Iy4KMTI0wYz+0+sNDAE1YtKYZaaJsvlz2mw46Tp5A5L0m3SEgnH++QIttWJS2KFGDMhU
         mm9q9T0Y8ercwTR8mwZyGdUCWoe/4CnDyYmQmq6LrEoMc44vWZOWyS+sOq89c2wFPfwW
         ksxAq8cjNhZIfqqr3vffey56LefKQ/w7IJcJxov52UJMStqL1lU+k6QK6hb/yysHP66k
         YHW1iBeKFuETfoWJd+9jwmVChtUEmSSY+gDfbf0qCUqlzmngz0o7yc8EadYF36bzWloF
         mE1g==
X-Gm-Message-State: AC+VfDzrZDKPLsLGuMpXz3muLah1rfkdvm95fMR5VCug3VWTbHD0Fg2w
        vkZFOLcVPVcQwuuJ6Q2Mpv1LNg37/eWrng==
X-Google-Smtp-Source: ACHHUZ5X1QagMEjqiwNPa5tS7efZTv1eB2bYoLvf7UkSjrCyb5G+M9a5xdfAlk888xzRcPSMw5eIgw==
X-Received: by 2002:a81:a14d:0:b0:55a:30f3:119 with SMTP id y74-20020a81a14d000000b0055a30f30119mr10441961ywg.35.1683102124555;
        Wed, 03 May 2023 01:22:04 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id t192-20020a8183c9000000b00552f3887d16sm8479050ywf.22.2023.05.03.01.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 01:22:03 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-55a829411b5so24084057b3.1;
        Wed, 03 May 2023 01:22:02 -0700 (PDT)
X-Received: by 2002:a25:240f:0:b0:b9d:d5dc:596c with SMTP id
 k15-20020a25240f000000b00b9dd5dc596cmr11998230ybk.12.1683102122353; Wed, 03
 May 2023 01:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230502130223.14719-1-tzimmermann@suse.de>
In-Reply-To: <20230502130223.14719-1-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 May 2023 10:21:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV06LN17KzOh42vjyF504myT=D=a-zz3MduOmQPEmv5SA@mail.gmail.com>
Message-ID: <CAMuHMdV06LN17KzOh42vjyF504myT=D=a-zz3MduOmQPEmv5SA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] fbdev: Move framebuffer I/O helpers to <asm/fb.h>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, javierm@redhat.com, daniel@ffwll.ch,
        vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        davem@davemloft.net, James.Bottomley@hansenpartnership.com,
        arnd@arndb.de, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On Tue, May 2, 2023 at 3:02 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> (was: fbdev: Use regular I/O function for framebuffers)
>
> Fbdev provides helpers for framebuffer I/O, such as fb_readl(),
> fb_writel() or fb_memcpy_to_fb(). The implementation of each helper
> depends on the architecture, but they are all equivalent to regular
> I/O functions of similar names. So use regular functions instead and
> move all helpers into <asm-generic/fb.h>
>
> The first patch a simple whitespace cleanup.
>
> Until now, <linux/fb.h> contained an include of <asm/io.h>. As this
> will go away patches 2 to 4 prepare include statements in the various
> drivers. Source files that use regular I/O helpers, such as readl(),
> now include <linux/io.h>. Source files that use framebuffer I/O
> helpers, such as fb_readl(), also include <asm/fb.h>.
>
> Patch 5 replaces the architecture-based if-else branching in
> <linux/fb.h> by helpers in <asm-generic/fb.h>. All helpers use Linux'
> existing I/O functions.
>
> Patch 6 harmonizes naming among fbdev and existing I/O functions.
>
> The patchset has been built for a variety of platforms, such as x86-64,
> arm, aarch64, ppc64, parisc, m64k, mips and sparc.
>
> v3:
>         * add the new helpers in <asm-generic/fb.h>
>         * support reordering and native byte order (Geert, Arnd)

Thanks, this fixes the mangled display I was seeing on ARAnyM
with bpp=16.

BTW, this series seems to have mixed dependencies: the change
to include/asm-generic/fb.h depends on "[PATCH v3 00/19] arch:
Consolidate <asm/fb.h>"[1], but with that applied, I had to manually
fixup drivers/video/fbdev/core/fb_cfb_fops.c.

[1] https://lore.kernel.org/all/20230417125651.25126-1-tzimmermann@suse.de,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
