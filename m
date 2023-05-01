Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E156F37CA
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjEATbR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjEAT3w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323603C1B;
        Mon,  1 May 2023 12:29:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaec6f189cso12402315ad.3;
        Mon, 01 May 2023 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969362; x=1685561362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8/b+eKq2obnq3wrn4AaChyOhPXbZKipyE2UTOB7XHg=;
        b=Q3jl6YttJDwUuWKyn1dVs6I8W94SFWxxciTJdLpT/LELBYCeGyev+ExIC9w29x2Yt1
         zXHIDz5du52vN2frCHR+hIpcwuJ6c3WNhfC/Gsy1nS14RuXHFXtXj5G9xq8KbaH8upCB
         hoZ+KR9ZQITjkQA540sZmLX6PX4iGNe7NpnWG1G2AsO+NZdypSRuEfFuzqh0wPvQQaGw
         4XpO3Q1D/iCtA92s97XY1Or0L7GqG2SHJxpwKx0yuxfIbjPslNXarskrtkCCtU8UwW5x
         DSxt7iwfG4oFpxWasaAVqe2jz7cH5xxqomQxklMjhuQacqvGLIa7+5cde3ROrtfKL2NP
         oDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969362; x=1685561362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8/b+eKq2obnq3wrn4AaChyOhPXbZKipyE2UTOB7XHg=;
        b=VdySAhRLn22WJFuwafnMV9bIGZEiAc4/91k2IE3mQ8nQ/NaJp16qwHj2Bl7RuSbBFD
         T0eELaTr7YU81kbm72M0B0SthDKHj/ViFZBaxlL9gdZVXNbZTHOuQ9dvAgzVa8ZC28Fl
         LGoKro/2ZXF1Dk7IjgflQ9VIJpiMuGLz9AbYxRfuGH2Fom3XmCxX3puZnBUnEFK9iMib
         ngSh6k266sSfEZcb2Xd0moksYmkIbW3oEYa1ZnmPVSGy0ZMXOEmFNyMjrtzJ24sxaWr2
         UEBcVbJsE/KzFfzOwkWEIB4j0Ok5HCVkhX1XyaZ3VSND7u02fJGLpTri6Z5vvzwA+R48
         /4DQ==
X-Gm-Message-State: AC+VfDy5s7oRd//Q/cbSyvlj5dKi1uulLYkeygGgbbuJU15LECd1N/AU
        qJhv5m5U+/HDD8wujYHLn60=
X-Google-Smtp-Source: ACHHUZ7SACaylL3/aSyKhkx7S2g1HYBvFG08B1pme9nPnu6u4pSNBbJS188a/Kq3fbmOV3eKOsv72w==
X-Received: by 2002:a17:902:db0b:b0:1aa:e5cd:647a with SMTP id m11-20020a170902db0b00b001aae5cd647amr7875588plx.23.1682969362180;
        Mon, 01 May 2023 12:29:22 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:21 -0700 (PDT)
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
Subject: [PATCH v2 33/34] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date:   Mon,  1 May 2023 12:28:28 -0700
Message-Id: <20230501192829.17086-34-vishal.moola@gmail.com>
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

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/um/include/asm/pgalloc.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 8ec7cd46dd96..760b029505c1 100644
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
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
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
+	ptdesc_pmd_dtor(virt_to_ptdesc(pmd));			\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+} while (0)
 
 #endif
 
-- 
2.39.2

