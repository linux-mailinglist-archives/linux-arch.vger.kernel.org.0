Return-Path: <linux-arch+bounces-9474-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497409FACBB
	for <lists+linux-arch@lfdr.de>; Mon, 23 Dec 2024 10:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1485518812CD
	for <lists+linux-arch@lfdr.de>; Mon, 23 Dec 2024 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAE41A0721;
	Mon, 23 Dec 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jCnmVm/T"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD11AB6CC
	for <linux-arch@vger.kernel.org>; Mon, 23 Dec 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947166; cv=none; b=NLQMzualJ0kqbPDFEeO2ogoTcRzhkgu2l/qwdjie6kRBFX70Y7sLVJoUdTgv3yDOSv37zQnlG7kERhP/jQzFdTh4jUhQwpwWrRgXXF/fLpja9pM0OaEZPPszjf0MHmCfrECyG6Kjhnta/RBF9nzBRHVS/ovXGnkTpyj3WG1oyY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947166; c=relaxed/simple;
	bh=AOHzYz3e0W68bypaywk5PqwWiTbsh7X+wa84FHfFzTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KtyUibiQfAsyBRL7YFYarVwUUiVLco/Q7b6HQhUdkHMK3vgaKWiLAmgPH5aL8hWWsWblMAk0E7Xdz5vn7A6+Wree/tbmZWjtBe7SF83b/t/f+ZtUVw/r3eajyNPLVkYcoygmlzMmqczE4YI8VD2W3a0PeUSVWkgbr4iKPJsoUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jCnmVm/T; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7feffe7cdb7so2366292a12.1
        for <linux-arch@vger.kernel.org>; Mon, 23 Dec 2024 01:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947162; x=1735551962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAJKsDdGNb+ALwQvMYs9Oz9Vq8VGrLJsA8GxB+kZmZc=;
        b=jCnmVm/TIkWfMytO3QSvme+fClSmAs5pduO/mAkMupwhIOpUfFfT0a3ztDvuFTYn5X
         xT2uM1aGyiOwIR+C9EaLYuyPxt2SR/yGOOBAUlRT65QH2trNelA5QjzYqPSWsJMv/i/d
         l4xnCtTVB5DF9mzcFgJjM0DMcPXqsEH/UO4gwmjhAOJMRBiue2pkcDHI1Rg/S7WuRQDa
         ihyfSL5wA9wS6NUaqQOQzoMWsZcVdkfUZeATeboLiBmZk0Po2kUCbCy0SrDbrr/RRcPi
         +Yq4JF0UJqbtc7vn6uPNiBws5Y7vMX6ew/SjBHUnM/zACZH0GvcMphrcUP3vLj0GTQg4
         b5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947162; x=1735551962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAJKsDdGNb+ALwQvMYs9Oz9Vq8VGrLJsA8GxB+kZmZc=;
        b=ZEbdxXejT4n8AndhSva4aIf/vJnCiUDr2ml0Ij5tCIOqOeytpaY0UVlX+xYJthDV6T
         p4DNfThCowVoauw9AQynPUhIVd3WlL8dYHqqaQ+rcpHxvnlmBIDZm2/FKMaAB9rMP5gR
         RobHvXP5015fhP4sN5o/qjnQVFbF5B3hS6eGjEm4CehTdA5iyWn7REgNap0iUj/pnAdF
         5DC4M6Uk7wCMnaeiFyW7qQS/cK/xH8t0WjJY7loEV9LW0nAYrvq9/vKxh8sa+JAwTrpY
         EaOAf+vLd46uqANHqwz8BeQ/QHIzfEgambXCds41q2CPP/xoGrnJA6+fgTDqKw3PMNiY
         l6pw==
X-Forwarded-Encrypted: i=1; AJvYcCXSjar7snLIIiPnLRNf3r2DOB4gXPggE6adQ5Dab9lepH2lQR2FeMOS1RRN6EVsvRIfeVu82B6Kq36l@vger.kernel.org
X-Gm-Message-State: AOJu0YzBSNeHRmpB9oEJRLc3J31EreS+9Wgc9yrnGqhW97JEsDlgWizC
	GhGC+KHEU62OVF/pjt63sCSehWkUVI1pht/1/oPeSkwdDkYaoABRCouhccBpu+o=
X-Gm-Gg: ASbGncu3gkGryrHXq00rVj2vgEnWwQzbzmz71W4vBc/iFNa5Xvp2MBrfmv9u88jHD7w
	yzxmAM7U0C1ljLoUeo0ohCRfGF1aQi3I0XZKN9Nump+5bT9zj4o/NO8gRd2vj+DdVAUhOHOdgjO
	ukWg1vzqlzLULjv9UU79gZcDr4AXFJq5P85mRAVcLAe9qr6aY1DeDg18HZYjHgy8RAm4jdbgeFt
	IlHG3xNdjk1iirIrQwd0SsEbsRkwBiwvt2foF86yqpwlUcurkZhtNQdyYVBfZF2fLIF9i+AWbmM
	UeWA54b6bZ5aHhz9lNyngQ==
X-Google-Smtp-Source: AGHT+IEiKQiNoCztX+vEmXJ78+SVJHcoRjQcReSYKDpgexw8hG6RQW+fGx0o5GN+OmUz8JwpFgmgkg==
X-Received: by 2002:a05:6a20:c88f:b0:1d5:10d6:92b9 with SMTP id adf61e73a8af0-1e5e07f88demr18787949637.30.1734947161832;
        Mon, 23 Dec 2024 01:46:01 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:46:01 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 14/17] mm: pgtable: move __tlb_remove_table_one() in x86 to generic file
Date: Mon, 23 Dec 2024 17:41:00 +0800
Message-Id: <286e9777dd266dc610de20120fae453b84d3a868.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __tlb_remove_table_one() in x86 does not contain architecture-specific
content, so move it to the generic file.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/include/asm/tlb.h | 19 -------------------
 mm/mmu_gather.c            | 20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 3858dbf75880e..77f52bc1578a7 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -20,25 +20,6 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
 }
 
-#ifdef CONFIG_PT_RECLAIM
-static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
-{
-	struct ptdesc *ptdesc;
-
-	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
-	__tlb_remove_table(ptdesc);
-}
-
-static inline void __tlb_remove_table_one(void *table)
-{
-	struct ptdesc *ptdesc;
-
-	ptdesc = table;
-	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
-}
-#define __tlb_remove_table_one __tlb_remove_table_one
-#endif /* CONFIG_PT_RECLAIM */
-
 static inline void invlpg(unsigned long addr)
 {
 	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 1e21022bcf339..7aa6f18c500b2 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -311,13 +311,29 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 	}
 }
 
-#ifndef __tlb_remove_table_one
+#ifdef CONFIG_PT_RECLAIM
+static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
+{
+	struct ptdesc *ptdesc;
+
+	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
+	__tlb_remove_table(ptdesc);
+}
+
+static inline void __tlb_remove_table_one(void *table)
+{
+	struct ptdesc *ptdesc;
+
+	ptdesc = table;
+	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
+}
+#else
 static inline void __tlb_remove_table_one(void *table)
 {
 	tlb_remove_table_sync_one();
 	__tlb_remove_table(table);
 }
-#endif
+#endif /* CONFIG_PT_RECLAIM */
 
 static void tlb_remove_table_one(void *table)
 {
-- 
2.20.1


