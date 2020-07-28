Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753C223003F
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgG1Df3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgG1Df2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E14C061794;
        Mon, 27 Jul 2020 20:35:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so11134494pgf.0;
        Mon, 27 Jul 2020 20:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBLkp4ACPTazmjPNrlv/57ssiAbYaRhM1wboTYBBHDY=;
        b=dVK/1EliSimIRnUstbAmbx25mSwdR+Js0puQBQW3DsLX1VrptOUZVyUDjo7npj1Mhx
         L3e5K36rO3npq4glvDBg4YqqkI4XpYAFUSzxOS1MTAz6RO3a7P1MeyS9q/dW3kz/gxle
         /9G3Jbo4dq+aolt4j2XDZLDyfRLvX2Bu2gB0/UlCQhw8WzxyINP0JWeWmD6swLpTVbI9
         MkiRqfViP/O5kKgY773WmCUMGAj6Io26pzg5z2lJr2jlGjHo5EWu36iiYvJct6hdmDjs
         xEXi9awKzb8oLJA64GjYb8TUmyGvAEj44+0XmvekMAPPeQqnnY3LYvisXSyA/Q5guxNk
         tF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBLkp4ACPTazmjPNrlv/57ssiAbYaRhM1wboTYBBHDY=;
        b=gdkVPJifBk/+tHWKmJ5D3MHdQqQEboSQje7lqIbTjreRsyIbPEAs9GWsha+w8kn8QT
         xcehuMMbZeZ5KzCC15z0H3tMzvvcS0Vmna5LpJ5jQrkOZmewHv4qTEzZmyZx5dshEjgP
         Hh6oQ0G/yLyDLGM+4W0Mw8nMZw/xEm8jyXqiJK52WC5yCYlsBquJOK6M6KNKE3bvX6V7
         oIBJzNq0dBDXfRM1iBWrUS4tuI7Pt6mV3QwEvdJB4IXPVy2YrguhhWzU5X/qVDJf16ZT
         6EOyZmse8GMePrEEy4q1rFMGpazqQGovXWFjTZdeQtiPcoVqP0tqbJTwcKSlqLWAAnwW
         oIUw==
X-Gm-Message-State: AOAM533Pg88ZQJ6OFKsnr2sbP4u5ghn7wCXKuB5TarPo7hvoetoXULHa
        E8Vi4esALs7lTQi+45G1VGTxMJP0
X-Google-Smtp-Source: ABdhPJwAK20YJK9/QxvuhDFbG5k71L1N7JplcOMAW7nPJfoIn8DDaWASYvwHqmKUD5r7MPuX4k/MPw==
X-Received: by 2002:a62:3207:: with SMTP id y7mr22632527pfy.95.1595907327960;
        Mon, 27 Jul 2020 20:35:27 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:35:27 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 18/24] s390: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:59 +1000
Message-Id: <20200728033405.78469-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/s390/include/asm/mmu_context.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index c9f3d8a52756..66f9cf0a07e3 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -15,6 +15,7 @@
 #include <asm/ctl_reg.h>
 #include <asm-generic/mm_hooks.h>
 
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -69,8 +70,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-#define destroy_context(mm)             do { } while (0)
-
 static inline void set_user_asce(struct mm_struct *mm)
 {
 	S390_lowcore.user_asce = mm->context.asce;
@@ -125,9 +124,7 @@ static inline void finish_arch_post_lock_switch(void)
 	set_fs(current->thread.mm_segment);
 }
 
-#define enter_lazy_tlb(mm,tsk)	do { } while (0)
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
                                struct mm_struct *next)
 {
@@ -136,4 +133,6 @@ static inline void activate_mm(struct mm_struct *prev,
 	set_user_asce(next);
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* __S390_MMU_CONTEXT_H */
-- 
2.23.0

