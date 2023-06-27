Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FB773F27E
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjF0DUn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjF0DT1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:19:27 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A5030C3;
        Mon, 26 Jun 2023 20:16:16 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-57083a06b71so40017377b3.1;
        Mon, 26 Jun 2023 20:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835769; x=1690427769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=eyYuDUlXPMdgLVymoCPm6l0B5AkMkP0MJVgww2Dc7/3sqQmnGU1ku6H9CU98Kx8HDx
         01E8lwPN+qvwNuBvO2TKM7cIgKQ3CJY1x5BttlhhMCAu/eXz9REbxcYgAP/6CQkWy6Cf
         lQ90mc5ZocMFbyDKOmgQ6JtaRafPtmT5vpmCcu1CHVchruI6mMlKmB0nAjhundO2FScF
         dwi9LCyq+7qGXz1usN+jVcsXjJuTQQ04p4sKanEFFQJoYolDJUzZRawaXCZwSYL33znl
         4r4UGf7Bdp39+qapNSstfbw+OcAirA3yy9mzGZ+ruj3Aqj6H943hd4iO/NnOtCq31XtZ
         136A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835769; x=1690427769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=eQZvgPhmLhwGkb8trxbjmsHr3Hm2QhoW14rfkADIJiHXQIBO1xq8aF4ngJplMiySrI
         WkPsOA+aouENGFgzLZUfGoIsXm3NRVS0fCP0bLUoUJv8sJt1FoY/hwBAezpV/7HtSWBl
         DyFUIwVfjP65/GA7cogoOSApQSWWSLirN2Wt3JPZgd5B9b+09VfhjzYKdZGGsF/ht+YY
         fZ2YjEMsypr7rjbGNL2XYjNkcHXVgIigFYq+AoWK5nL6w91mosOO7+lCiXICNvEVG1/Y
         h12+mj2Js9J++mqbpvTy6muEYzE4Fc21rxRQGXryLc033BWpMjFZk9VT39R86MmiOGh9
         HrBw==
X-Gm-Message-State: AC+VfDyYdMx3VutvmbTvfxsXNB94yOStRLJ53Q/lF3DwOkCJVpOIGJeF
        o8/2CnBfzsVRfPZrYV2GfRg=
X-Google-Smtp-Source: ACHHUZ5BRaD177tE1K+/zidTaxecch2WxFQR5MI/tG/yJGMKk055pAnLHtqYXsbXJZWlLLkzghbGoA==
X-Received: by 2002:a81:8684:0:b0:576:e4b6:9272 with SMTP id w126-20020a818684000000b00576e4b69272mr1982237ywf.30.1687835769172;
        Mon, 26 Jun 2023 20:16:09 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:16:08 -0700 (PDT)
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 29/33] sh: Convert pte_free_tlb() to use ptdescs
Date:   Mon, 26 Jun 2023 20:14:27 -0700
Message-Id: <20230627031431.29653-30-vishal.moola@gmail.com>
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

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
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

