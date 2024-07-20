Return-Path: <linux-arch+bounces-5543-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64D938143
	for <lists+linux-arch@lfdr.de>; Sat, 20 Jul 2024 14:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63D9281FAF
	for <lists+linux-arch@lfdr.de>; Sat, 20 Jul 2024 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B384E0D;
	Sat, 20 Jul 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXNTwVKG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002EB7462;
	Sat, 20 Jul 2024 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721478504; cv=none; b=OaNS2OZuCLX7lfwpOAN7bS1ENCPITtWgQmoujZI6suM7C4IvqfQ3Kk2/9Ir69KK36n2buulepPyf/zF1swSaaGzneyiQMOMFKd0vunfZlpObVwC6t4p4XyhSX7CX3HYgnfMZFduRksZ5SUQeFdWkMjF6uBZ8tdY8JY3j7hUILkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721478504; c=relaxed/simple;
	bh=/mmf7KEQ2fPqMset/cgfJzrTW1VPxx9MyxonZ+AyPQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGiaANWxFE9X0zMNoNOuSAy+gcTarXyM+aJPvgszVzsuT+E8/a5fdu2NakiA1Zk78F+yPVdTFUl8toCcas/K2syvb1pYOFDQeJNFHD3uyilkLfYJv+d3tfPPyppufwwh/aDg52n4/Rrq/UoikBgcGK/pMBOs+1jTM9RlJVogHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXNTwVKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F9FC2BD10;
	Sat, 20 Jul 2024 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721478503;
	bh=/mmf7KEQ2fPqMset/cgfJzrTW1VPxx9MyxonZ+AyPQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXNTwVKG4a4xYLw48OLtatEkRdqIGu8Mf+G1aUXiTTPTpT78IYUQ1/wzw0qcFGQoR
	 EepLZpsfpjbXKbh/xfZLM3pDZgCx3YVNfQ8PYWZH73ncdrVoIJ9MY6uDPyRIVyQIRs
	 +mD0V5quwhKhuRIUn7YWWcUOTpwaW7OpiJS6ob2EzbfT+pcMNhHQp3Wq1wCk5+tueN
	 cPKdYI9XDCq7cwRj9VCCE2OjNxFU7Ln9GS8efdMPhwguntvnlAzgrDRV9PZkgruXop
	 kgltilDaq6nb/4rY0NbgAzNLz0ekUP2swIpCx5HMEf1sL/wDuc2020z2LPpHNdvHa/
	 VhAS6LNc+rmag==
Date: Sat, 20 Jul 2024 15:25:15 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Message-ID: <Zpusq94oFVrygufA@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
 <20240716111346.3676969-14-rppt@kernel.org>
 <20240719184842.000030bc@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719184842.000030bc@Huawei.com>

On Fri, Jul 19, 2024 at 06:48:42PM +0100, Jonathan Cameron wrote:
> On Tue, 16 Jul 2024 14:13:42 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Move code dealing with numa_distance array from arch/x86 to
> > mm/numa_memblks.c
> 
> It's not really numa memblock related. Is this the best place
> to put it?

There is a dependency of numa_alloc_distance() on
numa_nodemask_from_meminfo() that relies on numa_memblk but I agree that
they are not really related.

However, I'd prefer to keep this code in mm/numa_memblks.c because
node_distance() definitions and related code are different between
architecures and having this code outside numa_memblks in e.g
mm/numa.c would be way more involved.
 
> > This code will be later reused by arch_numa.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 

-- 
Sincerely yours,
Mike.

