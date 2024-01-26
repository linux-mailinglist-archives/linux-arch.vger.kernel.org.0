Return-Path: <linux-arch+bounces-1720-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B42683DCD3
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 15:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7DF1C21BBC
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD821CA8D;
	Fri, 26 Jan 2024 14:56:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B11C68F;
	Fri, 26 Jan 2024 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280997; cv=none; b=ThFOMLOIHHhq/hXGpP5nyO952Sapq++tmdm3xQZDAkbdYCZl8crGpnbSqOjxT3J0sbJ47Hcub8RBThLwwBoNQ3z19F4579D6a9VoRjwixv0hVWEjxvOofxO5bvrXhlDG8Gmyw0ULARJ/w5DR9DG/3dWrhZx+Kvdz5FRsbBmQn1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280997; c=relaxed/simple;
	bh=f8cywfRmvLjKXiTEkbut2MRiriAkYIQcyCBGU0iDCGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqDx9nF7SjDIKSRnxqEsoznko6ppTTUxiQFJ4K5CR67pQTSUyoP36KkjpwBDTnCfNfaa0KweZqS3zTINRufP8oglNScgA/FgQpk9eTK8k7aQHINTiq//UHko9/I9xBWUqRIeNFvYDoxy7Q6/1dF55O503mUKefUX5fUiLqTysT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170B2C43601;
	Fri, 26 Jan 2024 14:56:33 +0000 (UTC)
Date: Fri, 26 Jan 2024 14:56:31 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <ZbPIH7g2Glh-9UWL@arm.com>
References: <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
 <ZbD2n-BKGbDgMfsB@FVFF77S0Q05N.cambridge.arm.com>
 <ZbEFPbT7vl6HN4lk@arm.com>
 <20240124132719.GF1455070@nvidia.com>
 <ZbFHPTUaBmbHYnwx@arm.com>
 <20240124192634.GJ1455070@nvidia.com>
 <20240125174333.GA2192844@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125174333.GA2192844@nvidia.com>

On Thu, Jan 25, 2024 at 01:43:33PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 24, 2024 at 03:26:34PM -0400, Jason Gunthorpe wrote:
> > The suggestion that it should not have any interleaving instructions
> > and use STP came from our CPU architecture team.
> 
> I got some more details here.
> 
> They point to the ARM publication about write combining
> 
> https://community.arm.com/cfs-file/__key/telligent-evolution-components-attachments/13-150-00-00-00-00-10-12/Understanding_5F00_Write_5F00_Combining_5F00_on_5F00_Arm_5F00_V.1.0.pdf
> 
> specifically to the example code using 4x 128 bit NEON stores.

That's an example but this document doesn't make any statements about
64-bit writes.

> They point at the actual CPU design and say it is optimized for 128
> bit stores (STP and ST4 included, it seems).
> 
> 64 bit stores trigger some different behavior.

This is highly microarchitecture specific. The best bet in the future is
the ST64B instruction but in the meantime it's pretty much guessing.

> I have no way to know if it will be OK for other drivers that expect
> this to be a performance path in the kernel.
> 
> Are you *sure* you want to do this str version? If it works for mlx5 I
> will send the patch and the other companies can come later with
> performance data.

Yeah, I'd stick to the STR for now, it makes things simpler as we don't
have to care about what emulation does.

-- 
Catalin

