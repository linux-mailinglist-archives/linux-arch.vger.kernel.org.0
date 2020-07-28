Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100CC23002F
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgG1DfF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgG1DfE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB2EC061794;
        Mon, 27 Jul 2020 20:35:04 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t1so25276plq.0;
        Mon, 27 Jul 2020 20:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xunuSn00ryI5QmLOCpDWIS49LIJoLf4dCD7QK4hOYao=;
        b=Vwd0wIE5pMB1KB/6Rg4KKys5GEaOzJHcN5kMr9KEpGK4buw7zn/fxH3pXYAUoXQfu3
         BoZKoytUA00vllJ+vLtMuC32R07hA6+x6c178aV0xXjTiQCqaxk4noJUK0nWp1je6g5z
         lsxUPTuKQ5mwZOwhsSzLo60VTSsgH+YFQpEoAsvC6TErpQrEOymA4G5m1Tw0kcD5SkSq
         icb4VR1VpPVnM+yo1D9Ma1SdRO/xUFZp1IjC0qFkkd7pVYxIbG7qbVUUtEvXnEk/mpDF
         4Amp9Nrx3CeiuYrBaTCiE9mqYWD2hulfu5u71xQ7sHnrMjEGGew/v0/TlrJj0CI+r4r8
         1iHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xunuSn00ryI5QmLOCpDWIS49LIJoLf4dCD7QK4hOYao=;
        b=GFMCDH4+M9oB32IHJ8jpuvW6kS+qe1JP6sAoUIBszvp9jkJiGB0VCm4Qi+tNCwqlLJ
         o+o9hvgjVITzu46qkUk3QY9sYsJKc6AUH5mNtowUvvhAyhUAaQqNUDrkfimq8lpfAP/9
         K85wAgLggnuRbqVG3SyKpo8LYk8dsxKhtethv+WS+qqZaL2icG1rC06VHN9odwkkxiLJ
         Fc0DNBN1uvnN1UwQymlNQRY4Kyhtx2roBG08X+MjN3dIBDGqeoCUd+cmsRntjqyvvn96
         Qg0yQGrRT1zsL3w3hmXf4m5CskIXlRte6ElqRHzyoIJ4F+oui5bhmLyzw+PEYITiXVGc
         4oWg==
X-Gm-Message-State: AOAM530xFH0tjfPGBeGzNRupOY93VimMRl8qEW5VHka7oup8LM4RrA5Z
        nzgPZnszujxjSBjev+kDt8JuUYJh
X-Google-Smtp-Source: ABdhPJwy9vQsOMTnhLc0CHqQwG9d4dF5tR3qtWGL2ir+KodwPx1w+ap9da2DdFTGpoTDL5POtac2GQ==
X-Received: by 2002:a17:90a:6e47:: with SMTP id s7mr2329493pjm.217.1595907303967;
        Mon, 27 Jul 2020 20:35:03 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:35:03 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH 12/24] nds32: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:53 +1000
Message-Id: <20200728033405.78469-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/nds32/include/asm/mmu_context.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/nds32/include/asm/mmu_context.h b/arch/nds32/include/asm/mmu_context.h
index b8fd3d189fdc..c651bc8cacdc 100644
--- a/arch/nds32/include/asm/mmu_context.h
+++ b/arch/nds32/include/asm/mmu_context.h
@@ -9,6 +9,7 @@
 #include <asm/proc-fns.h>
 #include <asm-generic/mm_hooks.h>
 
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -16,8 +17,6 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
-#define destroy_context(mm)	do { } while(0)
-
 #define CID_BITS	9
 extern spinlock_t cid_lock;
 extern unsigned int cpu_last_cid;
@@ -47,10 +46,6 @@ static inline void check_context(struct mm_struct *mm)
 		__new_context(mm);
 }
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
 {
@@ -62,7 +57,6 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	}
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-#define activate_mm(prev,next)	switch_mm(prev, next, NULL)
+#include <asm-generic/mmu_context.h>
 
 #endif
-- 
2.23.0

