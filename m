Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922E15F2606
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 00:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJBWp3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 2 Oct 2022 18:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJBWp1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 2 Oct 2022 18:45:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA68822BEF;
        Sun,  2 Oct 2022 15:45:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so13759420pjs.1;
        Sun, 02 Oct 2022 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=hTl+pyY12f3DZxyUqnMSkcg5Alz1/QdlswdwOgdvgGk=;
        b=XItK+i7/HHci/1wBFZFyGwYWT2B91gu7BuaV3mRqEMPRoXYrcBnpcqKi23LUK4/1j4
         Z+xWpx3f0QM7q5q/w8zc6ls9iGpj/Q7bVIWz7VyZoyN3CfpUunLP8KslF7KvgLCUfSDE
         +kYMQFIwDVxI6C4jJlSPDr8oA/T/xNcwijpIqbzLzHqAm2KWG1W2jbe2Bd4krpv4Mbjq
         W7HLeqJ3INfBp2DjKHH3ut2jdD6bUbDyR4k3v6uzL0LKMDt2b7clroFdda89W/fg1EpV
         xzr3xbAXANE7O+xsyTfo/qhN7IfFUMb+/r2as/EIep+c14/5M+ioEdecitSMCP9bhHjP
         l+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hTl+pyY12f3DZxyUqnMSkcg5Alz1/QdlswdwOgdvgGk=;
        b=vTHcZiJo9RTQn45EleJ2arnUNi4e897AZaYlYRqZU/jzUoTgBnbbfu+LwlCA3ZUPXu
         7sXn3m0MNFHqBWA+6eOcdRfV8oDwgQWuPDp/zmf2EnRmzF3d+g1Sv9f1i8/tmqOAK8qh
         8rRumw/CjUr5kvegljCz5xCnxYPUmKRNroSgXZ9OUQszEjuZcg9g1fFmlBy90EkwzDiN
         QLGPYvO/3llre6yMQ/9VepiJsIDPS57dTdLFoI4Y6RQmRQLgwZLgYFHzdoANC9dKKtZc
         cwXIFowucACQmbLty2KltF4v9CNkpW8Z3qcqxuu1V9mlta9gIKCp5OFGRTMtwdReNf7f
         FsOA==
X-Gm-Message-State: ACrzQf0PMfLaiaugUW7UI6Kon2AfIAipHGUkYuTaq8YRmmOwsTI+GuwD
        nB+BdUvCFv6CuKxudQKlgCkPEZmKHKJcIQ==
X-Google-Smtp-Source: AMsMyM6W5QLuMgH75IkaviUYdJedBOHtfRaIhto/pGd+YnZZC/1KBjCHoBb2PtzhkdEC3gmrkuxprg==
X-Received: by 2002:a17:902:c205:b0:178:5083:f656 with SMTP id 5-20020a170902c20500b001785083f656mr19309554pll.81.1664750724254;
        Sun, 02 Oct 2022 15:45:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r13-20020a63204d000000b00438b79c7049sm5326429pgm.42.2022.10.02.15.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 15:45:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 2 Oct 2022 15:45:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] alpha: Use generic <asm-generic/io.h>
Message-ID: <20221002224521.GA968453@roeck-us.net>
References: <20220818092059.103884-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818092059.103884-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 18, 2022 at 11:20:59AM +0200, Linus Walleij wrote:
> This enables the alpha to use <asm-generic/io.h> to fill in the
> missing (undefined) I/O accessor functions.
> 
> This is needed if Alpha ever wants to uses CONFIG_REGMAP_MMIO
> which has been patches to use accelerated _noinc accessors
> such as readsq/writesq that Alpha, while being a 64bit platform,
> as of now not yet provide. readq/writeq is however provided
> so the machine can do 64bit I/O.
> 
> This comes with the requirement that everything the architecture
> already provides needs to be defined, rather than just being,
> say, static inline functions.
> 
> Bite the bullet and just provide the definitions and make it work.
> 
> Alternative approaches:
> 
> - Implement proper readsq/writesq inline accessors for alpha
> - Rewrite the whole world of io.h to use something like __weak
>   instead of relying on defines
> - Leave regmap MMIO broken on Alpha because none of its drivers
>   use it
> - Make regmap MMIO depend of !ARCH_ALPHA
> 
> The latter seems a bit over the top. First option to implement
> readsq/writesq seems possible but I cannot test it (no hardware)
> so using the generic fallbacks seems like a better idea, also in
> general that will provide future defaults for accelerated defines.
> 
> Leaving regmap MMIO broken or disabling it for Alpha feels bad
> because it breaks compiler coverage.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-mm/202208181447.G9FLcMkI-lkp@intel.com/
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This patch results in the following build errors when trying to build
alpha:allmodconfig.

ERROR: modpost: "ioread64" [drivers/pci/switch/switchtec.ko] undefined!
ERROR: modpost: "ioread64" [drivers/net/ethernet/freescale/enetc/fsl-enetc.ko] undefined!
ERROR: modpost: "ioread64" [drivers/net/ethernet/freescale/enetc/fsl-enetc-vf.ko] undefined!
ERROR: modpost: "iowrite64" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!
ERROR: modpost: "iowrite64" [drivers/net/wwan/t7xx/mtk_t7xx.ko] undefined!
ERROR: modpost: "ioread64" [drivers/net/wwan/t7xx/mtk_t7xx.ko] undefined!
ERROR: modpost: "iowrite64" [drivers/firmware/arm_scmi/scmi-module.ko] undefined!
ERROR: modpost: "ioread64" [drivers/firmware/arm_scmi/scmi-module.ko] undefined!
ERROR: modpost: "iowrite64" [drivers/vfio/pci/vfio-pci-core.ko] undefined!
ERROR: modpost: "ioread64" [drivers/ntb/hw/mscc/ntb_hw_switchtec.ko] undefined!

Reverting it doesn't help because that just reintroduces the problem
that was supposed to be fixed by this patch.

Guenter
