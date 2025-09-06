Return-Path: <linux-arch+bounces-13392-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12EDB4678D
	for <lists+linux-arch@lfdr.de>; Sat,  6 Sep 2025 02:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0EC21BC7F85
	for <lists+linux-arch@lfdr.de>; Sat,  6 Sep 2025 00:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2517260A;
	Sat,  6 Sep 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eLVt7vFL"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5512BAF9;
	Sat,  6 Sep 2025 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757118849; cv=none; b=l9pZyMxn3kRiv6OCwLpSpbzc50TmMigkwfNbV5dFinlTseGZrqcz51D8ZICYqyWTgK7P80vQRfZnkWLRGKYAQ6/fD28f+3cjDijYT/pJ5+AXgPdVPE/TY3Nxl+DHxgq7EDSsFzz+vbtSSDB9Ha2caRK0dvoxWgJt2k1MHpTRqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757118849; c=relaxed/simple;
	bh=TP8N8QLR9U+mrjw0A8PlowZ5CeNbxOd5HYOykog1Bag=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JGvozzCYyFpHghSfpBXl/qyBO1n9Zk9MUUELH6Dj3tUEafU6Jns/WPiQQ/5DHdlmvFBbCmjPSswIXK7HlNrCUjfdcs8PsTnsTNmyjDyRd90EMB6ydrj4xLyRbKPpRpjh6VGnhpSVr8l30qjeHO2DjSCfxpSSxbEVlNpzg4+rmYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eLVt7vFL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6DC602015BC2;
	Fri,  5 Sep 2025 17:34:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DC602015BC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757118846;
	bh=K9KWTg5ZLVl7JKmxLTmSxxvQ2O5GQtcjCMzsHkL6234=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=eLVt7vFLeSC0ytiq9Xv7/x1KxvNy1tiaw7oeHicQi3PwfK/v2GNKdbtIfZsxPU/O/
	 LcabDr6lkCFB3XuTqQhD/FrI8xtg3N/zbBBR6VmD5sjoAqX7as5aq7z+8C+y7y4+Sq
	 f8qTzLqJfC0wl2zFR+yO6cEvVbIxosD2KE3eTsYc=
Message-ID: <b74712b4-056c-b307-8f85-04241cfd7a57@linux.microsoft.com>
Date: Fri, 5 Sep 2025 17:34:04 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V0 0/2] Fix CONFIG_HYPERV and vmbus related anamoly
Content-Language: en-US
From: Mukesh R <mrathor@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Cc: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "jikos@kernel.org" <jikos@kernel.org>,
 "bentiss@kernel.org" <bentiss@kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "deller@gmx.de" <deller@gmx.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>
References: <20250828005952.884343-1-mrathor@linux.microsoft.com>
 <SN6PR02MB4157917D84D00DBDAF54BD69D406A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ff4c58f1-564d-ddfa-bdff-48ffee6e0d72@linux.microsoft.com>
 <SN6PR02MB41573C5451F21286667C5441D400A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <4f38c613-255c-eaf6-0d50-28f8ffc02fff@linux.microsoft.com>
 <231f05cb-4f33-48ac-bb2e-1359ed52e606@linux.microsoft.com>
 <6a26cbf8-7877-4f39-0ed3-7bbc306f9fe5@linux.microsoft.com>
In-Reply-To: <6a26cbf8-7877-4f39-0ed3-7bbc306f9fe5@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 14:41, Mukesh R wrote:
> On 9/5/25 13:08, Nuno Das Neves wrote:
>> On 9/4/2025 11:18 AM, Mukesh R wrote:
>>> On 9/4/25 09:26, Michael Kelley wrote:
>>>> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Wednesday, September 3, 2025 7:17 PM
>>>>>
>>>>> On 9/2/25 07:42, Michael Kelley wrote:
>>>>>> From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Wednesday, August 27, 2025 6:00 PM
>>>>>>>
>>>>>>> At present, drivers/Makefile will subst =m to =y for CONFIG_HYPERV for hv
>>>>>>> subdir. Also, drivers/hv/Makefile replaces =m to =y to build in
>>>>>>> hv_common.c that is needed for the drivers. Moreover, vmbus driver is
>>>>>>> built if CONFIG_HYPER is set, either loadable or builtin.
>>>>>>>
>>>>>>> This is not a good approach. CONFIG_HYPERV is really an umbrella config that
>>>>>>> encompasses builtin code and various other things and not a dedicated config
>>>>>>> option for VMBUS. Vmbus should really have a config option just like
>>>>>>> CONFIG_HYPERV_BALLOON etc. This small series introduces CONFIG_HYPERV_VMBUS
>>>>>>> to build VMBUS driver and make that distinction explicit. With that
>>>>>>> CONFIG_HYPERV could be changed to bool.
>>>>>>
>>>>>> Separating the core hypervisor support (CONFIG_HYPERV) from the VMBus
>>>>>> support (CONFIG_HYPERV_VMBUS) makes sense to me. Overall the code
>>>>>> is already mostly in separate source files code, though there's some
>>>>>> entanglement in the handling of VMBus interrupts, which could be
>>>>>> improved later.
>>>>>>
>>>>>> However, I have a compatibility concern. Consider this scenario:
>>>>>>
>>>>>> 1) Assume running in a Hyper-V VM with a current Linux kernel version
>>>>>>     built with CONFIG_HYPERV=m.
>>>>>> 2) Grab a new version of kernel source code that contains this patch set.
>>>>>> 3) Run 'make olddefconfig' to create the .config file for the new kernel.
>>>>>> 4) Build the new kernel. This succeeds.
>>>>>> 5) Install and run the new kernel in the Hyper-V VM. This fails.
>>>>>>
>>>>>> The failure occurs because CONFIG_HYPERV=m is no longer legal,
>>>>>> so the .config file created in Step 3 has CONFIG_HYPERV=n. The
>>>>>> newly built kernel has no Hyper-V support and won't run in a
>>>>>> Hyper-V VM.
>>
>> It surprises me a little that =m doesn't get 'fixed up' to =y in this case.
>> I guess any invalid value turns to =n, which makes sense most of the time.
>>
>>>>>>
>>>>>> As a second issue, if in Step 1 the current kernel was built with
>>>>>> CONFIG_HYPERV=y, then the .config file for the new kernel will have
>>>>>> CONFIG_HYPERV=y, which is better. But CONFIG_HYPERV_VMBUS
>>>>>> defaults to 'n', so the new kernel doesn't have any VMBus drivers
>>>>>> and won't run in a typical Hyper-V VM.
>>>>>>
>>>>>> The second issue could be fixed by assigning CONFIG_HYPERV_VMBUS
>>>>>> a default value, such as whatever CONFIG_HYPERV is set to. But
>>>>>> I'm not sure how to fix the first issue, except by continuing to
>>>>>> allow CONFIG_HYPERV=m.
>>
>> I'm wondering, is there a path for this change, then? Are there some
>> intermediate step/s we could take to minimize the problem?
>>
>>>>>
>>>>> To certain extent, imo, users are expected to check config files
>>>>> for changes when moving to new versions/releases, so it would be a
>>>>> one time burden. 
>>>>
>>>> I'm not so sanguine about the impact. For those of us who work with
>>>> Hyper-V frequently, yes, it's probably not that big of an issue -- we can
>>>> figure it out. But a lot of Azure/Hyper-V users aren't that familiar with
>>>> the details of how the Kconfig files are put together. And the issue occurs
>>>> with no error messages that something has gone wrong in building
>>>> the kernel, except that it won't boot. Just running "make olddefconfig"
>>>> has worked in the past, so some users will be befuddled and end up
>>>> generating Azure support incidents. I also wonder about breaking
>>>> automated test suites for new kernels, as they are likely to be running
>>>> "make olddefconfig" or something similar as part of the automation.
>>>>
>>>>> CONFIG_HYPERV=m is just broken imo as one sees that
>>>>> in .config but magically symbols in drivers/hv are in kerenel.
>>>>>
>>>>
>>>> I agree that's not ideal. But note that some Hyper-V code and symbols
>>>> like ms_hyperv_init_platform() and related functions show up when
>>>> CONFIG_HYPERVISOR_GUEST=y, even if CONFIG_HYPERV=n. That's
>>>> the code in arch/x86/kernel/cpu/mshyperv.c and it's because Hyper-V
>>>> is one of the recognized and somewhat hardwired hypervisors (like
>>>> VMware, for example).
>>>>
>>>> Finally, there are about a dozen other places in the kernel that use
>>>> the same Makefile construct to make some code built-in even though
>>>> the CONFIG option is set to "m". That may not be enough occurrences
>>>> to make it standard practice, but Hyper-V guests are certainly not the
>>>> only case.
>>>>
>>>> In my mind, this is judgment call with no absolute right answer. What
>>>> do others think about the tradeoffs?
>>>
>>> Wei had said in private message that he agrees this is a good idea. Nuno
>>> said earlier above: 
>>>
>>> "FWIW I think it's a good idea, interested to hear what others think."
>>>
>> That was before Michael pointed out the potential issues which I was
>> unaware of. Let's see if there's a path that is smoother for all the
>> downstream users who may be compiling with CONFIG_HYPERV=m.
> 
> Ok, we've already thought of it for sometime and not able to come up
> with any. IMO, it's a minor hickup, not major. This is stalling
> upcoming iommu and other patches which will use CONFIG_HYPERV and 
> add more dependencies, and it would be much harder to straighten 
> out then. So I hope you guys can come up with some solution sooner than
> later, I can't think of any.

Played around a bit, setting it to "default HYPERV" like Michael suggested
gives it a default value of y. I thought it fail if one is bool and other
is tristate. So that should help with transition.

Thanks,
-Mukesh



