Return-Path: <linux-arch+bounces-9537-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C1D9FE442
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2024 10:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC3D1622C4
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2024 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1C19F111;
	Mon, 30 Dec 2024 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fdipIao0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4971A239F
	for <linux-arch@vger.kernel.org>; Mon, 30 Dec 2024 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549785; cv=none; b=ZIjHx5vZt62Zg7pdpVDOy3TXSoEGnTyWrWv9GmWhESfhrj0QIxcQ8sTy3SZrwRC2rZuqZkcbtEYkyWdwEp6nctmY/agQmlF2WrgOQlhuPxJ1ZXetWUG4j0FFXs4XDI9jX0n0pq0+eXXwN+XdNCNN8CETvZJsFLZONBPraRm/Gfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549785; c=relaxed/simple;
	bh=jiyynG1cSpqMCUPKcTsBXQhnImP0khzMQlCaAfJaSPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=peQumK/9pL4Gb0hLH53lKBSuAGvBwE1d8Ht+CrrAdtiHWCpE4B7HpbZN/dWTEePE9xLFPuaZHc5z4XFyB8Er/nT/W3AAip2v/qMEqlRQIwQDP0AFY+VefurF/DO//HEharwGbboLmPzXgm+QcnDlPqYRv8AOWS/6MNyHg935ZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fdipIao0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216395e151bso83725535ad.0
        for <linux-arch@vger.kernel.org>; Mon, 30 Dec 2024 01:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549783; x=1736154583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYmLHVK0AtU6ilI7ucnXt5jLNeYE7S1uMrvnVL/VK/o=;
        b=fdipIao0MfSzxuzWBCZMky5alX88xvN/MbnJ7aPPBrjTGMYdonXH3cQrXGOHC5BHGE
         1CbLRJGaZxP1k1OqLK5kcQIBeZFLwaPeflUsR6iUfioW884T1x2GaElMYG8WcXvobHur
         qSyL2ak4CGHxE0+qkv3L3oZZwquzLAy7uhHSGY06u61YsJVW1GyrK7KB3k7iLma6kKHd
         /A7xHVXQyHnufhe1DeBAMI+ir7bl7aIUJ5Q9fy+XvlRUZnCk2K+cttwdro0r0LiMX0h1
         z1uBoeakBxn5ROMm17+siFl282KcIVBDdT0DWK2hUfV+gA1XeXj30OutE3Sw5VsybpCB
         af1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549783; x=1736154583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYmLHVK0AtU6ilI7ucnXt5jLNeYE7S1uMrvnVL/VK/o=;
        b=WPCMPi79ApyAvY1lcOLfca9vclPD9wNrG9kaGH8uxEwktD8PWIyxhDmHNqVStmfreE
         2jCwWjPPI2+cjzJs45BB67b5hNKfSWEU8VBZk3DKRwclNrUJTqlxKl7Sgn+EZYJWo5nr
         IP4kyol+6F+hGqDo6NAuKoTsz0VavfFsRlFRek3jFZ11v1l8zvgz+MD2JwbrG4ot9HRE
         9JhEvAJ3BbdaDJtL4zPATpSRUNl+0E/4mfGqKKoqTW+/AGKqJ7/LCx6jr0R5tDFwgwKV
         6UfdGNcktEa87rxBSSJaoGTRorPsWwpHiwIFaFgZ91U4IrZawLG8chfUEDYr0AUjBkQl
         aWWA==
X-Forwarded-Encrypted: i=1; AJvYcCViGzxxaCVIIXBklY9nAxVAC1D8//dPt6wtjuvDuAxY7vzmkYJrbr8zK9WH75VEuO1FZKESbEkec5IN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8doKuieu/8KVTiDNA8krYSaMWIaqHGCHZMdZA4s1depvRD6Pu
	7892QxdmG+iZC2IowlVWHgP3RRgs1tWj3xNslM9xcly0mX/jQ5YOVyfo0yAwJ1Y=
X-Gm-Gg: ASbGncsMRexymBno3yHUEtp7uQ0TqVlvxrYhycKXhcQZPSZBqYAUjUlavrGx0nYFWWR
	eBrQyP3/7DJbIY04yJUdM0aKOQCPzRJ+S7jLRDdnGogjovopOxLpDdD7pq9i/szfzt8PRi36OR4
	JQv+HyWwrXPBp2P+tafLFGPPV4F2L/xvJRpFonh3R1DCMMtkgT3+V6WyY2pPN5MzAu9Nx+4Op48
	Gi7p76oHiSX6bhaqGTpB+5hz9PMBPPwR63nw/j1s72yZcD6AO+c1LWuCPqC4iZpLB17eO2v4lvi
	X2ZzgN9E8xRQMdSd20ovdQ==
X-Google-Smtp-Source: AGHT+IFA+DEWtAOVikEXL1Ne96u+hKYy4bbBxlgPSiON1NV20vNo54NDlhKj2iEhoHPJgNNx6Etn8w==
X-Received: by 2002:a17:903:2a87:b0:216:3f6e:fabd with SMTP id d9443c01a7336-219da5cc2d0mr588821545ad.7.1735549782882;
        Mon, 30 Dec 2024 01:09:42 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:09:42 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	palmer@dabbelt.com,
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
Subject: [PATCH v4 05/15] arm64: pgtable: use mmu gather to free p4d level page table
Date: Mon, 30 Dec 2024 17:07:40 +0800
Message-Id: <7c12112047ac230809aacd0379259414b9b0d3a3.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other levels of page tables, also use mmu gather mechanism to free
p4d level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/pgalloc.h |  1 -
 arch/arm64/include/asm/tlb.h     | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2965f5a7e39e3..1b4509d3382c6 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -85,7 +85,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
 	__pgd_populate(pgdp, __pa(p4dp), pgdval);
 }
 
-#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
 #else
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
 {
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a947c6e784ed2..445282cde9afb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -111,4 +111,18 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 }
 #endif
 
+#if CONFIG_PGTABLE_LEVELS > 4
+static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
+				  unsigned long addr)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
+
+	if (!pgtable_l5_enabled())
+		return;
+
+	pagetable_p4d_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
+}
+#endif
+
 #endif
-- 
2.20.1


