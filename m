Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9C725327D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgHZO46 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgHZOxV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5392CC061574;
        Wed, 26 Aug 2020 07:53:21 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nv17so999671pjb.3;
        Wed, 26 Aug 2020 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+cGML8t0IrnDZlw59Ro+Eu895qkrrnKIgTl4NIzGBZ4=;
        b=BspJF27QzbuQjjnvh+8w6iecMZp5YbD25ThpZed/PjkuGD6GJvNJ4CklxEb1ZrezDD
         yk7s2seci6BRkj6H0vXEDr6p6ouZWNefLvEUcER0Z4lbgqk4M/tISZl+Kg6lcDH1zm+J
         dODpaFi3JOrWQzVtm3giyP3xjFO0Q9RPJw6tbXqRFwPu8Rha7iWP7EMpxCXvA9A2Pudh
         LFalYZ8dqFGjPwLvve/KBiUZ279dPkB5bmL73P29fzrf4shaLvAf/hqdJdEXWajkCXAh
         G9VNfPz9scpQmioUtHRYPoxw2WqTtHJsSoUKxg7E5fzt5qBmZ91++UgqsvHT0OXrZyzO
         nCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+cGML8t0IrnDZlw59Ro+Eu895qkrrnKIgTl4NIzGBZ4=;
        b=nknA5B6MSKBavtZfxInU4K46I3xUY4uoQNtRHTS59tgKAtsRGWEeC8l0i6fZRJJIuH
         mgub1S55sDUq26c2sh9UHlkDz95bSkqr7HUMgZF/Kd5V5+eH13DqM8BI/H8R5uvYosEv
         v60YA+iCFRQW6HqJHRAQFi0wBnjgU2hxIZCQOh3VEp7CuNgCZg0u7JKE9d/EajrArqE3
         fDDeyRdnVJl8wr1soeKMviSQhakS3WLgaSe9AwfbzYXIR6FuxeKTu6Nfy5mP63Xbi0LQ
         L5N/J4gjjE6ZWvgAvMp5r4Da1BBGnwV8Tg2rZ4y0tPTArIFKT0F41M4NkytpfZ2EGCG9
         fPkQ==
X-Gm-Message-State: AOAM530ZKTof6WMNdXEkX8Lxh2b24bhinkISPP5f/ZUzxRqvLlroR8i4
        zs3Y/cCmekDj811DwRm3Fno2SHFSyMw=
X-Google-Smtp-Source: ABdhPJzsbZy6isz4fHT5ReTyRXlVh220hAC0FejIMuKzxdA9ukIYV2V/k8A2gJ++hFMUoDTndc1d1w==
X-Received: by 2002:a17:90a:7b82:: with SMTP id z2mr6216692pjc.106.1598453600691;
        Wed, 26 Aug 2020 07:53:20 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:20 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@kernel.org>
Subject: [PATCH v2 06/23] csky: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:32 +1000
Message-Id: <20200826145249.745432-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: linux-csky@vger.kernel.org
Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/csky/include/asm/mmu_context.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
index abdf1f1cb6ec..b227d29393a8 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -24,11 +24,6 @@
 #define cpu_asid(mm)		(atomic64_read(&mm->context.asid) & ASID_MASK)
 
 #define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.asid, 0); 0; })
-#define activate_mm(prev,next)		switch_mm(prev, next, current)
-
-#define destroy_context(mm)		do {} while (0)
-#define enter_lazy_tlb(mm, tsk)		do {} while (0)
-#define deactivate_mm(tsk, mm)		do {} while (0)
 
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
 
@@ -46,4 +41,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 	flush_icache_deferred(next);
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif /* __ASM_CSKY_MMU_CONTEXT_H */
-- 
2.23.0

