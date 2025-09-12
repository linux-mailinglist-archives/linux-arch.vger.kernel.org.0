Return-Path: <linux-arch+bounces-13518-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C08CCB555DB
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 20:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FCE5C5282
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 18:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5C832A819;
	Fri, 12 Sep 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LQ3BgZpe"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51810302CB2;
	Fri, 12 Sep 2025 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700609; cv=none; b=JxqUS9OQDGgaAyDAAMKec8QM684ZH6xZQwlJnymGck3XTl4lCq6qylYrbvG0jxl+EF6LL/BYS9BQi8VCPovP3V2DomvnuD/n4q1yYJRl9l/41AiPZ1nQuLCa8LlQ6DZkVTRTFUuBhm51kS4MPcR0m97ZZBW9DLY1ah/972CM0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700609; c=relaxed/simple;
	bh=yPJqLt8S5WWM4BObvCnuZSDbc1t/tgpd5gl4wkceEGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3c+crgGM9/fJ1XVtzaq2C74CVkrhehomByFYYJ3536xoME/bMOoI+eCfaFN+QpLEeXimyjuMh1mHTFgsWFMP0cunydtYHzj6hzrZoeg6QfcYcDom9jPyqzvP0axGR48m3M6LnNbhmhdWwc3I8hVBhZEFcjUksr1tpZ8m7qj9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LQ3BgZpe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id ED2B42119CBF;
	Fri, 12 Sep 2025 11:10:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED2B42119CBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757700602;
	bh=HXYJgEfXFwo/OPKrYhrveFvpXwC44rrX+LkCZApziY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LQ3BgZpeMJGwjTLRudlWpMa8SX8RO+j/34vsQaL4PkTvTkI/qkWK/wElTFG4ma7bq
	 8NM3LoJh5HhkcNK+KwwYAoh01/HqKWzw8IdRL8lUGd7y0lqldMU83UUu/URfbdFHiD
	 X8LZ8UBwGVc2sHYIuNq4iAAYSpEmzqL/34I8VDGk=
Message-ID: <a8c8305c-b518-c840-fc64-50bcba302725@linux.microsoft.com>
Date: Fri, 12 Sep 2025 11:10:00 -0700
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
 <d7d7b23f-eaea-2dbc-9c9d-4bee082f6fe7@linux.microsoft.com>
 <2025091253-overwrite-carol-b197@gregkh>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <2025091253-overwrite-carol-b197@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 04:43, Greg KH wrote:
> On Mon, Sep 08, 2025 at 02:01:34PM -0700, Mukesh R wrote:
>> On 9/6/25 04:36, Greg KH wrote:
>>> On Fri, Sep 05, 2025 at 06:09:52PM -0700, Mukesh Rathor wrote:
>>>> With CONFIG_HYPERV and CONFIG_HYPERV_VMBUS separated, change CONFIG_HYPERV
>>>> to bool from tristate. CONFIG_HYPERV now becomes the core Hyper-V
>>>> hypervisor support, such as hypercalls, clocks/timers, Confidential
>>>> Computing setup, PCI passthru, etc. that doesn't involve VMBus or VMBus
>>>> devices.
>>>
>>> But why are you making it so that this can not be a module anymore?  You
>>> are now forcing ALL Linux distro users to always have this code in their
>>> system, despite not ever using the feature.  That feels like a waste to
>>> me.
>>>
>>> What is preventing this from staying as a module?  Why must you always
>>> have this code loaded at all times for everyone?
>>
>> This is currently not a module. I assume it was at the beginning. In
>> drivers/Makefile today:
>>
>> obj-$(subst m,y,$(CONFIG_HYPERV))       += hv/
>>
>>
>> More context: CONFIG_HYPERV doesn't really reflect one module. It is
>> both for kernel built in code and building of stuff in drivers/hv.
>>
>> drivers/hv then builds 4 modules:
>>
>> obj-$(CONFIG_HYPERV)            += hv_vmbus.o
>> obj-$(CONFIG_HYPERV_UTILS)      += hv_utils.o
>> obj-$(CONFIG_HYPERV_BALLOON)    += hv_balloon.o
>> obj-$(CONFIG_MSHV_ROOT)         += mshv_root.o
>>
>> Notice vmbus is using CONFIG_HYPERV because there is no 
>> CONFIG_HYPERV_VMBUS. We are trying to fix that here.
> 
> This series does not apply to my tree:
> 
> checking file drivers/gpu/drm/Kconfig
> checking file drivers/hid/Kconfig
> checking file drivers/hv/Kconfig
> Hunk #2 FAILED at 82.
> 1 out of 2 hunks FAILED
> checking file drivers/hv/Makefile
> checking file drivers/input/serio/Kconfig
> checking file drivers/net/hyperv/Kconfig
> checking file drivers/pci/Kconfig
> checking file drivers/scsi/Kconfig
> checking file drivers/uio/Kconfig
> checking file drivers/video/fbdev/Kconfig
> checking file include/asm-generic/mshyperv.h
> Hunk #1 succeeded at 162 with fuzz 2 (offset -3 lines).
> Hunk #2 succeeded at 198 (offset -3 lines).
> Hunk #3 succeeded at 215 (offset -3 lines).
> checking file net/vmw_vsock/Kconfig
> 
> What was it made against?
> 

Sorry to hear that. It was built against hyper-next, but perhaps I 
accidentally used our internal mirror. Let me rebase and send V2
right away.

Thanks,
-Mukesh




