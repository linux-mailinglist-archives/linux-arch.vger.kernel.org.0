Return-Path: <linux-arch+bounces-12775-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876B4B0578F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 12:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13783B8E08
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C255327781D;
	Tue, 15 Jul 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FztlJ1OF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864CF19DF6A;
	Tue, 15 Jul 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574535; cv=none; b=kiAYg2MpLvE7LBUaY04B8p+rYWTMjfBuAmwgqpvRQTm9pE2nSsJEu9rXEChHz1Dq39QDdX1knnLokWcdD9qBFBID5fQDVaLl3nDmxI/DLssa8rQaLUUb1Hq5Pq6h0oJikGbmYLNVAim/VyWLVzpKO6HPKyGFH5qSGGKiYgQTmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574535; c=relaxed/simple;
	bh=IBYVlI+orIMPRgYFaIqphL4RshTJzkbjmDni9IWE3vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9wBC96AnWHFHeISRa0spUnaZedyx4fzGTPcG8R9koKsnPWxcs4jmOoXIDp+8uqEez8kHJdlBA7J3aYLwx+xZUMd6+qMUMobOfkj1uro9Kpmh4KpExEtQywP7lzxKFOUqUskx7eOfvUKOsYFl/YGzMvbkxsbmWnJhVhJ4HA/dkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FztlJ1OF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BDCC4CEE3;
	Tue, 15 Jul 2025 10:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752574535;
	bh=IBYVlI+orIMPRgYFaIqphL4RshTJzkbjmDni9IWE3vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FztlJ1OFq4eDjn612gnPl+YVBf7o63I7kavAKkN6NFFz2JarOIQLE/JFJXeCg6HIL
	 z4ZOGtGZqr2hPQKCDh6IFKndGWXk3RHqqyPPB3czhiyvHdDfjkLQATIl9Lfl8M5gID
	 0HJtGGxF+rGCtt710YXgmyHq4m4s6ORR7QRXexgQRC8ZUNIjSNQXBlfwaF88VnHy5Q
	 DAeqFE4EsBQdtOCEvZ/PIaHSEYH78SR85B5+0dobS6Zx5s4O7OpqEuvklCOv/kkzQZ
	 i3ZfJH1M7EPMLX9i6abuLL0sl0GpzfeP8svATD4gLx1MMmUlMd7S/CH7JSvW9yWmk3
	 gd5aHtoOobY1A==
Date: Tue, 15 Jul 2025 11:15:25 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH v3 6/6] IB/mlx5: Use __iowrite64_copy() for write
 combining stores
Message-ID: <aHYqPRqgcl5DQOpq@willie-the-truck>
References: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
 <6-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
 <20250714215504.GA2083014@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714215504.GA2083014@nvidia.com>

On Mon, Jul 14, 2025 at 06:55:04PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 11, 2024 at 01:46:19PM -0300, Jason Gunthorpe wrote:
> > mlx5 has a built in self-test at driver startup to evaluate if the
> > platform supports write combining to generate a 64 byte PCIe TLP or
> > not. This has proven necessary because a lot of common scenarios end up
> > with broken write combining (especially inside virtual machines) and there
> > is other way to learn this information.
> > 
> > This self test has been consistently failing on new ARM64 CPU
> > designs (specifically with NVIDIA Grace's implementation of Neoverse
> > V2). The C loop around writeq() generates some pretty terrible ARM64
> > assembly, but historically this has worked on a lot of existing ARM64 CPUs
> > till now.
> > 
> > We see it succeed about 1 time in 10,000 on the worst effected
> > systems. The CPU architects speculate that the load instructions
> > interspersed with the stores makes the WC buffers statistically flush too
> > often and thus the generation of large TLPs becomes infrequent. This makes
> > the boot up test unreliable in that it indicates no write-combining,
> > however userspace would be fine since it uses a ST4 instruction.
> 
> After a year of testing this in real systems it turns out that still
> some systems are not good enough with the unrolled 8 byte store loop.
> In my view the CPUs are quite bad here and this WC performance
> optimization is not working very well.
> 
> There are only two more options to work around this issue, use the
> unrolled 16 byte STP or the single Neon instruction 64 byte store.
> 
> Since STP was rejected alread we've only tested the Neon version. It
> does make a huge improvement, but it still somehow fails to combine
> rarely sometimes. The CPU is really bad at this :(

I think the thread was from last year so I've forgotten most of the
details, but wasn't STP rejected because it wasn't virtualisable? In
which case, doesn't NEON suffer from exactly the same (or possibly
worse) problem?

Also, have you managed to investigate why the CPU tends not to get this
right? Do we e.g. end up taking interrupts/exceptions while the self
test is running or something like that?

Sorry for the wall of questions!

Will

