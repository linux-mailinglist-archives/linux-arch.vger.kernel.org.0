Return-Path: <linux-arch+bounces-12264-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C42AD0DE2
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 16:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A9F172096
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 14:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F351A4F3C;
	Sat,  7 Jun 2025 14:16:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3DCA5A;
	Sat,  7 Jun 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749305808; cv=none; b=bsgsOtseXT8YUDZ+WbcWmevGK/s3SL469C/IvtVAIdfCKkkBiyyf8UHlzGeeSMDQA/ypsiLNHuaN4eBdhv8i03c96QdFgdRu/J6aHwicXZtgPcKCi7vKYwsVNPrHK/B/+kkGyLT951mmhc4EMv2TzdS7d/6/YpHj22uJiBcKApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749305808; c=relaxed/simple;
	bh=BRmj87RP767+F/IPH8y7XcECquUBMp7SSKsaQmg/+Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RSiFz8Onzs3w8WnompEDzNgKsHk0FwmLhVBSXXqs9PKjJMvRDb4kzK6/ppdRke0mkecw5wUvax22uA+o+KPVuykPYyxRIIFIZHdwZxq2G2NXopur7oduxIHXIZKiQEaNJFyVwcU/0BBkXrNl/X4stXq4GTWaUHtmp1CNu+yqMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxC3LISURoXnIPAQ--.40961S3;
	Sat, 07 Jun 2025 22:16:40 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxDce+SURoShMPAQ--.4187S2;
	Sat, 07 Jun 2025 22:16:37 +0800 (CST)
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
Subject: [GIT PULL] LoongArch changes for v6.16
Date: Sat,  7 Jun 2025 22:16:18 +0800
Message-ID: <20250607141619.3616592-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxDce+SURoShMPAQ--.4187S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF4kuF4kZrW7uF1fXFWxXwc_yoWrXrWkpF
	ZxurnrGF48Grn3Arnxt34Uur1DJr4xGry2qa1ak348Ar13Zw1UZr18XF95XFyUJ3yrJry0
	qr1rGw1aqF4UJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2l1vDUUUU

The following changes since commit 0ff41df1cb268fc69e703a08a57ee14ae967d0ca:

  Linux 6.15 (2025-05-25 16:09:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.16

for you to fetch changes up to f78fb2576f22b0ba5297412a9aa7691920666c41:

  platform/loongarch: laptop: Unregister generic_sub_drivers on exit (2025-06-07 11:37:15 +0800)

----------------------------------------------------------------
LoongArch changes for v6.16

1, Adjust the 'make install' operation;
2, Support SCHED_MC (Multi-core scheduler);
3, Enable ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS;
4, Enable HAVE_ARCH_STACKLEAK;
5, Increase max supported CPUs up to 2048;
6, Introduce the numa_memblks conversion;
7, Add PWM controller nodes in dts;
8, Some bug fixes and other small changes.

----------------------------------------------------------------
Binbin Zhou (3):
      LoongArch: dts: Add PWM support to Loongson-2K0500
      LoongArch: dts: Add PWM support to Loongson-2K1000
      LoongArch: dts: Add PWM support to Loongson-2K2000

Huacai Chen (5):
      Merge commit 'core-entry-2025-05-25' into loongarch-next
      LoongArch: Increase max supported CPUs up to 2048
      LoongArch: Introduce the numa_memblks conversion
      LoongArch: Avoid using $r0/$r1 as "mask" for csrxchg
      LoongArch: Preserve firmware configuration when desired

Thomas Weißschuh (1):
      LoongArch: vDSO: Correctly use asm parameters in syscall wrappers

Tianyang Zhang (2):
      LoongArch: Add SCHED_MC (Multi-core scheduler) support
      LoongArch: Fix panic caused by NULL-PMD in huge_pte_offset()

Yao Zi (3):
      platform/loongarch: laptop: Get brightness setting from EC on probe
      platform/loongarch: laptop: Add backlight power control support
      platform/loongarch: laptop: Unregister generic_sub_drivers on exit

Youling Tang (4):
      LoongArch: Add a default install.sh
      LoongArch: Using generic scripts/install.sh in `make install`
      LoongArch: Add some annotations in archhelp
      LoongArch: Enable HAVE_ARCH_STACKLEAK

Yuli Wang (1):
      LoongArch: Enable ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS

 .../core/mseal_sys_mappings/arch-support.txt       |   2 +-
 Documentation/userspace-api/mseal.rst              |   2 +-
 arch/loongarch/Kconfig                             |  18 ++-
 arch/loongarch/Makefile                            |  11 +-
 arch/loongarch/boot/dts/loongson-2k0500.dtsi       | 160 +++++++++++++++++++++
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts    |  24 ++++
 arch/loongarch/boot/dts/loongson-2k1000.dtsi       |  42 +++++-
 arch/loongarch/boot/dts/loongson-2k2000.dtsi       |  60 ++++++++
 arch/loongarch/boot/install.sh                     |  56 ++++++++
 arch/loongarch/include/asm/acpi.h                  |   2 +-
 arch/loongarch/include/asm/entry-common.h          |   8 +-
 arch/loongarch/include/asm/irqflags.h              |  16 ++-
 arch/loongarch/include/asm/loongarch.h             |   4 +-
 arch/loongarch/include/asm/numa.h                  |  14 --
 arch/loongarch/include/asm/smp.h                   |   1 +
 arch/loongarch/include/asm/sparsemem.h             |   5 -
 arch/loongarch/include/asm/stackframe.h            |   6 +
 arch/loongarch/include/asm/stacktrace.h            |   5 +
 arch/loongarch/include/asm/topology.h              |  15 +-
 arch/loongarch/include/asm/vdso/getrandom.h        |   2 +-
 arch/loongarch/include/asm/vdso/gettimeofday.h     |   6 +-
 arch/loongarch/kernel/acpi.c                       |  52 ++++---
 arch/loongarch/kernel/entry.S                      |   3 +
 arch/loongarch/kernel/numa.c                       | 108 ++------------
 arch/loongarch/kernel/smp.c                        |  38 +++++
 arch/loongarch/kernel/vdso.c                       |   4 +-
 arch/loongarch/mm/hugetlbpage.c                    |   3 +-
 arch/loongarch/mm/init.c                           |   8 --
 arch/loongarch/pci/acpi.c                          |  14 +-
 drivers/firmware/efi/libstub/Makefile              |   2 +-
 drivers/platform/loongarch/loongson-laptop.c       |  87 +++++------
 mm/Kconfig                                         |   1 +
 32 files changed, 561 insertions(+), 218 deletions(-)
 create mode 100755 arch/loongarch/boot/install.sh


