Return-Path: <linux-arch+bounces-2774-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E01D286C6FB
	for <lists+linux-arch@lfdr.de>; Thu, 29 Feb 2024 11:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD2C1C213A1
	for <lists+linux-arch@lfdr.de>; Thu, 29 Feb 2024 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46F979957;
	Thu, 29 Feb 2024 10:33:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB57994D;
	Thu, 29 Feb 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202793; cv=none; b=pXZ5VQJHXUX1tzWWkZ8yprFfHiId8/vXHfo4x7H4znPsBCZ+EhEb2C3w3o6Ti0MMwFLjnelSc6V5t9nBvwZrKWxmyaHbaIXs2IpGxL/1iD7s3uAlX477DYu4b6PokbXnEqQLGWYUR3lxaomI6i60WIu1sKZ/BIxwZiO0EGQX9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202793; c=relaxed/simple;
	bh=LzVIgurKSN0WZtrn243ryA0za0VzX5/llwTnhwb/8SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abPNHZs5doU//lcM7ZncgHqyU/zaYBQZvAEoBM6Vj2JJUa8OVPDQuPdCXpUe9DM825sLTM/EdSL4qXU1nac9zk7KgT3+27s2EQuYqEJMJh3wCyLqfzYIn+YmrWWq1/xlbeQDgLF+qeU+w+2eD9Bzwrsymf5ysan9RkAgwViFNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BB0C43390;
	Thu, 29 Feb 2024 10:33:06 +0000 (UTC)
Date: Thu, 29 Feb 2024 10:33:04 +0000
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
Message-ID: <ZeBdYCa5Kxqas4O8@arm.com>
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
> +						 const u32 *from, size_t count)
> +{
> +	switch (count) {
> +	case 8:
> +		asm volatile("str %w0, [%8, #4 * 0]\n"
> +			     "str %w1, [%8, #4 * 1]\n"
> +			     "str %w2, [%8, #4 * 2]\n"
> +			     "str %w3, [%8, #4 * 3]\n"
> +			     "str %w4, [%8, #4 * 4]\n"
> +			     "str %w5, [%8, #4 * 5]\n"
> +			     "str %w6, [%8, #4 * 6]\n"
> +			     "str %w7, [%8, #4 * 7]\n"
> +			     :
> +			     : "rZ"(from[0]), "rZ"(from[1]), "rZ"(from[2]),
> +			       "rZ"(from[3]), "rZ"(from[4]), "rZ"(from[5]),
> +			       "rZ"(from[6]), "rZ"(from[7]), "r"(to));
> +		break;

BTW, talking of maintenance, would a series of __raw_writel() with
Mark's recent patch for offset addressing generate similar code? I.e.:

		__raw_writel(from[0], to);
		__raw_writel(from[1], to + 1);
		...
		__raw_writel(from[7], to + 7);

(you may have mentioned it in previous threads, I did not check)

-- 
Catalin

