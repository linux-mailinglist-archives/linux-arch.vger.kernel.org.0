Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F019D215122
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 04:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgGFCSg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Jul 2020 22:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgGFCSg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Jul 2020 22:18:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D698EC061794
        for <linux-arch@vger.kernel.org>; Sun,  5 Jul 2020 19:18:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so37643463wmh.4
        for <linux-arch@vger.kernel.org>; Sun, 05 Jul 2020 19:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8azaCA9X1iEXFHYq8WU7gBmP5Jpn7hLBsRbOcU8tD5s=;
        b=mI6BLefG8kiEdyrg3ZfySPw/VMbyr7KUsuiPQfDyaYllWfFDAsc4lEex0NPJsZ5uUT
         8mCI15rM9FpIlS2UFl5ho/2H52kvZ0eL0oBjMZ1ZUHXn6iuPCiCS4Fs2jorkhGtrsD3u
         YMed9/HJs0T3wXtX/vcFJ7td+hk78SxduBvsQzFIkp04w5YdKJ8WJfb752ml1TWLw1FS
         cU30FSRc4N7wnXGmc0ScNERfIU1VCNHAWlkvISXHCyQFtbWt7e2xFF6lMT1A0zb34BoX
         vpod83/VMHQ3QoKNhAD+qOXWW3IQXHAHv2A1ugBwA+UN5uC3Rye7/gHK7S+W5qle8cwN
         EOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8azaCA9X1iEXFHYq8WU7gBmP5Jpn7hLBsRbOcU8tD5s=;
        b=KdQw34LuXJhgYIAQy70VWwX1u/7g+r1h+LY5Ux8Au4HHHreEGiry3aMwuRRXm71Q1F
         zejn6KJWZF/ldLELZvgvo+if9n28c/XDHV7NYs5FjDDmIqN3DmKjoVxXCWxRmwji1n+C
         wsE9FSaaCINWvYWf4nqY2Q+YnD0DJ3a5HoBhpLmNcRp3/SnW/fr5beNiW9kZWtgDqG1P
         Tsjs1F88cfGD8wBIKcuQo/f50rkEwI0S0D2T3npsIHl5adxL26weMS1H0JKIWjD8p2WN
         RP7PiwzZSPZQEKz3KUbY6BcOLccU3tXDXgSnl0Lmus6EQfMZrLLklW+dfSEQiuKGdCpV
         jacg==
X-Gm-Message-State: AOAM531xh8uljXxJdmxXbsPCrYFn0M/8nq3P1anXPNgvaRoOi5ua617z
        dPOlnNxDrAwd0HxNQY2MGoI=
X-Google-Smtp-Source: ABdhPJytt4H9PGzg2ntcpGdqYseJUZTiSJiP3ITiJ9lfclGIF9hzX1UAiNy7r8mkzTctoX04E9T9CQ==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr47340897wmi.49.1594001914526;
        Sun, 05 Jul 2020 19:18:34 -0700 (PDT)
Received: from bobo.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id g14sm19096722wrw.83.2020.07.05.19.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 19:18:33 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-arch@vger.kernel.org
Subject: [PATCH] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date:   Mon,  6 Jul 2020 12:18:22 +1000
Message-Id: <20200706021822.1515189-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

powerpc return from interrupt and return from system call sequences are
context synchronising.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../features/sched/membarrier-sync-core/arch-support.txt      | 4 ++--
 arch/powerpc/Kconfig                                          | 1 +
 arch/powerpc/include/asm/exception-64s.h                      | 4 ++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 8a521a622966..52ad74a25f54 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -5,7 +5,7 @@
 #
 # Architecture requirements
 #
-# * arm/arm64
+# * arm/arm64/powerpc
 #
 # Rely on implicit context synchronization as a result of exception return
 # when returning from IPI handler, and when returning to user-space.
@@ -45,7 +45,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9fa23eb320ff..920c4e3ca4ef 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -131,6 +131,7 @@ config PPC
 	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
+	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
 	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC32 && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 47bd4ea0837d..b88cb3a989b6 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -68,6 +68,10 @@
  *
  * The nop instructions allow us to insert one or more instructions to flush the
  * L1-D cache when returning to userspace or a guest.
+ *
+ * powerpc relies on return from interrupt/syscall being context synchronising
+ * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_SYNC_CORE
+ * without additional additional synchronisation instructions.
  */
 #define RFI_FLUSH_SLOT							\
 	RFI_FLUSH_FIXUP_SECTION;					\
-- 
2.23.0

