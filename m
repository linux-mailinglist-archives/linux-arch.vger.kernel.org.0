Return-Path: <linux-arch+bounces-226-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECAE7EC399
	for <lists+linux-arch@lfdr.de>; Wed, 15 Nov 2023 14:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A930281116
	for <lists+linux-arch@lfdr.de>; Wed, 15 Nov 2023 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8C1A70C;
	Wed, 15 Nov 2023 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zprRwOvA"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48A1A5BE
	for <linux-arch@vger.kernel.org>; Wed, 15 Nov 2023 13:28:20 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2750AF
	for <linux-arch@vger.kernel.org>; Wed, 15 Nov 2023 05:28:18 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5094cb3a036so9528164e87.2
        for <linux-arch@vger.kernel.org>; Wed, 15 Nov 2023 05:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700054897; x=1700659697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrVNEt2cc/SjP2EDNi8Ypx4BpRW+YQfrsXMUopTWpaU=;
        b=zprRwOvA48KLn950pgJrHqrGlQt3miOl3BufhUUpa3Iz/8XNOva97WZEFZoPaKAGyI
         aoYlFtcfm/rZDEg/rvpx6aCC5rxE2AyfeW2HnC2y/2wPkr5+VT1UN/wK3v/z4J+Sa1aX
         A4cwgmE3Jw/YtqHu5U/1e7rAVFggFyS19n9SAIDVBAfMctziWLh52DhvnRpCrIvufDKQ
         /UYV/xPt+JwoLfQe+0MzT3W03mBq8GsgDEwdWEHRY9BFwCD24ynJiz8HPfxVDan2iayC
         82w+W1GNye5SGAsp7HpOxVHR8H4XSd+btDDQqgDsPzB7Q49Wm4/qol9F8iAIz7qFQ+vl
         YjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054897; x=1700659697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrVNEt2cc/SjP2EDNi8Ypx4BpRW+YQfrsXMUopTWpaU=;
        b=VNzkF4xEKaF1nXPoDOog9sSi2lQRSfrazq2zx7HvFBUHk+T6AOXU/6aRhohIvS3Knf
         /ATyTKq4uC+2YBuPdu4oU5Q97cgNWnI4bXqCtBBJAyWWsJCupFTR5IhxPKnW0TFFBXOb
         R5LFLFC11BgJRJ742I7BxbxRwpT0SHzATOBaaAAbG8lyTHJK0izlZljK8yIZcHz6exYC
         PwT2GWrN7eLk+UO5j48hNtGpW/oWHoKTdM+bAne4Fx3H93G53A+3JTV+OyJROnavMlap
         qVrGHx/jTgLQiB5QY+E7IR37RlMIg/yAmzPQ9eCov2psIjmXyZLgzABVNOyuGahx5UcH
         U00A==
X-Gm-Message-State: AOJu0YzYcq4qAAB7AYmu9L3f1/pcYRTkllYA9IzSQSpdZmDcQkgHR+CA
	VI4MVd9wFHkLFSuEktPFWgEWJUu2x/9xWJAo19w=
X-Google-Smtp-Source: AGHT+IEZfdzsNM4pOVpdQmBfJck2ud0jjVkPzsGxSYAG5htEb3fgmCm3DK8SVrja4wL8Daoz/Qy5GA==
X-Received: by 2002:a05:6512:4846:b0:507:9702:8e09 with SMTP id ep6-20020a056512484600b0050797028e09mr8331107lfb.2.1700054896889;
        Wed, 15 Nov 2023 05:28:16 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b00507b1da672bsm1648705lfc.174.2023.11.15.05.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:28:16 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 15 Nov 2023 14:28:14 +0100
Subject: [PATCH 1/2] ARC: mm: Make virt_to_pfn() a static inline
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231115-virt-to-phy-arch-tree-v1-1-8b61296eae73@linaro.org>
References: <20231115-virt-to-phy-arch-tree-v1-0-8b61296eae73@linaro.org>
In-Reply-To: <20231115-virt-to-phy-arch-tree-v1-0-8b61296eae73@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, 
 Brian Cain <bcain@quicinc.com>
Cc: linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

In order to do this we move the virt_to_phys() and
below the definition of the __pa() and __va() macros so it
compiles. The macro version was also able to do recursive
symbol resolution.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arc/include/asm/page.h           | 21 ++++++++++++---------
 arch/arc/include/asm/pgtable-levels.h |  2 +-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index 02b53ad811fb..def0dfb95b43 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -84,15 +84,6 @@ typedef struct {
 
 typedef struct page *pgtable_t;
 
-/*
- * Use virt_to_pfn with caution:
- * If used in pte or paddr related macros, it could cause truncation
- * in PAE40 builds
- * As a rule of thumb, only use it in helpers starting with virt_
- * You have been warned !
- */
-#define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
-
 /*
  * When HIGHMEM is enabled we have holes in the memory map so we need
  * pfn_valid() that takes into account the actual extents of the physical
@@ -122,6 +113,18 @@ extern int pfn_valid(unsigned long pfn);
 #define __pa(vaddr)  		((unsigned long)(vaddr))
 #define __va(paddr)  		((void *)((unsigned long)(paddr)))
 
+/*
+ * Use virt_to_pfn with caution:
+ * If used in pte or paddr related macros, it could cause truncation
+ * in PAE40 builds
+ * As a rule of thumb, only use it in helpers starting with virt_
+ * You have been warned !
+ */
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define virt_addr_valid(kaddr)  pfn_valid(virt_to_pfn(kaddr))
 
diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
index fc417c75c24d..86e148226463 100644
--- a/arch/arc/include/asm/pgtable-levels.h
+++ b/arch/arc/include/asm/pgtable-levels.h
@@ -159,7 +159,7 @@
 #define pmd_clear(xp)		do { pmd_val(*(xp)) = 0; } while (0)
 #define pmd_page_vaddr(pmd)	(pmd_val(pmd) & PAGE_MASK)
 #define pmd_pfn(pmd)		((pmd_val(pmd) & PAGE_MASK) >> PAGE_SHIFT)
-#define pmd_page(pmd)		virt_to_page(pmd_page_vaddr(pmd))
+#define pmd_page(pmd)		virt_to_page((void *)pmd_page_vaddr(pmd))
 #define set_pmd(pmdp, pmd)	(*(pmdp) = pmd)
 #define pmd_pgtable(pmd)	((pgtable_t) pmd_page(pmd))
 

-- 
2.34.1


