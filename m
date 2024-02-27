Return-Path: <linux-arch+bounces-2753-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D12868DCC
	for <lists+linux-arch@lfdr.de>; Tue, 27 Feb 2024 11:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E621C23F5D
	for <lists+linux-arch@lfdr.de>; Tue, 27 Feb 2024 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82EA13AA57;
	Tue, 27 Feb 2024 10:37:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A91386DB;
	Tue, 27 Feb 2024 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030248; cv=none; b=e2HB7ZEgoM39YltPn05WXNxbXCu7t/YLApAQfbh0JD8HBA5QTK9Zqe3imnY7T2eyCeDGfxK92ozjtkiyYqsfcaadcM+lxOBc09xfhHQPmGI5JIel2hhuExbDN1z2OgqHTs8HBFtdNXXxK/d3u0VAgiFRaz+5O1rgNaCLUkXHPKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030248; c=relaxed/simple;
	bh=UopZteKsviPxCNjSny9cAIZSGOCRhXG4d51EkbeY/J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCPGvybBcpSehkwsbeW3ETUjqOvQJh2Dqv4c9EHJ3dDL+9eQR8MMKYYpRcaFsYa/gS4TWuGJLVjU2kEB1cM8DUgm3cZ1qzxi2JXnqRDAAGGRDWvftTrLFgNP2T12enj11+B9zikic0oK5fjBVb5uSqb8Fm91geDs32tRAaFncrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD64C433F1;
	Tue, 27 Feb 2024 10:37:20 +0000 (UTC)
Date: Tue, 27 Feb 2024 10:37:18 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
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
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Message-ID: <Zd27XtDg_NDzLXg-@arm.com>
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

On Tue, Feb 20, 2024 at 09:17:08PM -0400, Jason Gunthorpe wrote:
> +/*
> + * This generates a memcpy that works on a from/to address which is aligned to
> + * bits. Count is in terms of the number of bits sized quantities to copy. It
> + * optimizes to use the STR groupings when possible so that it is WC friendly.
> + */
> +#define memcpy_toio_aligned(to, from, count, bits)                        \
> +	({                                                                \
> +		volatile u##bits __iomem *_to = to;                       \
> +		const u##bits *_from = from;                              \
> +		size_t _count = count;                                    \
> +		const u##bits *_end_from = _from + ALIGN_DOWN(_count, 8); \
> +                                                                          \
> +		for (; _from < _end_from; _from += 8, _to += 8)           \
> +			__const_memcpy_toio_aligned##bits(_to, _from, 8); \
> +		if ((_count % 8) >= 4) {                                  \
> +			__const_memcpy_toio_aligned##bits(_to, _from, 4); \
> +			_from += 4;                                       \
> +			_to += 4;                                         \
> +		}                                                         \
> +		if ((_count % 4) >= 2) {                                  \
> +			__const_memcpy_toio_aligned##bits(_to, _from, 2); \
> +			_from += 2;                                       \
> +			_to += 2;                                         \
> +		}                                                         \
> +		if (_count % 2)                                           \
> +			__const_memcpy_toio_aligned##bits(_to, _from, 1); \
> +	})

Do we actually need all this if count is not constant? If it's not
performance critical anywhere, I'd rather copy the generic
implementation, it's easier to read.

Otherwise, apart from the __raw_writeq() typo that Will mentioned, the
patch looks fine to me.

-- 
Catalin

