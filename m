Return-Path: <linux-arch+bounces-5935-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CBE945F07
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 16:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B415F1C21A66
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 14:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688BC1E3CB8;
	Fri,  2 Aug 2024 14:01:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922605258;
	Fri,  2 Aug 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607308; cv=none; b=IfJmRtiCcDL31t9Ae8KmMcLncU2QXlBGzh88yAv4Bx8G1bJxfi0CKfdJWKGAOHXx8MCZfQCyuCLn+r4YwJrlJviNHTADMaKCnaN7IBdTBVpiBS5xk7/ILjNbFRfsOXDVkumTeazCm2KDoTzPQ+gvhXz72pjXlIN/ZHDRcgs8NSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607308; c=relaxed/simple;
	bh=u3ZMg2xsS0PphcV5AO/Z+wTJuTNi8Zl3B3cTy1JUA/o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6TWylVm1/V6t2fLyvEmTUCuLGjw2XqyMlK+0eH98mxe2kDQK2lKKJbo98d76jiav99ggA4LthF6+0jKWwQ9Hesmy0ztiiF/c1gdeEb5MDFxTWWWyQWq//AKUSOb2fotq/sMVbAAYjdK1Pp1q9EcLc1/QP9bv1lRj/F3bsFzkYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wb6rS3QPSz6K6ln;
	Fri,  2 Aug 2024 21:59:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 429D2140A86;
	Fri,  2 Aug 2024 22:01:43 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 2 Aug
 2024 15:01:42 +0100
Date: Fri, 2 Aug 2024 15:01:41 +0100
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
Subject: Re: [PATCH v3 23/26] of, numa: return -EINVAL when no numa-node-id
 is found
Message-ID: <20240802150141.00002143@Huawei.com>
In-Reply-To: <20240801060826.559858-24-rppt@kernel.org>
References: <20240801060826.559858-1-rppt@kernel.org>
	<20240801060826.559858-24-rppt@kernel.org>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  1 Aug 2024 09:08:23 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Currently of_numa_parse_memory_nodes() returns 0 if no "memory" node in
> device tree contains "numa-node-id" property. This makes of_numa_init()
> to return "success" despite no NUMA nodes were actually parsed and set
> up.
> 
> arch_numa workarounds this by returning an error if numa_nodes_parsed is
> empty.
> 
> numa_memblks however would WARN() in such case and since it will be used
> by arch_numa shortly, such warning is not desirable.
> 
> Make sure of_numa_init() returns -EINVAL when no NUMA node information
> was found in the device tree.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

