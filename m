Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0FE25323F
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHZOxt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgHZOxn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DD7C061574;
        Wed, 26 Aug 2020 07:53:43 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ls14so976628pjb.3;
        Wed, 26 Aug 2020 07:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xunuSn00ryI5QmLOCpDWIS49LIJoLf4dCD7QK4hOYao=;
        b=n1rRwMLjwoSs4LMnp2N+dPHCvP8ljePkQj/xCp/WwnZs+JpamY1B7d4lso6oW9I8ro
         0Y5ebFndVJ17LONT++8e8+yVXxoOHhaB3D4tbz+8ceizvL9vz6E0p1/uCf+1wh3tmUY4
         8yNpnr+Qlq1FF5vbKD0jVX/+YkoYybKlfjRQO6ajtH55LyHwMMGuPmiHDuJbRXm+GtA8
         hWAjFkP91086rmNtJy9BIhrgYEYZytiJO0un0JZJ0pc+Krt6HuEmGtCo4EWK9tx6fLAv
         NU+FndmpzJ1sX4NnoyS/K5rZK5agwKhZTDYqHBPsFBsigc7z5nGlab7HrdCVMdudok54
         wK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xunuSn00ryI5QmLOCpDWIS49LIJoLf4dCD7QK4hOYao=;
        b=me/2eYHoO5pYrW7XKmPjBpw4Uc9aWXSnKYdrjRIvb3LHmJ0AbwogdNwZgkDVgpyPLw
         bZnPaCLn/M5mx619q8UQYH9U5hMED5e8Lk3euYdPaBDoLoIhBaz4H2BKdDfHrFVxhYiQ
         0eemXOQpcsn1tDP+LeyClxlsuPRUmUso1L7bFDgGdlpj3/q+8SIIZ2R7g5LqSD5Za1H/
         M9NdKJAhYYoogippM2K4DrHX9T0dkeiuA/o/F+WuLpAE2dWkM5FRVzEm4HQpXiytxq1L
         PWt11dgxj6WfH2TW+YCbDgcDqCNh4MEn3WZaUd53mmDsCjAoZfx5Zi+FE9BVokztWKob
         j19Q==
X-Gm-Message-State: AOAM531ixWTjg9E85nfTC+fIXtV9QV4Tjp/YJ7QNoeBX5dqoHdySmQ4I
        ILPOSuqvZz+0h5y1bv9Z7ekeY6q1baQ=
X-Google-Smtp-Source: ABdhPJx36zSrgQ5+rUw7Uw0wSE2Zq6lUqBfvC6vMJYlTn5AKbamM0eiHzpvcIALtfEZJLDqM2W1XEg==
X-Received: by 2002:a17:90a:24f:: with SMTP id t15mr6516825pje.227.1598453622555;
        Wed, 26 Aug 2020 07:53:42 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:42 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH v2 12/23] nds32: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:38 +1000
Message-Id: <20200826145249.745432-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
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

