Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63BD48DFAD
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jan 2022 22:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiAMVbP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jan 2022 16:31:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56834 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbiAMVbP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jan 2022 16:31:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CB09B823A0;
        Thu, 13 Jan 2022 21:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E4EC36AE3;
        Thu, 13 Jan 2022 21:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642109472;
        bh=2Si9NLFkmup1qot6ahpn0khz5o0yaHvVTsZulWziZgE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qLDCwEnzh0d3p6Cn1d9O2Pt61njDHDHz4LaKYdPcjYsl8eX4cWVkaHSWDXTNi6VFq
         mvQzDUWIVOK4UTkSKh9wC0S7ytMxoWpZVtzjCIYtFtBluZec4YWz00P2XmaXxk1PUQ
         DG1Rw9ogjlFCTg0cJh5ijEXuLytmUMt1iLJupwoD32PIMHEjNahcs6jgaeJXrE7vGP
         +N3ydbuQedTeXXGz6dq93CiZ7UGDaGlp2aMZAcZKdPxAJigmhTathDT58J4mbLw0Tw
         YlvuqlkjEI9k/hZfEPywa925GD8RlYTO+vCMBTPSgUoY/KebmivLYk/Oj5nMIlEg9f
         ZPHk9w92Y/xlQ==
Message-ID: <4db8cff9-8bf8-0c45-6956-4b1b19b53b2f@kernel.org>
Date:   Thu, 13 Jan 2022 13:31:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/3] x86: Add test for
 arch_prctl(ARCH_VSYSCALL_CONTROL)
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>,
        musl@lists.openwall.com, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andrei Vagin <avagin@gmail.com>
References: <3a1c8280967b491bf6917a18fbff6c9b52e8df24.1641398395.git.fweimer@redhat.com>
 <54ae0e1f8928160c1c4120263ea21c8133aa3ec4.1641398395.git.fweimer@redhat.com>
 <564ba9d6b8f88d139be556d039aadb4b8e078eba.1641398395.git.fweimer@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <564ba9d6b8f88d139be556d039aadb4b8e078eba.1641398395.git.fweimer@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/5/22 08:03, Florian Weimer wrote:
> Signed-off-by: Florian Weimer <fweimer@redhat.com>

This seems like a respectable test case, but why does it work so hard to 
avoid using libc?  Is there something I shuold know about glibc that 
makes its maintainer not want to use it :-p

--Andy

> ---
> v3: Patch split out.
> 
>   tools/arch/x86/include/uapi/asm/prctl.h       |   2 +
>   tools/testing/selftests/x86/Makefile          |   7 +-
>   .../testing/selftests/x86/vsyscall_control.c  | 891 ++++++++++++++++++
>   3 files changed, 899 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/x86/vsyscall_control.c
> 
> diff --git a/tools/arch/x86/include/uapi/asm/prctl.h b/tools/arch/x86/include/uapi/asm/prctl.h
> index 754a07856817..aad0bcfbf49f 100644
> --- a/tools/arch/x86/include/uapi/asm/prctl.h
> +++ b/tools/arch/x86/include/uapi/asm/prctl.h
> @@ -18,4 +18,6 @@
>   #define ARCH_MAP_VDSO_32	0x2002
>   #define ARCH_MAP_VDSO_64	0x2003
>   
> +#define ARCH_VSYSCALL_CONTROL	0x5001
> +
>   #endif /* _ASM_X86_PRCTL_H */
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 0993d12f2c38..4c751836bfeb 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
>   			test_FCMOV test_FCOMI test_FISTTP \
>   			vdso_restorer
>   TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
> -			corrupt_xstate_header amx
> +			corrupt_xstate_header amx vsyscall_control
>   # Some selftests require 32bit support enabled also on 64bit systems
>   TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
>   
> @@ -107,3 +107,8 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
>   # state.
>   $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
>   $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
> +
> +# This test does not link against anything (neither libc nor libgcc).
> +$(OUTPUT)/vsyscall_control_64: \
> +	LIBS := -Wl,-no-pie -static -nostdlib -nostartfiles
> +	CFLAGS += -fno-pie -fno-stack-protector -fno-builtin -ffreestanding
> diff --git a/tools/testing/selftests/x86/vsyscall_control.c b/tools/testing/selftests/x86/vsyscall_control.c
> new file mode 100644
> index 000000000000..ee966f936c89
> --- /dev/null
> +++ b/tools/testing/selftests/x86/vsyscall_control.c
> @@ -0,0 +1,891 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * vsyscall_lockout.c - check that disabling vsyscall works
> + * Copyright (C) 2021 Red Hat, Inc.
> + *
> + * This test requires vsyscall=xonly or vsyscall=emulate.  With
> + * vsyscall=emulate, ARCH_VSYSCALL_CONTROL cannot turn off vsyscall
> + * completely (reads still work), but this is not tested here.
> + */
> +
> +#include <stddef.h>
> +
> +#include <asm/prctl.h>
> +#include <asm/vsyscall.h>
> +#include <linux/errno.h>
> +#include <linux/fcntl.h>
> +#include <linux/signal.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +#include <linux/unistd.h>
> +
> +#ifndef ARCH_VSYSCALL_CONTROL
> +#define ARCH_VSYSCALL_CONTROL	0x5001
> +#elif ARCH_VSYSCALL_CONTROL != 0x5001
> +#error wrong vlaue for ARCH_VSYSCALL_CONTROL
> +#endif
> +
> +
> +static inline long syscall0(int nr)
> +{
> +	unsigned long result;
> +
> +	__asm__ volatile ("syscall"
> +			  : "=a" (result)
> +			  : "0" (nr)
> +			  : "memory", "cc", "r11", "cx");
> +	return result;
> +}
> +
> +static inline long syscall1(int nr, long arg0)
> +{
> +	register long rdi asm("rdi") = arg0;
> +	unsigned long result;
> +
> +	__asm__ volatile ("syscall"
> +			  : "=a" (result)
> +			  : "0" (nr), "r" (rdi)
> +			  : "memory", "cc", "r11", "cx");
> +	return result;
> +}
> +
> +static inline long syscall2(int nr, long arg0, long arg1)
> +{
> +	register long rdi asm("rdi") = arg0;
> +	register long rsi asm("rsi") = arg1;
> +	unsigned long result;
> +
> +	__asm__ volatile ("syscall"
> +			  : "=a" (result)
> +			  : "0" (nr), "r" (rdi), "r" (rsi)
> +			  : "memory", "cc", "r11", "cx");
> +	return result;
> +}
> +
> +static inline long syscall3(int nr, long arg0, long arg1, long arg2)
> +{
> +	register long rdi asm("rdi") = arg0;
> +	register long rsi asm("rsi") = arg1;
> +	register long rdx asm("rdx") = arg2;
> +	unsigned long result;
> +
> +	__asm__ volatile ("syscall"
> +			  : "=a" (result)
> +			  : "0" (nr), "r" (rdi), "r" (rsi), "r" (rdx)
> +			  : "memory", "cc", "r11", "cx");
> +	return result;
> +}
> +
> +static inline long syscall4(int nr, long arg0, long arg1, long arg2, long arg3)
> +{
> +	register long rdi asm("rdi") = arg0;
> +	register long rsi asm("rsi") = arg1;
> +	register long rdx asm("rdx") = arg2;
> +	register long r10 asm("r10") = arg3;
> +	unsigned long result;
> +
> +	__asm__ volatile ("syscall"
> +			  : "=a" (result)
> +			  : "0" (nr), "r" (rdi), "r" (rsi), "r" (rdx),
> +			    "r" (r10)
> +			  : "memory", "cc", "r11", "cx");
> +	return result;
> +}
> +
> +static inline long syscall5(int nr, long arg0, long arg1, long arg2, long arg3,
> +			    long arg4)
> +{
> +	register long rdi asm("rdi") = arg0;
> +	register long rsi asm("rsi") = arg1;
> +	register long rdx asm("rdx") = arg2;
> +	register long r10 asm("r10") = arg3;
> +	register long r8 asm("r8") = arg4;
> +	unsigned long result;
> +
> +	__asm__ volatile ("syscall"
> +			  : "=a" (result)
> +			  : "0" (nr), "r" (rdi), "r" (rsi), "r" (rdx),
> +			    "r" (r10), "r" (r8)
> +			  : "memory", "cc", "r11", "cx");
> +	return result;
> +}
> +
> +static inline long vsyscall2(long addr, long arg0, long arg1)
> +{
> +	register long rdi asm("rdi") = arg0;
> +	register long rsi asm("rsi") = arg1;
> +	unsigned long result;
> +
> +	__asm__ volatile ("callq *%%rax"
> +			  : "=a" (result)
> +			  : "0" (addr), "r" (rdi), "r" (rsi)
> +			  : "memory", "cc", "r11", "cx");
> +	return result;
> +}
> +
> +static void __attribute__ ((noreturn)) sys_exit(int status)
> +{
> +	syscall1(__NR_exit, status);
> +	__builtin_unreachable();
> +}
> +
> +static int sys_access(const char *pathname, int mode)
> +{
> +	return syscall2(__NR_access, (long) pathname, mode);
> +}
> +
> +static int sys_mkdir(const char *pathname, __kernel_mode_t mode)
> +{
> +	return syscall2(__NR_mkdir, (long) pathname, mode);
> +}
> +
> +static int sys_open(const char *pathname, int flags, __kernel_mode_t mode)
> +{
> +	return syscall3(__NR_open, (long) pathname, flags, mode);
> +}
> +
> +static long sys_read(int fd, void *buffer, size_t length)
> +{
> +	return syscall3(__NR_read, fd, (long) buffer, length);
> +}
> +
> +static long sys_write(int fd, const void *buffer, size_t length)
> +{
> +	return syscall3(__NR_write, fd, (long) buffer, length);
> +}
> +
> +static int sys_mount(const char *source, const char *pathname,
> +		     const char *fstype, unsigned long flags,
> +		     const void *data)
> +{
> +	return syscall5(__NR_mount, (long) source, (long) pathname,
> +			(long) fstype, flags, (long) data);
> +}
> +
> +static void sigabrt(void)
> +{
> +	syscall2(__NR_kill, syscall0(__NR_getpid), SIGABRT);
> +}
> +
> +/*
> + * String buffers.
> + */
> +
> +struct buffer {
> +	char *position;
> +	char *limit;
> +};
> +
> +static void buffer_init(struct buffer *b, char *start, size_t length)
> +{
> +	b->position = start;
> +	b->limit = start + length;
> +}
> +
> +static void buffer_append(struct buffer *b, char ch)
> +{
> +	if (b->position >= b->limit)
> +		sigabrt();
> +	*b->position = ch;
> +	++b->position;
> +}
> +
> +static void buffer_append_string(struct buffer *b, const char *p)
> +{
> +	while (*p) {
> +		buffer_append(b, *p);
> +		++p;
> +	}
> +}
> +
> +static void buffer_append_dec_1(struct buffer *b, unsigned long val)
> +{
> +	if (val != 0) {
> +		buffer_append_dec_1(b, val / 10);
> +		buffer_append(b, '0' + (val % 10));
> +	}
> +}
> +
> +static void buffer_append_dec(struct buffer *b, unsigned long val)
> +{
> +	if (val == 0) {
> +		buffer_append(b, '0');
> +		return;
> +	}
> +	buffer_append_dec_1(b, val);
> +}
> +
> +/*
> + * Output to standard output.
> + */
> +
> +static void print_char(char byte)
> +{
> +	if (sys_write(1, &byte, 1) < 0)
> +		sigabrt();
> +}
> +
> +static void print_string(const char *p)
> +{
> +	while (*p) {
> +		print_char(*p);
> +		++p;
> +	}
> +}
> +
> +static void print_dec_1(unsigned long val)
> +{
> +	if (val != 0) {
> +		print_dec_1(val / 10);
> +		print_char('0' + (val % 10));
> +	}
> +}
> +
> +static void print_dec(unsigned long val)
> +{
> +	if (val == 0)
> +		print_char('0');
> +	else
> +		print_dec_1(val);
> +}
> +
> +static void print_signed_dec(long val)
> +{
> +	if (val < 0) {
> +		print_char('-');
> +		print_dec(-(unsigned long)val);
> +	} else
> +		print_dec(val);
> +}
> +
> +static void print_message(unsigned int lineno, const char *tag, const char *p)
> +{
> +	print_string(__FILE__);
> +	print_char(':');
> +	print_dec(lineno);
> +	print_char(':');
> +	print_char(' ');
> +	print_string(tag);
> +	print_char(':');
> +	print_char(' ');
> +	print_string(p);
> +}
> +
> +static void print_info(unsigned int lineno, const char *p)
> +{
> +	print_message(lineno, "info", p);
> +}
> +
> +static void print_error(unsigned int lineno, const char *p)
> +{
> +	print_message(lineno, "ERROR", p);
> +}
> +
> +static void print_failure(int lineno, const char *label, long ret)
> +{
> +	print_error(lineno, label);
> +	print_string(" failed: ");
> +	print_signed_dec(ret);
> +	print_char('\n');
> +}
> +
> +static void print_time(int lineno, const char *label, struct timeval tv)
> +{
> +	print_info(lineno, label);
> +	print_string(": ");
> +	print_dec(tv.tv_sec);
> +	print_char(' ');
> +	print_dec(tv.tv_usec);
> +	print_char('\n');
> +}
> +
> +/*
> + * Process-failing (v)syscall wrappers.
> + */
> +
> +static void xgettimeofday(struct timeval *tv)
> +{
> +	long ret = syscall2(__NR_gettimeofday, (long) tv, 0);
> +
> +	if (ret != 0) {
> +		print_failure(__LINE__, "gettimeofday", ret);
> +		sigabrt();
> +	}
> +}
> +
> +static void xvgettimeofday(struct timeval *tv)
> +{
> +	long ret = vsyscall2(VSYSCALL_ADDR, (long) tv, 0);
> +
> +	if (ret) {
> +		print_failure(__LINE__, "vgettimeofday", ret);
> +		sigabrt();
> +	}
> +}
> +
> +static int sys_arch_prctl(int code, unsigned long addr)
> +{
> +	return syscall2(__NR_arch_prctl, code, addr);
> +}
> +
> +static void xclose(int fd)
> +{
> +	long ret = syscall1(__NR_close, fd);
> +
> +	if (ret < 0) {
> +		print_failure(__LINE__, "close", ret);
> +		sigabrt();
> +	}
> +}
> +
> +static void xwrite_byte(int fd, char b)
> +{
> +	long ret = sys_write(fd, &b, 1);
> +
> +	if (ret != 1) {
> +		print_failure(__LINE__, "write", ret);
> +		sigabrt();
> +	}
> +}
> +
> +static int xread_byte(int fd)
> +{
> +	char b;
> +	long ret = sys_read(fd, &b, 1);
> +
> +	if (ret != 1) {
> +		print_failure(__LINE__, "read", ret);
> +		sigabrt();
> +	}
> +	return b;
> +}
> +
> +static void xpipe(int fds[static 2])
> +{
> +	long ret = syscall2(__NR_pipe2, (long) fds, O_CLOEXEC);
> +
> +	if (ret != 0) {
> +		print_failure(__LINE__, "pipe2", ret);
> +		sigabrt();
> +	}
> +}
> +
> +static __kernel_pid_t xfork(void)
> +{
> +	long ret = syscall0(__NR_fork);
> +
> +	if (ret < 0) {
> +		print_failure(__LINE__, "fork", ret);
> +		sigabrt();
> +	}
> +	return ret;
> +}
> +
> +static void xexecve(const char *pathname, char **argv, char **envp)
> +{
> +	long ret;
> +
> +	ret = syscall3(__NR_execve, (long) pathname, (long) argv, (long) envp);
> +	print_failure(__LINE__, "execve", ret);
> +	sigabrt();
> +}
> +
> +static __kernel_pid_t xwaitpid(__kernel_pid_t pid, int *status, int options)
> +{
> +	long ret = syscall4(__NR_wait4, pid, (long) status, options, 0);
> +
> +	if (ret < 0) {
> +		print_failure(__LINE__, "wait4", ret);
> +		sigabrt();
> +	}
> +	return ret;
> +}
> +
> +/*
> + * Various helpers.
> + */
> +
> +static void vsyscall_disable(void)
> +{
> +	long ret = sys_arch_prctl(ARCH_VSYSCALL_CONTROL, 0);
> +
> +	if (ret != 0)
> +		print_failure(__LINE__, "arch_prctl(ARCH_VSYSCALL_CONTROL, 0)", ret);
> +}
> +
> +static void vsyscall_enable(void)
> +{
> +	long ret = sys_arch_prctl(ARCH_VSYSCALL_CONTROL, 1);
> +
> +	if (ret != 0)
> +		print_failure(__LINE__, "arch_prctl(ARCH_VSYSCALL_CONTROL, 1)", ret);
> +}
> +
> +static long difftime(struct timeval first, struct timeval second)
> +{
> +	return second.tv_usec - first.tv_usec +
> +		(second.tv_sec - first.tv_sec) * 1000 * 1000;
> +}
> +
> +static void ensure_proc_is_mounted(int *status)
> +{
> +	int ret;
> +
> +	if (sys_access("/proc/version", 0) == 0)
> +		return;
> +
> +	ret = sys_mkdir("/proc", 0555);
> +	if (ret == EEXIST)
> +		return;
> +	if (ret != 0) {
> +		print_failure(__LINE__, "could not create /proc", ret);
> +		*status = 1;
> +		return;
> +	}
> +	ret = sys_mount("none", "/proc", "proc", 0, NULL);
> +	if (ret != 0) {
> +		print_failure(__LINE__, "could not mount /proc", ret);
> +		*status = 1;
> +		return;
> +	}
> +	if (sys_access("/proc/version", 0) != 0) {
> +		print_error(__LINE__, "no /proc/version after mounting /proc");
> +		*status = 1;
> +		return;
> +	}
> +}
> +
> +/*
> + * Individual subtest functions.
> + */
> +
> +static void check_time(int *status)
> +{
> +	struct timeval initial_time = { -1, -1 };
> +	struct timeval vsyscall_time = { -1, -1 };
> +	struct timeval final_time = { -1, -1 };
> +	long vsyscall_diff, final_diff;
> +
> +	xgettimeofday(&initial_time);
> +	xvgettimeofday(&vsyscall_time);
> +	xgettimeofday(&final_time);
> +	vsyscall_diff = difftime(initial_time, vsyscall_time);
> +	final_diff = difftime(vsyscall_time, final_time);
> +
> +	print_time(__LINE__, "initial gettimeofday", initial_time);
> +	print_time(__LINE__, "vsyscall gettimeofday", vsyscall_time);
> +	print_time(__LINE__, "final gettimeofday", final_time);
> +
> +	if (initial_time.tv_sec < 0 || initial_time.tv_usec < 0 ||
> +	    vsyscall_time.tv_sec < 0 || vsyscall_time.tv_usec < 0 ||
> +	    final_time.tv_sec < 0 || final_time.tv_usec < 0) {
> +		print_error(__LINE__, "negative time\n");
> +		*status = 1;
> +	}
> +
> +	print_info(__LINE__, "differences: ");
> +	print_signed_dec(vsyscall_diff);
> +	print_char(' ');
> +	print_signed_dec(final_diff);
> +	print_char('\n');
> +
> +	if (vsyscall_diff < 0 || final_diff < 0) {
> +		/*
> +		 * This may produce false positives if there is an active NTP.
> +		 */
> +		print_error(__LINE__, "time went backwards\n");
> +		*status = 1;
> +	}
> +}
> +
> +static void check_lockout_after_fork(int *status, int twice)
> +{
> +	__kernel_pid_t pid;
> +	struct timeval vsyscall_time;
> +	int wstatus;
> +
> +	if (twice) {
> +		__kernel_pid_t pid_outer;
> +
> +		print_info(__LINE__, "checking that lockout is inherited by fork\n");
> +
> +		pid_outer = xfork();
> +		if (pid_outer == 0) {
> +			vsyscall_disable();
> +			/*
> +			 * Logic for the subprocess follows below.
> +			 */
> +		} else {
> +			xwaitpid(pid_outer, &wstatus, 0);
> +			if (wstatus != 0) {
> +				print_error(__LINE__, "unexpected exit status: ");
> +				print_signed_dec(wstatus);
> +				print_char('\n');
> +				*status = 1;
> +			}
> +			return;
> +		}
> +	} else
> +		print_info(__LINE__, "checking that lockout works after one fork\n");
> +
> +	pid = xfork();
> +	if (pid == 0) {
> +		if (!twice)
> +			vsyscall_disable();
> +		/*
> +		 * This should trigger a fault.
> +		 */
> +		xvgettimeofday(&vsyscall_time);
> +		sys_exit(0);
> +	}
> +	xwaitpid(pid, &wstatus, 0);
> +	switch (wstatus) {
> +	case 0:
> +		print_error(__LINE__, "no crash after lockout\n");
> +		*status = 1;
> +		break;
> +	case 0x0100:
> +		*status = 1;
> +		break;
> +	case SIGSEGV:
> +		print_info(__LINE__, "termination after lockout\n");
> +		break;
> +	default:
> +		print_error(__LINE__, "unexpected exit status: ");
> +		print_signed_dec(wstatus);
> +		print_char('\n');
> +		*status = 1;
> +	}
> +
> +	if (twice)
> +		sys_exit(*status);
> +
> +	/*
> +	 * Status in the parent process should be unaffected.
> +	 */
> +	xvgettimeofday(&vsyscall_time);
> +}
> +
> +static void check_no_lockout_after_enable(int *status)
> +{
> +	__kernel_pid_t pid;
> +	struct timeval vsyscall_time;
> +	int wstatus;
> +
> +	print_info(__LINE__, "checking that vsyscall can be re-enabled\n");
> +
> +	pid = xfork();
> +	if (pid == 0) {
> +		vsyscall_disable();
> +		vsyscall_enable();
> +		xvgettimeofday(&vsyscall_time);
> +		print_time(__LINE__, "vsyscall time after re-enable", vsyscall_time);
> +		sys_exit(0);
> +	}
> +
> +	xwaitpid(pid, &wstatus, 0);
> +	if (wstatus != 0) {
> +		print_error(__LINE__, "unexpected exit status: ");
> +		print_signed_dec(wstatus);
> +		print_char('\n');
> +		*status = 1;
> +	}
> +}
> +
> +static void check_no_lockout_after_execve(char **argv, int *status)
> +{
> +	__kernel_pid_t pid;
> +	int wstatus;
> +
> +	print_info(__LINE__, "checking that lockout is not inherited by execve\n");
> +	pid = xfork();
> +	if (pid == 0) {
> +		struct timeval vsyscall_time;
> +		char *new_argv[3];
> +
> +		xvgettimeofday(&vsyscall_time);
> +		vsyscall_disable();
> +
> +		/*
> +		 * Re-exec the second stage.  See main_2 below.
> +		 */
> +		new_argv[0] = argv[0];
> +		new_argv[1] = "2";
> +		new_argv[2] = NULL;
> +		xexecve(argv[0], new_argv, new_argv + 2);
> +	}
> +
> +	xwaitpid(pid, &wstatus, 0);
> +	if (wstatus != 0) {
> +		print_error(__LINE__, "unexpected exit status: ");
> +		print_signed_dec(wstatus);
> +		print_char('\n');
> +		*status = 1;
> +	}
> +}
> +
> +static int has_vsyscall_map(int pid, int *status)
> +{
> +	int result = 0;
> +	char maps_path[50];
> +	int fd;
> +
> +	/*
> +	 * Construct /proc/PID/maps path.
> +	 */
> +	{
> +		struct buffer b;
> +
> +		buffer_init(&b, maps_path, sizeof(maps_path));
> +		buffer_append_string(&b, "/proc/");
> +		if (pid == 0)
> +			buffer_append_string(&b, "self");
> +		else
> +			buffer_append_dec(&b, pid);
> +		buffer_append_string(&b, "/maps");
> +		buffer_append(&b, 0);
> +	}
> +
> +	fd = sys_open(maps_path, O_RDONLY, 0);
> +	if (fd < 0) {
> +		print_error(__LINE__, "maps file ");
> +		print_string(maps_path);
> +		print_string(": ");
> +		print_signed_dec(fd);
> +		print_char('\n');
> +		*status = 1;
> +	}
> +
> +	/*
> +	 * Search for "[vsyscall]\n".
> +	 */
> +	{
> +		char buf[4096];
> +		long ret;
> +
> +		for (size_t i = 0; i < sizeof(buf); ++i)
> +			buf[i] = 0;
> +		ret = sys_read(fd, buf, sizeof(buf));
> +
> +		if (ret < 0 || ret >= sizeof(buf))
> +			print_failure(__LINE__, "read", ret);
> +		else {
> +			char *bracket = buf;
> +
> +			while (1) {
> +				while (*bracket && *bracket != '[')
> +					++bracket;
> +				if (*bracket != '[')
> +					/*
> +					 * End of file has been reached.
> +					 */
> +					break;
> +				++bracket;
> +				if (bracket[0] == 'v'
> +				    && bracket[1] == 's'
> +				    && bracket[2] == 'y'
> +				    && bracket[3] == 's'
> +				    && bracket[4] == 'c'
> +				    && bracket[5] == 'a'
> +				    && bracket[6] == 'l'
> +				    && bracket[7] == 'l'
> +				    && bracket[8] == ']'
> +				    && bracket[9] == '\n') {
> +					result = 1;
> +					break;
> +				}
> +			}
> +		}
> +	}
> +
> +	xclose(fd);
> +	return result;
> +}
> +
> +static void check_vsyscall_in_self_maps(int *status)
> +{
> +	__kernel_pid_t pid;
> +	int wstatus;
> +
> +	print_info(__LINE__, "checking [vsyscall] in /proc/self/maps\n");
> +
> +	pid = xfork();
> +	if (pid == 0) {
> +		if (!has_vsyscall_map(0, status)) {
> +			print_error(__LINE__, "[vsyscall] missing\n");
> +			*status = 1;
> +		}
> +		vsyscall_disable();
> +		if (has_vsyscall_map(0, status)) {
> +			print_error(__LINE__, "[vsyscall] present after disable\n");
> +			*status = 1;
> +		}
> +		vsyscall_enable();
> +		if (!has_vsyscall_map(0, status)) {
> +			print_error(__LINE__, "[vsyscall] missing after enable\n");
> +			*status = 1;
> +		}
> +		sys_exit(*status);
> +	}
> +
> +	xwaitpid(pid, &wstatus, 0);
> +	if (wstatus != 0) {
> +		print_error(__LINE__, "unexpected exit status: ");
> +		print_signed_dec(wstatus);
> +		print_char('\n');
> +		*status = 1;
> +	}
> +}
> +
> +static void check_vsyscall_maps_for_subprocess(int *status)
> +{
> +	__kernel_pid_t pid;
> +	int wstatus;
> +	int outer_to_inner[2];
> +	int inner_to_outer[2];
> +
> +	/*
> +	 * Create pipes used to synchronize the two processes.
> +	 */
> +	xpipe(outer_to_inner);
> +	xpipe(inner_to_outer);
> +
> +	print_info(__LINE__, "checking [vsyscall] in /proc/PID/maps\n");
> +
> +	pid = xfork();
> +	if (pid == 0) {
> +		xclose(outer_to_inner[1]);
> +		xclose(inner_to_outer[0]);
> +
> +		xread_byte(outer_to_inner[0]);
> +		vsyscall_disable();
> +		xwrite_byte(inner_to_outer[1], 101);
> +
> +		xread_byte(outer_to_inner[0]);
> +		vsyscall_disable();
> +		xwrite_byte(inner_to_outer[1], 102);
> +
> +		sys_exit(0);
> +	}
> +
> +	xclose(outer_to_inner[0]);
> +	xclose(inner_to_outer[1]);
> +
> +	if (!has_vsyscall_map(pid, status)) {
> +		print_error(__LINE__, "subprocess starts without [vsyscall]");
> +		*status = 1;
> +	}
> +
> +	xwrite_byte(outer_to_inner[1], 1);
> +	xread_byte(inner_to_outer[0]);
> +
> +	if (has_vsyscall_map(pid, status)) {
> +		print_error(__LINE__, "subprocess has [vsyscall] after disable");
> +		*status = 1;
> +	}
> +
> +	xwrite_byte(outer_to_inner[1], 2);
> +	xread_byte(inner_to_outer[0]);
> +
> +	if (has_vsyscall_map(pid, status)) {
> +		print_error(__LINE__, "subprocess lacks [vsyscall] after enable");
> +		*status = 1;
> +	}
> +
> +	xclose(outer_to_inner[1]);
> +	xclose(inner_to_outer[0]);
> +
> +	xwaitpid(pid, &wstatus, 0);
> +	if (wstatus != 0) {
> +		print_error(__LINE__, "unexpected exit status: ");
> +		print_signed_dec(wstatus);
> +		print_char('\n');
> +		*status = 1;
> +	}
> +}
> +
> +static void check_einval(int *status)
> +{
> +	long ret;
> +
> +	ret = sys_arch_prctl(ARCH_VSYSCALL_CONTROL, 2);
> +	if (ret != -EINVAL) {
> +		print_error(__LINE__, "arch_prctl(ARCH_VSYSCALL_CONTROL, 2) returned ");
> +		print_signed_dec(ret);
> +		print_char('\n');
> +		*status = 1;
> +	}
> +}
> +
> +/*
> + * Second stage: Check that the lockout is not inherited across execve.
> + * Used from check_no_lockout_after_execve.
> + */
> +static int main_2(void)
> +{
> +	struct timeval vsyscall_time = { -1, -1 };
> +	int status = 0;
> +
> +	xvgettimeofday(&vsyscall_time);
> +	print_time(__LINE__, "vsyscall gettimeofday after fork", vsyscall_time);
> +	if (vsyscall_time.tv_sec < 0 || vsyscall_time.tv_usec < 0)
> +		status = 1;
> +
> +	return status;
> +}
> +
> +static int main(int argc, char **argv)
> +{
> +	int status = 0;
> +
> +	if (argc > 1) {
> +		switch (*argv[1]) {
> +		case '2':
> +			return main_2();
> +		default:
> +			print_string("usage: ");
> +			print_string(argv[0]);
> +			print_string("\n");
> +			return 1;
> +		}
> +	}
> +
> +	ensure_proc_is_mounted(&status);
> +
> +	if (has_vsyscall_map(0, &status))
> +		print_info(__LINE__, "vsyscall active at process start\n");
> +	else
> +		print_error(__LINE__, "vsyscall inactive at process start\n");
> +
> +
> +	check_time(&status);
> +	check_lockout_after_fork(&status, 0);
> +	check_lockout_after_fork(&status, 1);
> +	check_no_lockout_after_enable(&status);
> +	check_no_lockout_after_execve(argv, &status);
> +	check_vsyscall_in_self_maps(&status);
> +	check_vsyscall_maps_for_subprocess(&status);
> +	check_einval(&status);
> +
> +	print_info(__LINE__, "testing done, exit status: ");
> +	print_signed_dec(status);
> +	print_char('\n');
> +	return status;
> +}
> +
> +static void __attribute__ ((used)) main_trampoline(long *rsp)
> +{
> +	sys_exit(main(*rsp, (char **) (rsp + 1)));
> +}
> +
> +__asm__(".text\n\t"
> +	".globl _start\n"
> +	"_start:\n\t"
> +	".cfi_startproc\n\t"
> +	".cfi_undefined rip\n\t"
> +	"movq %rsp, %rdi\n\t"
> +	"callq main_trampoline\n\t" /* Results in psABI %rsp alignment.  */
> +	".cfi_endproc\n\t"
> +	".type _start, @function\n\t"
> +	".size _start, . - _start\n\t"
> +	".previous");

