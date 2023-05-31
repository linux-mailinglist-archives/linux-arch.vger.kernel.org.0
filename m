Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75437718BE4
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjEaVbW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEaVbR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:31:17 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B62192;
        Wed, 31 May 2023 14:31:12 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-568bb833462so835877b3.1;
        Wed, 31 May 2023 14:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568671; x=1688160671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX969DJmm0QSNKJIBN0sjsA5M6jg25Ht5D0PDUGbnFg=;
        b=P7FbSxrmAPv3mGtl9KCze7nT8iCFSFWQSZd60mX+cJFZkb27WYcyDR38HUvSUNwOfA
         WyleVMjeIqtLEEwRc2YnbZ7txjSr2kC1Bu6eSjk/V4zQ7iY1ikjarw2unChyDBFaqyHl
         qrkXBVTcGnA2v9yMUpvE/svfRz2vIL9d0Nbx7Bw2sQnHGn9MhsASWeYBsHvbspQGObju
         1ipMDLV38bpj6HIH1n6AHSjFxILtRbDR5cBiuIg4YWigaXfk1Rbe6tGcUyluemp1MpHz
         Go7YaG8Vo7KSrA3KfxzMvgw5BO+v7vQIsvpOcy7enjsShHfHLHc+oYi1vHe+rSK3PBLh
         b6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568671; x=1688160671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bX969DJmm0QSNKJIBN0sjsA5M6jg25Ht5D0PDUGbnFg=;
        b=fuKDYYoTUDfpcdwV8k/HaLsbCWlq74vQ8D3P9vpxSh798jDpiR1/s749TNqSeflaOE
         u1YKbRGAyj9Vz1m5Uo4lo1dasPZ3Cyxo7daP4Ysm4AWGQ4e3W98Bj6344A3bIvgJ4IHR
         xNrUxqZf0OsvFHvQ5ZBhEW9+4cnV24L436s6x0cXQZYI7lXoaZNI5jOjaX75vJfjG4tp
         +UW4dzjPup1VbOyAmsEOPrGZp+DTcUtYnCivNwfUmHwGJC7dD/UBm8t/LFi4slOw4od1
         NXGvYGwnAVIWhOqgQnNimDGw/WKDjiV04jQE8/baYrZrQEFgWA1kTY3/bt7kEWZS77qT
         dd9w==
X-Gm-Message-State: AC+VfDw8fdKGBr3KzuohmgcNSDvM6DMLDxLCM2lcWrgOSDRtjsHmNXlY
        pdsXbRFhWfEjoWQQn/Pqf/Q=
X-Google-Smtp-Source: ACHHUZ49VjuEJEQYDlxCOib/9Ri8bRDKMaFSJKO9JbdYMtejkSn38dasbkcATHh4yJ4tcm7dGKQETg==
X-Received: by 2002:a0d:e7c3:0:b0:565:a081:a925 with SMTP id q186-20020a0de7c3000000b00565a081a925mr7102903ywe.29.1685568671501;
        Wed, 31 May 2023 14:31:11 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:11 -0700 (PDT)
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
        kvm@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 01/34] mm: Add PAGE_TYPE_OP folio functions
Date:   Wed, 31 May 2023 14:29:59 -0700
Message-Id: <20230531213032.25338-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
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

No folio equivalents for page type operations have been defined, so
define them for later folio conversions.

Also changes the Page##uname macros to take in const struct page* since
we only read the memory here.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/page-flags.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 92a2063a0a23..e99a616b9bcd 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -908,6 +908,8 @@ static inline bool is_page_hwpoison(struct page *page)
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
+#define folio_test_type(folio, flag)					\
+	((folio->page.page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
 
 static inline int page_type_has_type(unsigned int page_type)
 {
@@ -920,20 +922,34 @@ static inline int page_has_type(struct page *page)
 }
 
 #define PAGE_TYPE_OPS(uname, lname)					\
-static __always_inline int Page##uname(struct page *page)		\
+static __always_inline int Page##uname(const struct page *page)		\
 {									\
 	return PageType(page, PG_##lname);				\
 }									\
+static __always_inline int folio_test_##lname(const struct folio *folio)\
+{									\
+	return folio_test_type(folio, PG_##lname);			\
+}									\
 static __always_inline void __SetPage##uname(struct page *page)		\
 {									\
 	VM_BUG_ON_PAGE(!PageType(page, 0), page);			\
 	page->page_type &= ~PG_##lname;					\
 }									\
+static __always_inline void __folio_set_##lname(struct folio *folio)	\
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
+static __always_inline void __folio_clear_##lname(struct folio *folio)	\
+{									\
+	VM_BUG_ON_FOLIO(!folio_test_##lname(folio), folio);		\
+	folio->page.page_type |= PG_##lname;				\
+}									\
 
 /*
  * PageBuddy() indicates that the page is free and in the buddy system
-- 
2.40.1

