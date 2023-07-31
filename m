Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9CE769DC3
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjGaRE0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 13:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjGaRD6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 13:03:58 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BA1210E;
        Mon, 31 Jul 2023 10:03:43 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a426e70575so2742160b6e.0;
        Mon, 31 Jul 2023 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823022; x=1691427822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z39OytypuZQhWkFCV+z6u8l5O5ZgTP/vsQXKA5JsO6g=;
        b=U7jETlvh8mqc3055+tBC6M+9Gy8R7REEMm1ZwKGc87m0rGDIJvgZcQ22vsmsinFtgt
         YTQlnuPzwi5zjdD+hLDWvxB/bmYZ8keXNmrVzrv6YRz6eCv0CI9nx19KksxH7KprzagR
         irj90f/wH/tTIxD8sQn1Ka9sOZ4dPOYQtK8h3N0b0riSaIJ2B+2YXCtlZtVEkrPg3Bbm
         Ojw5AwhfC3mD3DUjG5dFAv5YKIY2ngXsFAsSD6uydkdJ8uV+q2q9uUnnFZIrFIqfANGz
         oTPiE5dBvTDG/Pv3tzLP875t1DoqUqRhJ+2aPTfRbOK8xixubum5W0ZiIgU8cUKgztEJ
         6Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823022; x=1691427822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z39OytypuZQhWkFCV+z6u8l5O5ZgTP/vsQXKA5JsO6g=;
        b=MxmwkpIAupiC1F2vgq0wuGUqKFjVP9kWb+Vu4tL1rsxcWeerwJj9QeJ2JR8iJvhXco
         CgS2dlm1zThJijEUzfz+/LpS5Bo4G1fvK6JDalyaWTgUYfsduHz3GaK7jZTfFZklO3BG
         bu+CdijTqQzXyCoApwBEZxfOp7LsZ7TKkhuMkqwIvsroNuX74iu8/LPRA/LF9DQFfXOk
         v8Yjg/iKuidEypBQ6Dk6yx0wyN3dBuFd48CbxlsyJX5Y6pAAJT3me6fbFgOS6oNyA/kX
         hbMlTEOXBQw7FYox7IdWDrtQZhfKrAHLxMyYLPhxSS2gGsChK5qp9/X7zeUW7Boz+o3W
         JLQw==
X-Gm-Message-State: ABy/qLaA4DRUL23x2fe9Ex0F3Su/unBepEb6NHf5mrOI1kVcqOiF97W4
        sLeOVkE419Paa1XskahrphIc6/SzW3KY4A==
X-Google-Smtp-Source: APBJJlHO94ah80UzwDXxBX9kkXsVAL3mPuWGcSVwu/SHGxcgeWhtI+EazxMnc09xov2z5IkvLaxhhA==
X-Received: by 2002:a05:6808:13c1:b0:3a3:7612:28cd with SMTP id d1-20020a05680813c100b003a3761228cdmr11096736oiw.28.1690823021788;
        Mon, 31 Jul 2023 10:03:41 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:03:41 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 02/31] pgtable: Create struct ptdesc
Date:   Mon, 31 Jul 2023 10:03:03 -0700
Message-Id: <20230731170332.69404-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/pgtable.h | 71 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5f36c055794b..1f92514d54b0 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -993,6 +993,77 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
 #endif /* CONFIG_MMU */
 
+
+/**
+ * struct ptdesc -    Memory descriptor for page tables.
+ * @__page_flags:     Same as page flags. Unused for page tables.
+ * @pt_rcu_head:      For freeing page table pages.
+ * @pt_list:          List of used page tables. Used for s390 and x86.
+ * @_pt_pad_1:        Padding that aliases with page's compound head.
+ * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
+ * @__page_mapping:   Aliases with page->mapping. Unused for page tables.
+ * @pt_mm:            Used for x86 pgds.
+ * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
+ * @_pt_pad_2:        Padding to ensure proper alignment.
+ * @ptl:              Lock for the page table.
+ * @__page_type:      Same as page->page_type. Unused for page tables.
+ * @_refcount:        Same as page refcount. Used for s390 page tables.
+ * @pt_memcg_data:    Memcg data. Tracked for page tables here.
+ *
+ * This struct overlays struct page for now. Do not modify without a good
+ * understanding of the issues.
+ */
+struct ptdesc {
+	unsigned long __page_flags;
+
+	union {
+		struct rcu_head pt_rcu_head;
+		struct list_head pt_list;
+		struct {
+			unsigned long _pt_pad_1;
+			pgtable_t pmd_huge_pte;
+		};
+	};
+	unsigned long __page_mapping;
+
+	union {
+		struct mm_struct *pt_mm;
+		atomic_t pt_frag_refcount;
+	};
+
+	union {
+		unsigned long _pt_pad_2;
+#if ALLOC_SPLIT_PTLOCKS
+		spinlock_t *ptl;
+#else
+		spinlock_t ptl;
+#endif
+	};
+	unsigned int __page_type;
+	atomic_t _refcount;
+#ifdef CONFIG_MEMCG
+	unsigned long pt_memcg_data;
+#endif
+};
+
+#define TABLE_MATCH(pg, pt)						\
+	static_assert(offsetof(struct page, pg) == offsetof(struct ptdesc, pt))
+TABLE_MATCH(flags, __page_flags);
+TABLE_MATCH(compound_head, pt_list);
+TABLE_MATCH(compound_head, _pt_pad_1);
+TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
+TABLE_MATCH(mapping, __page_mapping);
+TABLE_MATCH(pt_mm, pt_mm);
+TABLE_MATCH(ptl, ptl);
+TABLE_MATCH(rcu_head, pt_rcu_head);
+TABLE_MATCH(page_type, __page_type);
+TABLE_MATCH(_refcount, _refcount);
+#ifdef CONFIG_MEMCG
+TABLE_MATCH(memcg_data, pt_memcg_data);
+#endif
+#undef TABLE_MATCH
+static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
+
 /*
  * No-op macros that just return the current protection value. Defined here
  * because these macros can be used even if CONFIG_MMU is not defined.
-- 
2.40.1

