Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8E36F36F1
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjEAT3V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjEAT3N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:13 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520752D47;
        Mon,  1 May 2023 12:28:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso1995185b3a.2;
        Mon, 01 May 2023 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969316; x=1685561316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i6mX6BOTgb2TGO86QCloW3rCrq78sBOKu0dxXwRHVs=;
        b=pYnEspIgQ/94L4B7QgE7HxUaLyMe6HQnu5gVv7XKe7wrHmtTwaLadWDte57s2SBwdQ
         8bePLJ5Ai3/AmYhH4RiAfK8IjGb+8BxlohLn4+W6ycJ9Pg3WMvHLkkZOviW7YYTD/mmK
         GtZnk734H4mZvUq9Iut38ZejJnfrw2oYgWeCZ6PRbVlgoGyBpRA67FKhICj+7yH7j8HF
         a3LIP2IDGGOTftrbrsZRq8EQiQ5R1WymqweCw9yu0t92fclq88jf6kqwtf3FextynpJY
         IncHO/7Qw6ErlKR7f7HeTzuXXgCmLczBJBgXHLIbesev1rm2mkGmxXqiRqgTqpx3oce1
         ZBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969316; x=1685561316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9i6mX6BOTgb2TGO86QCloW3rCrq78sBOKu0dxXwRHVs=;
        b=et7CgAmJf9iYlnCgL1EQQupBdYCfB2jF95hm586dSvs5bOF1zMtELeP/4r2VkRylI7
         0gWN1deTdLHbdL4kTQURpPvHtL/Dsz8tFnKv35PhhYPVP6GVz4M8WJdSwTd5iYigD6+V
         8X3lmbnOLcG9EtMhQmHWrkkVicqp5Nf6dprUTpH0uSN3djUqcGYR6f/35cg4crzv4SsG
         ubzLaJzekRD0Aw8Ysq7AYvRAqSHeXpeLTzCmr4vTYTPxz2AZRLTQk9P31WCHrbvK022K
         ojqP/tNXP0XPFntaYfP6+pFOx2Tw3O+vmAj+92VQmXmB5cTnDtlXqIqXCS1u3OkJN9oh
         QEtw==
X-Gm-Message-State: AC+VfDxE+zGj+seA3Hjs45dHa034Pl5MK6v/rvMcgNoV6Q0cZe+fHuFA
        xPB66/RhO+0R8fAJ8EyTsvg=
X-Google-Smtp-Source: ACHHUZ4H6i4St7ld1wD0WuHlGapRQhff/8tSAzzBd7XutE+/MiRiNA1zmkp/wHjGquMcgELZnMsxdQ==
X-Received: by 2002:a17:903:1c3:b0:1a9:80a0:47dc with SMTP id e3-20020a17090301c300b001a980a047dcmr15039374plh.3.1682969315645;
        Mon, 01 May 2023 12:28:35 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:35 -0700 (PDT)
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
Subject: [PATCH v2 01/34] mm: Add PAGE_TYPE_OP folio functions
Date:   Mon,  1 May 2023 12:27:56 -0700
Message-Id: <20230501192829.17086-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
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
index 1c68d67b832f..607b495d1b57 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -902,6 +902,8 @@ static inline bool is_page_hwpoison(struct page *page)
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
+#define folio_test_type(folio, flag)					\
+	((folio->page.page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
 
 static inline int page_type_has_type(unsigned int page_type)
 {
@@ -914,20 +916,34 @@ static inline int page_has_type(struct page *page)
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
2.39.2

