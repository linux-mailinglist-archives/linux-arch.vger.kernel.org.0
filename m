Return-Path: <linux-arch+bounces-10509-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A501A4BED6
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 12:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBD23A3C55
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9BE1F3B8B;
	Mon,  3 Mar 2025 11:28:32 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BACF1F153C;
	Mon,  3 Mar 2025 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001312; cv=none; b=GDP7hJAnVD5epXWiSIe9ldb/NWTnS0DOFBCw5EDy17idDJELRlz8KayfuDFgQKUy95VKOePI7cT14Dmi7rrKAklYN4KuC/VaXMGcp5tksAqh6LXP3ECGrK0saIV6brLP7HgBJhOI6Y+872Iwv9BObB7kCtUMxUCHzLoOfK+x4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001312; c=relaxed/simple;
	bh=/u+MDloBVzmoc27sdAOV659GJ4fLzQwI2/890oNEeHo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WK2778ipc99O3zxSJVeahQgwVkbs59DMunl+62MjJ7mT0+OYF40MvAldl9YJMk+GPxXhvuzD12W/xxdIY5CfRdkAcQ+Q+i83uNJ/41Y3F+HVYFc0WC8CrLbDcSu4jLIlcQYXEt0nu/vXgaaY8L8dc8R06yRuLKlVrkYJfnPKVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 32D5372C8F5;
	Mon,  3 Mar 2025 14:19:11 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 01EDE7CCB3B; Mon,  3 Mar 2025 13:19:10 +0200 (IST)
Date: Mon, 3 Mar 2025 13:19:10 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Helge Deller <deller@gmx.de>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, strace-devel@lists.strace.io,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH v7 0/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO API
Message-ID: <20250303111910.GA24170@strace.io>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
PTRACE_GET_SYSCALL_INFO by letting the ptracer modify details of
system calls the tracee is blocked in.

This API allows ptracers to obtain and modify system call details in a
straightforward and architecture-agnostic way, providing a consistent way
of manipulating the system call number and arguments across architectures.

As in case of PTRACE_GET_SYSCALL_INFO, PTRACE_SET_SYSCALL_INFO also
does not aim to address numerous architecture-specific system call ABI
peculiarities, like differences in the number of system call arguments
for such system calls as pread64 and preadv.

The current implementation supports changing only those bits of system call
information that are used by strace system call tampering, namely, syscall
number, syscall arguments, and syscall return value.

Support of changing additional details returned by PTRACE_GET_SYSCALL_INFO,
such as instruction pointer and stack pointer, could be added later if
needed, by using struct ptrace_syscall_info.flags to specify the additional
details that should be set.  Currently, "flags" and "reserved" fields of
struct ptrace_syscall_info must be initialized with zeroes; "arch",
"instruction_pointer", and "stack_pointer" fields are currently ignored.

PTRACE_SET_SYSCALL_INFO currently supports only PTRACE_SYSCALL_INFO_ENTRY,
PTRACE_SYSCALL_INFO_EXIT, and PTRACE_SYSCALL_INFO_SECCOMP operations.
Other operations could be added later if needed.

Ideally, PTRACE_SET_SYSCALL_INFO should have been introduced along with
PTRACE_GET_SYSCALL_INFO, but it didn't happen.  The last straw that
convinced me to implement PTRACE_SET_SYSCALL_INFO was apparent failure
to provide an API of changing the first system call argument on riscv
architecture [1].

ptrace(2) man page:

long ptrace(enum __ptrace_request request, pid_t pid, void *addr, void *data);
...
PTRACE_SET_SYSCALL_INFO
       Modify information about the system call that caused the stop.
       The "data" argument is a pointer to struct ptrace_syscall_info
       that specifies the system call information to be set.
       The "addr" argument should be set to sizeof(struct ptrace_syscall_info)).

[1] https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/

Notes:
    v7:
    * csky: Fix typo in comment
    * mips: syscall_set_arguments: Remove mips_syscall_is_indirect check
    * mips: syscall_set_nr: Reword comment
    * mips: Add Reviewed-by
    * v6: https://lore.kernel.org/all/20250217090834.GA18175@strace.io/

    v6:
    * mips: Submit mips_get_syscall_arg() o32 fix via mips tree
      to get it merged into v6.14-rc3
    * Rebase to v6.14-rc3
    * v5: https://lore.kernel.org/all/20250210113336.GA887@strace.io/

    v5:
    * ptrace: Extend the commit message to say that the new API does not aim
      to address numerous architecture-specific syscall ABI peculiarities
    * selftests: Add a workaround for s390 16-bit syscall numbers
    * parisc: Add Acked-by
    * v4: https://lore.kernel.org/all/20250203065849.GA14120@strace.io/

    v4:
    * Split out syscall_set_return_value() for hexagon into a separate patch
    * s390: Change the style of syscall_set_arguments() implementation as
      requested
    * ptrace: Add Reviewed-by
    * v3: https://lore.kernel.org/all/20250128091445.GA8257@strace.io/

    v3:
    * powerpc: Submit syscall_set_return_value() fix for "sc" case separately
    * mips: Do not introduce erroneous argument truncation on mips n32,
      add a detailed description to the commit message of the
      mips_get_syscall_arg() change
    * ptrace: Add explicit padding to the end of struct ptrace_syscall_info,
      simplify obtaining of user ptrace_syscall_info,
      do not introduce PTRACE_SYSCALL_INFO_SIZE_VER0
    * ptrace: Change the return type of ptrace_set_syscall_info_* functions
      from "unsigned long" to "int"
    * ptrace: Add -ERANGE check to ptrace_set_syscall_info_exit(),
      add comments to -ERANGE checks
    * ptrace: Update comments about supported syscall stops
    * selftests: Extend set_syscall_info test, fix for mips n32
    * riscv: Add Tested-by and Reviewed-by

    v2:
    * Add patch to fix syscall_set_return_value() on powerpc
    * Add patch to fix mips_get_syscall_arg() on mips
    * Add syscall_set_return_value() implementation on hexagon
    * Add syscall_set_return_value() invocation to syscall_set_nr()
      on arm and arm64.
    * Fix syscall_set_nr() and mips_set_syscall_arg() on mips
    * Add a comment to syscall_set_nr() on arc, powerpc, s390, sh,
      and sparc
    * Remove redundant ptrace_syscall_info.op assignments in
      ptrace_get_syscall_info_*
    * Minor style tweaks in ptrace_get_syscall_info_op()
    * Remove syscall_set_return_value() invocation from
      ptrace_set_syscall_info_entry()
    * Skip syscall_set_arguments() invocation in case of syscall number -1
      in ptrace_set_syscall_info_entry() 
    * Split ptrace_syscall_info.reserved into ptrace_syscall_info.reserved
      and ptrace_syscall_info.flags
    * Use __kernel_ulong_t instead of unsigned long in set_syscall_info test

Dmitry V. Levin (6):
  hexagon: add syscall_set_return_value()
  syscall.h: add syscall_set_arguments()
  syscall.h: introduce syscall_set_nr()
  ptrace_get_syscall_info: factor out ptrace_get_syscall_info_op
  ptrace: introduce PTRACE_SET_SYSCALL_INFO request
  selftests/ptrace: add a test case for PTRACE_SET_SYSCALL_INFO

 arch/arc/include/asm/syscall.h                |  25 +
 arch/arm/include/asm/syscall.h                |  37 ++
 arch/arm64/include/asm/syscall.h              |  29 +
 arch/csky/include/asm/syscall.h               |  13 +
 arch/hexagon/include/asm/syscall.h            |  21 +
 arch/loongarch/include/asm/syscall.h          |  15 +
 arch/m68k/include/asm/syscall.h               |   7 +
 arch/microblaze/include/asm/syscall.h         |   7 +
 arch/mips/include/asm/syscall.h               |  43 ++
 arch/nios2/include/asm/syscall.h              |  16 +
 arch/openrisc/include/asm/syscall.h           |  13 +
 arch/parisc/include/asm/syscall.h             |  19 +
 arch/powerpc/include/asm/syscall.h            |  20 +
 arch/riscv/include/asm/syscall.h              |  16 +
 arch/s390/include/asm/syscall.h               |  21 +
 arch/sh/include/asm/syscall_32.h              |  24 +
 arch/sparc/include/asm/syscall.h              |  22 +
 arch/um/include/asm/syscall-generic.h         |  19 +
 arch/x86/include/asm/syscall.h                |  43 ++
 arch/xtensa/include/asm/syscall.h             |  18 +
 include/asm-generic/syscall.h                 |  30 +
 include/uapi/linux/ptrace.h                   |   7 +-
 kernel/ptrace.c                               | 179 +++++-
 tools/testing/selftests/ptrace/Makefile       |   2 +-
 .../selftests/ptrace/set_syscall_info.c       | 519 ++++++++++++++++++
 25 files changed, 1138 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/ptrace/set_syscall_info.c


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6

-- 
ldv

