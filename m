Return-Path: <linux-arch+bounces-376-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D3E7F437D
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 11:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C614A2815B2
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5013E470;
	Wed, 22 Nov 2023 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O+hU/Zmo"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08DD93;
	Wed, 22 Nov 2023 02:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7ns1+cR2VXPOP7AtcgbUoX/3v+cYI/iZR3J+PNLyhLY=; b=O+hU/ZmoJE29I5i9Ev5JyQQwhh
	kTVdews5WMgHNE8ZMQT9ewLjcYO6JYSW1cWeW15gT+VYEIUgYEaT0jOcV3tHGRa9C4Su3wSjKYJwn
	fSNhPH65Q3vCZrJjz9Azga2/9K0xQhmo+V9OaeidKlIsBtjZWwIe+4aVuKhRLJPsTbNemJDogqfmC
	cysbk2u5eN59DuzUHqg8Oup6bTBdAfwUZSY8AnoIwV6tY5JKgzaC3unAqS82D0sIZ5AhyqQRCTJo7
	yF1FIDfULSv3FB/rlz5PHkNd4qL+sLBtHn7lyUBjE9udLXfLk8qEELcf/zfwmg9ibR0Sc7yGHxKEe
	dclXpLGQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r5kIF-00CHKw-20;
	Wed, 22 Nov 2023 10:17:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 445093005AA; Wed, 22 Nov 2023 11:17:15 +0100 (CET)
Date: Wed, 22 Nov 2023 11:17:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	davem@davemloft.net, dsahern@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	samitolvanen@google.com, keescook@chromium.org, nathan@kernel.org,
	ndesaulniers@google.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, jpoimboe@kernel.org, joao@overdrivepizza.com,
	mark.rutland@arm.com
Subject: Re: [PATCH 0/2] x86/bpf: Fix FineIBT vs eBPF
Message-ID: <20231122101715.GQ8262@noisy.programming.kicks-ass.net>
References: <20231120144642.591358648@infradead.org>
 <20231122014107.p5zf4o6kjanypla4@macbook-pro-49.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122014107.p5zf4o6kjanypla4@macbook-pro-49.dhcp.thefacebook.com>

On Tue, Nov 21, 2023 at 05:41:07PM -0800, Alexei Starovoitov wrote:
> On Mon, Nov 20, 2023 at 03:46:42PM +0100, Peter Zijlstra wrote:
> > Hi!
> > 
> > There's a problem with FineIBT and eBPF using __nocfi when
> > CONFIG_BPF_JIT_ALWAYS_ON=n, in which case the __nocfi indirect call can target
> > a normal function like __bpf_prog_run32().
> 
> The lack (or partially broken) cfi in the kernel built with
> CONFIG_BPF_JIT_ALWAYS_ON=n is probably the last of people security concerns.
> We introduced CONFIG_BPF_JIT_ALWAYS_ON=y to remove the interpreter,
> since mere presence of _any_ interpreter in the kernel (bpf and any other)
> is an attack vector. As it was demonstrated during spectre days an interpreter
> sitting in executable part of vmlinux .text tremendously helps to craft
> a speculative execution exploit.

Oh, no argument there. I always have JIT_ALWAYS_ON=y (when I have BPF at
all) which is why it took me so long to actually trip over this.

This was a test script systematically build/boot a bunch of configs and
going unexpectedly *splat*.

But it was a good excuse to spend time fixing it.


