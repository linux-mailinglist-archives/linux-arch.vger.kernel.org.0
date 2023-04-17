Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C176E5240
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjDQUxB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjDQUwz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:52:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53B240FD;
        Mon, 17 Apr 2023 13:52:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i8so18357489plt.10;
        Mon, 17 Apr 2023 13:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764769; x=1684356769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds3IS9TWlY4iXOF1Vygr3Q/N2fJxO0/Dzlxnv3cq6/0=;
        b=hr7pEt7A7XcPfK4WHrNDJyXTyW/f522/QxHB9K2NM6BmG8KnIlcSk7Prak06XFsubX
         Sjsu1MPagS5Ajy0wM6nwYZFly4hHrr9DYIrVTEdELHRdfsGo64oEk7qD+41S/NMObi8y
         l8A2tz8IWZ1X+Du4Mg5V1agW+uGCUPtQdgx1HioQtiEf01hZXw902OFYpkixEmc4936W
         rbvY3hq0N/ZSHnXC+KGydT6+ZrTUjCaNrxKIoD5OlWamJ5QPi1l2Tt7uz8xTA1Fp0QB2
         97/hz5zZCcVfwzgfNZP+zBkRfPzWu3gB3ojY6/LKA9XIpl4tn1OEejbLEhRl9E9QH4p3
         YC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764769; x=1684356769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds3IS9TWlY4iXOF1Vygr3Q/N2fJxO0/Dzlxnv3cq6/0=;
        b=OvT9RvbMatd/Ae5qHVGDY4wBl7382xF3pHhTuzaS0Qaz2HOwwtQNOlckj0wR44yXoB
         tUVE/eU4lpYGTDuYWWeKBP5CpSWaNQq/mL+uUnqtW9DmDvZrmF3afFAMSZ1uat8K67SC
         vIZ55BvV5lAzgODMydclQoQguUYEZ/kQNEUCMKE6k1R/2m+y183Hb+Rz+hZXARLU7DyF
         ne2ZErEsyEIfNPQt0Q53+DAmkOfmNMCUwMOvhL4MvJAZc0mkn/otBD03A+l5Y9cQRI+Q
         RIm1Y8/gCVFCNIHSbt/8x4CuQ3f0OAkIShFDjmYZK4Y1s4DPzQOCzQvUWZwbe5KILg4G
         RppQ==
X-Gm-Message-State: AAQBX9fMz3SM6mN2dGXkrRfRhaIHaxywReXGG+9hCdIJa0ZukOSI3mm2
        w8+67rkP7qx3skHdJIFpUBk=
X-Google-Smtp-Source: AKy350bKOtS2RU5+UPauyBEeUGcMLqfRctd5dndnPm3bZbQM5N2yHnkL/dVsnC5V83h9pYCSEFQOHw==
X-Received: by 2002:a05:6a20:6595:b0:eb:ad6a:ccf4 with SMTP id p21-20020a056a20659500b000ebad6accf4mr15296929pzh.18.1681764769281;
        Mon, 17 Apr 2023 13:52:49 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:49 -0700 (PDT)
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
Subject: [PATCH 03/33] pgtable: Create struct ptdesc
Date:   Mon, 17 Apr 2023 13:50:18 -0700
Message-Id: <20230417205048.15870-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
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

Currently, page table information is stored within struct page. As part
of simplifying struct page, create struct ptdesc for page table
information.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pgtable.h | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 023918666dd4..7cc6ea057ee9 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -47,6 +47,56 @@
 #define pmd_pgtable(pmd) pmd_page(pmd)
 #endif
 
+/**
+ * struct ptdesc - Memory descriptor for page tables.
+ * @__page_flags: Same as page flags. Unused for page tables.
+ * @pt_list: List of used page tables. Used for s390 and x86.
+ * @_pt_pad_1: Padding that aliases with page's compound head.
+ * @pmd_huge_pte: Protected by ptdesc->ptl, used for THPs.
+ * @_pt_s390_gaddr: Aliases with page's mapping. Used for s390 gmap only.
+ * @pt_mm: Used for x86 pgds.
+ * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
+ * @ptl: Lock for the page table.
+ *
+ * This struct overlays struct page for now. Do not modify without a good
+ * understanding of the issues.
+ */
+struct ptdesc {
+	unsigned long __page_flags;
+
+	union {
+		struct list_head pt_list;
+		struct {
+			unsigned long _pt_pad_1;
+			pgtable_t pmd_huge_pte;
+		};
+	};
+	unsigned long _pt_s390_gaddr;
+
+	union {
+		struct mm_struct *pt_mm;
+		atomic_t pt_frag_refcount;
+	};
+
+#if ALLOC_SPLIT_PTLOCKS
+	spinlock_t *ptl;
+#else
+	spinlock_t ptl;
+#endif
+};
+
+#define TABLE_MATCH(pg, pt)						\
+	static_assert(offsetof(struct page, pg) == offsetof(struct ptdesc, pt))
+TABLE_MATCH(flags, __page_flags);
+TABLE_MATCH(compound_head, pt_list);
+TABLE_MATCH(compound_head, _pt_pad_1);
+TABLE_MATCH(mapping, _pt_s390_gaddr);
+TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
+TABLE_MATCH(pt_mm, pt_mm);
+TABLE_MATCH(ptl, ptl);
+#undef TABLE_MATCH
+static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
+
 /*
  * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
  *
-- 
2.39.2

