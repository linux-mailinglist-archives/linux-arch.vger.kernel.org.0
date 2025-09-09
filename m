Return-Path: <linux-arch+bounces-13445-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37948B4A228
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 08:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061634E30C2
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 06:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98536305977;
	Tue,  9 Sep 2025 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z0pQ6SS7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A5A302166;
	Tue,  9 Sep 2025 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399014; cv=none; b=pirHo5uUnTrAuNle4ntUsm7sCq2WSG6ai5cx7t+Sx2c0EemI7OfSEC7+PdZGUUkHJAWdZEXMqTx+/91fM6vBm/+D1cEXHOj3jxN6DxZeOkYJiAY8oOp0HS3fPZ9+DZT5QM+2OmjXtDQ4bkiUORqH/Mg9GPHznEcmzbNb2XxOyEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399014; c=relaxed/simple;
	bh=RpvqyvM6Tia415RbHYKNy7KCcVHJVN5DwJEHb6JVKqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaD1QkK70TkyYH3fHnyvk4eAIH6f3QtX/mgONquJhr9BvHOKRdEJEy1EJ2dx/TgZ4bSYb/809hNH+L5nrDf99FUknHVvs19YdX0vAQrfE5/Bq/PesRzobqb8i3gr9rGPVp7gf6YtnAufWd/EcK357C1pQnbzy7WsMJ7bSmxZePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z0pQ6SS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221BFC4CEF5;
	Tue,  9 Sep 2025 06:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757399012;
	bh=RpvqyvM6Tia415RbHYKNy7KCcVHJVN5DwJEHb6JVKqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z0pQ6SS7eR2zJMW725Xm153fb0MmYDN1/F8RX2jDWN2asJKPn77OQKv9tW/ECSX74
	 n91mDIMxCmVgzgjo0XihSloDRxk0DL7XjSz5NeCnILW9zIXDgL3wto4DW60mCvCOnb
	 9v07Qb67+9Mg9qqlyJjeIBBIGn/m4BzYCjgW5pRE=
Date: Tue, 9 Sep 2025 08:23:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-arch@vger.kernel.org, virtualization@lists.linux.dev,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	jikos@kernel.org, bentiss@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	dmitry.torokhov@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bhelgaas@google.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	deller@gmx.de, arnd@arndb.de, sgarzare@redhat.com, horms@kernel.org
Subject: Re: [PATCH v1 2/2] Drivers: hv: Make CONFIG_HYPERV bool
Message-ID: <2025090946-antibody-mortician-d6e1@gregkh>
References: <20250906010952.2145389-1-mrathor@linux.microsoft.com>
 <20250906010952.2145389-3-mrathor@linux.microsoft.com>
 <2025090621-rumble-cost-2c0d@gregkh>
 <d7d7b23f-eaea-2dbc-9c9d-4bee082f6fe7@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7d7b23f-eaea-2dbc-9c9d-4bee082f6fe7@linux.microsoft.com>

On Mon, Sep 08, 2025 at 02:01:34PM -0700, Mukesh R wrote:
> On 9/6/25 04:36, Greg KH wrote:
> > On Fri, Sep 05, 2025 at 06:09:52PM -0700, Mukesh Rathor wrote:
> >> With CONFIG_HYPERV and CONFIG_HYPERV_VMBUS separated, change CONFIG_HYPERV
> >> to bool from tristate. CONFIG_HYPERV now becomes the core Hyper-V
> >> hypervisor support, such as hypercalls, clocks/timers, Confidential
> >> Computing setup, PCI passthru, etc. that doesn't involve VMBus or VMBus
> >> devices.
> > 
> > But why are you making it so that this can not be a module anymore?  You
> > are now forcing ALL Linux distro users to always have this code in their
> > system, despite not ever using the feature.  That feels like a waste to
> > me.
> > 
> > What is preventing this from staying as a module?  Why must you always
> > have this code loaded at all times for everyone?
> 
> This is currently not a module. I assume it was at the beginning. In
> drivers/Makefile today:
> 
> obj-$(subst m,y,$(CONFIG_HYPERV))       += hv/
> 
> 
> More context: CONFIG_HYPERV doesn't really reflect one module. It is
> both for kernel built in code and building of stuff in drivers/hv.
> 
> drivers/hv then builds 4 modules:
> 
> obj-$(CONFIG_HYPERV)            += hv_vmbus.o
> obj-$(CONFIG_HYPERV_UTILS)      += hv_utils.o
> obj-$(CONFIG_HYPERV_BALLOON)    += hv_balloon.o
> obj-$(CONFIG_MSHV_ROOT)         += mshv_root.o
> 
> Notice vmbus is using CONFIG_HYPERV because there is no 
> CONFIG_HYPERV_VMBUS. We are trying to fix that here.

Ah, I missed that this was getting changed in the Makefile in patch 1,
that is what I was worried about.

Nevermind, this should be fine, sorry for the noise.  I'll go queue it
up later today.

greg k-h

