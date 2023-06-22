Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34E473A9D6
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 22:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjFVU6q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjFVU6m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 16:58:42 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711442694;
        Thu, 22 Jun 2023 13:58:04 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bb2ffa1e235so7075814276.0;
        Thu, 22 Jun 2023 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467478; x=1690059478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXYENedStYVsFXpaqy8X3+wmlabVR1q8JHyD5+dxFj0=;
        b=oWqJsihW3Mww2gXtWCx6NN1vPsnSmScA0KqTPfHOB2L1LHk/oZiCduo6ehbRGsj3u1
         3K4TZcf4ipLxkr2vI99P6IIjGRev7x1HMuDNE81bxWMzhRU6uyioFzTZTsBBM3X8iluN
         tBK6Y8stl1G/1qCE5N0GQ3Qa+8Pmm+N03Nm44USTvnLt7V5LvALEjdohUoDqU7kxuZLt
         IgowLw0bUJXUmFP7v8RMzC0EWbABefmvZCJB+fh5ayxmmTYy0RtnueLq29qEPJSsxOpa
         bu8Ei1mTrJukofeSyNP/F3QTQ4sGlZhg7IWdEGo85alo6ycJggU6oX8hiEo/eX8VwR76
         IyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467478; x=1690059478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXYENedStYVsFXpaqy8X3+wmlabVR1q8JHyD5+dxFj0=;
        b=DicwCtgzB61TGoXHIKOtF3ZO8QJPnWYrdrdut+oSomrFimf/ZyUhSFStCZ61JYQ3F7
         hV3QEpL40+saw8vEO7C8982V3go228Dn9X4AsqQbKQfWds1O7lACSZA0WkeMvUcCae9a
         l+ayhzagpZ9TUjynF/dhTvPwvWVSU3ihIbLhuCtQYOfEPOEHA6s7y76Y2PqgNopu5m1x
         MSP+EWPMGAPa/T3DXJlIs17N7gZEwzqbDwNJnVfdvtfd8MSrjWOUkaAswQ+REJyXtMMs
         wMDuc9MZz7vsZWHJ309MyQIcKjB3sQZj0tKQs1hdjgvoa3V8CjSKfczpRxcr8sS7IrjB
         2+Mw==
X-Gm-Message-State: AC+VfDwaEGEiHZZNizLPnWvoEpnlxZTu2qclLInsg0agkuGjJcDumOr6
        m3vd4wPh2PL9/Qh2FtOZEXk=
X-Google-Smtp-Source: ACHHUZ6Iv2PzBVPKZ2hNXXGWhZAWkMVnsSNpndVsfJ1BDlCBJeA25OFgV2XyKC6amBhVDhSuupua4g==
X-Received: by 2002:a25:2fce:0:b0:bac:2a78:aaa7 with SMTP id v197-20020a252fce000000b00bac2a78aaa7mr16148309ybv.54.1687467478063;
        Thu, 22 Jun 2023 13:57:58 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:57:57 -0700 (PDT)
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
Subject: [PATCH v5 01/33] mm: Add PAGE_TYPE_OP folio functions
Date:   Thu, 22 Jun 2023 13:57:13 -0700
Message-Id: <20230622205745.79707-2-vishal.moola@gmail.com>
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

No folio equivalents for page type operations have been defined, so
define them for later folio conversions.

Also changes the Page##uname macros to take in const struct page* since
we only read the memory here.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/page-flags.h | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 92a2063a0a23..9218028caf33 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -908,6 +908,8 @@ static inline bool is_page_hwpoison(struct page *page)
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
+#define folio_test_type(folio, flag)					\
+	((folio->page.page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
 
 static inline int page_type_has_type(unsigned int page_type)
 {
@@ -919,27 +921,41 @@ static inline int page_has_type(struct page *page)
 	return page_type_has_type(page->page_type);
 }
 
-#define PAGE_TYPE_OPS(uname, lname)					\
-static __always_inline int Page##uname(struct page *page)		\
+#define PAGE_TYPE_OPS(uname, lname, fname)				\
+static __always_inline int Page##uname(const struct page *page)		\
 {									\
 	return PageType(page, PG_##lname);				\
 }									\
+static __always_inline int folio_test_##fname(const struct folio *folio)\
+{									\
+	return folio_test_type(folio, PG_##lname);			\
+}									\
 static __always_inline void __SetPage##uname(struct page *page)		\
 {									\
 	VM_BUG_ON_PAGE(!PageType(page, 0), page);			\
 	page->page_type &= ~PG_##lname;					\
 }									\
+static __always_inline void __folio_set_##fname(struct folio *folio)	\
+{									\
+	VM_BUG_ON_FOLIO(!folio_test_type(folio, 0), folio);		\
+	folio->page.page_type &= ~PG_##lname;				\
+}									\
 static __always_inline void __ClearPage##uname(struct page *page)	\
 {									\
 	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
 	page->page_type |= PG_##lname;					\
-}
+}									\
+static __always_inline void __folio_clear_##fname(struct folio *folio)	\
+{									\
+	VM_BUG_ON_FOLIO(!folio_test_##fname(folio), folio);		\
+	folio->page.page_type |= PG_##lname;				\
+}									\
 
 /*
  * PageBuddy() indicates that the page is free and in the buddy system
  * (see mm/page_alloc.c).
  */
-PAGE_TYPE_OPS(Buddy, buddy)
+PAGE_TYPE_OPS(Buddy, buddy, buddy)
 
 /*
  * PageOffline() indicates that the page is logically offline although the
@@ -963,7 +979,7 @@ PAGE_TYPE_OPS(Buddy, buddy)
  * pages should check PageOffline() and synchronize with such drivers using
  * page_offline_freeze()/page_offline_thaw().
  */
-PAGE_TYPE_OPS(Offline, offline)
+PAGE_TYPE_OPS(Offline, offline, offline)
 
 extern void page_offline_freeze(void);
 extern void page_offline_thaw(void);
@@ -973,12 +989,12 @@ extern void page_offline_end(void);
 /*
  * Marks pages in use as page tables.
  */
-PAGE_TYPE_OPS(Table, table)
+PAGE_TYPE_OPS(Table, table, pgtable)
 
 /*
  * Marks guardpages used with debug_pagealloc.
  */
-PAGE_TYPE_OPS(Guard, guard)
+PAGE_TYPE_OPS(Guard, guard, guard)
 
 extern bool is_free_buddy_page(struct page *page);
 
-- 
2.40.1

