Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54708230043
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgG1Dfe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgG1Dfd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7AEC061794;
        Mon, 27 Jul 2020 20:35:33 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b9so9187552plx.6;
        Mon, 27 Jul 2020 20:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzevChhDu0zkNDnE+D6pyyVrpyllVR2c9oWvZ6O+SdA=;
        b=fMcS1wbL9TMbstUJO2nAlUpAcmqUR+PhCpjLJOWT0sR8n5XXRbC9sv/L+BRGQMTYX9
         DhyhzyBgLq3WyXVMtMSoMUjauW9o0/pLmDyUYdpJe9dJ2OV9xGYeIDtwh4TL24WlxSlM
         gcnJBjObGA3EV2yMkwGGB87W/IrYJNrwfWDUguPd7q/EmcD6ypy3ZnwIXgc4Gn9cruvk
         GsH720QkcwgubHpt9SjEiqKcy5kMEfwg4T3fkpJdQkcwPoZQ9WuT2UsYYzjTs8W+HXkg
         FwjeC+/5ABjDVxxTpcr+qA4Bv5ZG6aBfcKpQcLRZLTph3BPI/vc8BNoIMkySPyADFq93
         u6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzevChhDu0zkNDnE+D6pyyVrpyllVR2c9oWvZ6O+SdA=;
        b=TIgLRSp0nczUPC8dK+ie7L3p0sksD9kT6hxJ2P9aQlL2u8iD2UvZk7mYIlaftqXD5R
         O2izyZNtrJrXTrK46qR64LNPvxuG75mpRCd+9+WRUmP5tjS6OWaYWKLO4XB+SICvOAL2
         R/TLU563EU5BiNQL88SiWPj6oPlVYsxWe/tH+ZBC945ZEpJSVmRKA0agKKZQcKQyvuhB
         LpKIBYAhAM0059v0+hElRz2UMEMJqI6BrF8em3W7YbK06yYRRnddQbWNdrZiVMO4rYHq
         cjpRLUT2qXf/FPJIsIpXoN4UAVMapFDp391U1DiGd1o6NMZzWJdAWY2oa3vhVueROCNk
         6DVA==
X-Gm-Message-State: AOAM532bo5+j6P9+lp42uexkPm31+a92vBnGDw5d092z45q6YrRu2ZI4
        S/nEAOsnK7gD8ZsHkw4nqFN8XaVS
X-Google-Smtp-Source: ABdhPJxxOxzM2SLKd9ZcqOTFJhzmIuEoRXh4oj6u2JKpZU5DaAQV9jKU21jPNjRdgMs+dAhghdR0pQ==
X-Received: by 2002:a17:90a:4fa2:: with SMTP id q31mr2476162pjh.178.1595907332741;
        Mon, 27 Jul 2020 20:35:32 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:35:32 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH 19/24] sh: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:34:00 +1000
Message-Id: <20200728033405.78469-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/sh/include/asm/mmu_context.h    | 5 ++---
 arch/sh/include/asm/mmu_context_32.h | 9 ---------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/sh/include/asm/mmu_context.h b/arch/sh/include/asm/mmu_context.h
index 9470d17c71c2..ce40147d4a7d 100644
--- a/arch/sh/include/asm/mmu_context.h
+++ b/arch/sh/include/asm/mmu_context.h
@@ -85,6 +85,7 @@ static inline void get_mmu_context(struct mm_struct *mm, unsigned int cpu)
  * Initialize the context related info for a new mm_struct
  * instance.
  */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -121,9 +122,7 @@ static inline void switch_mm(struct mm_struct *prev,
 			activate_context(next, cpu);
 }
 
-#define activate_mm(prev, next)		switch_mm((prev),(next),NULL)
-#define deactivate_mm(tsk,mm)		do { } while (0)
-#define enter_lazy_tlb(mm,tsk)		do { } while (0)
+#include <asm-generic/mmu_context.h>
 
 #else
 
diff --git a/arch/sh/include/asm/mmu_context_32.h b/arch/sh/include/asm/mmu_context_32.h
index 71bf12ef1f65..bc5034fa6249 100644
--- a/arch/sh/include/asm/mmu_context_32.h
+++ b/arch/sh/include/asm/mmu_context_32.h
@@ -2,15 +2,6 @@
 #ifndef __ASM_SH_MMU_CONTEXT_32_H
 #define __ASM_SH_MMU_CONTEXT_32_H
 
-/*
- * Destroy context related info for an mm_struct that is about
- * to be put to rest.
- */
-static inline void destroy_context(struct mm_struct *mm)
-{
-	/* Do nothing */
-}
-
 #ifdef CONFIG_CPU_HAS_PTEAEX
 static inline void set_asid(unsigned long asid)
 {
-- 
2.23.0

