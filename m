Return-Path: <linux-arch+bounces-1393-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2009830A57
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 17:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C1F1C230A4
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FD9200C9;
	Wed, 17 Jan 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZJPHtWb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8622305;
	Wed, 17 Jan 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507535; cv=none; b=kjJ0xgD/fHfwVzpMCV1Tmw4fROweGT+N2G7Z+1PjD/vuucXe0hPioUBQRNAl/22K9mCIyZpQ75XjPUDevHFh25GOii6YnV34t+V3qhSG00MLXFDoXf3jh5gkDlhvYUGLEHBvOQMCcEe6DTUAloBtniiHSaj+ftX+cgDSYlrcnrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507535; c=relaxed/simple;
	bh=pEiz2tL8u53kCsBHC+wz183dfYKXhv0Zi1IP8ktIazY=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:User-Agent; b=bTQ4LTKn9Bwi6M/7IRBojxDG2RvWFbI9ROS1OT1HblZHlcsjKoExiep6x8fz32wf3QoJAVFrwdk94JdUj4hBkj7uliZA1BSJTs9JuHVkfE0wgrht3rGjqvHH6RUBG5AjPLMD7C2Mehb5s4v8NuKyMATSRYjuDGo3dh5Uma53QrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZJPHtWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9608EC433C7;
	Wed, 17 Jan 2024 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705507535;
	bh=pEiz2tL8u53kCsBHC+wz183dfYKXhv0Zi1IP8ktIazY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZJPHtWb0J8SqGwN3gxE0ekHZEfliftxNwuDadO0dx9f+1UakNDC8vEAcJga5RGuS
	 TvFe0kZRcV2JcBQxWEo6ujo9hd+OmF6X01WdtVQ1jCXy+lOlu51iTSUtmooVyq50/t
	 8EJ3Q28yzIZHbsHPEplgyQQ8JDix487p4RaWWqCV7QQ6HSBVSBR2OKqWfc5DdzekJm
	 M0gntltklOG2oQU5xWu1BSSwncOGGNyVpavROuo+kIPYCWEJtIdFx2NOKVg/ZYbe2m
	 9xJnPGuKMYCzfy8tVrtwRzs6Mt+7DPR8eCG8dxn91OVZLlfWkmasqja3x+fo2uKRkB
	 7proGVAMDnyKg==
Date: Wed, 17 Jan 2024 16:05:29 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240117160528.GA3398@willie-the-truck>
References: <ZW9cF0ALVwgvcQMy@arm.com>
 <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <ZaffFMJy8cHOvtu8@FVFF77S0Q05N.cambridge.arm.com>
 <20240117152822.GI734935@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117152822.GI734935@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 17, 2024 at 11:28:22AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 17, 2024 at 02:07:16PM +0000, Mark Rutland wrote:
> 
> > > I believe this is for the same reason as doing so in all of our other IO
> > > accessors.
> > > 
> > > We've deliberately ensured that our IO accessors use a single base register
> > > with no offset as this is the only form that HW can represent in ESR_ELx.ISS.SRT
> > > when reporting a stage-2 abort, which a hypervisor may use for emulating IO.
> > 
> > FWIW, IIUC the immediate-offset forms *without* writeback can still be reported
> > usefully in ESR_ELx, so I believe that we could use the "o" constraint for the
> > __raw_write*() functions, e.g.
> > 
> > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > {
> > 	asm volatile("str %x0, %1" : : "rZ" (val), "o" (*(volatile u64 *)addr));
> > }
> 
> "o" works well in the same simple memcpy loop:
> 
>         add     x2, x1, w2, uxtw 3
>         cmp     x1, x2
>         bcs     .L1
> .L3:
>         ldp     x10, x9, [x1]
>         ldp     x8, x7, [x1, 16]
>         ldp     x6, x5, [x1, 32]
>         ldp     x4, x3, [x1, 48]
>         str x10, [x0]
>         str x9, [x0, 8]
>         str x8, [x0, 16]
>         str x7, [x0, 24]
>         str x6, [x0, 32]
>         str x5, [x0, 40]
>         str x4, [x0, 48]
>         str x3, [x0, 56]
>         add     x1, x1, 64
>         add     x0, x0, 64
>         cmp     x2, x1
>         bhi     .L3
> .L1:
>         ret
> 
> Seems intersting to pursue?

I've seen the compiler struggle with plain "o" in the past ("Impossible
constraint in asm") so we might want "Qo" if we go down this route.

Will

