Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DBA6E5323
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDQUza (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjDQUxg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:36 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5F65267;
        Mon, 17 Apr 2023 13:53:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w11so27337322plp.13;
        Mon, 17 Apr 2023 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764801; x=1684356801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tniPUuVL526Jec1TVIaHRLAUx7OruO8jRIKlA5wqt8Q=;
        b=p/jfRaNPQGaoJd3ujqaeLDuUP7t0WkHa2oZwiGdpehhESyVFAOdOmg0fusWkZ2XuJJ
         Yw6K8nYA6/5N6tLufuYh20gi7M7wxwYV1IodMymMAu3e2vjlzp/s4l9Vf7kZibjxovMR
         cghNEQkYGyGSVWGuIAzI28gyVhrT8GgnWs6YLc4dnuPB71AZU/a5qfpWgaMEJ0Qfl1S+
         OG2NEJp7fE32TkPWsKahDfFv2MiE7qQWnDtWKvNsVMNbEDAHg0y2Zsbd1R1MkIpv2dly
         3HDaLyPuLXfOS4PxJXenmM3XNPnXJ5LYctnHIHC9Ub4peO/zkx0GIKpeh+s1nuyRNP2C
         xoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764801; x=1684356801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tniPUuVL526Jec1TVIaHRLAUx7OruO8jRIKlA5wqt8Q=;
        b=dfrJvADnJaSu1YlSEMqBJOVQM4TeR5Xr55oQrourXegWYlFTWhyJE8YZCPQl4+GVKY
         Zk3zcoyFXARqrPPdqwDZ9yxdvGuM8az/UPlKcH+hagJqzBwcZdAFQY+R0AUw9Zp0VzGs
         cDURFVZlRORUPEbhLIeXWaN4wUn/qW8QlKO49hZefnmAsbwrbx63u3gpR8O01Hu4w6Uv
         RlpPQh3LDxxTdberElwPmIXlPadBMid0RgGf5Xpgd67L/K0K7oIxjmnvY4bdF5En6Wkx
         cV4IvsnSQgoXexpLbuQoLhRtgzjqtNoyNscRdmAjmnToCAgWxs66Xgfo9JlgRmH9C2Z9
         ybDw==
X-Gm-Message-State: AAQBX9dmtKtMVgzwVtApYX7UWybmYisvDjWQpwfAeJKpl5df8xKGrGOX
        RMjrDzSHG53mrQM9iV/dMM8=
X-Google-Smtp-Source: AKy350YG/84D/pba4O2jep64IWrC+mjA+ueyHqImP8NgwjI0qVBUMRNq8Z2uYJzIP+ywt0PW/sWA2w==
X-Received: by 2002:a17:90a:8048:b0:247:78c0:125e with SMTP id e8-20020a17090a804800b0024778c0125emr8083390pjw.15.1681764801496;
        Mon, 17 Apr 2023 13:53:21 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:21 -0700 (PDT)
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
Subject: [PATCH 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:41 -0700
Message-Id: <20230417205048.15870-27-vishal.moola@gmail.com>
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
 arch/nios2/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index ecd1657bb2ce..ed868f4c0ca9 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-	do {							\
-		pgtable_pte_page_dtor(pte);			\
-		tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)					\
+	do {								\
+		ptdesc_pte_dtor(page_ptdesc(pte));			\
+		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
-- 
2.39.2

