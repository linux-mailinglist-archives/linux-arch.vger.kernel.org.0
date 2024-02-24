Return-Path: <linux-arch+bounces-2713-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32773862387
	for <lists+linux-arch@lfdr.de>; Sat, 24 Feb 2024 09:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639381C217AB
	for <lists+linux-arch@lfdr.de>; Sat, 24 Feb 2024 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6217580;
	Sat, 24 Feb 2024 08:54:15 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F02563;
	Sat, 24 Feb 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708764855; cv=none; b=bVsgPCvs6QtaGramP7OKI4kcZEakgD3PGU9ElFP9JHYjoMATnVVzGQHYPbdlSL6CymPaNy9TShG/NU0M1qdfzmO7Gpq32UPZwkXCy3qn3fpNDqlMWZ7eHN3UpjK1iRUJ7yNiL361K1MDqJHYkIXE4tV48bFPEUZzberdHPSC5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708764855; c=relaxed/simple;
	bh=EGe9UYsEr/9yfU000DGqVOgAZaeuzfLn2Tyry0Qc094=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i09fGzKlN9DVzlIYC0dLowgNLdztROOD3lZ/Jr5VzrN6k/DIgic9ivF7cMNR95KqtSKgJ85Is9HBzKKro8ghDlTibbEJL1a5M/IjV79Eo+tAls70rGWodEiNd4KekjglaltUy1RLSbXKNmMNCuvwQYw7BTtgfIedsjdwiIDQTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACF4C433C7;
	Sat, 24 Feb 2024 08:54:12 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch fixes for v6.8-rc6
Date: Sat, 24 Feb 2024 16:53:53 +0800
Message-ID: <20240224085353.2066777-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.8-3

for you to fetch changes up to f0f5c4894f89bac9074b45bccc447c3659a0fa6f:

  LoongArch: KVM: Streamline kvm_check_cpucfg() and improve comments (2024-02-23 14:36:31 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.8-rc6

Fix two cpu-hotplug issues, fix the init sequence about FDT system, fix
the coding style of dts, and fix the wrong CPUCFG ID handling of KVM.
----------------------------------------------------------------
Huacai Chen (3):
      LoongArch: Disable IRQ before init_fn() for nonboot CPUs
      LoongArch: Update cpu_sibling_map when disabling nonboot CPUs
      LoongArch: Call early_init_fdt_scan_reserved_mem() earlier

Krzysztof Kozlowski (1):
      LoongArch: dts: Minor whitespace cleanup

WANG Xuerui (3):
      LoongArch: KVM: Fix input validation of _kvm_get_cpucfg() & kvm_check_cpucfg()
      LoongArch: KVM: Rename _kvm_get_cpucfg() to _kvm_get_cpucfg_mask()
      LoongArch: KVM: Streamline kvm_check_cpucfg() and improve comments

 arch/loongarch/boot/dts/loongson-2k0500-ref.dts |   2 +-
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts |   2 +-
 arch/loongarch/kernel/setup.c                   |   4 +-
 arch/loongarch/kernel/smp.c                     | 122 ++++++++++++++----------
 arch/loongarch/kvm/vcpu.c                       |  81 ++++++++--------
 5 files changed, 113 insertions(+), 98 deletions(-)

