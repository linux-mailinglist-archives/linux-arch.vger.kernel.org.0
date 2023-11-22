Return-Path: <linux-arch+bounces-380-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653857F49F8
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 16:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975F81C20BFA
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750864E1C9;
	Wed, 22 Nov 2023 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F644C3C5;
	Wed, 22 Nov 2023 15:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6B9C433C7;
	Wed, 22 Nov 2023 15:13:07 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch fixes for v6.7-rc3
Date: Wed, 22 Nov 2023 23:12:45 +0800
Message-Id: <20231122151245.1730120-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.7-1

for you to fetch changes up to c517fd2738f472eb0d1db60a70d91629349a9bf8:

  Docs/zh_CN/LoongArch: Update links in LoongArch introduction.rst (2023-11-21 15:03:26 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.7-rc3

Fix several build errors, a potential kernel panic, a cpu hotplug issue
and update links in documentations.
----------------------------------------------------------------
Bibo Mao (1):
      LoongArch: Implement constant timer shutdown interface

Huacai Chen (3):
      LoongArch: Add __percpu annotation for __percpu_read()/__percpu_write()
      LoongArch: Silence the boot warning about 'nokaslr'
      LoongArch: Mark {dmw,tlb}_virt_to_page() exports as non-GPL

Masahiro Yamada (1):
      LoongArch: Add dependency between vmlinuz.efi and vmlinux.efi

WANG Rui (2):
      LoongArch: Explicitly set -fdirect-access-external-data for vmlinux
      LoongArch: Record pc instead of offset in la_abs relocation

Yanteng Si (2):
      Docs/LoongArch: Update links in LoongArch introduction.rst
      Docs/zh_CN/LoongArch: Update links in LoongArch introduction.rst

 Documentation/arch/loongarch/introduction.rst      |  4 ++--
 .../zh_CN/arch/loongarch/introduction.rst          |  4 ++--
 arch/loongarch/Makefile                            |  3 +++
 arch/loongarch/include/asm/asmmacro.h              |  3 +--
 arch/loongarch/include/asm/percpu.h                | 11 +++++------
 arch/loongarch/include/asm/setup.h                 |  2 +-
 arch/loongarch/kernel/relocate.c                   | 10 +++++++++-
 arch/loongarch/kernel/time.c                       | 23 +++++++++-------------
 arch/loongarch/mm/pgtable.c                        |  4 ++--
 9 files changed, 34 insertions(+), 30 deletions(-)

