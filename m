Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260EC4DBB08
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 00:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbiCPX3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 19:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346886AbiCPX3t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 19:29:49 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D2D167DA
        for <linux-arch@vger.kernel.org>; Wed, 16 Mar 2022 16:28:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso3915485pjo.5
        for <linux-arch@vger.kernel.org>; Wed, 16 Mar 2022 16:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=QjUbWpYW3rVnM/AEVOfQY7Hb1962iPWLkT7GwNacZrs=;
        b=OPswRH2lRihBIfhRfn+/3FQDyS4CIDrFb0a6W/SFptnXwSb197U4E15ipwXAHAI0Ta
         TNyvuSpdp0Dl7Udy9D2GfQMyBJv1EAU0uSev1KuzOjG/5dK0WBhl8Mbqd7ahL1zjtniM
         Y1SqPUOdGayiPKAU6YQE0nUK5pJvsw2r8oicK3P3V5ZhK6gt2WLY4clS8KYMvMnsh/qH
         t1+CgGbeMH5nQ/NzMh338/CKlZC6QrLpB6Ol4xXtu3THVc5XuN017XXitVKtMXD9lQqc
         x1VUjFX+iePIisj0C7WmE0/fu1p8BI2Bk3rrSnzxy2JNeg8GQP2Fx2KEuKzIbkX7wL9d
         r1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=QjUbWpYW3rVnM/AEVOfQY7Hb1962iPWLkT7GwNacZrs=;
        b=e5CA8ciNCNb3oFdDuUEklSdIG3qq1ckMF1TGVFwh7QUcoXtqtdMhuocRnHRGwR0BpI
         4Tecvyx4svbE/NQXQ4TUSa9LSjCVlV2R6/qZyc9Y5W0o3eXoaJD7mLb0Tyg6H25ZuR06
         q9/ceG4O2hZG1Bqjsjk3lDw4n9ohz0rxR9o5bY7p/gNX//3yEhHnS7B/aEIO9PV5zzqd
         W79IPHA/mmH2msMxWaqtqE/UfmXOmuLBiO/y/O6C9dO0LEdDyCWm440V56LYoYYtkgTU
         wHKDUZw344tNkV7fHMqIK7W6cmYN1YlndD/2MTGU+XMjjikEp5Z9nIRkyXFQtUj94aNy
         MwfA==
X-Gm-Message-State: AOAM530oPINtRkLnARz/e48On3WNKAOsGdBlxvsGc+ujsAmu0Blm8gdD
        73VLFmvTqCdLP9aiidTaZJNrYQ==
X-Google-Smtp-Source: ABdhPJx15zZafntzrXc+qFtN7TCKqNirxAH51x/OX1Z7DAEkhf7MHHxu+PKBTGIRQSByMNHXy1V3iA==
X-Received: by 2002:a17:903:1206:b0:151:7d67:2924 with SMTP id l6-20020a170903120600b001517d672924mr1783497plh.45.1647473309449;
        Wed, 16 Mar 2022 16:28:29 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id pj13-20020a17090b4f4d00b001bf2ff56430sm8078615pjb.30.2022.03.16.16.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 16:28:29 -0700 (PDT)
Subject: [PATCH 4/5] RISC-V: Move to ticket-spinlocks
Date:   Wed, 16 Mar 2022 16:25:59 -0700
Message-Id: <20220316232600.20419-5-palmer@rivosinc.com>
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

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/include/asm/Kbuild           |  2 ++
 arch/riscv/include/asm/spinlock.h       | 41 +------------------------
 arch/riscv/include/asm/spinlock_types.h |  6 +---
 3 files changed, 4 insertions(+), 45 deletions(-)

diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 57b86fd9916c..42b1961af1a6 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -2,5 +2,7 @@
 generic-y += early_ioremap.h
 generic-y += flat.h
 generic-y += kvm_para.h
+generic-y += ticket-lock.h
+generic-y += ticket-lock-types.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
index f4f7fa1b7ca8..38089cbdea92 100644
--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -10,46 +10,7 @@
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
+#include <asm-generic/ticket-lock.h>
 
 static inline void arch_read_lock(arch_rwlock_t *lock)
 {
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
index 5a35a49505da..431ee08e26c4 100644
--- a/arch/riscv/include/asm/spinlock_types.h
+++ b/arch/riscv/include/asm/spinlock_types.h
@@ -10,11 +10,7 @@
 # error "please don't include this file directly"
 #endif
 
-typedef struct {
-	volatile unsigned int lock;
-} arch_spinlock_t;
-
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+#include <asm-generic/ticket-lock-types.h>
 
 typedef struct {
 	volatile unsigned int lock;
-- 
2.34.1

