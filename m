Return-Path: <linux-arch+bounces-7885-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F0B995B4F
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 01:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453342845DC
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 23:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806C0215023;
	Tue,  8 Oct 2024 23:06:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567A11D0F44;
	Tue,  8 Oct 2024 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428785; cv=none; b=quj/5wNYs++bK1FArF51Li3KKz0AJBAr9ZHunpsgYBXZhsDZX1YUzyQT+5clGx8YliHG4hvlxbWQIBHU7eiCh98+7Z1Z9RYFAT9z9EXw2KJqYD+/H99IXkEWhXUoslykti/H7tjUj7NcQDvmyO5NGXcLO811i9yeM/A4fNR+Sv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428785; c=relaxed/simple;
	bh=4MIypqsyOGWR9qQpPieVB7d802V9vDLkd4c0SEg2wW4=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Bx74zGjsZEww11aru1rAOPHLCUjuImHmebQTRq1ej6KN920bTiJCv6jNc++u+m2QXyRpw1H/bXNa/Op8y+6xmT7oCr+v/edSJz3d3i+BnpA9484CcK6wF46YSRpZ5Wulu/SkUFutQdCdN4OZD20XqHHv4Eg+52BR0gcC2LcQrco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8738C4CEC7;
	Tue,  8 Oct 2024 23:06:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1syJHg-00000001164-3tWc;
	Tue, 08 Oct 2024 19:06:28 -0400
Message-ID: <20241008230527.674939311@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 08 Oct 2024 19:05:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Paul  Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thomas  Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 Borislav  Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 0/2] ftrace: Make ftrace_regs abstract and consolidate code
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>


This is based on:

  https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/
     ftrace/for-next

ftrace_regs was created to hold registers that store information to save
function parameters, return value and stack. Since it is a subset of
pt_regs, it should only be used by its accessor functions. But because
pt_regs can easily be taken from ftrace_regs (on most archs), it is
tempting to use it directly. But when running on other architectures, it
may fail to build or worse, build but crash the kernel!

Instead, make struct ftrace_regs an empty structure and have the
architectures define __arch_ftrace_regs and all the accessor functions
will typecast to it to get to the actual fields. This will help avoid
usage of ftrace_regs directly.

I again compiled all the affected architectures (except for 32bit ppc).
I got s390 built when disabling bcachefs.

Changes since v1: https://lore.kernel.org/all/20241007204743.41314f1d@gandalf.local.home/

- Moved the non ftrace args code from asm-generic/ftrace.h to linux/ftrace.h
  those archs have their own asm/ftrace.h and are not using asm-generic.
  The default has to be in linux/ftrace.h

- simplified arch_ftrace_get_regs() and made it a static inline function

- Added a second patch that consolidates a lot of the duplicate code
  when an architecture has pt_regs embedded in the ftrace_regs.

Steven Rostedt (2):
      ftrace: Make ftrace_regs abstract from direct use
      ftrace: Consolidate ftrace_regs accessor functions for archs using pt_regs

----
 arch/arm64/include/asm/ftrace.h          | 21 +++++++++--------
 arch/arm64/kernel/asm-offsets.c          | 22 +++++++++---------
 arch/arm64/kernel/ftrace.c               | 10 ++++----
 arch/loongarch/include/asm/ftrace.h      | 29 ++++--------------------
 arch/loongarch/kernel/ftrace_dyn.c       |  2 +-
 arch/powerpc/include/asm/ftrace.h        | 27 +++-------------------
 arch/powerpc/kernel/trace/ftrace.c       |  4 ++--
 arch/powerpc/kernel/trace/ftrace_64_pg.c |  2 +-
 arch/riscv/include/asm/ftrace.h          | 22 ++++++++++--------
 arch/riscv/kernel/asm-offsets.c          | 28 +++++++++++------------
 arch/riscv/kernel/ftrace.c               |  2 +-
 arch/s390/include/asm/ftrace.h           | 29 ++++--------------------
 arch/s390/kernel/asm-offsets.c           |  4 ++--
 arch/s390/kernel/ftrace.c                |  2 +-
 arch/s390/lib/test_unwind.c              |  4 ++--
 arch/x86/include/asm/ftrace.h            | 30 ++++++------------------
 arch/x86/kernel/ftrace.c                 |  2 +-
 include/linux/ftrace.h                   | 39 +++++++++++++++-----------------
 include/linux/ftrace_regs.h              | 36 +++++++++++++++++++++++++++++
 kernel/trace/ftrace.c                    |  2 +-
 20 files changed, 139 insertions(+), 178 deletions(-)
 create mode 100644 include/linux/ftrace_regs.h

