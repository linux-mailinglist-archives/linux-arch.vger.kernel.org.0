Return-Path: <linux-arch+bounces-169-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF4B7E8EBF
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B961F20F90
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F895394;
	Sun, 12 Nov 2023 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3ZnNHPp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8AF5386
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE71C433C8;
	Sun, 12 Nov 2023 06:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769928;
	bh=cuF9JM0r/gsp1vghHnzFT7BkfhIYwfHcWZhIf27n2xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3ZnNHPp3EJ0Y7agFTlRHB8X/PRo4qR3eYYHC7/GGu20rmlj22UU0PTGsvORZBD41
	 Z+EVPhN5T/bYe++fF/zfE0ELkpn3Rl+4JcZjYGnDj8dkve6+UH4nvo5DwIHyi5vocE
	 lEyIrJ7c07LGEPXju8fkDwtlWmfYYETHVZHKz0vDT4MojxgLB2IB9QAF+ZsLh63a03
	 pR2u2UEDc3ioOIihJNM3NSJpXwSI0R6vVBvEso2YO33TjSZPsiojurtrZ7sTarcJeo
	 6B4ZNSy9+D2Pazrrjl9Uf/Xtbmw46Z1+rZwN/cs4OQLG/0CrQeCn/UoGyKwwXBDYUl
	 mbwNziOgXRm7w==
From: guoren@kernel.org
To: arnd@arndb.de,
	guoren@kernel.org,
	palmer@rivosinc.com,
	tglx@linutronix.de,
	conor.dooley@microchip.com,
	heiko@sntech.de,
	apatel@ventanamicro.com,
	atishp@atishpatra.org,
	bjorn@kernel.org,
	paul.walmsley@sifive.com,
	anup@brainfault.org,
	jiawei@iscas.ac.cn,
	liweiwei@iscas.ac.cn,
	wefu@redhat.com,
	U2FsdGVkX1@gmail.com,
	wangjunqiang@iscas.ac.cn,
	kito.cheng@sifive.com,
	andy.chiu@sifive.com,
	vincent.chen@sifive.com,
	greentime.hu@sifive.com,
	wuwei2016@iscas.ac.cn,
	jrtc27@jrtc27.com,
	luto@kernel.org,
	fweimer@redhat.com,
	catalin.marinas@arm.com,
	hjl.tools@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 33/38] riscv: s64ilp32: Add rv64ilp32_defconfig
Date: Sun, 12 Nov 2023 01:15:09 -0500
Message-Id: <20231112061514.2306187-34-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

Follow the rv32_defconfig rule to add rv64ilp32_defconfig; the only
difference is:
-CONFIG_ARCH_RV32I=y
+CONFIG_ARCH_RV64ILP32=y

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Makefile               | 4 ++++
 arch/riscv/configs/64ilp32.config | 2 ++
 2 files changed, 6 insertions(+)
 create mode 100644 arch/riscv/configs/64ilp32.config

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 3b1435bade49..d01f41fdf57f 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -205,3 +205,7 @@ rv32_defconfig:
 PHONY += rv32_nommu_virt_defconfig
 rv32_nommu_virt_defconfig:
 	$(Q)$(MAKE) -f $(srctree)/Makefile nommu_virt_defconfig 32-bit.config
+
+PHONY += rv64ilp32_defconfig
+rv64ilp32_defconfig:
+	$(Q)$(MAKE) -f $(srctree)/Makefile defconfig 64ilp32.config
diff --git a/arch/riscv/configs/64ilp32.config b/arch/riscv/configs/64ilp32.config
new file mode 100644
index 000000000000..7d836aa2fae7
--- /dev/null
+++ b/arch/riscv/configs/64ilp32.config
@@ -0,0 +1,2 @@
+CONFIG_ARCH_RV64ILP32=y
+CONFIG_NONPORTABLE=y
-- 
2.36.1


