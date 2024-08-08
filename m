Return-Path: <linux-arch+bounces-6115-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D85694BC42
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 13:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4D91F2153D
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F189618C934;
	Thu,  8 Aug 2024 11:24:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF818C92E;
	Thu,  8 Aug 2024 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116294; cv=none; b=pHpYewg8BxN+gpcCOLELAb/u190DS9cGFrSs2W5bg59qbueu+fjZUDLqWTaHYsX1RqqbeZ/fR+hj4lzyJi2hIrEgrhVjIPa9VijUs6REQGdrAx8qkrenrwkV2u6TSSIev4xEISZTYJbMn2ou1X+3oDKUt4KGewmRea8nD47JvA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116294; c=relaxed/simple;
	bh=kWylaPC9muCUi953Oy76biClG+5GXj6epxJaGfOLYn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c7U1V0jXACoqKBu1R+EBINioMy8pGzY6F0bOHgiFuzu9ldtu0/0DMXudu0wEED80t/FFZmbMARPDEjt5YvSKBuseYPAuxuM+6iVTmtVe7hkQ/OTzdD1UUdFVBYjeZhytVw4AtYgHTGkNFhwsyC/8hKn+Eso5o04qG7GyTzT2yJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A3AC4AF0C;
	Thu,  8 Aug 2024 11:24:51 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch fixes for v6.11-rc3
Date: Thu,  8 Aug 2024 19:24:37 +0800
Message-ID: <20240808112437.1538513-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.11-1

for you to fetch changes up to 494b0792d962e8efac72b3a5b6d9bcd4e6fa8cf0:

  LoongArch: KVM: Remove undefined a6 argument comment for kvm_hypercall() (2024-08-07 17:37:14 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.11-rc3

Enable general EFI poweroff method to make poweroff usable on hardwares
which lack ACPI S5, use accessors to page table entries instead of direct
dereference to avoid potential problems, and two trivial kvm cleanups.
----------------------------------------------------------------
Dandan Zhang (1):
      LoongArch: KVM: Remove undefined a6 argument comment for kvm_hypercall()

Huacai Chen (1):
      LoongArch: Use accessors to page table entries instead of direct dereference

Miao Wang (1):
      LoongArch: Enable general EFI poweroff method

Yuli Wang (1):
      LoongArch: KVM: Remove unnecessary definition of KVM_PRIVATE_MEM_SLOTS

 arch/loongarch/include/asm/hugetlb.h  |  4 +--
 arch/loongarch/include/asm/kfence.h   |  6 ++---
 arch/loongarch/include/asm/kvm_host.h |  2 --
 arch/loongarch/include/asm/kvm_para.h |  4 +--
 arch/loongarch/include/asm/pgtable.h  | 48 +++++++++++++++++++++--------------
 arch/loongarch/kernel/efi.c           |  6 +++++
 arch/loongarch/kvm/mmu.c              |  8 +++---
 arch/loongarch/mm/hugetlbpage.c       |  6 ++---
 arch/loongarch/mm/init.c              | 10 ++++----
 arch/loongarch/mm/kasan_init.c        | 10 ++++----
 arch/loongarch/mm/pgtable.c           |  2 +-
 11 files changed, 60 insertions(+), 46 deletions(-)

