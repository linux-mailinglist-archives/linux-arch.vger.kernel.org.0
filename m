Return-Path: <linux-arch+bounces-15011-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C0C7A987
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F086934F8A0
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797412E284B;
	Fri, 21 Nov 2025 15:38:33 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647072D97BB;
	Fri, 21 Nov 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763739513; cv=none; b=ufzR9LQ2GKeozXwEm8JKrzg0SJs8SryiFXj6OGZoFuowMXFx4MP1y101+oyEEZUqxHT++TDmGQFoO4ri4xbq5tGmiqDTkMTIa7BZXmNtW8PcPB21isZwqotjtkOYRvyg30r5jViUgUsJQsL+20Be+7XJjgwB8YlDgJODNUSy6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763739513; c=relaxed/simple;
	bh=ryCRWvv7XdBibWvL4fadsc3qqHedhZ8wvCfbdFXGCIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DOMtnJGcSLkYKQUWIHW0/wHYKKcG+WwceAAZum+0gF1/0bSjIY/VMNlC9wZqpPpMj/zvUIn3NqfwF/apfIn63zmBIJoXsm4EAv7qnvpFiyJiZVQQzhMWWEHZV+2KOhcf+/HbCO1EoaN5bUtKiMVPmRPRQyIYFefFIklEBoNRZak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.219])
	by gateway (Coremail) with SMTP id _____8Dx_79shyBpxp4mAA--.17636S3;
	Fri, 21 Nov 2025 23:38:20 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.219])
	by front1 (Coremail) with SMTP id qMiowJAxleRhhyBpzEA7AQ--.6972S2;
	Fri, 21 Nov 2025 23:38:17 +0800 (CST)
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
Subject: [GIT PULL] LoongArch fixes for v6.18-rc7
Date: Fri, 21 Nov 2025 23:37:42 +0800
Message-ID: <20251121153747.3337264-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxleRhhyBpzEA7AQ--.6972S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFy7CFy7tF45JFWUZryruFX_yoW8Aryfpr
	y3urnxGF4rGr1fXwnxt3yUur15Jr1xG342qa13Gry8AFy5Zr1UJr18XryxXFyUJ3yfJryI
	qF1rJw15KF1UJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

The following changes since commit 6a23ae0a96a600d1d12557add110e0bb6e32730c:

  Linux 6.18-rc6 (2025-11-16 14:25:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.18-2

for you to fetch changes up to 677e6123e3d24adaa252697dc89740f2ac07664e:

  LoongArch: BPF: Disable trampoline for kernel module function trace (2025-11-20 14:42:05 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.18-rc7

Use UAPI types in ptrace UAPI header to fix nolibc ptrace; fix some bugs
about CPU name display, NUMA node parsing, kexec/kdump, PCI init and BPF
trampoline.
----------------------------------------------------------------
Bibo Mao (1):
      LoongArch: Fix NUMA node parsing with numa_memblks

Huacai Chen (3):
      LoongArch: Consolidate CPU names in /proc/cpuinfo
      LoongArch: Mask all interrupts during kexec/kdump
      LoongArch: Don't panic if no valid cache info for PCI

Thomas Weißschuh (1):
      LoongArch: Use UAPI types in ptrace UAPI header

Vincent Li (1):
      LoongArch: BPF: Disable trampoline for kernel module function trace

 arch/loongarch/include/asm/cpu.h         | 21 +++++++++++
 arch/loongarch/include/uapi/asm/ptrace.h | 40 ++++++++++-----------
 arch/loongarch/kernel/cpu-probe.c        | 34 ++++++------------
 arch/loongarch/kernel/machine_kexec.c    |  2 ++
 arch/loongarch/kernel/numa.c             | 60 ++++++++++----------------------
 arch/loongarch/kernel/proc.c             |  2 ++
 arch/loongarch/net/bpf_jit.c             |  3 ++
 arch/loongarch/pci/pci.c                 |  8 ++---
 8 files changed, 79 insertions(+), 91 deletions(-)


