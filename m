Return-Path: <linux-arch+bounces-5524-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A911937A09
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 17:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68C6B21E9C
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E759145A05;
	Fri, 19 Jul 2024 15:39:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745B1E4AD;
	Fri, 19 Jul 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403590; cv=none; b=p6JFPoHseqwoWpnobHf/VohxgyGJ6J94yiAq6hH03NemgrbllDh0MwDAMcspTSogwMIWpPftTRNFsymLohV3tBmmeA/gMHBTj1scvY2At5/mfUFkJG0qApYBzjZszj/Fvfxj9TEuZO7uXfcPXHhHdmeDQ2ZVFU/dSDGxvcUzwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403590; c=relaxed/simple;
	bh=DRFT/iygoJ22Y6tPCbb5a6xdAjLOpEr/T0egwGmQrUs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDBeuhclPv5aMSYIzY+ADj4XQbG7d8jGrXkx0pJuxmhkDoQe2mmm0fcQQ7/8XS+ao2vbZXajv1IjF4OGElCvjQ3DkjSX76rObE5P5Q3zQTzvhmdsl/mGf8/gwHiszidGQFUu7bvaMwFg9CRg06xiEfZUAmtOmNaCE2G6fcpuiZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WQYhJ2czbz6D94c;
	Fri, 19 Jul 2024 23:37:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BBFDA1400D8;
	Fri, 19 Jul 2024 23:39:37 +0800 (CST)
Received: from localhost (10.48.157.16) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 19 Jul
 2024 16:39:36 +0100
Date: Fri, 19 Jul 2024 16:39:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mike Rapoport <rppt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "Borislav
 Petkov" <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand
	<david@redhat.com>, "David S. Miller" <davem@davemloft.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens
	<hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "John Paul Adrian
 Glaubitz" <glaubitz@physik.fu-berlin.de>, Michael Ellerman
	<mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, Thomas Gleixner
	<tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon
	<will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linux-mips@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH 04/17] arch, mm: move definition of node_data to generic
 code
Message-ID: <20240719163935.00002506@Huawei.com>
In-Reply-To: <20240716111346.3676969-5-rppt@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
	<20240716111346.3676969-5-rppt@kernel.org>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 16 Jul 2024 14:13:33 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Every architecture that supports NUMA defines node_data in the same way:
> 
> 	struct pglist_data *node_data[MAX_NUMNODES];
> 
> No reason to keep multiple copies of this definition and its forward
> declarations, especially when such forward declaration is the only thing
> in include/asm/mmzone.h for many architectures.
> 
> Add definition and declaration of node_data to generic code and drop
> architecture-specific versions.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


