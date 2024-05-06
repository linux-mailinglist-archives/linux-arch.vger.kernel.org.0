Return-Path: <linux-arch+bounces-4218-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB578BCF3D
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 15:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0601C22922
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0915585931;
	Mon,  6 May 2024 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seSAopKE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31C7F492;
	Mon,  6 May 2024 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002585; cv=none; b=nZmIT9a97fTR4jwUBKpGeVGrJNAAyLlYiMkCopdL4OqJAQH7gjexLvDDRtBVCv8ZA+PpKKsyv8UkWTCPxpRg8xa92MtvfHxvVwx5TylIVTAdAYa6LaetEpiawGPg0QkatxDh7ZPrajtnsQExE/hTcp8TC19vCh8LZ88ku4Zk7B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002585; c=relaxed/simple;
	bh=e3iVBxf7ew9k9UDXLu373Pt8xf4Tqy85cxmJoR1r8ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mHLSw9FBVWDNplmmnb3GILOYXY3EFR3Wn5OwmedxPmTtcmbIEBNlxddsMWM6pEF3AN2B7L+HeAuB5aZRzs/WufG7rmsuWAHlbgLQJb+EOzD41eCQLyvzeWb/JKBurCnvcFy9XpcyCjkNRMpD7aiTfd2OZiybW39a0wbDGrok/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seSAopKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2896C3277B;
	Mon,  6 May 2024 13:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002585;
	bh=e3iVBxf7ew9k9UDXLu373Pt8xf4Tqy85cxmJoR1r8ig=;
	h=From:To:Cc:Subject:Date:From;
	b=seSAopKEibaYZCabMJg/0pxoDwn18EuNih4eTQhgHMvQFG0B/zvJAXlDjBj4t7qI1
	 jWfUx9bZ9tPLBOytvFz9kykXzjVdMzghyM3aQkcMQVwdtXa0vM2L7dMcr1VDZZtQ/X
	 B5lByOqHFWKV9nqcC7E8wCbpqcWip3qp8HT752tGvnPyr7FFxZjQZGisp/w0irgiJ4
	 DzcmwZhKF7BLXpxyHbOo7lN88B9VtH2b/40J3SMtIERZQy7cnq2Xqr3v1pM6pfyCvM
	 KAhoOHsu9OR4O0d6dvX0otKfU1KI760TBm2mJhdxxLLTjPbnBTLtJW5tAR1Ks85dUB
	 IgoBZ5zTx6UPA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/3] kbuild: remove many tool coverage variables
Date: Mon,  6 May 2024 22:35:41 +0900
Message-Id: <20240506133544.2861555-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This patch set removes many instances of the following variables:

  - OBJECT_FILES_NON_STANDARD
  - KASAN_SANITIZE
  - UBSAN_SANITIZE
  - KCSAN_SANITIZE
  - KMSAN_SANITIZE
  - GCOV_PROFILE
  - KCOV_INSTRUMENT

Such tools are intended only for kernel space objects, most of which
are listed in obj-y, lib-y, or obj-m.

The best guess is, objects in $(obj-y), $(lib-y), $(obj-m) can opt in
such tools. Otherwise, not.

This works in most places.



Masahiro Yamada (3):
  kbuild: provide reasonable defaults for tool coverage
  Makefile: remove redundant tool coverage variables
  kbuild: use GCOV_PROFILE and KCSAN_SANITIZE in
    scripts/Makefile.modfinal

 arch/arm/boot/bootp/Makefile           |  1 -
 arch/arm/boot/compressed/Makefile      |  7 -------
 arch/arm/vdso/Makefile                 |  9 ---------
 arch/arm64/kernel/pi/Makefile          |  6 ------
 arch/arm64/kernel/vdso/Makefile        |  8 --------
 arch/arm64/kvm/hyp/nvhe/Makefile       | 13 -------------
 arch/csky/kernel/vdso/Makefile         |  4 ----
 arch/loongarch/vdso/Makefile           |  7 -------
 arch/mips/boot/compressed/Makefile     |  6 ------
 arch/mips/vdso/Makefile                |  7 -------
 arch/parisc/boot/compressed/Makefile   |  4 ----
 arch/powerpc/kernel/vdso/Makefile      |  8 --------
 arch/powerpc/purgatory/Makefile        |  3 ---
 arch/riscv/boot/Makefile               |  2 --
 arch/riscv/kernel/compat_vdso/Makefile |  6 ------
 arch/riscv/kernel/pi/Makefile          |  6 ------
 arch/riscv/kernel/vdso/Makefile        |  6 ------
 arch/riscv/purgatory/Makefile          |  8 --------
 arch/s390/boot/Makefile                |  2 ++
 arch/s390/kernel/vdso32/Makefile       |  8 --------
 arch/s390/kernel/vdso64/Makefile       |  8 --------
 arch/s390/purgatory/Makefile           |  8 --------
 arch/sh/boot/compressed/Makefile       |  3 ---
 arch/sparc/vdso/Makefile               |  2 --
 arch/x86/boot/Makefile                 | 15 ---------------
 arch/x86/boot/compressed/Makefile      | 11 -----------
 arch/x86/entry/vdso/Makefile           | 26 --------------------------
 arch/x86/purgatory/Makefile            |  9 ---------
 arch/x86/realmode/rm/Makefile          | 11 -----------
 arch/x86/um/vdso/Makefile              |  7 -------
 arch/xtensa/boot/lib/Makefile          |  5 -----
 drivers/firmware/efi/libstub/Makefile  | 11 -----------
 drivers/misc/lkdtm/Makefile            |  4 ----
 init/Makefile                          |  3 ---
 scripts/Makefile.build                 |  2 +-
 scripts/Makefile.lib                   | 20 ++++++++++++--------
 scripts/Makefile.modfinal              |  4 +++-
 scripts/Makefile.vmlinux               |  3 ---
 scripts/mod/Makefile                   |  1 -
 39 files changed, 18 insertions(+), 256 deletions(-)

-- 
2.40.1


