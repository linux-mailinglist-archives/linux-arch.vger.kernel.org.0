Return-Path: <linux-arch+bounces-4012-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3ED8B3A71
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 16:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A0A1C230CD
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C231487DC;
	Fri, 26 Apr 2024 14:56:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028EC145343;
	Fri, 26 Apr 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143381; cv=none; b=D9GFvrv/0FZhP1ySoZxCQZAko5MKdltwEyga0CUQC6cFfu8i7wEHh8CVc9Im0teVdbtRbh8sVtvoaFu2BpVoksKGysnk3DZRwOu1FlXZrCc5WH8fDAehd7uFRfk83QByUnsxKbB4IDUXenHvzTDbPh3ADc9HC58f+KwJwAjjx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143381; c=relaxed/simple;
	bh=z1jflBr3VX1/PBMyVh0h/VQYEKgWjPIT/13RDoe3Gaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+ly3NrcuSFfgWxB3T/8fhpL/ZIEXxzWkCYPuKwiA4G9SGGVV9SvSTfUEUX1g/qnae5cYRdC1IpdxldXGgd6xfnV0mcW7a81EkpBHxVCL0TTvgsVhsDsmNGsKFKiXZo0ma0XulNx3vWWZsm64d1ebtPi2Los66pim20ohTTCNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D614C113CD;
	Fri, 26 Apr 2024 14:56:16 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch fixes for v6.9-rc6
Date: Fri, 26 Apr 2024 22:56:06 +0800
Message-ID: <20240426145606.981607-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.9-2

for you to fetch changes up to f3334ebb8a2a1841c2824594dd992e66de19deb2:

  LoongArch: Lately init pmu after smp is online (2024-04-25 22:17:52 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.9-rc6

Fix some build errors and some trivial runtime bugs.
----------------------------------------------------------------
Baoquan He (1):
      LoongArch: Fix Kconfig item and left code related to CRASH_CORE

Bibo Mao (1):
      LoongArch: Lately init pmu after smp is online

David Hildenbrand (1):
      LoongArch: Fix a build error due to __tlb_remove_tlb_entry()

Huacai Chen (1):
      LoongArch: Fix callchain parse error with kernel tracepoint events

Jiantao Shan (1):
      LoongArch: Fix access error when read fault on a write-only VMA

 arch/loongarch/Kconfig                                       | 2 +-
 arch/loongarch/include/asm/{crash_core.h => crash_reserve.h} | 4 ++--
 arch/loongarch/include/asm/perf_event.h                      | 8 ++++++++
 arch/loongarch/include/asm/tlb.h                             | 2 --
 arch/loongarch/kernel/perf_event.c                           | 2 +-
 arch/loongarch/mm/fault.c                                    | 4 ++--
 6 files changed, 14 insertions(+), 8 deletions(-)
 rename arch/loongarch/include/asm/{crash_core.h => crash_reserve.h} (75%)

