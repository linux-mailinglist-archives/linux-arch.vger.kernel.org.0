Return-Path: <linux-arch+bounces-9645-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B4A0543E
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 08:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0B93A6E9A
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 07:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B221F0E2F;
	Wed,  8 Jan 2025 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KtvLg51X"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ECF1E570E
	for <linux-arch@vger.kernel.org>; Wed,  8 Jan 2025 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319822; cv=none; b=FCrV6XeULaoAFxRVneWRvUUOJiIWpFAXpnmGy8++jOaSwCfcZtB0Zl0i9jtYaJ+0pohNjKuWcv4HRMFJjb7FxYU1eO9Ljk1AnRqbC3T6T9RR7ZN70jkBP+4aSyse10BG5tnX2ooTNQOSKTfXyIv1njv1J5lyaV2I2dOn7ydW3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319822; c=relaxed/simple;
	bh=6Tm9tzzLwfPI5sWMJ+gGPjjpg7Ij0ovc/RrCPGoP6W0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szCGDzfmVfMS7VqaCo2DQB5s8UiS10AbxOtzUnuOMecOR2E36zPt7UPkHCgVRAfCLa9xZ2w6+lQQh0DK6YfQ8gbYKGt/AcWrMBoHc21gbwWsPGYAcfrvyKo0EvK4wID0e6SL8ewKwxOnfGZK/5eQlEirVBexteiRWg84hekI5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KtvLg51X; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2167141dfa1so9535455ad.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Jan 2025 23:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319820; x=1736924620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmV2C/123ilQKoYc6h41pKDzG2aiaIfZ7nQkaBcWxp0=;
        b=KtvLg51Xue1YBzIOtDDnaKVLDxho5Y6O34b3QLXYGujr9xXAirsHXiFIDJ98IjU9oz
         Z0hAvHLsx9XPp3Agplnwmdgv1qA4pbR9wYkuCUL2dZ92URLD0cl6irNm7klKTt/Is0tm
         4JLj7aE1faDKWpUwyXHPqT4sgeuViPZFzB2ipUzZMoMJ296x2IbGR20ZTsAMf8/Au32o
         CIOBHWY/teEwvunVztgAgLPbdBy3ANmKwDUgjV3S+uTok9chdNvvXzRT2hGQqLXZcP1s
         LvQFH6G/sHCtN/HFAGvMHOg0FcCEXTRuZI0StA33iKs4vlrGO5YuafH2wd1ZbnK0lL1T
         VwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319820; x=1736924620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmV2C/123ilQKoYc6h41pKDzG2aiaIfZ7nQkaBcWxp0=;
        b=s3mU8PVydVqAC+OwcXeBePZ/rJ8MBKSLjyZBQ8LHbItanc04Kbo4tIyf7ZNxs0fYB4
         VGyrrrloqfIklsXqssUmcTXjHgPP7VMQZAay4hTn6Dvd8Q8Ty4dlKnsajEb0s/bl+sD1
         Ba/S6ruaZofjkbgyWYvSSOTpo/mjUJZ8vEzpYGWowvaCtpDfLKfdDQahL7cDm01/IDkH
         Eyqj6FfPZC5K6P8u/LnAi+i4MTo0l85GTiafQ68xSjZkFze28IZCSxUqKuNtlF929rxW
         hURMI6SuNYwl3LPgN4lgrM3XyjCFQooKwWyJbKyrZZYMVQlT6HtCz3BHNbALn44+omQ2
         39bw==
X-Forwarded-Encrypted: i=1; AJvYcCVmL3vTOu9EToBBywobrq7wV7AKUIjTd2SBZskwL9V1lgL0rNvUtd16FrDeCIFUKxXJst7m+rdk6Lcj@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVcYywNT3sgwN4gMXeCJdKW9hlcoHftnkKVgr8MZ1H3lkd2cI
	YZkKlVEoBPN/WK1zdF17hqkDIkrl3yiq3JpnUxeuLH+GrsHCaVDd5HYBG0M1rNo=
X-Gm-Gg: ASbGncvQFwJIFR/Ht3I7Wpl+mn80V7wpwzr02nh7/ubZW9icMq8BRXCtYxIP6VrArgO
	8oCj572uloCVun3Dm77C2ZM7VHkuRcgOe80QoNK7Pcz8l11rdmiariJSmo1pFAiRMHXyFYOHrYl
	jVL99cFnyqlKp5bEF3388cPjJAbDGc9YK2LXRgRg34I1JBObDAnqs/MyfZ53cP2t1mX/CmUEMCs
	bcteuH2OwqpIHerpbyOW+yJ0hHCGowF8MHRJ22x/WH32w0Ia56LPImx+uFKHavOLVVXaKtXNocP
	0yO9l4pbvB9H90Izebg/LPu4WgQ=
X-Google-Smtp-Source: AGHT+IFPhscn4ro6sBJsBOR2a8pRlJGCRsiSDouRo+43OGNlwIzbjZLHQRkjQ8iB7a2FmZbbQjyk4w==
X-Received: by 2002:a17:902:fc46:b0:216:4fad:35d0 with SMTP id d9443c01a7336-21a7a1d4731mr100818035ad.9.1736319820276;
        Tue, 07 Jan 2025 23:03:40 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:03:39 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	alex@ghiti.fr,
	andreas@gaisler.com,
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
Subject: [PATCH v5 17/17] mm: pgtable: introduce generic pagetable_dtor_free()
Date: Wed,  8 Jan 2025 14:57:33 +0800
Message-Id: <1663a0565aca881d1338ceb7d1db4aa9c333abd6.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pte_free(), pmd_free(), __pud_free() and __p4d_free() in
asm-generic/pgalloc.h and the generic __tlb_remove_table() are basically
the same, so let's introduce pagetable_dtor_free() to deduplicate them.

In addition, the pagetable_dtor_free() in s390 does the same thing, so
let's s390 also calls generic pagetable_dtor_free().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
---
 arch/s390/mm/pgalloc.c        |  6 ------
 include/asm-generic/pgalloc.h | 12 ++++--------
 include/asm-generic/tlb.h     |  3 +--
 include/linux/mm.h            |  6 ++++++
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 3e002dea6278f..a4e7619020931 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -180,12 +180,6 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	return table;
 }
 
-static void pagetable_dtor_free(struct ptdesc *ptdesc)
-{
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
-}
-
 void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 4afb346eae255..e3977ddca15e4 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -109,8 +109,7 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte_page);
 
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 
@@ -153,8 +152,7 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 
 	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 #endif
 
@@ -202,8 +200,7 @@ static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
 
 	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PUD_FREE
@@ -248,8 +245,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
 
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_P4D_FREE
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 53ae7748f555b..e402aef79c93e 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -213,8 +213,7 @@ static inline void __tlb_remove_table(void *table)
 {
 	struct ptdesc *ptdesc = (struct ptdesc *)table;
 
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cad11fa10c192..94078c488e904 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3001,6 +3001,12 @@ static inline void pagetable_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
+{
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
+}
+
 static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
-- 
2.20.1


