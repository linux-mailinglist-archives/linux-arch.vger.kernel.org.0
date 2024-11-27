Return-Path: <linux-arch+bounces-9174-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30699DA4AE
	for <lists+linux-arch@lfdr.de>; Wed, 27 Nov 2024 10:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C8F281F7D
	for <lists+linux-arch@lfdr.de>; Wed, 27 Nov 2024 09:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38154192D6A;
	Wed, 27 Nov 2024 09:18:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAEA193416;
	Wed, 27 Nov 2024 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699133; cv=none; b=QB8NAlmLw8fgqX/SZ2/LOZ1lqESWlmBTvZs2LBtpoQWlHZtNc78BvXDDRuKyt6N7PuqllOQQHgYfsuJz6PGAkCg14Eq893iV63g85fP1ym8Egz2lRlLePgVyPoQ+gpVlMmpTQOEO/zfEUxumVWqI8wBebL5RddMPy33xnP+Xqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699133; c=relaxed/simple;
	bh=BCJKwh0Dl8stVFIQL8XhbC444aHp6aT5OjILeQYVfac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XjtdKOIPddlexcbJ5JWGaQX4TU6BWe1acwW+J/o0ergBUgW4JVoKdd8xoD92bkVvaBhIcaEhkEEiIO0gjDlu96E3KSe7UKjax4pqZnjKWiUbTkRI8JY8BidcLoGKaFCXkELNgXlbfjKmLg8PLAkEkOL1sZxyVI9QMH23CLYrdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.38])
	by gateway (Coremail) with SMTP id _____8DxL63140ZnMrxJAA--.39382S3;
	Wed, 27 Nov 2024 17:18:45 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.38])
	by front1 (Coremail) with SMTP id qMiowMDxnODp40ZnJLBpAA--.12382S2;
	Wed, 27 Nov 2024 17:18:43 +0800 (CST)
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
Subject: [GIT PULL] LoongArch changes for v6.13
Date: Wed, 27 Nov 2024 17:18:25 +0800
Message-ID: <20241127091825.421126-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxnODp40ZnJLBpAA--.12382S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WryDJF13ur17Zr15KFy5KFX_yoW8Zw43pr
	W3uFnxJr4UGr43Xrnxt343Wrn8JF4xK347Xa1ayry8Cr1DZr1UXw18Grn3XFy7J393J340
	qryrG3WUKF18G3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

The following changes since commit adc218676eef25575469234709c2d87185ca223a:

  Linux 6.12 (2024-11-17 14:15:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.13

for you to fetch changes up to 3c272a7551af1c10f6dbba0e71add7dccc7733fa:

  LoongArch: Update Loongson-3 default config file (2024-11-26 18:06:54 +0800)

----------------------------------------------------------------
LoongArch changes for v6.13

1, Fix build failure with GCC 15 (-std=gnu23);
2, Add PREEMPT_RT/PREEMPT_LAZY support;
3, Add I2S in DTS for Loongson-2K1000/Loongson-2K2000;
4, Some bug fixes and other small changes.

----------------------------------------------------------------
Binbin Zhou (2):
      LoongArch: dts: Add I2S support to Loongson-2K1000
      LoongArch: dts: Add I2S support to Loongson-2K2000

Huacai Chen (8):
      Merge tag 'sched-core-2024-11-18' into loongarch-next
      LoongArch: Explicitly specify code model in Makefile
      LoongArch: Reduce min_delta for the arch clockevent device
      LoongArch: Fix sleeping in atomic context for PREEMPT_RT
      LoongArch: Select HAVE_POSIX_CPU_TIMERS_TASK_WORK
      LoongArch: Allow to enable PREEMPT_RT
      LoongArch: Allow to enable PREEMPT_LAZY
      LoongArch: Update Loongson-3 default config file

Tiezhu Yang (2):
      LoongArch: Fix build failure with GCC 15 (-std=gnu23)
      LoongArch: BPF: Sign-extend return values

 arch/loongarch/Kconfig                       |  3 +
 arch/loongarch/Makefile                      |  4 +-
 arch/loongarch/boot/dts/loongson-2k1000.dtsi | 17 +++++-
 arch/loongarch/boot/dts/loongson-2k2000.dtsi | 22 ++++++-
 arch/loongarch/configs/loongson3_defconfig   | 91 +++++++++++++++++++++++++---
 arch/loongarch/include/asm/thread_info.h     |  8 ++-
 arch/loongarch/kernel/time.c                 |  6 +-
 arch/loongarch/mm/tlb.c                      |  2 +-
 arch/loongarch/net/bpf_jit.c                 |  2 +-
 arch/loongarch/vdso/Makefile                 |  2 +-
 10 files changed, 134 insertions(+), 23 deletions(-)


