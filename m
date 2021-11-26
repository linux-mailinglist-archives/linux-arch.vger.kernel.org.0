Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C06945EF71
	for <lists+linux-arch@lfdr.de>; Fri, 26 Nov 2021 14:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350337AbhKZNxZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Nov 2021 08:53:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377666AbhKZNvX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Nov 2021 08:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637934489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=WwYQ7F2CqzhPk2lJPhddOTuMfrMggW7rI+rRosPHGKA=;
        b=gFge2y4BSuduRq1j0hFri/nE7s8mlmpAa2P7tG4JgCFdQsV3orN4WBq+3IS44OzNjwoTVR
        OEebOgnZrcj9lDpCBwUuo0LckTcu1/BAO2DX/5eM9Qg89O5tsVXu+W7ued+fiDFeLzZT5r
        KiIvzEAkM1dx4FcGE/DyOIPVeVxY3f8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-nG_FYKkBNsOi8ILvr2VO_A-1; Fri, 26 Nov 2021 08:48:04 -0500
X-MC-Unique: nG_FYKkBNsOi8ILvr2VO_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1760781EE6D;
        Fri, 26 Nov 2021 13:48:02 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42A621E6;
        Fri, 26 Nov 2021 13:47:57 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-x86_64@vger.kernel.org, kernel-hardening@lists.openwall.com
Cc:     linux-mm@kvack.org, x86@kernel.org, musl@lists.openwall.com,
        libc-alpha@sourceware.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] x86: Implement arch_prctl(ARCH_VSYSCALL_LOCKOUT) to disable
 vsyscall
Date:   Fri, 26 Nov 2021 14:47:56 +0100
Message-ID: <87h7bzjaer.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Distributions struggle with changing the default for vsyscall
emulation because it is a clear break of userspace ABI, something
that should not happen.

The legacy vsyscall interface is supposed to be used by libcs only,
not by applications.  This commit adds a new arch_prctl request,
ARCH_VSYSCALL_LOCKOUT.  Newer libcs can adopt this request to signal
to the kernel that the process does not need vsyscall emulation.
The kernel can then disable it for the remaining lifetime of the
process.  Legacy libcs do not perform this call, so vsyscall remains
enabled for them.  This approach should achieves backwards
compatibility (perfect compatibility if the assumption that only libcs
use vsyscall is accurate), and it provides full hardening for new
binaries.

The chosen value of ARCH_VSYSCALL_LOCKOUT should avoid conflicts
with outher x86-64 arch_prctl requests.

Future arch_prctls requests commonly used at process startup can imply
vsyscall lockout, so that a separate system call for the lockout is
not needed.

Signed-off-by: Florian Weimer <fweimer@redhat.com>

---
 arch/x86/entry/vsyscall/vsyscall_64.c          |   6 +
 arch/x86/include/asm/mmu.h                     |   6 +
 arch/x86/include/uapi/asm/prctl.h              |   2 +
 arch/x86/kernel/process_64.c                   |   5 +
 tools/arch/x86/include/uapi/asm/prctl.h        |   2 +
 tools/testing/selftests/x86/Makefile           |  13 +-
 tools/testing/selftests/x86/vsyscall_lockout.c | 431 +++++++++++++++++++++++++
 7 files changed, 462 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 0b6b277ee050..ac176481cbdf 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -174,6 +174,12 @@ bool emulate_vsyscall(unsigned long error_code,
 
 	tsk = current;
 
+	if (tsk->mm->context.vsyscall_lockout) {
+		warn_bad_vsyscall(KERN_WARNING, regs,
+				  "vsyscall after lockout (exploit attempt?)");
+		goto sigsegv;
+	}
+
 	/*
 	 * Check for access_ok violations and find the syscall nr.
 	 *
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea9..59ddac5ad2e7 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -41,6 +41,12 @@ typedef struct {
 #ifdef CONFIG_X86_64
 	unsigned short flags;
 #endif
+#ifdef CONFIG_X86_VSYSCALL_EMULATION
+	/*
+	 * Set to true by arch_prctl(ARCH_VSYSCALL_LOCKOUT).
+	 */
+	bool vsyscall_lockout;
+#endif
 
 	struct mutex lock;
 	void __user *vdso;			/* vdso base address */
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 754a07856817..6f2b17ec4798 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -18,4 +18,6 @@
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
 
+#define ARCH_VSYSCALL_LOCKOUT	0x5001
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 3402edec236c..eaabd365aa63 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -816,6 +816,11 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 		ret = put_user(base, (unsigned long __user *)arg2);
 		break;
 	}
+	case ARCH_VSYSCALL_LOCKOUT:
+#ifdef CONFIG_X86_VSYSCALL_EMULATION
+		current->mm->context.vsyscall_lockout = true;
+#endif
+		break;
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
 # ifdef CONFIG_X86_X32_ABI
diff --git a/tools/arch/x86/include/uapi/asm/prctl.h b/tools/arch/x86/include/uapi/asm/prctl.h
index 754a07856817..6f2b17ec4798 100644
--- a/tools/arch/x86/include/uapi/asm/prctl.h
+++ b/tools/arch/x86/include/uapi/asm/prctl.h
@@ -18,4 +18,6 @@
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
 
+#define ARCH_VSYSCALL_LOCKOUT	0x5001
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 8a1f62ab3c8e..2269429b77e0 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx
+			corrupt_xstate_header amx vsyscall_lockout
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
@@ -72,10 +72,12 @@ all_64: $(BINARIES_64)
 EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
 
 $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
-	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
+	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ \
+		$(or $(LIBS), -lrt -ldl -lm)
 
 $(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h
-	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
+	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ \
+		$(or $(LIBS), -lrt -ldl -lm)
 
 # x86_64 users should be encouraged to install 32-bit libraries
 ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)
@@ -105,3 +107,8 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
 # state.
 $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
 $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
+
+# This test does not link against anything (neither libc nor libgcc).
+$(OUTPUT)/vsyscall_lockout_64: \
+	LIBS := -Wl,-no-pie -static -nostdlib -nostartfiles
+	CFLAGS += -fno-pie -fno-stack-protector -fno-builtin -ffreestanding
diff --git a/tools/testing/selftests/x86/vsyscall_lockout.c b/tools/testing/selftests/x86/vsyscall_lockout.c
new file mode 100644
index 000000000000..88669b4907ee
--- /dev/null
+++ b/tools/testing/selftests/x86/vsyscall_lockout.c
@@ -0,0 +1,431 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vsyscall_lockout.c - check that disabling vsyscall works
+ * Copyright (C) 2021 Red Hat, Inc.
+ */
+
+#include <stddef.h>
+
+#include <asm/prctl.h>
+#include <asm/vsyscall.h>
+#include <linux/signal.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/unistd.h>
+
+#ifndef ARCH_VSYSCALL_LOCKOUT
+#define ARCH_VSYSCALL_LOCKOUT   0x5001
+#elif ARCH_VSYSCALL_LOCKOUT != 0x5001
+#error wrong vlaue for ARCH_VSYSCALL_LOCKOUT
+#endif
+
+static inline long syscall0(int nr)
+{
+        unsigned long result;
+
+        __asm__ volatile ("syscall"
+                          : "=a" (result)
+                          : "0" (nr)
+                          : "memory", "cc", "r11", "cx");
+        return result;
+}
+
+static inline long syscall1(int nr, long arg0)
+{
+        register long rdi __asm__ ("rdi") = arg0;
+        unsigned long result;
+
+        __asm__ volatile ("syscall"
+                          : "=a" (result)
+                          : "0" (nr), "r" (rdi)
+                          : "memory", "cc", "r11", "cx");
+        return result;
+}
+
+static inline long syscall2(int nr, long arg0, long arg1)
+{
+        register long rdi __asm__ ("rdi") = arg0;
+        register long rsi __asm__ ("rsi") = arg1;
+        unsigned long result;
+
+        __asm__ volatile ("syscall"
+                          : "=a" (result)
+                          : "0" (nr), "r" (rdi), "r" (rsi)
+                          : "memory", "cc", "r11", "cx");
+        return result;
+}
+
+static inline long syscall3(int nr, long arg0, long arg1, long arg2)
+{
+        register long rdi __asm__ ("rdi") = arg0;
+        register long rsi __asm__ ("rsi") = arg1;
+        register long rdx __asm__ ("rdx") = arg2;
+        unsigned long result;
+
+        __asm__ volatile ("syscall"
+                          : "=a" (result)
+                          : "0" (nr), "r" (rdi), "r" (rsi), "r" (rdx)
+                          : "memory", "cc", "r11", "cx");
+        return result;
+}
+
+static inline long syscall4(int nr, long arg0, long arg1, long arg2, long arg3)
+{
+        register long rdi __asm__ ("rdi") = arg0;
+        register long rsi __asm__ ("rsi") = arg1;
+        register long rdx __asm__ ("rdx") = arg2;
+        register long r10 __asm__ ("r10") = arg2;
+        unsigned long result;
+
+        __asm__ volatile ("syscall"
+                          : "=a" (result)
+                          : "0" (nr), "r" (rdi), "r" (rsi), "r" (rdx),
+                            "r" (r10)
+                          : "memory", "cc", "r11", "cx");
+        return result;
+}
+
+static inline long vsyscall1(long addr, long arg0)
+{
+        register long rdi __asm__ ("rdi") = arg0;
+        unsigned long result;
+
+        __asm__ volatile ("callq *%%rax"
+                          : "=a" (result)
+                          : "0" (addr), "r" (rdi)
+                          : "memory", "cc", "r11", "cx");
+        return result;
+}
+
+static void __attribute__ ((noreturn)) sys_exit(int status)
+{
+        syscall1(__NR_exit, status);
+        __builtin_unreachable();
+}
+
+static void sigabrt(void)
+{
+        syscall2(__NR_kill, syscall0(__NR_getpid), SIGABRT);
+}
+
+static void print_char(char byte)
+{
+        if (syscall3(__NR_write, 1L, (long) &byte, 1L) < 0)
+                sigabrt();
+}
+
+static void print_string(const char *p)
+{
+        while (*p) {
+                print_char(*p);
+                ++p;
+        }
+}
+
+static void print_dec_1(unsigned long val)
+{
+        if (val != 0) {
+                print_dec_1(val / 10);
+                print_char('0' + (val % 10));
+        }
+}
+
+static void print_dec(unsigned long val)
+{
+        if (val == 0)
+                print_char('0');
+        else
+                print_dec_1(val);
+}
+
+static void print_signed_dec(long val)
+{
+        if (val < 0) {
+                print_char('-');
+                print_dec(-(unsigned long)val);
+        } else
+                print_dec(val);
+}
+
+static void print_time(const char *label, struct timeval tv)
+{
+        print_string(label);
+        print_string(": ");
+        print_dec(tv.tv_sec);
+        print_char(' ');
+        print_dec(tv.tv_usec);
+        print_char('\n');
+}
+
+static void print_failure(const char *label, long ret)
+{
+        print_string("error: ");
+        print_string(label);
+        print_string(" failed: ");
+        print_signed_dec(ret);
+        print_char('\n');
+}
+
+static void xgettimeofday(struct timeval *tv)
+{
+        long ret = syscall1(__NR_gettimeofday, (long) tv);
+
+        if (ret != 0) {
+                print_failure("gettimeofday", ret);
+                sigabrt();
+        }
+}
+
+static void xvgettimeofday(struct timeval *tv)
+{
+        long ret = vsyscall1(VSYSCALL_ADDR, (long) tv);
+
+        if (ret) {
+                print_failure("vgettimeofday", ret);
+                sigabrt();
+        }
+}
+
+static int sys_arch_prctl(int code, unsigned long addr)
+{
+        return syscall2(__NR_arch_prctl, code, addr);
+}
+
+static __kernel_pid_t xfork(void)
+{
+        long ret = syscall0(__NR_fork);
+
+        if (ret < 0) {
+                print_failure("fork", ret);
+                sigabrt();
+        }
+        return ret;
+}
+
+static void xexecve(const char *pathname, char **argv, char **envp)
+{
+        long ret;
+
+        ret = syscall3(__NR_execve, (long) pathname, (long) argv, (long) envp);
+        print_failure("execve", ret);
+        sigabrt();
+}
+
+static __kernel_pid_t xwaitpid(__kernel_pid_t pid, int *status, int options)
+{
+        long ret = syscall4(__NR_wait4, pid, (long) status, options, 0);
+
+        if (ret < 0) {
+                print_failure("wait4", ret);
+                sigabrt();
+        }
+        return ret;
+}
+
+static int
+do_lockout(void)
+{
+        long ret = sys_arch_prctl(ARCH_VSYSCALL_LOCKOUT, 0);
+        if (ret < 0)
+                print_failure("arch_prctl(ARCH_VSYSCALL_LOCKOUT)", ret);
+        return ret;
+}
+
+static long difftime(struct timeval first, struct timeval second)
+{
+        return second.tv_usec - first.tv_usec +
+                (second.tv_sec - first.tv_sec) * 1000 * 1000;
+}
+
+/*
+ * Second stage: Check that the lockout is not inherited across execve.
+ */
+static int main_2(void)
+{
+        struct timeval vsyscall_time = { -1, -1 };
+        int status = 0;
+
+        xvgettimeofday(&vsyscall_time);
+        print_time("vsyscall gettimeofday after fork", vsyscall_time);
+        if (vsyscall_time.tv_sec < 0 || vsyscall_time.tv_usec < 0)
+                status = 1;
+
+        return status;
+}
+
+static void check_lockout_after_fork(int *status, int twice)
+{
+        __kernel_pid_t pid;
+        struct timeval vsyscall_time;
+        int wstatus;
+
+        if (twice) {
+                __kernel_pid_t pid_outer;
+
+                print_string("checking that lockout is inherited by fork\n");
+
+                pid_outer = xfork();
+                if (pid_outer == 0) {
+                        if (do_lockout())
+                                sys_exit(1);
+                        /*
+                         * Logic for the subprocess follows below.
+                         */
+                } else {
+                        xwaitpid(pid_outer, &wstatus, 0);
+                        if (wstatus != 0) {
+                                print_string("error: unexpected exit status: ");
+                                print_signed_dec(wstatus);
+                                print_char('\n');
+                                *status = 1;
+                        }
+                        return;
+                }
+        } else
+                print_string("checking that lockout works after one fork\n");
+
+        pid = xfork();
+        if (pid == 0) {
+                if (!twice && do_lockout())
+                        sys_exit(1);
+                /*
+                 * This should trigger a fault.
+                 */
+                xvgettimeofday(&vsyscall_time);
+                sys_exit(0);
+        }
+        xwaitpid(pid, &wstatus, 0);
+        switch (wstatus) {
+        case 0:
+                print_string("error: no crash after lockout\n");
+                *status = 1;
+                break;
+        case 0x0100:
+                *status = 1;
+                break;
+        case SIGSEGV:
+                print_string("termination after lockout\n");
+                break;
+        default:
+                print_string("error: unexpected exit status: ");
+                print_signed_dec(wstatus);
+                print_char('\n');
+                *status = 1;
+        }
+
+        if (twice)
+                sys_exit(*status);
+
+        /*
+         * Status in the parent process should be unaffected.
+         */
+        xvgettimeofday(&vsyscall_time);
+}
+
+static void check_no_lockout_after_execve(char **argv, int *status)
+{
+        __kernel_pid_t pid;
+        int wstatus;
+
+        print_string("checking that lockout is not inherited by execve\n");
+        pid = xfork();
+        if (pid == 0) {
+                struct timeval vsyscall_time;
+                char *new_argv[] = { argv[0], "2", NULL };
+
+                xvgettimeofday(&vsyscall_time);
+                if (do_lockout())
+                        sys_exit(1);
+
+                /*
+                 * Re-exec the second stage.  See main_2 above.
+                 */
+                xexecve(argv[0], new_argv, new_argv + 2);
+        }
+
+        xwaitpid(pid, &wstatus, 0);
+        if (wstatus != 0) {
+                print_string("error: unexpected exit status: ");
+                print_signed_dec(wstatus);
+                print_char('\n');
+                *status = 1;
+        }
+}
+
+static int main(int argc, char **argv)
+{
+        struct timeval initial_time = { -1, -1 };
+        struct timeval vsyscall_time = { -1, -1 };
+        struct timeval final_time = { -1, -1 };
+        long vsyscall_diff, final_diff;
+        int status = 0;
+
+        if (argc > 1)
+                switch (*argv[1]) {
+                case '2':
+                        return main_2();
+                default:
+                        print_string("usage: ");
+                        print_string(argv[0]);
+                        print_string("\n");
+                        return 1;
+                }
+
+
+        xgettimeofday(&initial_time);
+        xvgettimeofday(&vsyscall_time);
+        xgettimeofday(&final_time);
+        vsyscall_diff = difftime(initial_time, vsyscall_time);
+        final_diff = difftime(vsyscall_time, final_time);
+
+        print_time("initial gettimeofday", initial_time);
+        print_time("vsyscall gettimeofday", vsyscall_time);
+        print_time("final gettimeofday", final_time);
+
+        if (initial_time.tv_sec < 0 || initial_time.tv_usec < 0 ||
+            vsyscall_time.tv_sec < 0 || vsyscall_time.tv_usec < 0 ||
+            final_time.tv_sec < 0 || final_time.tv_usec < 0) {
+                print_string("error: negative time\n");
+                status = 1;
+        }
+
+        print_string("differences: ");
+        print_signed_dec(vsyscall_diff);
+        print_char(' ');
+        print_signed_dec(final_diff);
+        print_char('\n');
+
+        if (vsyscall_diff < 0 || final_diff < 0) {
+                /*
+                 * This may produce false positives if there is an active NTP.
+                 */
+                print_string("error: time went backwards\n");
+                status = 1;
+        }
+
+        check_lockout_after_fork(&status, 0);
+        check_lockout_after_fork(&status, 1);
+        check_no_lockout_after_execve(argv, &status);
+
+        print_string("testing done, exit status: ");
+        print_signed_dec(status);
+        print_char('\n');
+        return status;
+}
+
+static void __attribute__ ((used)) main_trampoline(long *rsp)
+{
+        sys_exit(main(*rsp, (char **) (rsp + 1)));
+}
+
+__asm__ (".text\n\t"
+         ".globl _start\n"
+         "_start:\n\t"
+         ".cfi_startproc\n\t"
+         ".cfi_undefined rip\n\t"
+         "movq %rsp, %rdi\n\t"
+         "callq main_trampoline\n\t" /* Results in psABI %rsp alignment.  */
+         ".cfi_endproc\n\t"
+         ".type _start, @function\n\t"
+         ".size _start, . - _start\n\t"
+         ".previous");

