Return-Path: <linux-arch+bounces-5542-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC6938135
	for <lists+linux-arch@lfdr.de>; Sat, 20 Jul 2024 14:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F418E1C20FAF
	for <lists+linux-arch@lfdr.de>; Sat, 20 Jul 2024 12:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BFD12D766;
	Sat, 20 Jul 2024 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zrgu0SuB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443DE8003F;
	Sat, 20 Jul 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721477558; cv=none; b=rxj8lMCSevGVp9z+b08shslDxfep3FcjExRq6zgU65mU0C6LVvYOmc3R6yeJAySvtu4VLY0ZXbvJneweI+6gJYg5/yDX3afnIjwmAkEuNzOnCuiGPMyxwU+RmLRbuvJ43UOxV0VpyfgdCG75iC/NhwkViWwvdn27PR2p/yC/rIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721477558; c=relaxed/simple;
	bh=fwbjiZOl2jVEvkjLoIR5P7+CK/Chy3OdwVeEOh6ZuS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLlUk3N/RWkq2xMjUbGujV9sW2CIyf52VBV9GpGo38rsDo0NO7p6EwG03AlvYOAk0cuqV3tCkgODRf2wQhm0q/b6i5gtSp3z7AAxGOG4bbK5BD1vyrT03090P5venu1fA/u4wczMOSsCtTROnnKskbhZwXQdVQ1F+m/+nJvHt4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zrgu0SuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09110C2BD10;
	Sat, 20 Jul 2024 12:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721477557;
	bh=fwbjiZOl2jVEvkjLoIR5P7+CK/Chy3OdwVeEOh6ZuS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zrgu0SuBbpILpJBm8U5PR8XGe87tRutuy1WzG7Fmsz4VozP42z8IfYuFPMEiCO6ez
	 djid8auGU5SdaEK5v5L5Kcs3yzuWYeCcZtOzcSL3vqkCL7k8A8lfqmCMd/yVXhjtF8
	 VHhSwiU64gORZkNkAHRI6mECdB/Pr9e9NEqnu9OJaFfY/A4K+TFaCMAZSDIPmjuJXD
	 m9fyDujPC45QYgAsPUjQDHQ+rAx5rEVo8xTvK67ZSw30TE3zGPomSDzPciI4/ZXvh5
	 fjlXjrfuFyfqzBaLPEL/6dkuLr5m5vWTRuYPQWlUZ6Y2t6qDf8GDx6tPL5wdYxPr4T
	 RVe/6SLZl02bQ==
Date: Sat, 20 Jul 2024 15:09:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Zi Yan <ziy@nvidia.com>
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
Subject: Re: [PATCH 14/17] mm: introduce numa_emulation
Message-ID: <Zpuo-BWxvdbun5z7@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
 <20240716111346.3676969-15-rppt@kernel.org>
 <CCB95DEB-6B72-4175-A379-7E60D89114A6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CCB95DEB-6B72-4175-A379-7E60D89114A6@nvidia.com>

On Fri, Jul 19, 2024 at 12:03:11PM -0400, Zi Yan wrote:
> On 16 Jul 2024, at 7:13, Mike Rapoport wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > Move numa_emulation codfrom arch/x86 to mm/numa_emulation.c
> >
> > This code will be later reused by arch_numa.
> >
> > No functional changes.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  arch/x86/Kconfig             |  8 --------
> >  arch/x86/include/asm/numa.h  | 12 ------------
> >  arch/x86/mm/Makefile         |  1 -
> >  arch/x86/mm/numa_internal.h  | 11 -----------
> >  include/linux/numa_memblks.h | 17 +++++++++++++++++
> >  mm/Kconfig                   |  8 ++++++++
> >  mm/Makefile                  |  1 +
> >  mm/numa_emulation.c          |  4 +---
> >  8 files changed, 27 insertions(+), 35 deletions(-)
> 
> After this code move, the document of numa=fake= should be moved from
> Documentation/arch/x86/x86_64/boot-options.rst to
> Documentation/admin-guide/kernel-parameters.txt
> too.

I'll add this as a separate commit.
 
> Something like:
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bc55fb55cd26..ce3659289b5e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4158,6 +4158,18 @@
>                         Disable NUMA, Only set up a single NUMA node
>                         spanning all memory.
> 
> +       numa=fake=<size>[MG]
> +                       If given as a memory unit, fills all system RAM with nodes of
> +                       size interleaved over physical nodes.
> +
> +       numa=fake=<N>
> +                       If given as an integer, fills all system RAM with N fake nodes
> +                       interleaved over physical nodes.
> +
> +       numa=fake=<N>U
> +                       If given as an integer followed by 'U', it will divide each
> +                       physical node into N emulated nodes.
> +
>         numa_balancing= [KNL,ARM64,PPC,RISCV,S390,X86] Enable or disable automatic
>                         NUMA balancing.
>                         Allowed values are enable and disable
> diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
> index 137432d34109..98d4805f0823 100644
> --- a/Documentation/arch/x86/x86_64/boot-options.rst
> +++ b/Documentation/arch/x86/x86_64/boot-options.rst
> @@ -170,18 +170,6 @@ NUMA
>      Don't parse the HMAT table for NUMA setup, or soft-reserved memory
>      partitioning.
> 
> -  numa=fake=<size>[MG]
> -    If given as a memory unit, fills all system RAM with nodes of
> -    size interleaved over physical nodes.
> -
> -  numa=fake=<N>
> -    If given as an integer, fills all system RAM with N fake nodes
> -    interleaved over physical nodes.
> -
> -  numa=fake=<N>U
> -    If given as an integer followed by 'U', it will divide each
> -    physical node into N emulated nodes.
> -
>  ACPI
>  ====
> 
> Best Regards,
> Yan, Zi



-- 
Sincerely yours,
Mike.

