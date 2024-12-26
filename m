Return-Path: <linux-arch+bounces-9511-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BD79FCB9B
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 16:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5F0161930
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7512B8249F;
	Thu, 26 Dec 2024 15:41:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C96C1EEE9;
	Thu, 26 Dec 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227708; cv=none; b=rbgnZz3wQKAqULARj94AIYekVd+Ovv7H97YDaUHvaU9zxFL9FyXJ+YqFfoew6K0ucDz/DN3QgDPGL5E1+sRkim8DMLxB84kCoNOrWL4APKZw7lOCWsy1eu3aai9cXPWme0ubdN3cSJncttl8t49+w68ueEG6ComCBxKzXVBRkX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227708; c=relaxed/simple;
	bh=BotnJtWi/WlwnvmmBOMcys5qecoohsd2ZDoo32+F7X0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKyKX13s4xrUWtyYt2EYj4XZfZxZnbaH50DkyjmKa0yxyNcCFbZJgxG+o3JqbhDsuKKky1KbJewVRJub/1FAkcsjy33bSeuW+PUILLJL5ZS+RS6G9mXCSQTPn2Nx1Rr1i7sm9Sx6iME3qhUSOUkPbYVntAFfGytDrFmeq5A1+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC413C4CED1;
	Thu, 26 Dec 2024 15:41:44 +0000 (UTC)
Date: Thu, 26 Dec 2024 10:42:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
Message-ID: <20241226104242.688716d9@gandalf.local.home>
In-Reply-To: <20241225223300.68299ea8a2836c6947fe9d1c@kernel.org>
References: <173379652547.973433.2311391879173461183.stgit@devnote2>
	<173379656618.973433.13429645373226409113.stgit@devnote2>
	<20241223163956.44245b4b@gandalf.local.home>
	<20241225223300.68299ea8a2836c6947fe9d1c@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Dec 2024 22:33:00 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
> index 8e1a27d2c1eb..f4e0c3361234 100644
> --- a/arch/x86/kernel/ftrace_32.S
> +++ b/arch/x86/kernel/ftrace_32.S
> @@ -194,8 +194,8 @@ return_to_handler:
>  	movl	%esp, %eax
>  	call	ftrace_return_to_handler
>  	movl	%eax, %ecx
> -	movl	%eax, PT_EAX(%esp)
> -	movl	%edx, PT_EDX(%esp)
> +	movl	PT_EAX(%esp), %eax
> +	movl	PT_EDX(%esp), %edx
>  	addl	$(PTREGS_SIZE), %esp
>  	JMP_NOSPEC ecx
>  #endif

This appears to fix the issue. I'll start running your latest series
through my tests.

Thanks,

-- Steve

