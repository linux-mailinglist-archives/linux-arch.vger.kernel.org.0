Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5D0220924
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 11:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbgGOJsk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 05:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730612AbgGOJsj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 05:48:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91251C061755
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 02:48:39 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j19so2796694pgm.11
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BE62416Xc19KRXmvjN2CjcEmrYIv08l7/E7jdoi1zI4=;
        b=ghMBMa6oHPfUaqdUjwynOWV+LMKEd8BRi/Q8axbMR0CCyoyKEzrLVIrG6ZElLCYL0O
         Vh1/EM6p8Dhca9uJkhYwZwYZ02giYdAj2qBibkHARMEx3CzYVOu/J9G7ObEbiENqdpXI
         ECJWONylQ79Oy2JRSEoEqcOom72b96KGFvRW0kvP7/T6zR64NDEeMn8zuDlMyXEHnJr9
         CxRBshIye4MDx+wxyKHCwbHmY/IFkz61uIery9g2x9D0/lLOO/6V1HEX0B8hogYHZvpi
         MQi00HLqEbNUYvRehYZAJYOJSd3/o5reDPTPGXqlUxo1VLNdcmooSzuODddGdMtr/AkN
         mjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BE62416Xc19KRXmvjN2CjcEmrYIv08l7/E7jdoi1zI4=;
        b=L3HMlueJKYTbpcqk/76JarrkJI6cl/ObHcrqqWWXDTZzrQd0vXo6eVz098SKqsSmB7
         Nfyhc6j41Yg4AE9wxR23W+HWlDS+wZFUdtokut0ZQ0Rjugud/4n8YoXxKma5sxaGb6w0
         zl6/lnhCXVVkj9Ciyug8o5bst3jj3bfYvfQ2BfBEaMS7TF1rdC8DUtzeW1y7HHkz0rLx
         4IjJZUj88NRSocZtbXTm+zuyttgmUfRcoaVx1ZY/wzaBcoa8JrKCffPK3c52CqE2vmfe
         OCjeIIfXn+tB3sNu41R6J7I6dFdj9y0BnmVh5SQkopKlFT1X3KIT6Il4LAwcd/UVMQCf
         l7Qw==
X-Gm-Message-State: AOAM532LDttBt5+/7jAz8KrTXtS6cc9WbRtbW1JZ5GiSipDg9iJ9IVzB
        fJiHQv8u2biPZoF4SbqNwX63JrQp
X-Google-Smtp-Source: ABdhPJw1ZZ9JPF/xHU2Hp61fu+puTuyZ0wJXDdK4fMm6aKqlfV/K5KJZXVLOvAn6niwYCehILcDuUw==
X-Received: by 2002:a62:7650:: with SMTP id r77mr7898932pfc.235.1594806519144;
        Wed, 15 Jul 2020 02:48:39 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id x66sm1790622pgb.12.2020.07.15.02.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:48:38 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-arch@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date:   Wed, 15 Jul 2020 19:48:29 +1000
Message-Id: <20200715094829.252208-1-npiggin@gmail.com>
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
v2: add more comments

 .../features/sched/membarrier-sync-core/arch-support.txt   | 4 ++--
 arch/powerpc/Kconfig                                       | 1 +
 arch/powerpc/include/asm/exception-64e.h                   | 6 +++++-
 arch/powerpc/include/asm/exception-64s.h                   | 7 +++++++
 arch/powerpc/kernel/entry_32.S                             | 6 ++++++
 5 files changed, 21 insertions(+), 3 deletions(-)

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
index 54a98ef7d7fe..071d7ccb830f 100644
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
+ * additional synchronisation instructions.
+ */
 #define RFI_TO_KERNEL							\
 	rfi
 
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 47bd4ea0837d..a4704f405e8d 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -68,6 +68,13 @@
  *
  * The nop instructions allow us to insert one or more instructions to flush the
  * L1-D cache when returning to userspace or a guest.
+ *
+ * powerpc relies on return from interrupt/syscall being context synchronising
+ * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_SYNC_CORE
+ * without additional additional synchronisation instructions. soft-masked
+ * interrupt replay does not include a context-synchronising rfid, but those
+ * always return to kernel, the context sync is only required for IPIs which
+ * return to user.
  */
 #define RFI_FLUSH_SLOT							\
 	RFI_FLUSH_FIXUP_SECTION;					\
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 217ebdf5b00b..23bb7352e7c3 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -35,6 +35,12 @@
 
 #include "head_32.h"
 
+/*
+ * powerpc relies on return from interrupt/syscall being context synchronising
+ * (which rfi is) to support ARCH_HAS_MEMBARRIER_SYNC_CORE without additional
+ * additional synchronisation instructions.
+ */
+
 /*
  * Align to 4k in order to ensure that all functions modyfing srr0/srr1
  * fit into one page in order to not encounter a TLB miss between the
-- 
2.23.0

