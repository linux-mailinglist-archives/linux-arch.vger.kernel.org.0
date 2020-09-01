Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08AB25912A
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgIAOrP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgIAOQC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE740C061260;
        Tue,  1 Sep 2020 07:16:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u20so880080pfn.0;
        Tue, 01 Sep 2020 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xhdYKbDeI//C8isyTeQG6V0bhJKWBijBvpr1V+gnGEs=;
        b=T4A+W2yS6M5KQnbIW9fn7O3Z6p924HgMcAZBjnTcSLjeYEM2j7i/Q+gVdvgLlbx/Wr
         4YVEKAwqatc9fn619WYBKrZzsiY/FPP3CKmmOSV6pRdWWoXCJqKVxKsnY1e3ZdiLnhMu
         K2WcQ9fh7POdOAW80IZXpBXTDJlaBHagPqVvbCYzlx+yMxtyzKwvl1fNG5rMazAdAfO5
         orQ6MJDdjLIpPRrMM/mwdJM1HYWX1aB6rVs/OupzKnoQzBYUTb78Lfv4vWvQdSVPg3f0
         jrpCAVBdpVqD+xODHrRTY2EC9Wh1ISt4tbvBbfVfBCy6QRabIU+JXYWatUpMvsW6kJbZ
         Ws7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhdYKbDeI//C8isyTeQG6V0bhJKWBijBvpr1V+gnGEs=;
        b=sx5RxI3wi77sgNMzx1chgl/gdtcDDLPxWBSCL4Ne5Y2NCajbbZ2QHZJYPZw/kOcsRD
         l24KR2kH5FzXhsCLwJJ4D7Hkxb0QFZMy9SGwxCZDrLORGozpMU0daaFaPV7yfyJPcKXi
         h0FFBd6EGC4ooRBlIYShzzb+8mx6ACd5K1TCWiaBimv7LjUH/wAAupwlmbEBOK+X4f1Y
         yP8xRBXjt+odPKA9YVBgzS7eY2/WyEXI7FM2HMWdLLr8zQikj/rgdTIBi6Q8WIIMqOzJ
         YrIbAhWsaSCx3u4+zRq5e7od1mG5HmUU2deS2YaeKen0ftgtC1kMHWtnEc50zYoMuUYd
         dCFw==
X-Gm-Message-State: AOAM531KVpc/Dck7d6Y0gyQhcEWnZrbgRgBwNnu19SltcVK5Hla1DaXU
        hbHXMxCkBRlQNYZLXD2l749EQHQ3i2g=
X-Google-Smtp-Source: ABdhPJyKaGdo4eiu4sBDOVDt2zOUFHP2Y2dgCjCgoPnDlnvF1oh4LLAgz1Slfa92Cw8toERGdtmjmQ==
X-Received: by 2002:a63:4923:: with SMTP id w35mr1641283pga.368.1598969760130;
        Tue, 01 Sep 2020 07:16:00 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:15:59 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH v3 03/23] arc: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:19 +1000
Message-Id: <20200901141539.1757549-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
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

Please ack or nack if you object to this being mered via
Arnd's tree.

 arch/arc/include/asm/mmu_context.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arc/include/asm/mmu_context.h b/arch/arc/include/asm/mmu_context.h
index 3a5e6a5b9ed6..df164066e172 100644
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
@@ -153,13 +155,13 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 }
 
 /*
- * Called at the time of execve() to get a new ASID
- * Note the subtlety here: get_new_mmu_context() behaves differently here
- * vs. in switch_mm(). Here it always returns a new ASID, because mm has
- * an unallocated "initial" value, while in latter, it moves to a new ASID,
- * only if it was unallocated
+ * activate_mm defaults (in asm-generic) to switch_mm and is called at the
+ * time of execve() to get a new ASID Note the subtlety here:
+ * get_new_mmu_context() behaves differently here vs. in switch_mm(). Here
+ * it always returns a new ASID, because mm has an unallocated "initial"
+ * value, while in latter, it moves to a new ASID, only if it was
+ * unallocated
  */
-#define activate_mm(prev, next)		switch_mm(prev, next, NULL)
 
 /* it seemed that deactivate_mm( ) is a reasonable place to do book-keeping
  * for retiring-mm. However destroy_context( ) still needs to do that because
@@ -168,8 +170,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * there is a good chance that task gets sched-out/in, making it's ASID valid
  * again (this teased me for a whole day).
  */
-#define deactivate_mm(tsk, mm)   do { } while (0)
 
-#define enter_lazy_tlb(mm, tsk)
+#include <asm-generic/mmu_context.h>
 
 #endif /* __ASM_ARC_MMU_CONTEXT_H */
-- 
2.23.0

