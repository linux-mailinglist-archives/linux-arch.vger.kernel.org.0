Return-Path: <linux-arch+bounces-14100-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1CFBDBCA6
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 01:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD9654228A
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 23:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7302E2F13;
	Tue, 14 Oct 2025 23:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAIs28Yo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965BD221F13;
	Tue, 14 Oct 2025 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760484422; cv=none; b=BHaXjElSrTL2R0JHIcDpzB4hL3dVmXvN4EdKjpzybwUn5wQPA2jVCvXIo79LZgE2I26ssywu4p7IO7URt+OJrnXSwlKRcY/4NlLA2D69JPAAHr0pnHEx3+Ox2521vldk0xn7hWSrNzCivvN/RiZYWZxI5sxB1C4UtxBgVIYe8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760484422; c=relaxed/simple;
	bh=5P1c3HZEgKsH8ctIgX15GY1ZMuJMbfzZtY7o952H6bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYUX+ztO4lW0Om9kjdpUaHRDPnbWnU6o144abHD4nxgvEnxl0yQ7gxlOrY5hKaxSZKVFwoIKtJHB+fAN+56hBDR6gdicAc/x5Rsv7H7i9fYMyu0nF/9SGezzjvRylXUkPKqpa9mLKAU710KJvUA/WkOxYZEKhtlAJPxNJmwl3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAIs28Yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B5FC4CEE7;
	Tue, 14 Oct 2025 23:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760484421;
	bh=5P1c3HZEgKsH8ctIgX15GY1ZMuJMbfzZtY7o952H6bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAIs28YoYYvTrrE6xrA4Mqu+f7sL30GgVRQxjsd5CChdUvpnaZYJYVeiDell/F2IN
	 H9pgChYZCjj9nKJS6e181RNvep2M6yeUfhzb/IJ2zfnLF659Eyjx3NQ8j/gvPXAYZS
	 x3cnJiO3jzpTH46snLMjJVB0vCMNNLOdcCQbHgYvmZWyhdKt8mw1l3HRCL6GSMC5bL
	 82BWfHUGktSP1x3HxRKj0fZ1SEBQAAYADoP5dMMel/SZpsWaTnMVrIPmh21IgYY2oD
	 2cS3lRg2oVeaon1x3iJ2d8VmUbt1sGjKjr+Jhie7/jUpc5cXeod+vjihF24pc6Hyts
	 dfD5G9P7ZgSZg==
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
Subject: [RFC PATCH 0/4] Enable Clang's Source-based Code Coverage and MC/DC for x86-64
Date: Tue, 14 Oct 2025 19:26:35 -0400
Message-ID: <20251014232639.673260-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829181007.GA468030@ax162>
References: <20250829181007.GA468030@ax162>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for Clang's Source-based Code Coverage to the
Linux kernel, enabling more accurate coverage measurement at the source
level compared to gcov. This is particularly valuable for safety-critical
use cases (automotive, medical, aerospace) where MC/DC coverage is required
for certification.

Changes since previous patchset [1]:
- Rebased on v6.18-rc1
- Adapted to lib/crypto reorganization (curve25519 exclusion moved to
  lib/crypto/Makefile)
- Minor correctness fixes throughout the codebase

The implementation has been tested with a kernel build using Clang 18+ and
boots successfully in a KVM environment with instrumentation enabled.

[1] https://lore.kernel.org/all/20240905043245.1389509-1-wentaoz5@illinois.edu/

Wentao Zhang (4):
  llvm-cov: add Clang's Source-based Code Coverage support
  llvm-cov: add Clang's MC/DC support
  x86: disable llvm-cov instrumentation
  x86: enable llvm-cov support

 Makefile                          |   9 ++
 arch/Kconfig                      |   1 +
 arch/x86/Kconfig                  |   2 +
 arch/x86/crypto/Makefile          |   1 +
 arch/x86/kernel/vmlinux.lds.S     |   2 +
 include/asm-generic/vmlinux.lds.h |  36 +++++
 kernel/Makefile                   |   1 +
 kernel/llvm-cov/Kconfig           | 121 ++++++++++++++
 kernel/llvm-cov/Makefile          |   8 +
 kernel/llvm-cov/fs.c              | 253 ++++++++++++++++++++++++++++++
 kernel/llvm-cov/llvm-cov.h        | 157 ++++++++++++++++++
 lib/crypto/Makefile               |   3 +-
 scripts/Makefile.lib              |  23 +++
 scripts/mod/modpost.c             |   2 +
 14 files changed, 618 insertions(+), 1 deletion(-)
 create mode 100644 kernel/llvm-cov/Kconfig
 create mode 100644 kernel/llvm-cov/Makefile
 create mode 100644 kernel/llvm-cov/fs.c
 create mode 100644 kernel/llvm-cov/llvm-cov.h

-- 
2.51.0


