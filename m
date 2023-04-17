Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8376E5355
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjDQUzy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjDQUyJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:54:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3047F83F2;
        Mon, 17 Apr 2023 13:53:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b2-20020a17090a6e0200b002470b249e59so16987538pjk.4;
        Mon, 17 Apr 2023 13:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764808; x=1684356808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSVYEUhM0zGHlDR1yqa5KIpwwPynV1rh1Z3AvIT239o=;
        b=Bs6MBnbjQkX1GScZCbLklar3CQYsHMcNQJhdEJMSRoz85XciXhpnQ0YtDU9kdG/nWk
         TxMCtPr19eviQJI5aQ6Z23KjvD0/UYdwUUF801SK8Z3tk/XuPH8n6ufK4lU6OPOoTkEa
         tcxsOYaiL60cLVhSI6wekl2Ojt4T3pVi0l4/Kpd6dmP8a2GTqJPhoPlibhYfl7AzaVkC
         8dHP626PMZuKBlHUuWDeE5Ws0Xf5nvhx1+eNXqdjJYxnU1JpJLYxfuGpVyKb6jdKhgqK
         l+AozFzFnnh8JDe5VzEpQS6lDqTnIa40opwHXXYLbmcB20BMSqSIISIYF0OD142rh4KG
         4Sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764808; x=1684356808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSVYEUhM0zGHlDR1yqa5KIpwwPynV1rh1Z3AvIT239o=;
        b=HYgtvAJ1p/8+QKYWp5sc98ZH761rOeRxR4pO07KYqH0ooVCXOipJmcKdx4JrL1AyS2
         4oByW+nuvDrh1apduoPt+gJghiqOV1EJPfmeBxSt5roa77OvR3PHX8lQbVFxUSmTm2Yp
         yose4eQY36XAdArL7Fb8afs+bdI/ew/FcgZAbrsEMGeqGcfbsXhjdKa1wLXyrLPydJuc
         0yWd24YdFecHQFukBiMlBMJGMyNrb36KHhV82bXMqvIpcuPO4yGmlFqivcHJ7s28T0Z9
         vOkza1DfBIylw643PrVdWE645yHRGspXVPdElE68sYub20UJH0879y3HVikRIEWkW5lj
         DKig==
X-Gm-Message-State: AAQBX9ciyxSKNC9yyWAw95wjzpVqhaEIWxD4U/mNmtZvTa0BYAN1yqYS
        /nc/Dzcm6+08hOOSxDD50Uk=
X-Google-Smtp-Source: AKy350a2GcdGbRUVrvD14pA7yb7zjU30cICJUnhJQSgTB8CRLuH7Cup5yhi/f0UjvURoMBG/RaZdVQ==
X-Received: by 2002:a17:903:1206:b0:19f:1871:3dcd with SMTP id l6-20020a170903120600b0019f18713dcdmr272381plh.5.1681764808447;
        Mon, 17 Apr 2023 13:53:28 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:28 -0700 (PDT)
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
Subject: [PATCH 31/33] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date:   Mon, 17 Apr 2023 13:50:46 -0700
Message-Id: <20230417205048.15870-32-vishal.moola@gmail.com>
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

Part of the conversions to replace pgtable pte constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/srmmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 13f027afc875..964938aa7b88 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -355,7 +355,8 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
-	if (page_ref_inc_return(page) == 2 && !pgtable_pte_page_ctor(page)) {
+	if (page_ref_inc_return(page) == 2 &&
+			!ptdesc_pte_ctor(page_ptdesc(page))) {
 		page_ref_dec(page);
 		ptep = NULL;
 	}
@@ -371,7 +372,7 @@ void pte_free(struct mm_struct *mm, pgtable_t ptep)
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
 	if (page_ref_dec_return(page) == 1)
-		pgtable_pte_page_dtor(page);
+		ptdesc_pte_dtor(page_ptdesc(page));
 	spin_unlock(&mm->page_table_lock);
 
 	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
-- 
2.39.2

