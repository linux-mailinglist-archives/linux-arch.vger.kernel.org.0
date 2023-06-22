Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908EB73AAEF
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 23:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjFVVDD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 17:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjFVVBy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 17:01:54 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358FC2D57;
        Thu, 22 Jun 2023 13:59:44 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-763dc87aac4so187168085a.2;
        Thu, 22 Jun 2023 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467536; x=1690059536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=bI7F5jd8U0pmZoDCjrDdgbVISfzJlV2CUqYAibSVdHZ1OfrWu+Og6tKjTlcLZOSWFx
         f+VE9wjvDVgQCRSbWCOuVgmL30v4mkM+TeOOIsHTqjG+MpjulK0jZg8Kight1gJqL3EJ
         uelPGFi4K83pZcziIo91nBQ/Xb1a7VXoH5rDwteSo81u0B0E0AB9v0ZYlD/3EFJOnXaR
         LHJhz4j3eKvixa2uY3tcUc56YA7rm/NnSwLp194pufjXDiSsyScPz/VvaVef5k0S3cDu
         KA06LddfVd5MnGrcrI8kMVYj85Gsgf9HVHh6xfDQTCqtTE6ZYhHSEi5n5/a6D65T/xzp
         1jRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467536; x=1690059536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=Zec/8Gg/5ma+s64Vg8jg76fvFofHHZrKYGf2vc8s1tBT3b+iMtYy+rX219bjTiOR9z
         rtJ1Gvn2U8Jqrd67xWCK3Zv9dJWKWAqA2DAkg10gcaSD+AcZG/5FO3XyivmTL50s6yWF
         6/7X43pCuFJy0uD82OB7nKub64HRJ3H0ozrrdfJmu7eTuLAxg/dWSlUruLxDvlrZBb3d
         7YB25Utj8ID+nM9kgvJuHle2SnnGEvkMuxYTPeED4Fysf8bjVBghrSTd9Dg1rNVGfEAM
         wlukCLC2qf27dYn4ZNHlJHf0jYFkIS9tzGPVFR+V5No9LJ+dLpQQIEsCZx1nxuI+CRNE
         ws8A==
X-Gm-Message-State: AC+VfDwfdKbp1+Ldzo8nkW5C9B7vONYmJ+5nNCyL2Z4UYXhS3LVMeseY
        kot+zJUuD2MDq1842biWFCI=
X-Google-Smtp-Source: ACHHUZ6PptFNgBqCV4/Z0wvxz/N4kUJPrg8w5rC/9pu7Gesur9H1ncl000IRfhTCjlej4fSGBBngjg==
X-Received: by 2002:a05:620a:c55:b0:75e:d11d:51ab with SMTP id u21-20020a05620a0c5500b0075ed11d51abmr23662404qki.9.1687467536577;
        Thu, 22 Jun 2023 13:58:56 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:56 -0700 (PDT)
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
Subject: [PATCH v5 29/33] sh: Convert pte_free_tlb() to use ptdescs
Date:   Thu, 22 Jun 2023 13:57:41 -0700
Message-Id: <20230622205745.79707-30-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
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

