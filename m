Return-Path: <linux-arch+bounces-4033-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8A58B4A2A
	for <lists+linux-arch@lfdr.de>; Sun, 28 Apr 2024 08:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E4028206B
	for <lists+linux-arch@lfdr.de>; Sun, 28 Apr 2024 06:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E464F1E4;
	Sun, 28 Apr 2024 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTZs9sEm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB6EED0;
	Sun, 28 Apr 2024 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714287394; cv=none; b=ayp2SHFhmGd+wutBIzD6ayDbef85RnziqESmRg6c5gRUihh9nEzhXmNGTgUyFryj68TbWD3+ddD92gYmk0wesyaiAH28gSAxGUmNKMoSTESWOFVs2ebXHEgvsp8nx3l/yMXL6savh59lY49HDQkJSagBgnwuzDTl6K0KqWDqaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714287394; c=relaxed/simple;
	bh=r0oXOuLVQhCBCby5vRLJpkXcTQDGNz/eiiiW5fCcIdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3imFH0UThs4DbUDvBr+5fkIgB6IpQo/fUZaBMk5DDIGuu6KfBltQKm3BV26tnRVo16uOcU4DKhJnJ2I59yYqHD82Xet+D1osjE743YGS1JtVIrC8jKFmmvgoNfrgzmFOo9N7WUs7LKNGlDt0jRy5A0N7f5uPFo9yZE7c9o/NZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTZs9sEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702DBC113CC;
	Sun, 28 Apr 2024 06:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714287393;
	bh=r0oXOuLVQhCBCby5vRLJpkXcTQDGNz/eiiiW5fCcIdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTZs9sEmm6/FaMuCbn9MAi43Dw5JaVHQ6Qo9kJKbgmQydz8t76xJqWvnLhWUbFuTg
	 eamwTb265HrxR6LlvTN02ea5enG0DyL5UUA409iL+FIlWuV8f+cOfIaceW/tsQa49F
	 k2+JGlrBeOuDTKAFlJG+dXckGS6E9qKllGv1lUiwvcOxOHi2PgVOFnk2K6JjT6mOLy
	 8wMBJhYy7rqcZ88dgAjki/503FzqraXQOZ8LtGXr77oJlvx8mQlCJ0bpcLxvSbj8II
	 FNv6UFgUz6gnk7tZPPzx3XToNx6Luyxbilf/EWAJ9azbxmvqxQI0iy3aMf/86QxAUL
	 09CFFAwUkdXQQ==
Date: Sun, 28 Apr 2024 09:55:02 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
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
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>,
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
Subject: Re: [PATCH v6 08/16] mm/execmem, arch: convert remaining overrides
 of module_alloc to execmem
Message-ID: <Zi3yxk_7rMEPp0lT@kernel.org>
References: <20240426082854.7355-1-rppt@kernel.org>
 <20240426082854.7355-9-rppt@kernel.org>
 <CAPhsuW52MYy4Md5O=7XVGvkw395-LB+BiSadxoDdw8CrLw5t7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW52MYy4Md5O=7XVGvkw395-LB+BiSadxoDdw8CrLw5t7A@mail.gmail.com>

On Fri, Apr 26, 2024 at 12:01:34PM -0700, Song Liu wrote:
> On Fri, Apr 26, 2024 at 1:30 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >
> > Extend execmem parameters to accommodate more complex overrides of
> > module_alloc() by architectures.
> >
> > This includes specification of a fallback range required by arm, arm64
> > and powerpc, EXECMEM_MODULE_DATA type required by powerpc, support for
> > allocation of KASAN shadow required by s390 and x86 and support for
> > late initialization of execmem required by arm64.
> >
> > The core implementation of execmem_alloc() takes care of suppressing
> > warnings when the initial allocation fails but there is a fallback range
> > defined.
> >
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > Acked-by: Will Deacon <will@kernel.org>
> 
> nit: We should probably move the logic for ARCH_WANTS_EXECMEM_LATE
> to a separate patch.

This would require to split arm64 and I prefer to keep all these changes
together. 

> Otherwise,
> 
> Acked-by: Song Liu <song@kernel.org>
 
Thanks!

-- 
Sincerely yours,
Mike.

