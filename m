Return-Path: <linux-arch+bounces-1723-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A624483DE66
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 17:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41054B21541
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDD41D54C;
	Fri, 26 Jan 2024 16:15:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFF91D545;
	Fri, 26 Jan 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706285722; cv=none; b=hjqqCAkn+UIn7M+QstEUFCnkXnWSjXeAfFPdqRxtwBT34byn37tnKjNQ0nE2fm6jduoYE36kCyI09E3L59GxUJjQg4UCV9H7MrbsV1z/ui+wGnnz5uZDSRGuGnXiqKc3OWoF0xxAv3Ms/2auJ3UBM+kyKAygjecKc4QeOaNrK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706285722; c=relaxed/simple;
	bh=r9voGzQRoAoyy3ZC7bd7DKTVtyra9oEHLiIH8NCv9Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wa0T6VSqTV91fKqZyGUlkJo3yPVpI+tYbxRnWCesIX+5Z+4yXGDYQHfBhYvOf2I+rfyAXGRHW6yE4NbZPNqa4Ek29xNGaPOH2exTvRmjzVCCLM+sHMG75b44XHawmd7hYBLtRVy0i6bNIEpTQm9hsRiGTx3OhXET0yCnK8RdbGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE166C43390;
	Fri, 26 Jan 2024 16:15:18 +0000 (UTC)
Date: Fri, 26 Jan 2024 16:15:16 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <ZbPalOaGu4XjMb0R@arm.com>
References: <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
 <20240124012723.GD1455070@nvidia.com>
 <86ede787d7.wl-maz@kernel.org>
 <20240124130638.GE1455070@nvidia.com>
 <86bk9a97rt.wl-maz@kernel.org>
 <20240124155225.GG1455070@nvidia.com>
 <ZbFO6ZXq99AWerlQ@arm.com>
 <20240125012924.GL1455070@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125012924.GL1455070@nvidia.com>

On Wed, Jan 24, 2024 at 09:29:24PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 24, 2024 at 05:54:49PM +0000, Catalin Marinas wrote:
> > On Wed, Jan 24, 2024 at 11:52:25AM -0400, Jason Gunthorpe wrote:
> > > 2) Userspace does ST4 to MMIO memory, and the VMM can't explode
> > >    because of this. Replacing the ST4 with 8x STR is NOT better,
> > >    that would be a big performance downside, especially for the
> > >    quirky hi-silicon hardware.
> > 
> > I was hoping KVM injects an error into the guest rather than killing it
> > but at a quick look I couldn't find it. The kvm_handle_guest_abort() ->
> > io_mem_abort() ends up returning -ENOSYS while handle_trap_exceptions()
> > only understands handled or not (like 1 or 0). Well, maybe I didn't look
> > deep enough.
> 
> It looks to me like qemu turns on the KVM_CAP_ARM_NISV_TO_USER and
> then when it gets a NISV it always converts it to a data abort to the
> guest. See kvm_arm_handle_dabt_nisv() in qemu. So it is just a
> correctness issue, not a 'VM userspace can crash the VMM' security
> problem.

The VMM wasn't my concern but rather a guest getting killed or not
functioning correctly (user app killed).

> Thus, IMHO, doing IO emulation for VFIO that doesn't support all the
> instructions actual existing SW uses to do IO is hard to justify. We
> are already on a slow path that only exists for technical correctness,
> it should be perfect. It is perfect on x86 because x86 KVM does SW
> instruction decode and emulation. ARM could too, but doesn't.

It could fall back to instruction decode, either in KVM or the VMM
(strong preference for the latter), but I'd only do this if it's
justified.

I don't think the issue here is VFIO, I doubt we'd ever see emulation
for hardware like mlx5. But we are changing generic kernel functions
like memcpy_toio/__iowrite64_copy() that end up being used in other
drivers (e.g. USB, UART) for emulated devices. If we can keep these
functions as generic as possible for both guest and native runs, that's
great. If the performance difference is significant, we can revisit.

-- 
Catalin

