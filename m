Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EEF6F371A
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjEAT3m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjEAT3V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:21 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2062D66;
        Mon,  1 May 2023 12:28:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaf21bb42bso11005715ad.2;
        Mon, 01 May 2023 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969320; x=1685561320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0Od9Inc5y6h3dSbsHmdGR20xSLs7HxIKZ/fFcl7OHg=;
        b=BSfSX498+nRsOwkOZCv/c3TfiIzHvFrBHqOPXzZnUzdOTpraA1SFYJQ7S9OlNSy+oo
         SgKJwDZ3qC6C//XEAcYljRcEjgHnyeaNoyhEAyOx7Ys6/3k09Ik8CgCQWIiXukHyuWI8
         JqooqMgdLQ1gpcR/L/mcYK+KZEjEg+InGInQqZs8g+xQwi3fiMtnPj+o8uf54dHCG0nD
         x8PpX8tpE3nfYMsr6vBPGSrBk7IqcdW9rAQJxVfKMF33+mjDorfNig4J/P1XioZbWwxD
         uXByeI5tsaD8qrYP2W7mncKrp6aQydR1tjw1T6sz0jLjo8cvDXE3/58iahOtRXOU+sGT
         jXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969320; x=1685561320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0Od9Inc5y6h3dSbsHmdGR20xSLs7HxIKZ/fFcl7OHg=;
        b=QFcsgk46/VstwdeApgLEfJd2t3Z+Y6sQxKg+61pPjBsvX5uctfzpmMxzkI4ZQZ5zVT
         2MkWIGKxAIPDMngCDBl1eIM3vQ8OaB7yJOw2cnhxBZfToy+/Opf4ZyR6aMbBF1fBApym
         olNhobqzoCbln8a9j5X5HAezN+0tSrgqq5ojVBDqRwwAsDUNWvpePULjqepcbNqMIkcR
         u28OwHt+k/DK59EtnFoDXh/1vlZBPaaR5RWfmdkpHStf4zFRBbgfwV9Rw1Mdu1oh2ULi
         HHRcNYaMC7pfUNQOuNB+u1gm+08swiwU0IL5aUmQZCp+xSAvdLU1K5i86s08p5yNngVs
         XLlg==
X-Gm-Message-State: AC+VfDy45ac5T7kNelg1PkQZWCTUTIdnNUMFL2gJLdTM8+5J4FKvH+1p
        rfKEtgPT27druUxsCYkuK18=
X-Google-Smtp-Source: ACHHUZ5c/2Ko6MMnlJILdIHFSiqsi7woH2pp9LXJUwyBETBH//ZWHg6e+tUlm1aX3nzTckKQE2QL/Q==
X-Received: by 2002:a17:902:d2cf:b0:1aa:ffe1:de13 with SMTP id n15-20020a170902d2cf00b001aaffe1de13mr2810716plc.5.1682969320162;
        Mon, 01 May 2023 12:28:40 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:39 -0700 (PDT)
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
Subject: [PATCH v2 04/34] pgtable: Create struct ptdesc
Date:   Mon,  1 May 2023 12:27:59 -0700
Message-Id: <20230501192829.17086-5-vishal.moola@gmail.com>
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

Currently, page table information is stored within struct page. As part
of simplifying struct page, create struct ptdesc for page table
information.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pgtable.h | 52 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 023918666dd4..5e0f51308724 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -989,6 +989,58 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
 #endif /* CONFIG_MMU */
 
+
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
+		unsigned long index;
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
+TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
+TABLE_MATCH(mapping, _pt_s390_gaddr);
+TABLE_MATCH(pt_mm, pt_mm);
+TABLE_MATCH(ptl, ptl);
+#undef TABLE_MATCH
+static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
+
 /*
  * No-op macros that just return the current protection value. Defined here
  * because these macros can be used even if CONFIG_MMU is not defined.
-- 
2.39.2

