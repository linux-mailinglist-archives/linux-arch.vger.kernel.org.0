Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E6C22198C
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 03:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgGPBfg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 21:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgGPBff (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 21:35:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070F4C061755
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 18:35:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so5147339wrp.2
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 18:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=No2sfoa2XC1AzcEtK/n3qxZKzaVyUKVOKE64N4pMv54=;
        b=UHwwNzkJQ9qTDaaKlL7k/lxPK/jXaantEE3zp7KA0EWNHj+HPs1rIs3rWntTeks/o6
         +m98G3qHhJuhXaaq8kMs5n1L5gaAOL7G69soMsn2LermUDffcrkQbg8d+lBD47KfkOh/
         FWZtngpH9SVgpETAzmg1pSM0PbGP6WNa29gZ+OX8j6AX2NOPsVo5JekiDu9xM8T4vAHp
         9UgE8r8MqhF6H8LT7VR4ApCSXcZABKDhLkgudTSABbnCCuQGVny9DcDP7TsXxuamZzZ3
         fjAdMjVOkP5eknRNuqoyR2YW5UBzUKfG4rWkEWM9oqKqMhkBYXrBPeuBDzmHjTQZLURl
         aVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=No2sfoa2XC1AzcEtK/n3qxZKzaVyUKVOKE64N4pMv54=;
        b=G0qfcnCnkc+1dvG8l59R81N8qkGcmWpdiBaCEgFakhR5GRBpVOUGsqPTruojlN/fsn
         GGq0HsE86PJkKiyK/2plVt0VNbf6ZEHjZzYEhZR3TdsivKRLMFtKMvfxF05WpY7BVY6g
         uvP9vqA5Oy9iLK216MId8Ao/euxHSWa9LDxGGrKvelJhP/xZH/R5+GTLyxjxPUjaEoz8
         k8I9PKJIiJtB/ckdtdM8pzoWTVd3j64ARM28pUWoIvEMEawzkBsGqMua1QQgKoHyPMXN
         uO6ervNg4hbAK5z66YYRWaxUj4XMhuG147qOvQNDizitbAyxDxTkyroGiHPA3JJd0UTi
         Niyg==
X-Gm-Message-State: AOAM531J2DdCB1x/7bA7wvbLgiVzPAv6NJ3uArO7xqaLKth0FoY9g2ST
        dXNcbOZM54jaKNLi+XL85m0=
X-Google-Smtp-Source: ABdhPJzKwW4E8EKZahCMqsAY6dQ2dsSbs4WSKcT9kAgysOtibkSAFbX7DAlm2f6LYw5ti733qyoBTA==
X-Received: by 2002:a5d:6088:: with SMTP id w8mr2313955wrt.49.1594863332634;
        Wed, 15 Jul 2020 18:35:32 -0700 (PDT)
Received: from bobo.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id p29sm6155879wmi.43.2020.07.15.18.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 18:35:32 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-arch@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH v3] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date:   Thu, 16 Jul 2020 11:35:22 +1000
Message-Id: <20200716013522.338318-1-npiggin@gmail.com>
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

v3: more comment fixes

 .../features/sched/membarrier-sync-core/arch-support.txt  | 4 ++--
 arch/powerpc/Kconfig                                      | 1 +
 arch/powerpc/include/asm/exception-64e.h                  | 6 +++++-
 arch/powerpc/include/asm/exception-64s.h                  | 8 ++++++++
 arch/powerpc/kernel/entry_32.S                            | 6 ++++++
 5 files changed, 22 insertions(+), 3 deletions(-)

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
diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
index 54a98ef7d7fe..72b6657acd2d 100644
--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -204,7 +204,11 @@ exc_##label##_book3e:
 	LOAD_REG_ADDR(r3,interrupt_base_book3e);\
 	ori	r3,r3,vector_offset@l;		\
 	mtspr	SPRN_IVOR##vector_number,r3;
-
+/*
+ * powerpc relies on return from interrupt/syscall being context synchronising
+ * (which rfi is) to support ARCH_HAS_MEMBARRIER_SYNC_CORE without additional
+ * synchronisation instructions.
+ */
 #define RFI_TO_KERNEL							\
 	rfi
 
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 47bd4ea0837d..d7a1a427a690 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -68,6 +68,14 @@
  *
  * The nop instructions allow us to insert one or more instructions to flush the
  * L1-D cache when returning to userspace or a guest.
+ *
+ * powerpc relies on return from interrupt/syscall being context synchronising
+ * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_SYNC_CORE
+ * without additional synchronisation instructions.
+ *
+ * soft-masked interrupt replay does not include a context-synchronising rfid,
+ * but those always return to kernel, the sync is only required when returning
+ * to user.
  */
 #define RFI_FLUSH_SLOT							\
 	RFI_FLUSH_FIXUP_SECTION;					\
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 217ebdf5b00b..f4d0af8e1136 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -35,6 +35,12 @@
 
 #include "head_32.h"
 
+/*
+ * powerpc relies on return from interrupt/syscall being context synchronising
+ * (which rfi is) to support ARCH_HAS_MEMBARRIER_SYNC_CORE without additional
+ * synchronisation instructions.
+ */
+
 /*
  * Align to 4k in order to ensure that all functions modyfing srr0/srr1
  * fit into one page in order to not encounter a TLB miss between the
-- 
2.23.0

