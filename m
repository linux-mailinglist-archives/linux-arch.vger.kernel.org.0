Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21600230026
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgG1Dev (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgG1Deu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36438C061794;
        Mon, 27 Jul 2020 20:34:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m8so3319432pfh.3;
        Mon, 27 Jul 2020 20:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qg+y9mENI5s/3Hp67w0VaPORZ5hguo4wpnU/9+nxop0=;
        b=q8pGv5BVNDYKDeE5Q1H62HjmQ29s5vTWRt1bs9tEywFk7P2jILZZXZj8dhK+A6bNYl
         8RfDO1oURPA1Btq8/J3eK/cYo5wE58mnRy8b8DKaW2QLg6yi7EvWWbnQdfpOIMCQPi8U
         U/Wck2kQWzSKrHdiOAWxZpK6F3MSgeRSwxDh/MLTdiYW1YzoDlKf0pp3pOit8W1WSG7z
         XaxDc+A58BSmoqCWAMghjddlMJFmS86yeetQJb9oX6FwgCXm4vkKyGGa8XYX6bhWSAYL
         1m7dnzjr8UpeWd+a6aZsdXxiyey8d3NLcxPP1vijokqj0BEspe4gAFC6ey5EIW+H+wtP
         Aalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qg+y9mENI5s/3Hp67w0VaPORZ5hguo4wpnU/9+nxop0=;
        b=b04g4B0OeQISMdzMPQhWqjEjRESA0XFkig0tHL9D2zhxUpM/OJgAZNki9QKxm3gLbw
         wGIKz/J61S0OFp3rn7/Yk8YBeoFk/mIBORDnrLhUvcHcpu0LntUizL01F7gfJj5Nt2gl
         Y7R060TYltuj0E0fn+KTqX6ezOdBFbWWSqA9P7gpIhrTJQGu7gYcyQevpiORvjxORPo0
         wbv9PzLLkYJdvOsbivKG3DtUoFxWggqXMQxx8+B5DgwyEAG+xzTqHSm10MWR0qp9QQDr
         4EMJsWMBevoxc4decVtOxIpIWfgNF4snez0/bhb/r6QW3pjVjk2GHa8OtTp0+N46yykW
         Eymg==
X-Gm-Message-State: AOAM533ZONocrIIVnKVW4yQt3gipvhafPcjs358cTdeELXjLStBLfXUT
        ZShQc5Lmpry2OkeHKNcv0jd1+PFo
X-Google-Smtp-Source: ABdhPJyegue1Y71ByKLFRmuTiOaLWPUs+XfPg2h9VkUzZQTnWzkiHGsmGDR8fjYjovJnS9bGyvA9UA==
X-Received: by 2002:a63:d951:: with SMTP id e17mr22284647pgj.318.1595907289567;
        Mon, 27 Jul 2020 20:34:49 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:34:49 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH 08/24] ia64: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:49 +1000
Message-Id: <20200728033405.78469-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
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

