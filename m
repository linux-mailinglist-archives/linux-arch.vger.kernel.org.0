Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB2A77343D
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjHGXIi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjHGXHb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:07:31 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF5D198C;
        Mon,  7 Aug 2023 16:06:29 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d479d128596so3766673276.1;
        Mon, 07 Aug 2023 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449580; x=1692054380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9QlLO1dPeyZnWI5hHw1TuJlTK1nfQVgIvIYX0JocUU=;
        b=ZmZBlK2BE47dPXTqc8IQ1uTKCUobrHijjQnotS76WbJUUgCGVOPFVEmsLAOFQve7Mq
         8k04A5/AuFSS607BBJG/Nd5XpAmnH5zPypJPEnlo7r978iqN52fpsMDyDxOev3Z41hLb
         CpvzpxqdWGHuM0xgZvYoYbOi2GTwb0pfPUe0oyJziB36Q6lozhNOIAq2JTvWjnhFdQ2U
         4BFxzsH5/HG/XXl5/YPVavhDi3L4gvkLB1NxxGw9654yYac9diJlEe3+5Z8y0K4G8C7u
         mJwXJ96QObfNW/oMJd7PgnIP4//NNbVjGeiAj0SJF/1wFKYAbBETcCfRmwi4qkbVDTFa
         RY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449580; x=1692054380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9QlLO1dPeyZnWI5hHw1TuJlTK1nfQVgIvIYX0JocUU=;
        b=ZtOSjQSDGrysRDDN6Fh749Slw45EwMIW29NjcJbCfB8R+K8EDI2oPO6Di08wK5XSB+
         9Z4taGldj/9fjTtKspYu4thAgPvWjZLfDBhirQZWDK/UVO/LV2sbrslbBDQm5jXPC8Ny
         GG4VFQcJKVwUOQD6srUUoH5/CwWwICEL2wzOUIC+9J5gwjhGOV1oeevsmlyHwpLPFAEU
         rFf9yfAsvOVM19Q8+UnYKncCdX6dJUcYOW1RWq6+3z6v2POFXiUSdXH9vqyxUg6OCpxI
         QjPOW4BTmhSdDPctyHDmEoN/o9R9R57jDAyFPy2olPO2Fp4LN2sC/90nSrqDgfaAyGJ2
         a90Q==
X-Gm-Message-State: AOJu0YxGWdv+E1N+1qunEwH0HOyAUZDW4qdYhBjkaU7Ejj2HA2p/bHWU
        N2iqQfjEWX9+JwdU205eeTA=
X-Google-Smtp-Source: AGHT+IFhMlpHJ+7onf6BYxf2ZEVLLZTaCynnVlAbd/4Vka+RTYiQ5OXzXPwOq0O9emhI9trC6wG3Sw==
X-Received: by 2002:a5b:f8c:0:b0:d0b:7e30:6d17 with SMTP id q12-20020a5b0f8c000000b00d0b7e306d17mr8498276ybh.14.1691449580620;
        Mon, 07 Aug 2023 16:06:20 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:06:20 -0700 (PDT)
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
        Richard Weinberger <richard@nod.at>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v9 30/31] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date:   Mon,  7 Aug 2023 16:05:12 -0700
Message-Id: <20230807230513.102486-31-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents. Also cleans up some spacing issues.

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/um/include/asm/pgalloc.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 8ec7cd46dd96..de5e31c64793 100644
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
+	pagetable_pte_dtor(page_ptdesc(pte));			\
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
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));			\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+} while (0)
 
 #endif
 
-- 
2.40.1

