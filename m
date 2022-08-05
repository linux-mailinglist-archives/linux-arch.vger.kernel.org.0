Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6025F58A972
	for <lists+linux-arch@lfdr.de>; Fri,  5 Aug 2022 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiHEKZf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Aug 2022 06:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiHEKZe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Aug 2022 06:25:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D611116D;
        Fri,  5 Aug 2022 03:25:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4F3BB827EC;
        Fri,  5 Aug 2022 10:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867C3C43140;
        Fri,  5 Aug 2022 10:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659695130;
        bh=6qou5lJ9UlODgazZoZR7Tiio62yPWA6PDFls0zOiKJI=;
        h=From:Date:Subject:To:Cc:From;
        b=nm3PDFUfmuaRlMQRJRma6iT70g0oh6oZAGKtiNXfVB3FCRv6cT2eb5HKExaAngSAd
         9xzpIrt4VZwd3SUYj00RplzilSmiEDLaN0B49DALzqLBgQsdzF8azpzyc0ufIQwrw5
         gfZsu1xnJPM1xKJvGf0JUmANBk/a2YBTF1/CG3jEEeMPM1f5DkuuzGlY508fe19Uej
         oGJJqXVH98FnIoof24aP7ZxGDvq7j9yWm+dXWbYlHYWHZK3gYhuxBRT5avPj7sfUxZ
         aOODzc2nJNefgrs0ksiyEgexPwcuwLbuup+PU2WeNI0Cu1Z824ur3I1THom6AUKGSq
         rhRG1hH5m0W0Q==
Received: by mail-ed1-f46.google.com with SMTP id b16so2813235edd.4;
        Fri, 05 Aug 2022 03:25:30 -0700 (PDT)
X-Gm-Message-State: ACgBeo3udlnpjTNkMlIL4N2ulpMd8LxnpZjFYaHD4bZlsAgnpsbKJud7
        uRzYNY/zNF8M7l0kGfL/BwVbGafhUY8CPmBt8xA=
X-Google-Smtp-Source: AA6agR7qw52v8Xrtb5g3bvH3jlTlxM1+g5YjvUAcr4ovWy2nMvkNCjNMO5qJ4gj9NEC+2rWEb8n1Z1k0UDtXTpnm4EQ=
X-Received: by 2002:aa7:cd99:0:b0:43c:4f9c:4977 with SMTP id
 x25-20020aa7cd99000000b0043c4f9c4977mr5949707edv.303.1659695128764; Fri, 05
 Aug 2022 03:25:28 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 5 Aug 2022 12:25:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2jgQcLaDXX6eOTNrU0RJ2O625e75LBMy6v2ABP0cdoww@mail.gmail.com>
Message-ID: <CAK8P3a2jgQcLaDXX6eOTNrU0RJ2O625e75LBMy6v2ABP0cdoww@mail.gmail.com>
Subject: [GIT PULL] asm-generic: updates for 6.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-6.0

for you to fetch changes up to 6f05e014b96c8846cdc39acdf10bbdbafb9c78a0:

  uapi: asm-generic: fcntl: Fix typo 'the the' in comment (2022-07-22
14:54:22 +0200)

----------------------------------------------------------------
asm-generic: updates for 6.0

There are three independent sets of changes:

 - Sai Prakash Ranjan adds tracing support to the asm-generic
   version of the MMIO accessors, which is intended to help
   understand problems with device drivers and has been part
   of Qualcomm's vendor kernels for many years.

 - A patch from Sebastian Siewior to rework the handling of
   IRQ stacks in softirqs across architectures, which is
   needed for enabling PREEMPT_RT.

 - The last patch to remove the CONFIG_VIRT_TO_BUS option and
   some of the code behind that, after the last users of this
   old interface made it in through the netdev, scsi, media and
   staging trees.

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge branch 'asm-generic-mmiotrace' into asm-generic
      arch/*/: remove CONFIG_VIRT_TO_BUS

Prasad Sodagudi (1):
      lib: Add register read/write tracing support

Sai Prakash Ranjan (8):
      arm64: io: Use asm-generic high level MMIO accessors
      coresight: etm4x: Use asm-generic IO memory barriers
      irqchip/tegra: Fix overflow implicit truncation warnings
      drm/meson: Fix overflow implicit truncation warnings
      KVM: arm64: Add a flag to disable MMIO trace for nVHE KVM
      asm-generic/io: Add logging support for MMIO accessors
      serial: qcom_geni_serial: Disable MMIO tracing for geni serial
      soc: qcom: geni: Disable MMIO tracing for GENI SE

Sebastian Andrzej Siewior (1):
      arch/*: Disable softirq stacks on PREEMPT_RT.

Slark Xiao (1):
      uapi: asm-generic: fcntl: Fix typo 'the the' in comment

 Documentation/core-api/bus-virt-phys-mapping.rst   | 220 ---------------------
 Documentation/core-api/dma-api-howto.rst           |  14 --
 Documentation/core-api/index.rst                   |   1 -
 .../translations/zh_CN/core-api/index.rst          |   1 -
 arch/Kconfig                                       |   3 +
 arch/alpha/Kconfig                                 |   1 -
 arch/alpha/include/asm/floppy.h                    |   2 +-
 arch/alpha/include/asm/io.h                        |   8 +-
 arch/arm/kernel/irq.c                              |   3 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/io.h                        |  41 +---
 arch/arm64/kvm/hyp/nvhe/Makefile                   |   7 +-
 arch/ia64/Kconfig                                  |   1 -
 arch/ia64/include/asm/io.h                         |   8 -
 arch/m68k/Kconfig                                  |   1 -
 arch/m68k/include/asm/virtconvert.h                |   4 +-
 arch/microblaze/Kconfig                            |   1 -
 arch/microblaze/include/asm/io.h                   |   2 -
 arch/mips/Kconfig                                  |   1 -
 arch/mips/include/asm/io.h                         |   9 -
 arch/parisc/Kconfig                                |   1 -
 arch/parisc/include/asm/floppy.h                   |   4 +-
 arch/parisc/include/asm/io.h                       |   2 -
 arch/parisc/kernel/irq.c                           |   2 +
 arch/powerpc/Kconfig                               |   1 -
 arch/powerpc/include/asm/io.h                      |   2 -
 arch/powerpc/kernel/irq.c                          |   4 +
 arch/riscv/include/asm/page.h                      |   1 -
 arch/s390/include/asm/softirq_stack.h              |   3 +-
 arch/sh/kernel/irq.c                               |   2 +
 arch/sparc/kernel/irq_64.c                         |   2 +
 arch/x86/Kconfig                                   |   1 -
 arch/x86/include/asm/io.h                          |   9 -
 arch/xtensa/Kconfig                                |   1 -
 arch/xtensa/include/asm/io.h                       |   3 -
 drivers/gpu/drm/meson/meson_viu.c                  |  22 +--
 drivers/hwtracing/coresight/coresight-etm4x-core.c |   8 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   8 +-
 drivers/irqchip/irq-tegra.c                        |  10 +-
 drivers/soc/qcom/qcom-geni-se.c                    |   3 +
 drivers/tty/serial/qcom_geni_serial.c              |   3 +
 include/asm-generic/io.h                           | 105 ++++++++--
 include/asm-generic/softirq_stack.h                |   2 +-
 include/trace/events/rwmmio.h                      |  97 +++++++++
 lib/Kconfig                                        |   7 +
 lib/Makefile                                       |   2 +
 lib/trace_readwrite.c                              |  47 +++++
 mm/Kconfig                                         |   8 -
 tools/include/uapi/asm-generic/fcntl.h             |   2 +-
 49 files changed, 314 insertions(+), 377 deletions(-)
 delete mode 100644 Documentation/core-api/bus-virt-phys-mapping.rst
 create mode 100644 include/trace/events/rwmmio.h
 create mode 100644 lib/trace_readwrite.c
