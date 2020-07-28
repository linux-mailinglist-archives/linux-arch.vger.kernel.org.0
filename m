Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB3A230030
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgG1DfF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgG1De5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2043CC061794;
        Mon, 27 Jul 2020 20:34:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l12so38326pgt.13;
        Mon, 27 Jul 2020 20:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wuGEwlNHfczwsScET5//DK/IY7Qs+PjjbY2XOsrR6EY=;
        b=JzX91hOG9NtIuBKa4imFLxOSKGBFW9r08mPmUWXNkmqjdFSwsFP74SFBgDJwSsT814
         fV25eF/NSdE6URAbiyqGs7Js38ZHNsC0AhFdTUyhCmEij7QkeDy1ZEvmkS46DAH7olR9
         2fS6FHJZhA/62c1/TaMzOqXffaQdQlJUJb3fU5xnIF+3ItCX8cVcEJ8QJYGBZhd0aKC8
         4ey+8pgO0OBn3NdLUoWzdfUmKRltKFTcI/aLSG8rIEU/eJqRm9Fi9xaHI2j/vmxbi8AP
         xcuNFyJwQmDeInRiVoghZzqQpGROifpDe0LkKA/a5SOINwJrVMAtmfcnj2KC5i05addr
         ZFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wuGEwlNHfczwsScET5//DK/IY7Qs+PjjbY2XOsrR6EY=;
        b=aLKdLGXLmH8D56MC0TdPjD/CkvsQnDrQzFZu21NXWOhSicryhhYgO8uR5tT6FQGKgP
         ali1xdsRWOKjFEdqN0PQpTCXEuvLYF/lbz6ROTIZsg49SwLKFY6kWnyC4yJ148DrdvLL
         sRwsSg7k7XB47wvRB88ulP8rjV7KUBJzhB2mUZQDW/MgyvmY1xvJ8JCUUJtd4R0VIbV8
         cO4lmnZoZYOudphYJVSB7GPW33CRxeuFnVP+NSLjL4qNgNavrK3P1Q0AzbMl8ZSbEuo3
         ouvJQhUZMUV1HMmC/kWRnyPky/sKLrMIPo2yX+LIhyTwb8Kww1Qe49Ukwi6OlcRGEwya
         2dkA==
X-Gm-Message-State: AOAM5302b1d9DXl7DSqmWeIge6Fq8VfaeelW1jKlgsHY6bF1M+XJ08Ow
        u5ShSxHHC6+SEjDQozyu2j6o4Y4I
X-Google-Smtp-Source: ABdhPJyB9tiMjx9VoS++5n8lKmCAqBX9f+Qc6ZVPl2F8mSMoNW/T59n6KR87om073TyALKnI3ikReg==
X-Received: by 2002:a63:d912:: with SMTP id r18mr22859487pgg.358.1595907296483;
        Mon, 27 Jul 2020 20:34:56 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:34:56 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH 10/24] microblaze: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:51 +1000
Message-Id: <20200728033405.78469-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Michal Simek <monstr@monstr.eu>
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

