Return-Path: <linux-arch+bounces-3834-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF58ABA19
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 09:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C561C2090E
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08EB12E5D;
	Sat, 20 Apr 2024 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HstIwZ4k"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4720EB;
	Sat, 20 Apr 2024 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713598501; cv=none; b=NEJIQASP3Ux0IRBMlmLbRO1DwkcnRXowI+ccL0hzeoDZKOOfU8/RMng5REfSY15sIvPAzNlS6mvu+TCUmmUhN+BFpwP0C0eVoaEMIstQgbhVDGRD4clvXzmN0U3EWwboWhDps0TZVFWeJrUzCcWe2A99ek+g3H3KIYLKt2LVpNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713598501; c=relaxed/simple;
	bh=YQ9KfPtm5Gq9HYepBoPJrHlxAcwZYbjakD5piFpGBCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLxl6jNNEst2IqF5XyMzMm82Xg8yJj4+7+iWllu0I+9/7J/iwHLHvBsh8AuzwxMOwekkExF8wcmFVqi/Cg8qyyN3l4WwEDpA1H12Ki3o1gYt2QeHg7FwgCnr1Vof9BkqkBnCwGTNYSzmQ6N+NLAkyoeBp99rBZLphCBV9icN8UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HstIwZ4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB26C113CE;
	Sat, 20 Apr 2024 07:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713598501;
	bh=YQ9KfPtm5Gq9HYepBoPJrHlxAcwZYbjakD5piFpGBCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HstIwZ4kXYt594F3dTAKefbjqk59LgLelJ4wfeugjHKdccg9U6QSsThvKUdOj6kpr
	 cxBq3QX4LKiL1ekSZ4hlwHrg2Qo19wEMdjfcoqJC1hKB987QXK8Wq3oegsKl2zZTfI
	 0ahwnVH2zTwg0WMFDB5bQY2DWepkh6sfONxxfG+SnniZiiLcfZnS8gmDD4/taXFr4a
	 gNoyuT99b/yZU19nTHh4Wm4L6MjmbQoSYrPwuVYcHB2CCTGISZcttYnTQA36iEYp8c
	 S1AEVNMPdbCPnyweb2c/fhVBUzL5EOQDTyFmN+U+fX6hUzHCENDjnN15hBAkD3dzc1
	 3OfMh4fyGR7Ag==
Date: Sat, 20 Apr 2024 10:33:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Masami Hiramatsu <masami.hiramatsu@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 14/15] kprobes: remove dependency on CONFIG_MODULES
Message-ID: <ZiNv0jY7Ebw75iQl@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-15-rppt@kernel.org>
 <20240418061615.5fad23b954bf317c029acc4d@gmail.com>
 <ZiKSffcTiP2c6fbs@kernel.org>
 <321def3e-8bf1-4920-92dd-037b20f1272d@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <321def3e-8bf1-4920-92dd-037b20f1272d@csgroup.eu>

On Fri, Apr 19, 2024 at 03:59:40PM +0000, Christophe Leroy wrote:
> 
> 
> Le 19/04/2024 à 17:49, Mike Rapoport a écrit :
> > Hi Masami,
> > 
> > On Thu, Apr 18, 2024 at 06:16:15AM +0900, Masami Hiramatsu wrote:
> >> Hi Mike,
> >>
> >> On Thu, 11 Apr 2024 19:00:50 +0300
> >> Mike Rapoport <rppt@kernel.org> wrote:
> >>
> >>> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >>>
> >>> kprobes depended on CONFIG_MODULES because it has to allocate memory for
> >>> code.
> >>>
> >>> Since code allocations are now implemented with execmem, kprobes can be
> >>> enabled in non-modular kernels.
> >>>
> >>> Add #ifdef CONFIG_MODULE guards for the code dealing with kprobes inside
> >>> modules, make CONFIG_KPROBES select CONFIG_EXECMEM and drop the
> >>> dependency of CONFIG_KPROBES on CONFIG_MODULES.
> >>
> >> Thanks for this work, but this conflicts with the latest fix in v6.9-rc4.
> >> Also, can you use IS_ENABLED(CONFIG_MODULES) instead of #ifdefs in
> >> function body? We have enough dummy functions for that, so it should
> >> not make a problem.
> > 
> > The code in check_kprobe_address_safe() that gets the module and checks for
> > __init functions does not compile with IS_ENABLED(CONFIG_MODULES).
> > I can pull it out to a helper or leave #ifdef in the function body,
> > whichever you prefer.
> 
> As far as I can see, the only problem is MODULE_STATE_COMING.
> Can we move 'enum module_state' out of #ifdef CONFIG_MODULES in module.h  ?

There's dereference of 'struct module' there:
 
		(*probed_mod)->state != MODULE_STATE_COMING) {
			...
		}

so moving out 'enum module_state' won't be enough.
 
> >   
> >> -- 
> >> Masami Hiramatsu
> > 

-- 
Sincerely yours,
Mike.

