Return-Path: <linux-arch+bounces-4517-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8678CE205
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 10:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21EE1F2263F
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD33885C69;
	Fri, 24 May 2024 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTSmyPEV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46FA82872;
	Fri, 24 May 2024 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538222; cv=none; b=tfqCgNAaf/LsG3lAte9phgkdmQzpk+x317guJD24F/F0BR6C+qbq3nhAdYiklGa9eYrJjIdtT8ckDCpGGZQKHMYjyk/m6JAO6NI6dXlrzfQAPHmm963yE6ZT2UurXwuxiQAcfk8ywpE44lqaNKTfON7YO4GxJSfy6ThEQCAmgTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538222; c=relaxed/simple;
	bh=KzZifyFunKdMl7mZy15PbBQXyBPtR28fDlzXAEBwRZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drSyg7VUEAFCKNkaY4Lhr3KL4cf5xFk5/RpTfpKdliupFJZr5wGJqOjpUCM12Jnk+t+ZP3ThQ7vlas83//B9O/iU59YWyYGq9ZjdWR2NIVp/mIYN3TXTzhelSn2SIoBMYyOVfNyJSDPBE+5Y4Sh7P5cF/LNKf4n07uy0jrpPH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTSmyPEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC38C2BBFC;
	Fri, 24 May 2024 08:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716538222;
	bh=KzZifyFunKdMl7mZy15PbBQXyBPtR28fDlzXAEBwRZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTSmyPEVPbnVYsbqpii0XYle0nGrfAI9KJYQ9QQtMO99GDFwrEnqvqqW0CTH4UlBj
	 tQBgvLjOBwnUJuGZxOGDTsX4L6RMbys6psDv8PUNuOdm/25RCKhlFkIYOfTrfRizEL
	 zrfZAyySbpZgi58QD2ndnKtlklKpcj+BMsW0AxWTTYZlCxENaRkfJYFJS6v1kNMR14
	 ga0qGrTXnaPwfBus+NEwyvGZfqJydhu3K7zoinPVPT9eMD//g3rIYeb7wY9RoPP5Ms
	 FDn/3P7s7/hz1wCZKv6/dHdxX1x3mYjBNAZq5sA38FYcjenIX4A18VMWI60BLNmiRp
	 OSh2FV9ePUR3g==
Date: Fri, 24 May 2024 11:08:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, arnd@arndb.de,
	anshuman.khandual@arm.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [Patch v2] mm/memblock: discard .text/.data if
 CONFIG_ARCH_KEEP_MEMBLOCK not set
Message-ID: <ZlBK_PZ2ZivCFXCv@kernel.org>
References: <20240510020422.8038-1-richard.weiyang@gmail.com>
 <ZkxLkK7vgzzaEvyw@kernel.org>
 <20240524014656.odw4yuvhgbu4dgf7@master>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524014656.odw4yuvhgbu4dgf7@master>

On Fri, May 24, 2024 at 01:46:56AM +0000, Wei Yang wrote:
> On Tue, May 21, 2024 at 10:21:52AM +0300, Mike Rapoport wrote:
> >Hi,
> >
> >On Fri, May 10, 2024 at 02:04:22AM +0000, Wei Yang wrote:
> >> When CONFIG_ARCH_KEEP_MEMBLOCK not set, we expect to discard related
> >> code and data. But it doesn't until CONFIG_MEMORY_HOTPLUG not set
> >> neither.
> >> 
> >> This patch puts memblock's .text/.data into its own section, so that it
> >> only depends on CONFIG_ARCH_KEEP_MEMBLOCK to discard related code and
> >> data.
> >> 
> >> After this, from the log message in mem_init_print_info(), init size
> >> increase from 2420K to 2432K on arch x86.
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >> 
> >> ---
> >> v2: fix orphan section for powerpc
> >> ---
> >>  arch/powerpc/kernel/vmlinux.lds.S |  1 +
> >>  include/asm-generic/vmlinux.lds.h | 14 +++++++++++++-
> >>  include/linux/memblock.h          |  8 ++++----
> >>  3 files changed, 18 insertions(+), 5 deletions(-)
> >>  
> >> +#define __init_memblock        __section(".mbinit.text") __cold notrace \
> >> +						  __latent_entropy
> >> +#define __initdata_memblock    __section(".mbinit.data")
> >> +
> >
> >The new .mbinit.* sections should be added to scripts/mod/modpost.c
> >alongside .meminit.* sections and then I expect modpost to report a bunch
> >of section mismatches because many memblock functions are called on memory
> >hotplug even on architectures that don't select ARCH_KEEP_MEMBLOCK.
> >
> 
> I tried to add some code in modpost.c, "make all" looks good.
> 
> May I ask how can I trigger the "mismatch" warning?
> 
> BTW, if ARCH_KEEP_MEMBLOCK unset, we would discard memblock meta-data. If
> hotplug would call memblock function, it would be dangerous?
> 
> The additional code I used is like below.
> 
> ---
>  scripts/mod/modpost.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 937294ff164f..c837e2882904 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -777,14 +777,14 @@ static void check_section(const char *modname, struct elf_info *elf,
>  
>  #define ALL_INIT_DATA_SECTIONS \
>  	".init.setup", ".init.rodata", ".meminit.rodata", \
> -	".init.data", ".meminit.data"
> +	".init.data", ".meminit.data", "mbinit.data"

should be ".mbinit.data"
>  
>  #define ALL_PCI_INIT_SECTIONS	\
>  	".pci_fixup_early", ".pci_fixup_header", ".pci_fixup_final", \
>  	".pci_fixup_enable", ".pci_fixup_resume", \
>  	".pci_fixup_resume_early", ".pci_fixup_suspend"
>  
> -#define ALL_XXXINIT_SECTIONS ".meminit.*"
> +#define ALL_XXXINIT_SECTIONS ".meminit.*", "mbinit.*"

and ".mbinit.*"

But regardless of typos, when ARCH_KEEP_MEMBLOCK=n the .mbinit is equivalent
to .init and it should not be referenced from .meminit, so I don't think
adding it here is correct.

If I simply alias __init_memblock to __init then with
CONFIG_MEMORY_HOTPLUG=y I get

WARNING: modpost: vmlinux: section mismatch in reference: early_pfn_to_nid+0x42 (section: .meminit.text) -> memblock_search_pfn_nid (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: memmap_init_range+0x142 (section: .meminit.text) -> mirrored_kernelcore (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: memmap_init_range+0x1e1 (section: .meminit.text) -> memblock (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: memmap_init_range+0x1e8 (section: .meminit.text) -> memblock (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: sparse_buffer_alloc+0x3b (section: .meminit.text) -> memblock_free (section: .init.text)

>  #define ALL_INIT_SECTIONS INIT_SECTIONS, ALL_XXXINIT_SECTIONS
>  #define ALL_EXIT_SECTIONS ".exit.*"
> @@ -799,7 +799,7 @@ static void check_section(const char *modname, struct elf_info *elf,
>  
>  #define INIT_SECTIONS      ".init.*"
>  
> -#define ALL_TEXT_SECTIONS  ".init.text", ".meminit.text", ".exit.text", \
> +#define ALL_TEXT_SECTIONS  ".init.text", ".meminit.text", ".mbinit.text", ".exit.text", \
>  		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
>  
>  enum mismatch {
> 
> -- 
> Wei Yang
> Help you, Help me
> 

-- 
Sincerely yours,
Mike.

