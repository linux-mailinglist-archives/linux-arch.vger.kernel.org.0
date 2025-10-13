Return-Path: <linux-arch+bounces-14056-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5186CBD576E
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 19:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC1DF4E5CDB
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B5E23817D;
	Mon, 13 Oct 2025 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEAssBod"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269C31474CC;
	Mon, 13 Oct 2025 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375931; cv=none; b=J76o7VG9J5MoY8TSVFBE4XBo+EKQMQJ4887tIWqhpq/We8swRBPDfGyqFyiHB+E77jz0Hqe++ZTcq8E/t0fDz7gWrE7R7f0BzNAh7hGRX3xbx4AzkHI/FyuyHoVjgWvSzIWf0Zu89ae8G/JoXi8+C+YMRL8fkRMBl+cKDDQo9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375931; c=relaxed/simple;
	bh=Y2MERDprkb3kMR+/1R9Ry9rEFwG0OBUDXG60Qqf7fTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnFN18zZ5jmW9kb09QkplPcfeHEZMC7lsZ99jgrdZHIfAKxf50Mklzug5FtUYCsSfVqKmG1odGmC7/JUm08NCionfDRdVRoC5AXmuMbrKKVRi1bQRgciLnfRsfHJN3Stwkw9o8jhk3GW/ug5J0Ece5+719wS83XUd31zrKF1fpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEAssBod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DD4C4CEE7;
	Mon, 13 Oct 2025 17:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760375930;
	bh=Y2MERDprkb3kMR+/1R9Ry9rEFwG0OBUDXG60Qqf7fTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEAssBodpy/H2SjEdm70ucFRkyzfFcjqWRYKLYGlDBbLnT8qfTUyhV97pt7z2SNXy
	 r9qjoY/o8vDxu+tr5kRhkRLmC4kdNfYgloAUE3NxioeOMnGSq+UN59Y7Ar7hzdeAkA
	 uuoPpNjbupGqZplE4orOX72EGNa9FZobpi8pKn7WZdfrpCkkVWM081Bk8myrAYjLhf
	 FFT6x0s7rT/Bbkp558vf2iAoQPGAYJ7DGsup8LVDrr88fxT+iM4abDMJtF+deU+Lu9
	 MwiKdCnNQ0kd9lijsLbMADP4R0jUNQumQ+jEm61b5tYjpPeg9xX4IK3hXRkG/ymjzt
	 hJL/k+vhYsUvQ==
Date: Mon, 13 Oct 2025 17:18:49 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, Neeraj.Upadhyay@amd.com,
	tiala@microsoft.com, kvijayab@amd.com, romank@linux.microsoft.com,
	linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 0/5] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
Message-ID: <20251013171849.GA3710129@liuwe-devbox-debian-v2.local>
References: <20250918150023.474021-1-tiala@microsoft.com>
 <aNxiPhrbquYg3PGq@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNxiPhrbquYg3PGq@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>

On Tue, Sep 30, 2025 at 11:05:34PM +0000, Wei Liu wrote:
> On Thu, Sep 18, 2025 at 11:00:18AM -0400, Tianyu Lan wrote:
> > Secure AVIC is a new hardware feature in the AMD64
> > architecture to allow SEV-SNP guests to prevent the
> > hypervisor from generating unexpected interrupts to
> > a vCPU or otherwise violate architectural assumptions
> > around APIC behavior.
> > 
> > Each vCPU has a guest-allocated APIC backing page of
> > size 4K, which maintains APIC state for that vCPU.
> > APIC backing page's ALLOWED_IRR field indicates the
> > interrupt vectors which the guest allows the hypervisor
> > to send.
> > 
> > This patchset is to enable the feature for Hyper-V
> > platform. Patch "Drivers: hv: Allow vmbus message
> > synic interrupt injected from Hyper-V" is to expose
> > new fucntion hv_enable_coco_interrupt() and device
> > driver and arch code may update AVIC backing page
> > ALLOWED_IRR field to allow Hyper-V inject associated
> > vector.
> > 
> > The patchset is based on the tip tree commit 27a17e02418e
> > (x86/sev: Indicate the SEV-SNP guest supports Secure AVIC)
> > 
> > Tianyu Lan (5):
> >   x86/hyperv: Don't use hv apic driver when Secure AVIC is available
> >   drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
> >   x86/hyperv: Don't use auto-eoi when Secure AVIC is available
> >   x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts
> 
> These look good to me.

I applied these four to hyperv-next.

> 
> >   x86/Hyper-V: Add Hyper-V specific hvcall to set backing page
> 
> Please address Borislav's comment on this patch.

This is no longer needed.

Thanks,
Wei

