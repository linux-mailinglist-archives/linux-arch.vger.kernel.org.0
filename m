Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB333E99A
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 07:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCQGY6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 02:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCQGY2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 02:24:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CCEC06174A;
        Tue, 16 Mar 2021 23:24:28 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 30so277446ple.4;
        Tue, 16 Mar 2021 23:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAbu4uylyD/1yZsJCHQjYIcITelz2x29iNZ/QiXVtA4=;
        b=sXb2QLLIzWJSM+Zi+acrl+MEb1zX47TUFWvEPje56QooIkKUgZXMeMimDdGJUXgX9J
         1WvPANwCYbJxwUTnOOm5W8F/OLX2VpjutsPFQg4uOs2mvGm8doD5GsJJ13j54ULp1C1P
         jh1im1vMwuhKWECyIqpMLcJr78DwSrzAYvzNcphn11O7eWgNETP1pyQWqOy/+s0bhR4m
         2kEEAUNYMIrnYwc7qMhpZQnc8QyPT1k9gcefN4vnGFpxLM0SLUG3foeuVY1lqxMUz7y3
         2PcMEPrmyVJAHyQwrHt5vdJB3xO8ebkFhXJ14d0rNpOs7F9G7ulHI5o+BKXIQLDVmLvh
         4uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAbu4uylyD/1yZsJCHQjYIcITelz2x29iNZ/QiXVtA4=;
        b=AqvLtDYdRLT8AoMZ0Da1YU0yvOu9zNhpXkgolJAK6Jijm136nOlS8FLI+ytxsme56Z
         eGaVaJDGGagZtskRH/PZwpPPTNqIY1+bKM7Fb7fFvLSuO2iKXb005f5ZsGrsV/EN1TPI
         mDqP1UyijdQsmxPCiVqIPKmkMqRJ5QbkkyX8MBD3ZzNACL5A9oFWW3clE43twqPNYbPr
         19vN8RWljNGFsZFoGVLv4YR8aySQQIBIQ1FVr0jY1C14AJ6Ob3AB8UhObZtS7C5SwuJg
         UYUbMGvUdV4rZAb5SUpxLdjxU86WAQ+pNHunnTvJdd4r4D9CWLUoScMGJ0fJ6OWNDMYs
         qthg==
X-Gm-Message-State: AOAM533FLHyfVTa51oHA5LcOnSf2Fktdd/YqLmwt2tG0t3KfM5mNcjV8
        Pt2rpBgbWsshPys+LPZhrxg=
X-Google-Smtp-Source: ABdhPJz1uqgDCGDQAR9TanybbKMGcsepIcdLLEpecSZtq52NFToIck/CqpiGOQ15vW6GJFJxlSh+vQ==
X-Received: by 2002:a17:902:ead5:b029:e5:bd04:bf48 with SMTP id p21-20020a170902ead5b02900e5bd04bf48mr3083048pld.38.1615962268349;
        Tue, 16 Mar 2021 23:24:28 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id s19sm17959620pfh.168.2021.03.16.23.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:24:27 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 01/14] ARM: mm: add missing pud_page define to 2-level page tables
Date:   Wed, 17 Mar 2021 16:23:49 +1000
Message-Id: <20210317062402.533919-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210317062402.533919-1-npiggin@gmail.com>
References: <20210317062402.533919-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ARM uses its own PMD folding scheme which is missing pud_page which
should just pass through to pmd_page. Move this from the 3-level
page table to common header.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Ding Tianhong <dingtianhong@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm/include/asm/pgtable-3level.h | 2 --
 arch/arm/include/asm/pgtable.h        | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 2b85d175e999..d4edab51a77c 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -186,8 +186,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
 
 #define pmd_write(pmd)		(pmd_isclear((pmd), L_PMD_SECT_RDONLY))
 #define pmd_dirty(pmd)		(pmd_isset((pmd), L_PMD_SECT_DIRTY))
-#define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
-#define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
 
 #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
 #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index c02f24400369..d63a5bb6bd0c 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -166,6 +166,9 @@ extern struct page *empty_zero_page;
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
+#define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
+#define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 
 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
-- 
2.23.0

