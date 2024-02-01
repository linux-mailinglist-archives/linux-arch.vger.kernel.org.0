Return-Path: <linux-arch+bounces-1961-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B52845252
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 09:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B9B288EA3
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 08:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBA61586FA;
	Thu,  1 Feb 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BZLJuWKx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E714C5A2
	for <linux-arch@vger.kernel.org>; Thu,  1 Feb 2024 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774760; cv=none; b=V/jWINbKNAXfc0gd7wJ88RP7zs286EmoYCrGeTl6bTFe5x+n+KA+d8t/QsEapRwcLt9zrLJ0bapCW6qpjjgHy+6G+Ii0vSZ9LX9jKlF4tUy7ps6SEG8yeXRiZ9KN5dO7GVHuRzDctVdhkuwoLiwK5Lw0yK2ZYh3lPcpzoSzW634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774760; c=relaxed/simple;
	bh=UFjVSsl6NY5jcy9u+P6W6fC+epRmU3IECOgX+lhK+Oo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QBOg4bW6vRRzH4SYOuU8uj+h85zPjWYm3e4gfu/MsY7vnO/SF/VpO4KclAhzsOrYwFNu50VHQrzSP+YPPKZxbKmuBs1YxBmZqqras9kTB5LUi7WNFiQS/1XUpVNdiGoSNItgG1sfPLJTcLTLasAAnlAPJr8k1TAYVAbHPL0Cqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BZLJuWKx; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-363a5fc8b5fso74915ab.0
        for <linux-arch@vger.kernel.org>; Thu, 01 Feb 2024 00:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706774757; x=1707379557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUqkQTp/EejRMwYJr1zUIe1l3Bx/6LHMX3gDVJzEF5k=;
        b=BZLJuWKxY9cWyv+yJ0YHx5za3LhQ9hTVNOEpTX58KCmWUT25n2mRiVmojAJOTxa7tA
         301slMpaQpuezgC7tuEWRcwpvqhEZmTRr0XeClWtay9lmvjsLBVOP+OH24k0cRDMB1im
         tcQmCo/hthecT9czbi5S6F7VH0+i65tmtKvw2NoXhwUxdtecoXjScLnW8OMwIjHUd7Cb
         iya8FIUgeHv82hRD7L1p908H2x5fBLCMlRqc+zE0KCwi1jlV0+dIA1LNn6kNJpAAhntP
         Ce/jZYhbobUDAOYIMAYMuOUA2wANQTRrfrIuCfBl3Yc27Blh4LUV4ldM1ZUd8GZArsqR
         z10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706774757; x=1707379557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUqkQTp/EejRMwYJr1zUIe1l3Bx/6LHMX3gDVJzEF5k=;
        b=HV8t9R72LOTJHT/GF9C8fJmnFstmDhQDgg95novIlXZuMaq4yuLQFuJvs0rhzdsoPG
         9Mrn7LkjDhGJ3TyDaGLn47OmyVTEBodD6gq46CU2ASjfkPkFnUuiiHaSyrx8SopdELbL
         iL70oNDU7R55I4isNc+XdqLrG1cyUDGruPsXGoQ+D9M7GugRiX4O5OoS4oSgZaNU9iis
         OXnoxG9RK8M7dvNqaTFZZcj7V0kxywbfV7FJ1kvnjRREZB/GoRxjBy/25/WHMlD0E25m
         q6DA4qTUOx6fUbjq2JdqFBfT/DBkM3eklqtCPEc8cZ9COTAhrNcOAnuXXEkTVTIvGeUN
         vgLA==
X-Forwarded-Encrypted: i=0; AJvYcCXlNjui5mwzEm1iBC3grbzfVxrfXBnTBzw0viVhDIbd8k26le2pAPoH17IiI9nVOCqon/+tmPGeKxXF6ReZxQUxW/xO6B7RPrmRHQ==
X-Gm-Message-State: AOJu0YwDsKi+bvQyqXlUgBLjwQK37OlXCVFAVZsCF4v9cSHrWS+yjiID
	c2iQcWF0fxVJM16VtdFvipbeiJpJycwkdZ76CAuQIwr6YAQqmsA8bqSaZxZ4rw8=
X-Google-Smtp-Source: AGHT+IHNpsxcxBhK+Nhq/jFWZmtjYt1OxzFS7/Ya3k5ZLd6vvFcTq4MCRBXJUPNh31FQmRsEoOWExw==
X-Received: by 2002:a6b:c9d8:0:b0:7bf:cc4d:ea53 with SMTP id z207-20020a6bc9d8000000b007bfcc4dea53mr4665474iof.0.1706774757261;
        Thu, 01 Feb 2024 00:05:57 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.153])
        by smtp.gmail.com with ESMTPSA id d14-20020a056a00198e00b006de1da4ca81sm8389738pfl.55.2024.02.01.00.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:05:56 -0800 (PST)
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
Subject: [PATCH 1/2] mm: pgtable: add missing flag and statistics for kernel PTE page
Date: Thu,  1 Feb 2024 16:05:40 +0800
Message-Id: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For kernel PTE page, we do not need to allocate and initialize its split
ptlock, but as a page table page, it's still necessary to add PG_table
flag and NR_PAGETABLE statistics for it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/asm-generic/pgalloc.h |  7 ++++++-
 include/linux/mm.h            | 21 ++++++++++++++++-----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 879e5f8aa5e9..908bd9140ac2 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -23,6 +23,8 @@ static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
 
 	if (!ptdesc)
 		return NULL;
+
+	__pagetable_pte_ctor(ptdesc);
 	return ptdesc_address(ptdesc);
 }
 
@@ -46,7 +48,10 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
  */
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	pagetable_free(virt_to_ptdesc(pte));
+	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
+
+	__pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 /**
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e442fd0efdd9..e37db032764e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2922,26 +2922,37 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
-static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
+static inline void __pagetable_pte_ctor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
 
-	if (!ptlock_init(ptdesc))
-		return false;
 	__folio_set_pgtable(folio);
 	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+}
+
+static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
+{
+	if (!ptlock_init(ptdesc))
+		return false;
+
+	__pagetable_pte_ctor(ptdesc);
 	return true;
 }
 
-static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
+static inline void __pagetable_pte_dtor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
 
-	ptlock_free(ptdesc);
 	__folio_clear_pgtable(folio);
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
+{
+	ptlock_free(ptdesc);
+	__pagetable_pte_dtor(ptdesc);
+}
+
 pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
 static inline pte_t *pte_offset_map(pmd_t *pmd, unsigned long addr)
 {
-- 
2.30.2


