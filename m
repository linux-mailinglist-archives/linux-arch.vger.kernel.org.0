Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407D2718D13
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjEaVfE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjEaVeS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:34:18 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3CAE5F;
        Wed, 31 May 2023 14:32:53 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-561c1436c75so810617b3.1;
        Wed, 31 May 2023 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568734; x=1688160734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ/uV998f7GBK3U8fEwXlOSI96PW+5wzkUNMHiphdSU=;
        b=Gco7uaZ8T0f7tmyth6uZeLtIanv6GpulpDiuQwIsnzqnPkjzJkIu0h1PZGQ4iQfI5A
         Wsvmi3eI4+D34lVcMDUsWRCETH5qcZJ6o4mHbMVq/3LTC/HNm7eQ6q2KfFVCA86f3d3I
         LxBFjI2qJ2MPH41lEvrCJnwlKDxe1mBh52b4jr4phbiXUV/rBKhdQfCzS+0QvKIx+CwJ
         I9nD3g0MgWbwsz1cldEhhb6oFNl81Iu/IWeIlG3kHhqR9NOaQpioUXIEm19YojgZVH7b
         YKNDEnmfXzRXtSrjS8AB8ePFyFPpDGIfkcu+Z1fbAVxcvdW9nHAWNVZ44Hj2Se7PAnUx
         U49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568734; x=1688160734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQ/uV998f7GBK3U8fEwXlOSI96PW+5wzkUNMHiphdSU=;
        b=E2F7wJAdwB95LBL1oRag1pc1kIKUw5WAjZCuSrWF/4vN3P6OyebBUK+irp7DvohZ3e
         G5Ma+F9lYkZ1C9eFU1QpYVS2lwx8PCHuubreU1kM5h9GLBHDfkgRBOCIk5V8POoeSICt
         t1C4ZcGXLlhb7csATSv7Ttx+YKkczt8SFdJk/9A4YQVaWiS7+0APksvyOEwY8x0ja+mG
         3hOr1OImwEmBjCTDTH2nR98N9ZwwltV1Ijj25O7DM8OJDtFHL/2R0PyGL6wtwbfFwNru
         u2AZjpqQZIRZHoJK2taXLdeOm6x7a0dgfMnP1f1i2OSWHp2MTwfuv28spBYLdz/fP0Sa
         Tf1g==
X-Gm-Message-State: AC+VfDwW1R3T8mTkbm53gfScko+450K2wD5m/9DZndxfzrY+RsY2fXEM
        HeA1yrG+e7GmcnMcjmVuJ7Y=
X-Google-Smtp-Source: ACHHUZ5gIOI1fuO3+omWI3ZFi04M+ls0ECM5yJW/hGOTfIhuUEs0QHIWlyyE93+ta0AMRd/Bn9r+fw==
X-Received: by 2002:a0d:db15:0:b0:562:6c0:c4d3 with SMTP id d21-20020a0ddb15000000b0056206c0c4d3mr7636270ywe.13.1685568734582;
        Wed, 31 May 2023 14:32:14 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:32:14 -0700 (PDT)
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
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH v3 33/34] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date:   Wed, 31 May 2023 14:30:31 -0700
Message-Id: <20230531213032.25338-34-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
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

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/um/include/asm/pgalloc.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 8ec7cd46dd96..de5e31c64793 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -25,19 +25,19 @@
  */
 extern pgd_t *pgd_alloc(struct mm_struct *);
 
-#define __pte_free_tlb(tlb,pte, address)		\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb),(pte));			\
+#define __pte_free_tlb(tlb, pte, address)			\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
 
-#define __pmd_free_tlb(tlb, pmd, address)		\
-do {							\
-	pgtable_pmd_page_dtor(virt_to_page(pmd));	\
-	tlb_remove_page((tlb),virt_to_page(pmd));	\
-} while (0)						\
+#define __pmd_free_tlb(tlb, pmd, address)			\
+do {								\
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));			\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+} while (0)
 
 #endif
 
-- 
2.40.1

