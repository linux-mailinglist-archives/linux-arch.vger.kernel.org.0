Return-Path: <linux-arch+bounces-9245-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71DD9E3C88
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2024 15:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD06128147F
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2024 14:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F31FA826;
	Wed,  4 Dec 2024 14:18:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879081F759E;
	Wed,  4 Dec 2024 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321925; cv=none; b=cKM4MnM+ZFOEWy/sGAJ9G9N4TYkduZMCtGobLF2bf5mEFzfHrHIvGRWwlKGWztwmSRDO8oB34d8nOWKltaMbr32wUQ+OUNFqiLtSDjUQW+etS1I9vTGPkxbWyMtQm5hqZnAxUvIx2M0qwtXkQBBDqFB36l21ZUpubibcDB7EOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321925; c=relaxed/simple;
	bh=GmZWMuugyo6caCqVaQEDgXKASXNxQvYls+9mTgX7TaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mtAfr8d4KOdDDi4kKmLeH55K+65mhPfm3B6dH8gIGKocpQgO8aBwwtrNLAvD4qdK4gQohxnO/DvR6McWBW7KjfkStdZQ6PIRl9/7sifqIkA3Njti0iaQLDvpbDJn5pcDCuuLDuBkrziuo9VPLz9fthEL/6EtzZ4OckVKJcwrUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.38])
	by gateway (Coremail) with SMTP id _____8Ax6+G5ZFBnxsNQAA--.25576S3;
	Wed, 04 Dec 2024 22:18:33 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.38])
	by front1 (Coremail) with SMTP id qMiowMCxecG2ZFBnUrd1AA--.10506S2;
	Wed, 04 Dec 2024 22:18:33 +0800 (CST)
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
Subject: [GIT PULL] LoongArch fixes for v6.13-rc2
Date: Wed,  4 Dec 2024 22:18:18 +0800
Message-ID: <20241204141818.2091423-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxecG2ZFBnUrd1AA--.10506S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFy8AF1xZr15WFWrAF4DKFX_yoW8Ar17pr
	43uFnxJr4rGrn3Jr13tw1DWrn8Jr1xGryaq3W3ArW8Ar4UZr1UXr1rWrykXFyUJ3yxJr1I
	qF1rJw15KF1UJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.13-1

for you to fetch changes up to 7f71507851fc7764b36a3221839607d3a45c2025:

  LoongArch: KVM: Protect kvm_io_bus_{read,write}() with SRCU (2024-12-03 19:49:28 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.13-rc2

Fix bugs about EFI screen info, hugetlb pte clear and Lockdep-RCU splat
in KVM, plus some trival cleanups.
----------------------------------------------------------------
Bibo Mao (1):
      LoongArch: Add architecture specific huge_pte_clear()

David Wang (1):
      LoongArch/irq: Use seq_put_decimal_ull_width() for decimal values

Huacai Chen (3):
      LoongArch: Fix reserving screen info memory for above-4G firmware
      LoongArch: KVM: Protect kvm_check_requests() with SRCU
      LoongArch: KVM: Protect kvm_io_bus_{read,write}() with SRCU

Tiezhu Yang (1):
      LoongArch: BPF: Adjust the parameter of emit_jirl()

 arch/loongarch/include/asm/hugetlb.h | 10 ++++++++++
 arch/loongarch/include/asm/inst.h    | 12 +++++++++++-
 arch/loongarch/kernel/efi.c          |  2 +-
 arch/loongarch/kernel/inst.c         |  2 +-
 arch/loongarch/kernel/smp.c          |  2 +-
 arch/loongarch/kvm/exit.c            | 31 +++++++++++++++++++++----------
 arch/loongarch/kvm/intc/ipi.c        |  6 +++++-
 arch/loongarch/kvm/vcpu.c            |  4 +++-
 arch/loongarch/net/bpf_jit.c         |  6 +++---
 9 files changed, 56 insertions(+), 19 deletions(-)


