Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A6F72D2AE
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 23:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbjFLVJZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 17:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbjFLVI2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 17:08:28 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9060A4EE8;
        Mon, 12 Jun 2023 14:05:55 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-19f45faedfbso3268544fac.0;
        Mon, 12 Jun 2023 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603953; x=1689195953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ/uV998f7GBK3U8fEwXlOSI96PW+5wzkUNMHiphdSU=;
        b=Tn4mHghr2z50QboRcFFwBXnQDC7dmOVTmd7q6odwa9ofCDQNfilhaBNviFDHX8SrYA
         fagx19tWV5xnG2unDu30AzBD8hFIWArocnuzCUa1K7AMS5VYUgKKhDVTLptGD0WPUw8/
         ZX9JliY6gx8+hXM3OztwRe71m1A+kx2eLC7qxtJVOpdoP5HVloTMtr0/abQT4yyYQOzs
         IVhZgoGgAdf28rfS5OorktySibfeqB5FLW0b+HoIsUsy+Q3Hv3TNg2zjbv2EGrbvSAhn
         +UJqDlCblQUHBUCUqLriRDZ3qurN8WXPOHGnwhy4vkGIt3E2YX1KhqR56pPwBtbb673W
         dPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603953; x=1689195953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQ/uV998f7GBK3U8fEwXlOSI96PW+5wzkUNMHiphdSU=;
        b=UbbEMBxwDpTz9Gu/s29/6zp064qrdciv9WkRYuOE90hnVWV27RLyXyA1E1WEbWA6nv
         QQiq9wSugDGlu0fb6RINnFqi64x47NMsFN35bAeuPVtGoWbuLKpp2lvFeZ1skXE1Zqd+
         /IMkGiNACp6tp/Hy19KxMXx5BgkX+V+Cpd6LQkn4R23/OU3Q8rR62JBNJToMdJ8mD0Ql
         4mvmIjotZ+BmYrBw1z+RCxAvxgYojiRyOwprRac08CLc4AihQ101C+cHwtj4DS+l/DGM
         9ug14AQrCcjraDwllbdWMouTnqaOFCiyZkMIFsG9gj0IvCJvU5nYR+0Wgd0X3zAKD2lf
         6Zdg==
X-Gm-Message-State: AC+VfDxmYnb72xZc6a6YfHQXU/tUbm0sKv5bK3e9rkjCjyQ7at4ORtL3
        RgTNwhGHhLTFiz1ef1FW9RoWDXJvPsBQPA==
X-Google-Smtp-Source: ACHHUZ4ThTH5LM1afe2PTTFtQ0ZfGkzFFO1FbLLwGaoZUh9UZKP9YYPXqsENj3drsF2z7+M8WUTgQg==
X-Received: by 2002:a05:6870:2207:b0:19f:5701:8c47 with SMTP id i7-20020a056870220700b0019f57018c47mr6429537oaf.9.1686603953383;
        Mon, 12 Jun 2023 14:05:53 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:53 -0700 (PDT)
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
        Richard Weinberger <richard@nod.at>
Subject: [PATCH v4 33/34] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date:   Mon, 12 Jun 2023 14:04:22 -0700
Message-Id: <20230612210423.18611-34-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
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

