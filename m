Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3DA77E3A6
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbjHPOcx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 10:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343631AbjHPOct (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 10:32:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7BF270A
        for <linux-arch@vger.kernel.org>; Wed, 16 Aug 2023 07:32:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68876bbecb6so1066301b3a.1
        for <linux-arch@vger.kernel.org>; Wed, 16 Aug 2023 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1692196362; x=1692801162;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/SYmXlzqLpIxQ0GeSbsbj9HuUwWG7ePoCeIzMe/+uE=;
        b=xDamK0ZpvWog6LhNyohHjBdSZuQRwkuOpR+yg3gStZge1sDojHGiXQHcqF5vU6Jols
         79js5afxths5NMiWBdnvFlESPRAHMwVuDJCj9v4KWgQyP8zkHqDJ4Z2UUccB5D4726bF
         v9eLG/0HTXGrJreWdgRjONrqyQ0923yLmYM2guGGM2bdwPS+SPweStDqmND4vpNWcZ5d
         md7NL5ndSfSQoTH+KjaMrxHGYkNCQ4KO/VxizGwSeqgQqRYxFgEmsDHOenUVg0f70dcm
         xXTTI1zlqo47IQEwtqGxUh43KynoPvBMkuCzYik2jD8MY9mAoqvJroPQVWIjtkj258a9
         HD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692196362; x=1692801162;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/SYmXlzqLpIxQ0GeSbsbj9HuUwWG7ePoCeIzMe/+uE=;
        b=g3HRL5D556kdnF0kNV8mj+syHrSAVKRRcGmJimHlcJ3AWs6pHmLxPhkoKi+93L9rbE
         TbfUH3HBxOk0JT0V7NV0QiyRTZKXJpfMeWgGZRyNp8ZdsJ3P77NPzoDKs+m5XfIYZPhY
         E3Uk+GrbQzBb0+6jf8mz9uKMf4P65Wi1coiRIcMser3XppzZAU5mGEtlL3BP2QWhaPPn
         hbxnVP7FWUhQ5Ogq69zJDGavp2Rr6qHQixfXohRjO7g59foIqShiIKhClhb0c/Yuh11m
         fbAw+GF8kgtClRSByT4WsfCixnPfLJNNnMMsJIeEKT6VYnVjT9cYEN70M58H44g1wzHE
         /+KA==
X-Gm-Message-State: AOJu0YxSdLAlTLdm0Sg6WpQjqSoRL9UvIrevm2+eb0bIISmIW/W9MeMF
        2Nnyum1ypvvCkj9L4pXwyiCInQ==
X-Google-Smtp-Source: AGHT+IEOviedvo31A8p1d5RyMSJ5+vbrte6xlO74lWIyNvGeAmRdJRlCv1DTo+zNgkhzpqBz+t/rOA==
X-Received: by 2002:a05:6a20:3246:b0:13f:3d25:d83 with SMTP id hm6-20020a056a20324600b0013f3d250d83mr1924733pzc.19.1692196361587;
        Wed, 16 Aug 2023 07:32:41 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id n26-20020a638f1a000000b00565009a97f0sm11924990pgd.17.2023.08.16.07.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:32:40 -0700 (PDT)
Date:   Wed, 16 Aug 2023 07:32:40 -0700 (PDT)
X-Google-Original-Date: Wed, 16 Aug 2023 07:32:39 PDT (-0700)
Subject:     Re: [PATCH] treewide: drop CONFIG_EMBEDDED
In-Reply-To: <20230816055010.31534-1-rdunlap@infradead.org>
CC:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Jason@zx2c4.com,
        wireguard@lists.zx2c4.com, linux-arch@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, vgupta@kernel.org,
        bcain@quicinc.com, linux-hexagon@vger.kernel.org,
        gerg@linux-m68k.org, geert@linux-m68k.org,
        linux-m68k@lists.linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        linux-openrisc@vger.kernel.org, linux-mips@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, linux-sh@vger.kernel.org,
        jcmvbkbc@gmail.com, josh@joshtriplett.org, masahiroy@kernel.org,
        linux-kbuild@vger.kernel.org, akpm@linux-foundation.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-80e4aa94-a825-4aca-a7da-47a57b7d9958@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 15 Aug 2023 22:50:10 PDT (-0700), rdunlap@infradead.org wrote:
> There is only one Kconfig user of CONFIG_EMBEDDED and it can be
> switched to EXPERT or "if !ARCH_MULTIPLATFORM" (suggested by Arnd).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: wireguard@lists.zx2c4.com
> Cc: linux-arch@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Brian Cain <bcain@quicinc.com>
> Cc: linux-hexagon@vger.kernel.org
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: linux-openrisc@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  arch/arc/configs/axs101_defconfig                    |    2 +-
>  arch/arc/configs/axs103_defconfig                    |    2 +-
>  arch/arc/configs/axs103_smp_defconfig                |    2 +-
>  arch/arc/configs/haps_hs_smp_defconfig               |    2 +-
>  arch/arc/configs/hsdk_defconfig                      |    2 +-
>  arch/arc/configs/nsim_700_defconfig                  |    2 +-
>  arch/arc/configs/nsimosci_defconfig                  |    2 +-
>  arch/arc/configs/nsimosci_hs_defconfig               |    2 +-
>  arch/arc/configs/tb10x_defconfig                     |    2 +-
>  arch/arc/configs/vdk_hs38_defconfig                  |    2 +-
>  arch/arc/configs/vdk_hs38_smp_defconfig              |    2 +-
>  arch/arm/Kconfig                                     |    2 +-
>  arch/arm/configs/aspeed_g4_defconfig                 |    2 +-
>  arch/arm/configs/aspeed_g5_defconfig                 |    2 +-
>  arch/arm/configs/at91_dt_defconfig                   |    2 +-
>  arch/arm/configs/axm55xx_defconfig                   |    2 +-
>  arch/arm/configs/bcm2835_defconfig                   |    2 +-
>  arch/arm/configs/clps711x_defconfig                  |    2 +-
>  arch/arm/configs/keystone_defconfig                  |    2 +-
>  arch/arm/configs/lpc18xx_defconfig                   |    2 +-
>  arch/arm/configs/lpc32xx_defconfig                   |    2 +-
>  arch/arm/configs/milbeaut_m10v_defconfig             |    2 +-
>  arch/arm/configs/moxart_defconfig                    |    2 +-
>  arch/arm/configs/multi_v4t_defconfig                 |    2 +-
>  arch/arm/configs/multi_v7_defconfig                  |    2 +-
>  arch/arm/configs/pxa_defconfig                       |    2 +-
>  arch/arm/configs/qcom_defconfig                      |    2 +-
>  arch/arm/configs/sama5_defconfig                     |    2 +-
>  arch/arm/configs/sama7_defconfig                     |    2 +-
>  arch/arm/configs/socfpga_defconfig                   |    2 +-
>  arch/arm/configs/stm32_defconfig                     |    2 +-
>  arch/arm/configs/tegra_defconfig                     |    2 +-
>  arch/arm/configs/vf610m4_defconfig                   |    2 +-
>  arch/hexagon/configs/comet_defconfig                 |    2 +-
>  arch/m68k/configs/amcore_defconfig                   |    2 +-
>  arch/m68k/configs/m5475evb_defconfig                 |    2 +-
>  arch/m68k/configs/stmark2_defconfig                  |    2 +-
>  arch/microblaze/configs/mmu_defconfig                |    2 +-
>  arch/mips/configs/ath25_defconfig                    |    2 +-
>  arch/mips/configs/ath79_defconfig                    |    2 +-
>  arch/mips/configs/bcm47xx_defconfig                  |    2 +-
>  arch/mips/configs/ci20_defconfig                     |    2 +-
>  arch/mips/configs/cu1000-neo_defconfig               |    2 +-
>  arch/mips/configs/cu1830-neo_defconfig               |    2 +-
>  arch/mips/configs/db1xxx_defconfig                   |    2 +-
>  arch/mips/configs/gcw0_defconfig                     |    2 +-
>  arch/mips/configs/generic_defconfig                  |    2 +-
>  arch/mips/configs/loongson2k_defconfig               |    2 +-
>  arch/mips/configs/loongson3_defconfig                |    2 +-
>  arch/mips/configs/malta_qemu_32r6_defconfig          |    2 +-
>  arch/mips/configs/maltaaprp_defconfig                |    2 +-
>  arch/mips/configs/maltasmvp_defconfig                |    2 +-
>  arch/mips/configs/maltasmvp_eva_defconfig            |    2 +-
>  arch/mips/configs/maltaup_defconfig                  |    2 +-
>  arch/mips/configs/omega2p_defconfig                  |    2 +-
>  arch/mips/configs/pic32mzda_defconfig                |    2 +-
>  arch/mips/configs/qi_lb60_defconfig                  |    2 +-
>  arch/mips/configs/rs90_defconfig                     |    2 +-
>  arch/mips/configs/rt305x_defconfig                   |    2 +-
>  arch/mips/configs/vocore2_defconfig                  |    2 +-
>  arch/mips/configs/xway_defconfig                     |    2 +-
>  arch/nios2/configs/10m50_defconfig                   |    2 +-
>  arch/nios2/configs/3c120_defconfig                   |    2 +-
>  arch/openrisc/configs/or1klitex_defconfig            |    2 +-
>  arch/powerpc/configs/40x/klondike_defconfig          |    2 +-
>  arch/powerpc/configs/44x/fsp2_defconfig              |    2 +-
>  arch/powerpc/configs/52xx/tqm5200_defconfig          |    2 +-
>  arch/powerpc/configs/mgcoge_defconfig                |    2 +-
>  arch/powerpc/configs/microwatt_defconfig             |    2 +-
>  arch/powerpc/configs/ps3_defconfig                   |    2 +-
>  arch/riscv/configs/nommu_k210_defconfig              |    2 +-
>  arch/riscv/configs/nommu_k210_sdcard_defconfig       |    2 +-

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V

>  arch/sh/configs/rsk7264_defconfig                    |    2 +-
>  arch/sh/configs/rsk7269_defconfig                    |    2 +-
>  arch/xtensa/configs/cadence_csp_defconfig            |    2 +-
>  init/Kconfig                                         |    8 --------
>  kernel/configs/tiny-base.config                      |    2 +-
>  tools/testing/selftests/wireguard/qemu/kernel.config |    1 -
>  78 files changed, 76 insertions(+), 85 deletions(-)
>
> diff -- a/arch/arm/Kconfig b/arch/arm/Kconfig
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -250,7 +250,7 @@ config ARCH_MTD_XIP
>  	bool
>
>  config ARM_PATCH_PHYS_VIRT
> -	bool "Patch physical to virtual translations at runtime" if EMBEDDED
> +	bool "Patch physical to virtual translations at runtime" if !ARCH_MULTIPLATFORM
>  	default y
>  	depends on MMU
>  	help
> diff -- a/init/Kconfig b/init/Kconfig
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1790,14 +1790,6 @@ config DEBUG_RSEQ
>
>  	  If unsure, say N.
>
> -config EMBEDDED
> -	bool "Embedded system"
> -	select EXPERT
> -	help
> -	  This option should be enabled if compiling the kernel for
> -	  an embedded system so certain expert options are available
> -	  for configuration.
> -
>  config HAVE_PERF_EVENTS
>  	bool
>  	help
> diff -- a/arch/powerpc/configs/40x/klondike_defconfig b/arch/powerpc/configs/40x/klondike_defconfig
> --- a/arch/powerpc/configs/40x/klondike_defconfig
> +++ b/arch/powerpc/configs/40x/klondike_defconfig
> @@ -4,7 +4,7 @@ CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_SYSFS_DEPRECATED=y
>  CONFIG_SYSFS_DEPRECATED_V2=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  CONFIG_APM8018X=y
> diff -- a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
> --- a/arch/powerpc/configs/44x/fsp2_defconfig
> +++ b/arch/powerpc/configs/44x/fsp2_defconfig
> @@ -15,7 +15,7 @@ CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_RD_LZ4 is not set
>  CONFIG_KALLSYMS_ALL=y
>  CONFIG_BPF_SYSCALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PROFILING=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> diff -- a/arch/powerpc/configs/52xx/tqm5200_defconfig b/arch/powerpc/configs/52xx/tqm5200_defconfig
> --- a/arch/powerpc/configs/52xx/tqm5200_defconfig
> +++ b/arch/powerpc/configs/52xx/tqm5200_defconfig
> @@ -3,7 +3,7 @@ CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_KALLSYMS is not set
>  # CONFIG_EPOLL is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  CONFIG_MODVERSIONS=y
> diff -- a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
> --- a/arch/arc/configs/axs101_defconfig
> +++ b/arch/arc/configs/axs101_defconfig
> @@ -9,7 +9,7 @@ CONFIG_NAMESPACES=y
>  # CONFIG_UTS_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
> diff -- a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
> --- a/arch/arc/configs/axs103_defconfig
> +++ b/arch/arc/configs/axs103_defconfig
> @@ -9,7 +9,7 @@ CONFIG_NAMESPACES=y
>  # CONFIG_UTS_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
> diff -- a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
> --- a/arch/arc/configs/axs103_smp_defconfig
> +++ b/arch/arc/configs/axs103_smp_defconfig
> @@ -9,7 +9,7 @@ CONFIG_NAMESPACES=y
>  # CONFIG_UTS_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/arch/arc/configs/haps_hs_smp_defconfig b/arch/arc/configs/haps_hs_smp_defconfig
> --- a/arch/arc/configs/haps_hs_smp_defconfig
> +++ b/arch/arc/configs/haps_hs_smp_defconfig
> @@ -11,7 +11,7 @@ CONFIG_NAMESPACES=y
>  # CONFIG_UTS_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
> --- a/arch/arc/configs/hsdk_defconfig
> +++ b/arch/arc/configs/hsdk_defconfig
> @@ -9,7 +9,7 @@ CONFIG_NAMESPACES=y
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_BLK_DEV_RAM=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/arch/arc/configs/nsim_700_defconfig b/arch/arc/configs/nsim_700_defconfig
> --- a/arch/arc/configs/nsim_700_defconfig
> +++ b/arch/arc/configs/nsim_700_defconfig
> @@ -12,7 +12,7 @@ CONFIG_NAMESPACES=y
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/arch/arc/configs/nsimosci_defconfig b/arch/arc/configs/nsimosci_defconfig
> --- a/arch/arc/configs/nsimosci_defconfig
> +++ b/arch/arc/configs/nsimosci_defconfig
> @@ -11,7 +11,7 @@ CONFIG_NAMESPACES=y
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/arch/arc/configs/nsimosci_hs_defconfig b/arch/arc/configs/nsimosci_hs_defconfig
> --- a/arch/arc/configs/nsimosci_hs_defconfig
> +++ b/arch/arc/configs/nsimosci_hs_defconfig
> @@ -11,7 +11,7 @@ CONFIG_NAMESPACES=y
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
> --- a/arch/arc/configs/tb10x_defconfig
> +++ b/arch/arc/configs/tb10x_defconfig
> @@ -16,7 +16,7 @@ CONFIG_INITRAMFS_ROOT_GID=501
>  # CONFIG_RD_GZIP is not set
>  CONFIG_KALLSYMS_ALL=y
>  # CONFIG_AIO is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_ISA_ARCOMPACT=y
>  CONFIG_MODULES=y
> diff -- a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_hs38_defconfig
> --- a/arch/arc/configs/vdk_hs38_defconfig
> +++ b/arch/arc/configs/vdk_hs38_defconfig
> @@ -4,7 +4,7 @@ CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
> diff -- a/arch/arc/configs/vdk_hs38_smp_defconfig b/arch/arc/configs/vdk_hs38_smp_defconfig
> --- a/arch/arc/configs/vdk_hs38_smp_defconfig
> +++ b/arch/arc/configs/vdk_hs38_smp_defconfig
> @@ -4,7 +4,7 @@ CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
> diff -- a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
> --- a/arch/hexagon/configs/comet_defconfig
> +++ b/arch/hexagon/configs/comet_defconfig
> @@ -14,7 +14,7 @@ CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_LOG_BUF_SHIFT=18
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> diff -- a/arch/m68k/configs/amcore_defconfig b/arch/m68k/configs/amcore_defconfig
> --- a/arch/m68k/configs/amcore_defconfig
> +++ b/arch/m68k/configs/amcore_defconfig
> @@ -8,7 +8,7 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  # CONFIG_AIO is not set
>  # CONFIG_ADVISE_SYSCALLS is not set
>  # CONFIG_MEMBARRIER is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/arch/m68k/configs/m5475evb_defconfig b/arch/m68k/configs/m5475evb_defconfig
> --- a/arch/m68k/configs/m5475evb_defconfig
> +++ b/arch/m68k/configs/m5475evb_defconfig
> @@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=14
>  # CONFIG_EVENTFD is not set
>  # CONFIG_SHMEM is not set
>  # CONFIG_AIO is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_MODULES=y
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_COLDFIRE=y
> diff -- a/arch/m68k/configs/stmark2_defconfig b/arch/m68k/configs/stmark2_defconfig
> --- a/arch/m68k/configs/stmark2_defconfig
> +++ b/arch/m68k/configs/stmark2_defconfig
> @@ -9,7 +9,7 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  # CONFIG_AIO is not set
>  # CONFIG_ADVISE_SYSCALLS is not set
>  # CONFIG_MEMBARRIER is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_COLDFIRE=y
> diff -- a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
> --- a/arch/microblaze/configs/mmu_defconfig
> +++ b/arch/microblaze/configs/mmu_defconfig
> @@ -7,7 +7,7 @@ CONFIG_SYSFS_DEPRECATED=y
>  CONFIG_SYSFS_DEPRECATED_V2=y
>  # CONFIG_BASE_FULL is not set
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=1
>  CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR=1
>  CONFIG_XILINX_MICROBLAZE0_USE_BARREL=1
> diff -- a/arch/nios2/configs/10m50_defconfig b/arch/nios2/configs/10m50_defconfig
> --- a/arch/nios2/configs/10m50_defconfig
> +++ b/arch/nios2/configs/10m50_defconfig
> @@ -9,7 +9,7 @@ CONFIG_LOG_BUF_SHIFT=14
>  # CONFIG_EVENTFD is not set
>  # CONFIG_SHMEM is not set
>  # CONFIG_AIO is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  CONFIG_NIOS2_MEM_BASE=0x8000000
> diff -- a/arch/nios2/configs/3c120_defconfig b/arch/nios2/configs/3c120_defconfig
> --- a/arch/nios2/configs/3c120_defconfig
> +++ b/arch/nios2/configs/3c120_defconfig
> @@ -9,7 +9,7 @@ CONFIG_LOG_BUF_SHIFT=14
>  # CONFIG_EVENTFD is not set
>  # CONFIG_SHMEM is not set
>  # CONFIG_AIO is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  CONFIG_NIOS2_MEM_BASE=0x10000000
> diff -- a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
> --- a/arch/openrisc/configs/or1klitex_defconfig
> +++ b/arch/openrisc/configs/or1klitex_defconfig
> @@ -6,7 +6,7 @@ CONFIG_USER_NS=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_SGETMASK_SYSCALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_OPENRISC_BUILTIN_DTB="or1klitex"
>  CONFIG_HZ_100=y
>  CONFIG_OPENRISC_HAVE_SHADOW_GPRS=y
> diff -- a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/mgcoge_defconfig
> --- a/arch/powerpc/configs/mgcoge_defconfig
> +++ b/arch/powerpc/configs/mgcoge_defconfig
> @@ -9,7 +9,7 @@ CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_RD_GZIP is not set
>  CONFIG_KALLSYMS_ALL=y
>  # CONFIG_PCSPKR_PLATFORM is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PARTITION_ADVANCED=y
>  # CONFIG_PPC_PMAC is not set
>  CONFIG_PPC_82xx=y
> diff -- a/arch/powerpc/configs/microwatt_defconfig b/arch/powerpc/configs/microwatt_defconfig
> --- a/arch/powerpc/configs/microwatt_defconfig
> +++ b/arch/powerpc/configs/microwatt_defconfig
> @@ -8,7 +8,7 @@ CONFIG_CGROUPS=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
> --- a/arch/powerpc/configs/ps3_defconfig
> +++ b/arch/powerpc/configs/ps3_defconfig
> @@ -3,7 +3,7 @@ CONFIG_POSIX_MQUEUE=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_PERF_EVENTS is not set
>  CONFIG_PROFILING=y
>  CONFIG_PPC64=y
> diff -- a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
> --- a/arch/riscv/configs/nommu_k210_defconfig
> +++ b/arch/riscv/configs/nommu_k210_defconfig
> @@ -21,7 +21,7 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  # CONFIG_IO_URING is not set
>  # CONFIG_ADVISE_SYSCALLS is not set
>  # CONFIG_KALLSYMS is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_SLUB=y
> diff -- a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> @@ -13,7 +13,7 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  # CONFIG_IO_URING is not set
>  # CONFIG_ADVISE_SYSCALLS is not set
>  # CONFIG_KALLSYMS is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_SLUB=y
> diff -- a/arch/sh/configs/rsk7264_defconfig b/arch/sh/configs/rsk7264_defconfig
> --- a/arch/sh/configs/rsk7264_defconfig
> +++ b/arch/sh/configs/rsk7264_defconfig
> @@ -9,7 +9,7 @@ CONFIG_SYSFS_DEPRECATED=y
>  CONFIG_SYSFS_DEPRECATED_V2=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_COUNTERS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  CONFIG_MMAP_ALLOW_UNINITIALIZED=y
> diff -- a/arch/sh/configs/rsk7269_defconfig b/arch/sh/configs/rsk7269_defconfig
> --- a/arch/sh/configs/rsk7269_defconfig
> +++ b/arch/sh/configs/rsk7269_defconfig
> @@ -1,6 +1,6 @@
>  CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_SWAP_IO_SPACE=y
> diff -- a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
> --- a/arch/xtensa/configs/cadence_csp_defconfig
> +++ b/arch/xtensa/configs/cadence_csp_defconfig
> @@ -21,7 +21,7 @@ CONFIG_INITRAMFS_SOURCE="$$KERNEL_INITRA
>  # CONFIG_RD_LZO is not set
>  # CONFIG_RD_LZ4 is not set
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PROFILING=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_FORCE_LOAD=y
> diff -- a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
> --- a/arch/arm/configs/aspeed_g4_defconfig
> +++ b/arch/arm/configs/aspeed_g4_defconfig
> @@ -15,7 +15,7 @@ CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_UID16 is not set
>  # CONFIG_SYSFS_SYSCALL is not set
>  # CONFIG_AIO is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_ARCH_MULTI_V7 is not set
>  CONFIG_ARCH_ASPEED=y
> diff -- a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -15,7 +15,7 @@ CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_UID16 is not set
>  # CONFIG_SYSFS_SYSCALL is not set
>  # CONFIG_AIO is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  CONFIG_ARCH_MULTI_V6=y
>  CONFIG_ARCH_ASPEED=y
> diff -- a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -7,7 +7,7 @@ CONFIG_CGROUPS=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_ARCH_MULTI_V4T=y
>  CONFIG_ARCH_MULTI_V5=y
>  # CONFIG_ARCH_MULTI_V7 is not set
> diff -- a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
> --- a/arch/arm/configs/axm55xx_defconfig
> +++ b/arch/arm/configs/axm55xx_defconfig
> @@ -21,7 +21,7 @@ CONFIG_NAMESPACES=y
>  CONFIG_SCHED_AUTOGROUP=y
>  CONFIG_RELAY=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PROFILING=y
>  CONFIG_ARCH_AXXIA=y
>  CONFIG_ARM_LPAE=y
> diff -- a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
> --- a/arch/arm/configs/bcm2835_defconfig
> +++ b/arch/arm/configs/bcm2835_defconfig
> @@ -19,7 +19,7 @@ CONFIG_RELAY=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PROFILING=y
>  CONFIG_CC_STACKPROTECTOR_REGULAR=y
>  CONFIG_ARCH_MULTI_V6=y
> diff -- a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
> --- a/arch/arm/configs/clps711x_defconfig
> +++ b/arch/arm/configs/clps711x_defconfig
> @@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
>  CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_RD_LZMA=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_JUMP_LABEL=y
>  CONFIG_PARTITION_ADVANCED=y
>  CONFIG_ARCH_CLPS711X=y
> diff -- a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
> --- a/arch/arm/configs/keystone_defconfig
> +++ b/arch/arm/configs/keystone_defconfig
> @@ -14,7 +14,7 @@ CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_ELF_CORE is not set
>  # CONFIG_BASE_FULL is not set
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PROFILING=y
>  CONFIG_ARCH_KEYSTONE=y
>  CONFIG_ARM_LPAE=y
> diff -- a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
> --- a/arch/arm/configs/lpc18xx_defconfig
> +++ b/arch/arm/configs/lpc18xx_defconfig
> @@ -14,7 +14,7 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  # CONFIG_SIGNALFD is not set
>  # CONFIG_EVENTFD is not set
>  # CONFIG_AIO is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_MMU is not set
>  CONFIG_ARCH_LPC18XX=y
>  CONFIG_SET_MEM_PARAM=y
> diff -- a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
> --- a/arch/arm/configs/lpc32xx_defconfig
> +++ b/arch/arm/configs/lpc32xx_defconfig
> @@ -9,7 +9,7 @@ CONFIG_SYSFS_DEPRECATED=y
>  CONFIG_SYSFS_DEPRECATED_V2=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_ARCH_MULTI_V7 is not set
>  CONFIG_ARCH_LPC32XX=y
>  CONFIG_AEABI=y
> diff -- a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
> --- a/arch/arm/configs/milbeaut_m10v_defconfig
> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
> @@ -3,7 +3,7 @@ CONFIG_NO_HZ_IDLE=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_CGROUPS=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  CONFIG_ARCH_MILBEAUT=y
>  CONFIG_ARCH_MILBEAUT_M10V=y
> diff -- a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
> --- a/arch/arm/configs/moxart_defconfig
> +++ b/arch/arm/configs/moxart_defconfig
> @@ -10,7 +10,7 @@ CONFIG_IKCONFIG_PROC=y
>  # CONFIG_TIMERFD is not set
>  # CONFIG_EVENTFD is not set
>  # CONFIG_AIO is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_ARCH_MULTI_V4=y
>  # CONFIG_ARCH_MULTI_V7 is not set
> diff -- a/arch/arm/configs/multi_v4t_defconfig b/arch/arm/configs/multi_v4t_defconfig
> --- a/arch/arm/configs/multi_v4t_defconfig
> +++ b/arch/arm/configs/multi_v4t_defconfig
> @@ -2,7 +2,7 @@ CONFIG_KERNEL_LZMA=y
>  CONFIG_SYSVIPC=y
>  CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_ARCH_MULTI_V4T=y
>  # CONFIG_ARCH_MULTI_V7 is not set
>  CONFIG_ARCH_AT91=y
> diff -- a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -3,7 +3,7 @@ CONFIG_NO_HZ_IDLE=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_CGROUPS=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  CONFIG_ARCH_VIRT=y
>  CONFIG_ARCH_AIROHA=y
> diff -- a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -11,7 +11,7 @@ CONFIG_IKCONFIG_PROC=y
>  CONFIG_LOG_BUF_SHIFT=13
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PROFILING=y
>  # CONFIG_ARCH_MULTI_V7 is not set
>  CONFIG_ARCH_PXA=y
> diff -- a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
> --- a/arch/arm/configs/qcom_defconfig
> +++ b/arch/arm/configs/qcom_defconfig
> @@ -7,7 +7,7 @@ CONFIG_IKCONFIG_PROC=y
>  CONFIG_CGROUPS=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PROFILING=y
>  CONFIG_ARCH_QCOM=y
>  CONFIG_ARCH_MSM8X60=y
> diff -- a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -5,7 +5,7 @@ CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_CGROUPS=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_ARCH_AT91=y
>  CONFIG_SOC_SAMA5D2=y
>  CONFIG_SOC_SAMA5D3=y
> diff -- a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -12,7 +12,7 @@ CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_FHANDLE is not set
>  # CONFIG_IO_URING is not set
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_ARCH_AT91=y
>  CONFIG_SOC_SAMA7G5=y
>  CONFIG_ATMEL_CLOCKSOURCE_TCB=y
> diff -- a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> --- a/arch/arm/configs/socfpga_defconfig
> +++ b/arch/arm/configs/socfpga_defconfig
> @@ -7,7 +7,7 @@ CONFIG_CGROUPS=y
>  CONFIG_CPUSETS=y
>  CONFIG_NAMESPACES=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PROFILING=y
>  CONFIG_ARCH_INTEL_SOCFPGA=y
>  CONFIG_ARM_THUMBEE=y
> diff -- a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -11,7 +11,7 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  # CONFIG_SIGNALFD is not set
>  # CONFIG_EVENTFD is not set
>  # CONFIG_AIO is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_BLK_DEV_BSG is not set
>  # CONFIG_MMU is not set
>  CONFIG_ARCH_STM32=y
> diff -- a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
> --- a/arch/arm/configs/tegra_defconfig
> +++ b/arch/arm/configs/tegra_defconfig
> @@ -14,7 +14,7 @@ CONFIG_NAMESPACES=y
>  CONFIG_USER_NS=y
>  CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_ELF_CORE is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  CONFIG_ARCH_TEGRA=y
>  CONFIG_SMP=y
> diff -- a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
> --- a/arch/arm/configs/vf610m4_defconfig
> +++ b/arch/arm/configs/vf610m4_defconfig
> @@ -5,7 +5,7 @@ CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_RD_XZ is not set
>  # CONFIG_RD_LZ4 is not set
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_MMU is not set
>  CONFIG_ARCH_MXC=y
>  CONFIG_SOC_VF610=y
> diff -- a/arch/mips/configs/ath25_defconfig b/arch/mips/configs/ath25_defconfig
> --- a/arch/mips/configs/ath25_defconfig
> +++ b/arch/mips/configs/ath25_defconfig
> @@ -11,7 +11,7 @@ CONFIG_BLK_DEV_INITRD=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  # CONFIG_FHANDLE is not set
>  # CONFIG_AIO is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
> --- a/arch/mips/configs/ath79_defconfig
> +++ b/arch/mips/configs/ath79_defconfig
> @@ -5,7 +5,7 @@ CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_RD_GZIP is not set
>  # CONFIG_AIO is not set
>  # CONFIG_KALLSYMS is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
> --- a/arch/mips/configs/bcm47xx_defconfig
> +++ b/arch/mips/configs/bcm47xx_defconfig
> @@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_BCM47XX=y
>  CONFIG_PCI=y
>  # CONFIG_SUSPEND is not set
> diff -- a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
> --- a/arch/mips/configs/ci20_defconfig
> +++ b/arch/mips/configs/ci20_defconfig
> @@ -18,7 +18,7 @@ CONFIG_NAMESPACES=y
>  CONFIG_USER_NS=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_MACH_INGENIC_SOC=y
>  CONFIG_JZ4780_CI20=y
>  CONFIG_HIGHMEM=y
> diff -- a/arch/mips/configs/cu1000-neo_defconfig b/arch/mips/configs/cu1000-neo_defconfig
> --- a/arch/mips/configs/cu1000-neo_defconfig
> +++ b/arch/mips/configs/cu1000-neo_defconfig
> @@ -15,7 +15,7 @@ CONFIG_NAMESPACES=y
>  CONFIG_USER_NS=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_MACH_INGENIC_SOC=y
> diff -- a/arch/mips/configs/cu1830-neo_defconfig b/arch/mips/configs/cu1830-neo_defconfig
> --- a/arch/mips/configs/cu1830-neo_defconfig
> +++ b/arch/mips/configs/cu1830-neo_defconfig
> @@ -15,7 +15,7 @@ CONFIG_NAMESPACES=y
>  CONFIG_USER_NS=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_MACH_INGENIC_SOC=y
> diff -- a/arch/mips/configs/db1xxx_defconfig b/arch/mips/configs/db1xxx_defconfig
> --- a/arch/mips/configs/db1xxx_defconfig
> +++ b/arch/mips/configs/db1xxx_defconfig
> @@ -17,7 +17,7 @@ CONFIG_CGROUP_FREEZER=y
>  CONFIG_CGROUP_DEVICE=y
>  CONFIG_CGROUP_CPUACCT=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_MIPS_ALCHEMY=y
>  CONFIG_HZ_100=y
>  CONFIG_PCI=y
> diff -- a/arch/mips/configs/gcw0_defconfig b/arch/mips/configs/gcw0_defconfig
> --- a/arch/mips/configs/gcw0_defconfig
> +++ b/arch/mips/configs/gcw0_defconfig
> @@ -2,7 +2,7 @@ CONFIG_DEFAULT_HOSTNAME="gcw0"
>  CONFIG_NO_HZ_IDLE=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_PREEMPT_VOLUNTARY=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PROFILING=y
>  CONFIG_MACH_INGENIC_SOC=y
>  CONFIG_JZ4770_GCW0=y
> diff -- a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
> --- a/arch/mips/configs/generic_defconfig
> +++ b/arch/mips/configs/generic_defconfig
> @@ -17,7 +17,7 @@ CONFIG_SCHED_AUTOGROUP=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_BPF_SYSCALL=y
>  CONFIG_USERFAULTFD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_CPU_LITTLE_ENDIAN=y
> diff -- a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
> --- a/arch/mips/configs/loongson2k_defconfig
> +++ b/arch/mips/configs/loongson2k_defconfig
> @@ -18,7 +18,7 @@ CONFIG_SCHED_AUTOGROUP=y
>  CONFIG_SYSFS_DEPRECATED=y
>  CONFIG_RELAY=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_MACH_LOONGSON64=y
>  # CONFIG_CPU_LOONGSON3_CPUCFG_EMULATION is not set
>  CONFIG_HZ_256=y
> diff -- a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
> --- a/arch/mips/configs/loongson3_defconfig
> +++ b/arch/mips/configs/loongson3_defconfig
> @@ -26,7 +26,7 @@ CONFIG_SYSFS_DEPRECATED=y
>  CONFIG_RELAY=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_BPF_SYSCALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  CONFIG_MACH_LOONGSON64=y
>  CONFIG_CPU_HAS_MSA=y
> diff -- a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
> --- a/arch/mips/configs/maltaaprp_defconfig
> +++ b/arch/mips/configs/maltaaprp_defconfig
> @@ -5,7 +5,7 @@ CONFIG_AUDIT=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_LOG_BUF_SHIFT=15
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_MIPS_MALTA=y
>  CONFIG_CPU_LITTLE_ENDIAN=y
>  CONFIG_CPU_MIPS32_R2=y
> diff -- a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
> --- a/arch/mips/configs/malta_qemu_32r6_defconfig
> +++ b/arch/mips/configs/malta_qemu_32r6_defconfig
> @@ -5,7 +5,7 @@ CONFIG_NO_HZ=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_LOG_BUF_SHIFT=15
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_MIPS_MALTA=y
>  CONFIG_CPU_LITTLE_ENDIAN=y
>  CONFIG_CPU_MIPS32_R6=y
> diff -- a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
> --- a/arch/mips/configs/maltasmvp_defconfig
> +++ b/arch/mips/configs/maltasmvp_defconfig
> @@ -5,7 +5,7 @@ CONFIG_NO_HZ=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_LOG_BUF_SHIFT=15
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_MIPS_MALTA=y
>  CONFIG_CPU_LITTLE_ENDIAN=y
>  CONFIG_CPU_MIPS32_R2=y
> diff -- a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
> --- a/arch/mips/configs/maltasmvp_eva_defconfig
> +++ b/arch/mips/configs/maltasmvp_eva_defconfig
> @@ -5,7 +5,7 @@ CONFIG_NO_HZ=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_LOG_BUF_SHIFT=15
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_MIPS_MALTA=y
>  CONFIG_CPU_LITTLE_ENDIAN=y
>  CONFIG_CPU_MIPS32_R2=y
> diff -- a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
> --- a/arch/mips/configs/maltaup_defconfig
> +++ b/arch/mips/configs/maltaup_defconfig
> @@ -6,7 +6,7 @@ CONFIG_NO_HZ=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_LOG_BUF_SHIFT=15
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  CONFIG_MIPS_MALTA=y
>  CONFIG_CPU_LITTLE_ENDIAN=y
>  CONFIG_CPU_MIPS32_R2=y
> diff -- a/arch/mips/configs/omega2p_defconfig b/arch/mips/configs/omega2p_defconfig
> --- a/arch/mips/configs/omega2p_defconfig
> +++ b/arch/mips/configs/omega2p_defconfig
> @@ -17,7 +17,7 @@ CONFIG_NAMESPACES=y
>  CONFIG_USER_NS=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/arch/mips/configs/pic32mzda_defconfig b/arch/mips/configs/pic32mzda_defconfig
> --- a/arch/mips/configs/pic32mzda_defconfig
> +++ b/arch/mips/configs/pic32mzda_defconfig
> @@ -7,7 +7,7 @@ CONFIG_IKCONFIG_PROC=y
>  CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_RELAY=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_MACH_PIC32=y
>  CONFIG_DTB_PIC32_MZDA_SK=y
> diff -- a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
> --- a/arch/mips/configs/qi_lb60_defconfig
> +++ b/arch/mips/configs/qi_lb60_defconfig
> @@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
>  # CONFIG_CROSS_MEMORY_ATTACH is not set
>  CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_MACH_INGENIC_SOC=y
> diff -- a/arch/mips/configs/rs90_defconfig b/arch/mips/configs/rs90_defconfig
> --- a/arch/mips/configs/rs90_defconfig
> +++ b/arch/mips/configs/rs90_defconfig
> @@ -15,7 +15,7 @@ CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
>  # CONFIG_IO_URING is not set
>  # CONFIG_ADVISE_SYSCALLS is not set
>  # CONFIG_KALLSYMS is not set
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_PERF_EVENTS is not set
>  CONFIG_PROFILING=y
>  CONFIG_MACH_INGENIC_SOC=y
> diff -- a/arch/mips/configs/rt305x_defconfig b/arch/mips/configs/rt305x_defconfig
> --- a/arch/mips/configs/rt305x_defconfig
> +++ b/arch/mips/configs/rt305x_defconfig
> @@ -7,7 +7,7 @@ CONFIG_BLK_DEV_INITRD=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  # CONFIG_AIO is not set
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/arch/mips/configs/vocore2_defconfig b/arch/mips/configs/vocore2_defconfig
> --- a/arch/mips/configs/vocore2_defconfig
> +++ b/arch/mips/configs/vocore2_defconfig
> @@ -17,7 +17,7 @@ CONFIG_NAMESPACES=y
>  CONFIG_USER_NS=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/arch/mips/configs/xway_defconfig b/arch/mips/configs/xway_defconfig
> --- a/arch/mips/configs/xway_defconfig
> +++ b/arch/mips/configs/xway_defconfig
> @@ -7,7 +7,7 @@ CONFIG_BLK_DEV_INITRD=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  # CONFIG_AIO is not set
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
> diff -- a/kernel/configs/tiny-base.config b/kernel/configs/tiny-base.config
> --- a/kernel/configs/tiny-base.config
> +++ b/kernel/configs/tiny-base.config
> @@ -1 +1 @@
> -CONFIG_EMBEDDED=y
> +CONFIG_EXPERT=y
> diff -- a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
> --- a/tools/testing/selftests/wireguard/qemu/kernel.config
> +++ b/tools/testing/selftests/wireguard/qemu/kernel.config
> @@ -41,7 +41,6 @@ CONFIG_KALLSYMS=y
>  CONFIG_BUG=y
>  CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
>  CONFIG_JUMP_LABEL=y
> -CONFIG_EMBEDDED=n
>  CONFIG_BASE_FULL=y
>  CONFIG_FUTEX=y
>  CONFIG_SHMEM=y
