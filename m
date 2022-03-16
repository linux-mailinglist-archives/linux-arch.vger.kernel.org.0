Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25E34DBB0C
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 00:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346600AbiCPX3w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 19:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347293AbiCPX3t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 19:29:49 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E791167EB
        for <linux-arch@vger.kernel.org>; Wed, 16 Mar 2022 16:28:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m22so3499725pja.0
        for <linux-arch@vger.kernel.org>; Wed, 16 Mar 2022 16:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=llt+unTQxxB47mMK9cTVf/sVk7YwdP8ahVPZ8vUzo+E=;
        b=P13QgI0zd+4RAOt3pbwZknViRr2CVhiVAFIRqM5bOGjAu9nzvjSnZusFhYRC5h9qSQ
         9JCxra+cscVH+cq1tVm8CjiuMJlxW877K2j6AlCHNuh0DRBNi9EE4AcotfiNoC3XOOLK
         dhnYjAvGq4qBYfG/ws5BM4JI/1zMJoKWHl+gPx8IkFDWC/CuJ+vSOxvmg3M8IpV/BOKi
         Oz6nK2qVkXNZ02AyIkvsE3D3PHdimNMIXmdl8ruKlmv4JHoGQeGhFIjnxn/Mq7G4QX+y
         2JDewQpoUe01b9wf6IjFRTdrHwJVTBH6ES8hoo446YGPwdfpUHyka6ajuquwNdtxfM3P
         F7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=llt+unTQxxB47mMK9cTVf/sVk7YwdP8ahVPZ8vUzo+E=;
        b=NNMxYpuVfE6fTDKIrCE8UmrwQiUa34ZVbH5Kokp4teHKN+6x7kCya4xz975I6hum0e
         9B/PwlwVJCsMXhtspuQjTTuXvvQJ7VnFArQB9PtHXrAZL/zFszPi/KULcFxnidh2dZrR
         Fqz05YRUjraXXh0MROlBs9qJXZk8/iIVsKtub2NEvMzhrW/jQjnu7mMER0VTiAMmG1bI
         mWihPrkzbQWEPE3za+YQFCZVjHWYSkYkdX9fza/T5gDhplS0xeV4sRfVFjO43cFUa1Kn
         KFkMgY4Cet+mmLwLD23iwdlH196C0SK4AS8M9Ozmuhw7LiCG+ZCJZAzofSmMy4SXGwcF
         r/ew==
X-Gm-Message-State: AOAM532xdhZ5Fvr4AaLqQmCKqJEgTu7st/Q734WdXjYkd1PUg9WwJnWV
        ked22XZum28y3gAJGUOGIYn+9g==
X-Google-Smtp-Source: ABdhPJzyPV7prsqRJmPgkY9DrfVu2bdBaNJER6RIDfsjbbPdF+/QlL1mJF+2to5VA22BRA7tJfuvxA==
X-Received: by 2002:a17:903:11c9:b0:151:9521:d5c7 with SMTP id q9-20020a17090311c900b001519521d5c7mr1923340plh.73.1647473310711;
        Wed, 16 Mar 2022 16:28:30 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id o5-20020a056a0015c500b004f7988f16c3sm4696034pfu.30.2022.03.16.16.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 16:28:30 -0700 (PDT)
Subject: [PATCH 5/5] RISC-V: Move to queued RW locks
Date:   Wed, 16 Mar 2022 16:26:00 -0700
Message-Id: <20220316232600.20419-6-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220316232600.20419-1-palmer@rivosinc.com>
References: <20220316232600.20419-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, mingo@redhat.com, Will Deacon <will@kernel.org>,
        longman@redhat.com, boqun.feng@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org, peterz@infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

With the move to fair spinlocks, we might as well move to fair rwlocks.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/Kconfig                      |  1 +
 arch/riscv/include/asm/Kbuild           |  2 +
 arch/riscv/include/asm/spinlock.h       | 82 +------------------------
 arch/riscv/include/asm/spinlock_types.h |  7 +--
 4 files changed, 5 insertions(+), 87 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5adcbd9b5e88..feb7030cfb6d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -38,6 +38,7 @@ config RISCV
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
 	select ARCH_USE_MEMTEST
+	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 42b1961af1a6..e8714070cbb9 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -4,5 +4,7 @@ generic-y += flat.h
 generic-y += kvm_para.h
 generic-y += ticket-lock.h
 generic-y += ticket-lock-types.h
+generic-y += qrwlock.h
+generic-y += qrwlock_types.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
index 38089cbdea92..97dfb150d18c 100644
--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -11,86 +11,6 @@
 #include <asm/current.h>
 #include <asm/fence.h>
 #include <asm-generic/ticket-lock.h>
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
+#include <asm/qrwlock.h>
 
 #endif /* _ASM_RISCV_SPINLOCK_H */
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
index 431ee08e26c4..3779f13706fa 100644
--- a/arch/riscv/include/asm/spinlock_types.h
+++ b/arch/riscv/include/asm/spinlock_types.h
@@ -11,11 +11,6 @@
 #endif
 
 #include <asm-generic/ticket-lock-types.h>
-
-typedef struct {
-	volatile unsigned int lock;
-} arch_rwlock_t;
-
-#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
+#include <asm/qrwlock_types.h>
 
 #endif /* _ASM_RISCV_SPINLOCK_TYPES_H */
-- 
2.34.1

