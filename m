Return-Path: <linux-arch+bounces-15585-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED23CE711A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 15:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DC453002B8C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDF132AAAE;
	Mon, 29 Dec 2025 14:31:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4C329389
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018665; cv=none; b=M7+CjQgLic1oBSGYNrqprZpa8hSmComsYoQxy2OXZScFhDhTvRqxfGHfYsWafd0H6z1q+YlLzo3dotPV8vZffVL2/Fw4LP0Pg4CT+3BA20ilDjoW5wE2v4rzDx/IH4IsbGgQbFxlKJnLPnyErS1OauXyH2ZSm/HMUCZmF6Stusw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018665; c=relaxed/simple;
	bh=lC6GEfxIGK/35lvrPF2qw5D86rHWEQ6C/lNcw05H+jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRy569kvTfEzjhqG8ftaaTtXPEZeRcRWb+sqn2ynX5zIQ6CwvSyOj/G2QmUShx6wkDYu8xXpZ/etdc5au3xkF1T7u0DOxDMkArli5VR+SaDzHAhLuzNIGF6hWu8wcTZEv/Piy8hnasVvf1BDMmjc31kVBApyTk9VEWRJH09otxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso14504962b3a.2
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 06:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767018662; x=1767623462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=foHDr6tTVVg2N+oq2ubI3TwM6NJy7Osy+6nFP/DCYQ8=;
        b=Q0KERiooE+TBPQJ0T4+pN2Zvm7K5cEtcYZRFU3awnxqg8YQ3H4GPiYVJNBAuz41LUX
         7YN37b11QXgV6kwZuuckJYbhBaa4s/XwQhIud5N0TrC2NyxHYvC5J1rcJzuK2LVxh8p/
         rBH8eTp2CG5k0d5m1WgvX+BTsb0C0QSYxr2UZcR+z4R8A2jJv76BKp9N7GZK/Qiz8TZQ
         v1UIKvI5G4lUdqi8lUgffb3NfQCoPwYPcjy+EfGjXyc/iFiWDLqXtWnGeGXevKN/RDJF
         RgG4MJKeTk07LUrce9XV99IRmrh68nZYwX9H4QIXpp4S5jywm69Hb4MPVoZn7XUSpjLO
         c6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCU5DtGDnVqXtoZIjeXbPsTreQB1e/sT8WWT4i9VnzdxQHNLPEuXBdaFlLH+Of/Z6cMCOo6P3pl9qQVi@vger.kernel.org
X-Gm-Message-State: AOJu0YxsowBJ7a3mAx4eTbRbWrwJWBXV/SFWzEIlQE9mOfV5l1z7sWF/
	G5j2O2QdiQDgQswuMpHTDWSKj5NpNpOw2t3kBYsv2BB/KHoDbx+Z+Z/g
X-Gm-Gg: AY/fxX5mLoYMvS6UCi4iXx+blnmZ6j9wCZ+XqecI0M0ZvBIECJTDk2OoFT2lRq/Oz13
	d7/TrT+XfiSs8yzC+LGA/uhlyuab2rrqStvdA6GKIjbOXclMpWHMXUkIj/StsIXQf7Xm2m5Iv8b
	vGHyoIKTiZ5K6+09/N4caCaY7F3Z2peYkrFuaBtMtQ/rHxrp73Nob2cfd1FZMu2GJh+U1jEcUbj
	HSoHKcyzQw23yDyYSj5yron9hUxY3sHmYq6Jk14h/XVUh7Sz9Nh7iw+SS1e6WlWJ66+0OZ2lu2G
	eiuio7q0AhJU5TsGIhk1V0bQVdjjhaR8Y+AL+14gW7N3pxgpeQ474Tb9OS+ojC4DCNZafV0x5Sa
	Pt49JdxMRMmnYw7rEUlTYUmebD68rx/aM3dM0QIdwHd7LMt9maynwVOa9+rYMGZE36N73ddozw0
	s16VESVXWdvekXkT/a5QZW
X-Google-Smtp-Source: AGHT+IEcRpszq5Kq79VNLMGams7x9wFNNmMmBbYeukt6SbJFbwCYZtO3VxeJZmswaHVyyAPRvGA8Bg==
X-Received: by 2002:a05:6a00:4514:b0:7f7:4a39:55cd with SMTP id d2e1a72fcca58-7ff6178be74mr27982951b3a.0.1767018661690;
        Mon, 29 Dec 2025 06:31:01 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([103.88.46.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm29705159b3a.32.2025.12.29.06.30.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:31:01 -0800 (PST)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	shy828301@gmail.com,
	riel@surriel.com,
	jannh@google.com,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH RESEND v1 1/3] mm/tlb: allow architectures to skip redundant TLB sync IPIs
Date: Mon, 29 Dec 2025 22:30:31 +0800
Message-ID: <20251229143038.73315-2-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251229143038.73315-1-lance.yang@linux.dev>
References: <20251229143038.73315-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When unsharing hugetlb PMD page tables, we currently send two IPIs: one
for TLB invalidation, and another to synchronize with concurrent GUP-fast
walkers.

However, if the TLB flush already reaches all CPUs, the second IPI is
redundant. GUP-fast runs with IRQs disabled, so when the TLB flush IPI
completes, any concurrent GUP-fast must have finished.

Add tlb_table_flush_implies_ipi_broadcast() to let architectures indicate
their TLB flush provides full synchronization, enabling the redundant IPI
to be skipped.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 include/asm-generic/tlb.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 4d679d2a206b..e8d99b5e831f 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -261,6 +261,20 @@ static inline void tlb_remove_table_sync_one(void) { }
 
 #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
+/*
+ * Architectures can override if their TLB flush already broadcasts IPIs to all
+ * CPUs when freeing or unsharing page tables.
+ *
+ * Return true only when the flush guarantees:
+ * - IPIs reach all CPUs with potentially stale paging-structure cache entries
+ * - Synchronization with IRQ-disabled code like GUP-fast
+ */
+#ifndef tlb_table_flush_implies_ipi_broadcast
+static inline bool tlb_table_flush_implies_ipi_broadcast(void)
+{
+	return false;
+}
+#endif
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 /*
-- 
2.49.0


