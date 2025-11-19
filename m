Return-Path: <linux-arch+bounces-14894-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 866BEC6D2E7
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 08:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D85FA4F7158
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940B932ABF1;
	Wed, 19 Nov 2025 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LUgmfphZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F132ABD1
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537621; cv=none; b=sc+XBtD9TaMDgmC4QDDayMcRnLxP/QKYoxcD9wW82mEfGxQqmBTcRAXmx4MxkbigJtoVM+Z3VTXK9zmTxAVSqhxldYcbzR7CcuoWDZu21CuTyCpeTgu5dly2eoMcCR0FtxFCgRSZ9c/91ZLuwxcsEHtxWGgiyq6x++/BHHaBHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537621; c=relaxed/simple;
	bh=opxRmBMekzq2+Xp2ELM+kTyKgoYL1xD2QEfTCfk+1go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9xS0PzSc333k2G2fOu6foyZwTFKqgG9i0RiZrx2QDrcQ3v44qOmBNcb/aHbA43e74Xz+MXIuUbx9EoEu9Fc2VnC4NTn17CWZe5AK8+4aNssmVqZ8zgw2Q49MZrXxU9Ubdb+snHpZMLuYKCL8H37K+mxrrsr3g2EINhDF7fISKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LUgmfphZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763537617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/QZPwfh2tBLiGMNDgv3nVc2+27U6V/3aKYz1C9WyO4=;
	b=LUgmfphZq+fvy8Fvu1tjVnrqGz9k2q8SBhj9h64+wRn+7bojNcXZyqdp6prQqscS2feFX8
	bObNs5syxHC8+5XyV15RIhnayEGuvN50r1EUj1rPlsxFv7tOY7PB78KcZic/oWfkHREL8W
	JIpYE0IsfsnkMqTZu6kB6Akc6TgnRVo=
From: Qi Zheng <qi.zheng@linux.dev>
To: will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	dev.jain@arm.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ioworker0@gmail.com,
	linmag7@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 7/7] mm: enable PT_RECLAIM on all 64-bit architectures
Date: Wed, 19 Nov 2025 15:31:24 +0800
Message-ID: <caacf08b765ef00770b7c75afdb5e5754485b2aa.1763537007.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1763537007.git.zhengqi.arch@bytedance.com>
References: <cover.1763537007.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

Now, the MMU_GATHER_RCU_TABLE_FREE is enabled on all 64-bit architectures,
so make PT_RECLAIM depend on 64BIT, thereby enabling PT_RECLAIM on all
64-bit architectures.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/Kconfig | 1 -
 mm/Kconfig       | 9 ++-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eac2e86056902..96bff81fd4787 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -330,7 +330,6 @@ config X86
 	select FUNCTION_ALIGNMENT_4B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
-	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
 	select ARCH_SUPPORTS_SCHED_SMT		if SMP
 	select SCHED_SMT			if SMP
 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
diff --git a/mm/Kconfig b/mm/Kconfig
index d548976d0e0ad..94eec5c0cad96 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1448,14 +1448,9 @@ config ARCH_HAS_USER_SHADOW_STACK
 	  The architecture has hardware support for userspace shadow call
           stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
 
-config ARCH_SUPPORTS_PT_RECLAIM
-	def_bool n
-
 config PT_RECLAIM
-	bool "reclaim empty user page table pages"
-	default y
-	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
-	select MMU_GATHER_RCU_TABLE_FREE
+	def_bool y
+	depends on 64BIT
 	help
 	  Try to reclaim empty user page table pages in paths other than munmap
 	  and exit_mmap path.
-- 
2.20.1


