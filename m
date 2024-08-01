Return-Path: <linux-arch+bounces-5894-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450C39451C8
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 19:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765911C24CE3
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFF91B374F;
	Thu,  1 Aug 2024 17:45:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5A313C8E8;
	Thu,  1 Aug 2024 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534352; cv=none; b=DkOvUvHJrewurC/FYbllXqDUj2ocE5Pbh7pnV6H8M0jjTLDR8wURbfiRmLWHGIxNI6k2aEe4emxNEpLzwBo3sVI7wuEdH5Txz8+sGthXfN9J6rSp3ndxQdY1yv1Hf9fnTUXHKTd6e78w2mC9gFJFJGqs9BnJwauDLUAsMpE8Pyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534352; c=relaxed/simple;
	bh=L0lKgzFenYknPcjmMm2DsPSlveu6ZCz/RN3IH34o0N0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBfWh723Ec32dn7UcoajAyGvkKqENVKz/sNMjz3CEmO3dPbTxFZPchRov1epXlU6+HKLdCvvpQIbBAWef1glIHsWTkFjY3kn4zKmKyv5TaYhRXjwL+wjXtkYcCbpgTQ3Ih7WP2z38dEFCIgOvaQ0d162dma2RZERMGlFd+siulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WZbsX1GyPz6K6Y1;
	Fri,  2 Aug 2024 01:43:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 41BE0140A86;
	Fri,  2 Aug 2024 01:45:48 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 1 Aug
 2024 18:45:46 +0100
Date: Thu, 1 Aug 2024 18:45:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mike Rapoport <rppt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "Borislav
 Petkov" <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand
	<david@redhat.com>, "David S. Miller" <davem@davemloft.net>, Davidlohr Bueso
	<dave@stgolabs.net>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Heiko
 Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, Jonathan Corbet
	<corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt
	<palmer@dabbelt.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring
	<robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner
	<tglx@linutronix.de>, "Vasily Gorbik" <gor@linux.ibm.com>, Will Deacon
	<will@kernel.org>, Zi Yan <ziy@nvidia.com>, <devicetree@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <loongarch@lists.linux.dev>,
	<nvdimm@lists.linux.dev>, <sparclinux@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v3 04/26] MIPS: sgi-ip27: drop
 HAVE_ARCH_NODEDATA_EXTENSION
Message-ID: <20240801184546.00000ba6@Huawei.com>
In-Reply-To: <20240801060826.559858-5-rppt@kernel.org>
References: <20240801060826.559858-1-rppt@kernel.org>
	<20240801060826.559858-5-rppt@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  1 Aug 2024 09:08:04 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Commit f8f9f21c7848 ("MIPS: Fix build error for loongson64 and
> sgi-ip27") added HAVE_ARCH_NODEDATA_EXTENSION to sgi-ip27 to silence a
> compilation error that happened because sgi-ip27 didn't define array of
> pg_data_t as node_data like most other architectures did.
> 
> After addition of node_data array that matches other architectures and
> after ensuring that offline nodes do not appear on node_possible_map, it
> is safe to drop arch_alloc_nodedata() and HAVE_ARCH_NODEDATA_EXTENSION
> from sgi-ip27.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  arch/mips/Kconfig                |  1 -
>  arch/mips/sgi-ip27/ip27-memory.c | 10 ----------
>  2 files changed, 11 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 60077e576935..ea5f3c3c31f6 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -735,7 +735,6 @@ config SGI_IP27
>  	select WAR_R10000_LLSC
>  	select MIPS_L1_CACHE_SHIFT_7
>  	select NUMA
> -	select HAVE_ARCH_NODEDATA_EXTENSION
>  	help
>  	  This are the SGI Origin 200, Origin 2000 and Onyx 2 Graphics
>  	  workstations.  To compile a Linux kernel that runs on these, say Y
> diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
> index c30ef6958b97..eb6d2fa41a8a 100644
> --- a/arch/mips/sgi-ip27/ip27-memory.c
> +++ b/arch/mips/sgi-ip27/ip27-memory.c
> @@ -426,13 +426,3 @@ void __init mem_init(void)
>  	memblock_free_all();
>  	setup_zero_pages();	/* This comes from node 0 */
>  }
> -
> -pg_data_t * __init arch_alloc_nodedata(int nid)
> -{
> -	return memblock_alloc(sizeof(pg_data_t), SMP_CACHE_BYTES);
> -}
> -
> -void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
> -{
> -	__node_data[nid] = (struct node_data *)pgdat;
> -}


