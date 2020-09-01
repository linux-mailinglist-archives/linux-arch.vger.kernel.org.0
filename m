Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3692590C6
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgIAOij (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgIAORs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:17:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E44C061238;
        Tue,  1 Sep 2020 07:17:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w7so870985pfi.4;
        Tue, 01 Sep 2020 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LFi90LdQN/Zk1sYT6T5v1lAFBWcv/lCT8hsQFua3q/w=;
        b=GRbCB90GdyZUi+VoPIPMsixFWPMZj2oy9F/AbKWnvm2FipfPGJ6rm1dMmzM76rSyHW
         JoXy8WZcBi9L4LHS8bOCZneb74jcAg2PgKNesxYbnnRM5Rc/oWTEtQ+IvnHzBLFz0Kea
         veq7Mb55DSVQMLTba9tXuO+bS1eTjmewXYheXfJbA90kC33Uqs1QRFN73OHttlpaXWAm
         9EecoPIEZ/PbWi/A7BXMwxe3xCT7cqF8nF4WCBrrt8t/9nYioy6zQb+02nqwpuqL9ub7
         tU5UKXd3G1H6ILcgpOPP70ReSgB9LFSoycIi2CuJhMvJIdABGd5WZ98GzniWuw5u/0fn
         CERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFi90LdQN/Zk1sYT6T5v1lAFBWcv/lCT8hsQFua3q/w=;
        b=H/2aLzArs8eErj/Az7dGFZo8t/Cik/aRpkAcItQtctuG288yAa6nXNmigk9WgVGx2c
         k0bBcaFftrdh2MoAAvaHXise/jshxzBYpycGpACsUwv/Or6gX8i5Q/dALo8LMoFLGOmb
         Cxi2dJYEFJiRCDbpbzMGZr5r+xO9tvBjuycWZ/efHx6G7JnWL+kfQwtInaDlbwBiXM4z
         ty1ejGaMFxCWwb/HHwx/3TeuLj+YPSopxOoRog+67p3IeH0a8UXfFOY7N653rH4AkMHj
         IVsiWoGnDC05qhDHdqFFEbO9GtokP6b+SJyi1dXdEjb3Vlp9NC/xfO5bMpn57P9i0ATC
         5cjA==
X-Gm-Message-State: AOAM530MTWqlbfeBaYagUOjJAUzvLN34ZekjBTR7aqhQbo8m0LQRxcZ6
        qybxp8yoV+vmLy7wvt8RDA2rA05R01U=
X-Google-Smtp-Source: ABdhPJzPQFVQko+EtVWd2JEHXsa40beM/TRyiCuAQFGgp5jdZ8vubIaNgK+HxHvBH8DRG3SBsKKPuA==
X-Received: by 2002:aa7:9d8b:: with SMTP id f11mr2043036pfq.5.1598969836473;
        Tue, 01 Sep 2020 07:17:16 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:17:16 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 22/23] x86: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:38 +1000
Message-Id: <20200901141539.1757549-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
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

