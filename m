Return-Path: <linux-arch+bounces-8434-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0804C9ABAB3
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 02:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267CF1C22D5A
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 00:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF87C18E20;
	Wed, 23 Oct 2024 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ptq/Asv6"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C2E1C6A3;
	Wed, 23 Oct 2024 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644668; cv=none; b=sImg5hSQ9ZGCzSDmmiK6WLThYWdW9r7Ktf5I6sQ8PYYZ8mvzsqO4RsMIyV3CdB0nAice+r5ffCfuj/6KNJQ4/r54NvO4ZvqTVAqTyrJ79ypxEV3RnKG4/60UUMaCT5gb8R/lLd25W+yncH0so9eVp1Vxxwun9J5lUTE6GFZPYvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644668; c=relaxed/simple;
	bh=2CicPGy2glP1mUqm5CAPj05xgBoGuI0XdTJxJxXKrDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8mfOGrSL+Cyp0D+wTbJLEL2Z8k1WE35Gar1ofxumN6D8VA8EP6Bs2xK1TJedCWyfuoQ8i8KdbZVAm4ubIfwjoOW649jL8Pmbkp+mGjMA0ll/QwZwDYm837+N83YGFoa58fyl+3X/En34BFVLHGp3Q3u72bBtGWgBH4unkbvrDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ptq/Asv6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id E31B820FC5F2;
	Tue, 22 Oct 2024 17:51:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E31B820FC5F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729644666;
	bh=zjZeWP3Fn8idOep3PQVo7QwCf4WCY+6296943aRWrJo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ptq/Asv6NOd+j2FY/cwnF8Hu8cTmgTkCKNGmUO8vaWOmDGr2W5C3tiAUiJjUCJHpp
	 D3lFoU5kHF/38OOU7fNrQytJFQx60+KYnIi8VDrVVrWD1Sh/M95SHve4tCkxvaOjyU
	 8mjWFYlVmGMrtAatziaIPXazv+vB8cutE+AlXvbQ=
Message-ID: <725bac7d-5758-44fd-82cc-29fb85d8c53f@linux.microsoft.com>
Date: Tue, 22 Oct 2024 17:51:05 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add new headers for Hyper-V Dom0
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157F6EA7B2454D2F6CBF2ECD4782@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157F6EA7B2454D2F6CBF2ECD4782@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/2024 11:21 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, October 3, 2024 12:51 PM
>>>> An intermediary header "hv_defs.h" is introduced to conditionally
>> include either hyperv-tlfs.h or hvhdk.h. This is required because
>> several headers which today include hyperv-tlfs.h, are shared
>> between Hyper-V and KVM code (e.g. mshyperv.h).
> 
> Have you considered user space code that uses
> include/linux/hyperv.h? Which of the two schemes will it use? That code
> needs to compile correctly on x86 and ARM64 after your changes.
> User space code includes the separate DPDK project, and some of the
> tools in the kernel tree under tools/hv. Anything that uses the
> uio_hv_generic.c driver falls into this category.
> 
Unless I misunderstand something, the uapi code isn't affected at all
by this patch set. e.g. the code in tools/hv uses include/uapi/linux/hyperv.h,
which doesn't include any other Hyper-V headers.

I'm not aware of how the DPDK project uses the Hyper-V definitions, but if it
is getting headers from uapi it should also be unaffected.

> I think there's also user space code that is built for vDSO that might pull
> in the .h files you are modifying. There are in-progress patches dealing
> with vDSO include files, such as [1]. My general comment on vDSO
> is to be careful in making #include file changes that it uses, but I'm
> not knowledgeable enough on how vDSO is built to give specific
> guidance. :-(
> 
Hmm, interesting, looks like it does get used by userspace. The tsc page
is mapped into userspace in vdso.vma.c, and read in vdso/gettimeofday.h.

That is unexpected for me, since these things aren't in uapi. However I don't
anticipate a problem. The definitions used haven't changed, just the headers
they are included from.

Thanks
Nuno

> Michael
> 
> [1] https://lore.kernel.org/lkml/20241010135146.181175-1-vincenzo.frascino@arm.com/
> 
>>
>> Summary:
>> Patch 1-2: Cleanup patches
>> Patch 3: Add the new headers (hvhdk.h, etc..) in include/hyperv/
>> Patch 4: Add hv_defs.h and use it in mshyperv.h, svm.h,
>>          hyperv_timer.h
>> Patch 5: Switch to the new headers, only in Hyper-V code
>>
>> Nuno Das Neves (5):
>>   hyperv: Move hv_connection_id to hyperv-tlfs.h
>>   hyperv: Remove unnecessary #includes
>>   hyperv: Add new Hyper-V headers
>>   hyperv: Add hv_defs.h to conditionally include hyperv-tlfs.h or
>>     hvhdk.h
>>   hyperv: Use hvhdk.h instead of hyperv-tlfs.h in Hyper-V code
>>
>>  arch/arm64/hyperv/hv_core.c              |    3 +-
>>  arch/arm64/hyperv/mshyperv.c             |    1 +
>>  arch/arm64/include/asm/mshyperv.h        |    2 +-
>>  arch/x86/entry/vdso/vma.c                |    1 +
>>  arch/x86/hyperv/hv_apic.c                |    2 +-
>>  arch/x86/hyperv/hv_init.c                |    3 +-
>>  arch/x86/hyperv/hv_proc.c                |    4 +-
>>  arch/x86/hyperv/hv_spinlock.c            |    1 +
>>  arch/x86/hyperv/hv_vtl.c                 |    1 +
>>  arch/x86/hyperv/irqdomain.c              |    1 +
>>  arch/x86/hyperv/ivm.c                    |    2 +-
>>  arch/x86/hyperv/mmu.c                    |    2 +-
>>  arch/x86/hyperv/nested.c                 |    2 +-
>>  arch/x86/include/asm/kvm_host.h          |    1 -
>>  arch/x86/include/asm/mshyperv.h          |    3 +-
>>  arch/x86/include/asm/svm.h               |    2 +-
>>  arch/x86/include/asm/vdso/gettimeofday.h |    1 +
>>  arch/x86/kernel/cpu/mshyperv.c           |    2 +-
>>  arch/x86/kernel/cpu/mtrr/generic.c       |    1 +
>>  arch/x86/kvm/vmx/vmx_onhyperv.h          |    1 -
>>  arch/x86/mm/pat/set_memory.c             |    2 -
>>  drivers/clocksource/hyperv_timer.c       |    2 +-
>>  drivers/hv/channel.c                     |    1 +
>>  drivers/hv/channel_mgmt.c                |    1 +
>>  drivers/hv/connection.c                  |    1 +
>>  drivers/hv/hv.c                          |    1 +
>>  drivers/hv/hv_balloon.c                  |    5 +-
>>  drivers/hv/hv_common.c                   |    2 +-
>>  drivers/hv/hv_kvp.c                      |    1 -
>>  drivers/hv/hv_snapshot.c                 |    1 -
>>  drivers/hv/hv_util.c                     |    1 +
>>  drivers/hv/hyperv_vmbus.h                |    1 -
>>  drivers/hv/ring_buffer.c                 |    1 +
>>  drivers/hv/vmbus_drv.c                   |    1 +
>>  drivers/iommu/hyperv-iommu.c             |    1 +
>>  drivers/net/hyperv/netvsc.c              |    1 +
>>  drivers/pci/controller/pci-hyperv.c      |    1 +
>>  include/asm-generic/hyperv-tlfs.h        |    9 +
>>  include/asm-generic/mshyperv.h           |    2 +-
>>  include/clocksource/hyperv_timer.h       |    2 +-
>>  include/hyperv/hv_defs.h                 |   29 +
>>  include/hyperv/hvgdk.h                   |   66 ++
>>  include/hyperv/hvgdk_ext.h               |   46 +
>>  include/hyperv/hvgdk_mini.h              | 1212 ++++++++++++++++++++++
>>  include/hyperv/hvhdk.h                   |  733 +++++++++++++
>>  include/hyperv/hvhdk_mini.h              |  310 ++++++
>>  include/linux/hyperv.h                   |   12 +-
>>  net/vmw_vsock/hyperv_transport.c         |    1 -
>>  48 files changed, 2442 insertions(+), 40 deletions(-)
>>  create mode 100644 include/hyperv/hv_defs.h
>>  create mode 100644 include/hyperv/hvgdk.h
>>  create mode 100644 include/hyperv/hvgdk_ext.h
>>  create mode 100644 include/hyperv/hvgdk_mini.h
>>  create mode 100644 include/hyperv/hvhdk.h
>>  create mode 100644 include/hyperv/hvhdk_mini.h
>>
>> --
>> 2.34.1
>>
> 


