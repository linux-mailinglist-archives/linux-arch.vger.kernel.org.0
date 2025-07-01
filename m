Return-Path: <linux-arch+bounces-12545-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4647AEFB4B
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 15:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD5327A630C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC2275B1E;
	Tue,  1 Jul 2025 13:56:36 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A017275B15;
	Tue,  1 Jul 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378196; cv=none; b=rbbe1W1yp4U1FG980YMDJI4llXN5Mfx+Ay7WfQVF7eK5vewN+oJ2hfidjF8FU0C+fDLHH4j3/ekssClsQzTpvxBWqybtTYdge259i7lfKgoUUWmExkP4L+Q4Pd6TSfb+goyDUgI2EbwgU9Kt3q7uOX8XOM+45BCSpk6b9T8Hvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378196; c=relaxed/simple;
	bh=OjzN30GIiPcplOAaeYUjDuVVavt00lwj5wf5fyxHSgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hCjUhNlpOp+5G4Rpsg+7XNo5V/3hT+jckl75ilm5IAE0bnRT5YWFbJ3aDM/DZbtgoz9PX6H7l9qLde/feC2Vn+Gs0eWh9yxVvbIhA8qj2e4sRPzMg3vqqxkJH7Zxucpd29VXOA3QRgZEkKtDG3QyhM/wwtudzCIfr7u80kcaHIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E7141713;
	Tue,  1 Jul 2025 06:56:18 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE12C3F58B;
	Tue,  1 Jul 2025 06:56:23 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andreas Larsson <andreas@gaisler.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chris Zankel <chris@zankel.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonas Bonn <jonas@southpole.se>,
	Kees Cook <kees@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rich Felker <dalias@libc.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 00/23] binfmt_elf,arch/*: Use elf.h for coredump note names
Date: Tue,  1 Jul 2025 14:55:53 +0100
Message-Id: <20250701135616.29630-1-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to clean up an aspect of coredump generation:

ELF coredumps contain a set of notes describing the state of machine
registers and other information about the dumped process.

Notes are identified by a numeric identifier n_type and a "name"
string, although this terminology is somewhat misleading.  Officially,
the "name" of a note is really an "originator" or namespace identifier
that indicates how to interpret n_type [1], although in practice it is
often used more loosely.

Either way, each kind of note needs _both_ a specific "name" string and
a specific n_type to identify it robustly.

To centralise this knowledge in one place and avoid the need for ad-hoc
code to guess the correct name for a given note, commit 7da8e4ad4df0
("elf: Define note name macros") [2] added an explicit NN_<foo> #define
in elf.h to give the name corresponding to each named note type
NT_<foo>.

Now that the note name for each note is specified explicitly, the
remaining guesswork for determining the note name for common and
arch-specific regsets in ELF core dumps can be eliminated.

This series aims to do just that:

 * Patch 2 adds a user_regset field to specify the note name, and a
   helper macro to populate it correctly alongside the note type.

 * Patch 3 ports away the ad-hoc note names in the common coredump
   code.

 * Patches 4-22 make the arch-specific changes.  (This is pretty
   mechanical for most arches.)

 * The final patch adds a WARN() when no note name is specified,
   and simplifies the fallback guess.  This should only be applied
   when all arches have ported across.

See the individual patches for details.


Testing:

 * x86, arm64: Booted in a VM and triggered a core dump with no WARN(),
   and verified that the dumped notes are the same.

 * arm: Build-tested only (for now).

 * Other arches: not tested yet

Any help with testing is appreciated.  If the following generates the
same notes (as dumped by readelf -n core) and doesn't trigger a WARN,
then we are probably good.

$ sleep 60 &
$ kill -QUIT $!

(Register content might differ between runs, but it should be safe to
ignore that -- this series only deals with the note names and types.)

Cheers
---Dave


[1] System V Application Binary Interface, Edition 4.1,
Section 5 (Program Loading and Dynamic Linking) -> "Note Section"

https://refspecs.linuxfoundation.org/elf/gabi41.pdf

[2] elf: Define note name macros

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/uapi/linux/elf.h?id=7da8e4ad4df0dd12f37357af62ce1b63e75ae2e6


Dave Martin (23):
  regset: Fix kerneldoc for struct regset_get() in user_regset
  regset: Add explicit core note name in struct user_regset
  binfmt_elf: Dump non-arch notes with strictly matching name and type
  ARC: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
  ARM: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
  arm64: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
    names
  csky: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
  hexagon: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
    names
  LoongArch: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
    names
  m68k: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
  MIPS: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
  nios2: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
    names
  openrisc: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
    names
  parisc: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
    names
  powerpc/ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
    names
  riscv: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
    names
  s390/ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
  sh: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
  sparc: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
    names
  x86/ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
  um: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
  xtensa: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
    names
  binfmt_elf: Warn on missing or suspicious regset note names

 arch/arc/kernel/ptrace.c                 |  4 +-
 arch/arm/kernel/ptrace.c                 |  6 +-
 arch/arm64/kernel/ptrace.c               | 52 ++++++++---------
 arch/csky/kernel/ptrace.c                |  4 +-
 arch/hexagon/kernel/ptrace.c             |  2 +-
 arch/loongarch/kernel/ptrace.c           | 16 ++---
 arch/m68k/kernel/ptrace.c                |  4 +-
 arch/mips/kernel/ptrace.c                | 20 +++----
 arch/nios2/kernel/ptrace.c               |  2 +-
 arch/openrisc/kernel/ptrace.c            |  4 +-
 arch/parisc/kernel/ptrace.c              |  8 +--
 arch/powerpc/kernel/ptrace/ptrace-view.c | 74 ++++++++++++------------
 arch/riscv/kernel/ptrace.c               | 12 ++--
 arch/s390/kernel/ptrace.c                | 42 +++++++-------
 arch/sh/kernel/ptrace_32.c               |  4 +-
 arch/sparc/kernel/ptrace_32.c            |  4 +-
 arch/sparc/kernel/ptrace_64.c            |  8 +--
 arch/x86/kernel/ptrace.c                 | 22 +++----
 arch/x86/um/ptrace.c                     | 10 ++--
 arch/xtensa/kernel/ptrace.c              |  4 +-
 fs/binfmt_elf.c                          | 36 +++++++-----
 fs/binfmt_elf_fdpic.c                    | 17 +++---
 include/linux/regset.h                   | 12 +++-
 23 files changed, 194 insertions(+), 173 deletions(-)


base-commit: 86731a2a651e58953fc949573895f2fa6d456841
-- 
2.34.1


