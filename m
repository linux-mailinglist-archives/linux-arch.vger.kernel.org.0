Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E449D73AADC
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 23:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjFVVCu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 17:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjFVVBt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 17:01:49 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2E22D4F;
        Thu, 22 Jun 2023 13:59:37 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-be3e2d172cbso6083479276.3;
        Thu, 22 Jun 2023 13:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467532; x=1690059532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AnRv7d38hHUVaoAGins0CaWMMRgzo0GwUb20Y9YoSw=;
        b=iN2FzqOQCGlMw61BHmPlvHKCi1d4I+83kYFUJ+05be01GNIJnqIJIlehoUIlvwUaVM
         d/OWGkj4lxemSlNpzjA9vagyXYnKzygaSW8qGOFAS4kKsFBEkls14ZpomWkO/T200zVH
         qlBgWwV7Su2BIgoVpSS5ByD582z4lmvR8XQqnfXM/x/kcWnUDA1l8EH7UvhzGe/a36fq
         qzeiYGkPPC0vXVHADUCnvEqnbyiXBVZ5TrMcTAX4hM8+UdpZhrwM5A+KI61Sp+b5buW5
         P1n/PN9/guunik8p7869oduuP/QEBbbnDZw3HC5F5neXLeBMAmnYdB3CF11sup6NCeqV
         0mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467532; x=1690059532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AnRv7d38hHUVaoAGins0CaWMMRgzo0GwUb20Y9YoSw=;
        b=XzAroTsseAmGgVE0stXUQGvuGegHjqBCuAIrlPZ11Xiu9NZQk5dM8dm2PcVpsZqG8W
         QTaVrLu8ZuwGCE3ar5IWbGJ9H7Xi6eGVU9TUReHp5A14iIT/1SrC84IDa5u4SkTQD8zp
         YwQjUU3pc4NQ7/tIym4o+GMohv8iwAZL8R6aFWjifOsZraXj1G3pRmU16WhAZKlj8WBa
         O1YIQM6tcJOXSePuTzzdFngL88JoABDZ3w8bUU1/drgCVZB4oj1spm62POi643yBU8fX
         RtXJKyFV33QLB5RtqB7o98iajWw5VeYBK09Q54f2shDtfhJZI/ivKO3l2YIosaf4iZFw
         chTA==
X-Gm-Message-State: AC+VfDzRT95AH5kgbWtuAtZIU3Bv8+qd5P+DX52Bgkn+79BMHn0lSEbz
        cH1XA/8eioIP2Q5cAQgMaUg=
X-Google-Smtp-Source: ACHHUZ4L0O/ZcQJNV1a5FO9DGWMsGkRAWmV2oZ5bMU1z3VMLdsFOJ9p+X6w0stYIYuPTzeAJzZnheQ==
X-Received: by 2002:a05:6902:1cf:b0:bff:78f9:ffcd with SMTP id u15-20020a05690201cf00b00bff78f9ffcdmr4883793ybh.38.1687467532210;
        Thu, 22 Jun 2023 13:58:52 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:51 -0700 (PDT)
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
        Jonas Bonn <jonas@southpole.se>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v5 27/33] openrisc: Convert __pte_free_tlb() to use ptdescs
Date:   Thu, 22 Jun 2023 13:57:39 -0700
Message-Id: <20230622205745.79707-28-vishal.moola@gmail.com>
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
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/openrisc/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index b7b2b8d16fad..c6a73772a546 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -66,10 +66,10 @@ extern inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)	\
-do {					\
-	pgtable_pte_page_dtor(pte);	\
-	tlb_remove_page((tlb), (pte));	\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.40.1

