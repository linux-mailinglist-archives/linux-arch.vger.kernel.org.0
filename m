Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1993E73AA02
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 22:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjFVU7Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 16:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjFVU7C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 16:59:02 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A02E2100;
        Thu, 22 Jun 2023 13:58:27 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-55e11f94817so4751978eaf.2;
        Thu, 22 Jun 2023 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467488; x=1690059488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sr5TgrSX24KD5rPSp2rkPhxpII4heal/IIgk1FACoIs=;
        b=UtF2QiZk6b9G+hZ8o+uaaa8jIMv9kwu5Z4W+DnKhqSxtuxZLeuCmgWiQ2UyCbKdGf3
         JlKYQP1/9HAEwi4YcMuZIpkc1UasphklUD1y4PAfxdaiUenlc82pk0MDNgE4UyvTP/Ti
         WAZ4mtTP+0UbBT6PIwdrRUvrUpbxA+faq7jSe2iTSffGzc1HNKXsxuak3eG36Kz3Hx1p
         3Bw014l7N9peXiYCyjbUvF7k31KviCnInVoJPhH8kz/FXkdJ8oxWXWbjuOh6BjmUEfNL
         NLvkARmq7C0ZzVI4l8HT21OfZWS/swkiU6k+jkbLgeAOyE/KVS/34HjWz0qthh2YGY4M
         vuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467488; x=1690059488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sr5TgrSX24KD5rPSp2rkPhxpII4heal/IIgk1FACoIs=;
        b=LmSoB8fH1eDh4wgcjjE2RjieMj/W83hYGq7yDiI7vOdAEtjM9Er2hVnaBdwQNCoXa0
         dk6kB2mWe7Jx/6cltrQOAes6xOkTcK9DRNBgkJnVXbWf+KpV4biVmYw/vcZSaakXeCQe
         depRu+gZLoBMoogeMRSxSHXnuz9AebypY6rtZYLUsSsG17pc+NgDp3T09v8g/vP3pFrK
         pN3A/8Fv7w/3cEC/JHTTCIo/bIngiawBccU66fEv8uvwDyq3SV8kIPiG06+6A/4tSnXH
         J3uRcNCsV9rwopS57M+cCe2aZ1Utai1KVV//UruPMrHxUprB+5rBazBhV3QPUiw7yYaD
         CZ+Q==
X-Gm-Message-State: AC+VfDwcM8S6Mw0uuKLDCbKlkVM3cRlCnQBiLSOdbwFWYX+E7UP1TRhm
        y/Or8emD4oFBn9U5ZDhoTYk=
X-Google-Smtp-Source: ACHHUZ6Wv4q+lCV8nxexJGI3S2vfJP94k7k+pAexpWAqQNNuxMHJpmGx+Tn2Ll2+HAYtwXHgGRnsHw==
X-Received: by 2002:a05:6358:9f9f:b0:132:d8bc:b15b with SMTP id fy31-20020a0563589f9f00b00132d8bcb15bmr1343396rwb.2.1687467488545;
        Thu, 22 Jun 2023 13:58:08 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:08 -0700 (PDT)
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
Subject: [PATCH v5 06/33] mm: Convert ptlock_alloc() to use ptdescs
Date:   Thu, 22 Jun 2023 13:57:18 -0700
Message-Id: <20230622205745.79707-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

