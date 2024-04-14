Return-Path: <linux-arch+bounces-3655-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470E38A40F6
	for <lists+linux-arch@lfdr.de>; Sun, 14 Apr 2024 09:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6F5B20FA5
	for <lists+linux-arch@lfdr.de>; Sun, 14 Apr 2024 07:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA28920328;
	Sun, 14 Apr 2024 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkZX4pyV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8681EF01;
	Sun, 14 Apr 2024 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713080113; cv=none; b=jhfvLqamUHK2kY9VNTqF3eDzI2Ftt7Mk7PJCXyk4ATUWzbhfebrsn7U3evEBCasV5X7hMYjOLUgof+yFrHFqx2o5nkJJAud896wkvTNslSlT069J3Xk/NQFMEtk1Bwm+rn/xaYJZicVY8yZ9ES2zMovoNurDDnN9NOe1vpRKumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713080113; c=relaxed/simple;
	bh=3r6JYrqvdbon9DEhTY1H2+qNf7eZiRWdkYsZpzrESPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9c8pXGPHCQFn/kT++m1l0ssOR9MnSdW6Jo3axbb/KvhYfaw3m195eTQ+lBycNNt8+J8TbGykiRz825GHmhAv3VYw5SVWwFsbr7FyAJVfevmGHVIGRHkLrcJnSgXdowk154oO8h0E1DXUeJ8+gTx/ZqfRhwNA3jArBoxqeMKe08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkZX4pyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E552AC072AA;
	Sun, 14 Apr 2024 07:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713080113;
	bh=3r6JYrqvdbon9DEhTY1H2+qNf7eZiRWdkYsZpzrESPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkZX4pyVmQMjyHu1MkWMG+OmN+DpitNdvE+8Vnnpv2LwAkTUvDzAFWuF0QZM39J6H
	 Ds3a5kvcM/VK28fYIC44oLB0Bdn+zUbgRasxe5aCWB4xUu/RgLtSeh5qZWnq/2e8FJ
	 rTnb7E26SRg3O/Hr8+YjRqZvnQzlbsBhEdpfwJTzRcQc4vzX1fY1+RLch4UM3gsvOo
	 lhHc3rEpR8JxFCgxftuFbGO+Ys7pTermVZbhFSEMwu4SjmoAKErzDXHDO+V07uYXeL
	 1NKQmyuzEhmwb/N+lOun0QbkHzR0Hj54fWIETmay8j375CiTaSdfa1+arS37433DN9
	 Fj6dSalTyF8Tw==
Date: Sun, 14 Apr 2024 10:34:00 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>, Helge Deller <deller@gmx.de>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Will Deacon <will@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH 2/7] mm: vmalloc: don't account for number of nodes
 for HUGE_VMAP allocations
Message-ID: <ZhuG6HxnXp036bKk@kernel.org>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-3-rppt@kernel.org>
 <9217c95a-39f6-49ce-9857-ee2eebdb7a16@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9217c95a-39f6-49ce-9857-ee2eebdb7a16@csgroup.eu>

On Fri, Apr 12, 2024 at 06:07:19AM +0000, Christophe Leroy wrote:
> 
> 
> Le 11/04/2024 à 18:05, Mike Rapoport a écrit :
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > vmalloc allocations with VM_ALLOW_HUGE_VMAP that do not explictly
> > specify node ID will use huge pages only if size_per_node is larger than
> > PMD_SIZE.
> > Still the actual allocated memory is not distributed between nodes and
> > there is no advantage in such approach.
> > On the contrary, BPF allocates PMD_SIZE * num_possible_nodes() for each
> > new bpf_prog_pack, while it could do with PMD_SIZE'ed packs.
> > 
> > Don't account for number of nodes for VM_ALLOW_HUGE_VMAP with
> > NUMA_NO_NODE and use huge pages whenever the requested allocation size
> > is larger than PMD_SIZE.
> 
> Patch looks ok but message is confusing. We also use huge pages at PTE 
> size, for instance 512k pages or 16k pages on powerpc 8xx, while 
> PMD_SIZE is 4M.

Ok, I'll rephrase.
 
> Christophe
> 
> > 
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> >   mm/vmalloc.c | 9 ++-------
> >   1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 22aa63f4ef63..5fc8b514e457 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3737,8 +3737,6 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> >   	}
> >   
> >   	if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
> > -		unsigned long size_per_node;
> > -
> >   		/*
> >   		 * Try huge pages. Only try for PAGE_KERNEL allocations,
> >   		 * others like modules don't yet expect huge pages in
> > @@ -3746,13 +3744,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> >   		 * supporting them.
> >   		 */
> >   
> > -		size_per_node = size;
> > -		if (node == NUMA_NO_NODE)
> > -			size_per_node /= num_online_nodes();
> > -		if (arch_vmap_pmd_supported(prot) && size_per_node >= PMD_SIZE)
> > +		if (arch_vmap_pmd_supported(prot) && size >= PMD_SIZE)
> >   			shift = PMD_SHIFT;
> >   		else
> > -			shift = arch_vmap_pte_supported_shift(size_per_node);
> > +			shift = arch_vmap_pte_supported_shift(size);
> >   
> >   		align = max(real_align, 1UL << shift);
> >   		size = ALIGN(real_size, 1UL << shift);

-- 
Sincerely yours,
Mike.

