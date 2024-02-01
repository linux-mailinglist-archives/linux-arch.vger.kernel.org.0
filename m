Return-Path: <linux-arch+bounces-1962-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA0D845255
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 09:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B7A289A4A
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 08:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7BC159590;
	Thu,  1 Feb 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FIdgrMal"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631F158D86
	for <linux-arch@vger.kernel.org>; Thu,  1 Feb 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774767; cv=none; b=K2+8mYUW0SAaR4e557RtNVcBLeZV45tQi9vOtV/dgAs0x+/9JWXetzvWJLClw/3cHReZcdezCBMYo98zsbFQbZfYmz1uPtUDH2twbPPO6BxGxF8ghd43IXF9qHaaDnYPLfn8vbqHPUZYrrzLtzwluwyTv7I9HFwWsWj5wL8Bez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774767; c=relaxed/simple;
	bh=fX+LasV85//JB3JqayRg2DaHh21Pzpe/TlzJPEh9Cz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hw0DY8XRT+gRbW6bU8HsJVSstGTHm/5Azavtm4+SBJQWR4+OC86OxtrMEOL8mMVPbEQ9zzYkbj4ooU+lNebE/cmq8+/K+LH+o2HFXTFXMhF187WaYNX19Am9Iz1WN4WneNXdLD/7SEgrwYXMe0T1tYCvIgnP846wkLdouQ8sG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FIdgrMal; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cdbc42f5efso171889a12.0
        for <linux-arch@vger.kernel.org>; Thu, 01 Feb 2024 00:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706774761; x=1707379561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTPGAhJtcf1MyPZRa7AekzLPzVB6P7R8lGN8K5e/uaY=;
        b=FIdgrMalvruH1KXdta8buHKdfstw3XrRDaIWMiR1eZUjXomHIOUpqmWxPkzjTSU2P9
         KnenHxF6FFkk5ynjYWdnd+eS0wAv/hzM2k6owZhljiaeySltzkyHY+ZcB4Mfe6hqBOWT
         MVC1bNuCdQyG8ONUGuX21dtPiojidgfWBlCsgP1ImqDTxvVGIw/HRX+Jx00dvEXn6k8s
         3L/4iXvYREEK6S/tC2YZB0FaEvlsOAP/2O7f48o1r6erGClLz8qSPzcH7XLXPQnP2onn
         h/QKW4Mwa7JRy+b9DXAdrt5aMwIWvvo7XwVlRoS8Hg9UcsvnpdfGEqxhbngXJGQ7qq+u
         6LSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706774761; x=1707379561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTPGAhJtcf1MyPZRa7AekzLPzVB6P7R8lGN8K5e/uaY=;
        b=RvG1n9ulrJFOMzTbWNzI9Jl6u+17mBOUAzhLqfM8srX+LOSTG6t3eekz4D6FAPO+e4
         u3elrQlUesv6N/gwc5a73pfxk6a+KRLuZZpR5iq89XTfweVFreUeWQwtqENGSXEWVkL9
         F2heMn3f/MIh3UIj+gJRLYn42h79e584gVbY5Q+9Q6/gkkwXhX0zx4WALry0DG9us7a0
         aqzETK/zEZmdYI5jtV2ZKzuCq8oaBOukufdVMHdEA2vReS9iZAWsr8P4bx0E1XYcEKUD
         LRoh4sLDYRy9TU/nT1XECzLNEPGyCKZYKS466yWnfe2x1YA/K1WJiqejzP2Z8ryx7eaa
         OKYQ==
X-Forwarded-Encrypted: i=0; AJvYcCVFfYB3RTcnYecMak8JIQTVlbCvzKp0J2vo5XatvUcZpQk1/NGrVl4qqfB+Dcl7Mydr8u+mYP2hV6+vrZJbt4ecvHBIUQ6hVdEoEw==
X-Gm-Message-State: AOJu0Yyldfj1sAV3mQeAikMGuhHeTWqO+ruQZMuhVfBlgF/utWp0k0HX
	CIP5IqOnpqx9YNpTR2yhSo3iLgOo9rydQozOfUxPOzU6gxd5Z38TUj4ASkLeGSg=
X-Google-Smtp-Source: AGHT+IEUnUoM51cECvFG4aDXlm1WeTlTFMHPR0fA3iZmMtXBOgbtIn54HRGZi2CYU2BKNTL6psaVlg==
X-Received: by 2002:a62:cf02:0:b0:6dd:c870:2f7c with SMTP id b2-20020a62cf02000000b006ddc8702f7cmr4177620pfg.2.1706774761225;
        Thu, 01 Feb 2024 00:06:01 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.153])
        by smtp.gmail.com with ESMTPSA id d14-20020a056a00198e00b006de1da4ca81sm8389738pfl.55.2024.02.01.00.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:06:00 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	arnd@arndb.de
Cc: muchun.song@linux.dev,
	david@redhat.com,
	willy@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 2/2] mm: pgtable: remove unnecessary split ptlock for kernel PMD page
Date: Thu,  1 Feb 2024 16:05:41 +0800
Message-Id: <63f0b3d2f9124ae5076963fb5505bd36daba0393.1706774109.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For kernel PMD entry, we use init_mm.page_table_lock to protect it, so
there is no need to allocate and initialize the split ptlock for kernel
PMD page.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/asm-generic/pgalloc.h | 10 ++++++++--
 include/linux/mm.h            | 21 ++++++++++++++++-----
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 908bd9140ac2..57bd41adf760 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -139,7 +139,10 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 	ptdesc = pagetable_alloc(gfp, 0);
 	if (!ptdesc)
 		return NULL;
-	if (!pagetable_pmd_ctor(ptdesc)) {
+
+	if (mm == &init_mm) {
+		__pagetable_pmd_ctor(ptdesc);
+	} else if (!pagetable_pmd_ctor(ptdesc)) {
 		pagetable_free(ptdesc);
 		return NULL;
 	}
@@ -153,7 +156,10 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 
 	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-	pagetable_pmd_dtor(ptdesc);
+	if (mm == &init_mm)
+		__pagetable_pmd_dtor(ptdesc);
+	else
+		pagetable_pmd_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 #endif
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e37db032764e..68ca71407177 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3048,26 +3048,37 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 	return ptl;
 }
 
-static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
+static inline void __pagetable_pmd_ctor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
 
-	if (!pmd_ptlock_init(ptdesc))
-		return false;
 	__folio_set_pgtable(folio);
 	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+}
+
+static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
+{
+	if (!pmd_ptlock_init(ptdesc))
+		return false;
+
+	__pagetable_pmd_ctor(ptdesc);
 	return true;
 }
 
-static inline void pagetable_pmd_dtor(struct ptdesc *ptdesc)
+static inline void __pagetable_pmd_dtor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
 
-	pmd_ptlock_free(ptdesc);
 	__folio_clear_pgtable(folio);
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_pmd_dtor(struct ptdesc *ptdesc)
+{
+	pmd_ptlock_free(ptdesc);
+	__pagetable_pmd_dtor(ptdesc);
+}
+
 /*
  * No scalability reason to split PUD locks yet, but follow the same pattern
  * as the PMD locks to make it easier if we decide to.  The VM should not be
-- 
2.30.2


