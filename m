Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C285207BE
	for <lists+linux-arch@lfdr.de>; Tue, 10 May 2022 00:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiEIWgr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 18:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiEIWg2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 18:36:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F0A2B9C98
        for <linux-arch@vger.kernel.org>; Mon,  9 May 2022 15:32:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p12so13444138pfn.0
        for <linux-arch@vger.kernel.org>; Mon, 09 May 2022 15:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=2MXHg1nHEtz4YJcqPiDeGeD1CCu8R+98LObcjAIALKk=;
        b=SJNyDksBDfIy/xljFU8N94+9xDStduZbfk4JRmLuZrEJTnw4pR6x4tyOHaQX9b58/4
         9gRdGJsoxHnnj5fhHBGLz4Ue5weaPnH1WfHru2lYGS2C7lkigvlGQvhbc+Im+y9IGfMI
         9Oi8B2OBK/KLbFctypQdxCNxtMMYcL06SeUAQUgKm6AEblKLByUQd+iI8j8r4hg+7frq
         TZfHEcdlPH2DTYQz04dU+Lj/tt2JOEIwqRE4pt6YLIOZNGwgOb0AZSDv90KM+5WaIvOG
         fdEyTwI74cuLZZaGNxtOe3XJIDxtge7EeO9OyGQrM/YPvrcN3pNdLKenYoxn3lsj5UZk
         uFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=2MXHg1nHEtz4YJcqPiDeGeD1CCu8R+98LObcjAIALKk=;
        b=SDwIq7a/NzG0vbOnb/r4G2jpeNROWRsPV2ynoKtAs/A7ON0Ze2t3PL09aejhmAKiGT
         9PuTBztMySR+LHBacU5x8VtFwZFTObiYtWmtsdecrh9ZTsgFA7RuIFegIFw0DiGdtKbq
         1BNpIkHj+omdqDuyNTct+LdzLRRNIsS30L/O/Tva/yFuKV2F8MWHu5NIiAgIwlrhr8ES
         Bxv38jt/R7kFoO2y2cdcEeENrOsydb/pvO3t8n9b4BppZQ/k+VrWt2fhaFuJ2R9Ftukk
         8bjIMd9HPvsGUY3J5+oS5Ks8gg62QcolkJtdxDlgGIkzS2mUhaF+XSTi7ut1XaFZ83/Y
         btcw==
X-Gm-Message-State: AOAM532g2DvhljaWCd/b7S0MxNH8FCDeTR/79vYA8em5sL8YiQGWmK9Y
        NCZsxYr5/22PwBKVGewYAA0uYg==
X-Google-Smtp-Source: ABdhPJyFc9YI7DdX/uV+BDVfSMLOd/pBGy6EZDj4wH/qE+g163tG1PYUrufgfLqUrsRlHs4sY7lu5w==
X-Received: by 2002:a62:b60f:0:b0:508:2a61:2c8b with SMTP id j15-20020a62b60f000000b005082a612c8bmr17904643pff.2.1652135550618;
        Mon, 09 May 2022 15:32:30 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902f14200b0015e8d4eb204sm398533plb.78.2022.05.09.15.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:32:30 -0700 (PDT)
Subject: [PATCH v5 6/7] RISC-V: Move to queued RW locks
Date:   Mon,  9 May 2022 15:29:55 -0700
Message-Id: <20220509222956.2886-7-palmer@rivosinc.com>
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
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
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

Now that we have fair spinlocks we can use the generic queued rwlocks,
so we might as well do so.

Reviewed-by: Arnd Bergmann <arnd@arndb.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/Kconfig                      |  1 +
 arch/riscv/include/asm/Kbuild           |  2 +
 arch/riscv/include/asm/spinlock.h       | 99 -------------------------
 arch/riscv/include/asm/spinlock_types.h | 24 ------
 4 files changed, 3 insertions(+), 123 deletions(-)
 delete mode 100644 arch/riscv/include/asm/spinlock.h
 delete mode 100644 arch/riscv/include/asm/spinlock_types.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 00fd9c548f26..f8a55d94016d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,7 @@ config RISCV
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
 	select ARCH_USE_MEMTEST
+	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_GENERAL_HUGETLB
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index c3f229ae8033..504f8b7e72d4 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -3,6 +3,8 @@ generic-y += early_ioremap.h
 generic-y += flat.h
 generic-y += kvm_para.h
 generic-y += parport.h
+generic-y += spinlock.h
+generic-y += spinlock_types.h
 generic-y += qrwlock.h
 generic-y += qrwlock_types.h
 generic-y += user.h
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
deleted file mode 100644
index 88a4d5d0d98a..000000000000
--- a/arch/riscv/include/asm/spinlock.h
+++ /dev/null
@@ -1,99 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2015 Regents of the University of California
- * Copyright (C) 2017 SiFive
- */
-
-#ifndef _ASM_RISCV_SPINLOCK_H
-#define _ASM_RISCV_SPINLOCK_H
-
-/* This is horible, but the whole file is going away in the next commit. */
-#define __ASM_GENERIC_QRWLOCK_H
-
-#include <linux/kernel.h>
-#include <asm/current.h>
-#include <asm/fence.h>
-#include <asm-generic/spinlock.h>
-
-static inline void arch_read_lock(arch_rwlock_t *lock)
-{
-	int tmp;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bltz	%1, 1b\n"
-		"	addi	%1, %1, 1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		: "+A" (lock->lock), "=&r" (tmp)
-		:: "memory");
-}
-
-static inline void arch_write_lock(arch_rwlock_t *lock)
-{
-	int tmp;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bnez	%1, 1b\n"
-		"	li	%1, -1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		: "+A" (lock->lock), "=&r" (tmp)
-		:: "memory");
-}
-
-static inline int arch_read_trylock(arch_rwlock_t *lock)
-{
-	int busy;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bltz	%1, 1f\n"
-		"	addi	%1, %1, 1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		"1:\n"
-		: "+A" (lock->lock), "=&r" (busy)
-		:: "memory");
-
-	return !busy;
-}
-
-static inline int arch_write_trylock(arch_rwlock_t *lock)
-{
-	int busy;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bnez	%1, 1f\n"
-		"	li	%1, -1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		"1:\n"
-		: "+A" (lock->lock), "=&r" (busy)
-		:: "memory");
-
-	return !busy;
-}
-
-static inline void arch_read_unlock(arch_rwlock_t *lock)
-{
-	__asm__ __volatile__(
-		RISCV_RELEASE_BARRIER
-		"	amoadd.w x0, %1, %0\n"
-		: "+A" (lock->lock)
-		: "r" (-1)
-		: "memory");
-}
-
-static inline void arch_write_unlock(arch_rwlock_t *lock)
-{
-	smp_store_release(&lock->lock, 0);
-}
-
-#endif /* _ASM_RISCV_SPINLOCK_H */
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
deleted file mode 100644
index f2f9b5d7120d..000000000000
--- a/arch/riscv/include/asm/spinlock_types.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2015 Regents of the University of California
- */
-
-#ifndef _ASM_RISCV_SPINLOCK_TYPES_H
-#define _ASM_RISCV_SPINLOCK_TYPES_H
-
-/* This is horible, but the whole file is going away in the next commit. */
-#define __ASM_GENERIC_QRWLOCK_TYPES_H
-
-#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
-# error "please don't include this file directly"
-#endif
-
-#include <asm-generic/spinlock_types.h>
-
-typedef struct {
-	volatile unsigned int lock;
-} arch_rwlock_t;
-
-#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
-
-#endif /* _ASM_RISCV_SPINLOCK_TYPES_H */
-- 
2.34.1

