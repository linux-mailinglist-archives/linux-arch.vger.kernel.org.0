Return-Path: <linux-arch+bounces-2605-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2585E729
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 20:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F76A282796
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 19:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A5C85C55;
	Wed, 21 Feb 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ87J93G"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C27FBBC;
	Wed, 21 Feb 2024 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543337; cv=none; b=Id/2HroRQaAsWVMQWLRJKV5AsW7cE3ko0T31bXwzwues0mhony/viZfAYv0DS8rrtkrq2YHDhyNTGSfazXyPU1yTL9+VC9Ic73j2+n+nKNQuPf+6yKDDfe/rPyjpNGCdYYRluWot4CGh3g1f/ZZMwqrqksuKVp+d/TRhJfMFgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543337; c=relaxed/simple;
	bh=0OodqgNcvx8ntnlXtEmNl9CzN4cmy/3auP5St1YCfYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUuO+8eBkXoaWBFgwnRaxALBa54+9LIgV3WoS585/J0XiaoJACOoyfvQmESRWl3gIYURJMhVzqtRvJ/iQ/sEb1I/EW/d+PicNbZPcdlyAYTGf51DTSaTV4sT7vhA3ctRH77biiLnNZAaLXOuZJz5T/lD+N5uiE+Kws8FalKXxHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ87J93G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3ECC433C7;
	Wed, 21 Feb 2024 19:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708543336;
	bh=0OodqgNcvx8ntnlXtEmNl9CzN4cmy/3auP5St1YCfYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJ87J93G+evRIoU8Rda/h3gEh+MmBQn/ihau1koXbpG2vc7Q7X/Z3FDA+27G5eGKp
	 adq/fFZsuxU9dGUvQ230eoKDaDysEUD69zfaKXCggxVmXhRcjlKBVEU0Q0k2rA3BAX
	 vYHujOcAZrwDDP3o52EkzUI46Ox75hSNy38AGA5vguRG5WscWt6Sg9BGIIq/9CvBKy
	 0RFb/VgnVQahUHpG96HdW0EROCdzv2pY9bcEZ1dAIkJDeQu+FTMCwMYjQo88bHW8fz
	 y7YEBgT5m4GIfG0M10Xe1DX+64vISb2glhnZ3nFnLAeDL6LA7l90+0tr269uPe1yt8
	 afMcW129BlMSA==
Date: Wed, 21 Feb 2024 19:22:06 +0000
From: Will Deacon <will@kernel.org>
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
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Message-ID: <20240221192205.GA7619@willie-the-truck>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 20, 2024 at 09:17:08PM -0400, Jason Gunthorpe wrote:
> +static inline void __const_memcpy_toio_aligned64(volatile u64 __iomem *to,
> +						 const u64 *from, size_t count)
> +{
> +	switch (count) {
> +	case 8:
> +		asm volatile("str %x0, [%8, #8 * 0]\n"
> +			     "str %x1, [%8, #8 * 1]\n"
> +			     "str %x2, [%8, #8 * 2]\n"
> +			     "str %x3, [%8, #8 * 3]\n"
> +			     "str %x4, [%8, #8 * 4]\n"
> +			     "str %x5, [%8, #8 * 5]\n"
> +			     "str %x6, [%8, #8 * 6]\n"
> +			     "str %x7, [%8, #8 * 7]\n"
> +			     :
> +			     : "rZ"(from[0]), "rZ"(from[1]), "rZ"(from[2]),
> +			       "rZ"(from[3]), "rZ"(from[4]), "rZ"(from[5]),
> +			       "rZ"(from[6]), "rZ"(from[7]), "r"(to));
> +		break;
> +	case 4:
> +		asm volatile("str %x0, [%4, #8 * 0]\n"
> +			     "str %x1, [%4, #8 * 1]\n"
> +			     "str %x2, [%4, #8 * 2]\n"
> +			     "str %x3, [%4, #8 * 3]\n"
> +			     :
> +			     : "rZ"(from[0]), "rZ"(from[1]), "rZ"(from[2]),
> +			       "rZ"(from[3]), "r"(to));
> +		break;
> +	case 2:
> +		asm volatile("str %x0, [%2, #8 * 0]\n"
> +			     "str %x1, [%2, #8 * 1]\n"
> +			     :
> +			     : "rZ"(from[0]), "rZ"(from[1]), "r"(to));
> +		break;
> +	case 1:
> +		__raw_writel(*from, to);

Shouldn't this be __raw_writeq?

Will

