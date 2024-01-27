Return-Path: <linux-arch+bounces-1738-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AFB83EBFD
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jan 2024 09:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A0F1F232C7
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jan 2024 08:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E617721;
	Sat, 27 Jan 2024 08:14:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8CC1DA20;
	Sat, 27 Jan 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706343274; cv=none; b=RwaR7/BHpbgnKeOwWKpP2/hnqrNxCs1Gmz8v0XO3RNXFx3Rwj0/SRCmqVTm3NlWPntL6vaGW7fwmXStLcn4fpbiMR7XjFwrl63pLmiP61qoS/4C7orkVSMlvagZfzVbVFVunHwkMlCcagzOA5U55b9OGeIkm+xod1ig2VSjABWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706343274; c=relaxed/simple;
	bh=eDHTQC1CndZwwXi0lTafYiYOhUPLfTEZ+eyORirvrzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WwHZfGE+IrSw3nmpbdChADC+8yQjviWFBqaYcV02hGhG3GNzUP7LL4zbaNZ9AHiiCsIxslJf9+JOIfiB1sbiwZkd3uJoiHs6nZznDIMe96bupLJelsSlvd5GHD084G3IpcugbuIP+dc2HLwplXaNSc5S/X+lCTSsNXA/TRxFAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352DEC433C7;
	Sat, 27 Jan 2024 08:14:30 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch fixes for v6.8-rc2
Date: Sat, 27 Jan 2024 16:14:12 +0800
Message-Id: <20240127081412.810197-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.8-1

for you to fetch changes up to 48ef9e87b407f89f230f804815af7ac2031ec17a:

  LoongArch: KVM: Add returns to SIMD stubs (2024-01-26 16:22:07 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.8-rc2

Fix boot failure on machines with more than 8 nodes, and fix two build
errors about KVM.
----------------------------------------------------------------
Huacai Chen (2):
      LoongArch/smp: Call rcutree_report_cpu_starting() at tlb_init()
      LoongArch: KVM: Fix build due to API changes

Randy Dunlap (1):
      LoongArch: KVM: Add returns to SIMD stubs

 arch/loongarch/include/asm/kvm_vcpu.h |  4 ++--
 arch/loongarch/kernel/smp.c           |  1 -
 arch/loongarch/kvm/mmu.c              |  4 ++--
 arch/loongarch/mm/tlb.c               | 16 ++++++++++------
 4 files changed, 14 insertions(+), 11 deletions(-)

