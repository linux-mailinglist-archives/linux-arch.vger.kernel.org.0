Return-Path: <linux-arch+bounces-9062-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8516B9C7033
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 14:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66BBB303A7
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A685B1DFE00;
	Wed, 13 Nov 2024 12:49:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173F7081B;
	Wed, 13 Nov 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502161; cv=none; b=r8U+z78MpZJz0yd5FFpJRgdrozrxlKNk/+1lD9+QdsVbwEL4xoknUnUyhl7okJIjbKprxnEtSN1xaBi5D988DGzTwBSuc/wMotlUuyei/WXGetsV7C8cl7WSPuyqdx1LL0cQlcsmpJM361HLlDMUDjcyXVSd8TMvvg4QE7kcNGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502161; c=relaxed/simple;
	bh=YK7IWFQuoMgmyDR0b+T/zMZlcvpxCh7TWTf5teM5VRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCdMFssF9hf1jWsVxXJyS0jrNnkzbDY/WJju4kRZavGyv8s+Iax4JURE6u99FUXqEND/5MCspM9jAew+o/8Axpyt6tniO3lNnQK6rFzXt56gsgUHGjUuKfBSy1e+1tbH7ji0rQqo7D417oUG2Opo0VARzOYf5i86ysifRm9f9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9931CC4CED9;
	Wed, 13 Nov 2024 12:49:17 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch fixes for v6.12-final
Date: Wed, 13 Nov 2024 20:48:57 +0800
Message-ID: <20241113124857.1959435-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:

  Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.12-2

for you to fetch changes up to 6ce031e5d6f475d476bab55ab7d8ea168fedc4c1:

  LoongArch: Fix AP booting issue in VM mode (2024-11-12 16:35:39 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.12-final

For all possible CPUs setup logical-physical CPU mapping, in order to
avoid CPU hotplug issue, fix some KASAN bugs, fix AP booting issue in
VM mode, and some trivial cleanups.
----------------------------------------------------------------
Bibo Mao (1):
      LoongArch: Fix AP booting issue in VM mode

Huacai Chen (4):
      LoongArch: For all possible CPUs setup logical-physical CPU mapping
      LoongArch: Fix early_numa_add_cpu() usage for FDT systems
      LoongArch: Make KASAN work with 5-level page-tables
      LoongArch: Disable KASAN if PGDIR_SIZE is too large for cpu_vabits

Kanglong Wang (1):
      LoongArch: Add WriteCombine shadow mapping in KASAN

Yuli Wang (1):
      LoongArch: Define a default value for VM_DATA_DEFAULT_FLAGS

 arch/loongarch/include/asm/kasan.h | 13 +++++-
 arch/loongarch/include/asm/page.h  |  5 +--
 arch/loongarch/kernel/acpi.c       | 81 +++++++++++++++++++++++++-------------
 arch/loongarch/kernel/paravirt.c   | 15 +++++++
 arch/loongarch/kernel/smp.c        |  5 ++-
 arch/loongarch/mm/kasan_init.c     | 46 +++++++++++++++++++---
 6 files changed, 124 insertions(+), 41 deletions(-)

