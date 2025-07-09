Return-Path: <linux-arch+bounces-12595-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D90AFDF0D
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 07:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685B8563587
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 05:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3D8269CF0;
	Wed,  9 Jul 2025 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="P+9TWd4x"
X-Original-To: linux-arch@vger.kernel.org
Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F174C08;
	Wed,  9 Jul 2025 05:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038034; cv=none; b=cYNceocUiHN7nmUHZm3xfZqQ9l+jSV8and5OxWDnUgOUb7IHSi1Sdy0XkjEBHzy5Q2m6v0uBFRd+X613+2tB9LV5xSxdwRJeaC10G0vRoseQ1XO7X2sAbSGZQfCk7YiAErXR8tEZ751T+qeSanFDNxz4acBxGvJ7NxkVApq9lMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038034; c=relaxed/simple;
	bh=EN5ByLBGywGLTiCp1bK3fyTglM7Zbn5pwSVlzcDFN2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGaipwUU/aWjK1ythTQJVB8GAk8/oF60HBsfg6QT1XCQjprEGRFucFBWqmHYIaM3ejuBgZ/jCUyxmBwom6aUfqrJ0vh1E8NKq2nX79cFGQHyA9TWijFUzHMFWfgbCQzhY4jrJSPu8MAc6O0OLzDJm7f+MPTYH/P8/ezZAE14tFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=P+9TWd4x reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Received: from [157.82.206.39] ([157.82.206.39])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56955rZV065688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 9 Jul 2025 14:05:53 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=4clTUl4sMeFn+3+ZKeZuCK2i1/1ZYbUuPzsuXuco86k=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=Message-ID:Date:Subject:To:From;
        s=rs20250326; t=1752037554; v=1;
        b=P+9TWd4xgbOJt4IAGxHHsFZCUP5mU2LruCqB6XvGSTxPuNiG88lEdFqKSI5e8GV9
         IZQ027gIzqE6R884yIAbqFDeeb+QV4d98ETFvdXUnoX+FYopiMFnNscVsB2zI9Wa
         2l2RcZyKqEBQDUjGZTaMI0r6Rf5IedBu6hCBpXk/895FEVdR2zQg58ehwJmyxgfF
         XT9yXnMK/B98pfOeSBYxC5A9B18qaCU6AclyvtM00Ovo46CMOeuPcCCb07Ssut/I
         yGZrAOC9hnteaFT0HuEm66QoaIAFlJenYdCL8L9SlWdVr/Lxm01+5vFw0NVbVwNR
         jKgFire83dealgPIcgL8rg==
Message-ID: <36c0213c-6b14-4ad2-969e-3d8e356bb680@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 9 Jul 2025 14:05:53 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] binfmt_elf,arch/*: Use elf.h for coredump note
 names
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin"
 <hpa@zytor.com>,
        "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexandre Ghiti <alex@ghiti.fr>, Andreas Larsson <andreas@gaisler.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dinh Nguyen
 <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Jonas Bonn <jonas@southpole.se>, Kees Cook <kees@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Max Filippov
 <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley
 <paul.walmsley@sifive.com>,
        Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
References: <20250701135616.29630-1-Dave.Martin@arm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250701135616.29630-1-Dave.Martin@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/07/01 22:55, Dave Martin wrote:
> This series aims to clean up an aspect of coredump generation:
> 
> ELF coredumps contain a set of notes describing the state of machine
> registers and other information about the dumped process.
> 
> Notes are identified by a numeric identifier n_type and a "name"
> string, although this terminology is somewhat misleading.  Officially,
> the "name" of a note is really an "originator" or namespace identifier
> that indicates how to interpret n_type [1], although in practice it is
> often used more loosely.
> 
> Either way, each kind of note needs _both_ a specific "name" string and
> a specific n_type to identify it robustly.
> 
> To centralise this knowledge in one place and avoid the need for ad-hoc
> code to guess the correct name for a given note, commit 7da8e4ad4df0
> ("elf: Define note name macros") [2] added an explicit NN_<foo> #define
> in elf.h to give the name corresponding to each named note type
> NT_<foo>.
> 
> Now that the note name for each note is specified explicitly, the
> remaining guesswork for determining the note name for common and
> arch-specific regsets in ELF core dumps can be eliminated.
> 
> This series aims to do just that:
> 
>   * Patch 2 adds a user_regset field to specify the note name, and a
>     helper macro to populate it correctly alongside the note type.
> 
>   * Patch 3 ports away the ad-hoc note names in the common coredump
>     code.
> 
>   * Patches 4-22 make the arch-specific changes.  (This is pretty
>     mechanical for most arches.)
> 
>   * The final patch adds a WARN() when no note name is specified,
>     and simplifies the fallback guess.  This should only be applied
>     when all arches have ported across.
> 
> See the individual patches for details.
> 
> 
> Testing:
> 
>   * x86, arm64: Booted in a VM and triggered a core dump with no WARN(),
>     and verified that the dumped notes are the same.
> 
>   * arm: Build-tested only (for now).
> 
>   * Other arches: not tested yet
> 
> Any help with testing is appreciated.  If the following generates the
> same notes (as dumped by readelf -n core) and doesn't trigger a WARN,
> then we are probably good.
> 
> $ sleep 60 &
> $ kill -QUIT $!
> 
> (Register content might differ between runs, but it should be safe to
> ignore that -- this series only deals with the note names and types.)
> 
> Cheers
> ---Dave
> 
> 
> [1] System V Application Binary Interface, Edition 4.1,
> Section 5 (Program Loading and Dynamic Linking) -> "Note Section"
> 
> https://refspecs.linuxfoundation.org/elf/gabi41.pdf
> 
> [2] elf: Define note name macros
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/uapi/linux/elf.h?id=7da8e4ad4df0dd12f37357af62ce1b63e75ae2e6
> 
> 
> Dave Martin (23):
>    regset: Fix kerneldoc for struct regset_get() in user_regset
>    regset: Add explicit core note name in struct user_regset
>    binfmt_elf: Dump non-arch notes with strictly matching name and type
>    ARC: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
>    ARM: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
>    arm64: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
>      names
>    csky: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
>    hexagon: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
>      names
>    LoongArch: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
>      names
>    m68k: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
>    MIPS: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
>    nios2: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
>      names
>    openrisc: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
>      names
>    parisc: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
>      names
>    powerpc/ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
>      names
>    riscv: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
>      names
>    s390/ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
>    sh: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
>    sparc: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
>      names
>    x86/ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
>    um: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
>    xtensa: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note
>      names
>    binfmt_elf: Warn on missing or suspicious regset note names
> 
>   arch/arc/kernel/ptrace.c                 |  4 +-
>   arch/arm/kernel/ptrace.c                 |  6 +-
>   arch/arm64/kernel/ptrace.c               | 52 ++++++++---------
>   arch/csky/kernel/ptrace.c                |  4 +-
>   arch/hexagon/kernel/ptrace.c             |  2 +-
>   arch/loongarch/kernel/ptrace.c           | 16 ++---
>   arch/m68k/kernel/ptrace.c                |  4 +-
>   arch/mips/kernel/ptrace.c                | 20 +++----
>   arch/nios2/kernel/ptrace.c               |  2 +-
>   arch/openrisc/kernel/ptrace.c            |  4 +-
>   arch/parisc/kernel/ptrace.c              |  8 +--
>   arch/powerpc/kernel/ptrace/ptrace-view.c | 74 ++++++++++++------------
>   arch/riscv/kernel/ptrace.c               | 12 ++--
>   arch/s390/kernel/ptrace.c                | 42 +++++++-------
>   arch/sh/kernel/ptrace_32.c               |  4 +-
>   arch/sparc/kernel/ptrace_32.c            |  4 +-
>   arch/sparc/kernel/ptrace_64.c            |  8 +--
>   arch/x86/kernel/ptrace.c                 | 22 +++----
>   arch/x86/um/ptrace.c                     | 10 ++--
>   arch/xtensa/kernel/ptrace.c              |  4 +-
>   fs/binfmt_elf.c                          | 36 +++++++-----
>   fs/binfmt_elf_fdpic.c                    | 17 +++---
>   include/linux/regset.h                   | 12 +++-
>   23 files changed, 194 insertions(+), 173 deletions(-)
> 
> 
> base-commit: 86731a2a651e58953fc949573895f2fa6d456841

For the whole series:
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

