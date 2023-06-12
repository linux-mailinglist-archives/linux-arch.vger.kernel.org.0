Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7423E72D228
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 23:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbjFLVJH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 17:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbjFLVIO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 17:08:14 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E0B4EC5;
        Mon, 12 Jun 2023 14:05:32 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-39c7f5706f0so2833786b6e.3;
        Mon, 12 Jun 2023 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603931; x=1689195931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFY2ToTc/KdsqBsJRwbv8KRLKHn/LK4ImlbTce4a9J0=;
        b=Hs3OvBwxjNbzyixj7aSD+NgtYC45wE004i2+DhLM32gwxSgyME8uf0ehUc+DFmEBWc
         xTMw6H3P+HY7Tq7UuCfgFLKB1x+LkNTK02YDaXYWD1PeR9EEokleZ/wyxNBXTFWH/El9
         c1bXL1i+QVcFD32llcBXIuwFJs/8j8fBCHPhcoBGFcfEu/JCwezOfmF0Yorw8OxgwAQW
         Ostw6KM5t1cwURmpaD0hTGMu4TC4wHA6I1gDTQyjBc+K/xsxhtlIAUhVsIG12sG34SnA
         HCLguPK5bJjFlDAoWGoj4Zr1Q8mKdxu4vSYAJa+HTJDnQnTisEOZH/pEJVvGvXlWVYbR
         pDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603931; x=1689195931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFY2ToTc/KdsqBsJRwbv8KRLKHn/LK4ImlbTce4a9J0=;
        b=Pgn7IVIuwjCkd0iN//elxNK2meXj6z/s1lg4Nx7KW8K+HywLQR1PlrmyQD2jOPC5Ej
         OYPhPNkddXFHm4eAG0frypBOMS98jD0TmU4hEN4KmbPAqpNfkTdmGFTMRVCYRXgpQyY9
         J+J2KvxgYhUS5kJ6y4UwzD1LfopbIWiNEgXJ4q3euHyZDfSAagNRPuyexwH7c5HddMhG
         QC9TcL7jX3wYpBcOWFMISAVFw+K6JugDdC7WGOjEOh30jpOjchPSGrobgXMwHPsx+QcX
         rAjLPZdV7Tm1/qiMkVSU1vGH0KSKUElUm08oRdNjV8xcviIY9j2b5NJn0ExMq5EwJkDU
         TEvw==
X-Gm-Message-State: AC+VfDwszCoC5VAeMMvoAS7fmJaqeoZFL3dPpMSp/Jl0lrswwFqUXrKe
        vP9aS+kNi73bsgKkddgkfJk=
X-Google-Smtp-Source: ACHHUZ6j3CfgAuZNFN9JISmvDm/MlbHYE4sRUTkol2XKHwfWtbEYLS5pSkDxzuxqJ+njTa+59MBJKg==
X-Received: by 2002:a05:6358:1a8a:b0:129:bddf:7960 with SMTP id gm10-20020a0563581a8a00b00129bddf7960mr4783450rwb.16.1686603930823;
        Mon, 12 Jun 2023 14:05:30 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:30 -0700 (PDT)
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
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v4 22/34] csky: Convert __pte_free_tlb() to use ptdescs
Date:   Mon, 12 Jun 2023 14:04:11 -0700
Message-Id: <20230612210423.18611-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
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
Acked-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/include/asm/pgalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index 7d57e5da0914..9c84c9012e53 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -63,8 +63,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #define __pte_free_tlb(tlb, pte, address)		\
 do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page(tlb, pte);			\
+	pagetable_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
 } while (0)
 
 extern void pagetable_init(void);
-- 
2.40.1

