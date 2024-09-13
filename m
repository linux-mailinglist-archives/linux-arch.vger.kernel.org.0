Return-Path: <linux-arch+bounces-7286-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6265977D35
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 12:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C3EB24F52
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 10:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445CC1A76A5;
	Fri, 13 Sep 2024 10:21:19 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED231272A6;
	Fri, 13 Sep 2024 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222879; cv=none; b=PPCsOLG0bGf3SmJzeHGl0EHFKFBP1l0LaIms/MiBCsbwPYRIed7EX0yEcczzyuSPvRAMPQ1nwctIKnvXDSHXQjEJG1QVd9JXz/i/3CMx/ac61dU4SKx1RcgeQc6vP8I/Gso11iVoQQooqXDZQNY8BLM0jP9JWcan+7YnROghbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222879; c=relaxed/simple;
	bh=1FyR0o40y1aNgEI0i4ySUV9pFjo0kEOqPL5Kw87FMt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3AjOOQj5/CUE9922HsNlj+oJJo+n+HCIuSipDYG4QN8nzNFTl9bNTeTMj6JXlmZU5WfNXUjR4Jrnn8mbhCfPt0XbwHERZEvXglYQWhtEhQ1K/qX+HTSthInPhomLXXB+o9Vsf7/y7fVd/dH+XQxSUODV1o6tc2gklwzKAy6AIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE3CC4CEC0;
	Fri, 13 Sep 2024 10:21:08 +0000 (UTC)
Date: Fri, 13 Sep 2024 11:21:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, guoren <guoren@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	shuah <shuah@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Chris Torek <chris.torek@gmail.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-abi-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to
 47 bits
Message-ID: <ZuQSEn3rFVnIrbRH@arm.com>
References: <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
 <f23b18c6-1856-4b59-9ba3-59809b425c81@app.fastmail.com>
 <Ztrq8PBLJ3QuFJz7@arm.com>
 <oshwto46wbbgneiayj63umllyozm3c4267rvpszqzaopwnt2l7@6mxl5vydtons>
 <ZuDoExckq21fePoe@ghost>
 <ZuHfp0_tAQhaymdy@arm.com>
 <ZuKHpFB+uWuJe2xm@ghost>
 <ZuLIPZId9aHcAY2j@arm.com>
 <ZuNaD+zAXiAulc0n@ghost>
 <ZuQPF7Gbcqzq0U6N@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuQPF7Gbcqzq0U6N@arm.com>

On Fri, Sep 13, 2024 at 11:08:23AM +0100, Catalin Marinas wrote:
> On Thu, Sep 12, 2024 at 02:15:59PM -0700, Charlie Jenkins wrote:
> > On Thu, Sep 12, 2024 at 11:53:49AM +0100, Catalin Marinas wrote:
> > > On Wed, Sep 11, 2024 at 11:18:12PM -0700, Charlie Jenkins wrote:
> > > > Opting-in to the higher address space is reasonable. However, it is not
> > > > my preference, because the purpose of this flag is to ensure that
> > > > allocations do not exceed 47-bits, so it is a clearer ABI to have the
> > > > applications that want this guarantee to be the ones setting the flag,
> > > > rather than the applications that want the higher bits setting the flag.
[...]
> Anyway, the prctl() can go both ways, either expanding or limiting the
> default address space. So I'd be fine with such interface.

Ah, I just realised (while reading Lorenzo's reply) that we can't really
restrict the space via a prctl() as we have the main thread stack
already allocated by the kernel before the user code starts. You may
need to limit this stack as well, not just the later heap allocations
(anonymous mmap()).

-- 
Catalin

