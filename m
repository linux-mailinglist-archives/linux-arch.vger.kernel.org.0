Return-Path: <linux-arch+bounces-9135-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C040B9D1800
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 19:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3B9B2230B
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 18:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B0A1E0DE0;
	Mon, 18 Nov 2024 18:24:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E9E1DFDA5;
	Mon, 18 Nov 2024 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954279; cv=none; b=gQfUq8IVWK2EbRx91uyRHDMpB3vq867GnQgodRsC/jdO/PrV89zIR2wMPzkxL5Sco8NJm7ObA9jOv33+xl31Qo3qw7rNZKICHihHaroVLcSxGd/zn8RVygW4giBP2ItjCVGqRxfwxPyUlw4FyNBtfxZAuQV6BiEQbfI5IbPgLr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954279; c=relaxed/simple;
	bh=QTNu1OGAPgNOZxJIMvW3IuS7XmGuX4ZDJPj5EOOKtxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFmFNszOSjbsxDOFsE/Zc6FhpTeXtyaJk0uTJdlnoM4mnBW4LQ7ZTYaZgL1ThGYTHZcyfcW9mJd0ohmWAQWHk3Vwe0223YODAjO4hrZGbE9nS3YIWiKETr1LJIsUs9NWP2K17XHd0t4iyhsPuUBifz6VdQd9642wl/DlUubWT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4F3C4CECC;
	Mon, 18 Nov 2024 18:24:30 +0000 (UTC)
Date: Mon, 18 Nov 2024 13:25:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski
 <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain
 <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christoph
 Hellwig <hch@infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller
 <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet
 <kent.overstreet@linux.dev>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov
 <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek
 <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, Richard
 Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Song Liu
 <song@kernel.org>, Stafford Horne <shorne@gmail.com>, Suren Baghdasaryan
 <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v7 0/8] x86/module: use large ROX pages for text
 allocations
Message-ID: <20241118132501.4eddb46c@gandalf.local.home>
In-Reply-To: <20241023162711.2579610-1-rppt@kernel.org>
References: <20241023162711.2579610-1-rppt@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 19:27:03 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> This is an updated version of execmem ROX caches.
> 

FYI, I booted a kernel before and after applying these patches with my
change:

  https://lore.kernel.org/20241017113105.1edfa943@gandalf.local.home

Before these patches:

 # cat /sys/kernel/tracing/dyn_ftrace_total_info
57695 pages:231 groups: 9
ftrace boot update time = 14733459 (ns)
ftrace module total update time = 449016 (ns)

After:

 # cat /sys/kernel/tracing/dyn_ftrace_total_info
57708 pages:231 groups: 9
ftrace boot update time = 47195374 (ns)
ftrace module total update time = 592080 (ns)

Which caused boot time to slowdown by over 30ms. That may not seem like
much, but we are very concerned about boot time and are fighting every ms
we can get.

-- Steve

