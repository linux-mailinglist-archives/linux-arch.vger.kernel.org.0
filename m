Return-Path: <linux-arch+bounces-5640-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D9C93D081
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4FC2833CC
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2B7178371;
	Fri, 26 Jul 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erbBnHVt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1B41A286;
	Fri, 26 Jul 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721986831; cv=none; b=cSKIVcGjEuOI9NDHxWdnPFSYJGadddiqw0Bw/0X10KKNQXsK+T586XWkmjViHLQBi75JLWTcx9H8jD/kPQa1zuF3d+av7WhxwGg7eOxlMiDVNHR1rTzuAL+3Qb/YC/yfXZCT/5G/nII3OjHukfkaWkPJm2ERsBsTgwytbSaoGUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721986831; c=relaxed/simple;
	bh=/W5kbKWSvcsVRYIH6lNhUURaeOalcNxprGj7xwqXc8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBFRF6w5Vc95asL3rDHbR9IyvGpyJW8RyLF4m8jvJfeiZ9TbNfkxFXhNTkEgyb2EfbKzOkhe8itvQ8yDnIc34LaRSjJTPpRK1uaaclvpze6DmYhMZ1ytM4j6x22UoK01mD6eCTSao2XH4fzP6WxwehwuZW3EQQVd+ba9Yh5W9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erbBnHVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9535FC32782;
	Fri, 26 Jul 2024 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721986830;
	bh=/W5kbKWSvcsVRYIH6lNhUURaeOalcNxprGj7xwqXc8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=erbBnHVtheMUAGs7sb6st1OpVR9FaIVHYj78yec90OKFphlkSZV5k/wAOzf9v7bHw
	 qD/B4sk/oLODwsgv3p0XiErsiTqRDrNBJUfunPPt2ly/fcLhz146SfXfrJeznvLkZe
	 U5MzHL6oELYwecQ5CE2FRGA7zc5ak6Om4kOHFE+xDor4Bpwaxj+6BMtxs9zpKRb0zj
	 t0frO2fOt1mK8tuZJlZLn78/gGZpvARM3U+4DMaFSKK7j8fCZBwVSU2h9+v0uuhWmf
	 doJp2N540bOFVoqeMi8DgOk/gCs4xM/TGYVOkNqWaGGBNobmAGDB5q2iYuCtHTHaiN
	 kQwqqR1cv6trg==
Date: Fri, 26 Jul 2024 12:40:03 +0300
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
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, nvdimm@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 00/25] mm: introduce numa_memblks
Message-ID: <ZqNu8zwjhiTkbpIB@kernel.org>
References: <20240723064156.4009477-1-rppt@kernel.org>
 <1D474894-F8AC-427B-8F90-5A6808E77CC5@nvidia.com>
 <6336C276-113E-4D93-A09E-13420A6438D8@nvidia.com>
 <231F6DF6-96C8-4149-92CF-4FC03C9FE357@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <231F6DF6-96C8-4149-92CF-4FC03C9FE357@nvidia.com>

On Wed, Jul 24, 2024 at 10:48:42PM -0400, Zi Yan wrote:
> On 24 Jul 2024, at 20:35, Zi Yan wrote:
> > On 24 Jul 2024, at 18:44, Zi Yan wrote:
> >>
> >> Hi,
> >>
> >> I have tested this series on both x86_64 and arm64. It works fine on x86_64.
> >> All numa=fake= options work as they did before the series.
> >>
> >> But I am not able to boot the kernel (no printout at all) on arm64 VM
> >> (Mac mini M1 VMWare). By git bisecting, arch_numa: switch over to numa_memblks
> >> is the first patch causing the boot failure. I see the warning:
> >>
> >> WARNING: modpost: vmlinux: section mismatch in reference: numa_add_cpu+0x1c (section: .text) -> early_cpu_to_node (section: .init.text)
> >>
> >> I am not sure if it is red herring or not, since changing early_cpu_to_node
> >> to cpu_to_node in numa_add_cpu() from mm/numa_emulation.c did get rid of the
> >> warning, but the system still failed to boot.
> >>
> >> Please note that you need binutils 2.40 to build the arm64 kernel, since there
> >> is a bug(https://sourceware.org/bugzilla/show_bug.cgi?id=31924) in 2.42 preventing
> >> arm64 kernel from booting as well.
> >>
> >> My config is attached.
> >
> > I get more info after adding earlycon to the boot option.
> > pgdat is NULL, causing issues when free_area_init_node() is dereferencing
> > it at first WARN_ON.
> >
> > FYI, my build is this series on top of v6.10 instead of the base commit,
> > where the series applies cleanly on top v6.10.
> 
> OK, the issue comes from that my arm64 VM has no ACPI but x86_64 VM has it,
> thus on arm64 VM numa_init(arch_acpi_numa_ini) failed in arch_numa_init()
> and the code falls back to numa_init(dummy_numa_init). In dummy_numa_init(),
> before patch 23 "arch_numa: switch over to numa_memblks", numa_add_memblk()
> from drivers/base/arch_numa.c is called on arm64, which unconditionally
> set 0 to numa_nodes_parsed. This is missing in the x86 version of
> numa_add_memblk(), which is now used by all arch. By adding the patch
> below, my arm64 kernel boots in the VM.
> 
> 
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index 806550239d08..354f15b8d9b7 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -279,6 +279,7 @@ static int __init dummy_numa_init(void)
>                 pr_err("NUMA init failed\n");
>                 return ret;
>         }
> +       node_set(0, numa_nodes_parsed);
> 
>         numa_off = true;
>         return 0;
> 
> 
> Feel free to add
> 
> Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
> 
> after you incorporate the fix.

Thanks a lot for testing, debugging and fixing! 
> 
> --
> Best Regards,
> Yan, Zi



-- 
Sincerely yours,
Mike.

