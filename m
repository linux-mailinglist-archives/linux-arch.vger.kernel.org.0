Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EA823004B
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgG1Dfu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgG1Dft (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64192C061794;
        Mon, 27 Jul 2020 20:35:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k1so10762743pjt.5;
        Mon, 27 Jul 2020 20:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAvZz66+QaBdG22l2e4wGzGeeBoM/iwnQLAAqOO4w3k=;
        b=raIuuV8uCiFBJ/lHrBNbzsGk6I9fJmFLp7oA7Q4Zq8ne0fPffDvdDzPmwQf8MDa9H5
         iq6RaDgDS0JPxC41pfFYr066sTtd/e/ecBTBQKanlt4nsYCx3YqeTiUOq7wlnd9t+5BA
         sISbSV3NUsfPoqd2v2x8llQ4NvPeMI3BHgiuuqyp/2eZg0Vx1vsvgJd+VVvWOyHfCmFP
         gjCKPkS8RMRmqcXB80sZMpzqlrJxbDN/Sgs1ZeJXVb9HN9iw2AF2NowzhdO1hYYpYA1f
         nZ09ejKNF/qR/kzz0RUyUv2jBoYLOuGa+5R4TEhDHgYlV10N2aAOgVqcRWMksd3p7pq7
         rlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAvZz66+QaBdG22l2e4wGzGeeBoM/iwnQLAAqOO4w3k=;
        b=jDaEOIst/AWWBliwZuAfHfMN4Dn/ae/4KczTu/ICr2s1OR3MmGm6Fbb+8TdMbDauZz
         2ru2O1Ws5bisYUVS87dBQeXOW9rtzQ6qt359c22Kd3I8YpXCF3hEHb6QXzG5jdKOiq0A
         bQel82WDM7rZFXq7sshwJvUxnGxTzwYirtlOyYkItV06a7dtqIq7DN3p5hY6NtkC5cOQ
         ovmeStHHytlhz5nfbZNkbNU9khvZ9wOtBdoYhaz/jPEZ7hfL4xHmfUGMhKP0aNaDc+so
         hslySyWUg+Oq0o5D5yvpxPbnIrR77tHOyR0OmQC5zEJIgTRW56mgax2U4NX495LJh5Iv
         bZfg==
X-Gm-Message-State: AOAM533srY/GNFn2LqWMGc+mzw8QGp8gntFMUXswkD2TD41JC6tgzW80
        4shfxJQdgHQfOidq8OWuqTN9VNCL
X-Google-Smtp-Source: ABdhPJx4KFc9AQIC7ArYHaqefa7TK8k/yMc05XMGZylzBAVOeed4XSg5Bld4PxWgP8XSWWG1WcH1Qw==
X-Received: by 2002:a17:902:b113:: with SMTP id q19mr21395986plr.170.1595907348803;
        Mon, 27 Jul 2020 20:35:48 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:35:48 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 23/24] x86: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:34:04 +1000
Message-Id: <20200728033405.78469-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/x86/include/asm/mmu_context.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 47562147e70b..255750548433 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -92,12 +92,14 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 }
 #endif
 
+#define enter_lazy_tlb enter_lazy_tlb
 extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 
 /*
  * Init a new mm.  Used on mm copies, like at fork()
  * and on mm's that are brand-new, like at execve().
  */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -117,6 +119,8 @@ static inline int init_new_context(struct task_struct *tsk,
 	init_new_context_ldt(mm);
 	return 0;
 }
+
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	destroy_context_ldt(mm);
@@ -215,4 +219,6 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 
 unsigned long __get_current_cr3_fast(void);
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* _ASM_X86_MMU_CONTEXT_H */
-- 
2.23.0

