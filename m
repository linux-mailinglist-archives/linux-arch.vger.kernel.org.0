Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EE670824F
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjERNNB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjERNMt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B269D19BE;
        Thu, 18 May 2023 06:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD35864F43;
        Thu, 18 May 2023 13:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E0CC433D2;
        Thu, 18 May 2023 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415468;
        bh=zy+LIqvorCsCX2M/f8auQf0yEixqHw8DL0243s77+7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V33X5RSXttGRYRE6P1dvR0Tbx8vki/Mq7DswtIqCmy3ZEFQZpbBSsZILfBQdb/axC
         fW8gACvqQA8h24X6k4404VOWLXlYEJBBMImO5nemBEJZ/61Y+K01DoawjshCys6tPR
         CjMLoqcpJVur2iKg/LiMGQYwu0NzjCbEge5jadGCtxIk0hD9J9umPuYkHbaPKCDT9Y
         W3Ns51Fyrr8bLqReQVKpyg3/uZPPtBkd2mljV1s+MvXTJ7mR264CEc7tQT188cPrvB
         LeFL3fBkOwciz11llqrzSxDj2rBWzKYCoDVmv8w9JSJJWG4RoVTNoR/eGXfGTGU6TR
         8QoIvXwrddaTw==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        paul.walmsley@sifive.com, catalin.marinas@arm.com, will@kernel.org,
        rppt@kernel.org, anup@brainfault.org, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, corbet@lwn.net, wuwei2016@iscas.ac.cn,
        jrtc27@jrtc27.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH 02/22] riscv: vdso: Remove compat_vdso/
Date:   Thu, 18 May 2023 09:09:53 -0400
Message-Id: <20230518131013.3366406-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230518131013.3366406-1-guoren@kernel.org>
References: <20230518131013.3366406-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

After unifying vdso32 & vdso64 into vdso/, we ever needn't compat_vdso
directory. This commit removes the whole compat_vdso/.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/compat_vdso/.gitignore                 | 2 --
 arch/riscv/kernel/compat_vdso/compat_vdso.S              | 8 --------
 arch/riscv/kernel/compat_vdso/compat_vdso.lds.S          | 3 ---
 arch/riscv/kernel/compat_vdso/flush_icache.S             | 3 ---
 arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh | 5 -----
 arch/riscv/kernel/compat_vdso/getcpu.S                   | 3 ---
 arch/riscv/kernel/compat_vdso/note.S                     | 3 ---
 arch/riscv/kernel/compat_vdso/rt_sigreturn.S             | 3 ---
 8 files changed, 30 deletions(-)
 delete mode 100644 arch/riscv/kernel/compat_vdso/.gitignore
 delete mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.S
 delete mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
 delete mode 100644 arch/riscv/kernel/compat_vdso/flush_icache.S
 delete mode 100755 arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh
 delete mode 100644 arch/riscv/kernel/compat_vdso/getcpu.S
 delete mode 100644 arch/riscv/kernel/compat_vdso/note.S
 delete mode 100644 arch/riscv/kernel/compat_vdso/rt_sigreturn.S

diff --git a/arch/riscv/kernel/compat_vdso/.gitignore b/arch/riscv/kernel/compat_vdso/.gitignore
deleted file mode 100644
index 19d83d846c1e..000000000000
--- a/arch/riscv/kernel/compat_vdso/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-compat_vdso.lds
diff --git a/arch/riscv/kernel/compat_vdso/compat_vdso.S b/arch/riscv/kernel/compat_vdso/compat_vdso.S
deleted file mode 100644
index ffd66237e091..000000000000
--- a/arch/riscv/kernel/compat_vdso/compat_vdso.S
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#define	vdso_start	compat_vdso_start
-#define	vdso_end	compat_vdso_end
-
-#define	__VDSO_PATH	"arch/riscv/kernel/compat_vdso/compat_vdso.so"
-
-#include "../vdso/vdso.S"
diff --git a/arch/riscv/kernel/compat_vdso/compat_vdso.lds.S b/arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
deleted file mode 100644
index c7c9355d311e..000000000000
--- a/arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#include "../vdso/vdso.lds.S"
diff --git a/arch/riscv/kernel/compat_vdso/flush_icache.S b/arch/riscv/kernel/compat_vdso/flush_icache.S
deleted file mode 100644
index 523dd8b96045..000000000000
--- a/arch/riscv/kernel/compat_vdso/flush_icache.S
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#include "../vdso/flush_icache.S"
diff --git a/arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh b/arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh
deleted file mode 100755
index 8ac070c783b3..000000000000
--- a/arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-LC_ALL=C
-sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define compat\2_offset\t0x\1/p'
diff --git a/arch/riscv/kernel/compat_vdso/getcpu.S b/arch/riscv/kernel/compat_vdso/getcpu.S
deleted file mode 100644
index 10f463efe271..000000000000
--- a/arch/riscv/kernel/compat_vdso/getcpu.S
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#include "../vdso/getcpu.S"
diff --git a/arch/riscv/kernel/compat_vdso/note.S b/arch/riscv/kernel/compat_vdso/note.S
deleted file mode 100644
index b10312907542..000000000000
--- a/arch/riscv/kernel/compat_vdso/note.S
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#include "../vdso/note.S"
diff --git a/arch/riscv/kernel/compat_vdso/rt_sigreturn.S b/arch/riscv/kernel/compat_vdso/rt_sigreturn.S
deleted file mode 100644
index 884aada4facc..000000000000
--- a/arch/riscv/kernel/compat_vdso/rt_sigreturn.S
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#include "../vdso/rt_sigreturn.S"
-- 
2.36.1

