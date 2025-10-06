Return-Path: <linux-arch+bounces-13940-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD258BBFB70
	for <lists+linux-arch@lfdr.de>; Tue, 07 Oct 2025 00:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 620A234C086
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 22:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA3122AE45;
	Mon,  6 Oct 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M4hIhAmX"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D5D2192E4;
	Mon,  6 Oct 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790540; cv=none; b=bRu8m+uvBzCCHPEQDUbKj/gXtMzFxdknqDhZOxWWq5/qIxbkstVRMHDRob76M0G/G2Qz2dHUlXd9+iua2qV39RWbTLsoYMJpcJFoYko/otRd7/0bAay2ZbdTuz1FBVowmGs9o8TlW6A+N2c2lMApoVo9DlCq5mzhvL06e1RZD1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790540; c=relaxed/simple;
	bh=xBx6eoybhK6Z7qJu7B2Qw79Yjs3xbXlduwvIlGTsCvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhyeMSsKl4YTgASHL84c3XlEwOX7/s9a/D1VDKV9Z9+3cir1XYL2BN6XzSpumuSK8uCu9f8UbJmvxOGORHty06hu+dFlzWWMZC+9CJIthRJeH8KDJSXmqngolYkomqJi6nm7pua1mZ1bG1ZZj5vsmIwnc5umH8EcIgYGPbS2gxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M4hIhAmX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6F58B211CDFC;
	Mon,  6 Oct 2025 15:42:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F58B211CDFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759790537;
	bh=2Qeb8MB2Y9o7j2dDxE+z2vNE0rIfKJIRDJ/v1rzq8ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4hIhAmXvFCqA02EO4Exxx0OlrKkerCZqoZxi1r58f/BEM/qIB/Tf3BIxy1QDDWmP
	 3hMMB2Gtsq+3yYegrqARj5HkkAFGGnlFBRI7Nyvapr2VCWoCbNXbfYA4duxPbNXOzi
	 6NHS7lBtzTPASyI+LZqW2Aqvr8YI/pyIXq8iXJZs=
From: Mukesh Rathor <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de
Subject: [PATCH v3 4/6] x86/hyperv: Add trampoline asm code to transition from hypervisor
Date: Mon,  6 Oct 2025 15:42:06 -0700
Message-Id: <20251006224208.1060990-5-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
References: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a small asm stub to transition from the hypervisor to Linux
after devirtualization. Devirtualization means disabling hypervisor on
the fly, so after it is done, the code is running on physical processor
instead of virtual, and hypervisor is gone. This can be done by a
root vm only.

At a high level, during panic of either the hypervisor or the root,
the NMI handler asks hypervisor to devirtualize. As part of that,
the arguments include an entry point to return back to Linux. This asm
stub implements that entry point.

The stub is entered in protected mode, uses temporary gdt and page table
to enable long mode and get to kernel entry point which then restores full
kernel context to resume execution to kexec.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/hv_trampoline.S | 101 ++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 arch/x86/hyperv/hv_trampoline.S

diff --git a/arch/x86/hyperv/hv_trampoline.S b/arch/x86/hyperv/hv_trampoline.S
new file mode 100644
index 000000000000..25f02ff12286
--- /dev/null
+++ b/arch/x86/hyperv/hv_trampoline.S
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * X86 specific Hyper-V kdump/crash related code.
+ *
+ * Copyright (C) 2025, Microsoft, Inc.
+ *
+ */
+#include <linux/linkage.h>
+#include <asm/alternative.h>
+#include <asm/msr.h>
+#include <asm/processor-flags.h>
+#include <asm/nospec-branch.h>
+
+/*
+ * void noreturn hv_crash_asm32(arg1)
+ *    arg1 == edi == 32bit PA of struct hv_crash_tramp_data
+ *
+ * The hypervisor jumps here upon devirtualization in protected mode. This
+ * code gets copied to a page in the low 4G ie, 32bit space so it can run
+ * in the protected mode. Hence we cannot use any compile/link time offsets or
+ * addresses. It restores long mode via temporary gdt and page tables and
+ * eventually jumps to kernel code entry at HV_CRASHDATA_OFFS_C_entry.
+ *
+ * PreCondition (ie, Hypervisor call back ABI):
+ *  o CR0 is set to 0x0021: PE(prot mode) and NE are set, paging is disabled
+ *  o CR4 is set to 0x0
+ *  o IA32_EFER is set to 0x901 (SCE and NXE are set)
+ *  o EDI is set to the Arg passed to HVCALL_DISABLE_HYP_EX.
+ *  o CS, DS, ES, FS, GS are all initialized with a base of 0 and limit 0xFFFF
+ *  o IDTR, TR and GDTR are initialized with a base of 0 and limit of 0xFFFF
+ *  o LDTR is initialized as invalid (limit of 0)
+ *  o MSR PAT is power on default.
+ *  o Other state/registers are cleared. All TLBs flushed.
+ */
+
+#define HV_CRASHDATA_OFFS_TRAMPCR3    0x0    /*  0 */
+#define HV_CRASHDATA_OFFS_KERNCR3     0x8    /*  8 */
+#define HV_CRASHDATA_OFFS_GDTRLIMIT  0x12    /* 18 */
+#define HV_CRASHDATA_OFFS_CS_JMPTGT  0x28    /* 40 */
+#define HV_CRASHDATA_OFFS_C_entry    0x30    /* 48 */
+
+	.text
+	.code32
+
+SYM_CODE_START(hv_crash_asm32)
+	UNWIND_HINT_UNDEFINED
+	ENDBR
+	movl	$X86_CR4_PAE, %ecx
+	movl	%ecx, %cr4
+
+	movl %edi, %ebx
+	add $HV_CRASHDATA_OFFS_TRAMPCR3, %ebx
+	movl %cs:(%ebx), %eax
+	movl %eax, %cr3
+
+	/* Setup EFER for long mode now */
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btsl	$_EFER_LME, %eax
+	wrmsr
+
+	/* Turn paging on using the temp 32bit trampoline page table */
+	movl %cr0, %eax
+	orl $(X86_CR0_PG), %eax
+	movl %eax, %cr0
+
+	/* since kernel cr3 could be above 4G, we need to be in the long mode
+	 * before we can load 64bits of the kernel cr3. We use a temp gdt for
+	 * that with CS.L=1 and CS.D=0 */
+	mov %edi, %eax
+	add $HV_CRASHDATA_OFFS_GDTRLIMIT, %eax
+	lgdtl %cs:(%eax)
+
+	/* not done yet, restore CS now to switch to CS.L=1 */
+	mov %edi, %eax
+	add $HV_CRASHDATA_OFFS_CS_JMPTGT, %eax
+	ljmp %cs:*(%eax)
+SYM_CODE_END(hv_crash_asm32)
+
+	/* we now run in full 64bit IA32-e long mode, CS.L=1 and CS.D=0 */
+	.code64
+	.balign 8
+SYM_CODE_START(hv_crash_asm64)
+	UNWIND_HINT_UNDEFINED
+	ENDBR
+	/* restore kernel page tables so we can jump to kernel code */
+	mov %edi, %eax
+	add $HV_CRASHDATA_OFFS_KERNCR3, %eax
+	movq %cs:(%eax), %rbx
+	movq %rbx, %cr3
+
+	mov %edi, %eax
+	add $HV_CRASHDATA_OFFS_C_entry, %eax
+	movq %cs:(%eax), %rbx
+	ANNOTATE_RETPOLINE_SAFE
+	jmp *%rbx
+
+	int $3
+
+SYM_INNER_LABEL(hv_crash_asm_end, SYM_L_GLOBAL)
+SYM_CODE_END(hv_crash_asm64)
-- 
2.36.1.vfs.0.0


