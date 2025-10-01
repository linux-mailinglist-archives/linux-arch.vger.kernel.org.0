Return-Path: <linux-arch+bounces-13825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB47EBB147B
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 18:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76BAC4E1DA8
	for <lists+linux-arch@lfdr.de>; Wed,  1 Oct 2025 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FCB2C2365;
	Wed,  1 Oct 2025 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grt/R0so"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D31EBA19;
	Wed,  1 Oct 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759337118; cv=none; b=JimRg528vhe/IilB308kIyiTQ3++Z4g7BNPKFXSHaXZYhMXZLm3ZRr4HJPfxqCHHFpEP95dlPdwv3E1g1yb7LBc734PWeLuIJqxSW4XM735uWg1qBjAFWeZlnbEgCxuSN4FhWSETcACb1jdmxUvpk2NJxPEKLt9SRUgdVVygzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759337118; c=relaxed/simple;
	bh=MlqpAikH1OWmKnPftKwstAu69RtadIFDLdyHc9NLlCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8hM6VQvJVDLen2LB/lXl0C0vyw28+WLwdhU5dFrB1RPdOlX4uUN+ZVhfgGR/SbNIiQ/cUMqM+DtE/e8tyN1vPf0Jq9jZw1faUiuAdTdsgbbERY3bZiTo3aGP/7BmwS2qAqwF9VQsGyl9XsIg7AiefrCdazMxLNW+gTqi96ho1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grt/R0so; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1B1C4CEF9;
	Wed,  1 Oct 2025 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759337117;
	bh=MlqpAikH1OWmKnPftKwstAu69RtadIFDLdyHc9NLlCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grt/R0so3wGZBLWpTvtis4YVWYu0OWep3ecKNHvbq7qnybhqzve3CRlAwyGup1A0m
	 ZrU5gzan7fvGY+HBDacq9cQVhu0kD/9p5zyxIRXlbfTE//GuC03KL8xX/DzZYBYHfg
	 ERyVJYc45o+Gv/5N/HK/VQMVCTd5fX+Qz92sDRMbes4AgKrxiE13uPZTBeVLUxFqHp
	 7CWCOVLqlb4dDxrfw4YDP8hdWAfu5hV3+V92AWWv7uzT6GHzUtowxz6+RJZ0yRbr2K
	 6HRzFTdg6/mkV8ko8OxuQ/Vw5UUFLujZsbJ6PWs+JaM5XcAlYTHRx+dEI5wgAzFmmZ
	 yQjKV8fw8MCKQ==
Date: Wed, 1 Oct 2025 09:45:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Will Deacon <will@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
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
	Jijie Shao <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next V6] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
Message-ID: <20251001164505.GA379753@ax162>
References: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
 <651ee9fe-706e-4471-a71b-e7a12b42cc3e@redhat.com>
 <20251001145514.GC3024065@nvidia.com>
 <20251001163655.GA370262@ax162>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001163655.GA370262@ax162>

On Wed, Oct 01, 2025 at 09:36:55AM -0700, Nathan Chancellor wrote:
> Removing the semicolon resolves the issue for me and matches the format
> of .arch_extension in the rest of the kernel. I am guessing binutils
> became less strict with parsing at some point.

Looks like 2.40 is the first fixed release.

  https://sourceware.org/bugzilla/show_bug.cgi?id=29519
  https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=e8f20526238199c18afe163a230eafe19b51fca0

