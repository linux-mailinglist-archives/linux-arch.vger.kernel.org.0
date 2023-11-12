Return-Path: <linux-arch+bounces-174-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C27E8EC8
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B863B20945
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090E75394;
	Sun, 12 Nov 2023 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxp8Fc+v"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20135386
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E562C433CD;
	Sun, 12 Nov 2023 06:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769960;
	bh=dK4ton2oM+HkEOBvpM4c5CJzMl0JR/DxER2w5fW1tdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uxp8Fc+vLd1OxaYU6JHEobJ9lYSoyT6mwQRrxVaQHLsmnTO1D4uf+oE/hQ8pZEfO9
	 pAJtj7VRnQ9zBG+TSXtv6eTkf37UxZfFA4Hk6LYgFrXIqwAxwW3ZQ4F6/k/0DduMCE
	 qlMYWbc751aEgRudX/rL7cUXLbpS/X1y9DOGeZanW1TTWYFUnokD9byjiEHodJcu/0
	 Iil9U3Uaf5n9IISv32EMhC743m6kyCSKZ0VQ8t5k6qmeNHW0AonN8PVg8eZ+kxeheI
	 GRPTmdj+kurQ+mOgDuTqewn0Cj7scDwDXghLYpCxYR1E7IYwBjETB1B1XU5saALSBk
	 f3A5BZh6NAhWg==
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
Subject: [RFC PATCH V2 38/38] 64ilp32 v.s. 64lp64
Date: Sun, 12 Nov 2023 01:15:14 -0500
Message-Id: <20231112061514.2306187-39-guoren@kernel.org>
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

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/Kconfig            | 1 -
 arch/riscv/include/asm/page.h | 2 +-
 init/main.c                   | 2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5106eab17811..acd6aa60ed84 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -160,7 +160,6 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select UACCESS_MEMCPY if !MMU
-	select ZONE_DMA32 if 64BIT
 
 config CLANG_SUPPORTS_DYNAMIC_FTRACE
 	def_bool CC_IS_CLANG
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 7c535e88cf91..f9af3e6b6e21 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -106,7 +106,7 @@ typedef struct page *pgtable_t;
  * We override this value as its generic definition uses __pa too early in
  * the boot process (before kernel_map.va_pa_offset is set).
  */
-#define MIN_MEMBLOCK_ADDR      0
+#define MIN_MEMBLOCK_ADDR      0x60400000ULL
 #endif
 
 #ifdef CONFIG_MMU
diff --git a/init/main.c b/init/main.c
index ad920fac325c..f88f0227e398 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1496,6 +1496,8 @@ static int __ref kernel_init(void *unused)
 	    !try_to_run_init_process("/bin/sh"))
 		return 0;
 
+	show_mem(0, NULL);
+
 	panic("No working init found.  Try passing init= option to kernel. "
 	      "See Linux Documentation/admin-guide/init.rst for guidance.");
 }
-- 
2.36.1


