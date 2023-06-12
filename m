Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7403D72D224
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 23:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjFLVJF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 17:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbjFLVIP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 17:08:15 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F414EC6;
        Mon, 12 Jun 2023 14:05:33 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-56cf916aaa2so27690957b3.3;
        Mon, 12 Jun 2023 14:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603933; x=1689195933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELrYSGf3rZcM0SKncNLanyoUH1rFlxcI1YjdtaAHWOM=;
        b=LyMVzyXqiqaKfQOftnbB5qB90EtUnrbgPE+tRRy8u809McOQMdRt58iULBOhR8JFtH
         hhRJmphgmRUDnbyyXP2Q9YxbwzAkn3ThfcILkwgMQG3ISbn98a07kPZmsAVC8Vehd4Mo
         1biR1LFmmxLwxk8sGkOJv0esnaOWjdr489RSbTn71+xsATggGjgO9UBlAUeAeLB5A5f/
         kGoRSfqAHa+jn1LV08UE8edOQfnKwbxOGGV8ICxkOoxOLTvOaFWF2RtvL1e5xr2jqLU0
         QA04uFGbeM6zqpolABbfncapro6b5DTja8wzwTkJfjoIbnkhTJwsqQTX3z92z2Org5Ii
         BY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603933; x=1689195933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELrYSGf3rZcM0SKncNLanyoUH1rFlxcI1YjdtaAHWOM=;
        b=ArnHzClXdY1y12f7FQE509m0PlJpFt3JJd6tI1J++PkTgUeAzJsMHZaxdEdEUiEq/k
         xltLyI7hsz9UrceUj7UayfUTMuotiVwkbwQ8Izzb6wiZpZ4VrlQiblIza1694vmV6Aae
         pPsZxc2lFsvWizzRoMllOY1UYPpfXL07yzfSuoB59itTBbE6T6Poi8zb3i5rwTPKwFUf
         n14kH/FrAc/P72JhuZNkVrApDCmMU0f1vr0SWNNJosQ1FtkpDSAfhuZj3PtV07nd7Xz9
         P7JonKKvgnV+2ejVz272kMBOBw7vrZbFkRNHsh6wZYfQLYDU5G22q0idOEdM6VnUAYNZ
         hrhA==
X-Gm-Message-State: AC+VfDzZBhS18CJA+FGaARZbiQgxymKLcrnMOHXycZJCssqnWgbdn3/R
        tWqd+v2W3rmqDJCyQiYAgDM=
X-Google-Smtp-Source: ACHHUZ7fItlbNlNZv8dpxyHqv1w2q3utm4HiSoRDwiOPIqWB+aVpZeSy3j3Rf4mLiiGsI+aWaI88yQ==
X-Received: by 2002:a81:8942:0:b0:56d:1f8d:b480 with SMTP id z63-20020a818942000000b0056d1f8db480mr4434878ywf.25.1686603932812;
        Mon, 12 Jun 2023 14:05:32 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:32 -0700 (PDT)
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
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 23/34] hexagon: Convert __pte_free_tlb() to use ptdescs
Date:   Mon, 12 Jun 2023 14:04:12 -0700
Message-Id: <20230612210423.18611-24-vishal.moola@gmail.com>
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
---
 arch/hexagon/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index f0c47e6a7427..55988625e6fb 100644
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
+	pagetable_pte_dtor((page_ptdesc(pte)));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.40.1

