Return-Path: <linux-arch+bounces-7846-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D709955B3
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 19:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7838B26B26
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 17:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7620A5F5;
	Tue,  8 Oct 2024 17:33:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD52A1E0B84;
	Tue,  8 Oct 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408807; cv=none; b=LjbSpB337OqVu7xQT3nPg9g3xwvNg+pFT+I54mwHE1lHP8utgYWSqsagClV2Nf90c9VYiAWnq+5bprZauUZtFU1vR9TsT5aD+cQCSwMKlKZ1IwzcDjXwH7kgi1Cxxfigu3GQ4mgjNJj8mLlekLKYWjCXuIoTqSJLJfCY5ct3Qtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408807; c=relaxed/simple;
	bh=V/O67xgHBvSlN/RwcF5jeWewjjQlkU+oj9wOlfQfWhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikm9K1vjwl7K3Ma6CZnU07l8rwz0uLK7wa22qWQruqQXtqgnrE5zyaRwpKBcEzVzTfoeO98Y0s83MTaz78yxfSISeSno/8pltxrs934NsP2yLHijQgzh/jjSkw2feA5r0G3nsU6o5WuZ44UNUsaiJWKVih4QkE2YjQN9r9HiOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95454C4CEC7;
	Tue,  8 Oct 2024 17:33:22 +0000 (UTC)
Date: Tue, 8 Oct 2024 13:33:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] ftrace: Make ftrace_regs abstract from direct use
Message-ID: <20241008133325.47b7b457@gandalf.local.home>
In-Reply-To: <20241008145852.27223-E-hca@linux.ibm.com>
References: <20241007204743.41314f1d@gandalf.local.home>
	<20241007205458.2bbdf736@gandalf.local.home>
	<20241008145852.27223-E-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Oct 2024 16:58:52 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Mon, Oct 07, 2024 at 08:54:58PM -0400, Steven Rostedt wrote:
> > On Mon, 7 Oct 2024 20:47:43 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > #define arch_ftrace_get_regs(fregs)	({ &arch_ftrace_regs(fregs)->regs; })
> > 
> > I may send a v2 (tomorrow).  
> 
> Could you also write against which tree this patch is?
> It doesn't apply on top of Linus' master branch.

Ah, sorry, I should have specified. It applies to my ftrace/for-next branch
(which is also part of linux-next). I just checked out linux-next, and it
still applies but with some shifts, so updates from other trees do affect
it slightly.

If you want it to apply cleanly, use this tree:

  https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/  ftrace/for-next

-- Steve

