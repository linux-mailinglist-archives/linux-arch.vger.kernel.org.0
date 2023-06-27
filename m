Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18E773F158
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjF0DPh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjF0DP1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:15:27 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5FB1701;
        Mon, 26 Jun 2023 20:15:21 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57083a06b71so40012837b3.1;
        Mon, 26 Jun 2023 20:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835720; x=1690427720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sr5TgrSX24KD5rPSp2rkPhxpII4heal/IIgk1FACoIs=;
        b=GRJmT9zZCc6VZLx9VY+7Q8GbOsBn33lZq/FXBv0aXORmxRac0rj/lSqIwgsFHnmh66
         6cAHAx0KI5Lagl5OZRxl+lTWKC9rW3K7h91Q6uOR2njTfEcjIvHn1/QWkX3jlNssdRYv
         kPZ6iyIVFwiYJpTBLvXR9/yIre3tRTqt009ghcdse7E6cPjs19QO0aXvNJJOMDpClaY7
         t8HHPKKx/NAZrk3fhoJWolRioMxC3Zc40A+aLrsXlHiTMIf/9zaAkHOq7TYNlbv+VzGn
         jItTpyFNqlbWxSgJZgFIeDKcVXb95B0vXbDJ5HgCdgCt4hiGi9xgNTBoUpG/3ZX1ru9x
         fM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835720; x=1690427720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sr5TgrSX24KD5rPSp2rkPhxpII4heal/IIgk1FACoIs=;
        b=Lh51IWhEKFQe7c9Dybv3UjkBF5b/6eAF2x8etK9z/UyO23PNItsaPWpzYk6r4hKC2g
         MATRc9X22HQGCUUWA362bjL/K6Xwy51FLjc8oekFdjtn5K4bTtIzBWpysVx/lbTwe3me
         5weCRd80Pr+9gU+utjjAM7nA2lMlim8qrnsLITigMxr/XE7YHCePgU1zvlHMdMljrxNU
         QJTJmdrniTP3gQXHLJ0J+l3gfgYYuAWADEwhWAmGNUZ931QhKDX6bAch+e/QtcnsWnF1
         7vCcU5L6TrJTojxjS+xC5xugMLfKS4Qpzr1XLEimN4zZ9pul4jEjBmSAAMV/xv8N2zuA
         JvWw==
X-Gm-Message-State: AC+VfDyKVKL2oJ210n72+7+QUX0kTNmBstoyMBmobjRMf0tSx3/e1Xjb
        XfhPVik0j/iGExayYL7Aito=
X-Google-Smtp-Source: ACHHUZ63yguTuEDNtqBAUu0oFztqBMiblJl9iKmWyGby1Nlfce/DGMkGkkGcggiUUjYXFR4C+z9ptA==
X-Received: by 2002:a0d:d78c:0:b0:56f:ff75:abcc with SMTP id z134-20020a0dd78c000000b0056fff75abccmr30306915ywd.29.1687835720566;
        Mon, 26 Jun 2023 20:15:20 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:20 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 06/33] mm: Convert ptlock_alloc() to use ptdescs
Date:   Mon, 26 Jun 2023 20:14:04 -0700
Message-Id: <20230627031431.29653-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 6 +++---
 mm/memory.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1511faf0263c..39b0a4661e44 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2798,7 +2798,7 @@ static inline void pagetable_free(struct ptdesc *pt)
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
+bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
 static inline spinlock_t *ptlock_ptr(struct page *page)
@@ -2810,7 +2810,7 @@ static inline void ptlock_cache_init(void)
 {
 }
 
-static inline bool ptlock_alloc(struct page *page)
+static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	return true;
 }
@@ -2840,7 +2840,7 @@ static inline bool ptlock_init(struct page *page)
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
+	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
 	spin_lock_init(ptlock_ptr(page));
 	return true;
diff --git a/mm/memory.c b/mm/memory.c
index 80faf3e76232..2ff14f50c7b3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5920,14 +5920,14 @@ void __init ptlock_cache_init(void)
 			SLAB_PANIC, NULL);
 }
 
-bool ptlock_alloc(struct page *page)
+bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	spinlock_t *ptl;
 
 	ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
 	if (!ptl)
 		return false;
-	page->ptl = ptl;
+	ptdesc->ptl = ptl;
 	return true;
 }
 
-- 
2.40.1

