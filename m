Return-Path: <linux-arch+bounces-15482-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14910CC6E9E
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 10:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02C553027DBC
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15C342151;
	Wed, 17 Dec 2025 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pyc1KpvA"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D267341AAF;
	Wed, 17 Dec 2025 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964853; cv=none; b=hbA9Q4nxm2IhaB80xBaYN/0vAMjrskgItOoPhfO1hkCYFthBrmnEuILt2fSd3Z/xNGQ1LdW1L3I517W+hm8eGCK/bNVFd2zmCQyvNSRdaBOGSDr/ANHBUMlS6SbMpPyIoVQhKohPeX6VYoaqwOn8YZsxwH1dXLxG3yUMyMpXKFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964853; c=relaxed/simple;
	bh=9RDc6+mY/BOwjSpoEwGFWhPntxw3uW/Hv6MZvdDJ5eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZzhkxk68IFgFTdXkohAbcpjrD2Yy2o8YvuyzDMtdQUblNRQMzFj+anxVlmB6xUmxslQSZChWTQeSNlEf3iE02yMznzdxOjHQyaVJfEPaZWLghAe7A+RQ8miB5QmIbYEfrwav63AjB4qDLsR0k7NbYnH29e7ej5GJQXVzLRc2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pyc1KpvA; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765964849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6yDfSie6tI+R/bkHsg8f30F7brlmJ878+dqsdcToXoQ=;
	b=Pyc1KpvAxk811HYK04xjZpyTzpEkJYxqqJmPoGGAQiXIyGUCHOz7UnqXrw4Idz7ei3/Hvn
	nKx4SWPSfqUG4f91J+BuNBSg1KCzxG0cBAC6q78EOJ3y5AH8vsj9RdwGKsDwh1k/3OGPBu
	+BEuL1tluj818rz3TGgaraPxgsFz7Rk=
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
Subject: [PATCH v3 7/7] mm: make PT_RECLAIM depends on MMU_GATHER_RCU_TABLE_FREE
Date: Wed, 17 Dec 2025 17:45:48 +0800
Message-ID: <ac2bdb2a66da1edb24f60d1da1099e2a0b734880.1765963770.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1765963770.git.zhengqi.arch@bytedance.com>
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

The PT_RECLAIM can work on all architectures that support
MMU_GATHER_RCU_TABLE_FREE, so make PT_RECLAIM depends on
MMU_GATHER_RCU_TABLE_FREE.

BTW, change PT_RECLAIM to be enabled by default, since nobody should want
to turn it off.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/Kconfig | 1 -
 mm/Kconfig       | 9 ++-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 80527299f859a..0d22da56a71b0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -331,7 +331,6 @@ config X86
 	select FUNCTION_ALIGNMENT_4B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
-	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
 	select ARCH_SUPPORTS_SCHED_SMT		if SMP
 	select SCHED_SMT			if SMP
 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
diff --git a/mm/Kconfig b/mm/Kconfig
index bd0ea5454af82..fc00b429b7129 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1447,14 +1447,9 @@ config ARCH_HAS_USER_SHADOW_STACK
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
+	depends on MMU_GATHER_RCU_TABLE_FREE
 	help
 	  Try to reclaim empty user page table pages in paths other than munmap
 	  and exit_mmap path.
-- 
2.20.1


