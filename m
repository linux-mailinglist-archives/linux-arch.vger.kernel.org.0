Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876A225325F
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgHZOzT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgHZOyY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:54:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58BFC061756;
        Wed, 26 Aug 2020 07:54:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q93so1197015pjq.0;
        Wed, 26 Aug 2020 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LFi90LdQN/Zk1sYT6T5v1lAFBWcv/lCT8hsQFua3q/w=;
        b=gAZmM9ijM6uRIbJgMuK6cdpxSCGL3X0aN2OJWq4mKPGIHQoe4uUXiMmjTeFHWBxeev
         gZnQaTfWdEDCpUVkS6o8neOVCDd16NmRnSGLN0nwvc9ysWGgKOFIDrdeqvM9kYXcoweJ
         +OYgRha6cGCWmqXx4soJtzKRuCBJQy6Prrr8yrhGaggR1EHGnKKLJ4JVDLgiOM/E6M5+
         x+X24U/Zr4fK2SyfswMohxENGL6EsmlmuPVtJkbahGTAYGvljX/dYmB6kE4Ptg4xENcX
         lo8YYPolqekviooUc9V2DHClegUUoRX91emu17f5N5iuL4gsz4NkN5RFpyHzIgBZgTGl
         pz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFi90LdQN/Zk1sYT6T5v1lAFBWcv/lCT8hsQFua3q/w=;
        b=iIPWosm0vKOMFZj+z3dbF6owicAm8D97zrKxYe/hHX++tOqAdzGhiJ9kVasI+TA0aY
         mIB1RAQL2VUQYJiU8wu+IfX4jAPYKSeOfkFF5ai0DtubRnWo158gbnHf1RPNQhaIjIKo
         h+ecW/h/FeiEcRsIDG7FuS86Tsj6dUQ9VhpA0nAQeUCmarDQNtseDNP4Z5qiYGhe72QP
         vb6tpXv40PGodrCj4SCeCzI0oD9WoftepOyyPFm6giSaibzHRVs+VXTKvfOTJ2O8nif6
         44hAQot2k56SRh98g0SAxNe4GXN1+HnPnlL1Uv8jfkS43p7kYu+OIDEirsEDxv2AAlLI
         QC1A==
X-Gm-Message-State: AOAM5319R8HBLr6oUX99AkHZ1Y83LYWV/xhkRG6mmic8KNToKAod1Qct
        9VOQ6aKuvwzJnC3iawH5ciigm2h4lTM=
X-Google-Smtp-Source: ABdhPJz+w25ojokfqUyML0jgxpkh96G1H3gOrbijHk0y9SorqFJkCxJL7p4DPgIoUQtQ/C9hxH0hig==
X-Received: by 2002:a17:902:bcc6:: with SMTP id o6mr12318919pls.109.1598453663185;
        Wed, 26 Aug 2020 07:54:23 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:54:22 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 22/23] x86: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:48 +1000
Message-Id: <20200826145249.745432-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/x86/include/asm/mmu_context.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index d98016b83755..36afcbea6a9f 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -91,12 +91,14 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
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
@@ -116,6 +118,8 @@ static inline int init_new_context(struct task_struct *tsk,
 	init_new_context_ldt(mm);
 	return 0;
 }
+
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	destroy_context_ldt(mm);
@@ -214,4 +218,6 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 
 unsigned long __get_current_cr3_fast(void);
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* _ASM_X86_MMU_CONTEXT_H */
-- 
2.23.0

