Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516E62590D3
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgIAOjg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgIAORC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:17:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4A3C061263;
        Tue,  1 Sep 2020 07:16:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 17so857209pfw.9;
        Tue, 01 Sep 2020 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V+3JHgVNweMgUhzc7j6b8ZRjCMqnC1xbmRm2pl0WCfg=;
        b=CB20cpEqML91DElw2lqnEobmqalA/rjf60OkO/wd35o3JQ0VTyekzIDx/QYPoD8F7s
         AwLtmANxAr15KN6IwOlwQ95Brx7uEGuT98kYZy0Y/JlbjGrRTw91JcloFGznUj+dsNBZ
         l6ApDQG4/5PJicafeXy+yZxGhrac6kzjt6vcOog+Zgv9U4ZBiDWXfYoiQhbaZv8Iz1D1
         X9kejM9Q86UkBGt6doMDVld8qOp3oyG/DJj24ASee8R7OIibieQzbI6f7ZuwLI9XfX+c
         no3jk94IDfS2mDRSM3n7iV/Xl55YmrDtHrszCBy0ChWg/nXWzlnMwMEkkJBsty5S3vdr
         zM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+3JHgVNweMgUhzc7j6b8ZRjCMqnC1xbmRm2pl0WCfg=;
        b=lxABHtpvFMKx9Vizk6TX4SmT32PGgKjCq3Bc/ghve0Df8sSCVO28k2QR/q5XBYIUWM
         gCIWmu2KUunlnXXdF4ZtIxxO4leKwXH0SovFI8o2IpVr/yvx0POnTWfu7QYh2XD7tw74
         Q+7e3MZNEftucV7WfEs9sSJwWhVP+/5SSpsJ33LLT0/qJEEHQruIMVURdmbb0s3+/urX
         InUeIy2qIpZhO/VPv7LKzXRt/4XBixD39a6U1pkVbkJkRA4EyiIoV+OCJdpde85duyvd
         lQTpGW/9pQcQst0H3u2F7HucBvwv4G75WSsp0DeQIe7JRcYmoxmIZ1U4d8KOllPME5BU
         ZpTg==
X-Gm-Message-State: AOAM532X8OHZm+fy45GuOhVDgsYniBXS/nD4rXdRKSNiqSgi+QcjE3wT
        KuEKxW5zXq/a5X93g69Kr0bapa/g/8I=
X-Google-Smtp-Source: ABdhPJylKehXG36qs/dxLCybNpFCCKXykAX3lh1Xfj4HAPNNOKYZVyumOMiUgeJGuiKwKNjpyRrTdA==
X-Received: by 2002:a63:5ec5:: with SMTP id s188mr1704463pgb.218.1598969814810;
        Tue, 01 Sep 2020 07:16:54 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:54 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Pekka Enberg <penberg@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v3 17/23] riscv: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:33 +1000
Message-Id: <20200901141539.1757549-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Reviewed-by: Pekka Enberg <penberg@kernel.org>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/riscv/include/asm/mmu_context.h | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 67c463812e2d..250defa06f3a 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -13,34 +13,16 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm,
-	struct task_struct *task)
-{
-}
-
-/* Initialize context-related info for a new mm_struct */
-static inline int init_new_context(struct task_struct *task,
-	struct mm_struct *mm)
-{
-	return 0;
-}
-
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	struct task_struct *task);
 
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
 			       struct mm_struct *next)
 {
 	switch_mm(prev, next, NULL);
 }
 
-static inline void deactivate_mm(struct task_struct *task,
-	struct mm_struct *mm)
-{
-}
+#include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
-- 
2.23.0

