Return-Path: <linux-arch+bounces-8238-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32E9A107A
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 19:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7771F230EC
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7398208208;
	Wed, 16 Oct 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4Y5pPBe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18D3188580;
	Wed, 16 Oct 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099272; cv=none; b=e5LGcAC1NLbMqWv2o9nVIfWNUoO3wW2sBPsLXFoG77BC5RS6o230cZLcYio1NkNCGkFzeOUMt5IhovWrNL+Db85id8c3pp8h1RCLOrmA1vmwhdcJZRsi31aZWXm9np+6qUo+IDcB2w7dKbtNCoeG0A7scCcjnMOwunMneLEsQ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099272; c=relaxed/simple;
	bh=pE67RiyjvIOKtyfw/S0Zs4qanipSNG01XM8veQFduUg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG9YSijjlSYBoVSVG8vDp6A09v12ImH1ftelLudQR9kFxdiCnJdCgcGczEKu3OEIhDbVqmWFMhFsvvf2fu8waqZcfOsCY4H91cwyKMcwVOoVja4OaCpusovWd7B1mkzc50OGufndOyB7gWCTeE2zsf+Y0ZPpDyM/OAQL0GI+qlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4Y5pPBe; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so940301fa.1;
        Wed, 16 Oct 2024 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729099269; x=1729704069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1GP0B75uZXvlMdPMs8sxWFWqOcAn6bbZYSntM7zvNeg=;
        b=F4Y5pPBe9APpbwYadbXbku8Zf1SvfCcTmpFqH2tcxBpfRem46aWpcnOIjcpfdTVrN0
         hzmZ2TuPFtm8hWNkxzARRhEZRw5FtvjDv+uj9w4MQpH6aSvnuRIwetc2fvow8d/aLRBN
         Hg6xpCrgjG/b8Ogohu74shFj/p9Lnb3B9GwgXT/GHzIj0CLZEkxLpeuUbqQ5RL1ZO2I8
         m+3qnWn+4zPi14XbOeGsEd/XTefl6wZEm4bPAAak2lQrZP+1G1L33lw49JDPP89Ll2gS
         9JPZm/U795oK278WSn+m6iBXipACNaPO3j8wL8HiS0xAcMOTtov05U6PyendIRFHuxj5
         /1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729099269; x=1729704069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GP0B75uZXvlMdPMs8sxWFWqOcAn6bbZYSntM7zvNeg=;
        b=p9XjJm6t+Ryl7OFH/cCZcrEQm41BDGmWT8ZMsspzarHEPuBCpL1Glv2xSD1v8skAwo
         otVEcuJ7N7l9CjAZlQUPm31TQhgY0YP7E1baUYsFzzv6QtJ81jngptHq1LA20KjxYK8P
         ex9dPxT5M0/CeKtCLW7MHsLmmMdDIi3OyPCOHlimVfzgh2YlhnPhWGI0bZmZOZiC/DJ/
         to3WgckRfemCU6uy08AvGyfoQcYvBhmFtfIFwTAPbpDeKhUYDCuUNeqUZFxxnEzY2iaj
         Y6zn0LDtdHXKLbB/8tiwzrcnBltxzrjksarZtaHA6n5WLHAjgD919dnXiNRUv3YLb8Ec
         OYcw==
X-Forwarded-Encrypted: i=1; AJvYcCU0+az4LC9NsanuNVaHlZCitnEN73vQE8FTkKJi/QgedsM2G49plalUhcKwVGWsLCK2Sd3VMUaK/VEyyA32@vger.kernel.org, AJvYcCUDu1z5n9G7nGSWnIZppTG6y5mXYu4LexWH3f4xPYcFBiClXWyTHxkSxcLcfWvypfNEHQ3vmk5KUhjuj8v/Ww==@vger.kernel.org, AJvYcCVAQXrQL/YABB+w06V3V7wLB0Hqy0g9v+P3sek8vWNLeLfk+wJsm942CdsockYa5N9B+xQDF1UVRnkYsQ==@vger.kernel.org, AJvYcCVfbQO3y3Kokwx81IH+QwekX1tCHtnXtohJaKS7ILW0zobeyX6PcmZwh6NmEFcRJOahFKjUANfrpvJt38ANTLGjM3P7@vger.kernel.org, AJvYcCVh2due35+hEMlw83F2XsUgZyrfNOFnrXkHuZ6XXgPJJqBBqPYHPHUoK5qBteJitfHBx1u7FlYkQpTI3m8=@vger.kernel.org, AJvYcCVoOxQkCwWhWLqmH3Y9vLX+jTobEXcpab3cLcCcSeugOdv0lCpUsTfwrR839aj5XghGPGs+A+WhzgEO0+a6MA==@vger.kernel.org, AJvYcCW1GcjJUk9VdB7ffqyUUYx3Cm6xbaOl+AttCo9/Z7BuhqF2glUDANNL5kA3Abjjw021zw+NpK2JpzDsrA==@vger.kernel.org, AJvYcCWi2Y8h4TfBsjD9Ow2LIYQSQ9ifrixYlEZ+H59wt7d9NEa9o/eWTFeGSsvZhR2gBg/mx2E=@vger.kernel.org, AJvYcCX6+3x/O5DqvAdjhc2WoHNHQPZkjiUH8SdXIuZyq+67E/NWl6bXo7pFoMbycpJtCUDwjQOGBKOo5BZQeAIC@vger.kernel.org, AJvYcCXSSS7c
 R8tZjUtHjlQDBL+VhMqDq+WKoGVkj8MjcrX8wxCatb+9diPm0DBBPoS2vq12PJU1TysjGogFNg==@vger.kernel.org, AJvYcCXU2RhPV/PiBSp29rYchoRB20kVZ/U1VnIsA5GZqVYG2l8ix0kU9lFokTuwVLI/sW5WmCeXZ+jIGUsLJlL6770=@vger.kernel.org, AJvYcCXjPZqekd9b9imA7W1+YoYaO2XyAu1PEIMcYkV1qerhaHcDoMor6oY1dGkL2rjOnDWjRj7UoHA6NGQMcg==@vger.kernel.org, AJvYcCXs50Ra7As3Fl/iXT9krRlcBnjXFpoQJ/5vo3Ahi+JIRN7YXJI7NCRcz5V/jbMptEETMF7gSmuHj+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xoNQAol8JL6PXC1Fsh/rXK5LlLpSXgL607GcYQXDVvITp3+i
	vP8dNqdtp6bZVRyFE/Ex+WV+Gg0aN/NBxbWUTaXarLj7k0t7LF5C
X-Google-Smtp-Source: AGHT+IE3BOIzolDg/ircoXlrXALD+U8X6mjirKNd/VoSdJ8ZQKv3Aj0k5T5yFcByNzOByKxATFiOdw==
X-Received: by 2002:a05:6512:402a:b0:539:f619:b458 with SMTP id 2adb3069b0e04-539f619b4cbmr6540423e87.22.1729099268652;
        Wed, 16 Oct 2024 10:21:08 -0700 (PDT)
Received: from pc636 (host-95-203-1-67.mobileonline.telia.com. [95.203.1.67])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffa8a5fsm512819e87.26.2024.10.16.10.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 10:21:08 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Oct 2024 19:21:02 +0200
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
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
	Suren Baghdasaryan <surenb@google.com>,
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
	sparclinux@vger.kernel.org, x86@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 2/8] mm: vmalloc: don't account for number of nodes
 for HUGE_VMAP allocations
Message-ID: <Zw_1_ln440eHTjGt@pc636>
References: <20241016122424.1655560-1-rppt@kernel.org>
 <20241016122424.1655560-3-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016122424.1655560-3-rppt@kernel.org>

On Wed, Oct 16, 2024 at 03:24:18PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> vmalloc allocations with VM_ALLOW_HUGE_VMAP that do not explicitly
> specify node ID will use huge pages only if size_per_node is larger than
> a huge page.
> Still the actual allocated memory is not distributed between nodes and
> there is no advantage in such approach.
> On the contrary, BPF allocates SZ_2M * num_possible_nodes() for each
> new bpf_prog_pack, while it could do with a single huge page per pack.
> 
> Don't account for number of nodes for VM_ALLOW_HUGE_VMAP with
> NUMA_NO_NODE and use huge pages whenever the requested allocation size
> is larger than a huge page.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/vmalloc.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 634162271c00..86b2344d7461 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3763,8 +3763,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  	}
>  
>  	if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
> -		unsigned long size_per_node;
> -
>  		/*
>  		 * Try huge pages. Only try for PAGE_KERNEL allocations,
>  		 * others like modules don't yet expect huge pages in
> @@ -3772,13 +3770,10 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  		 * supporting them.
>  		 */
>  
> -		size_per_node = size;
> -		if (node == NUMA_NO_NODE)
> -			size_per_node /= num_online_nodes();
> -		if (arch_vmap_pmd_supported(prot) && size_per_node >= PMD_SIZE)
> +		if (arch_vmap_pmd_supported(prot) && size >= PMD_SIZE)
>  			shift = PMD_SHIFT;
>  		else
> -			shift = arch_vmap_pte_supported_shift(size_per_node);
> +			shift = arch_vmap_pte_supported_shift(size);
>  
>  		align = max(real_align, 1UL << shift);
>  		size = ALIGN(real_size, 1UL << shift);
>
Looking at this place, i see that an overwriting a "size" approach seems as
something that is a bit hard to follow. Below we have following code:

<snip>
...
again:
	area = __get_vm_area_node(real_size, align, shift, VM_ALLOC |
	  VM_UNINITIALIZED | vm_flags, start, end, node,
	  gfp_mask, caller);
...
<snip>

where we pass a "real_size", whereas there is only one place in the
__vmalloc_node_range_noprof() function where a "size" is used. It is
in the end of function:

<snip>
...
	size = PAGE_ALIGN(size);
	if (!(vm_flags & VM_DEFER_KMEMLEAK))
		kmemleak_vmalloc(area, size, gfp_mask);

	return area->addr;
<snip>

As fro this patch:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

