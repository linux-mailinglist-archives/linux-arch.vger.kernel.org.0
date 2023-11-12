Return-Path: <linux-arch+bounces-163-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706CD7E8EB5
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129661F20F63
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957C34410;
	Sun, 12 Nov 2023 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9FS9ARU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CEF440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139DCC433C8;
	Sun, 12 Nov 2023 06:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769892;
	bh=Se41gQju7esb4eo2kifFLRU4bWbFiAHi/+vBMhWFQy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q9FS9ARUamXXaaEY7AQz3NchiLDA2ZkD57Sll0hRZts0OLQyJeawiSN2smXN0fSE0
	 9PCu9cIbHg9iqvXzLl0HAhBfnbf4do6AlWl+bRNTlhzz27lrJqQtK64ckOa9E4hSMK
	 vIS/YyelQCO8j9btqRE99cEzhSJxcPhTJ7KZcb3yesHRJHsMQD3mArJ9eZS8l5puCe
	 ab+J9RECiexXhAchKZMaZaCjwLxoOPo+ETD4GaceQQhFDVJ5aOVfz8L1cTVmhjb4pV
	 7cC/lbI7m1gRb5qiB+sXzaBhgMXzocyyV36Ef52nSiA5IxVqlGcyxRr3ZMG8vsSlfE
	 nPYSCj8r+4F+g==
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
Subject: [RFC PATCH V2 27/38] riscv: s64ilp32: Correct the rv64ilp32 stackframe layout
Date: Sun, 12 Nov 2023 01:15:03 -0500
Message-Id: <20231112061514.2306187-28-guoren@kernel.org>
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

The callee saved fp & ra are xlen size, not long size. This patch
corrects the layout for the struct stackframe.

echo c > /proc/sysrq-trigger

Before the patch:

sysrq: Trigger a crash
Kernel panic - not syncing: sysrq triggered crash
CPU: 0 PID: 102 Comm: sh Not tainted 6.3.0-rc1-00084-g9e2ba938797e-dirty #2
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
---[ end Kernel panic - not syncing: sysrq triggered crash ]---

After the patch:

sysrq: Trigger a crash
Kernel panic - not syncing: sysrq triggered crash
CPU: 0 PID: 102 Comm: sh Not tainted 6.3.0-rc1-00084-g9e2ba938797e-dirty #1
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<c00050c8>] dump_backtrace+0x1e/0x26
[<c086dcae>] show_stack+0x2e/0x3c
[<c0878e00>] dump_stack_lvl+0x40/0x5a
[<c0878e30>] dump_stack+0x16/0x1e
[<c086df7c>] panic+0x10c/0x2a8
[<c04f4c1e>] sysrq_reset_seq_param_set+0x0/0x76
[<c04f52cc>] __handle_sysrq+0x9c/0x19c
[<c04f5946>] write_sysrq_trigger+0x64/0x78
[<c020c7f6>] proc_reg_write+0x4a/0xa2
[<c01acf0a>] vfs_write+0xac/0x308
[<c01ad2b8>] ksys_write+0x62/0xda
[<c01ad33e>] sys_write+0xe/0x16
[<c0879860>] do_trap_ecall_u+0xd8/0xda
[<c00037de>] ret_from_exception+0x0/0x66
---[ end Kernel panic - not syncing: sysrq triggered crash ]---

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/stacktrace.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
index f7e8ef2418b9..cea8aafbecca 100644
--- a/arch/riscv/include/asm/stacktrace.h
+++ b/arch/riscv/include/asm/stacktrace.h
@@ -8,7 +8,13 @@
 
 struct stackframe {
 	unsigned long fp;
+#ifdef CONFIG_ARCH_RV64ILP32
+	unsigned long pad1;
+#endif
 	unsigned long ra;
+#ifdef CONFIG_ARCH_RV64ILP32
+	unsigned long pad2;
+#endif
 };
 
 extern void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
-- 
2.36.1


