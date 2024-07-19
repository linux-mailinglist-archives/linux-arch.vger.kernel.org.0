Return-Path: <linux-arch+bounces-5513-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A125937365
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 07:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C94281653
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 05:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F583D0C5;
	Fri, 19 Jul 2024 05:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRFthwaJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A678A35;
	Fri, 19 Jul 2024 05:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368713; cv=none; b=XP3ID2nPSH2aLtgUDGiUiaUwOhPe0Jd6W+INdwDqAA4FOBlIs05+6Rl2aXjjhAXN9fgFp3u775emQ9VQWL5Dide918X1FfzW0ZVL5AMFkilCiClxhOVgW7k85u6SJJ9cgHbaOS4ZkO58bzSYqWxo/0OcX8Qs5pLvkxdTnGEcGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368713; c=relaxed/simple;
	bh=UQznUIdoHoSsnmJ9kRgND1mWM0Wr77U9QEYTciDIo28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZguJpHnX8fe8y7f/Qsn9brJu52qV8u2yaL50sznIj20S6Yvwl+AtUlL6yj9kgVEg6SoJT1sky3xSw9eq2410xHQaeJPFn7M4gpzEY2uFDb61IjzPKpNRp7mIeuz+sljKXjAka1KP0IneJmvv5NwCqdey6kKs3u+WMVmTpbFqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRFthwaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BCBC32782;
	Fri, 19 Jul 2024 05:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721368712;
	bh=UQznUIdoHoSsnmJ9kRgND1mWM0Wr77U9QEYTciDIo28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YRFthwaJnqijAayKx7Nr5Wz+cg7XtkKFYmu9Y+J8JOSZNkKtcyO0oPxjnmHQb5MAT
	 +SzEDWjweXYNk8r/wQxrhgFgyaJzF2zS7ds36V+HfUkLd39/F0Jm+9Xel/QgVHiXrN
	 u8dtVDBEcxTLfuJ09zphSq9TFj0SodZS5yh/iSTnCqMAmk0l0hgKZ81y9JEQyQLhxw
	 sglzaaOKdzC/1FVu4YR8/PhMdvuoqPLRhEF6pZyxCI7bcLrHj8JLnnhhcpRX6xDDkZ
	 xqyY0lHVXYowiKXrRiLwZxIMlHLP+cfRIEOh0c7+hIF8r+/xRAu73hBTRRXaUjI764
	 7OCKjCrNEM7Gw==
Date: Fri, 19 Jul 2024 08:55:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 13/17] mm: move numa_distance and related code from x86
 to numa_memblks
Message-ID: <Zpn_z_NgzTl_db5t@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
 <20240716111346.3676969-14-rppt@kernel.org>
 <8b402e92-d874-4b30-9108-f521bd20d36c@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b402e92-d874-4b30-9108-f521bd20d36c@sifive.com>

On Thu, Jul 18, 2024 at 04:46:17PM -0500, Samuel Holland wrote:
> On 2024-07-16 6:13 AM, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Move code dealing with numa_distance array from arch/x86 to
> > mm/numa_memblks.c
> > 
> > This code will be later reused by arch_numa.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  arch/x86/mm/numa.c                   | 101 ---------------------------
> >  arch/x86/mm/numa_internal.h          |   2 -
> >  include/linux/numa_memblks.h         |   4 ++
> >  {arch/x86/mm => mm}/numa_emulation.c |   0
> >  mm/numa_memblks.c                    | 101 +++++++++++++++++++++++++++
> >  5 files changed, 105 insertions(+), 103 deletions(-)
> >  rename {arch/x86/mm => mm}/numa_emulation.c (100%)
> 
> The numa_emulation.c rename looks like it should be part of the next commit, not
> this one.

Right, thanks!

-- 
Sincerely yours,
Mike.

