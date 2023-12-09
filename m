Return-Path: <linux-arch+bounces-859-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E841180B3F1
	for <lists+linux-arch@lfdr.de>; Sat,  9 Dec 2023 12:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB091F210E6
	for <lists+linux-arch@lfdr.de>; Sat,  9 Dec 2023 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6FE13FE5;
	Sat,  9 Dec 2023 11:24:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B4134CE;
	Sat,  9 Dec 2023 11:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29652C433C7;
	Sat,  9 Dec 2023 11:24:24 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch fixes for v6.7-rc5
Date: Sat,  9 Dec 2023 19:23:17 +0800
Message-Id: <20231209112317.1542046-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.7-2

for you to fetch changes up to e2f7b3d8b4b300956a77fa1ab084c931ba1c7421:

  LoongArch: BPF: Fix unconditional bswap instructions (2023-12-09 15:49:16 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.7-rc5

Preserve syscall nr across execve(), slightly clean up drdtime(), fix
the Clang built zboot kernel, fix a stack unwinder bug and several bpf
jit bugs.
----------------------------------------------------------------
Hengqi Chen (3):
      LoongArch: Preserve syscall nr across execve()
      LoongArch: BPF: Don't sign extend memory load operand
      LoongArch: BPF: Don't sign extend function return value

Jinyang He (1):
      LoongArch: Set unwind stack type to unknown rather than set error flag

Tiezhu Yang (2):
      LoongArch: BPF: Fix sign-extension mov instructions
      LoongArch: BPF: Fix unconditional bswap instructions

WANG Rui (1):
      LoongArch: Apply dynamic relocations for LLD

Xi Ruoyao (1):
      LoongArch: Slightly clean up drdtime()

 arch/loongarch/Makefile                 |  2 +-
 arch/loongarch/include/asm/elf.h        |  2 +-
 arch/loongarch/include/asm/loongarch.h  |  5 ++---
 arch/loongarch/kernel/stacktrace.c      |  2 +-
 arch/loongarch/kernel/unwind.c          |  1 -
 arch/loongarch/kernel/unwind_prologue.c |  2 +-
 arch/loongarch/net/bpf_jit.c            | 18 ++++++------------
 7 files changed, 12 insertions(+), 20 deletions(-)

