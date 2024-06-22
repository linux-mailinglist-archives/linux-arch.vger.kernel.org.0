Return-Path: <linux-arch+bounces-5016-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 723CC913294
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jun 2024 09:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E62B21379
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jun 2024 07:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A41E149E09;
	Sat, 22 Jun 2024 07:32:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296735382;
	Sat, 22 Jun 2024 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719041548; cv=none; b=aBtjx/Jr/WfNkdBE1apZJVswsyJ5GEjvFo8jvxDK5P7arbabghh3GF3zMs9gF6Lrjbz6ig1aU04ooubdAdHEfCw1UMhI0OOV7cOdEempjl1u9weQXQC4SxOwjh7c8c1FZ9ovYK/PCydZwNP0aiIeKE2qnLVyF53Qx9HLAhJ1pJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719041548; c=relaxed/simple;
	bh=nkKrH/UaCcQ/yaHBB23khAOAQ3R2ktX5uAP7Vt0xAzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rCrnM6J81MTWH01UdEjDMg+RROcr1i1OKC4kw7ItkSkqAwDpem3Ayr+8FHZTGjpGy4Qsw5EsiJTkpf3/oFNRGEfb9ZbHPI/ZDQbqql9as40gQgq/MbmuPGGua0/fbHY+uw4oRjnDGr+UmqzfWkdxnFaO4IrJujDfYXryQkHsk5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2519BC32781;
	Sat, 22 Jun 2024 07:32:24 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.10-rc5
Date: Sat, 22 Jun 2024 15:32:06 +0800
Message-ID: <20240622073206.1578052-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.10-2

for you to fetch changes up to d0a1c07739e1b7f74683fe061545669156d102f2:

  LoongArch: KVM: Remove an unneeded semicolon (2024-06-21 10:18:40 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.10-rc5

Some hw breakpoint fixes, an objtool build warnging fix, and a trivial cleanup.
----------------------------------------------------------------
Hui Li (3):
      LoongArch: Fix watchpoint setting error
      LoongArch: Trigger user-space watchpoints correctly
      LoongArch: Fix multiple hardware watchpoint issues

Xi Ruoyao (1):
      LoongArch: Only allow OBJTOOL & ORC unwinder if toolchain supports -mthin-add-sub

Yang Li (1):
      LoongArch: KVM: Remove an unneeded semicolon

 arch/loongarch/Kconfig                     |  5 +-
 arch/loongarch/Kconfig.debug               |  1 +
 arch/loongarch/include/asm/hw_breakpoint.h |  4 +-
 arch/loongarch/kernel/hw_breakpoint.c      | 96 +++++++++++++++++-------------
 arch/loongarch/kernel/ptrace.c             | 47 ++++++++-------
 arch/loongarch/kvm/exit.c                  |  2 +-
 6 files changed, 91 insertions(+), 64 deletions(-)

