Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DBF718CEA
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjEaVeo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjEaVdx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:33:53 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD24E50;
        Wed, 31 May 2023 14:32:43 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565c7399afaso819677b3.1;
        Wed, 31 May 2023 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568729; x=1688160729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viYddHqy4Zdgp0J9O3iaWpIktRFOpc+3TNsEHN2SX9A=;
        b=hVqCB7aFrL5Nthi8pAlbjPvcInjFZt1qHkddABmx8gtVThNjktDfpfcNDFDlw5CG2+
         3xRmURAs/k2Nz9kNjLGLhiem3PMoX9/E6HDghH1XQlgENBdym8j3RSqFBZDSSy/b34yh
         AE2QmRwS6oPUlHWjPpeT/6u7AJu6WV2M048WkEp+vu4WP+h6zxRkbzSalddZaQ9VOuvn
         LGPsCzdTJ+5x5K0wsh8kq5o2Vj7pKu44k/mXiACQfaNUMTBzpYonaoHUeQuALtzvZCNz
         9M8tSd6AM43Q88HJNwRerrYrxc+HBnHCgqChwQ1i4KI3ds/XwizMZlg5u8MI061tV0gV
         yEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568729; x=1688160729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viYddHqy4Zdgp0J9O3iaWpIktRFOpc+3TNsEHN2SX9A=;
        b=fXYrJHBo+9Do9aSWpSGBYO0418EuAG2tcJD6Rpc7sUlg2wJq/MKo/MhyDfI9AN9Hvj
         ejpyCkNEYT1Am3invNGGMHtlrZULXkiOqtY0rcBtycXa94g+kcH3UWTtBmCRxf5RWbTI
         DnUnmQ+2OYHSxbqp30m/pkLM7/M0/VPta1xPZ687JMFYcynh+P+5ioUNP7vPWpFdPU+U
         fmcZKjjYCxCGjIP+a/+t3CbIbNXN0U+JrJxisNtg40k7sLiWEC6Yo3LEBJzMJw7hOOYa
         YpU+kZ+Pxu8gswF7oGvk5Lq3Kmd14EHLB7LCEopqDZx4hzDk1zgwAKxBrfYCfWmbXhxj
         d8mw==
X-Gm-Message-State: AC+VfDyRHAVa8Mg0bne2UfYL1HbaPR7vv/fO0JBi2iRrgzkLLtqcY21N
        RdXzqsCunto6kscdBDH1VuZCa+dQAnW2vw==
X-Google-Smtp-Source: ACHHUZ7dIRO2Itz1UIyUgFPRBSeGYhHu2aqfX+t+ZClzgP9Es2W2C4cR0F0LltUImCNhGQXKVAT26w==
X-Received: by 2002:a81:48ce:0:b0:565:62eb:db6 with SMTP id v197-20020a8148ce000000b0056562eb0db6mr28101ywa.42.1685568728711;
        Wed, 31 May 2023 14:32:08 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:32:08 -0700 (PDT)
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
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date:   Wed, 31 May 2023 14:30:28 -0700
Message-Id: <20230531213032.25338-31-vishal.moola@gmail.com>
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
 arch/sh/include/asm/pgalloc.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index a9e98233c4d4..5d8577ab1591 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_SH_PGALLOC_H
 #define __ASM_SH_PGALLOC_H
 
+#include <linux/mm.h>
 #include <asm/page.h>
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
@@ -31,10 +32,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
 
-#define __pte_free_tlb(tlb,pte,addr)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
-- 
2.40.1

