Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A237373F16C
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjF0DPR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjF0DPO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:15:14 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FA819A2;
        Mon, 26 Jun 2023 20:15:10 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5702415be17so30767097b3.2;
        Mon, 26 Jun 2023 20:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835710; x=1690427710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXYENedStYVsFXpaqy8X3+wmlabVR1q8JHyD5+dxFj0=;
        b=Y5YNwg/QZrK+aHp3q3F/s+zHvk1fnDqd1/MV2/FtyEws8x/EU1okIb5gZ0g0bwjJIl
         5VUUqN9Wuh0HLMtWdAEYbmMx90i6AJPptQg4hAlIbSGwOvljd5Q6n3O/2f8tA77gBCdK
         YDhNGdvPzlezHyk8L+H+QUfnc3k/4+57L174UxCkkys5LGiYJFRoujM3bGB1Ibcn91ui
         mqfwiux2PkGJoz2g2vjn5ccwHyr655voiBf0XjjuTxpjhEe8LJcN7Q6CvIBEB03riKFC
         EsDpQXncNNWQyJs9hFhiDQn510NXqp1Pgv3vGtCcL2I6tmdj8XTW1jmQN/FUgbsQGPmI
         XxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835710; x=1690427710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXYENedStYVsFXpaqy8X3+wmlabVR1q8JHyD5+dxFj0=;
        b=lmSm1XsFADuIG0wCEmYGEzzfOsqO3/rqQcu0Kg/dE+k6XQtaRW1Aw2i6XzKLLQDuUY
         +9rP5RhfeS2tjrTo1clDrtQaXWSGDr1oXmxQiHdpZeb5sZ5kVaplgSnAyRDye3jU7Duq
         mnNIo6q3VLAUWwS8afN+dq+sZ+urLJv0JVho1gcQyKQ1w/0tDHC6bNj8XmmDXaW/B5zX
         6mDYCm/Qk5K1h31/fBmApIrDrQB4Guo0Vq4r6MK74d5O71eWffpXYUro+vHwj9e9voga
         5xrKAX5NBusUnJBSdP/98rtzMgCb7jRQO/1hGQ/AIIDqoxYo9Yk/WzBW5wqWw1NSK3eL
         e7yA==
X-Gm-Message-State: AC+VfDxPwuXGcXzqIT0pwOUmxCzc42tZg7owMRHTuF8vCdHbtYRRUjq1
        Tv7avT7u+MbS1cJaYr2Ax44=
X-Google-Smtp-Source: ACHHUZ6evDL0HWuUOw/E7eS1sxmpRauJbQh+5KyxG9iaYPnpfZgG5Wrtu7krHuwGR/MT62H3t8vWEA==
X-Received: by 2002:a0d:d681:0:b0:561:81b:7319 with SMTP id y123-20020a0dd681000000b00561081b7319mr25124050ywd.32.1687835709872;
        Mon, 26 Jun 2023 20:15:09 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:09 -0700 (PDT)
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
Subject: [PATCH v6 01/33] mm: Add PAGE_TYPE_OP folio functions
Date:   Mon, 26 Jun 2023 20:13:59 -0700
Message-Id: <20230627031431.29653-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
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

