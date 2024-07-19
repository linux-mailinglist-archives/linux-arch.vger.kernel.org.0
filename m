Return-Path: <linux-arch+bounces-5531-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B7937B07
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 18:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BF51F21541
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 16:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A598E1465BC;
	Fri, 19 Jul 2024 16:30:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624B1459F9;
	Fri, 19 Jul 2024 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406628; cv=none; b=p4pllCGn0amaYFVrZcfM7DO9TflcFAp1EDO9Lp3nGPQirqbRlcwNl0h+G6oo79x1rYU0f5aF+GnigimEUVz5C+1NaUg+vg0mLXAFwV2obIGI3T05wc3sC2wIFIO90DJTPnWtu2n9Bdduz1pVJqqR2Ksl89ZoQKQDwEamLCAKx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406628; c=relaxed/simple;
	bh=apjbNIgzFKzsJkQExYidFUciZLfx74+MuVZgeVEKk40=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekmLApW2b4//jlZ7idKF3sCVKOehnzKHxueyMJ+BMb5E9Anv+RyKVB6ialxY44b9VPN22Z26rP3IW2GZHgSSMNLiYHn0pqhAaoHsu6We6bvKD0iKqLumgDkKQtbAdEqxWCn3bbT4FiXRTxCSNGUzhz1N8ysOQTncZRoactpaefU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WQZqJ0Xzhz6K6TT;
	Sat, 20 Jul 2024 00:28:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B243F140C98;
	Sat, 20 Jul 2024 00:30:22 +0800 (CST)
Received: from localhost (10.48.157.16) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 19 Jul
 2024 17:30:16 +0100
Date: Fri, 19 Jul 2024 17:30:15 +0100
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
Subject: Re: [PATCH 07/17] x86/numa: move FAKE_NODE_* defines to numa_emu
Message-ID: <20240719173015.00002a01@Huawei.com>
In-Reply-To: <20240716111346.3676969-8-rppt@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
	<20240716111346.3676969-8-rppt@kernel.org>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 16 Jul 2024 14:13:36 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> The definitions of FAKE_NODE_MIN_SIZE and FAKE_NODE_MIN_HASH_MASK are
> only used by numa emulation code, make them local to
> arch/x86/mm/numa_emulation.c
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

