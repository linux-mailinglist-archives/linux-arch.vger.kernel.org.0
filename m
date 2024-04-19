Return-Path: <linux-arch+bounces-3817-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E9A8AA8B7
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 08:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C38F1F21186
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 06:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CF03A1A8;
	Fri, 19 Apr 2024 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGPxC8PC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77DA63E;
	Fri, 19 Apr 2024 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509798; cv=none; b=uSluC9zo28vHSoNgnpCTH08/ccnBLEO8gH6TK5xWBiFM5Mj2WodUMDcTCP+DgAZvoSe/JFTO7t0wTfWMQxTdeY+XuOSCRP+QGzcwAi1XwGisjgI+chvmpjnSOeV7+zLindn5TMjqfqYWoRFBugF/QePjG3f07+1kKDwNSJ20dLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509798; c=relaxed/simple;
	bh=QyMnC6yNCYeGf0vrwo+bvOEGlhU1enTkpEMS1UdTz3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfeXrSOHRfzoP83QFoYBbmVcyWej2sBnyV6u8bkYQKL4THyJKWx3Lf+tKiXXLWm+KPl3tx31E9mwK1BP+kQCHb38y9WM8sYfUi+nPCaL24bUDc5/YYAghrAP3yqhqoIAzAMprsIP3bJUFivCquJ9mBFkvBGfLUPa1kXva/J6dFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGPxC8PC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5881C072AA;
	Fri, 19 Apr 2024 06:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713509797;
	bh=QyMnC6yNCYeGf0vrwo+bvOEGlhU1enTkpEMS1UdTz3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGPxC8PCY8SnZrF0RCOMbIgSLrKy8hMUcTwQhGg04AArCCIqcrHmv5Ozj+/15Mxmb
	 Z5tAH7Vdwb4CwNtAt3c/UrCpMIZJPngEV7ak2csa/7FlHToGNqqaiOtjXXYFiXJWt3
	 6ObsP+646nnF8SnH5skC5WEdWELGtHSHzBDWXZqXYwBofamn2QdDvdgy5CTKGNpPOO
	 1v84dtOt7AKF4KxvZWU3TOdBN2g9tkVxrJyakFg/qwL0NKQfGsXLfFOWV0O05jtLTZ
	 wM29U64qOuZV772RLQ5j7ljjoO+qx0/azdfHFMH7xioH9AhimXQ/fqnfmBiI3Sy0+P
	 8Za6g/P3pUaVg==
Date: Fri, 19 Apr 2024 09:55:16 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Topel <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 05/15] mm: introduce execmem_alloc() and execmem_free()
Message-ID: <ZiIVVBgaDN4RsroT@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-6-rppt@kernel.org>
 <20240415075241.GF40213@noisy.programming.kicks-ass.net>
 <Zh1lnIdgFeM1o8S5@FVFF77S0Q05N.cambridge.arm.com>
 <Zh4nJp8rv1qRBs8m@kernel.org>
 <CAPhsuW6Pbg2k_Gu4dsBx+H8H5XCHvNdtEZJBPiG_eT0qqr9D1w@mail.gmail.com>
 <ZiE91CJcNw7gBj9g@kernel.org>
 <CAPhsuW4au6v8k8Ab7Ff6Yj64rGvZ7wkz=Xrgh8ZZtLyscpChqQ@mail.gmail.com>
 <ZiFd567L4Zzm2okO@kernel.org>
 <CAPhsuW5SL4_=ZXdHZV8o0KS+5Vf25UMvEKhRgFQLioFtf2pgoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5SL4_=ZXdHZV8o0KS+5Vf25UMvEKhRgFQLioFtf2pgoQ@mail.gmail.com>

On Thu, Apr 18, 2024 at 02:01:22PM -0700, Song Liu wrote:
> On Thu, Apr 18, 2024 at 10:54 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Thu, Apr 18, 2024 at 09:13:27AM -0700, Song Liu wrote:
> > > On Thu, Apr 18, 2024 at 8:37 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > > >
> > > > > > I'm looking at execmem_types more as definition of the consumers, maybe I
> > > > > > should have named the enum execmem_consumer at the first place.
> > > > >
> > > > > I think looking at execmem_type from consumers' point of view adds
> > > > > unnecessary complexity. IIUC, for most (if not all) archs, ftrace, kprobe,
> > > > > and bpf (and maybe also module text) all have the same requirements.
> > > > > Did I miss something?
> > > >
> > > > It's enough to have one architecture with different constrains for kprobes
> > > > and bpf to warrant a type for each.
> > >
> > > AFAICT, some of these constraints can be changed without too much work.
> >
> > But why?
> > I honestly don't understand what are you trying to optimize here. A few
> > lines of initialization in execmem_info?
> 
> IIUC, having separate EXECMEM_BPF and EXECMEM_KPROBE makes it
> harder for bpf and kprobe to share the same ROX page. In many use cases,
> a 2MiB page (assuming x86_64) is enough for all BPF, kprobe, ftrace, and
> module text. It is not efficient if we have to allocate separate pages for each
> of these use cases. If this is not a problem, the current approach works.

The caching of large ROX pages does not need to be per type. 

In the POC I've posted for caching of large ROX pages on x86 [1], the cache is
global and to make kprobes and bpf use it it's enough to set a flag in
execmem_info.

[1] https://lore.kernel.org/all/20240411160526.2093408-1-rppt@kernel.org

> Thanks,
> Song

-- 
Sincerely yours,
Mike.

