Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB3039D001
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 18:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFFQbs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhFFQbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 12:31:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD187C061766;
        Sun,  6 Jun 2021 09:29:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso295088wms.1;
        Sun, 06 Jun 2021 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxkRqzdPS7sAeenmAuAvXZNGk/e4PdC5sUpAPxYKCMA=;
        b=n4gGZKDBFX45+p0Oca5kJ8IwxlnU0aUbBahQijaeb3j27qEE2IJahLAUPVrStQRjQx
         dbCgI70DMtLse1Z+A8cRbAStEDKVKP0sIsZubxQt6Ui1PLFahD7lZQwp0l82/s9rMYf/
         sQqgxc2oWrAyAyWdmMCBIyURlyTplSYS8R+Vy9OzAn3yba4lsIan869Eefdd2d4556n8
         zWb2+dl0SKmLtwSDBr+DC9P2ieoeKmvFGy9F5feO+oOtbGOlD1RyBFojHSZJyLYdTe7Q
         mdelZj99XyiwcT3twseJY++oUXVzEE7vhFN+vPeTbD8Dl0Lel50cnxhMtP1J/cgIEU4d
         HRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxkRqzdPS7sAeenmAuAvXZNGk/e4PdC5sUpAPxYKCMA=;
        b=K9mkLSAVWrrwybhUcLA8omOzCOKmPHmkGFWy0f3GYPMcLJKbscndtGd2oYCHaRgWt8
         XRakGShpJVkXfzHuDu/QmU3geduuP8yRjQHvgPlTbPw5pICtwyV+fERPQeDelyhcusTY
         PJWSYOuEai4F4BrH4N0QsSORS3dueBcpUgz5/EUAW0GuI41u35tsyvLbk5P0OJ5ATAVg
         HpdJrrwADdD6bCm3Rn8wrQyeC3PNGhvOf3bKDeCQG3SmGn4iMoQ4R+zAA+GhM2919nUo
         p2uU+7+/yUIG0ec+a/jOpvpWiu3jvYsySA4ihRr51+xeMAppBQzgJ+lld1zJJKxQaoLV
         1cAw==
X-Gm-Message-State: AOAM532gKGzpF8S3V987NcuCCmZdrowX3Db2Clu3Vu9TnSFtX1OC53gp
        jYHXJ7TBRJUaw8FfDhjORZ1hdlPR+xJ45A==
X-Google-Smtp-Source: ABdhPJyrscID/EgtH33p7P2vPcGxNXzPY1ijc8FmSRl2qmAONrX/E6TS55YTH52Ls7/wzKf9m0odbw==
X-Received: by 2002:a1c:6503:: with SMTP id z3mr13027277wmb.72.1622996979205;
        Sun, 06 Jun 2021 09:29:39 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id g21sm14000384wrb.46.2021.06.06.09.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 09:29:38 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com, guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH v2 00/11] riscv: Add DMA_COHERENT support for Allwinner D1
Date:   Sun, 06 Jun 2021 18:29:37 +0200
Message-ID: <3110420.cQCZQDpDj9@jernej-laptop>
In-Reply-To: <1622970249-50770-1-git-send-email-guoren@kernel.org>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

Dne nedelja, 06. junij 2021 ob 11:03:55 CEST je guoren@kernel.org napisal(a):
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The RISC-V ISA doesn't yet specify how to query or modify PMAs, so let
> vendors define the custom properties of memory regions in PTE.
> 
> This patchset helps SOC vendors to support their own custom interconnect
> coherent solution with PTE attributes.
> 
> For example, allwinner D1[1] uses T-HEAD C906 as main processor, C906 has
> two modes in MMU:
>  - Compatible mode, the same as the definitions in spec.
>  - Enhanced mode, add custom DMA_COHERENT attribute bits in PTE which
>    not mentioned in spec.
> 
> Allwinner D1 needs the enhanced mode to support the DMA type device with
> non-coherent interconnect in its SOC. C906 uses BITS(63 - 59) as custom
> attribute bits in PTE.
> 
> The patchset contain 4 parts (asid, pgtable, cmo, soc) which have been
> tested on D1:
>  - asid: T-HEAD C906 of D1 contains full asid hw facilities which has no
>    conflict with RISC-V spec, and hope these patches soon could be
>    approved.
>  - pgtable: Using a image-hdr to pass vendor specific information and
>    setup custom PTE attributes in a global struct variable during boot
>    stage. Also it needs define custom protection_map in linux/mm.
>  - cmo: We need deal with dma_sync & icache_sync & __vdso_icache_sync.
>    In this patchset, I just show you how T-HEAD C9xx work, and seems Atish
>    is working for the DMA infrustructure, please let me know the idea.
>  - soc: Add allwinner gmac driver & dts & Kconfig for sunxi test.
> 
> The patchset could work with linux-5.13-rc4, here is the steps for D1:
>  - Download linux-5.13-rc4 and apply the patchset
>  - make ARCH=riscv CROSS_COMPILE=riscv64-linux- defconfig
>  - make ARCH=riscv CROSS_COMPILE=riscv64-linux- Image modules dtbs
>  - mkimage -A riscv -O linux -T kernel -C none -a 0x00200000 -e 0x00200000
> -n Linux -d arch/riscv/boot/Image uImage - Download newest opensbi [2],
> build with [3], and get fw_dynamic.bin - Copy uImage, fw_dynamic.bin,
> allwinner-d1-nezha-kit.dtb into boot partition of TF card.
>  - Plugin the TF card and power on D1.
> 
> Link: https://linux-sunxi.org/D1 [1]
> Link: https://github.com/riscv/opensbi branch:master [2]
> Link:
> https://github.com/riscv/opensbi/blob/master/docs/platform/thead-c9xx.md
> [3]
> 

Some patches are marked with v2 and some V5. It's very confusing. Mark them 
with same version in next revision.

Best regards,
Jernej

> Changes since v1:
>  - Rebase on linux-5.13-rc4
>  - Support defconfig for different PTE attributes
>  - Support C906 icache_sync
>  - Add Allwinner D1 dts & Kconfig & gmac for testing
>  - Add asid optimization for D1 usage
> 
> Guo Ren (10):
>   riscv: asid: Use global mappings for kernel pages
>   riscv: asid: Add ASID-based tlbflushing methods
>   riscv: asid: Optimize tlbflush coding convention
>   riscv: pgtable: Fixup _PAGE_CHG_MASK usage
>   riscv: pgtable: Add custom protection_map init
>   riscv: pgtable: Add DMA_COHERENT with custom PTE attributes
>   riscv: cmo: Add dma-noncoherency support
>   riscv: cmo: Add vendor custom icache sync
>   riscv: soc: Initial DTS for Allwinner D1 NeZha board
>   riscv: soc: Add Allwinner SoC kconfig option
> 
> liush (1):
>   riscv: soc: Allwinner D1 GMAC driver only for temp use
> 
>  arch/riscv/Kconfig                                 |    9 +
>  arch/riscv/Kconfig.socs                            |   12 +
>  arch/riscv/boot/dts/Makefile                       |    1 +
>  arch/riscv/boot/dts/allwinner/Makefile             |    2 +
>  .../boot/dts/allwinner/allwinner-d1-nezha-kit.dts  |   29 +
>  arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi    |  100 +
>  arch/riscv/configs/defconfig                       |    1 +
>  arch/riscv/include/asm/cacheflush.h                |   48 +-
>  arch/riscv/include/asm/mmu_context.h               |    2 +
>  arch/riscv/include/asm/pgtable-64.h                |    8 +-
>  arch/riscv/include/asm/pgtable-bits.h              |   20 +-
>  arch/riscv/include/asm/pgtable.h                   |   44 +-
>  arch/riscv/include/asm/sbi.h                       |   15 +
>  arch/riscv/include/asm/soc.h                       |    1 +
>  arch/riscv/include/asm/tlbflush.h                  |   22 +
>  arch/riscv/include/asm/vendorid_list.h             |    1 +
>  arch/riscv/kernel/sbi.c                            |   19 +
>  arch/riscv/kernel/soc.c                            |   22 +
>  arch/riscv/kernel/vdso/flush_icache.S              |   33 +-
>  arch/riscv/mm/Makefile                             |    1 +
>  arch/riscv/mm/cacheflush.c                         |    3 +-
>  arch/riscv/mm/context.c                            |    2 +-
>  arch/riscv/mm/dma-mapping.c                        |   53 +
>  arch/riscv/mm/init.c                               |   26 +
>  arch/riscv/mm/tlbflush.c                           |   57 +-
>  drivers/net/ethernet/Kconfig                       |    1 +
>  drivers/net/ethernet/Makefile                      |    1 +
>  drivers/net/ethernet/allwinnertmp/Kconfig          |   17 +
>  drivers/net/ethernet/allwinnertmp/Makefile         |    7 +
>  drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c |  690 ++++++
>  drivers/net/ethernet/allwinnertmp/sunxi-gmac.c     | 2240
> ++++++++++++++++++++ drivers/net/ethernet/allwinnertmp/sunxi-gmac.h     | 
> 258 +++
>  drivers/net/phy/realtek.c                          |    2 +-
>  mm/mmap.c                                          |    4 +
>  34 files changed, 3714 insertions(+), 37 deletions(-)
>  create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
>  create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi create
> mode 100644 arch/riscv/mm/dma-mapping.c
>  create mode 100644 drivers/net/ethernet/allwinnertmp/Kconfig
>  create mode 100644 drivers/net/ethernet/allwinnertmp/Makefile
>  create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c
>  create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac.c
>  create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac.h




