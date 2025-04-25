Return-Path: <linux-arch+bounces-11570-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8A8A9BEA9
	for <lists+linux-arch@lfdr.de>; Fri, 25 Apr 2025 08:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5578D1B66338
	for <lists+linux-arch@lfdr.de>; Fri, 25 Apr 2025 06:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554BE1DFDAB;
	Fri, 25 Apr 2025 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofAFvxRb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1904E137E;
	Fri, 25 Apr 2025 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562678; cv=none; b=f3QDZaD8ldOOZeDgzgxP40Up4MH6jHamwJzUyz3+xDEDV3JAviKKZWMrBc1xAqNxh6bZuK7r9D0sl9zEo6PYF5+eIOSK/AdpqirdpkNI9JL/GG4N5yOkcwpy0yZpJviVMxcVbOqFYFOsI+vIuRp2RyVW+kfBWNYClQ+Klvu7AVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562678; c=relaxed/simple;
	bh=GIqQZ1dCRUDCHo4FeFANi+6joS0iyejlHj27N/oETyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ5aByg2aUeLRZvQXqGhcwpdL/obUy/mV8iSCF0XFm+E1Irjo40Ns6dHbz7fWd+lfupJTVtO9yJOGmsbM1uEiLyyKzEs5Wytv4VWijmP8ecZCor8cruXJUxSzAbX1DdTTkzYHDpUomSI3Xb6AdBt7lzHOA5Hk026+jhP5VFoLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofAFvxRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB92CC4CEE4;
	Fri, 25 Apr 2025 06:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745562677;
	bh=GIqQZ1dCRUDCHo4FeFANi+6joS0iyejlHj27N/oETyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofAFvxRb3i1wsdHnPsZon3UzTa0HMqQEAs49Z8Whb/D8lHfG5gPiZatwVWz7pB/NW
	 dp9oTLlRjQ9fVjS6J4KItmgYIvEwGX43Ns9FUTndfBIOUBIFCLzFFvlvs8MpE0FGo/
	 bwXc6kNmKTGh6CYL8sLsEoBumcqbn1l3cFyBPNiittw3T6RviJqRh0vBuDkl8CAiV6
	 bdcDIzSfiFbdAAbp2wkqpMfpccQgxQiU1BpHvZbCQHeK3ql4xFSHBThRB8+ZP35ZRY
	 3g3Vvn9ckTeisZyBBJytUOX9pIH415/yQ1zvu0pzExHTwVZBfwVYA8KXAQRM50hwOL
	 ++ZgGFIEhlT8w==
Date: Fri, 25 Apr 2025 06:31:15 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: aleksander.lobakin@intel.com, andriy.shevchenko@linux.intel.com,
	arnd@arndb.de, bp@alien8.de, catalin.marinas@arm.com,
	corbet@lwn.net, dakr@kernel.org, dan.j.williams@intel.com,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	gregkh@linuxfoundation.org, haiyangz@microsoft.com, hch@lst.de,
	hpa@zytor.com, James.Bottomley@hansenpartnership.com,
	Jonathan.Cameron@huawei.com, kys@microsoft.com, leon@kernel.org,
	lukas@wunner.de, luto@kernel.org, m.szyprowski@samsung.com,
	martin.petersen@oracle.com, mingo@redhat.com, peterz@infradead.org,
	quic_zijuhu@quicinc.com, robin.murphy@arm.com, tglx@linutronix.de,
	wei.liu@kernel.org, will@kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next 1/6] Documentation: hyperv: Confidential VMBus
Message-ID: <aAssMxyM-TBnyARj@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
 <20250409000835.285105-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409000835.285105-2-romank@linux.microsoft.com>

On Tue, Apr 08, 2025 at 05:08:30PM -0700, Roman Kisel wrote:
> Define what the confidential VMBus is and describe what advantages
> it offers on the capable hardware.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  Documentation/virt/hyperv/vmbus.rst | 41 +++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/virt/hyperv/vmbus.rst b/Documentation/virt/hyperv/vmbus.rst
> index 1dcef6a7fda3..f600e3d09800 100644
> --- a/Documentation/virt/hyperv/vmbus.rst
> +++ b/Documentation/virt/hyperv/vmbus.rst
> @@ -324,3 +324,44 @@ rescinded, neither Hyper-V nor Linux retains any state about
>  its previous existence. Such a device might be re-added later,
>  in which case it is treated as an entirely new device. See
>  vmbus_onoffer_rescind().
> +
> +Confidential VMBus
> +------------------
> +
> +The confidential VMBus provides the control and data planes where
> +the guest doesn't talk to either the hypervisor or the host. Instead,
> +it relies on the trusted paravisor. The hardware (SNP or TDX) encrypts
> +the guest memory and the register state also measuring the paravisor
> +image via using the platform security processor to ensure trsuted and
> +confidential computing.
> +
> +To support confidential communication with the paravisor, a VmBus client

Please be consistent. In this document I see VMBus and VmBus. We should
stick with only one form.

Wei.

