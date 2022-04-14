Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D7F501E16
	for <lists+linux-arch@lfdr.de>; Fri, 15 Apr 2022 00:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344227AbiDNWH6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Apr 2022 18:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245175AbiDNWHq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2022 18:07:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8920ADD60
        for <linux-arch@vger.kernel.org>; Thu, 14 Apr 2022 15:05:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y6so5831967plg.2
        for <linux-arch@vger.kernel.org>; Thu, 14 Apr 2022 15:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=fGuiIocTsGNeGfljFQBqIaq8z11faA06QmkOS1ZNMsM=;
        b=R6qB8EHjaJgSIdCtMKhdYuPkgsZWKZJvItsuxrvYJe66b0kWr5qEcaypbW8fVsbM0X
         FhUqRtspmHufGwN2FALekT8CyXJm5S7kjyMcktlGU1XrpzbtotUCXZuO87tkl8dzpRsU
         rD7GHFid/eI0LZmwYI/csFXmn3CvJN7DaDKvJaMLpPJ/3/P4dIfleHYvn2zvLdnkO4tP
         7bShSmxTBQk2haxc2USQ9dtIjlVAIPg3bDRc+xVXDklpfpHWqfjPqU6sgkCSldEnbFhC
         TWJSMeobIJFf8xFLlsze9XxDtvdwjGCazEbqvvXoqURGpeC9W8m/Vt3E4JkUOM5Z3ckq
         eeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=fGuiIocTsGNeGfljFQBqIaq8z11faA06QmkOS1ZNMsM=;
        b=GOoI4rpCjhwykMyQjLAXWZxtGX2ZwJnYPbyOEAxqs/lzbEIbCegLGZnWfRjlVJZhht
         6iFOejnoN7Exf5cxog9tIsnnXFMZGEsfYWf+XEr3r0HvXjPk32DjUGX7CkcI5xfWDU7A
         xH4NmLwqQWdyLu3ycJCWmfIgx8KgWxYlCf5ASlQCFcsubZOLAn/EwlwfNUWGrP9NjS5K
         cC3xTMJcVhNNuWG9A5mK2sGXN0X5NRFbcmIUvHLL9cFf4ATltYnaZX7iqOj0NxLiPXXJ
         x4DAeREwB6HgMLVis7hRPONPpJ229gyENTH3AM4AMBB1Y1d9T+jwHgjU8XIBVmUHMA53
         NUHA==
X-Gm-Message-State: AOAM531l8vTLfRCkhBLkPHnnVxx/6Pb4CzExwXVAO7vbJMY9w5hgC9FZ
        Rfrp/Yis7a8j/2UiG+GyqTYq5w==
X-Google-Smtp-Source: ABdhPJyAzBb8YxpknFCk5JeSfiuwavmwv/MB+OUr9ESYgO7bJCkViBS7KMaonnUZ91p8m5wnAMzoYg==
X-Received: by 2002:a17:90a:4294:b0:1cd:5524:cd6a with SMTP id p20-20020a17090a429400b001cd5524cd6amr716857pjg.212.1649973919487;
        Thu, 14 Apr 2022 15:05:19 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0024c500b004fae56b2921sm805319pfv.167.2022.04.14.15.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:05:19 -0700 (PDT)
Subject: [PATCH v3 4/7] openrisc: Move to ticket-spinlock
Date:   Thu, 14 Apr 2022 15:02:11 -0700
Message-Id: <20220414220214.24556-5-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414220214.24556-1-palmer@rivosinc.com>
References: <20220414220214.24556-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, macro@orcam.me.uk,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, wangkefeng.wang@huawei.com,
        jszhang@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, guoren@kernel.org,
        shorne@gmail.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

We have no indications that openrisc meets the qspinlock requirements,
so move to ticket-spinlock as that is more likey to be correct.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

