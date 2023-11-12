Return-Path: <linux-arch+bounces-143-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE987E8E90
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7571F20F75
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F41440E;
	Sun, 12 Nov 2023 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c59OtDgx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CEE440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F82C43391;
	Sun, 12 Nov 2023 06:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769770;
	bh=DKk902dUzJRu+EpHJ3Wk2xXFN2nL8OoR25SRcqCxR2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c59OtDgxKoaL5H+8t/esEfV4kKvicRpVLj8v1lnhz3siL7SoX+2IByEa0bFClwdAn
	 gWRKRChuD0ELQzyxEhYYTrZ2c111YRbKdTtjo5SAXQ7zbrerldn80owtj+w72YJl8o
	 XyBcE5AGmM3J9GulU7mgINeZo+r9aq4447aDD8rL7aO3bGorg4INoFvR5ly2W5eWa/
	 PGT6kAuUzfr9kOZVP9bqms7r2XiNrBnF3kWDsm3W6ESHZ9jx35kFCdp06buDcYrX2T
	 idUnQF9oVyN4PTA5ImVxyC9kkYF+rJYoA+Xbsf33gcQdiYEuMw0BkhIdKmJkuKVy2l
	 qZ113gkQTjpoA==
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
Subject: [RFC PATCH V2 07/38] riscv: u64ilp32: Add ptrace interface support
Date: Sun, 12 Nov 2023 01:14:43 -0500
Message-Id: <20231112061514.2306187-8-guoren@kernel.org>
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

The pt_regs of u64ilp32 is the same as the 64-bit kernel's. So, change
to use native_view instead.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 1d572cf3140f..5471b12127da 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -369,7 +369,8 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
 #ifdef CONFIG_COMPAT
-	if (test_tsk_thread_flag(task, TIF_32BIT))
+	if (test_tsk_thread_flag(task, TIF_32BIT) &&
+	   !test_tsk_thread_flag(task, TIF_64ILP32))
 		return &compat_riscv_user_native_view;
 	else
 #endif
-- 
2.36.1


