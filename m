Return-Path: <linux-arch+bounces-2111-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7997F84CA8E
	for <lists+linux-arch@lfdr.de>; Wed,  7 Feb 2024 13:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EEE91C2206C
	for <lists+linux-arch@lfdr.de>; Wed,  7 Feb 2024 12:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA9359B66;
	Wed,  7 Feb 2024 12:15:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B51B7EE;
	Wed,  7 Feb 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308101; cv=none; b=A5I+BLu+Ts+sFN0b6OwTgc29x23VW8bBnJ94FHx14x+eYOS/LaQ1O46E5NFQ0RUN1E1VzKaO51itU5dQRdpCGDo3aAqp1fmqOu8DJv6RwmiZI54heYUfQMVwfhigxRNjbIlUBzu6bHgKVrSpXAkhIPLxPKv1LpItC0hbe80qjIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308101; c=relaxed/simple;
	bh=DEW2EIodjITPTCMqGcXHrl9weBl5q8z92NvoiY1Ixpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ht3bmFnUGcwTw5RARrMRya7xW/78FB/Ijd3eonHrITrGSBfFw4mdUQHwT0rqCkr3J/zCICq576XVaHgDE3Utgo5A737Gu2QhAB7oh+BG5zIUjO/1P/7nuBPEKxN38JLfcDpDRh1jw4ohFWKGUiQjI30OUJYhH6D8x7cIQdKyap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26A8C433C7;
	Wed,  7 Feb 2024 12:14:58 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch fixes for v6.8-rc4
Date: Wed,  7 Feb 2024 20:14:36 +0800
Message-ID: <20240207121436.3845425-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.8-2

for you to fetch changes up to cca5efe77a6a2d02b3da4960f799fa233e460ab1:

  LoongArch: vDSO: Disable UBSAN instrumentation (2024-02-06 12:32:05 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.8-rc4

Fix acpi_core_pic[] array overflow, fix earlycon parameter if KASAN
enabled, disable UBSAN instrumentation for vDSO build, and two Kconfig
cleanups.
----------------------------------------------------------------
Huacai Chen (2):
      LoongArch: Change acpi_core_pic[NR_CPUS] to acpi_core_pic[MAX_CORE_PIC]
      LoongArch: Fix earlycon parameter if KASAN enabled

Kees Cook (1):
      LoongArch: vDSO: Disable UBSAN instrumentation

Masahiro Yamada (2):
      LoongArch: Select ARCH_ENABLE_THP_MIGRATION instead of redefining it
      LoongArch: Select HAVE_ARCH_SECCOMP to use the common SECCOMP menu

 arch/loongarch/Kconfig            | 23 ++---------------------
 arch/loongarch/include/asm/acpi.h |  4 +++-
 arch/loongarch/kernel/acpi.c      |  4 +---
 arch/loongarch/mm/kasan_init.c    |  3 +++
 arch/loongarch/vdso/Makefile      |  1 +
 5 files changed, 10 insertions(+), 25 deletions(-)

