Return-Path: <linux-arch+bounces-11204-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401ACA7847C
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 00:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A1D16D20F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 22:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FBF1EF376;
	Tue,  1 Apr 2025 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFWiuBeW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C972F4ED;
	Tue,  1 Apr 2025 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545781; cv=none; b=KdskU/wGZWJZPHM8pggtih6tZe6HGbzwmjzyZxie5ahPaWNlpUNb89Cmu86B3uwvg7WjfFpfzulahjpI+5izIP79YbDgEQ4q0A9AE3SxCMCibYbj0HrDlX3cxfIrmjhovr19o2PUBd+gH4zpfyJQCfZ6lhg5IBGOznSjXeSVFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545781; c=relaxed/simple;
	bh=zBOpo8bHXqPXz1TKBORySxRo5vy6/1PRYjj0iSPTP7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyjT261+7uK9i20qBaRejtlRqORIlyoDPVeqveZGi4BfrmEhVds/GNyRqV++YV1lWzztt5o/7wFt5HhuIeRodAY0u0zjid2wVP73PAgEX32QG9ePiEEzIo7DBXK/o00n4afMU+jHfJf3BoxYJGb1zYlrzOa6V+Th39l+doj68Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFWiuBeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37DBC4CEE4;
	Tue,  1 Apr 2025 22:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743545781;
	bh=zBOpo8bHXqPXz1TKBORySxRo5vy6/1PRYjj0iSPTP7s=;
	h=From:To:Cc:Subject:Date:From;
	b=nFWiuBeWydsoQhHsMN54IcYviFkxoHmAoM6Mkt6uzDGgHqXfEHac7ObSGdYhzsQfH
	 VUbu40MZ+QZXu64pLdgRqCi72h3TOLFtzt9WgjdB/lEouA50hSdLxPsUqjKKda2aeJ
	 XuTFFNhDOzvsbum5gsQbyn7YyqmLoZUyR66gqtzGwXrtlJ+vN4cxfwuPus4tWA2nhw
	 SDaRr8vuRFHftuhj23ARqGY6A3O+Cd84Qpx+2CyRh6O96dcsoAWqXEgEpRy9ESPQMn
	 uqcNvJS2/og+3Bt1QZBLQYpE5VYN/dx3VF2TVMC+zD24eEux+W6W6i/2Rxgk7QAkRP
	 /te9vO0qBa21w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 0/7] More CRC kconfig option cleanups
Date: Tue,  1 Apr 2025 15:15:53 -0700
Message-ID: <20250401221600.24878-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series finishes cleaning up the CRC kconfig options by removing the
remaining unnecessary prompts and an unnecessary 'default y', removing
CONFIG_LIBCRC32C, and documenting all the options.

I'm planning to take this series through the CRC tree.

Eric Biggers (7):
  lib/crc: remove unnecessary prompt for CONFIG_CRC32 and drop 'default
    y'
  lib/crc: remove unnecessary prompt for CONFIG_CRC_CCITT
  lib/crc: remove unnecessary prompt for CONFIG_CRC16
  lib/crc: remove unnecessary prompt for CONFIG_CRC_T10DIF
  lib/crc: remove unnecessary prompt for CONFIG_CRC_ITU_T
  lib/crc: document all the CRC library kconfig options
  lib/crc: remove CONFIG_LIBCRC32C

 arch/arm/configs/at91_dt_defconfig            |  1 -
 arch/arm/configs/collie_defconfig             |  1 -
 arch/arm/configs/davinci_all_defconfig        |  1 -
 arch/arm/configs/dove_defconfig               |  1 -
 arch/arm/configs/exynos_defconfig             |  1 -
 arch/arm/configs/imx_v6_v7_defconfig          |  2 -
 arch/arm/configs/lpc18xx_defconfig            |  1 -
 arch/arm/configs/lpc32xx_defconfig            |  1 -
 arch/arm/configs/milbeaut_m10v_defconfig      |  2 -
 arch/arm/configs/mmp2_defconfig               |  1 -
 arch/arm/configs/multi_v4t_defconfig          |  1 -
 arch/arm/configs/multi_v5_defconfig           |  1 -
 arch/arm/configs/mvebu_v5_defconfig           |  1 -
 arch/arm/configs/mxs_defconfig                |  1 -
 arch/arm/configs/omap2plus_defconfig          |  3 -
 arch/arm/configs/orion5x_defconfig            |  1 -
 arch/arm/configs/pxa168_defconfig             |  1 -
 arch/arm/configs/pxa910_defconfig             |  1 -
 arch/arm/configs/pxa_defconfig                |  2 -
 arch/arm/configs/s5pv210_defconfig            |  1 -
 arch/arm/configs/sama7_defconfig              |  2 -
 arch/arm/configs/spitz_defconfig              |  1 -
 arch/arm/configs/stm32_defconfig              |  1 -
 arch/arm/configs/wpcm450_defconfig            |  2 -
 arch/hexagon/configs/comet_defconfig          |  3 -
 arch/m68k/configs/amcore_defconfig            |  1 -
 arch/mips/configs/ath79_defconfig             |  1 -
 arch/mips/configs/bigsur_defconfig            |  1 -
 arch/mips/configs/fuloong2e_defconfig         |  1 -
 arch/mips/configs/ip22_defconfig              |  1 -
 arch/mips/configs/ip27_defconfig              |  1 -
 arch/mips/configs/ip30_defconfig              |  1 -
 arch/mips/configs/ip32_defconfig              |  1 -
 arch/mips/configs/omega2p_defconfig           |  1 -
 arch/mips/configs/rb532_defconfig             |  1 -
 arch/mips/configs/rt305x_defconfig            |  1 -
 arch/mips/configs/sb1250_swarm_defconfig      |  1 -
 arch/mips/configs/vocore2_defconfig           |  1 -
 arch/mips/configs/xway_defconfig              |  1 -
 arch/parisc/configs/generic-32bit_defconfig   |  2 -
 arch/parisc/configs/generic-64bit_defconfig   |  1 -
 arch/powerpc/configs/44x/sam440ep_defconfig   |  1 -
 arch/powerpc/configs/44x/warp_defconfig       |  2 -
 .../configs/83xx/mpc832x_rdb_defconfig        |  1 -
 .../configs/83xx/mpc834x_itx_defconfig        |  1 -
 .../configs/83xx/mpc834x_itxgp_defconfig      |  1 -
 .../configs/83xx/mpc837x_rdb_defconfig        |  1 -
 arch/powerpc/configs/85xx/ge_imp3a_defconfig  |  2 -
 arch/powerpc/configs/85xx/stx_gp3_defconfig   |  2 -
 .../configs/85xx/xes_mpc85xx_defconfig        |  1 -
 arch/powerpc/configs/86xx-hw.config           |  1 -
 arch/powerpc/configs/amigaone_defconfig       |  1 -
 arch/powerpc/configs/chrp32_defconfig         |  1 -
 arch/powerpc/configs/fsl-emb-nonhw.config     |  1 -
 arch/powerpc/configs/g5_defconfig             |  1 -
 arch/powerpc/configs/gamecube_defconfig       |  1 -
 arch/powerpc/configs/linkstation_defconfig    |  2 -
 arch/powerpc/configs/mpc83xx_defconfig        |  1 -
 arch/powerpc/configs/mpc866_ads_defconfig     |  1 -
 arch/powerpc/configs/mvme5100_defconfig       |  2 -
 arch/powerpc/configs/pasemi_defconfig         |  1 -
 arch/powerpc/configs/pmac32_defconfig         |  1 -
 arch/powerpc/configs/ppc44x_defconfig         |  1 -
 arch/powerpc/configs/ppc64e_defconfig         |  1 -
 arch/powerpc/configs/ps3_defconfig            |  2 -
 arch/powerpc/configs/skiroot_defconfig        |  2 -
 arch/powerpc/configs/storcenter_defconfig     |  1 -
 arch/powerpc/configs/wii_defconfig            |  1 -
 arch/sh/configs/ap325rxa_defconfig            |  1 -
 arch/sh/configs/ecovec24_defconfig            |  1 -
 arch/sh/configs/edosk7705_defconfig           |  1 -
 arch/sh/configs/espt_defconfig                |  1 -
 arch/sh/configs/hp6xx_defconfig               |  2 -
 arch/sh/configs/kfr2r09-romimage_defconfig    |  1 -
 arch/sh/configs/landisk_defconfig             |  1 -
 arch/sh/configs/lboxre2_defconfig             |  1 -
 arch/sh/configs/magicpanelr2_defconfig        |  2 -
 arch/sh/configs/migor_defconfig               |  1 -
 arch/sh/configs/r7780mp_defconfig             |  1 -
 arch/sh/configs/r7785rp_defconfig             |  1 -
 arch/sh/configs/rts7751r2d1_defconfig         |  1 -
 arch/sh/configs/rts7751r2dplus_defconfig      |  1 -
 arch/sh/configs/sdk7780_defconfig             |  1 -
 arch/sh/configs/se7206_defconfig              |  3 -
 arch/sh/configs/se7712_defconfig              |  1 -
 arch/sh/configs/se7721_defconfig              |  1 -
 arch/sh/configs/se7724_defconfig              |  1 -
 arch/sh/configs/sh03_defconfig                |  1 -
 arch/sh/configs/sh2007_defconfig              |  2 -
 arch/sh/configs/sh7724_generic_defconfig      |  1 -
 arch/sh/configs/sh7763rdp_defconfig           |  1 -
 arch/sh/configs/sh7770_generic_defconfig      |  1 -
 arch/sh/configs/titan_defconfig               |  1 -
 arch/sparc/configs/sparc64_defconfig          |  1 -
 drivers/block/Kconfig                         |  2 +-
 drivers/block/drbd/Kconfig                    |  2 +-
 drivers/md/Kconfig                            |  2 +-
 drivers/md/persistent-data/Kconfig            |  2 +-
 drivers/net/ethernet/broadcom/Kconfig         |  4 +-
 drivers/net/ethernet/cavium/Kconfig           |  2 +-
 fs/bcachefs/Kconfig                           |  2 +-
 fs/btrfs/Kconfig                              |  2 +-
 fs/ceph/Kconfig                               |  2 +-
 fs/erofs/Kconfig                              |  2 +-
 fs/gfs2/Kconfig                               |  1 -
 fs/xfs/Kconfig                                |  2 +-
 lib/Kconfig                                   | 57 +++++++++----------
 net/batman-adv/Kconfig                        |  2 +-
 net/ceph/Kconfig                              |  2 +-
 net/netfilter/Kconfig                         |  4 +-
 net/netfilter/ipvs/Kconfig                    |  2 +-
 net/openvswitch/Kconfig                       |  2 +-
 net/sched/Kconfig                             |  2 +-
 net/sctp/Kconfig                              |  2 +-
 tools/testing/selftests/bpf/config.x86_64     |  1 -
 tools/testing/selftests/hid/config.common     |  1 -
 116 files changed, 46 insertions(+), 170 deletions(-)


base-commit: 91e5bfe317d8f8471fbaa3e70cf66cae1314a516
-- 
2.49.0


