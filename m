Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB366E532C
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjDQUzf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjDQUxj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D6710FE;
        Mon, 17 Apr 2023 13:53:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso256115pjc.1;
        Mon, 17 Apr 2023 13:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764803; x=1684356803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2PCFvKq9JWcIC4Exd9oDYO0v0PQOHyXRap+yEgbOb4=;
        b=Sg9gXChNrNLShRRgfwOKl/OTTCvmKSrllpuIiui1MavGQQvyi4/hV9+QaVJ3t9hABY
         7LNyY9zC8MZPe/8uyGF6BwZFFCebqKsRkCF7WD2/MczVElNAeTdXAZoU8m9zjTh6P7Zy
         0Ui6eydpR2I1tZyrhRUO19d2JsU/fHL/oyFe81PNxO86Jxw/ya4bgHlBy023YgAYk0Ea
         ro6AAOx594UY8fA/m7D7bEpjpZMo/caINuRe5NJsUpyuSeut+/oOBeuT5hXbXmkAYI67
         Pav/++zqcV0Pbp5FUcdmVoTNUO7tgK9EwNCc3eK51W0dnm+P+Og2+jgMY/+82hRUmWz8
         imHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764803; x=1684356803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2PCFvKq9JWcIC4Exd9oDYO0v0PQOHyXRap+yEgbOb4=;
        b=hnulMdvSj16phQfa6Bq/kGGvzyy4S7/6B97FE4KPLDZpaErpF57TJlyiU/xpsHt5lt
         SUQdV+NLCN825EOUU11aX5XHNt0pnG/Ktpg7fs+xH2ilLg88B1RpY5IL/DzkXCADfmJD
         xp2BQF1sm+ol1WbXyl8Y5GUIVk0aUWgw2TgOaO7/ViclYwRUh9KuygppoDn6/FO2Emdi
         0ADx5Pgt2rkoLzvevUxkai3l2gHSLUNyD2nJmpeX/eXRGLzMhoOAX90D1bNmLaPTWtk6
         ypb2msdZiWt/LNA8YNxc+MvKJK+CbH8YXqjL5lYzPPxySKHFzqNR1V1KLDVoL9J7a7D4
         ZcQw==
X-Gm-Message-State: AAQBX9ecfF72mMJHuPHoF+XQKFZWJid5e41ER4OvGuI1RChGqR9sAH0G
        XN0FtI9OU0FhSwu899qf4iU=
X-Google-Smtp-Source: AKy350ZH2s2lfJdxSYj+T2S9Ef0UoYzkgLYY3eeGq1S7Q2hAbd0lFGX52BFTYQkOd2khPVGSck6LXA==
X-Received: by 2002:a17:90a:e28f:b0:247:4200:7432 with SMTP id d15-20020a17090ae28f00b0024742007432mr11696070pjz.40.1681764802858;
        Mon, 17 Apr 2023 13:53:22 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:22 -0700 (PDT)
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
Subject: [PATCH 27/33] openrisc: Convert __pte_free_tlb() to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:42 -0700
Message-Id: <20230417205048.15870-28-vishal.moola@gmail.com>
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
 arch/openrisc/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index b7b2b8d16fad..14e641686281 100644
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
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.39.2

