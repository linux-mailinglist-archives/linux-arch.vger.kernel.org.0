Return-Path: <linux-arch+bounces-13378-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA9EB42FA3
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 04:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA3C567710
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 02:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B71F542A;
	Thu,  4 Sep 2025 02:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i90ZRoOq"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8991EB1A4;
	Thu,  4 Sep 2025 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952201; cv=none; b=Xg5GxgvqUT1kDRRmycwFt8soKzTEmxMKjQry7Xifj3XDsZbXXxiYahU3lO/Fpc2YrIWQvCfxLMZU8oCG1JEDfDq/t4/Z7aVO/1xuhmc5Xv/A/SaqjPRoIpSSyW+tmLZEkTK3zWoPCATVlQTQ3fuiA3YMnTK8Pdtf/YdhNfSCY9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952201; c=relaxed/simple;
	bh=WzRgIr8Nsc96FYUeTDhPpbd74zf/aBMieYBWKFYK56Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHOhL0M3mio8FsfiDv8f0zk+gkcSWGS/JWXSALvcp2mbK4Ymn0mJdOwK2kPvqPIzsi+5GQZ1qQOzgm+f9WIXYoCqkTyukZPPwoKBmPNTPviA3lDXIkKRPys21E8Z7o6UKXPhYkHAghIUwtHqdASabBSTmlR3P7kXrVZrD9OjiiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i90ZRoOq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id AF272211938F;
	Wed,  3 Sep 2025 19:16:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF272211938F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756952198;
	bh=a4jumFB4PVokJK1dGa5tFvFLYvH7VS3Usw/M76NBjRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i90ZRoOq/9PHAR3KCaZxigllW/rJt9761pZoVNcSfG2k0k8yrrQjtXGtzTjhqKYEa
	 vk3MOSjtKtSM1u/8MB2oA8JfxdfTkQF7vk0FOKgSHEWKbplGhjLGN+714eXuU+OkHP
	 v0DqC9hBYEPhR1bpYXVDvxoNQqd7OQ09twpOLTno=
Message-ID: <ff4c58f1-564d-ddfa-bdff-48ffee6e0d72@linux.microsoft.com>
Date: Wed, 3 Sep 2025 19:16:37 -0700
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
To: Michael Kelley <mhklinux@outlook.com>,
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
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157917D84D00DBDAF54BD69D406A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 07:42, Michael Kelley wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Wednesday, August 27, 2025 6:00 PM
>>
>> At present, drivers/Makefile will subst =m to =y for CONFIG_HYPERV for hv
>> subdir. Also, drivers/hv/Makefile replaces =m to =y to build in
>> hv_common.c that is needed for the drivers. Moreover, vmbus driver is
>> built if CONFIG_HYPER is set, either loadable or builtin.
>>
>> This is not a good approach. CONFIG_HYPERV is really an umbrella config that
>> encompasses builtin code and various other things and not a dedicated config
>> option for VMBUS. Vmbus should really have a config option just like
>> CONFIG_HYPERV_BALLOON etc. This small series introduces CONFIG_HYPERV_VMBUS
>> to build VMBUS driver and make that distinction explicit. With that
>> CONFIG_HYPERV could be changed to bool.
> 
> Separating the core hypervisor support (CONFIG_HYPERV) from the VMBus
> support (CONFIG_HYPERV_VMBUS) makes sense to me. Overall the code
> is already mostly in separate source files code, though there's some
> entanglement in the handling of VMBus interrupts, which could be
> improved later.
> 
> However, I have a compatibility concern. Consider this scenario:
> 
> 1) Assume running in a Hyper-V VM with a current Linux kernel version
>     built with CONFIG_HYPERV=m.
> 2) Grab a new version of kernel source code that contains this patch set.
> 3) Run 'make olddefconfig' to create the .config file for the new kernel.
> 4) Build the new kernel. This succeeds.
> 5) Install and run the new kernel in the Hyper-V VM. This fails.
> 
> The failure occurs because CONFIG_HYPERV=m is no longer legal,
> so the .config file created in Step 3 has CONFIG_HYPERV=n. The
> newly built kernel has no Hyper-V support and won't run in a
> Hyper-V VM.
> 
> As a second issue, if in Step 1 the current kernel was built with
> CONFIG_HYPERV=y, then the .config file for the new kernel will have
> CONFIG_HYPERV=y, which is better. But CONFIG_HYPERV_VMBUS
> defaults to 'n', so the new kernel doesn't have any VMBus drivers
> and won't run in a typical Hyper-V VM.
> 
> The second issue could be fixed by assigning CONFIG_HYPERV_VMBUS
> a default value, such as whatever CONFIG_HYPERV is set to. But
> I'm not sure how to fix the first issue, except by continuing to
> allow CONFIG_HYPERV=m. 

To certain extent, imo, users are expected to check config files
for changes when moving to new versions/releases, so it would be a 
one time burden. CONFIG_HYPERV=m is just broken imo as one sees that
in .config but magically symbols in drivers/hv are in kerenel.

Thanks,
-Mukesh


> See additional minor comments in Patches 1 and 2.
> 
> Michael
> 
>>
>> For now, hv_common.c is left as is to reduce conflicts for upcoming patches,
>> but once merges are mostly done, that and some others should be moved to
>> virt/hyperv directory.
>>
>> Mukesh Rathor (2):
>>   hyper-v: Add CONFIG_HYPERV_VMBUS option
>>   hyper-v: Make CONFIG_HYPERV bool
>>
>>  drivers/Makefile               |  2 +-
>>  drivers/gpu/drm/Kconfig        |  2 +-
>>  drivers/hid/Kconfig            |  2 +-
>>  drivers/hv/Kconfig             | 14 ++++++++++----
>>  drivers/hv/Makefile            |  4 ++--
>>  drivers/input/serio/Kconfig    |  4 ++--
>>  drivers/net/hyperv/Kconfig     |  2 +-
>>  drivers/pci/Kconfig            |  2 +-
>>  drivers/scsi/Kconfig           |  2 +-
>>  drivers/uio/Kconfig            |  2 +-
>>  drivers/video/fbdev/Kconfig    |  2 +-
>>  include/asm-generic/mshyperv.h |  8 +++++---
>>  net/vmw_vsock/Kconfig          |  2 +-
>>  13 files changed, 28 insertions(+), 20 deletions(-)
>>
>> --
>> 2.36.1.vfs.0.0
>>


