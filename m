Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2C8230019
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgG1Ded (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgG1Dec (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884F7C061794;
        Mon, 27 Jul 2020 20:34:31 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m22so11104939pgv.9;
        Mon, 27 Jul 2020 20:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmVZOCfUq47mihn2FQ6TLRI6bQd0ipE9wiB6y1RWkXs=;
        b=nOYCqA5kKlucmXolFRvkYUAhgIDIrlfwX7JkbLcqxa9mVyIBAgOps2dlFBEaS06Ehm
         Opq1E8SxSa5DZcmM5gdCSJnKF1LAk8Jz3ZLnXxEu9BFgiFvabAxaIyECgBWf2/DQ5JT/
         LpohiYViviwQe/wLTxwbILwXU2Jf9kxSoBSZe2i3OUTu4DF0sNEiVjIfM8BmDPcd/PH3
         kZDZzc5VLqKq5YdTkJHXHJ60hIaPRW3wsbtjKhUIwMRUt4XxctfwIiARiMIHCc/kIlkU
         pkWWfrbTNjTqRIt4FJqv68SUeti0vau36dq4yohE7No18xzIzCLPW1klMqb3fyCHduOA
         kzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmVZOCfUq47mihn2FQ6TLRI6bQd0ipE9wiB6y1RWkXs=;
        b=Wek2PZBhUhXZMIvwNUl+2SNmrolCvqJ1d/8f0kwSbuliIjHHwyMPVlgW83WJCSbj74
         VHVdYQi/cQbI+BPB2ZEHeG01Ac5B2ap2s/J9ybqLOPYQY2NfRfNbQl01J/7mWzxaQYEC
         66y77D5hmV7Tn/GRdCN1e/qI9uyZuVqpzntQWM5ZoLn4CVnH5BcqIk1iL6wLVCVHR5XP
         7OFR93Xh834xUf7U9R5YgNSKPJ8Wnqr+BCZD93SDiIDXZzM0Ij7qwrdPfYfkT2E1Wc2n
         Qv3h1QpNGqBl4FhXITBv+81MyUVizRPX/OO6B/lPnD/lk7QyWvO0WpRwZ6B93L2apzWL
         g5DQ==
X-Gm-Message-State: AOAM530dZmmRtjD4HH9TWGUb4uGh6sOhIxK7AqToTaVfKFqoizZFa9tJ
        gKn3kK8E4HtEq91AZOVz0j5Mx1n7
X-Google-Smtp-Source: ABdhPJxrlYk3wuSoz6yW5gTVzZjaFK+AH99QTvOTfXhxxhM+IRG7XYNJ7uug5lni8egvpEIIbDr08w==
X-Received: by 2002:a65:4bc8:: with SMTP id p8mr16084763pgr.418.1595907270841;
        Mon, 27 Jul 2020 20:34:30 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:34:30 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH 03/24] arc: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:44 +1000
Message-Id: <20200728033405.78469-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arc/include/asm/mmu_context.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arc/include/asm/mmu_context.h b/arch/arc/include/asm/mmu_context.h
index 3a5e6a5b9ed6..586d31902a99 100644
--- a/arch/arc/include/asm/mmu_context.h
+++ b/arch/arc/include/asm/mmu_context.h
@@ -102,6 +102,7 @@ static inline void get_new_mmu_context(struct mm_struct *mm)
  * Initialize the context related info for a new mm_struct
  * instance.
  */
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -113,6 +114,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	unsigned long flags;
@@ -153,13 +155,12 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 }
 
 /*
- * Called at the time of execve() to get a new ASID
- * Note the subtlety here: get_new_mmu_context() behaves differently here
- * vs. in switch_mm(). Here it always returns a new ASID, because mm has
- * an unallocated "initial" value, while in latter, it moves to a new ASID,
- * only if it was unallocated
+ * activate_mm defaults to switch_mm and is called at the time of execve() to
+ * get a new ASID Note the subtlety here: get_new_mmu_context() behaves
+ * differently here vs. in switch_mm(). Here it always returns a new ASID,
+ * because mm has an unallocated "initial" value, while in latter, it moves to
+ * a new ASID, only if it was unallocated
  */
-#define activate_mm(prev, next)		switch_mm(prev, next, NULL)
 
 /* it seemed that deactivate_mm( ) is a reasonable place to do book-keeping
  * for retiring-mm. However destroy_context( ) still needs to do that because
@@ -168,8 +169,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * there is a good chance that task gets sched-out/in, making it's ASID valid
  * again (this teased me for a whole day).
  */
-#define deactivate_mm(tsk, mm)   do { } while (0)
 
-#define enter_lazy_tlb(mm, tsk)
+#include <asm-generic/mmu_context.h>
 
 #endif /* __ASM_ARC_MMU_CONTEXT_H */
-- 
2.23.0

