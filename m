Return-Path: <linux-arch+bounces-3605-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA3A8A1FA9
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 21:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8DB1C22B5A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 19:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA3D17BA5;
	Thu, 11 Apr 2024 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LW4B+RA/"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E14179AB;
	Thu, 11 Apr 2024 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864734; cv=none; b=eMYMe8p8esrOaDfeQjvfasmmELdh2rw3euMQiVNqdNwWNvCa/I7E8K5pMAf3uDTVwxtwi7fBETM9Uju/VEfGeVAH4Keob9TkcTmcH3Y1Lf8XdMqXM5EhkDlD+/Nei12RjMF2Um7BOmH6uVZyD2P6df03AZncTXICx0VEN5Nj2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864734; c=relaxed/simple;
	bh=v/kg2zBgjouqNayyfTZ1gQRpaCtsWdHXcAeRYRi8jSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/C0StsHFU9gn6cbnUAiuarWHeNJKZHzZh0nh5/YlN/wuYIJaD0LreWV64zvda5Cp6RcZNbWVKl7kdEATl7Y/cqTC8udR0Mh6ONJkAOQmyEnH3+1Jxv1UCPEqV1sWl+Ui4cxqwfwDmp1uUvG7UiYuWqrPIqlY6J9sYVRCwuaSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LW4B+RA/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mF3LgyonzoPiLPggKtlEjI/RAYj7UYB9rpei5Ud65w4=; b=LW4B+RA/mLBikoIkjpMDpYn9oP
	u2YAB5xmL1D4XkoUv1Ve9gQEIQ0TAvvtWmZldKRQqHURClp6PnA6zwtnlpDI5YcucnvadEV7WunWR
	b/1Iq8vVt1oArh5tcqicc9Z63IyQeyuWCw9WE0oR/Ok86B2YT082t2bjkyb27tRD8lbretuG1UYwR
	NEF+joRqo6rwX3adbENZeQaNQlnWdEzjPCwZa5i/q7E286YXArA3Jy82X/wR+QDg69SZaiPqn91EB
	VhUQK10NXrl7tuNE0LjnU4cJYOYOYsXm/2EOsZ/Hcy9WT5WMB3gVzJ0tiJjB3LXt+twOTdZqPWpdj
	bhUwFHXw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv0MS-0000000DwB9-3meA;
	Thu, 11 Apr 2024 19:45:28 +0000
Date: Thu, 11 Apr 2024 12:45:28 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Mike Rapoport <rppt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
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
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, netdev@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 00/15] mm: jit/text allocator
Message-ID: <Zhg92CoCZmxC5ORi@bombadil.infradead.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411160051.2093261-1-rppt@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Apr 11, 2024 at 07:00:36PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Hi,
> 
> Since v3 I looked into making execmem more of an utility toolbox, as we
> discussed at LPC with Mark Rutland, but it was getting more hairier than
> having a struct describing architecture constraints and a type identifying
> the consumer of execmem.
> 
> And I do think that having the description of architecture constraints for
> allocations of executable memory in a single place is better that having it
> spread all over the place.
> 
> The patches available via git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=execmem/v4

I've taken the first 5 patches through modules-next for now to get early
exposure to testing. Of those I just had minor nit feedback on the 5th,
but the rest look good.

Let's wait for review for the rest of the patches 6-15.

  Luis

