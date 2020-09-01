Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB2A259116
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgIAOpC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgIAOQU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:20 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BD7C061263;
        Tue,  1 Sep 2020 07:16:20 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so757506pgl.3;
        Tue, 01 Sep 2020 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FmD6S4VqHjRXcx/+V5HKXlkHBAdRWWNIZL1IhjQV5u0=;
        b=Os1gKBY83fa3BnKaf2/Fgk8+qHXbsizFP4X+5zkibqdpKESKqO2CxfOAmi3rzOYHE9
         Vy0JGM/Mv/4WaF4mgO5D+ynpZZDqC/uI150cLaBW+aebDIZjOIRcxe8TrmaOByhj/lPv
         cMeOj+VRtfOgnNnztpMePFyY9BNSXZdESlVNAoSuMN2AS20JXT3BgCLrKKPueKJ97z/g
         sQER9bZ7UXcV2ZWFpj2aEoRBqVY9zK8yM+hswomMc3+qTQ/8XPrNIo7EjbQbceHHHw/O
         AtYWM+wBVuhixvDMKauTGbbMsdCCwCbKnMvXUL6gwdvjFBQqA2nPzs9P4KzmQUXW5Mfb
         aErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FmD6S4VqHjRXcx/+V5HKXlkHBAdRWWNIZL1IhjQV5u0=;
        b=HMQCf9X0Pfrq0Nkk+POCzAgDxBIOcIbnLLYNsqh2ESgS2MjJyjE2xEzphrK9Xv7dHV
         s/GP0CZFbBTzwjz8isioCOX8WMQ1OGfuSXWPEjamZ56LMUqhcH+H6/uT3OaoOk6N9tiR
         Op6z7EQ16fhtA3u3arGrNMal+eDXncLiFnUvOxz3bSrO6MZDjrTY4nlwc1WLXM4m/rpv
         rMmFgpWTx6fA1ABgXqh/vJioEIUtmsA2Gdg2+0Qx2/g2MhCCl19HoMCLd5R2ed8KmzLF
         7c0hZ3mldIxAHymPaVXJqNh+sWukTiz8DTP1DOUwiF9V50gvyMsQ2DiW5iawtajkX7XG
         losw==
X-Gm-Message-State: AOAM5304HNDfHgtzYwKdNWNp3HXx/C5rmrIRI599cndjAl/QZEPuXOt9
        /tnngnyxfLPSLPn8zL3zReGLww/yweU=
X-Google-Smtp-Source: ABdhPJw2zhJr1rT1/jQq//SJBkZbAVhJfAAF70Rwlclj/9VkgPdZhOkJ0VXXHUfZHxB08QZ5FQ4xcw==
X-Received: by 2002:a62:1b4a:: with SMTP id b71mr2067784pfb.235.1598969779641;
        Tue, 01 Sep 2020 07:16:19 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:19 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH v3 08/23] ia64: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:24 +1000
Message-Id: <20200901141539.1757549-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Please ack or nack if you object to this being mered via
Arnd's tree.

 arch/ia64/include/asm/mmu_context.h | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/ia64/include/asm/mmu_context.h b/arch/ia64/include/asm/mmu_context.h
index 2da0e2eb036b..87a0d5bc11ef 100644
--- a/arch/ia64/include/asm/mmu_context.h
+++ b/arch/ia64/include/asm/mmu_context.h
@@ -49,11 +49,6 @@ DECLARE_PER_CPU(u8, ia64_need_tlb_flush);
 extern void mmu_context_init (void);
 extern void wrap_mmu_context (struct mm_struct *mm);
 
-static inline void
-enter_lazy_tlb (struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /*
  * When the context counter wraps around all TLBs need to be flushed because
  * an old context number might have been reused. This is signalled by the
@@ -116,6 +111,7 @@ get_mmu_context (struct mm_struct *mm)
  * Initialize context number to some sane value.  MM is guaranteed to be a
  * brand-new address-space, so no TLB flushing is needed, ever.
  */
+#define init_new_context init_new_context
 static inline int
 init_new_context (struct task_struct *p, struct mm_struct *mm)
 {
@@ -123,12 +119,6 @@ init_new_context (struct task_struct *p, struct mm_struct *mm)
 	return 0;
 }
 
-static inline void
-destroy_context (struct mm_struct *mm)
-{
-	/* Nothing to do.  */
-}
-
 static inline void
 reload_context (nv_mm_context_t context)
 {
@@ -178,11 +168,10 @@ activate_context (struct mm_struct *mm)
 	} while (unlikely(context != mm->context));
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 /*
  * Switch from address space PREV to address space NEXT.
  */
+#define activate_mm activate_mm
 static inline void
 activate_mm (struct mm_struct *prev, struct mm_struct *next)
 {
@@ -196,5 +185,7 @@ activate_mm (struct mm_struct *prev, struct mm_struct *next)
 
 #define switch_mm(prev_mm,next_mm,next_task)	activate_mm(prev_mm, next_mm)
 
+#include <asm-generic/mmu_context.h>
+
 # endif /* ! __ASSEMBLY__ */
 #endif /* _ASM_IA64_MMU_CONTEXT_H */
-- 
2.23.0

