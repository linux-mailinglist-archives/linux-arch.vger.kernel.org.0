Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D995515ECB
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 17:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382978AbiD3Plj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382429AbiD3Plh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 11:41:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F691A0BF7
        for <linux-arch@vger.kernel.org>; Sat, 30 Apr 2022 08:37:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so12887031pjb.5
        for <linux-arch@vger.kernel.org>; Sat, 30 Apr 2022 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=vsFDZUB/84NzhX1Z1IP0W5vQn6O0PaUxSIdB0QjeUDc=;
        b=r9PDVKcgm65Yi4vII/nk4Hbo/0VBC0YV7rdeo8wYExc1mL5i9iTQrvolkp1GVFLke7
         +vCF/A5uqEZvh2csjfLPm8RWQsuHbKJX5kwLzm78bw0kFy42B6J4nK8MD/fKN48dI4bG
         523x+G8tMmvMFwvBTnJ9CHVBhnmsDko/gzea7i1d/e4C2uq1pHJ2kE0F23EmSkojAL3L
         fd201kWeiUl5qiV4l0f1gNZUR0QSWEbHO12tcQN0BazqIjtOLG62PJBWmQZP4OcuE4Eb
         RxvgdLj+WdYFMnxwj+PMOBWi7eBUZ7BBl2ku0KO40Vcvdzu19+9wALmnOJee6SEHdHxN
         toNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=vsFDZUB/84NzhX1Z1IP0W5vQn6O0PaUxSIdB0QjeUDc=;
        b=KsH6rW/JpUd6BeiId//z4Q/bWVrMoeONSR/5snKwnvxmWzmzJDDBEvx5IKLQoHOdNv
         Yq/A+9+GQhMgMn/CuEhzDBYG8qQysQ+g3hqqaL+KA9e/EHJ+PomwmjdMJbHlgVFZ3WwU
         fDzS2QVcuQEfFsJKLmGzH11dofG9sXm6EOUA6EVxUaDbiuA9DfdhFM9aqx3M0NG8WST1
         xNqM2p0n2vBm6d8oR10FGoAkepZIUzJ9yaN5QgGKZwQx2qEDVdozFpq9bLa7hYtw+F4p
         YSRe6mK+8blf9OYCAXndNWCttHj9nNdrRsH7TGCu1J2NkBFeVracgvoPDT3T4oSpIaAJ
         CbQg==
X-Gm-Message-State: AOAM532quaTFgUG+tzipRdLsAvsj3M+mus5Az7jwIKMuELNfe406iNA4
        vgm1aY1tkBgFRwSmUwN7Y2ouGQ==
X-Google-Smtp-Source: ABdhPJw/hFbzhIhDKerSo/xxSkM2N2Ke32oM0UbAy8C7RthY2xSvx/irL3sI6rRGhR1JZDHiupHHjA==
X-Received: by 2002:a17:902:8b8a:b0:158:fbd0:45ab with SMTP id ay10-20020a1709028b8a00b00158fbd045abmr4283114plb.110.1651333078732;
        Sat, 30 Apr 2022 08:37:58 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b0015e8d4eb1f4sm1630983plr.62.2022.04.30.08.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 08:37:58 -0700 (PDT)
Subject: [PATCH v4 5/7] RISC-V: Move to generic spinlocks
Date:   Sat, 30 Apr 2022 08:36:24 -0700
Message-Id: <20220430153626.30660-6-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220430153626.30660-1-palmer@rivosinc.com>
References: <20220430153626.30660-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     guoren@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, macro@orcam.me.uk, jszhang@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

