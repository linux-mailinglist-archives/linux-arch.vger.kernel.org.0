Return-Path: <linux-arch+bounces-13419-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E45B49B5F
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 23:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B76D7B2A57
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 21:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DE62DAFBA;
	Mon,  8 Sep 2025 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sZBDJtvF"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193A723535C;
	Mon,  8 Sep 2025 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365298; cv=none; b=pUp3oWz4JlSfISUoC0V1pck09J3s6UA6kCfg55HNXk2NsLo6YDo4Z6qPUdoDM7OTk7nmn7fOR4RwxmJ4puink8Iyjr4lk8DF6mELfZicU1tBwQtL5550gB5oAtsGzjlUJBw0g+2k9mzXlFYv+mFxLbasDpnUB7tSzclLaJ1huuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365298; c=relaxed/simple;
	bh=Qa3p4r1BGPTbg9JN8Jg7rYA6n7V+dwXJpFgMOWciwh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTI5MBZ/GbljLix0oXPUdyl9GW/ws2RLl9u8ePKobhDrRZFNUCCXY3J2ZfS6mD8fjVoFUDUNGTOeFr4vQIdTiVkiCjEYxIWtL2xmWE+hoCQM6+8hw+96cfDKdq9eCrqmmtowRkRuXH3qs2L+ME3Qc+xHvLlgQGFGmqAIJBggKts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sZBDJtvF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3AF8E2119388;
	Mon,  8 Sep 2025 14:01:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AF8E2119388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757365296;
	bh=8OfRFbMGWhbwHqeXODOj/IPgEc3LWLOaJehvGyq5fVY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sZBDJtvFs9Ofj7nMAu5VU8L0L4nKeDGeNVmFwTGr5mm9ZPuuOp9UCj9Btu+E1vcfa
	 HB/ifrMcHgdgWOwk/crvaI47rWI+1w94qYyPAZve41oYiMcu+vkaoDgD185Gry75ro
	 Z7o4crQc3sp24xFFXTYFnxdnQ96IoHTX58i70aM8=
Message-ID: <d7d7b23f-eaea-2dbc-9c9d-4bee082f6fe7@linux.microsoft.com>
Date: Mon, 8 Sep 2025 14:01:34 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 2/2] Drivers: hv: Make CONFIG_HYPERV bool
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-arch@vger.kernel.org, virtualization@lists.linux.dev,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, dmitry.torokhov@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bhelgaas@google.com,
 James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 deller@gmx.de, arnd@arndb.de, sgarzare@redhat.com, horms@kernel.org
References: <20250906010952.2145389-1-mrathor@linux.microsoft.com>
 <20250906010952.2145389-3-mrathor@linux.microsoft.com>
 <2025090621-rumble-cost-2c0d@gregkh>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <2025090621-rumble-cost-2c0d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/25 04:36, Greg KH wrote:
> On Fri, Sep 05, 2025 at 06:09:52PM -0700, Mukesh Rathor wrote:
>> With CONFIG_HYPERV and CONFIG_HYPERV_VMBUS separated, change CONFIG_HYPERV
>> to bool from tristate. CONFIG_HYPERV now becomes the core Hyper-V
>> hypervisor support, such as hypercalls, clocks/timers, Confidential
>> Computing setup, PCI passthru, etc. that doesn't involve VMBus or VMBus
>> devices.
> 
> But why are you making it so that this can not be a module anymore?  You
> are now forcing ALL Linux distro users to always have this code in their
> system, despite not ever using the feature.  That feels like a waste to
> me.
> 
> What is preventing this from staying as a module?  Why must you always
> have this code loaded at all times for everyone?

This is currently not a module. I assume it was at the beginning. In
drivers/Makefile today:

obj-$(subst m,y,$(CONFIG_HYPERV))       += hv/


More context: CONFIG_HYPERV doesn't really reflect one module. It is
both for kernel built in code and building of stuff in drivers/hv.

drivers/hv then builds 4 modules:

obj-$(CONFIG_HYPERV)            += hv_vmbus.o
obj-$(CONFIG_HYPERV_UTILS)      += hv_utils.o
obj-$(CONFIG_HYPERV_BALLOON)    += hv_balloon.o
obj-$(CONFIG_MSHV_ROOT)         += mshv_root.o

Notice vmbus is using CONFIG_HYPERV because there is no 
CONFIG_HYPERV_VMBUS. We are trying to fix that here.

Thanks,
-Mukesh

> thanks,
> 
> greg k-h


