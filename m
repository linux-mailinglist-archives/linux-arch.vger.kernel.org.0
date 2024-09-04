Return-Path: <linux-arch+bounces-7037-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDAE96CAFC
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AE71C21FE3
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0BE17B514;
	Wed,  4 Sep 2024 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT2v4k9z"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F7154458;
	Wed,  4 Sep 2024 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493692; cv=none; b=TPRoqQ2EqYj+Sfo/Ar1uCcFofi9hE8NrJzjISmaPqO22KoX30c56Vp5WY/aUoi4+S+0wKZzG5KdiBK09H/xN3jsesXeDq2PQvRWyIWN1rXaMvGmUB6aDHuc1XQ9LrfpB8UPyoIAd8dmXa+RiCKFBSU1j/av7D/qHUrACTrXZQk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493692; c=relaxed/simple;
	bh=CYB/GfmJdrDKFu/H7+2VE0eaf6pWF3nzHTyM2uXXS0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B++P/tl8//q/htnsOyReYEBW3ZNvRQ3tbH3vofybBdWnQ2WMeltI7PWPQiFQgzjxovUMa5K+LvtGdc+dQfogRed/8vgVtGIS8qk/8fkdyftSzXylGSrJgg8EpmnOeiRciaVt8V9v35zzvqPW4jVfUq+6HUGOBiw+P7ycANv0X7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT2v4k9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43CFC4CEC2;
	Wed,  4 Sep 2024 23:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493692;
	bh=CYB/GfmJdrDKFu/H7+2VE0eaf6pWF3nzHTyM2uXXS0s=;
	h=From:To:Cc:Subject:Date:From;
	b=RT2v4k9zK9bwOPUoGHeKemzwjs6HcZHc9uadsz+sT47ccy03nMcEiNemuV+05QDFD
	 cTGu9bQ62Oro11VYbqFHWEpAJJhNwON0Eaa6SeJzAiV8VCPU4DA/9F4+ZwcbTuq7UT
	 JUpFO+Nh3cyVgUPV0sbAu7UEw7FAQ7DdwzXz72CtdnR2ehJPACjPq7LZ25gw82amWi
	 PEaHSf0ORFQBXRBlLYpi9V74RRnBI7oJ1VbspaHEbvtaPePfwUkKzjTKiFg5by4im1
	 xCG6hJb09f5Zr7/O10dE5gp7qaNG2hInuCTgD9Ol0mQ9N6vOfbd6rv97gmBNnCwRfy
	 nq95NYW9Qa1+A==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 00/15] kbuild: refactor DTB build rules, introduce a generic built-in boot DTB support
Date: Thu,  5 Sep 2024 08:47:36 +0900
Message-ID: <20240904234803.698424-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


01 and 02 are kbuild cleanups.
03 and 04 parepare to wrap boot DTBs in scripts/Makefile.vmlinux.

My plan is to 05-13 to each arch ML in the next cycle, but they are included
in this patch set so that reviewers can understand what will happen in
the future.



Masahiro Yamada (15):
  kbuild: add intermediate targets for Flex/Bison in
    scripts/Makefile.host
  kbuild: split device tree build rules into scripts/Makefile.dtbs
  kbuild: move non-boot builtin DTBs to .init.rodata section
  kbuild: add generic support for built-in boot DTBs
  MIPS: migrate to generic rule for built-in DTBs
  riscv: migrate to the generic rule for built-in DTB
  LoongArch:  migrate to the generic rule for built-in DTB
  ARC: migrate to the generic rule for built-in DTB
  openrisc: migrate to the generic rule for built-in DTB
  xtensa: migrate to the generic rule for built-in DTB
  nios2: migrate to the generic rule for built-in DTB
  sh: migrate to the generic rule for built-in DTB
  microblaze: migrate to the generic rule for built-in DTB
  kbuild: rename CONFIG_GENERIC_BUILTIN_DTB to CONFIG_BUILTIN_DTB
  kbuild: use .init.rodata section unconditionally for cmd_wrap_S_dtb

 Makefile                                      |   7 +-
 arch/arc/Kconfig                              |   7 +-
 arch/arc/Makefile                             |   3 -
 arch/arc/boot/dts/Makefile                    |   9 +-
 arch/arc/configs/axs101_defconfig             |   2 +-
 arch/arc/configs/axs103_defconfig             |   2 +-
 arch/arc/configs/axs103_smp_defconfig         |   2 +-
 arch/arc/configs/haps_hs_defconfig            |   2 +-
 arch/arc/configs/haps_hs_smp_defconfig        |   2 +-
 arch/arc/configs/hsdk_defconfig               |   2 +-
 arch/arc/configs/nsim_700_defconfig           |   2 +-
 arch/arc/configs/nsimosci_defconfig           |   2 +-
 arch/arc/configs/nsimosci_hs_defconfig        |   2 +-
 arch/arc/configs/nsimosci_hs_smp_defconfig    |   2 +-
 arch/arc/configs/tb10x_defconfig              |   2 +-
 arch/arc/configs/vdk_hs38_defconfig           |   2 +-
 arch/arc/configs/vdk_hs38_smp_defconfig       |   2 +-
 arch/loongarch/Kbuild                         |   1 -
 arch/loongarch/boot/dts/Makefile              |   2 -
 arch/microblaze/Kbuild                        |   1 -
 arch/microblaze/Kconfig                       |   5 +
 arch/microblaze/boot/dts/Makefile             |   5 -
 arch/microblaze/boot/dts/linked_dtb.S         |   2 -
 arch/microblaze/kernel/vmlinux.lds.S          |   2 +-
 arch/mips/Kconfig                             |   1 +
 arch/mips/Makefile                            |   3 -
 arch/mips/boot/dts/Makefile                   |   2 -
 arch/mips/boot/dts/brcm/Makefile              |   2 -
 arch/mips/boot/dts/cavium-octeon/Makefile     |   2 -
 arch/mips/boot/dts/ingenic/Makefile           |   2 -
 arch/mips/boot/dts/lantiq/Makefile            |   2 -
 arch/mips/boot/dts/loongson/Makefile          |   2 -
 arch/mips/boot/dts/mscc/Makefile              |   3 -
 arch/mips/boot/dts/mti/Makefile               |   2 -
 arch/mips/boot/dts/pic32/Makefile             |   2 -
 arch/mips/boot/dts/ralink/Makefile            |   2 -
 arch/nios2/Kbuild                             |   2 +-
 arch/nios2/boot/dts/Makefile                  |   4 +-
 arch/nios2/kernel/prom.c                      |   2 +-
 arch/nios2/platform/Kconfig.platform          |  10 +-
 arch/openrisc/Kbuild                          |   1 -
 arch/openrisc/Kconfig                         |   3 +-
 arch/openrisc/boot/dts/Makefile               |   2 +-
 arch/openrisc/configs/or1klitex_defconfig     |   2 +-
 arch/openrisc/configs/or1ksim_defconfig       |   2 +-
 arch/openrisc/configs/simple_smp_defconfig    |   2 +-
 arch/riscv/Kbuild                             |   1 -
 arch/riscv/Kconfig                            |   2 +-
 arch/riscv/boot/dts/Makefile                  |   2 -
 arch/riscv/configs/nommu_k210_defconfig       |   2 +-
 .../riscv/configs/nommu_k210_sdcard_defconfig |   2 +-
 arch/sh/Kbuild                                |   1 -
 arch/sh/Kconfig                               |   6 +-
 arch/sh/boot/dts/Makefile                     |   2 +-
 arch/sh/kernel/setup.c                        |   4 +-
 arch/xtensa/Kbuild                            |   2 +-
 arch/xtensa/Kconfig                           |   3 +-
 arch/xtensa/boot/dts/Makefile                 |   2 +-
 arch/xtensa/configs/audio_kc705_defconfig     |   2 +-
 arch/xtensa/configs/cadence_csp_defconfig     |   2 +-
 arch/xtensa/configs/generic_kc705_defconfig   |   2 +-
 arch/xtensa/configs/nommu_kc705_defconfig     |   2 +-
 arch/xtensa/configs/smp_lx200_defconfig       |   2 +-
 arch/xtensa/configs/virt_defconfig            |   2 +-
 arch/xtensa/configs/xip_kc705_defconfig       |   2 +-
 drivers/of/Kconfig                            |   6 +
 drivers/of/fdt.c                              |   2 +-
 drivers/of/unittest.c                         |   6 +-
 scripts/Makefile.build                        |  58 +++----
 scripts/Makefile.dtbs                         | 142 ++++++++++++++++++
 scripts/Makefile.host                         |   5 +
 scripts/Makefile.lib                          | 115 --------------
 scripts/Makefile.vmlinux                      |  44 ++++++
 scripts/link-vmlinux.sh                       |   4 +
 74 files changed, 294 insertions(+), 256 deletions(-)
 delete mode 100644 arch/microblaze/boot/dts/linked_dtb.S
 create mode 100644 scripts/Makefile.dtbs

-- 
2.43.0


