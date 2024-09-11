Return-Path: <linux-arch+bounces-7215-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BBE975A40
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 20:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385E61C21E89
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 18:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB4C1B533C;
	Wed, 11 Sep 2024 18:21:40 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEFE19EEC8;
	Wed, 11 Sep 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078900; cv=none; b=ADxxuzWT9kup5+yhfqr9bgy7WdBQdJg57MMADQ11vdPc8Sst1N2lMRHpBJcsn0+JQq55oD6sKqHCdtig5ePBU92NQwMjHv4Lpg9STS+e0grMY25piFwuZCXZYAnJ6ITAmRPKbwOtzguP6lI/QWpqNj1B42kYks1MTlPX61hc/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078900; c=relaxed/simple;
	bh=2cZas4SimbOELK54ILhf2k9/V2LxmAALpH5ubeNMXEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP/hclgiLFbxRWj91GNSHxe6sYCCLMux96HnYWTDvZ9NcocJKq5MrCWckIlfIN0+rhF6hZS2dNmpTyqSvL0GYdB/cUnozR6jSj1UIKg5oqxS3nCZlLjqPEGY6+EDB0qqzgw+lUkRDPPDYV6pzJKLGTkQBD/HD3VtyscqUWQhlGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB7BC4CEC0;
	Wed, 11 Sep 2024 18:21:30 +0000 (UTC)
Date: Wed, 11 Sep 2024 19:21:27 +0100
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
Message-ID: <ZuHfp0_tAQhaymdy@arm.com>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
 <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
 <f23b18c6-1856-4b59-9ba3-59809b425c81@app.fastmail.com>
 <Ztrq8PBLJ3QuFJz7@arm.com>
 <oshwto46wbbgneiayj63umllyozm3c4267rvpszqzaopwnt2l7@6mxl5vydtons>
 <ZuDoExckq21fePoe@ghost>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuDoExckq21fePoe@ghost>

On Tue, Sep 10, 2024 at 05:45:07PM -0700, Charlie Jenkins wrote:
> On Tue, Sep 10, 2024 at 03:08:14PM -0400, Liam R. Howlett wrote:
> > * Catalin Marinas <catalin.marinas@arm.com> [240906 07:44]:
> > > On Fri, Sep 06, 2024 at 09:55:42AM +0000, Arnd Bergmann wrote:
> > > > On Fri, Sep 6, 2024, at 09:14, Guo Ren wrote:
> > > > > On Fri, Sep 6, 2024 at 3:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > >> It's also unclear to me how we want this flag to interact with
> > > > >> the existing logic in arch_get_mmap_end(), which attempts to
> > > > >> limit the default mapping to a 47-bit address space already.
> > > > >
> > > > > To optimize RISC-V progress, I recommend:
> > > > >
> > > > > Step 1: Approve the patch.
> > > > > Step 2: Update Go and OpenJDK's RISC-V backend to utilize it.
> > > > > Step 3: Wait approximately several iterations for Go & OpenJDK
> > > > > Step 4: Remove the 47-bit constraint in arch_get_mmap_end()

Point 4 is an ABI change. What guarantees that there isn't still
software out there that relies on the old behaviour?

> > > > I really want to first see a plausible explanation about why
> > > > RISC-V can't just implement this using a 47-bit DEFAULT_MAP_WINDOW
> > > > like all the other major architectures (x86, arm64, powerpc64),
> > > 
> > > FWIW arm64 actually limits DEFAULT_MAP_WINDOW to 48-bit in the default
> > > configuration. We end up with a 47-bit with 16K pages but for a
> > > different reason that has to do with LPA2 support (I doubt we need this
> > > for the user mapping but we need to untangle some of the macros there;
> > > that's for a separate discussion).
> > > 
> > > That said, we haven't encountered any user space problems with a 48-bit
> > > DEFAULT_MAP_WINDOW. So I also think RISC-V should follow a similar
> > > approach (47 or 48 bit default limit). Better to have some ABI
> > > consistency between architectures. One can still ask for addresses above
> > > this default limit via mmap().
> > 
> > I think that is best as well.
> > 
> > Can we please just do what x86 and arm64 does?
> 
> I responded to Arnd in the other thread, but I am still not convinced
> that the solution that x86 and arm64 have selected is the best solution.
> The solution of defaulting to 47 bits does allow applications the
> ability to get addresses that are below 47 bits. However, due to
> differences across architectures it doesn't seem possible to have all
> architectures default to the same value. Additionally, this flag will be
> able to help users avoid potential bugs where a hint address is passed
> that causes upper bits of a VA to be used.

The reason we added this limit on arm64 is that we noticed programs
using the top 8 bits of a 64-bit pointer for additional information.
IIRC, it wasn't even openJDK but some JavaScript JIT. We could have
taught those programs of a new flag but since we couldn't tell how many
are out there, it was the safest to default to a smaller limit and opt
in to the higher one. Such opt-in is via mmap() but if you prefer a
prctl() flag, that's fine by me as well (though I think this should be
opt-in to higher addresses rather than opt-out of the higher addresses).

-- 
Catalin

