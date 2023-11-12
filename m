Return-Path: <linux-arch+bounces-138-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 960DA7E8E86
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D4C1F20FA2
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5294410;
	Sun, 12 Nov 2023 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM0z84tJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D92440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8497BC433CC;
	Sun, 12 Nov 2023 06:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769738;
	bh=zy+LIqvorCsCX2M/f8auQf0yEixqHw8DL0243s77+7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RM0z84tJA0mRaJMee/k+ux2axfXtnnmJ3Vb+KxOgBWXWNeRBvHdig4yh5SxFL/lQ0
	 0RrdKxAfQFL7jVYOmeEuWUKEWuDoO7tNWc53/eZ5c5AJC3PgcAcPf7+D1rw1+p9Z7s
	 JYx7Kmod9QzBxqdXH5lkw9zW+2FQx1auZTTrL7nLONLkq+gsHo1gqcDVSk4noc1+IV
	 RRUETV07GcboogqBaZbB47abzXtGphvh1F6qvVBifBtCcgerIOVzkbLbmpGnJyB5dM
	 UZoQUmchMmgaX3UEokh6oG7q0vDslWUjM+ykEQrxEK/4i/3MFYIJp5AVvEyR3Mm4Sq
	 Q8Xwhyfhctnng==
From: guoren@kernel.org
To: arnd@arndb.de,
	guoren@kernel.org,
	palmer@rivosinc.com,
	tglx@linutronix.de,
	conor.dooley@microchip.com,
	heiko@sntech.de,
	apatel@ventanamicro.com,
	atishp@atishpatra.org,
	bjorn@kernel.org,
	paul.walmsley@sifive.com,
	anup@brainfault.org,
	jiawei@iscas.ac.cn,
	liweiwei@iscas.ac.cn,
	wefu@redhat.com,
	U2FsdGVkX1@gmail.com,
	wangjunqiang@iscas.ac.cn,
	kito.cheng@sifive.com,
	andy.chiu@sifive.com,
	vincent.chen@sifive.com,
	greentime.hu@sifive.com,
	wuwei2016@iscas.ac.cn,
	jrtc27@jrtc27.com,
	luto@kernel.org,
	fweimer@redhat.com,
	catalin.marinas@arm.com,
	hjl.tools@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 02/38] riscv: u64ilp32: Remove compat_vdso/
Date: Sun, 12 Nov 2023 01:14:38 -0500
Message-Id: <20231112061514.2306187-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


