Return-Path: <linux-arch+bounces-9175-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F0F9DADE0
	for <lists+linux-arch@lfdr.de>; Wed, 27 Nov 2024 20:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0780E165139
	for <lists+linux-arch@lfdr.de>; Wed, 27 Nov 2024 19:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7136E20110F;
	Wed, 27 Nov 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2BtrIqN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164CA6A8D2;
	Wed, 27 Nov 2024 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735931; cv=none; b=t2gIUWEqmL7qf4ygF/FKPkEeNTyrx+ZLK9c5UtKb2iBmASreoq2lp/gLjUIT3nCU/ieC13j8RCidRw1mZRJGfvydtaXLM4bfpOH6cL8dtY3EB4oCdqxEma59EZz5WaeuXKcwqrhUJcwVYMAdk1U4YpANYyhZzd6B7i5UG3jqLck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735931; c=relaxed/simple;
	bh=xrciW+EMhZ5UEofbJw9NwB4YNk6WJ7ZsUg3ugalAKtY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGydcpK62W4yA/BawQoJzSI8k5mru11GP6tVcjQiqEre9YwwCvgb4q05Lv7rmHOeb39M2OArWZoAzxTFIgP+FuOf18ToGWudbNlHuTxmBNsXSbDp0mdl1XFP4zvaEX+zKsRuSD+BB7Glk0+CbMg/qvVVr3g3FquYGbozBK3rp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2BtrIqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD69C4CED2;
	Wed, 27 Nov 2024 19:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732735930;
	bh=xrciW+EMhZ5UEofbJw9NwB4YNk6WJ7ZsUg3ugalAKtY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X2BtrIqNGPOvV+49M5YnEnvMfq90m+ylhD7PzWNtlQWXRcWLiIC9o7ibIu7Z+6NCF
	 kcXzlV4NXbHYexopnI8wyMqZtXl1aARG1Kv+1kHo2QdWtEH8r51A6kx0Z+b8YMEuGQ
	 KkVWB5pfPFETZ3jygkOvTt1oTUJ7ox8ovqX6d1E+iA+5p2Dg3oRun7qGKNbz7lmsz9
	 P2yGA8boYanYTYFxQR6QsePoSp98SjRizDnHD/Y6HoJ2E4HX1u+AiXq7pnGqhQjajY
	 UFL0t9n5dlc0Yh9Rql7BGoHCScG0i7PhlQ+71XDRGrapyLXfaRB16QrJ7c3W0qJT2C
	 zsuLVCEMA8n/A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tGNlf-00GLsr-Kw;
	Wed, 27 Nov 2024 19:32:07 +0000
Date: Wed, 27 Nov 2024 19:32:06 +0000
Message-ID: <867c8ov5ft.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
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
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	nvdimm@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 24/26] arch_numa: switch over to numa_memblks
In-Reply-To: <20240807064110.1003856-25-rppt@kernel.org>
References: <20240807064110.1003856-1-rppt@kernel.org>
	<20240807064110.1003856-25-rppt@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: rppt@kernel.org, linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, andreas@gaisler.com, akpm@linux-foundation.org, arnd@arndb.de, bp@alien8.de, catalin.marinas@arm.com, christophe.leroy@csgroup.eu, dan.j.williams@intel.com, dave.hansen@linux.intel.com, david@redhat.com, davem@davemloft.net, dave@stgolabs.net, gregkh@linuxfoundation.org, hca@linux.ibm.com, chenhuacai@kernel.org, mingo@redhat.com, jiaxun.yang@flygoat.com, glaubitz@physik.fu-berlin.de, jonathan.cameron@huawei.com, corbet@lwn.net, mpe@ellerman.id.au, palmer@dabbelt.com, rafael@kernel.org, robh@kernel.org, samuel.holland@sifive.com, tsbogend@alpha.franken.de, tglx@linutronix.de, gor@linux.ibm.com, will@kernel.org, ziy@nvidia.com, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-s390@vger.k
 ernel.org, linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, nvdimm@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org, Jonathan.Cameron@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Hi Mike,

Sorry for reviving a rather old thread.

On Wed, 07 Aug 2024 07:41:08 +0100,
Mike Rapoport <rppt@kernel.org> wrote:
> 
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Until now arch_numa was directly translating firmware NUMA information
> to memblock.
> 
> Using numa_memblks as an intermediate step has a few advantages:
> * alignment with more battle tested x86 implementation
> * availability of NUMA emulation
> * maintaining node information for not yet populated memory
> 
> Adjust a few places in numa_memblks to compile with 32-bit phys_addr_t
> and replace current functionality related to numa_add_memblk() and
> __node_distance() in arch_numa with the implementation based on
> numa_memblks and add functions required by numa_emulation.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> [arm64 + CXL via QEMU]
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/Kconfig       |   1 +
>  drivers/base/arch_numa.c   | 201 +++++++++++--------------------------
>  include/asm-generic/numa.h |   6 +-
>  mm/numa_memblks.c          |  17 ++--
>  4 files changed, 75 insertions(+), 150 deletions(-)
>

[...]

>  static int __init numa_register_nodes(void)
>  {
>  	int nid;
> -	struct memblock_region *mblk;
> -
> -	/* Check that valid nid is set to memblks */
> -	for_each_mem_region(mblk) {
> -		int mblk_nid = memblock_get_region_node(mblk);
> -		phys_addr_t start = mblk->base;
> -		phys_addr_t end = mblk->base + mblk->size - 1;
> -
> -		if (mblk_nid == NUMA_NO_NODE || mblk_nid >= MAX_NUMNODES) {
> -			pr_warn("Warning: invalid memblk node %d [mem %pap-%pap]\n",
> -				mblk_nid, &start, &end);
> -			return -EINVAL;
> -		}
> -	}
>  

This hunk has the unfortunate side effect of killing my ThunderX
extremely early at boot time, as this sorry excuse for a machine
really relies on the kernel recognising that whatever NUMA information
the FW offers is BS.

Reverting this hunk restores happiness (sort of).

FWIW, I've posted a patch with such revert at [1].

Thanks,

	M.

[1] https://lore.kernel.org/r/20241127193000.3702637-1-maz@kernel.org

-- 
Without deviation from the norm, progress is not possible.

