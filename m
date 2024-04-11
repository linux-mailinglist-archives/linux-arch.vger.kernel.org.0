Return-Path: <linux-arch+bounces-3559-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC518A1015
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 12:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4702887F1
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 10:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ED21474CE;
	Thu, 11 Apr 2024 10:30:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D596146D79;
	Thu, 11 Apr 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831429; cv=none; b=UhnFrrkIbquX4KmyWwgsdWxqQR4ccp51nWnGtyCsHoXwBRXAKewT0FiW53dwIO2mDFk1cl3fgvQcJd756/cWVvweXIFMALLjbsdxOyLad1tF/FHo2z3+L/ULeSELJ+azQQrueK2PW2ogw5rBqsPMw3SgQ9JuvW8Tq4mjyzlq5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831429; c=relaxed/simple;
	bh=wComOVfoaefWwC2Rt0UKt2s8/ND86+TBpIl7IK3UsSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MnDJVlghXABE9/vx5VirleCbo3GMNILMda0TZTQ4FG9+xknAb/Zr05AxsnCOhfP6+rsj9KZqiPKOxjL+I8l78X8tQvY/Slys4KU8H4CPAVkVZ98MuRJo1O0y0Pd1FfuVxxJlcRdxz31hObR7W5B3hBKMhOm8r2vwzaX0m7alQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00654C433F1;
	Thu, 11 Apr 2024 10:30:26 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch fixes for v6.9-rc4
Date: Thu, 11 Apr 2024 18:30:00 +0800
Message-ID: <20240411103000.2655846-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.9-1

for you to fetch changes up to a07c772fa658645887119184de48b255bf19a46e:

  LoongArch: Include linux/sizes.h in addrspace.h to prevent build errors (2024-04-10 21:08:51 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.9-rc4

Make {virt, phys, page, pfn} translation work with KFENCE for LoongArch
(otherwise NVMe and virtio-blk cannot work with KFENCE enabled), update
dts files for Loongson-2K series to make devices work correctly, and fix
a build error.
----------------------------------------------------------------
Huacai Chen (7):
      mm: Move lowmem_page_address() a little later
      LoongArch: Make {virt, phys, page, pfn} translation work with KFENCE
      LoongArch: Make virt_addr_valid()/__virt_addr_valid() work with KFENCE
      LoongArch: Update dts for Loongson-2K1000 to support ISA/LPC
      LoongArch: Update dts for Loongson-2K2000 to support ISA/LPC
      LoongArch: Update dts for Loongson-2K2000 to support PCI-MSI
      LoongArch: Update dts for Loongson-2K2000 to support GMAC/GNET

Randy Dunlap (1):
      LoongArch: Include linux/sizes.h in addrspace.h to prevent build errors

 arch/loongarch/boot/dts/loongson-2k1000.dtsi    |  7 ++++++
 arch/loongarch/boot/dts/loongson-2k2000-ref.dts | 33 +++++++++++++++++++++++++
 arch/loongarch/boot/dts/loongson-2k2000.dtsi    | 24 +++++++++++++++---
 arch/loongarch/include/asm/addrspace.h          |  1 +
 arch/loongarch/include/asm/io.h                 | 20 +++++++++++----
 arch/loongarch/include/asm/kfence.h             |  9 +++++++
 arch/loongarch/include/asm/page.h               | 26 ++++++++++++++++++-
 arch/loongarch/mm/mmap.c                        |  4 +++
 arch/loongarch/mm/pgtable.c                     |  4 +--
 include/linux/mm.h                              | 10 ++++----
 10 files changed, 121 insertions(+), 17 deletions(-)

