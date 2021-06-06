Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7E439CFD4
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 17:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhFFPlO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 11:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFFPlN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 11:41:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D742C061766;
        Sun,  6 Jun 2021 08:39:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so8515880wmq.0;
        Sun, 06 Jun 2021 08:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tXVK6dmsPKFlxVGsnju6Gmzr7jy3YZ4iKuNuKJOxdWw=;
        b=JOvuaADx3aNM3K94Mgv7uoshwLFoOBBxt+pdTzvdBBN2//CSdNpWIIsYmwg2dvQ/Ex
         DGIHYa91NfPNIMRutxQawEBgMJJ/Uiuwzvw3uywKGw6woRT6pn/3Ahn3P+Z6T2TeyFQO
         Ppyjx7DAmMPpsHvwz3sLNMoK2NaCu6+ORaml+9s1IDyjT4rT3TgAfZSFwYqAdqMSbYYN
         2+9Vsh/5639do0hlzWgfzGD/uoRDjLSKqZVFXUJZ3DA0qRRoPknbtrvawyODg9NF6xku
         RUcE7lVj4u1RpcIkFNZKfxGfkHcXvEi0608OrAGbYUH6zONN/xtob1pE65sPVDCkuZn7
         t3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXVK6dmsPKFlxVGsnju6Gmzr7jy3YZ4iKuNuKJOxdWw=;
        b=bG1zdkjxl4AYX7zo7a9y8VfINWUjDR58zvIyIKRRgWZL0s4H9krk0Kt1YQbmToVTto
         KnODPr8PwW+d09Bxt94OmCi0X+7JzQWArjU7S3qvCTaTbWg73Uf9UmH+b2TqFcRhTdp7
         iXUHuJ8CoyZH2DPEgFCFXp203wyTs1RB2QDSkmrx0unxQ/ctCdFnKxa15FXcaPaCJEWx
         +5kGS+bljjCa71gkusHVVNDsRCqaCKqMBoMF4zkqSuU3bkziofxld89+SzRBskglrm76
         1jNMKeANiAHjMqP4WmmE+Cmzp2N+AK/YcOVmY5lteLIAW9coD3Nj0t+OVPO59ehvpqMV
         lB5Q==
X-Gm-Message-State: AOAM533LNZMCZqIqii83T87Ygcqn1IqTyaI+QjwzEzZcGlQ4fTnBQWK5
        PW1sAWWLohM2tCAINmq8AbU=
X-Google-Smtp-Source: ABdhPJzk5jC8DWCQBqX+x/UEE4Ml4TK5R3j6VYfcijR+eC1lozRFL3EB2lxSBndsOMBtKoSQPka6UA==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr11781738wmk.69.1622993953117;
        Sun, 06 Jun 2021 08:39:13 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id 3sm14203074wmi.7.2021.06.06.08.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 08:39:12 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, wens@csie.org,
        maxime@cerno.tech, Drew Fustini <drew@beagleboard.org>,
        liush@allwinnertech.com,
        Wei Wu =?utf-8?B?KOWQtOS8nyk=?= <lazyparser@gmail.com>,
        wefu@redhat.com, linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH v2 11/11] riscv: soc: Allwinner D1 GMAC driver only for temp use
Date:   Sun, 06 Jun 2021 17:39:09 +0200
Message-ID: <49182865.cm8dGOVcTj@jernej-laptop>
In-Reply-To: <CAJF2gTQgaJFW9knuVmW8J8zMAt_Gtq3KJ9gsGKg6=xLBuq0=uA@mail.gmail.com>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org> <20210606115027.5c715e64@slackpad.fritz.box> <CAJF2gTQgaJFW9knuVmW8J8zMAt_Gtq3KJ9gsGKg6=xLBuq0=uA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

Dne nedelja, 06. junij 2021 ob 17:32:22 CEST je Guo Ren napisal(a):
>  ,
> 
> On Sun, Jun 6, 2021 at 6:50 PM Andre Przywara <andre.przywara@arm.com> 
wrote:
> > On Sun,  6 Jun 2021 09:04:09 +0000
> > guoren@kernel.org wrote:
> > 
> > Hi,
> > 
> > > From: liush <liush@allwinnertech.com>
> > > 
> > > This is a temporary driver, only guaranteed to work on allwinner
> > > D1. In order to ensure the developer's demand for network usage.
> > 
> > That looks like some Allwinner BSP driver, please don't endorse code
> > of this quality (just look at all that commented code and the attempt
> > for compile-time configuration).
> > 
> > > It only could work at 1Gps mode.
> > > 
> > > The correct gmac driver should follow (I guess)
> > > drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > > 
> > > If anyone is familiar with it and can help porting, I would be
> > > very grateful.
> > 
> > Have you tried compiling and using that driver? Ideally it should just
> > work, Linux drivers are meant to be portable, by design. And the driver
> > is already enabled by COMPILE_TEST.
> 
> It still needs some work with dwmac-sun8i.c glue layer, eg:
> tx/rx-delay setting, clk & pinmux drivers.
> 
> The patch is just to help people using D1 with GMAC temporarily with
> network function.

It should be marked "DO NOT MERGE" or similar then.

Best regards,
Jernej

> 
> > But I guess you need some extra care to make the non-coherent DMA work?
> > I haven't looked in detail, but are those new CMOs hooked into the
> > generic DMA framework?
> 
> Yes, we have the simliar principle with arm & csky for non-coherent:
>  - Using PTE attributes setting Using PTE attributes to support
> _PAGE_IOREMAP & _PAGE_WRITECOMBINE
>  - Using CMO instructions deal SYNC_DMA_FOR_CPU/DEVICE.
> 
> > Cheers,
> > Andre
> > 
> > > Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> > > Tested-by: Guo Ren <guoren@kernel.org>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Corentin Labbe <clabbe@baylibre.com>
> > > Cc: Samuel Holland <samuel@sholland.org>
> > > Cc: Icenowy Zheng <icenowy@aosc.io>
> > > Cc: LABBE Corentin <clabbe.montjoie@gmail.com>
> > > Cc: Michael Walle <michael@walle.cc>
> > > Cc: Chen-Yu Tsai <wens@csie.org>
> > > Cc: Maxime Ripard <maxime@cerno.tech>
> > > Cc: Wei Fu <wefu@redhat.com>
> > > Cc: Wei Wu <lazyparser@gmail.com>
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>



