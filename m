Return-Path: <linux-arch+bounces-13779-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C169BA15B3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 22:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF81174064
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 20:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF3D24EF8C;
	Thu, 25 Sep 2025 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG2Nik8g"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD84204E;
	Thu, 25 Sep 2025 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832258; cv=none; b=VIIa8TU9Gyz2SMkWvJ3RUmMdI2PvOgE93/fGzJiQSdsunNGxtlAO7AoWef2qxYjSB+5Q54UAvwtzNLiTBq6RO+EKc4JzAMUviKfggiOpiuZRwQHIIi3bZ6CzLjloN2+xAVGNdbn2BT5KpZnJpL7H1wdPcY6ADGtW5r3vDR/D1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832258; c=relaxed/simple;
	bh=SB7VFFS497fVqOtw/xEspRqIe+JuY6wZmouhpT9nChM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmJjEZYNvhRRn2lfjVyCcd4VDxDuGuTAYY8+uoNE6K86ysEnWzBEza/XWJvTpdug0dWNviViaFzp0nzVxvWgYYcXdnWQYKlsgVCC51NqqT3N41jogl3rOvuQcCLID/Md8LEUAt0t69j74KywjBXXxo6bKdbA3cLUT2mUObSEbK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG2Nik8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C23C4CEF7;
	Thu, 25 Sep 2025 20:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758832258;
	bh=SB7VFFS497fVqOtw/xEspRqIe+JuY6wZmouhpT9nChM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oG2Nik8gzsWZh4y8F/lhqAYk70kCj3etLu0UGMrA3eCDJxAuVemwc+TzmdzEQBjHj
	 szCeNajFGVSbmWl0E5fE2bfTT4cojKEiGrB8uXKYhC6jrcfOcLnHEPr08n3HJoRIeb
	 xs6y50qus7EtCoTO2axKKvR2V+7hnnT4Jpye1ubwF5dQQkEthyW4VS9MQQsxADG1Z8
	 SLNn1xX5M0kJB1UMOxRdinekft352a5qQwDP3kGNJz0OLXKFWnxNmAbi5mGBhK2w6U
	 Fs5gUTiXssFLJ3H5ccv/xjrxK6P0VRVFykGtqwstFdgh6Le+MDfMDlQMsczF8w2IG3
	 MoLr8DuugM0Dw==
Date: Thu, 25 Sep 2025 16:30:46 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
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
	Leon Romanovsky <leonro@mellanox.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V5] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
Message-ID: <20250925203046.GA491548@ax162>
References: <1758800913-830383-1-git-send-email-tariqt@nvidia.com>
 <20250925115433.GU2617119@nvidia.com>
 <d548b14e-ae28-4807-9b29-9961543ea549@nvidia.com>
 <20250925122139.GW2617119@nvidia.com>
 <13c5072c-dc93-477c-b72e-02156a0ecc2e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13c5072c-dc93-477c-b72e-02156a0ecc2e@app.fastmail.com>

On Thu, Sep 25, 2025 at 03:05:52PM +0200, Arnd Bergmann wrote:
> On the other hand, I would in general strongly prefer
> 
>      if (IS_ENABLED(CONFIG_FOO)) {
>             ...
>      }
> 
> over any of the preprocessor conditionals, both for readability
> and for improving compile-time coverage of the conditional code.
> 
> Unfortunately that does not work here because kernel_neon_begin()
> etc are only defined on Arm.

Even if the neon macros/functions were to be dummy defined, I suspect
clang may complain about the vector register clobbers on architectures
other than arm64, since it will validate some inline assembly even in
dead code.

