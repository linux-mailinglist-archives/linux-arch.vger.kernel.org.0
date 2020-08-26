Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6941253296
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgHZO5l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgHZOxG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69DC061574;
        Wed, 26 Aug 2020 07:53:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h2so1006136plr.0;
        Wed, 26 Aug 2020 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6IDKVv/shVEq6irgZZFcLvF1FRkf6GgTDbDcMbNEAs=;
        b=Fn3sDeuriJkzPq8xhjmF8hfliMyPLrzu+HeDi8nNSywnpEb6tEK82GyFjtvfg7Jn2G
         K3C+AVMEI43lXyXUzi5+1h/MnpOEAu5PD9nGyD55rToVneTmm9nWQwqYEVrpcDp6Cx4o
         I3M9bZbNehxI42EaM06LKpI4gdGG8tH3GyY/WJx32aiPMX3NuKpH8voX25DtXVmK/ZO3
         ULmKzAk4sf8kpnuZp+GFAkwbHP4xNDKUFp5kAFZZqBWzHrox1+JB24MC0T0hx61dxF1p
         /0dD8SEFkVJZMWFtACiTaclunC1o1Uv1uubiqa/fu1a5S2C2QV7Prjdr03x512uSNhqi
         Jf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6IDKVv/shVEq6irgZZFcLvF1FRkf6GgTDbDcMbNEAs=;
        b=TOkhqERlM8Q4+yBkpVAv3toNKjMAyRdUpbFIeuY6vf8fhxSsp75k/TFrLN5LqUEi+Z
         DI9QXHirreg9mj//sP5TiHoEONt3SQxdfhCAAaDzZ/JOuO9nxtH6Nswx8U241E1BOsVx
         B8CnMsv0xmmXmsjc0NpurpRhzVWlceXPPd7awuZf6RNm5hG6r8+quPipI9vIYoTM1RX6
         clXcLvLUnZAvvAvbRBeg1c3Un8dEFeNEDiIcIVXhoLCj1Ju30M+BGKhLdBfAYRpcxqRu
         +DPnQOEkLuFIfNQ2pfMQd8OsERn3on6+cf7kDn5q1ePJCfTmkykvhQzPLqULXw3vSLRZ
         /hqw==
X-Gm-Message-State: AOAM5305ygWhI+iMFFEpGDAsBVIkSnuyWQq849f1BrHznI3O8z+059A6
        7K3aW6L/CpNnIPZrBnyPoWnx1kaZV7E=
X-Google-Smtp-Source: ABdhPJzpYIR2LPns0GuFjTMbiHoFylGaEIOxfIsAUBjTAzVS5DVSDZOjUh4q5HoqzX5d/FcrlPnZYg==
X-Received: by 2002:a17:90b:4a46:: with SMTP id lb6mr6525335pjb.107.1598453585598;
        Wed, 26 Aug 2020 07:53:05 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:05 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH v2 02/23] alpha: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:28 +1000
Message-Id: <20200826145249.745432-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index 6d7d9bc1b4b8..4eea7c616992 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -214,8 +214,6 @@ ev4_activate_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm)
 	tbiap();
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 #ifdef CONFIG_ALPHA_GENERIC
 # define switch_mm(a,b,c)	alpha_mv.mv_switch_mm((a),(b),(c))
 # define activate_mm(x,y)	alpha_mv.mv_activate_mm((x),(y))
@@ -229,6 +227,7 @@ ev4_activate_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm)
 # endif
 #endif
 
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -242,12 +241,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
-extern inline void
-destroy_context(struct mm_struct *mm)
-{
-	/* Nothing to do.  */
-}
-
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
@@ -255,6 +249,8 @@ enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 	  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
 }
 
+#include <asm-generic/mmu_context.h>
+
 #ifdef __MMU_EXTERN_INLINE
 #undef __EXTERN_INLINE
 #undef __MMU_EXTERN_INLINE
-- 
2.23.0

