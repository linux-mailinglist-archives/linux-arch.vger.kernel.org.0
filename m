Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A976E5357
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjDQU4C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjDQUyn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:54:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524C2659A;
        Mon, 17 Apr 2023 13:53:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l21so9395668pla.5;
        Mon, 17 Apr 2023 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764810; x=1684356810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8/b+eKq2obnq3wrn4AaChyOhPXbZKipyE2UTOB7XHg=;
        b=RTJID0Q/WW7iedj/afuCWToOfH/aBrY/NrWNeyN7ByP/usee9y9Bzy2eV2Pryddh5k
         SgN8rXjbYlFESamvA2kpEGUYeNDAEQAcb5DBJGBzqZ39H1PUjeRb3TeWmdsscSkj+duB
         XdhsoeufQBiAlQ1VDbbJWcUzg1wdK3pe72OAkzLWRjQ1C0S075Nqq87qXF8IdfaSlDxW
         +Bud3Bjv7jwgjZOfa7R1sSZhrnf0y6c/vZkSvJ9Qym0uRrXk7trecdbr2o902twf3Tei
         jaw/7g2aCCpoNC5Ttid57NGpw+n0jzjqhu5TM+KCbKbeUljRTtHuGZwGu624c+XnB9eN
         r1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764810; x=1684356810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8/b+eKq2obnq3wrn4AaChyOhPXbZKipyE2UTOB7XHg=;
        b=CtSkceqouBFbMt8hXA7jrAgfUBRZJvjlvnWFkrQCMy2LU/5UcGYPnP0gZRPAd+OAur
         4EFahtcPLXLwN2uFomjeMaU+3hkCqiUiMUnkvEnKbLlkRR/1d+J/ZzC16fAqmNZK9JyL
         zFV9FlszdJXsEL+4J02TKFs4spy6RvINn7FxFXbDoLpvklFEtYOwXbsN6vir82G560wk
         AwBVNuLvx3XW/RHBJZddb0obbDX4XRtRqZsROlPrFlhj5anMx/HFx9KgVox3xPUVKzBg
         eI7QrFWmUaaQDHQmVCAoKXX0kKvzUFne1lT/UuwZ0fs76CsTOZt41VczSz8t4WZGGQwf
         O5IQ==
X-Gm-Message-State: AAQBX9eeSvauDWouWS9Z8zfWUParQKudfd0CDk2SyjNEkfgXphejVWUZ
        1zFH6kpoKKspm97nNCMo7xM=
X-Google-Smtp-Source: AKy350Ygryz7WWGm7uHh1637qBCeDzWZK5X9wTShPkAHp+hvTpFfVrAPSXU4dDYY+IJtVCH6njxkhg==
X-Received: by 2002:a17:90a:4144:b0:240:973d:b436 with SMTP id m4-20020a17090a414400b00240973db436mr14169767pjg.49.1681764809815;
        Mon, 17 Apr 2023 13:53:29 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:29 -0700 (PDT)
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
Subject: [PATCH 32/33] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:47 -0700
Message-Id: <20230417205048.15870-33-vishal.moola@gmail.com>
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
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/um/include/asm/pgalloc.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 8ec7cd46dd96..760b029505c1 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -25,19 +25,19 @@
  */
 extern pgd_t *pgd_alloc(struct mm_struct *);
 
-#define __pte_free_tlb(tlb,pte, address)		\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb),(pte));			\
+#define __pte_free_tlb(tlb, pte, address)			\
+do {								\
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
 
-#define __pmd_free_tlb(tlb, pmd, address)		\
-do {							\
-	pgtable_pmd_page_dtor(virt_to_page(pmd));	\
-	tlb_remove_page((tlb),virt_to_page(pmd));	\
-} while (0)						\
+#define __pmd_free_tlb(tlb, pmd, address)			\
+do {								\
+	ptdesc_pmd_dtor(virt_to_ptdesc(pmd));			\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+} while (0)
 
 #endif
 
-- 
2.39.2

