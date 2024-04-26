Return-Path: <linux-arch+bounces-4028-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205B88B4214
	for <lists+linux-arch@lfdr.de>; Sat, 27 Apr 2024 00:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E84283FC9
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 22:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176F537707;
	Fri, 26 Apr 2024 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zv8HME6W"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E095374CC;
	Fri, 26 Apr 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714169826; cv=none; b=amGqJ1y+GkIRIp474VGblWytt0mREegO+veffeQusw/o8p8Z4k2GNy7VHbfMy6zB+tAsOw9oU0wkJT+Dghz7Finx3hMYuvsJZsniFAjO7Dhn6p6vsGYFthnPHM2XwdZwZb/6GIb5cN3INttDvDd+ILaFdPbIIBlNC1kDvNTvB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714169826; c=relaxed/simple;
	bh=2mPzRah3Wm9xdrDA65IUWBsFdPpbm+E8qeM6+YgkocQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4rnd3EAk7UxJCwSKghagKbCm5P1CoJCGzY+ynpMVqwCrlR/qQv3yN4AWC4+QGzx9J1jswXZAcJynj0oTAaHGC5jv4pFNJeMGght66BSEaKlHNyffK62VVDLnU9ngQCW0U3bfLrI85JiIXxzNM7dy68ZxDpYevh4MdpCpP/4jJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zv8HME6W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cTQ9xerQdOeH4jXMbGtf6cI/Y+VdXzSArGlGz80aHAI=; b=Zv8HME6WgWAowWyjCUeyLO5IYe
	9GvjlhE8hKbAu7zINfW50IO7YqF/KISlrxBvJvIpW/1NtSBxHBP8e1bGCKQWgIg6Zu49N0IXokQx1
	ejexzw/XGdbOekwVMtqdb6v4W/qk9C97w9f+sYd9IkC7gqC5uoJSUH1JKMEv13teK8gpd/uDPxzpZ
	upDMrwC30rkgH2OGFFi22R/M3snVkVRHN8+4FXWSFFmYGruiSFkjuXd5PJCh82iTsEdt7OuWfutIa
	2sabrXg/46pbOGj5UHrMk8kWQruxRwF8WwtxW1F4txOzN8uKgtgEqY/iGEC+uHjpLgVSi2SF33Q91
	UXWXhQKg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0TsG-0000000ECRx-3CkI;
	Fri, 26 Apr 2024 22:16:56 +0000
Date: Fri, 26 Apr 2024 15:16:56 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
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
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>, Song Liu <song@kernel.org>,
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
Subject: Re: [PATCH v6 00/16] mm: jit/text allocator
Message-ID: <Ziwn2Nqrf3PWxVTd@bombadil.infradead.org>
References: <20240426082854.7355-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426082854.7355-1-rppt@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Apr 26, 2024 at 11:28:38AM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Hi,
> 
> The patches are also available in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=execmem/v6
> 
> v6 changes:
> * restore patch "arm64: extend execmem_info for generated code
>   allocations" that disappeared in v5 rebase
> * update execmem initialization so that by default it will be
>   initialized early while late initialization will be an opt-in

I've taken this new iteration again through modules-next so to help get
more testing exposure to this. If we run into conflicts again with mm
we can see if Andrew is willing to take this in through there. However,
it may make sense to only consider up to "mm: introduce execmem_alloc() and
execmem_free()" for v6.10 given we're bound to likely find more issues
and we are already at rc5.

  Luis

