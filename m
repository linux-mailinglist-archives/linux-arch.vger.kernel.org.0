Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB61769E9D
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjGaRHa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 13:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjGaRGd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 13:06:33 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334E42139;
        Mon, 31 Jul 2023 10:04:37 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso3787429276.1;
        Mon, 31 Jul 2023 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823066; x=1691427866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOzSOLTncjJXn0AvJQqE6PD7zrtBe8MIuyz5zw7TzDY=;
        b=f6adceAKsPvui0l7VSUiRnWj+VnC8V29gRyKPW/KXba4L11duKnXDkkl9h+DOUEe82
         /+uFEmkPUA7pfwVfanOSjRVPX3wfPLVY3FZPvGi3VyyqlsToEnHzzIylic2yHwlsDcH3
         W3JP9R5mJExPbkEH69AGyH0gizw4AowCqMoujs5LGqqMzZnJK/dPFOzk0elvmdxwimx1
         zHO/RBskNqXdsMC9zN3IXGN1/Qatnc3KRzwrgmn/b1CAPxkc6smcQgcPCS+F4TUkpdDt
         7sG/wG+FEbTCZLXxJ46EURhFx988hfZQfl6N1HhCumdsXb4Bqj21mhmFktRwf8yfQcyF
         sVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823066; x=1691427866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOzSOLTncjJXn0AvJQqE6PD7zrtBe8MIuyz5zw7TzDY=;
        b=DiwvxTrOxNnVBSOMBOm9MT7mnnhXSJs2e5BpK9hMTXumaS+w4tyr+pmHqxMCATk9wh
         SUtNNwK0KHAagS9yQQQQOCd/uu1MlieDu2+kfGAEvHtHbyxkTJwM2o7ZgNNJBXboOe5P
         XlJQA27KPT/TnUi9Dm5HU8naL/4BhKdb8GigY+Qi0vhm4t/Bps8U6dPi/3NDwRe4InOY
         V56dWWJkeQgu+j5Y6CQgQ6K2OyQXbqd5SY0jcKE+rXaVcWws547qV1Q+L+Ox6XizOiBs
         uTMwct7/5rXXvlqzDyhdl6PxtyNFMYYdBEuPfDWuesbhFDVVKl9oIujG1m75awMg1AzJ
         NWqA==
X-Gm-Message-State: ABy/qLY2Twiphgjbry5Sq9oUh0/jwZnp1bEdUFxMWUbbOtMz0U87M93e
        bB85mI/I8Yb3q+m8HbBHpBMggKDhxgPCqw==
X-Google-Smtp-Source: APBJJlE4T05ogdyrjIbBXTs0RpkDVTPnYG3Ig2UA6lH+KuSSQ9n98n0kBdmmWfFoFgc9s9NgVox+UA==
X-Received: by 2002:a25:ada4:0:b0:d0a:8973:b1c with SMTP id z36-20020a25ada4000000b00d0a89730b1cmr247583ybi.12.1690823066447;
        Mon, 31 Jul 2023 10:04:26 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:26 -0700 (PDT)
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
        Mike Rapoport <rppt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH mm-unstable v8 24/31] nios2: Convert __pte_free_tlb() to use ptdescs
Date:   Mon, 31 Jul 2023 10:03:25 -0700
Message-Id: <20230731170332.69404-25-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
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
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/nios2/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index ecd1657bb2ce..ce6bb8e74271 100644
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
+		pagetable_pte_dtor(page_ptdesc(pte));			\
+		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
-- 
2.40.1

