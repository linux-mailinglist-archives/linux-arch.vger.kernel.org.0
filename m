Return-Path: <linux-arch+bounces-9657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609A4A085D1
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 04:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853893A9B96
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 03:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F0A3BBF0;
	Fri, 10 Jan 2025 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UI2PWbpd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B218BEC;
	Fri, 10 Jan 2025 03:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479097; cv=none; b=EneuVV6Pd1pFA+uYo6ZjkqaWRQ0hhdKGPUw/Jjbxw+rtHUFAeAY//2K4GyOdmNdOEA5kf3duikyo0HM0Aj313yOLwIvqt3Ilp7C27VcQ3aDSUdiLGXlsBycxrOjvzjBXgqiNjC99H7Tb7as+9ew0Aa5S/XETZSwRAbfQHmx9dME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479097; c=relaxed/simple;
	bh=aIXN1fFDfC84V416aPhCKGkGdMkFr9cf9umweXfeUA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpyZFcwDh+Csjsc1M8UGNyPSONPvmIIVtETI1dWXcT24NTRgyUaQoFTcn10iYYPcMBE6rR9eRRQE/BjafqESQV08+biouFs+fKZjsNiu0jGrwe/PU8rP2B/9/QoMhYuDUP4M3hQyYAJenvKEKOrQ48siMmPC/DqQw187J2OcZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=UI2PWbpd; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8080:c1f1:e386:c572:17d3:6ddc] ([IPv6:2601:646:8080:c1f1:e386:c572:17d3:6ddc])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50A3FGON981507
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 9 Jan 2025 19:15:22 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50A3FGON981507
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1736478939;
	bh=2Gsk7+JP3PoZg8VhoEWFUmet8fDEOviqEDX2siCLmXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UI2PWbpd/173uf8ET7OhKCSxHMq3wIV9uPwlDabKLopTn4XQlVOW2UhdDhLNKQ2ou
	 8eY5IkJPjKd/ufxYXpC3T7ngILIHHww7s3f/TxHKadq33uowsRPtdqvlulWYDcl4s8
	 98gF9cD/iHRBhl+LkNR2Vz4dcuRwuyCMkzCPxTONo9GrePkGJYLa5vUD7mYV9L5Uos
	 ee2fTgpV4TmVkm3/EnjzCs2Wh3is/8drjYQa4kdxx6i4NZ58BWsIW3fEOCUEzu/US4
	 z0xQ+UHFUiZOJoDRJIqr/23SWWVPTNXl6Nb/6Jv9OAyLaNK9jKDb4DWbnzq60xty/Q
	 X0SCgYzOXKJQw==
Message-ID: <4536aca6-c430-4cf9-a98f-8282c7378955@zytor.com>
Date: Thu, 9 Jan 2025 19:15:09 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO API
To: "Dmitry V. Levin" <ldv@strace.io>, Oleg Nesterov <oleg@redhat.com>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>, Renzo Davoli <renzo@cs.unibo.it>,
        Davide Berardi <berardi.dav@gmail.com>, strace-devel@lists.strace.io,
        Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt
 <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.osdn.me>, Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250107230153.GA30560@strace.io>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20250107230153.GA30560@strace.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This would seem like a very good idea. However, it is perhaps important 
to realize that it doesn't fully eliminate the problems with 64-bit 
arguments on 32-bit ABIs being handled differently (never mind 
inconsistencies in system call ABIs etc.) There isn't all that much that 
can be done about that directly, though.

	-hpa


On 1/7/25 15:01, Dmitry V. Levin wrote:
> PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
> PTRACE_GET_SYSCALL_INFO by letting the ptracer modify details of
> system calls the tracee is blocked in.
> 
> This API allows ptracers to obtain and modify system call details
> in a straightforward and architecture-agnostic way.
> 
> Current implementation supports changing only those bits of system call
> information that are used by strace, namely, syscall number, syscall
> arguments, and syscall return value.
> 
> Support of changing additional details returned by PTRACE_GET_SYSCALL_INFO,
> such as instruction pointer and stack pointer, could be added later
> if needed, by re-using struct ptrace_syscall_info.reserved to specify
> the additional details that should be set.  Currently, the reserved
> field of struct ptrace_syscall_info must be initialized with zeroes;
> arch, instruction_pointer, and stack_pointer fields are ignored.
> 
> PTRACE_SET_SYSCALL_INFO currently supports only PTRACE_SYSCALL_INFO_ENTRY,
> PTRACE_SYSCALL_INFO_EXIT, and PTRACE_SYSCALL_INFO_SECCOMP operations.
> Other operations could be added later if needed.
> 
> Ideally, PTRACE_SET_SYSCALL_INFO should have been introduced along with
> PTRACE_GET_SYSCALL_INFO, but it didn't happen.  The last straw that
> convinced me to implement PTRACE_SET_SYSCALL_INFO was apparent failure
> to provide an API of changing the first system call argument on riscv
> architecture [1].
> 
> ptrace(2) man page:
> 
> long ptrace(enum __ptrace_request request, pid_t pid, void *addr, void *data);
> ...
> PTRACE_SET_SYSCALL_INFO
>         Modify information about the system call that caused the stop.
>         The "data" argument is a pointer to struct ptrace_syscall_info
>         that specifies the system call information to be set.
>         The "addr" argument should be set to sizeof(struct ptrace_syscall_info)).
> 
> [1] https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
> 
> Dmitry V. Levin (6):
>    Revert "arch: remove unused function syscall_set_arguments()"
>    syscall.h: add syscall_set_arguments() on remaining
>      HAVE_ARCH_TRACEHOOK arches
>    syscall.h: introduce syscall_set_nr()
>    ptrace_get_syscall_info: factor out ptrace_get_syscall_info_op
>    ptrace: introduce PTRACE_SET_SYSCALL_INFO request
>    selftests/ptrace: add a test case for PTRACE_SET_SYSCALL_INFO
> 
>   arch/arc/include/asm/syscall.h                |  20 +
>   arch/arm/include/asm/syscall.h                |  25 +
>   arch/arm64/include/asm/syscall.h              |  20 +
>   arch/csky/include/asm/syscall.h               |  13 +
>   arch/hexagon/include/asm/syscall.h            |  14 +
>   arch/loongarch/include/asm/syscall.h          |  15 +
>   arch/m68k/include/asm/syscall.h               |   7 +
>   arch/microblaze/include/asm/syscall.h         |   7 +
>   arch/mips/include/asm/syscall.h               |  53 +++
>   arch/nios2/include/asm/syscall.h              |  16 +
>   arch/openrisc/include/asm/syscall.h           |  13 +
>   arch/parisc/include/asm/syscall.h             |  19 +
>   arch/powerpc/include/asm/syscall.h            |  15 +
>   arch/riscv/include/asm/syscall.h              |  16 +
>   arch/s390/include/asm/syscall.h               |  19 +
>   arch/sh/include/asm/syscall_32.h              |  19 +
>   arch/sparc/include/asm/syscall.h              |  17 +
>   arch/um/include/asm/syscall-generic.h         |  19 +
>   arch/x86/include/asm/syscall.h                |  43 ++
>   arch/xtensa/include/asm/syscall.h             |  18 +
>   include/asm-generic/syscall.h                 |  30 ++
>   include/linux/ptrace.h                        |   3 +
>   include/uapi/linux/ptrace.h                   |   3 +-
>   kernel/ptrace.c                               | 154 ++++++-
>   tools/testing/selftests/ptrace/Makefile       |   2 +-
>   .../selftests/ptrace/set_syscall_info.c       | 436 ++++++++++++++++++
>   26 files changed, 994 insertions(+), 22 deletions(-)
>   create mode 100644 tools/testing/selftests/ptrace/set_syscall_info.c
> 


