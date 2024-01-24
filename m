Return-Path: <linux-arch+bounces-1523-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30C083B08D
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 18:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64391C2225C
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 17:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4917412837E;
	Wed, 24 Jan 2024 17:54:55 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266871272CF;
	Wed, 24 Jan 2024 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118895; cv=none; b=frfE0gLzIRVqb+w8mV7LqGqo5+HgIli+oxdc9/TfE2nV0JDV/t8VA5rRNUD3O78bSRjyVqikj10CjkcN6o5W4glKPNEM2jYfEqaTSK/v7H8JcRNqityfIf1S1r71RZbwsVQWEW+30cqE4CQ8p9hAvqQVxEvsyMumlIP4cBGUwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118895; c=relaxed/simple;
	bh=guDVrp7dd6phcaJIS3EhU0IHJ8fEHSsSgATEDK+DPVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsZ+wMkQpdO0tf+M4cQrOL9S3Q4Abp55CcTr3nEwUSdsrdYE6+pxjGJEPy9iA0ifVSOPEDs2xR7xCVhfncBmnvu5F/OxYjK2i0EErznpahA65o9tJ0qbBlJuiAf0mXPRecoWCoKl5NNolynFj4QcnSny782fk0O6grT8RLKIF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0D4C433F1;
	Wed, 24 Jan 2024 17:54:51 +0000 (UTC)
Date: Wed, 24 Jan 2024 17:54:49 +0000
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
Message-ID: <ZbFO6ZXq99AWerlQ@arm.com>
References: <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
 <20240124012723.GD1455070@nvidia.com>
 <86ede787d7.wl-maz@kernel.org>
 <20240124130638.GE1455070@nvidia.com>
 <86bk9a97rt.wl-maz@kernel.org>
 <20240124155225.GG1455070@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124155225.GG1455070@nvidia.com>

On Wed, Jan 24, 2024 at 11:52:25AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 24, 2024 at 01:32:22PM +0000, Marc Zyngier wrote:
> > What I'm saying is that there are way to make it better without
> > breaking your particular toy workload which, as important as it may be
> > to *you*, doesn't cover everybody's use case.
> 
> Please, do we need the "toy" stuff? The industry is spending 10's of
> billions of dollars right now to run "my workload". Currently not
> widely on ARM servers, but we are all hoping ARM can succeed here,
> right?
> 
> I still don't know what you mean by "better". There are several issues
> now
> 
> 1) This series, where WC doesn't trigger on new cores. Maybe 8x STR
>    will fix it, but it is not better performance wise than 4x STP.

It would be good to know. If the performance difference is significant,
we can revisit. I'm not keen on using alternatives here without backing
it up by numbers (do we even have a way to detect whether Linux is
running natively or not? we may have to invent something).

> 2) Userspace does ST4 to MMIO memory, and the VMM can't explode
>    because of this. Replacing the ST4 with 8x STR is NOT better,
>    that would be a big performance downside, especially for the
>    quirky hi-silicon hardware.

I was hoping KVM injects an error into the guest rather than killing it
but at a quick look I couldn't find it. The kvm_handle_guest_abort() ->
io_mem_abort() ends up returning -ENOSYS while handle_trap_exceptions()
only understands handled or not (like 1 or 0). Well, maybe I didn't look
deep enough.

-- 
Catalin

