Return-Path: <linux-arch+bounces-6007-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D7B948390
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 22:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89D01C2209E
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 20:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAABC14B08E;
	Mon,  5 Aug 2024 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0ifEE+/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAA813E881;
	Mon,  5 Aug 2024 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722890158; cv=none; b=JOntuJRi39P9TIi6nOysa5VL9maWhlgHy5FUIKQZGLKpSS+JLzzJSLaACMENEJhdMyHWn9PwCegSjXgD5/l1W5x0BuNJb8i59Ic1DDRywonLlhIZz5aWNEA0anyEJE/e65YFYIRjuI4eENIE0xjyJyrn6vGjQsCFjWlq/wsFhhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722890158; c=relaxed/simple;
	bh=wRagKm6MS39NDYLBbcdNfb/zxQJOwJqmtNN36cxhWNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRX5D6tfGFNevLoF+XowPQOn+LAZeWzqVQABuUYVjklm/f2woquJ9idyWqgf0jcc8jLBmkAgUervbhn8xTTloSjyarn7Sd7DTJJNIn8SOgEmi5Do465o9tqE3rd045jcBJeI3V3aZnQ3EIGLEc+gBhNLQEcaage2Ll8KFx+UdRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0ifEE+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51B2C32782;
	Mon,  5 Aug 2024 20:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722890158;
	bh=wRagKm6MS39NDYLBbcdNfb/zxQJOwJqmtNN36cxhWNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0ifEE+/fQd9VQyFJiGF6eqG5LkKWn0QoytIRLG6RGNO3Qz+ixAqBqBhJXWXYzJE8
	 0lFaNo21LgP2mbO565lm6BtVRnS7fXNHEJVy8zEtHsy8Uw8u/a5v19B4OkrZVUS3fx
	 ix+vSxthkk0vtjORnJgV3NWtYxBAy3BhlS8nwLVfIFfPyq5ww4vSd2FHKgUzoj06Iv
	 Vb4ByzZFa5e2puJlKIa3k2+AazNy3wMipT1Qok9eH8nBZ24hNYG5OjUnktHHi7xdO4
	 HdW3CuSUf4iLi1uAYROJiEHzYtewSLvIDZn8z4DY92o6CWtrXY1hYgkOWg3WUTpR8E
	 O3fqMHFNWnE8A==
Date: Mon, 5 Aug 2024 23:33:39 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
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
	Zi Yan <ziy@nvidia.com>, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	nvdimm@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 22/26] mm: numa_memblks: use
 memblock_{start,end}_of_DRAM() when sanitizing meminfo
Message-ID: <ZrE3I6qCdfHPa3FB@kernel.org>
References: <20240801060826.559858-1-rppt@kernel.org>
 <20240801060826.559858-23-rppt@kernel.org>
 <66b1342e8af7f_c1448294af@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b1342e8af7f_c1448294af@dwillia2-xfh.jf.intel.com.notmuch>

On Mon, Aug 05, 2024 at 01:21:02PM -0700, Dan Williams wrote:
> Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > numa_cleanup_meminfo() moves blocks outside system RAM to
> > numa_reserved_meminfo and it uses 0 and PFN_PHYS(max_pfn) to determine
> > the memory boundaries.
> > 
> > Replace the memory range boundaries with more portable
> > memblock_start_of_DRAM() and memblock_end_of_DRAM().
> 
> Can you say a bit more about why this is more portable? Is there any
> scenario for which (0, max_pfn) does the wrong thing?

arm64 may have DRAM starting at addresses other than 0.
And max_pfn seems to me a redundant global variable that I'd love to see
gone.

-- 
Sincerely yours,
Mike.

