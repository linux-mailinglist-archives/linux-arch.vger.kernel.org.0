Return-Path: <linux-arch+bounces-8081-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E575799CB3C
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 15:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F0B5B25781
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 13:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E931AA7A7;
	Mon, 14 Oct 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMvBZJVO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101C81A76C4;
	Mon, 14 Oct 2024 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911493; cv=none; b=eeSDxrQk8+xnUIpvuq8HzU3azwQnUMgTfDrdPo3SYqPXwfqlqDT81IzPVd/o7BVdsx4JHuKXwhrJaVot0Gqs+ZstH+NxABCTTSrgYa7FnLfD2HK6PVY9Yd/ESKetxgglUMTbXoOOgN6zsM+MzOe0/m2XiGbNh8KQIuc9/14YR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911493; c=relaxed/simple;
	bh=Rj0DDOED5iD2FdGYxYV+4r4tEXYq4n6Xi/0d9QAVLUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv2BjvjRfhADX1K/7e1XCYeM8/kImi6/9tkXEXk90RWuefHEx1UKDuIKqtLoLMJtswZNCFzyyX9AWJ5xlJK6FwhmVYwpsev9aq9ezQwygKULDJGSLuKtF+T1pLtgxNgi25DatM6G0qfaITvVGe7t+ga4lYgeJ6HObxENxVjug6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMvBZJVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D95C4CEC3;
	Mon, 14 Oct 2024 13:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728911492;
	bh=Rj0DDOED5iD2FdGYxYV+4r4tEXYq4n6Xi/0d9QAVLUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMvBZJVOinxsLsrPPXzSxPojzLbDfnzNQ55w0X0QwTjcMMxar0CDAK08E2JThkQpb
	 4cpioov/cqx2XJwdmLwC1BTnXl3vfXvrgA1ETi3RHPPFn/KFa3uZAW+joXD5HEZg+c
	 4U5ok631tPzwPd7hoGyNRL5ynGDynUSOamB6K2RiHfHSi/erCk9kHqPS+1U5lBuMVB
	 r0jU8Sa0yR3rOlG2WDCJ68+YmRHtYreB6qz66TSlQdG0YMQVcdBysszRX2pWrQ1lN4
	 ziJbkceFmXn8rCIwx79sxsDKS6SGBNY9GisCIBFcBwGbEy+4gMh7VJcsFjn3AG+8KF
	 uacBBUphpSFpQ==
Date: Mon, 14 Oct 2024 16:07:40 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
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
Subject: Re: [PATCH v5 7/8] execmem: add support for cache of large ROX pages
Message-ID: <Zw0XnDHbpHDwFDHy@kernel.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-8-rppt@kernel.org>
 <Zwd7GRyBtCwiAv1v@infradead.org>
 <ZwfPPZrxHzQgYfx7@kernel.org>
 <ZwjXz0dz-RldVNx0@infradead.org>
 <ZwuIPZkjX0CfzhjS@kernel.org>
 <ZwyyTetoLX7aXhGg@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwyyTetoLX7aXhGg@infradead.org>

On Sun, Oct 13, 2024 at 10:55:25PM -0700, Christoph Hellwig wrote:
> On Sun, Oct 13, 2024 at 11:43:41AM +0300, Mike Rapoport wrote:
> > > But why?  That's pretty different from our normal style of arch hooks,
> > > and introduces an indirect call in a security sensitive area.
> > 
> > Will change to __weak hook. 
> 
> Isn't the callback required when using the large ROX page?  I.e.
> shouldn't it be an unconditional callback and not a weak override?

I'll add a Kconfig option to ensure that an architecture that wants to use
large ROX pages has explicit callback for that.

-- 
Sincerely yours,
Mike.

