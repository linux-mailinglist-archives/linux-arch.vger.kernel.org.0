Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D54D515EC8
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 17:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382986AbiD3Plh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 11:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiD3Plg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 11:41:36 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C02DA0BE4
        for <linux-arch@vger.kernel.org>; Sat, 30 Apr 2022 08:37:58 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id z21so8667731pgj.1
        for <linux-arch@vger.kernel.org>; Sat, 30 Apr 2022 08:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=z3KLQgMj1TGNiy68N/+4cjWSftL0fQ46WdCXDumEo+g=;
        b=OIjS69Rysux2zOuPu+QGyQyEdlRWBp2cAHY90hMkRDcU+740wg96FctIHu6gimhe37
         lz3jiYHZzNFTdx32AfsrWEbeDRWge1y2JeufrIPVxrl4eUYhH7+j85QUjV4yTlpew1Qz
         O/Lwal75dK7+QounVjK9C7dYqAFShV4gJMNyJ1gWPoAIdrZQYBITK18BbXnd0idplft1
         QHNO3WQkZIuBSzo2GgKyrMyVdDvBNibHbD/fYMkpOV4gf5DDYvB1VFIuM6r8Hp6RMADH
         N/4tYcc94hfUa/k8OhPS1Z3ZmLWbtys1gNxrDGeNmBnciOp1mBgdO5PLtUf77tbM7NSE
         nxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=z3KLQgMj1TGNiy68N/+4cjWSftL0fQ46WdCXDumEo+g=;
        b=zjv+oGKTxAMIoq0qfcJAHS/T9JmzfeUO8RJQNVFc8FhKQu1lfmMe6hw/YFhtet5Ij0
         IjBSv0rkya3o3vVEd4i4EYzHZMdHJQCNhpJfRgyziS3ENNuBl2Y9VQKS4hf6x16TIjlD
         v8cyg3Rp3SzIXrmHFpdDITVpWAOdUJHWceQFYNVja4tq5rufABVzpDrsY5AZD61e8NKp
         Znmsnvscg8CfcbrmcNkJb8ACanoTHaKqZK3jCM+Ewf7kMsA9eKBnVL02zigDlWw05ZoG
         XLdKvIsT2tVu8ftUAN+S4sCMYFIBnZILHwjAWsaZ3ku3f53eDh65By4twfeWHelBG1Gr
         acYg==
X-Gm-Message-State: AOAM5303uR2UOxqyVPQCPRUmj+IeUFwpV25IJGnPLpI/hJ34aOvkSYf1
        wrX13WGDnHtmNt3KvCNXTxfJlw==
X-Google-Smtp-Source: ABdhPJwQ5vPL3rfJKlBBkun+N1EkTvaAg1pnc1AebUDuMRn0c3hata7ORS3NhPRk+anvBJZz91htfQ==
X-Received: by 2002:a63:81c8:0:b0:3ab:6025:f43c with SMTP id t191-20020a6381c8000000b003ab6025f43cmr3472832pgd.189.1651333077608;
        Sat, 30 Apr 2022 08:37:57 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g11-20020a63110b000000b003c14af50614sm8108129pgl.44.2022.04.30.08.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 08:37:57 -0700 (PDT)
Subject: [PATCH v4 4/7] openrisc: Move to ticket-spinlock
Date:   Sat, 30 Apr 2022 08:36:23 -0700
Message-Id: <20220430153626.30660-5-palmer@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

We have no indications that openrisc meets the qspinlock requirements,
so move to ticket-spinlock as that is more likey to be correct.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/openrisc/Kconfig                      |  1 -
 arch/openrisc/include/asm/Kbuild           |  5 ++--
 arch/openrisc/include/asm/spinlock.h       | 27 ----------------------
 arch/openrisc/include/asm/spinlock_types.h |  7 ------
 4 files changed, 2 insertions(+), 38 deletions(-)
 delete mode 100644 arch/openrisc/include/asm/spinlock.h
 delete mode 100644 arch/openrisc/include/asm/spinlock_types.h

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 0d68adf6e02b..99f0e4a4cbbd 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -30,7 +30,6 @@ config OPENRISC
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
-	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index ca5987e11053..3386b9c1c073 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
-generic-y += qspinlock_types.h
-generic-y += qspinlock.h
+generic-y += spinlock_types.h
+generic-y += spinlock.h
 generic-y += qrwlock_types.h
 generic-y += qrwlock.h
 generic-y += user.h
diff --git a/arch/openrisc/include/asm/spinlock.h b/arch/openrisc/include/asm/spinlock.h
deleted file mode 100644
index 264944a71535..000000000000
--- a/arch/openrisc/include/asm/spinlock.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * OpenRISC Linux
- *
- * Linux architectural port borrowing liberally from similar works of
- * others.  All original copyrights apply as per the original source
- * declaration.
- *
- * OpenRISC implementation:
- * Copyright (C) 2003 Matjaz Breskvar <phoenix@bsemi.com>
- * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
- * et al.
- */
-
-#ifndef __ASM_OPENRISC_SPINLOCK_H
-#define __ASM_OPENRISC_SPINLOCK_H
-
-#include <asm/qspinlock.h>
-
-#include <asm/qrwlock.h>
-
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
-
-#endif
diff --git a/arch/openrisc/include/asm/spinlock_types.h b/arch/openrisc/include/asm/spinlock_types.h
deleted file mode 100644
index 7c6fb1208c88..000000000000
--- a/arch/openrisc/include/asm/spinlock_types.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _ASM_OPENRISC_SPINLOCK_TYPES_H
-#define _ASM_OPENRISC_SPINLOCK_TYPES_H
-
-#include <asm/qspinlock_types.h>
-#include <asm/qrwlock_types.h>
-
-#endif /* _ASM_OPENRISC_SPINLOCK_TYPES_H */
-- 
2.34.1

