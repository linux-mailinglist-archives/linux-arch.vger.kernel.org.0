Return-Path: <linux-arch+bounces-3837-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E838ABB1B
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 12:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026122815CF
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 10:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28C61AAA5;
	Sat, 20 Apr 2024 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3eyeiLy"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676CC14273;
	Sat, 20 Apr 2024 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713610428; cv=none; b=dhiY3/x0/9/8c2XF3wZ3TuyZQtQSeoHqlsIJIg/Hgw9p3R4PBClSUWy2l0eIP2ae8MC5Y5E2CmmKKfdMzSSd0l7HaFbQMyvUaF2IxqBx1YPh/9YevN9N/+D6BvVZ9d9/aHcKceuFFeBOa1zEn/loWPRDysDt549816haSrqwOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713610428; c=relaxed/simple;
	bh=SM7VfRahGBLcoMQTiuF9XwON0oAIQm3UPvX2eiqyDXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B379p1/kc4juQFlkHH+3LJhZad49RSBm76RIHBkLVYifKzVKHEa96448eyXSnKi4w/TAZFTFpNipR/I9vPkm5C2+2oR/halV7ENDHl6/5mlL/V/TweTfv1cOIZGDJczKd52N/dDx8B+KIueL4VTLH5Jp94MLgvJcranozjJ/qiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3eyeiLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F744C072AA;
	Sat, 20 Apr 2024 10:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713610427;
	bh=SM7VfRahGBLcoMQTiuF9XwON0oAIQm3UPvX2eiqyDXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3eyeiLylPAUkLSbyyrlGHXzvYV/bgYpLPhV7vw8xijwr2D1MExbuRdRactesAT8X
	 zdt7h71F5DqBQu/eRbhv/5Y0Rre5yGM+3/QnKDXleUxYNRTZmWf1Vo3WU+1+o9lafL
	 JRP9zqL5lB14IFxVzQv/2Y2x11fPGHO1UTIDooMmj7MCyEzwQSZ7FSoL/8Q352iA+B
	 xJtavt8SFXQQ13eBr6UXoSA7CP3oDA+2zBywG990wKdhsiRvE/zNe3PUQwDEQ+0Y6e
	 BUuBnLZ3CWf9tTcjXso+bnm9SeKBHDu3KkkjgF+H+J+dCs6K3ICndd93HsxM2BWoMW
	 e8kLY5pax56uw==
Date: Sat, 20 Apr 2024 13:52:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Message-ID: <ZiOea81saMutayxt@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-15-rppt@kernel.org>
 <20240418061615.5fad23b954bf317c029acc4d@gmail.com>
 <ZiKSffcTiP2c6fbs@kernel.org>
 <321def3e-8bf1-4920-92dd-037b20f1272d@csgroup.eu>
 <ZiNv0jY7Ebw75iQl@kernel.org>
 <20240420181500.07b39c77f1ca086e8a5161b4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240420181500.07b39c77f1ca086e8a5161b4@kernel.org>

On Sat, Apr 20, 2024 at 06:15:00PM +0900, Masami Hiramatsu wrote:
> On Sat, 20 Apr 2024 10:33:38 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > On Fri, Apr 19, 2024 at 03:59:40PM +0000, Christophe Leroy wrote:
> > > 
> > > 
> > > Le 19/04/2024 à 17:49, Mike Rapoport a écrit :
> > > > Hi Masami,
> > > > 
> > > > On Thu, Apr 18, 2024 at 06:16:15AM +0900, Masami Hiramatsu wrote:
> > > >> Hi Mike,
> > > >>
> > > >> On Thu, 11 Apr 2024 19:00:50 +0300
> > > >> Mike Rapoport <rppt@kernel.org> wrote:
> > > >>
> > > >>> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > > >>>
> > > >>> kprobes depended on CONFIG_MODULES because it has to allocate memory for
> > > >>> code.
> > > >>>
> > > >>> Since code allocations are now implemented with execmem, kprobes can be
> > > >>> enabled in non-modular kernels.
> > > >>>
> > > >>> Add #ifdef CONFIG_MODULE guards for the code dealing with kprobes inside
> > > >>> modules, make CONFIG_KPROBES select CONFIG_EXECMEM and drop the
> > > >>> dependency of CONFIG_KPROBES on CONFIG_MODULES.
> > > >>
> > > >> Thanks for this work, but this conflicts with the latest fix in v6.9-rc4.
> > > >> Also, can you use IS_ENABLED(CONFIG_MODULES) instead of #ifdefs in
> > > >> function body? We have enough dummy functions for that, so it should
> > > >> not make a problem.
> > > > 
> > > > The code in check_kprobe_address_safe() that gets the module and checks for
> > > > __init functions does not compile with IS_ENABLED(CONFIG_MODULES).
> > > > I can pull it out to a helper or leave #ifdef in the function body,
> > > > whichever you prefer.
> > > 
> > > As far as I can see, the only problem is MODULE_STATE_COMING.
> > > Can we move 'enum module_state' out of #ifdef CONFIG_MODULES in module.h  ?
> > 
> > There's dereference of 'struct module' there:
> >  
> > 		(*probed_mod)->state != MODULE_STATE_COMING) {
> > 			...
> > 		}
> > 
> > so moving out 'enum module_state' won't be enough.
> 
> Hmm, this part should be inline functions like;
> 
> #ifdef CONFIG_MODULES
> static inline bool module_is_coming(struct module *mod)
> {
> 	return mod->state == MODULE_STATE_COMING;
> }
> #else
> #define module_is_coming(mod) (false)

I'd prefer

static inline module_is_coming(struct module *mod)
{
	return false;
}

> #endif
>
> Then we don't need the enum.
> Thank you,
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

-- 
Sincerely yours,
Mike.

