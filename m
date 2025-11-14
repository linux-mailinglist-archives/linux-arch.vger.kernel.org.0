Return-Path: <linux-arch+bounces-14748-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B459C5CCE0
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 12:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FE73BB862
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EC5314A67;
	Fri, 14 Nov 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B1fHws4v"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED33314A61
	for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763118852; cv=none; b=U2DVu9ll0SAtBjM7LRVcquhzYJw0YcyBYhC811hR7VEPRI+O1Ea7Q3UCJxqC3g2aLmqd1PqBLdzSlCnzVw16eH0qs91QNXlsux5uUMypIPNJvbOGyI47LP1s0MIb9/ChaThTEeCGwen7cZupHJOcoGFkOu1/NY6nCSd+xNfEZ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763118852; c=relaxed/simple;
	bh=CXsWQVszD/4e4l8zbTDqOiyMxntdOa/q50nLcbN+x40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqGTP25gVv+5ysfS+rEZXcqW+RruDZfxk7ooWyp0GDm9J/etZA7SgGRx52tQ0lBxOX4gbz8WIKL/a7qQ+A/g2cnxD37VXjG8fmvJn3ti69S5h/J7J+8t3RQrjdD/hlc34rTKz5wkc744rl7bMRUl+yojMs5CtwBhSXgrMncnfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B1fHws4v; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763118849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MvAZBElD0X3pJk/MX8AXoxW4zTACm8dJmSYdSV26R0=;
	b=B1fHws4vdV9SHk7Nm4NMEkMGypQnWt5ebGnT0lkQhYxPSrPX9T5usjJtN8D6xLK5/tENRj
	6lr6jCeTav9vHkLaX2Cm/MDvr39umGBs008BSWf4p0qasklCP7V5XJNNR/0A712o57bV/X
	UdgHrzzazzIM8MjWkX4twJlrGaTbo7c=
From: Qi Zheng <qi.zheng@linux.dev>
To: will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	dev.jain@arm.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 7/7] mm: make PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE && 64BIT
Date: Fri, 14 Nov 2025 19:11:21 +0800
Message-ID: <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1763117269.git.zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

Make PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE so that PT_RECLAIM can
be enabled by default on all architectures that support
MMU_GATHER_RCU_TABLE_FREE.

Considering that a large number of PTE page table pages (such as 100GB+)
can only be caused on a 64-bit system, let PT_RECLAIM also depend on
64BIT.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/Kconfig | 1 -
 mm/Kconfig       | 6 +-----
 2 files changed, 1 insertion(+), 6 deletions(-)

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
index a5a90b169435d..e795fbd69e50c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1440,14 +1440,10 @@ config ARCH_HAS_USER_SHADOW_STACK
 	  The architecture has hardware support for userspace shadow call
           stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
 
-config ARCH_SUPPORTS_PT_RECLAIM
-	def_bool n
-
 config PT_RECLAIM
 	bool "reclaim empty user page table pages"
 	default y
-	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
-	select MMU_GATHER_RCU_TABLE_FREE
+	depends on MMU_GATHER_RCU_TABLE_FREE && MMU && SMP && 64BIT
 	help
 	  Try to reclaim empty user page table pages in paths other than munmap
 	  and exit_mmap path.
-- 
2.20.1


