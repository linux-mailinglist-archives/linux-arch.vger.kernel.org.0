Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EF12590D2
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgIAOjf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgIAORC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:17:02 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1283C061265;
        Tue,  1 Sep 2020 07:16:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so585183plk.13;
        Tue, 01 Sep 2020 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3gjRN/KamVH3sWTz8RDBj5bBWnJISflepDch8HJoRKQ=;
        b=clQYQjHEqBLvSIfYOAtUdto16FpX8DmsWPL+uidGuhdurAKPF6RNx3tBPXa3DwTJLh
         NIu3DHt9WdtfSYzBystNWWHPgSGcSyaKtlwG30k8Pu/LCGvYFGzC6RliYcDO55n5mrf0
         6X2Fz2L36/qasOAQmhtLf3BXzKL0BxOuTuqorV0WR04sxZ4yCc2wZQqyHQI9XY4uAPLx
         dLCWCtwe7paXbmcd71RHt6E0KKaeNufjYOLTEVtT2j/KKqbYAKdovfzS9wdxiOeGqqnH
         F6Tz+2wtvSqA2N2eLnVINcH406141kCrDiwHmiwXYfjgxrxi6iHEFZCXlv79r5awdqht
         +2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3gjRN/KamVH3sWTz8RDBj5bBWnJISflepDch8HJoRKQ=;
        b=NVjH1m5naQOtFk1RL9QCDFTNfDJoKexPboBnBBHskW2o5/9jjK9Td5qHOFm+Q8kICg
         9MINTzBL0URrk07/cJF6Pg+RnVqTHAR9qTxXW24OWnoQEUoboh0UTc+rgUlBVb838Ei9
         otC3bzk2GAduwJ1mTafhwWhlu1lakZiaSKJwSRNygZ06Ws1S4m3ZiSdzpWjRPomW78n5
         UZAURHt+Mk9DbonuqgTOXcLoukcGOcOuees/mez2JGKp4ndoTtQiUDaulKgksGfj8sXB
         L9GBmgBC5SFc5nCFU7yYLjYGU/xom716oOau4wDFtOdQ9pEbhSiOvGVEgLJIYcZaiQzD
         zTNw==
X-Gm-Message-State: AOAM530OsDiUtlIGSuZYdB8IiTxTq0gqcr1s0zmdFkhruNtHPvuY9Gt8
        kuJEa/7mzRtjbKHTZ1H3klsB5hsYwDE=
X-Google-Smtp-Source: ABdhPJwf8o5Z+3C/zuq69JbjA8nGkrebFYBg2C9BnrWEmZQgV4d152UpPBXmoBoHaJDILG4ogxQpJA==
X-Received: by 2002:a17:902:b405:: with SMTP id x5mr1545946plr.267.1598969819246;
        Tue, 01 Sep 2020 07:16:59 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:58 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 18/23] s390: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:34 +1000
Message-Id: <20200901141539.1757549-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Please ack or nack if you object to this being mered via
Arnd's tree.

 arch/s390/include/asm/mmu_context.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index c9f3d8a52756..66f9cf0a07e3 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -15,6 +15,7 @@
 #include <asm/ctl_reg.h>
 #include <asm-generic/mm_hooks.h>
 
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -69,8 +70,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-#define destroy_context(mm)             do { } while (0)
-
 static inline void set_user_asce(struct mm_struct *mm)
 {
 	S390_lowcore.user_asce = mm->context.asce;
@@ -125,9 +124,7 @@ static inline void finish_arch_post_lock_switch(void)
 	set_fs(current->thread.mm_segment);
 }
 
-#define enter_lazy_tlb(mm,tsk)	do { } while (0)
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
                                struct mm_struct *next)
 {
@@ -136,4 +133,6 @@ static inline void activate_mm(struct mm_struct *prev,
 	set_user_asce(next);
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* __S390_MMU_CONTEXT_H */
-- 
2.23.0

