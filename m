Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A3545F505
	for <lists+linux-arch@lfdr.de>; Fri, 26 Nov 2021 20:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhKZTLv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Nov 2021 14:11:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60006 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhKZTJu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Nov 2021 14:09:50 -0500
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 14:09:49 EST
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F841B826A6;
        Fri, 26 Nov 2021 18:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97BAC9305D;
        Fri, 26 Nov 2021 18:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637953130;
        bh=iOM0FavmD6rOqR5B09CIYYTiOXh3dkD3aSGCBxSsL8s=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=keeGV5ynrcKa8CoEZaIshFsGnykooxIDL/N/el02gkNc7GETUb1/TFUiByk4st9ok
         TxxMc3gEiEL/SNc+SbhscXpd02ceVmIvnDeK6X3vwsric3ZCpi7zJvEZEcFd6Yjhfa
         5CwebnODdl4ls4vdCxCtq5mgy5+BSW+c2POOuq1bOJrk0Y7tqj9FZt8QcPXSAr1C+h
         MnApSXQ1EFbCBwXI3GNAbXRDNqjuU8xthI4ruYte13M6Xh7/8N9Noj1nRyICsD/EgF
         dZJLGxnyB+XleJyDoCB7aRgKy2Iz2iEMmeJYwwtzPJojOL75CxlUD55amIkeKNbIvK
         3Tvb6TJNavp8w==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 68ED427C005A;
        Fri, 26 Nov 2021 13:58:48 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Fri, 26 Nov 2021 13:58:48 -0500
X-ME-Sender: <xms:Zy6hYTGrzcSsDL_aznpRvrVaF6dsn2lAOduHDSFHiYd7K7ArJoy67g>
    <xme:Zy6hYQUGgirVSMus2chshaJlhZYbAo3n9DWcuOeuaXI49QsSll_PXHFhquJfBMqtY
    0pzA8JO-4p1jSY7CQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrhedvgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:Zy6hYVJmwcS1Cz1BDGzHuDJ2iyRBBQhy2f-O29cOa8xMYfnP8yNQPg>
    <xmx:Zy6hYRGpwTxvChH1-TkGv0wTjCgHpLJ0m0bNzSEv2T0czq43_a7q6Q>
    <xmx:Zy6hYZUGSrKIqbZ9fSWlLEJa11Jzocr38B6RCaXawVnawoGBJDrCwg>
    <xmx:aC6hYRQwRwlFRx5dOyjlOoG43DP5kTR5F3SUo_th-Mh9EXLhVX02cBiQBm8>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8D63A21E006E; Fri, 26 Nov 2021 13:58:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <4728eeae-8f1b-4541-b05a-4a0f35a459f7@www.fastmail.com>
In-Reply-To: <87h7bzjaer.fsf@oldenburg.str.redhat.com>
References: <87h7bzjaer.fsf@oldenburg.str.redhat.com>
Date:   Fri, 26 Nov 2021 10:58:26 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Florian Weimer" <fweimer@redhat.com>, linux-arch@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, kernel-hardening@lists.openwall.com
Cc:     linux-mm@kvack.org, "the arch/x86 maintainers" <x86@kernel.org>,
        musl@lists.openwall.com,
        "Dave Hansen via Libc-alpha" <libc-alpha@sourceware.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH] x86: Implement arch_prctl(ARCH_VSYSCALL_LOCKOUT) to disable
 vsyscall
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Fri, Nov 26, 2021, at 5:47 AM, Florian Weimer wrote:
> Distributions struggle with changing the default for vsyscall
> emulation because it is a clear break of userspace ABI, something
> that should not happen.
>
> The legacy vsyscall interface is supposed to be used by libcs only,
> not by applications.  This commit adds a new arch_prctl request,
> ARCH_VSYSCALL_LOCKOUT.  Newer libcs can adopt this request to signal
> to the kernel that the process does not need vsyscall emulation.
> The kernel can then disable it for the remaining lifetime of the
> process.  Legacy libcs do not perform this call, so vsyscall remains
> enabled for them.  This approach should achieves backwards
> compatibility (perfect compatibility if the assumption that only libcs
> use vsyscall is accurate), and it provides full hardening for new
> binaries.

Why is a lockout needed instead of just a toggle?  By the time an attack=
er can issue prctls, an emulated vsyscall seems like a pretty minor expl=
oit technique.  And programs that load legacy modules or instrument othe=
r programs might need to re-enable them.

Also, the interaction with emulate mode is somewhat complex. For now, le=
t=E2=80=99s support this in xonly mode only. A complete implementation w=
ill require nontrivial mm work.  I had that implemented pre-KPTI, but KP=
TI made it more complicated.

Finally, /proc/self/maps should be wired up via the gate_area code.

>
> The chosen value of ARCH_VSYSCALL_LOCKOUT should avoid conflicts
> with outher x86-64 arch_prctl requests.
>
> Future arch_prctls requests commonly used at process startup can imply
> vsyscall lockout, so that a separate system call for the lockout is
> not needed.
>
> Signed-off-by: Florian Weimer <fweimer@redhat.com>
>
> ---
>  arch/x86/entry/vsyscall/vsyscall_64.c          |   6 +
>  arch/x86/include/asm/mmu.h                     |   6 +
>  arch/x86/include/uapi/asm/prctl.h              |   2 +
>  arch/x86/kernel/process_64.c                   |   5 +
>  tools/arch/x86/include/uapi/asm/prctl.h        |   2 +
>  tools/testing/selftests/x86/Makefile           |  13 +-
>  tools/testing/selftests/x86/vsyscall_lockout.c | 431 ++++++++++++++++=
+++++++++
>  7 files changed, 462 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c=20
> b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 0b6b277ee050..ac176481cbdf 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -174,6 +174,12 @@ bool emulate_vsyscall(unsigned long error_code,
>=20
>  	tsk =3D current;
>=20
> +	if (tsk->mm->context.vsyscall_lockout) {
> +		warn_bad_vsyscall(KERN_WARNING, regs,
> +				  "vsyscall after lockout (exploit attempt?)");
> +		goto sigsegv;
> +	}
> +
>  	/*
>  	 * Check for access_ok violations and find the syscall nr.
>  	 *
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index 5d7494631ea9..59ddac5ad2e7 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -41,6 +41,12 @@ typedef struct {
>  #ifdef CONFIG_X86_64
>  	unsigned short flags;
>  #endif
> +#ifdef CONFIG_X86_VSYSCALL_EMULATION
> +	/*
> +	 * Set to true by arch_prctl(ARCH_VSYSCALL_LOCKOUT).
> +	 */
> +	bool vsyscall_lockout;
> +#endif
>=20
>  	struct mutex lock;
>  	void __user *vdso;			/* vdso base address */
> diff --git a/arch/x86/include/uapi/asm/prctl.h=20
> b/arch/x86/include/uapi/asm/prctl.h
> index 754a07856817..6f2b17ec4798 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -18,4 +18,6 @@
>  #define ARCH_MAP_VDSO_32	0x2002
>  #define ARCH_MAP_VDSO_64	0x2003
>=20
> +#define ARCH_VSYSCALL_LOCKOUT	0x5001
> +
>  #endif /* _ASM_X86_PRCTL_H */
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64=
.c
> index 3402edec236c..eaabd365aa63 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -816,6 +816,11 @@ long do_arch_prctl_64(struct task_struct *task,=20
> int option, unsigned long arg2)
>  		ret =3D put_user(base, (unsigned long __user *)arg2);
>  		break;
>  	}
> +	case ARCH_VSYSCALL_LOCKOUT:
> +#ifdef CONFIG_X86_VSYSCALL_EMULATION
> +		current->mm->context.vsyscall_lockout =3D true;
> +#endif
> +		break;
>=20
>  #ifdef CONFIG_CHECKPOINT_RESTORE
>  # ifdef CONFIG_X86_X32_ABI
> diff --git a/tools/arch/x86/include/uapi/asm/prctl.h=20
> b/tools/arch/x86/include/uapi/asm/prctl.h
> index 754a07856817..6f2b17ec4798 100644
> --- a/tools/arch/x86/include/uapi/asm/prctl.h
> +++ b/tools/arch/x86/include/uapi/asm/prctl.h
> @@ -18,4 +18,6 @@
>  #define ARCH_MAP_VDSO_32	0x2002
>  #define ARCH_MAP_VDSO_64	0x2003
>=20
> +#define ARCH_VSYSCALL_LOCKOUT	0x5001
> +
>  #endif /* _ASM_X86_PRCTL_H */
> diff --git a/tools/testing/selftests/x86/Makefile=20
> b/tools/testing/selftests/x86/Makefile
> index 8a1f62ab3c8e..2269429b77e0 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY :=3D entry_from_vm86=20
> test_syscall_vdso unwind_vdso \
>  			test_FCMOV test_FCOMI test_FISTTP \
>  			vdso_restorer
>  TARGETS_C_64BIT_ONLY :=3D fsgsbase sysret_rip syscall_numbering \
> -			corrupt_xstate_header amx
> +			corrupt_xstate_header amx vsyscall_lockout
>  # Some selftests require 32bit support enabled also on 64bit systems
>  TARGETS_C_32BIT_NEEDED :=3D ldt_gdt ptrace_syscall
>=20
> @@ -72,10 +72,12 @@ all_64: $(BINARIES_64)
>  EXTRA_CLEAN :=3D $(BINARIES_32) $(BINARIES_64)
>=20
>  $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
> -	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
> +	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ \
> +		$(or $(LIBS), -lrt -ldl -lm)
>=20
>  $(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h
> -	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
> +	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ \
> +		$(or $(LIBS), -lrt -ldl -lm)
>=20
>  # x86_64 users should be encouraged to install 32-bit libraries
>  ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)
> @@ -105,3 +107,8 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
>  # state.
>  $(OUTPUT)/check_initial_reg_state_32: CFLAGS +=3D -Wl,-ereal_start=20
> -static
>  $(OUTPUT)/check_initial_reg_state_64: CFLAGS +=3D -Wl,-ereal_start=20
> -static
> +
> +# This test does not link against anything (neither libc nor libgcc).
> +$(OUTPUT)/vsyscall_lockout_64: \
> +	LIBS :=3D -Wl,-no-pie -static -nostdlib -nostartfiles
> +	CFLAGS +=3D -fno-pie -fno-stack-protector -fno-builtin -ffreestanding
> diff --git a/tools/testing/selftests/x86/vsyscall_lockout.c=20
> b/tools/testing/selftests/x86/vsyscall_lockout.c
> new file mode 100644
> index 000000000000..88669b4907ee
> --- /dev/null
> +++ b/tools/testing/selftests/x86/vsyscall_lockout.c
> @@ -0,0 +1,431 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * vsyscall_lockout.c - check that disabling vsyscall works
> + * Copyright (C) 2021 Red Hat, Inc.
> + */
> +
> +#include <stddef.h>
> +
> +#include <asm/prctl.h>
> +#include <asm/vsyscall.h>
> +#include <linux/signal.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +#include <linux/unistd.h>
> +
> +#ifndef ARCH_VSYSCALL_LOCKOUT
> +#define ARCH_VSYSCALL_LOCKOUT   0x5001
> +#elif ARCH_VSYSCALL_LOCKOUT !=3D 0x5001
> +#error wrong vlaue for ARCH_VSYSCALL_LOCKOUT
> +#endif
> +
> +static inline long syscall0(int nr)
> +{
> +        unsigned long result;
> +
> +        __asm__ volatile ("syscall"
> +                          : "=3Da" (result)
> +                          : "0" (nr)
> +                          : "memory", "cc", "r11", "cx");
> +        return result;
> +}
> +
> +static inline long syscall1(int nr, long arg0)
> +{
> +        register long rdi __asm__ ("rdi") =3D arg0;
> +        unsigned long result;
> +
> +        __asm__ volatile ("syscall"
> +                          : "=3Da" (result)
> +                          : "0" (nr), "r" (rdi)
> +                          : "memory", "cc", "r11", "cx");
> +        return result;
> +}
> +
> +static inline long syscall2(int nr, long arg0, long arg1)
> +{
> +        register long rdi __asm__ ("rdi") =3D arg0;
> +        register long rsi __asm__ ("rsi") =3D arg1;
> +        unsigned long result;
> +
> +        __asm__ volatile ("syscall"
> +                          : "=3Da" (result)
> +                          : "0" (nr), "r" (rdi), "r" (rsi)
> +                          : "memory", "cc", "r11", "cx");
> +        return result;
> +}
> +
> +static inline long syscall3(int nr, long arg0, long arg1, long arg2)
> +{
> +        register long rdi __asm__ ("rdi") =3D arg0;
> +        register long rsi __asm__ ("rsi") =3D arg1;
> +        register long rdx __asm__ ("rdx") =3D arg2;
> +        unsigned long result;
> +
> +        __asm__ volatile ("syscall"
> +                          : "=3Da" (result)
> +                          : "0" (nr), "r" (rdi), "r" (rsi), "r" (rdx)
> +                          : "memory", "cc", "r11", "cx");
> +        return result;
> +}
> +
> +static inline long syscall4(int nr, long arg0, long arg1, long arg2,=20
> long arg3)
> +{
> +        register long rdi __asm__ ("rdi") =3D arg0;
> +        register long rsi __asm__ ("rsi") =3D arg1;
> +        register long rdx __asm__ ("rdx") =3D arg2;
> +        register long r10 __asm__ ("r10") =3D arg2;
> +        unsigned long result;
> +
> +        __asm__ volatile ("syscall"
> +                          : "=3Da" (result)
> +                          : "0" (nr), "r" (rdi), "r" (rsi), "r" (rdx),
> +                            "r" (r10)
> +                          : "memory", "cc", "r11", "cx");
> +        return result;
> +}
> +
> +static inline long vsyscall1(long addr, long arg0)
> +{
> +        register long rdi __asm__ ("rdi") =3D arg0;
> +        unsigned long result;
> +
> +        __asm__ volatile ("callq *%%rax"
> +                          : "=3Da" (result)
> +                          : "0" (addr), "r" (rdi)
> +                          : "memory", "cc", "r11", "cx");
> +        return result;
> +}
> +
> +static void __attribute__ ((noreturn)) sys_exit(int status)
> +{
> +        syscall1(__NR_exit, status);
> +        __builtin_unreachable();
> +}
> +
> +static void sigabrt(void)
> +{
> +        syscall2(__NR_kill, syscall0(__NR_getpid), SIGABRT);
> +}
> +
> +static void print_char(char byte)
> +{
> +        if (syscall3(__NR_write, 1L, (long) &byte, 1L) < 0)
> +                sigabrt();
> +}
> +
> +static void print_string(const char *p)
> +{
> +        while (*p) {
> +                print_char(*p);
> +                ++p;
> +        }
> +}
> +
> +static void print_dec_1(unsigned long val)
> +{
> +        if (val !=3D 0) {
> +                print_dec_1(val / 10);
> +                print_char('0' + (val % 10));
> +        }
> +}
> +
> +static void print_dec(unsigned long val)
> +{
> +        if (val =3D=3D 0)
> +                print_char('0');
> +        else
> +                print_dec_1(val);
> +}
> +
> +static void print_signed_dec(long val)
> +{
> +        if (val < 0) {
> +                print_char('-');
> +                print_dec(-(unsigned long)val);
> +        } else
> +                print_dec(val);
> +}
> +
> +static void print_time(const char *label, struct timeval tv)
> +{
> +        print_string(label);
> +        print_string(": ");
> +        print_dec(tv.tv_sec);
> +        print_char(' ');
> +        print_dec(tv.tv_usec);
> +        print_char('\n');
> +}
> +
> +static void print_failure(const char *label, long ret)
> +{
> +        print_string("error: ");
> +        print_string(label);
> +        print_string(" failed: ");
> +        print_signed_dec(ret);
> +        print_char('\n');
> +}
> +
> +static void xgettimeofday(struct timeval *tv)
> +{
> +        long ret =3D syscall1(__NR_gettimeofday, (long) tv);
> +
> +        if (ret !=3D 0) {
> +                print_failure("gettimeofday", ret);
> +                sigabrt();
> +        }
> +}
> +
> +static void xvgettimeofday(struct timeval *tv)
> +{
> +        long ret =3D vsyscall1(VSYSCALL_ADDR, (long) tv);
> +
> +        if (ret) {
> +                print_failure("vgettimeofday", ret);
> +                sigabrt();
> +        }
> +}
> +
> +static int sys_arch_prctl(int code, unsigned long addr)
> +{
> +        return syscall2(__NR_arch_prctl, code, addr);
> +}
> +
> +static __kernel_pid_t xfork(void)
> +{
> +        long ret =3D syscall0(__NR_fork);
> +
> +        if (ret < 0) {
> +                print_failure("fork", ret);
> +                sigabrt();
> +        }
> +        return ret;
> +}
> +
> +static void xexecve(const char *pathname, char **argv, char **envp)
> +{
> +        long ret;
> +
> +        ret =3D syscall3(__NR_execve, (long) pathname, (long) argv,=20
> (long) envp);
> +        print_failure("execve", ret);
> +        sigabrt();
> +}
> +
> +static __kernel_pid_t xwaitpid(__kernel_pid_t pid, int *status, int=20
> options)
> +{
> +        long ret =3D syscall4(__NR_wait4, pid, (long) status, options=
,=20
> 0);
> +
> +        if (ret < 0) {
> +                print_failure("wait4", ret);
> +                sigabrt();
> +        }
> +        return ret;
> +}
> +
> +static int
> +do_lockout(void)
> +{
> +        long ret =3D sys_arch_prctl(ARCH_VSYSCALL_LOCKOUT, 0);
> +        if (ret < 0)
> +                print_failure("arch_prctl(ARCH_VSYSCALL_LOCKOUT)",=20
> ret);
> +        return ret;
> +}
> +
> +static long difftime(struct timeval first, struct timeval second)
> +{
> +        return second.tv_usec - first.tv_usec +
> +                (second.tv_sec - first.tv_sec) * 1000 * 1000;
> +}
> +
> +/*
> + * Second stage: Check that the lockout is not inherited across execv=
e.
> + */
> +static int main_2(void)
> +{
> +        struct timeval vsyscall_time =3D { -1, -1 };
> +        int status =3D 0;
> +
> +        xvgettimeofday(&vsyscall_time);
> +        print_time("vsyscall gettimeofday after fork", vsyscall_time);
> +        if (vsyscall_time.tv_sec < 0 || vsyscall_time.tv_usec < 0)
> +                status =3D 1;
> +
> +        return status;
> +}
> +
> +static void check_lockout_after_fork(int *status, int twice)
> +{
> +        __kernel_pid_t pid;
> +        struct timeval vsyscall_time;
> +        int wstatus;
> +
> +        if (twice) {
> +                __kernel_pid_t pid_outer;
> +
> +                print_string("checking that lockout is inherited by=20
> fork\n");
> +
> +                pid_outer =3D xfork();
> +                if (pid_outer =3D=3D 0) {
> +                        if (do_lockout())
> +                                sys_exit(1);
> +                        /*
> +                         * Logic for the subprocess follows below.
> +                         */
> +                } else {
> +                        xwaitpid(pid_outer, &wstatus, 0);
> +                        if (wstatus !=3D 0) {
> +                                print_string("error: unexpected exit=20
> status: ");
> +                                print_signed_dec(wstatus);
> +                                print_char('\n');
> +                                *status =3D 1;
> +                        }
> +                        return;
> +                }
> +        } else
> +                print_string("checking that lockout works after one=20
> fork\n");
> +
> +        pid =3D xfork();
> +        if (pid =3D=3D 0) {
> +                if (!twice && do_lockout())
> +                        sys_exit(1);
> +                /*
> +                 * This should trigger a fault.
> +                 */
> +                xvgettimeofday(&vsyscall_time);
> +                sys_exit(0);
> +        }
> +        xwaitpid(pid, &wstatus, 0);
> +        switch (wstatus) {
> +        case 0:
> +                print_string("error: no crash after lockout\n");
> +                *status =3D 1;
> +                break;
> +        case 0x0100:
> +                *status =3D 1;
> +                break;
> +        case SIGSEGV:
> +                print_string("termination after lockout\n");
> +                break;
> +        default:
> +                print_string("error: unexpected exit status: ");
> +                print_signed_dec(wstatus);
> +                print_char('\n');
> +                *status =3D 1;
> +        }
> +
> +        if (twice)
> +                sys_exit(*status);
> +
> +        /*
> +         * Status in the parent process should be unaffected.
> +         */
> +        xvgettimeofday(&vsyscall_time);
> +}
> +
> +static void check_no_lockout_after_execve(char **argv, int *status)
> +{
> +        __kernel_pid_t pid;
> +        int wstatus;
> +
> +        print_string("checking that lockout is not inherited by=20
> execve\n");
> +        pid =3D xfork();
> +        if (pid =3D=3D 0) {
> +                struct timeval vsyscall_time;
> +                char *new_argv[] =3D { argv[0], "2", NULL };
> +
> +                xvgettimeofday(&vsyscall_time);
> +                if (do_lockout())
> +                        sys_exit(1);
> +
> +                /*
> +                 * Re-exec the second stage.  See main_2 above.
> +                 */
> +                xexecve(argv[0], new_argv, new_argv + 2);
> +        }
> +
> +        xwaitpid(pid, &wstatus, 0);
> +        if (wstatus !=3D 0) {
> +                print_string("error: unexpected exit status: ");
> +                print_signed_dec(wstatus);
> +                print_char('\n');
> +                *status =3D 1;
> +        }
> +}
> +
> +static int main(int argc, char **argv)
> +{
> +        struct timeval initial_time =3D { -1, -1 };
> +        struct timeval vsyscall_time =3D { -1, -1 };
> +        struct timeval final_time =3D { -1, -1 };
> +        long vsyscall_diff, final_diff;
> +        int status =3D 0;
> +
> +        if (argc > 1)
> +                switch (*argv[1]) {
> +                case '2':
> +                        return main_2();
> +                default:
> +                        print_string("usage: ");
> +                        print_string(argv[0]);
> +                        print_string("\n");
> +                        return 1;
> +                }
> +
> +
> +        xgettimeofday(&initial_time);
> +        xvgettimeofday(&vsyscall_time);
> +        xgettimeofday(&final_time);
> +        vsyscall_diff =3D difftime(initial_time, vsyscall_time);
> +        final_diff =3D difftime(vsyscall_time, final_time);
> +
> +        print_time("initial gettimeofday", initial_time);
> +        print_time("vsyscall gettimeofday", vsyscall_time);
> +        print_time("final gettimeofday", final_time);
> +
> +        if (initial_time.tv_sec < 0 || initial_time.tv_usec < 0 ||
> +            vsyscall_time.tv_sec < 0 || vsyscall_time.tv_usec < 0 ||
> +            final_time.tv_sec < 0 || final_time.tv_usec < 0) {
> +                print_string("error: negative time\n");
> +                status =3D 1;
> +        }
> +
> +        print_string("differences: ");
> +        print_signed_dec(vsyscall_diff);
> +        print_char(' ');
> +        print_signed_dec(final_diff);
> +        print_char('\n');
> +
> +        if (vsyscall_diff < 0 || final_diff < 0) {
> +                /*
> +                 * This may produce false positives if there is an=20
> active NTP.
> +                 */
> +                print_string("error: time went backwards\n");
> +                status =3D 1;
> +        }
> +
> +        check_lockout_after_fork(&status, 0);
> +        check_lockout_after_fork(&status, 1);
> +        check_no_lockout_after_execve(argv, &status);
> +
> +        print_string("testing done, exit status: ");
> +        print_signed_dec(status);
> +        print_char('\n');
> +        return status;
> +}
> +
> +static void __attribute__ ((used)) main_trampoline(long *rsp)
> +{
> +        sys_exit(main(*rsp, (char **) (rsp + 1)));
> +}
> +
> +__asm__ (".text\n\t"
> +         ".globl _start\n"
> +         "_start:\n\t"
> +         ".cfi_startproc\n\t"
> +         ".cfi_undefined rip\n\t"
> +         "movq %rsp, %rdi\n\t"
> +         "callq main_trampoline\n\t" /* Results in psABI %rsp=20
> alignment.  */
> +         ".cfi_endproc\n\t"
> +         ".type _start, @function\n\t"
> +         ".size _start, . - _start\n\t"
> +         ".previous");
