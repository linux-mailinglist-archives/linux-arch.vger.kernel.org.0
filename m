Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06B06E52FC
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjDQUyJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjDQUx3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABA876AF;
        Mon, 17 Apr 2023 13:53:16 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v21-20020a17090a459500b0024776162815so6441039pjg.2;
        Mon, 17 Apr 2023 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764796; x=1684356796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apg836Gn0N7QExyyhUUGNgc2fd2r3iyoAghRwsUjc2o=;
        b=DU+PC+Lb75+sxyzE8TFBhUq23MhtXNiuA1nw0c/GhsuV5IK3M7l/Hh4azDLq1DRa+j
         fu7HXiEzvV3T+N5Mt1is7DhkrUBl4PJsqFnRPYaX3oFVj8P6Qlk5ZLs6mljyu96mU+sv
         zpquQbUhbrKn4GUU7udC1O03s9ThOPwnMOZQlJkJdwRy8ikjPxI0naLAwtnZbb4WzEoy
         3BNpuQVnvIHEKJKSenAtt9bKOamb6q7fxWlfz+PtLFjOTztncr7nNFnGXeF7WX7UQ2CN
         r/J7luQKDmaqSpU1aG4/YKRgzEf0E8SysEU40ARw1q6PEFiJTtJVgg7dYOEMGKOTGrN2
         xyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764796; x=1684356796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apg836Gn0N7QExyyhUUGNgc2fd2r3iyoAghRwsUjc2o=;
        b=ZDjNDJ505lpUPd7IFNNLJ0uPyASL8WTXYreEYg7DUjI9uIR/lbd7ztQQaEA1CI0G9P
         tqWOrulsfjVHygORX0Zy+4aIp9gHTW04cVL25DuyMgx9AVtxFx1LD+51vafjdqxC3lHO
         QhvgWZw1qAtu770XA8Ir6dVuR5RwOgb8ZUX51YPCFBsYZAS7r/VhgBdS3tJ1ujEPlhwp
         N2jmJHpFtLPfkZJjNnfo9IQRF5xdLGjXuIoIiGXRawjthBzQt6Uy/N4sHTnGIoIgHN+o
         E2Ga7wZ51UYRVoGBnFpmQzOVKf9nH1Y+zJcTeREnkY7htNrs4Wy8rgo2yt4JzEMYSMn6
         hWyA==
X-Gm-Message-State: AAQBX9eUcD6rUXxj2OHPt0b3teMdIXxPMVIwh3t3Bu5iEWgF5rQvC4a3
        dRX4FUn7kEz6qmCFjSyQE2s=
X-Google-Smtp-Source: AKy350ZcoHXe5N321oYs87Q7Ayd5DnxwU4W2BhAi27QaGMsyV7i9NrgOQAsujiVTD54cy1B75qhHjg==
X-Received: by 2002:a17:90b:3b8c:b0:23f:9d83:ad76 with SMTP id pc12-20020a17090b3b8c00b0023f9d83ad76mr12727299pjb.23.1681764795745;
        Mon, 17 Apr 2023 13:53:15 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:15 -0700 (PDT)
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
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 22/33] hexagon: Convert __pte_free_tlb() to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:37 -0700
Message-Id: <20230417205048.15870-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
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
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/hexagon/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index f0c47e6a7427..0f8432430e68 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -87,10 +87,10 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 		max_kernel_seg = pmdindex;
 }
 
-#define __pte_free_tlb(tlb, pte, addr)		\
-do {						\
-	pgtable_pte_page_dtor((pte));		\
-	tlb_remove_page((tlb), (pte));		\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	ptdesc_pte_dtor((page_ptdesc(pte)));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.39.2

