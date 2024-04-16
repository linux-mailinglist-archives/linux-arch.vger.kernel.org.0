Return-Path: <linux-arch+bounces-3718-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC128A6619
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 10:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7AA1F215B6
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3710B86255;
	Tue, 16 Apr 2024 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p61+UYgY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE2985959;
	Tue, 16 Apr 2024 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256203; cv=none; b=W+SXq8KM17NfxZqf61n/tUo9fwAai5VwhGx+sK6vcjYb3X1oeaAZRK+2Zpj8VHOxghWRl+cJYat+Uf0d3GRL0ndbuEd9noHuEHcRjOseGxcngjUsvOSATWfK+ZFbio5iOat0HTz0xsEowElko8dROj5cPI3+XWm5WFkB0o/Lcpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256203; c=relaxed/simple;
	bh=lJrj9v6ekM+Ddi5L9uY9dMcBsBq+d7SARM1jH6N4GQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gST/C1vOqA1EmWlrS9NrQhVdPkaV6TrAcfTSGDr/mgR262tD0XWwJtFxWy/aUxo59T30bsOXjCs7UN8/Qx+O7pRXNcA7hkPrNPXgsWXPxVQIgqMrHoGqz89UhdLOfnUtzF0dPatyFEQ3b3wg4rxCU8rgYlNn92+nlvFbJY0on1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p61+UYgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B131DC113CE;
	Tue, 16 Apr 2024 08:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713256202;
	bh=lJrj9v6ekM+Ddi5L9uY9dMcBsBq+d7SARM1jH6N4GQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p61+UYgYo11o8wr+9Y1NTCQKaUdil+iO3y09VvB2XgUFcg+G0hFo9nVW748ZyFVyS
	 jbsf9lWI/fFLW2RS99UV30A3yiEWvznNPQ8QGOUpP08u3lFxS3v2xFdx4iUVfPLLvQ
	 kUTrfHBa2we/FaHPNnxCp/OEulJA6LTIK+TyCuJUppYn2sc73MSIfB37zKPHIXDyXM
	 vJfCDtHbQXfm1eYIVsUEcNy+DkO2Ld937JnJ/MOVna6c+oUdYFKaKxzWRGG033qwRR
	 LtIIu1HqZaC3Ig8eBWSR97uPo608TMUmpzBoHQXGVFzkEUxfvYwv7vLMjz8gm6l87/
	 XztQv707Kx+FQ==
Date: Tue, 16 Apr 2024 11:29:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
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
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, llvm@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 6/6] IB/mlx5: Use __iowrite64_copy() for write
 combining stores
Message-ID: <20240416082957.GC6832@unreal>
References: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
 <6-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>

On Thu, Apr 11, 2024 at 01:46:19PM -0300, Jason Gunthorpe wrote:
> mlx5 has a built in self-test at driver startup to evaluate if the
> platform supports write combining to generate a 64 byte PCIe TLP or
> not. This has proven necessary because a lot of common scenarios end up
> with broken write combining (especially inside virtual machines) and there
> is other way to learn this information.
> 
> This self test has been consistently failing on new ARM64 CPU
> designs (specifically with NVIDIA Grace's implementation of Neoverse
> V2). The C loop around writeq() generates some pretty terrible ARM64
> assembly, but historically this has worked on a lot of existing ARM64 CPUs
> till now.
> 
> We see it succeed about 1 time in 10,000 on the worst effected
> systems. The CPU architects speculate that the load instructions
> interspersed with the stores makes the WC buffers statistically flush too
> often and thus the generation of large TLPs becomes infrequent. This makes
> the boot up test unreliable in that it indicates no write-combining,
> however userspace would be fine since it uses a ST4 instruction.
> 
> Further, S390 has similar issues where only the special zpci_memcpy_toio()
> will actually generate large TLPs, and the open coded loop does not
> trigger it at all.
> 
> Fix both ARM64 and S390 by switching to __iowrite64_copy() which now
> provides architecture specific variants that have a high change of
> generating a large TLP with write combining. x86 continues to use a
> similar writeq loop in the generate __iowrite64_copy().
> 
> Fixes: 11f552e21755 ("IB/mlx5: Test write combining support")
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mem.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>

