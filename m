Return-Path: <linux-arch+bounces-6714-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6116962905
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 15:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D38B2151E
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D4A188008;
	Wed, 28 Aug 2024 13:44:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8210187FF0;
	Wed, 28 Aug 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852666; cv=none; b=JEYoTOl/B/hBsqnq7yz3wh0SIToe1uu8p2TViBIzmIR/FufeqCp5K3N/gTJ7mjTu6aHdZ4yaZID8gs+W2un7TgYiDwefHmkr8QWE9qfgQfVcBQtPqsLgbKewLA1BcyOwRfO/FgbO/pUExKJG+Btai891ljtS5xG3OwNH+JZL6xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852666; c=relaxed/simple;
	bh=NQKR4kmYDJZVpjqUVVji7zM3O8nDRf8pGst/XO7dF3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TtUHZ18OGJkIPD8hRfkfGUH2puXOnwW4enULRCJWWyDDbL/Lye9ZrVJ5fGrjHQduVcTxLJhF/Ep1knmXCpP8amBEUcLP2QDGlzJZ6yyuArRXD3qwJCp1q04MiMsxAJDLC0F5oPV3A5TeTDq4rdB/bZUURllZ4gON1Kqx35kTRpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCBEC4CAD4;
	Wed, 28 Aug 2024 13:44:23 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch fixes for v6.11-rc6
Date: Wed, 28 Aug 2024 21:44:08 +0800
Message-ID: <20240828134408.3231389-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.11-2

for you to fetch changes up to 4956e07f05e239b274d042618a250c9fa3e92629:

  LoongArch: KVM: Invalidate guest steal time address on vCPU reset (2024-08-26 23:11:32 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.11-rc6

Remove the unused dma-direct.h, and some bug & warning fixes.
----------------------------------------------------------------
Bibo Mao (1):
      LoongArch: KVM: Invalidate guest steal time address on vCPU reset

Huacai Chen (1):
      LoongArch: Define ARCH_IRQ_INIT_FLAGS as IRQ_NOPROBE

Miao Wang (1):
      LoongArch: Remove the unused dma-direct.h

Tiezhu Yang (1):
      LoongArch: Add ifdefs to fix LSX and LASX related warnings

 arch/loongarch/include/asm/dma-direct.h | 11 -----------
 arch/loongarch/include/asm/hw_irq.h     |  2 ++
 arch/loongarch/include/asm/kvm_vcpu.h   |  1 -
 arch/loongarch/kernel/fpu.S             |  4 ++++
 arch/loongarch/kernel/irq.c             |  3 ---
 arch/loongarch/kvm/switch.S             |  4 ++++
 arch/loongarch/kvm/timer.c              |  7 -------
 arch/loongarch/kvm/vcpu.c               |  2 +-
 8 files changed, 11 insertions(+), 23 deletions(-)
 delete mode 100644 arch/loongarch/include/asm/dma-direct.h

