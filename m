Return-Path: <linux-arch+bounces-168-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265D67E8EBD
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAFD6B2097D
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A6F53A1;
	Sun, 12 Nov 2023 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eds0Ikvb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA085386
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3362C433C7;
	Sun, 12 Nov 2023 06:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769922;
	bh=bS9zYu4p2fDX0v+IO9ccI6gNcdJmQYX5Su7I11BAbz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eds0Ikvb4knSS+2emy3RCxl6MssNc5zSLI7TvAgF41P6aLGxzvhumme+tfoiJbZYR
	 E64mIZD3foSewobLLFWM8uEAYS2F7Kh6RRauO69qm7oFrRLBiW5gcTGx7lQquDH1H4
	 pyGzBxPO8sU1e4R2qo6ecYZVx0NP7Pn6xurHDlH/Gr544GTZVrrt/ofParw6Qb0Tpm
	 9o78tX8Aa4k8+RKVvEClQE4oPy776KWO5tvkrU2H3+Gs4WcLuzV1r+qVRi/fQ/GK8P
	 B5sTrI/oBj3IU/2VjqZLyF7Cy/1WyISInWnMyztHVxlQ5TsnAF6GPIStsmJkrSURHC
	 7/S9+w2Jg0xbg==
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
Subject: [RFC PATCH V2 32/38] riscv: s64ilp32: Validate harts by architecture name
Date: Sun, 12 Nov 2023 01:15:08 -0500
Message-Id: <20231112061514.2306187-33-guoren@kernel.org>
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

When rv64ilp32 was introduced, the 32BIT would work with rv64,isa. So
use the architecture name instead of the ABI width name. This is an
addition to the commit: 069b0d517077 ("RISC-V: validate riscv,isa at
boot, not during ISA string parsing").

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index bc39fd16ab64..3c06ffc00fe0 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -66,10 +66,11 @@ int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *har
 		return -ENODEV;
 	}
 
-	if (IS_ENABLED(CONFIG_32BIT) && strncasecmp(isa, "rv32ima", 7))
+	if (IS_ENABLED(CONFIG_RV32I) && strncasecmp(isa, "rv32ima", 7))
 		return -ENODEV;
 
-	if (IS_ENABLED(CONFIG_64BIT) && strncasecmp(isa, "rv64ima", 7))
+	if ((IS_ENABLED(CONFIG_RV64I) || IS_ENABLED(CONFIG_RV64IILP32))
+				     && strncasecmp(isa, "rv64ima", 7))
 		return -ENODEV;
 
 	return 0;
-- 
2.36.1


