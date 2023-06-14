Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7D73024B
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjFNOtc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 10:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245405AbjFNOtU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 10:49:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4942D1BF7
        for <linux-arch@vger.kernel.org>; Wed, 14 Jun 2023 07:49:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b3f66dda65so12646055ad.1
        for <linux-arch@vger.kernel.org>; Wed, 14 Jun 2023 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1686754158; x=1689346158;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKRPE21e3VYfChpFhohDRbV1xWyVB/8sEvcGY/fQRtY=;
        b=StLoc1kVQd8T9vYMLq0d7MyCHvxTL+0SIFZNTaA2rIaV3Q3TxJP1T2XFTGwcKZ7Bso
         bjLkgFqON00qrD7vOcMG2nwP2tUTvOQC4Qz+ruaJSoRXbMJ8zekx905259Ej/nz/EsDh
         ppaseEAxZUyq3/AJ/WiMvkfPVXRbf8FWxpP33b0SXtob2sIropYCCwdhc+4pBSpIR7Hp
         do+JfGRUQu+3phZg888rY2sShfFKoC/S+D6mwXll2Km/ak94SKgD02sGR4eBQRi1q5eU
         0uKI5zn0olHna/hKqL7AjcqQslXL5DgkUMsAAcmPmvkqOMBYQ3pjbXd60iDL6i/lfIfm
         xbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686754158; x=1689346158;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKRPE21e3VYfChpFhohDRbV1xWyVB/8sEvcGY/fQRtY=;
        b=ZF5maw4axDQm3D+lurPzdEPS2wc/4hNp3GesqV8N6vID6GDgxSq+FjGID94RAsUyHi
         gQws260SMoKxY+h1PNquoGjRVEBiid7o4+4qZ+yNELSYURZnCHBEnFvQsyAlFq4zWfxz
         ovWTTQanuDqe4/AxFdvjVUPVJEfa4k9p5ecuvFDc1V5O1pNs+E0d3ZYB5oA55G+4fhe3
         z/b9RgsQ824LlFtG1W18SnVceLT0uvOXaAJAQmoG9pL1vKm6bSc4lFMuivI6yUcG2x0v
         UKLTXaZkd1pz+e5XZHUoT1ln2htD8vm0+1/qddEM8C1shbxLQhke3pGPjnvED603Fwk0
         m2yA==
X-Gm-Message-State: AC+VfDw+v+jBWWgiCiGhta5kGeGA4JCiICZX3Xjn04SbwXOGzmdPbzxb
        LGj6UtsvIjx/Gw0hgwklkyx4Ng==
X-Google-Smtp-Source: ACHHUZ76y61nmrxgu/6Uj1VU/Fx1+aYmcHGqSELnwIIfd1gkpGJDnTmM8AnZnj0eFQIjXvfyvmNj0Q==
X-Received: by 2002:a17:903:32d1:b0:1af:cbb1:845 with SMTP id i17-20020a17090332d100b001afcbb10845mr16027525plr.16.1686754158383;
        Wed, 14 Jun 2023 07:49:18 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001b3d7205401sm5552790plb.303.2023.06.14.07.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:49:17 -0700 (PDT)
Date:   Wed, 14 Jun 2023 07:49:17 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Jun 2023 07:49:15 PDT (-0700)
Subject:     Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <20230523165502.2592-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-4483745f-f356-454c-8c2a-5f0e5b6c9739@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 23 May 2023 09:54:58 PDT (-0700), jszhang@kernel.org wrote:
> When trying to run linux with various opensource riscv core on
> resource limited FPGA platforms, for example, those FPGAs with less
> than 16MB SDRAM, I want to save mem as much as possible. One of the
> major technologies is kernel size optimizations, I found that riscv
> does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION, which
> passes -fdata-sections, -ffunction-sections to CFLAGS and passes the
> --gc-sections flag to the linker.
>
> This not only benefits my case on FPGA but also benefits defconfigs.
> Here are some notable improvements from enabling this with defconfigs:
>
> nommu_k210_defconfig:
>    text    data     bss     dec     hex
> 1112009  410288   59837 1582134  182436     before
>  962838  376656   51285 1390779  1538bb     after
>
> rv32_defconfig:
>    text    data     bss     dec     hex
> 8804455 2816544  290577 11911576 b5c198     before
> 8692295 2779872  288977 11761144 b375f8     after
>
> defconfig:
>    text    data     bss     dec     hex
> 9438267 3391332  485333 13314932 cb2b74     before
> 9285914 3350052  483349 13119315 c82f53     after
>
> patch1 and patch2 are clean ups.
> patch3 fixes a typo.
> patch4 finally enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION for riscv.
>
> NOTE: Zhangjin Wu firstly sent out a patch to enable dead code
> elimination for riscv several months ago, I didn't notice it until
> yesterday. Although it missed some preparations and some sections's
> keeping, he is the first person to enable this feature for riscv. To
> ease merging, this series take his patch into my entire series and
> makes patch4 authored by him after getting his ack to reflect
> the above fact.
>
> Since v1:
>   - collect Reviewed-by, Tested-by tag
>   - Make patch4 authored by Zhangjin Wu, add my co-developed-by tag
>
> Jisheng Zhang (3):
>   riscv: move options to keep entries sorted
>   riscv: vmlinux-xip.lds.S: remove .alternative section
>   vmlinux.lds.h: use correct .init.data.* section name
>
> Zhangjin Wu (1):
>   riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>
>  arch/riscv/Kconfig                  |  13 +-
>  arch/riscv/kernel/vmlinux-xip.lds.S |   6 -
>  arch/riscv/kernel/vmlinux.lds.S     |   6 +-
>  include/asm-generic/vmlinux.lds.h   |   2 +-
>  4 files changed, 11 insertions(+), 16 deletions(-)

Do you have a base commit for this?  It's not applying to 6.4-rc1 and 
the patchwork bot couldn't find one either.
