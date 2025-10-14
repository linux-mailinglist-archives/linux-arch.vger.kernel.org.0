Return-Path: <linux-arch+bounces-14104-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21421BDBCDD
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 01:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FA1547604
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 23:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA312F9DA1;
	Tue, 14 Oct 2025 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJhaVLVT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3792E7BC0;
	Tue, 14 Oct 2025 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760484442; cv=none; b=iUIxyECWSx3hi5WIHFtG1DbQFfy+oQTuhA7uCM/I4aOxG2ptKx3oYw0kv2uE6QgR0dlLvAz3fT4ZAevuaz1m9VjSB7ZiPnYD1ifJpa5+iypJGKBWE9XVeIgS3YyReE21Q5KEiIdPcpwsuX9rBFwkU4NicugoOi4gfill5/evK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760484442; c=relaxed/simple;
	bh=1TpApqFhm/8zdJyy1fMGH2+/kuKom2S6e7bMBlVrzaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHQMBMBys+JzM9Jv7Ekc5dMLjjQKNYQu2LY6OkfZmxxYGEYdtkyVkr/hOfFGC2sEhZyWC886TH7H7P9MAMXdj2/SCU227AzUp8EvxvNg29W9qLuOe+GSdMNh85h5kjZyebWm+8J8xHYne0/VDusVrRiB+n1iZK5mMN7TteTiQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJhaVLVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA00FC2BC9E;
	Tue, 14 Oct 2025 23:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760484441;
	bh=1TpApqFhm/8zdJyy1fMGH2+/kuKom2S6e7bMBlVrzaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MJhaVLVTpMS4DhVN7xy3hEHyuXzk6r43Kn+AEBSzU4LXGX5jF4QabLgDvRkZUOKH8
	 VFZxTTtQcb11/rIXUHJtJr+al0C307wX0VVOKSZg4oLtkQAEqIgWf7Ale4uJTxzLro
	 rtMyu3zruLexE+RU6YBjkWHr59gAB48cmJxSxWjpPE5JNxjffZGX+zfU7WWJHg4WR2
	 /U9nAL9NZcc8MvoBcG41B0tz1oz6SyABCYR5QmcwJHl0LG2AuADxSeXZ2ZhHA0/4gK
	 JZtRxO5EDXwMN97Dz8fuGlvmFVZ/ie8Mtmp5ZddzB8hF+nmbYd6y7PM3Qn+sqPnKbJ
	 z0eAFrjQwzmWg==
From: Sasha Levin <sashal@kernel.org>
To: nathan@kernel.org
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	sashal@kernel.org,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	wentaoz5@illinois.edu,
	x86@kernel.org
Subject: [RFC PATCH 4/4] x86: enable llvm-cov support
Date: Tue, 14 Oct 2025 19:26:39 -0400
Message-ID: <20251014232639.673260-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014232639.673260-1-sashal@kernel.org>
References: <20250829181007.GA468030@ax162>
 <20251014232639.673260-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Zhang <wentaoz5@illinois.edu>

Set ARCH_HAS_* options to "y" in kconfig and include section description in
linker script.

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Kconfig              | 2 ++
 arch/x86/kernel/vmlinux.lds.S | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a2..7764562df838b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -90,6 +90,8 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_LLVM_COV		if X86_64
+	select ARCH_HAS_LLVM_COV_PROFILE_ALL	if X86_64
 	select ARCH_HAS_KERNEL_FPU_SUPPORT
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index d7af4a64c211b..d2caff2a1abff 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -203,6 +203,8 @@ SECTIONS
 
 	BUG_TABLE
 
+	LLVM_COV_DATA
+
 	ORC_UNWIND_TABLE
 
 	/* Init code and data - will be freed after init */
-- 
2.51.0


