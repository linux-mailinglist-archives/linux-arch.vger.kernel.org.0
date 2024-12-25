Return-Path: <linux-arch+bounces-9483-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBF89FC555
	for <lists+linux-arch@lfdr.de>; Wed, 25 Dec 2024 14:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0177418838FE
	for <lists+linux-arch@lfdr.de>; Wed, 25 Dec 2024 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF1B1925AE;
	Wed, 25 Dec 2024 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYsjoaBP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C485626;
	Wed, 25 Dec 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735133589; cv=none; b=KJvVJkrPzcZtqVwf/A3lJk84eYjemYV537N0GcOHvbq8FAEYAOwONxWHFNAMufyqny32QvNWKbhTsOjV6MyCxnedsaahTuzJvZzTOD+Dn5CJLsZGBPt80sOtrqm5mu3ZfyFMt3sX/DEDi5/PeAzVJr0nqkmxHPXsaupv+TWxhJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735133589; c=relaxed/simple;
	bh=0XOFiVo+zOtxp/fbrz4XN0saf1jD3kvygSecxNvsG2c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZelpCYRljLV4vNOpxkUl3300pqK41PfNbdpnUjiD2HQguQDNUnyL8UAigOnLJrgqSDftgxvIB4QtKNB1MnvwOghlj2VFHDdma8+m9/RW/idUOL1/QONJ850zeRMcQHO8E2hhoYl09Gvu5o0KRwRkHEl7UAYYbCAP23emmn+1I9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYsjoaBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4477FC4CECD;
	Wed, 25 Dec 2024 13:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735133588;
	bh=0XOFiVo+zOtxp/fbrz4XN0saf1jD3kvygSecxNvsG2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MYsjoaBPT40kl9GpVzu/uiFhq/vO1Z6xMABq9WStO1c8mqSnyrnIQykWTNyGTIcqt
	 qnAzpbkKekwBnUd0vYOeCfbKnBo133PPL1duOZRrEmbC0jjA12VKj7R14H2Kf+S9a7
	 Xg/H06ymP/ltH038UxmWAicURkpVmyF+Wl2UscoIyfhNDigBHllYXoiSBOyLUd7P5x
	 SuFWEbigaxi2SR9gTBlQ3WtgyweK5Qk5RhSOae7C0d3Pg17FS/vk0SURKFJ67WoAWJ
	 +uptZOXmxCdy6ZGFdB/j7uFK+ofm++HzO466cQq6fipK1FaZDIz7fTrGH0PcNcTIRd
	 Brf7j6kGyNiwA==
Date: Wed, 25 Dec 2024 22:33:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>, Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v21 03/20] fgraph: Replace fgraph_ret_regs with
 ftrace_regs
Message-Id: <20241225223300.68299ea8a2836c6947fe9d1c@kernel.org>
In-Reply-To: <20241223163956.44245b4b@gandalf.local.home>
References: <173379652547.973433.2311391879173461183.stgit@devnote2>
	<173379656618.973433.13429645373226409113.stgit@devnote2>
	<20241223163956.44245b4b@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On Mon, 23 Dec 2024 16:39:56 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 10 Dec 2024 11:09:26 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Use ftrace_regs instead of fgraph_ret_regs for tracing return value
> > on function_graph tracer because of simplifying the callback interface.
> > 
> > The CONFIG_HAVE_FUNCTION_GRAPH_RETVAL is also replaced by
> > CONFIG_HAVE_FUNCTION_GRAPH_FREGS.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Heiko Carstens <hca@linux.ibm.com>
> 
> My x86-32 test failed on this patch with:
> 
> [    8.387985] Testing tracer preemptoff: PASSED
> [    9.603053] Testing tracer preemptirqsoff: PASSED
> [   10.820200] Testing tracer wakeup: PASSED
> [   12.030489] Testing tracer wakeup_rt: PASSED
> [   13.237925] Testing tracer wakeup_dl: PASSED
> [   14.440146] Testing tracer function_graph:
> [   14.611021] ------------[ cut here ]------------
> [   14.614997] WARNING: CPU: 0 PID: 1 at kernel/sched/deadline.c:1519 update_curr_dl_se+0x205/0x270
> [   14.614997] Modules linked in:
> [   14.614997] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 <89>E<EC><E8>^Q~A<FF>d<8B>5<80><96>wɅ<C0><B8>`<FC>9<C9>^OE<F8><8B><86><94>^D 6.13.0-rc4-test-00003-g50b6e5b87e20-dirty #811
> [   14.614997] PSh<E5>^L5<C9><E8><99><FC>^Y<FF><83><C4>^L<EB><C3>.<8D><B4>&
> [   14.614997] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   14.614997] EIP: update_curr_dl_se+0x205/0x270
> [   14.614997] Code: 51 10 89 43 34 0f b7 43 48 89 53 38 66 25 40 01 66 83 f8 40 75 04 80 4b 48 81 89 d8 e8 14 5b ff ff 83 f8 01 0f 84 d4 fe ff ff <0f> 0b e9 cd fe ff ff 8d 74 26 00 ba 20 00 00 00 89 d8 e8 c4 ab ff
> [   14.614997] EAX: c81eed9c EBX: f6f896e0 ECX: c81eed9c EDX: 00000001
> [   14.614997] ESI: f6f89100 EDI: fffffffe EBP: c11cdaac ESP: c11cda94
> [   14.614997] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010082
> [   14.614997] CR0: 80050033 CR2: ff9ff000 CR3: 0978c000 CR4: 000006f0
> [   14.614997] Call Trace:
> [   14.614997] irq event stamp: 11132292
> [   14.614997] hardirqs last  enabled at (11132291): [<c82fac0c>] trace_graph_entry+0x23c/0x3d0
> [   14.614997] hardirqs last disabled at (11132292): [<c8e9f0bc>] sysvec_apic_timer_interrupt+0xc/0x40
> [   14.614997] softirqs last  enabled at (11059360): [<c81678ac>] return_to_handler+0x0/0x34
> [   14.614997] softirqs last disabled at (11059355): [<c81678ac>] return_to_handler+0x0/0x34
> [   14.614997] ---[ end trace 0000000000000000 ]---
> [    7.652636] ------------[ cut here ]------------
> [    7.652636] DEBUG_LOCKS_WARN_ON(1)
> [    7.652636] WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:232 __lock_acquire+0xf42/0x25c0
> [    7.652636] Modules linked in:
> [    7.652636] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 <89>E<EC><E8>^Q~A<FF>d<8B>5<80><96>wɅ<C0><B8>`<FC>9<C9>^OE<F8><8B><86><94>^D 6.13.0-rc4-test-00003-g50b6e5b87e20-dirty #811
> [    7.652636] PSh<E5>^L5<C9><E8><99><FC>^Y<FF><83><C4>^L<EB><C3>.<8D><B4>&
> [    7.652636] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [    7.652636] EIP: __lock_acquire+0xf42/0x25c0
> [    7.652636] Code: e8 63 ba 57 00 85 c0 0f 84 19 f9 ff ff 8b 0d a8 59 62 c9 85 c9 0f 85 0b f9 ff ff 68 c4 8c 34 c9 68 0b 23 32 c9 e8 be ce f7 ff <0f> 0b 58 31 c0 5a e9 61 f2 ff ff 8d 76 00 b9 05 00 00 00 64 a1 80
> [    7.652636] EAX: c820bf72 EBX: 00000000 ECX: c820bf72 EDX: 00000001
> [    7.652636] ESI: 00000000 EDI: c11a2e38 EBP: c1143e7c ESP: c1143de4
> [    7.652636] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010086
> [    7.652636] CR0: 80050033 CR2: ff9ff000 CR3: 0978c000 CR4: 000006f0
> [    7.652636] Call Trace:
> [    7.652636] WARNING: stack recursion on stack type 3
> [    7.652636] irq event stamp: 11215629
> [    7.652636] hardirqs last  enabled at (11215628): [<c81917c9>] handle_softirqs+0x99/0x3b0
> [    7.652636] hardirqs last disabled at (11215629): [<c8eaf5cd>] _raw_spin_lock_irq+0x4d/0x50
> [    7.652636] softirqs last  enabled at (11059360): [<c81678ac>] return_to_handler+0x0/0x34
> [    7.652636] softirqs last disabled at (11215627): [<c81678ac>] return_to_handler+0x0/0x34
> [    7.652636] ---[ end trace 0000000000000000 ]---
> [    7.652636] ------------[ cut here ]------------
> [    7.652636] kernel BUG at arch/x86/mm/extable.c:373!
> [    7.652636] ------------[ cut here ]------------
> [    7.652636] kernel BUG at arch/x86/mm/extable.c:373!
> [    7.652636] ------------[ cut here ]------------
> [    7.652636] kernel BUG at arch/x86/mm/extable.c:373!
> [    7.652636] ------------[ cut here ]------------
> [    7.652636] kernel BUG at arch/x86/mm/extable.c:373!
> [    7.652636] ------------[ cut here ]------------
> [    7.652636] kernel BUG at arch/x86/mm/extable.c:373!
> [    7.652636] ------------[ cut here ]------------
> [    7.652636] kernel BUG at arch/x86/mm/extable.c:373!
> [    7.652636] ------------[ cut here ]------------
> [...]
> 
> Config attached.

Thanks for reporting!

diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 58d9ed50fe61..8e1a27d2c1eb 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -187,14 +187,15 @@ SYM_CODE_END(ftrace_graph_caller)
 
 .globl return_to_handler
 return_to_handler:
-	pushl	$0
-	pushl	%edx
-	pushl	%eax
+	subl	$(PTREGS_SIZE), %esp
+	movl	$0, PT_EBP(%esp)
+	movl	%edx, PT_EDX(%esp)
+	movl	%eax, PT_EAX(%esp)
 	movl	%esp, %eax
 	call	ftrace_return_to_handler
 	movl	%eax, %ecx
-	popl	%eax
-	popl	%edx
-	addl	$4, %esp		# skip ebp
+	movl	%eax, PT_EAX(%esp)
+	movl	%edx, PT_EDX(%esp)

Aah, my bad! These should recover registers from stack...

	movl	PT_EAX(%esp), %eax
	movl	PT_EDX(%esp), %edx


+	addl	$(PTREGS_SIZE), %esp
 	JMP_NOSPEC ecx
 #endif

Can you try below change?

Thank you!


diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 8e1a27d2c1eb..f4e0c3361234 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -194,8 +194,8 @@ return_to_handler:
 	movl	%esp, %eax
 	call	ftrace_return_to_handler
 	movl	%eax, %ecx
-	movl	%eax, PT_EAX(%esp)
-	movl	%edx, PT_EDX(%esp)
+	movl	PT_EAX(%esp), %eax
+	movl	PT_EDX(%esp), %edx
 	addl	$(PTREGS_SIZE), %esp
 	JMP_NOSPEC ecx
 #endif


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

