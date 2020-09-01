Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E147825901F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgIAOR3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgIAOQb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D456C06121A;
        Tue,  1 Sep 2020 07:16:27 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mw10so675750pjb.2;
        Tue, 01 Sep 2020 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SbWs4d0PATtiP554ptetXUDc8hVLPW+9H9C3/1CDH4M=;
        b=n0MN0ALLct+cMJ4zTND1afwQYuKwbfUwiewSJrLiyVpFwL8+GJdrsZYlVd9vlXIQYU
         XTh6Wo3T3+vBUMHVs6idMkldSEmUWED3XGBLQuAS5beYBakuO/CEZWAXWrmlynZz/8iG
         snPoOWizNmkCw9Xy13QUUXZQFxBWqxFjZCbahHTCHINvBPVil8ID8kctveJmCeqw//tz
         OjOeKhR8WtmT959HwQLPl0XIwrkYYHftLeQReLB8NIBy8fPLPBqcXrBi2x2vO6TQI3Yi
         CHfxx1LogDrrjU02t0v5dhyC5w8BzVQbCV1+avHraMeDxs8TKpds3zkRpMNVpQ4PhEYm
         mf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SbWs4d0PATtiP554ptetXUDc8hVLPW+9H9C3/1CDH4M=;
        b=mEK3LJaAJrYgLmHLMPIeso4rVdjDgTN43R+RlPJm2MNNp7+NMS59bIc2P7b3I6PfHL
         sEL6OvHKdYyMFXI37vjgODXzPi68V5DBbkKHvtnrNDSrdBUx8jKf49NYOssqf3QiDs42
         H32sRIkmjFgRK0mPcGgBcWfpHFaJgxNyiN+Uncwk6bodRehix+KAwFvEV1Cl6Tv2EM7f
         3s5qt9u+02Hkt5AAMAb6vOplQvxwYMErSfztGuE3Jk2lwFf1LKnM9wFQVWxSb+f9ueUD
         vi7Wu2YcH0s1p2akN+dc5XBQVaTE6k9Dvu2vpbfHuldZD+Waf3Ui2/K8jJlMKedfOrEE
         +Miw==
X-Gm-Message-State: AOAM5315UQd6QLTrybOz8CvRQnSwHe6CnNGNYzKKIrBN61HL6K5fHc7W
        y7p/TXz1J3PHuwZ1Vv1nXhvCqJ/lmOc=
X-Google-Smtp-Source: ABdhPJxqvB1oc8rbYwj5XOvCl1XBMBM5W/etvhoWKaO9X3Q3hghYyipAdTeftKK9fXtdMtV6D0rnyQ==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14mr1587551plo.42.1598969786813;
        Tue, 01 Sep 2020 07:16:26 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:26 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v3 10/23] microblaze: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:26 +1000
Message-Id: <20200901141539.1757549-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Wire asm-generic/mmu_context.h to provide generic empty hooks for arch
code simplification.

Acked-by: Michal Simek <monstr@monstr.eu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/microblaze/include/asm/mmu_context_mm.h | 8 ++++----
 arch/microblaze/include/asm/processor.h      | 3 ---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/include/asm/mmu_context_mm.h b/arch/microblaze/include/asm/mmu_context_mm.h
index a1c7dd48454c..c2c77f708455 100644
--- a/arch/microblaze/include/asm/mmu_context_mm.h
+++ b/arch/microblaze/include/asm/mmu_context_mm.h
@@ -33,10 +33,6 @@
    to represent all kernel pages as shared among all contexts.
  */
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 # define NO_CONTEXT	256
 # define LAST_CONTEXT	255
 # define FIRST_CONTEXT	1
@@ -105,6 +101,7 @@ static inline void get_mmu_context(struct mm_struct *mm)
 /*
  * We're finished using the context for an address space.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	if (mm->context != NO_CONTEXT) {
@@ -126,6 +123,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *active_mm,
 			struct mm_struct *mm)
 {
@@ -136,5 +134,7 @@ static inline void activate_mm(struct mm_struct *active_mm,
 
 extern void mmu_context_init(void);
 
+#include <asm-generic/mmu_context.h>
+
 # endif /* __KERNEL__ */
 #endif /* _ASM_MICROBLAZE_MMU_CONTEXT_H */
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 1ff5a82b76b6..616211871a6e 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -122,9 +122,6 @@ unsigned long get_wchan(struct task_struct *p);
 #  define KSTK_EIP(task)	(task_pc(task))
 #  define KSTK_ESP(task)	(task_sp(task))
 
-/* FIXME */
-#  define deactivate_mm(tsk, mm)	do { } while (0)
-
 #  define STACK_TOP	TASK_SIZE
 #  define STACK_TOP_MAX	STACK_TOP
 
-- 
2.23.0

