Return-Path: <linux-arch+bounces-1136-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293C8818F2C
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 19:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C3C288000
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 18:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D37B39AE9;
	Tue, 19 Dec 2023 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvEJaO/t"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C394739AE7;
	Tue, 19 Dec 2023 18:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01013C433CC;
	Tue, 19 Dec 2023 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703009013;
	bh=jOzh15UGY8/GeKyvzomEjUoOApjigEX2YDPvhINsBhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BvEJaO/t7fLRI9ME+g6Nf2uKvBFzhDxeGVkHtu0GNM/cuRLsGbH1Dn5794sKOGhX7
	 t2neLuWSxp8mcJ6f0iqpeVhqi4qYZ8ahPfVqN2Da62LUO4i/t7gL4bmvdBqH64Llyn
	 QkRpi8dmIk/b/s2jltgElLVpM3vEGAMoladx4fbNv3xbFj5qlDKciiWQ+lStLf8ju1
	 pub/Wz86s+HQWQ3Ve18yw7Zyy0EcvOkhR8zgpWpEnigIMCNNdI7HcIC4rkQ9U2GhTK
	 L7bquPxY+IC1hy+VduUcpRaujnplUMl8dZNy79gV5MHb1aIEYQXoOGfUkVwIpLYaME
	 gcTZZsxBtN4Pg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/4] riscv: enable HAVE_FAST_GUP if MMU
Date: Wed, 20 Dec 2023 01:50:46 +0800
Message-Id: <20231219175046.2496-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231219175046.2496-1-jszhang@kernel.org>
References: <20231219175046.2496-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Activate the fast gup for riscv mmu platforms. Here are some
GUP_FAST_BENCHMARK performance numbers:

Before the patch:
GUP_FAST_BENCHMARK: Time: get:53203 put:5085 us

After the patch:
GUP_FAST_BENCHMARK: Time: get:17711 put:5060 us

The get time is reduced by 66.7%! IOW, 3x get speed!

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig               | 1 +
 arch/riscv/include/asm/pgtable.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d3555173d9f4..04df9920282d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -119,6 +119,7 @@ config RISCV
 	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
 	select HAVE_EBPF_JIT if MMU
+	select HAVE_FAST_GUP if MMU
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ab00235b018f..c6eb214139e6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -673,6 +673,12 @@ static inline int pmd_write(pmd_t pmd)
 	return pte_write(pmd_pte(pmd));
 }
 
+#define pud_write pud_write
+static inline int pud_write(pud_t pud)
+{
+	return pte_write(pud_pte(pud));
+}
+
 static inline int pmd_dirty(pmd_t pmd)
 {
 	return pte_dirty(pmd_pte(pmd));
-- 
2.40.0


