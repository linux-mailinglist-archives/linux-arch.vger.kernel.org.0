Return-Path: <linux-arch+bounces-7285-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17266977CF5
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 12:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35399B27548
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 10:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9CE1D7E46;
	Fri, 13 Sep 2024 10:08:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729851BD00C;
	Fri, 13 Sep 2024 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222115; cv=none; b=E/gdBG5UzfH8wkkXOHcAhhJMd6IoepOQnAmLXxB/4YsEp9ATQZlRt15snXJ93U8YrNs6bCePBLtpYoT/L0tP3dmFmyoG5WWGFAaarrud7MgmLVSNIQTeP21ruduXeYeaoDao/KUP6v3uqOFBCrnMXtM2HhCOsyh7tnFr3DXjfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222115; c=relaxed/simple;
	bh=e/DBTJD8mKVYtqmc31ZP4xQcSa8VjrlsLeu/n3O5RJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfTwwDiyI81cbRe/EF28CuNN3PvxmszUi6fvqAFXSexhdkxOtK1ZmUa4qOIAhC5sYgAWxtH/zR1rVJ710B6QMb/0K1S/DzuEEEh48BQ0fCpD6tWdsHMar1TV9X3dDzr9nbY3HKuYCfrck1jtboLEpLkZRy0exzXnlByDSDbwka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6077CC4CEC0;
	Fri, 13 Sep 2024 10:08:25 +0000 (UTC)
Date: Fri, 13 Sep 2024 11:08:23 +0100
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
Message-ID: <ZuQPF7Gbcqzq0U6N@arm.com>
References: <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
 <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
 <f23b18c6-1856-4b59-9ba3-59809b425c81@app.fastmail.com>
 <Ztrq8PBLJ3QuFJz7@arm.com>
 <oshwto46wbbgneiayj63umllyozm3c4267rvpszqzaopwnt2l7@6mxl5vydtons>
 <ZuDoExckq21fePoe@ghost>
 <ZuHfp0_tAQhaymdy@arm.com>
 <ZuKHpFB+uWuJe2xm@ghost>
 <ZuLIPZId9aHcAY2j@arm.com>
 <ZuNaD+zAXiAulc0n@ghost>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuNaD+zAXiAulc0n@ghost>

On Thu, Sep 12, 2024 at 02:15:59PM -0700, Charlie Jenkins wrote:
> On Thu, Sep 12, 2024 at 11:53:49AM +0100, Catalin Marinas wrote:
> > On Wed, Sep 11, 2024 at 11:18:12PM -0700, Charlie Jenkins wrote:
> > > Opting-in to the higher address space is reasonable. However, it is not
> > > my preference, because the purpose of this flag is to ensure that
> > > allocations do not exceed 47-bits, so it is a clearer ABI to have the
> > > applications that want this guarantee to be the ones setting the flag,
> > > rather than the applications that want the higher bits setting the flag.
> > 
> > Yes, this would be ideal. Unfortunately those applications don't know
> > they need to set a flag in order to work.
> 
> It's not a regression, the applications never worked (on platforms that
> do not have this default). The 47-bit default would allow applications
> that didn't work to start working at the cost of a non-ideal ABI. That
> doesn't seem like a reasonable tradeoff to me.  If applications want to
> run on new hardware that has different requirements, shouldn't they be
> required to update rather than expect the kernel will solve their
> problems for them?

That's a valid point but it depends on the application and how much you
want to spend updating user-space. OpenJDK is fine, if you need a JIT
you'll have to add support for that architecture anyway. But others are
arch-agnostic, you just recompile to your target. It's not an ABI
problem, more of an API one.

The x86 case (and powerpc/arm64) was different, the 47-bit worked for a
long time before expanding it. So it made a lot of sense to keep the
same default.

Anyway, the prctl() can go both ways, either expanding or limiting the
default address space. So I'd be fine with such interface.

-- 
Catalin

