Return-Path: <linux-arch+bounces-7360-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DD397DABC
	for <lists+linux-arch@lfdr.de>; Sat, 21 Sep 2024 01:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888A4B2160C
	for <lists+linux-arch@lfdr.de>; Fri, 20 Sep 2024 23:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1596018D63B;
	Fri, 20 Sep 2024 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiVeK4hj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D751C693;
	Fri, 20 Sep 2024 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726873991; cv=none; b=SvwB7bl9bMX0mSNMfo4vvSgrZMQtDNID0MKQE2B1BLYj/r5tpa2bFlwY8Jmdy7f+UpTi5I/AxbCWji5nwSeTtlv12DJRwiF3yOsQSDLs1NcJh/WLO8F7TCBnOEHdKrFA7rxrG8gxl1gZMWN+ymSqoOYXMzLFwhLgvwnK/azH28g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726873991; c=relaxed/simple;
	bh=+CbtnYI/5ORGbbRU1OhnMdiA6deltgQ52qYdl/OS+Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tXOty0ZfUUeuE0dJxuNqWS0ppQY0IV4tzWdIPD10nVZtr3h4f/JxgpOVZUkph6CKRRJ3dkeNjUiqGbjthDQrvu9T1dYYU+x7WxQpRgZi476E+jcvqa447fQ2JgZkY6QrYrTtSYaD7BSCPEvXCbHwNl62c8FH9K5ft5Vn1pvfJp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiVeK4hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F1DC4CEC3;
	Fri, 20 Sep 2024 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726873989;
	bh=+CbtnYI/5ORGbbRU1OhnMdiA6deltgQ52qYdl/OS+Ok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kiVeK4hjoJc9Eu0ncckqydFSpzyBITFhQViNa96hU8zj303xNGFlP5l/AVb7YUrW/
	 MMYZmViZSBnoL8LJf9qET6QugL0EZ06S1Q362GvIhgI+Ztf0HBFwagdh6B2697zFfC
	 JH7vqgUw6v8Ym+KYOpW+8mXSPj5ee6M87jdDVRQaFxr+kce6dCfRxRdmBJdhIKFtiX
	 vAMBJdm9mMoWusz0drX9SKUtl3+xqeAuDZY5oWKan0anGqC4fLVvk6rnAOLSXB7p1Q
	 Ev+LIz5XEw7DoW2dMADqySR+8NJ6uRPDzC9l8+P/mBUoz/J5Do3KZ6ZXUwPWoSLUGm
	 /XPnIUTB6M2gw==
Date: Fri, 20 Sep 2024 18:13:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, James.Bottomley@hansenpartnership.com,
	martin.petersen@oracle.com, arnd@arndb.de,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-arch@vger.kernel.org, maz@kernel.org, den@valinux.co.jp,
	jgowans@amazon.com, dawei.li@shingroup.cn
Subject: Re: [RFC 04/12] PCI: hv: Annotate the VMBus channel IRQ name
Message-ID: <20240920231307.GA1073064@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604050940.859909-5-mhklinux@outlook.com>

On Mon, Jun 03, 2024 at 10:09:32PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> In preparation for assigning Linux IRQs to VMBus channels, annotate
> the IRQ name in the single VMBus channel used for setup and teardown
> of a virtual PCI device in a Hyper-V guest. The annotation adds the
> 16-bit PCI domain ID that the Hyper-V vPCI driver assigns to the
> virtual PCI bus for the device.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Seems fine to me.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/controller/pci-hyperv.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 5992280e8110..4f70cddb61dc 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3705,6 +3705,9 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hdev->channel->request_addr_callback = vmbus_request_addr;
>  	hdev->channel->rqstor_size = HV_PCI_RQSTOR_SIZE;
>  
> +	snprintf(hdev->channel->irq_name, VMBUS_CHAN_IRQ_NAME_MAX,
> +				"vpci:%04x", dom);
> +
>  	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
>  			 hv_pci_onchannelcallback, hbus);
>  	if (ret)
> @@ -4018,6 +4021,8 @@ static int hv_pci_resume(struct hv_device *hdev)
>  	hdev->channel->next_request_id_callback = vmbus_next_request_id;
>  	hdev->channel->request_addr_callback = vmbus_request_addr;
>  	hdev->channel->rqstor_size = HV_PCI_RQSTOR_SIZE;
> +	snprintf(hdev->channel->irq_name, VMBUS_CHAN_IRQ_NAME_MAX,
> +				"vpci:%04x", hbus->bridge->domain_nr);
>  
>  	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
>  			 hv_pci_onchannelcallback, hbus);
> -- 
> 2.25.1
> 

