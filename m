Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5EF5207C3
	for <lists+linux-arch@lfdr.de>; Tue, 10 May 2022 00:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiEIWga (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 18:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiEIWgZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 18:36:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF432B94FD
        for <linux-arch@vger.kernel.org>; Mon,  9 May 2022 15:32:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g184so10683031pgc.1
        for <linux-arch@vger.kernel.org>; Mon, 09 May 2022 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=l3y+uE3Fvtp2xHzyvVvn8Uk7sf8fqxmF1yAHfZGjbjE=;
        b=ozemy3V/2A3hPcMiRcW6JpuqWwi2z7SkmKjV3Cx+CGRGngIJC1+KfsoGkxMbKZq9QJ
         VW6wPMy6Un59VqW064JGGBr0reSu71Ei/+nTqVnBn2rTff18aw5kO+WwkhYJ4ds/29cm
         74bZ27YmVQCc3O8YbCoib+/b57uFAFc9xA5CLHWEQAX4EMM3+NCOB4ZdbUvpdqZaaxc3
         FHfRyaA6GuBpehGAD6bb1qzTNIq0/Ty6ShSJ0LDgouM0ewPp2dSvIoCa/83hafb8Dode
         N3ATZmgSWwyGC+QE0IyGKaptcqB7W8QhYQdHCEh/dsXg5EVr54JD0B9YfIqkTk15WJTV
         iexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=l3y+uE3Fvtp2xHzyvVvn8Uk7sf8fqxmF1yAHfZGjbjE=;
        b=5/Uf1z1IOw8d4He97wSrb5AtjarDOF/7alC2X1WW4lBGA8Gf7HH6wDyq2HpxvLV9Qt
         M/zTRjtjuxXbTTJdDs1iAQalLxcyC5ZO+I9aMbC62g6Q57OTqxKpQZ9yeyIWLoVs7KU1
         hDaHqXYgJ/4wUNT19IVfscFy1QAM9aKuCWqg4KPYmJ4Ct4Wgp4Z+5F9xVzT6vhENiW2E
         EsrIRnsVXi4OvLi9vxdXRFLadW6/EcRqNMZPnxMFIJO3wH2ua4yjRuZId/FNYRG3/xS0
         t5p4MGv3T9ir6iAi0zvdY5ygANpnBMD2WPIHXq3piLHkXInzwUN0DCeP/DkOsgpxYk7N
         OGBw==
X-Gm-Message-State: AOAM533dHdN3hmMMIv2zHyvD5d5hyyQ0P7UCvu+EEgblsPNA+vorVzP6
        9sZ/kTr0NSC4QWYdA9tmUAAnmg==
X-Google-Smtp-Source: ABdhPJz7CLkSBkLh0z66lz8HJhyESY+ateqbYGew8k99H1/oXsHvlYCBiCDWVygMoWQmV78GH8sWow==
X-Received: by 2002:a63:78ca:0:b0:398:ae5:6515 with SMTP id t193-20020a6378ca000000b003980ae56515mr14958760pgc.345.1652135549233;
        Mon, 09 May 2022 15:32:29 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z21-20020aa785d5000000b0050dc76281fdsm9267093pfn.215.2022.05.09.15.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:32:28 -0700 (PDT)
Subject: [PATCH v5 5/7] RISC-V: Move to generic spinlocks
Date:   Mon,  9 May 2022 15:29:54 -0700
Message-Id: <20220509222956.2886-6-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509222956.2886-1-palmer@rivosinc.com>
References: <20220509222956.2886-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     guoren@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, macro@orcam.me.uk,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, jszhang@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Our existing spinlocks aren't fair and replacing them has been on the
TODO list for a long time.  This moves to the recently-introduced ticket
spinlocks, which are simple enough that they are likely to be correct
and fast on the vast majority of extant implementations.

This introduces a horrible hack that allows us to split out the spinlock
conversion from the rwlock conversion.  We have to do the spinlocks
first because qrwlock needs fair spinlocks, but we don't want to pollute
the asm-generic code to support the generic spinlocks without qrwlocks.
Thus we pollute the RISC-V code, but just until the next commit as it's
all going away.

Reviewed-by: Arnd Bergmann <arnd@arndb.de
Reviewed-by: Guo Ren <guoren@kernel.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/include/asm/Kbuild           |  2 ++
 arch/riscv/include/asm/spinlock.h       | 44 +++----------------------
 arch/riscv/include/asm/spinlock_types.h |  9 +++--
 3 files changed, 10 insertions(+), 45 deletions(-)

diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 5edf5b8587e7..c3f229ae8033 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -3,5 +3,7 @@ generic-y += early_ioremap.h
 generic-y += flat.h
 generic-y += kvm_para.h
 generic-y += parport.h
+generic-y += qrwlock.h
+generic-y += qrwlock_types.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
index f4f7fa1b7ca8..88a4d5d0d98a 100644
--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -7,49 +7,13 @@
 #ifndef _ASM_RISCV_SPINLOCK_H
 #define _ASM_RISCV_SPINLOCK_H
 
+/* This is horible, but the whole file is going away in the next commit. */
+#define __ASM_GENERIC_QRWLOCK_H
+
 #include <linux/kernel.h>
 #include <asm/current.h>
 #include <asm/fence.h>
-
-/*
- * Simple spin lock operations.  These provide no fairness guarantees.
- */
-
-/* FIXME: Replace this with a ticket lock, like MIPS. */
-
-#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
-
-static inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	smp_store_release(&lock->lock, 0);
-}
-
-static inline int arch_spin_trylock(arch_spinlock_t *lock)
-{
-	int tmp = 1, busy;
-
-	__asm__ __volatile__ (
-		"	amoswap.w %0, %2, %1\n"
-		RISCV_ACQUIRE_BARRIER
-		: "=r" (busy), "+A" (lock->lock)
-		: "r" (tmp)
-		: "memory");
-
-	return !busy;
-}
-
-static inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	while (1) {
-		if (arch_spin_is_locked(lock))
-			continue;
-
-		if (arch_spin_trylock(lock))
-			break;
-	}
-}
-
-/***********************************************************/
+#include <asm-generic/spinlock.h>
 
 static inline void arch_read_lock(arch_rwlock_t *lock)
 {
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
index 5a35a49505da..f2f9b5d7120d 100644
--- a/arch/riscv/include/asm/spinlock_types.h
+++ b/arch/riscv/include/asm/spinlock_types.h
@@ -6,15 +6,14 @@
 #ifndef _ASM_RISCV_SPINLOCK_TYPES_H
 #define _ASM_RISCV_SPINLOCK_TYPES_H
 
+/* This is horible, but the whole file is going away in the next commit. */
+#define __ASM_GENERIC_QRWLOCK_TYPES_H
+
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
 
-typedef struct {
-	volatile unsigned int lock;
-} arch_spinlock_t;
-
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+#include <asm-generic/spinlock_types.h>
 
 typedef struct {
 	volatile unsigned int lock;
-- 
2.34.1

