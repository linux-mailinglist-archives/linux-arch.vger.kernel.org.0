Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C210F4F036E
	for <lists+linux-arch@lfdr.de>; Sat,  2 Apr 2022 15:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348290AbiDBN54 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Apr 2022 09:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356176AbiDBN5F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Apr 2022 09:57:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CB31EC67;
        Sat,  2 Apr 2022 06:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BB87B808CD;
        Sat,  2 Apr 2022 13:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C61C340F3;
        Sat,  2 Apr 2022 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648907692;
        bh=5ucjX4VG+LqJh2oWQ1pBBRlKhrNudWlPTr2cJhdCZBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnTAcBowNA/yYNk8tC7CszK2kitX38egEfjF5k9hyP/cq2+aKvc6QLgcoVND0v0xu
         cpg5KiZPBQ2p21A1AgEfSROFuDVhs5vwjrNLenjcFcVFZ1uvHClpOGTMN2S9HgrVSh
         Bl2luOGlmAH9jRd1ooLbJGGWy3umjn3RdHvsClc2UJP4qNiRfsFCagxbKTMj0YBmtI
         giAcOemI5b6KCAOFrkZ4b15zvhVCtpnc5fXZxWlnSAQQsJSeTf7BWfKVG91x1dFVHM
         pd9DzmH5ATNXPXlft3Nro7MT9OJtdWXXwECfy29sYSO+wlJeert+iHD+FLpBVRWrmx
         vaYiAs3hTB7FA==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH V11 19/20] riscv: compat: ptrace: Add compat_arch_ptrace implement
Date:   Sat,  2 Apr 2022 21:52:55 +0800
Message-Id: <20220402135256.2691868-20-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402135256.2691868-1-guoren@kernel.org>
References: <20220402135256.2691868-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Now, you can use native gdb on riscv64 for rv32 app debugging.

$ uname -a
Linux buildroot 5.16.0-rc4-00036-gbef6b82fdf23-dirty #53 SMP Mon Dec 20 23:06:53 CST 2021 riscv64 GNU/Linux
$ cat /proc/cpuinfo
processor       : 0
hart            : 0
isa             : rv64imafdcsuh
mmu             : sv48

$ file /bin/busybox
/bin/busybox: setuid ELF 32-bit LSB shared object, UCB RISC-V, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv32-ilp32d.so.1, for GNU/Linux 5.15.0, stripped
$ file /usr/bin/gdb
/usr/bin/gdb: ELF 32-bit LSB shared object, UCB RISC-V, version 1 (GNU/Linux), dynamically linked, interpreter /lib/ld-linux-riscv32-ilp32d.so.1, for GNU/Linux 5.15.0, stripped
$ /usr/bin/gdb /bin/busybox
GNU gdb (GDB) 10.2
Copyright (C) 2021 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
...
Reading symbols from /bin/busybox...
(No debugging symbols found in /bin/busybox)
(gdb) b main
Breakpoint 1 at 0x8ddc
(gdb) r
Starting program: /bin/busybox
Failed to read a valid object file image from memory.

Breakpoint 1, 0x555a8ddc in main ()
(gdb) i r
ra             0x77df0b74       0x77df0b74
sp             0x7fdd3d10       0x7fdd3d10
gp             0x5567e800       0x5567e800 <bb_common_bufsiz1+160>
tp             0x77f64280       0x77f64280
t0             0x0      0
t1             0x555a6fac       1431990188
t2             0x77dd8db4       2011008436
fp             0x7fdd3e34       0x7fdd3e34
s1             0x7fdd3e34       2145205812
a0             0xffffffff       -1
a1             0x2000   8192
a2             0x7fdd3e3c       2145205820
a3             0x0      0
a4             0x7fdd3d30       2145205552
a5             0x555a8dc0       1431997888
a6             0x77f2c170       2012397936
a7             0x6a7c7a2f       1786542639
s2             0x0      0
s3             0x0      0
s4             0x555a8dc0       1431997888
s5             0x77f8a3a8       2012783528
s6             0x7fdd3e3c       2145205820
s7             0x5567cecc       1432866508
--Type <RET> for more, q to quit, c to continue without paging--
s8             0x1      1
s9             0x0      0
s10            0x55634448       1432568904
s11            0x0      0
t3             0x77df0bb8       2011106232
t4             0x42fc   17148
t5             0x0      0
t6             0x40     64
pc             0x555a8ddc       0x555a8ddc <main+28>
(gdb) si
0x555a78f0 in mallopt@plt ()
(gdb) c
Continuing.
BusyBox v1.34.1 (2021-12-19 22:39:48 CST) multi-call binary.
BusyBox is copyrighted by many authors between 1998-2015.
Licensed under GPLv2. See source distribution for detailed
copyright notices.

Usage: busybox [function [arguments]...]
   or: busybox --list[-full]
...
[Inferior 1 (process 107) exited normally]
(gdb) q

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/kernel/ptrace.c | 87 +++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index a89243730153..bb387593a121 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -12,6 +12,7 @@
 #include <asm/thread_info.h>
 #include <asm/switch_to.h>
 #include <linux/audit.h>
+#include <linux/compat.h>
 #include <linux/ptrace.h>
 #include <linux/elf.h>
 #include <linux/regset.h>
@@ -111,11 +112,6 @@ static const struct user_regset_view riscv_user_native_view = {
 	.n = ARRAY_SIZE(riscv_user_regset),
 };
 
-const struct user_regset_view *task_user_regset_view(struct task_struct *task)
-{
-	return &riscv_user_native_view;
-}
-
 struct pt_regs_offset {
 	const char *name;
 	int offset;
@@ -273,3 +269,84 @@ __visible void do_syscall_trace_exit(struct pt_regs *regs)
 		trace_sys_exit(regs, regs_return_value(regs));
 #endif
 }
+
+#ifdef CONFIG_COMPAT
+static int compat_riscv_gpr_get(struct task_struct *target,
+				const struct user_regset *regset,
+				struct membuf to)
+{
+	struct compat_user_regs_struct cregs;
+
+	regs_to_cregs(&cregs, task_pt_regs(target));
+
+	return membuf_write(&to, &cregs,
+			    sizeof(struct compat_user_regs_struct));
+}
+
+static int compat_riscv_gpr_set(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	struct compat_user_regs_struct cregs;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &cregs, 0, -1);
+
+	cregs_to_regs(&cregs, task_pt_regs(target));
+
+	return ret;
+}
+
+static const struct user_regset compat_riscv_user_regset[] = {
+	[REGSET_X] = {
+		.core_note_type = NT_PRSTATUS,
+		.n = ELF_NGREG,
+		.size = sizeof(compat_elf_greg_t),
+		.align = sizeof(compat_elf_greg_t),
+		.regset_get = compat_riscv_gpr_get,
+		.set = compat_riscv_gpr_set,
+	},
+#ifdef CONFIG_FPU
+	[REGSET_F] = {
+		.core_note_type = NT_PRFPREG,
+		.n = ELF_NFPREG,
+		.size = sizeof(elf_fpreg_t),
+		.align = sizeof(elf_fpreg_t),
+		.regset_get = riscv_fpr_get,
+		.set = riscv_fpr_set,
+	},
+#endif
+};
+
+static const struct user_regset_view compat_riscv_user_native_view = {
+	.name = "riscv",
+	.e_machine = EM_RISCV,
+	.regsets = compat_riscv_user_regset,
+	.n = ARRAY_SIZE(compat_riscv_user_regset),
+};
+
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+			compat_ulong_t caddr, compat_ulong_t cdata)
+{
+	long ret = -EIO;
+
+	switch (request) {
+	default:
+		ret = compat_ptrace_request(child, request, caddr, cdata);
+		break;
+	}
+
+	return ret;
+}
+#endif /* CONFIG_COMPAT */
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+#ifdef CONFIG_COMPAT
+	if (test_tsk_thread_flag(task, TIF_32BIT))
+		return &compat_riscv_user_native_view;
+	else
+#endif
+		return &riscv_user_native_view;
+}
-- 
2.25.1

