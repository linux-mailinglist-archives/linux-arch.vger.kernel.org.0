Return-Path: <linux-arch+bounces-8736-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5699B82D4
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 19:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5CE1C21175
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 18:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F8E1B5325;
	Thu, 31 Oct 2024 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eC1OCMqT"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152471386C9;
	Thu, 31 Oct 2024 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400460; cv=none; b=BcWuhupJ9WZOfpZrHIPa3Xhdxbao5Q3PjUtY1xY3ZXQOzBp5IqPxhfAjiY7k+n/tiNQZawCVKIIn4zMbVSzb6/BDBjAMDmmgfa46N5BesA06orU5aqEd9Lz2EdXwz+zTdKi0M/AAS8ixkfXw/7vtdpE8s7pkTT1usCqlb3ojmTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400460; c=relaxed/simple;
	bh=PgnJ+gOr59jRF+AEVpZTxGfNhtTZ7ShoVuDk8To3/mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKpv0L0zPMxEvqQJ0lxLcfZWpw9n3/mHQH0i0r6FT1ROMGLKsfdaVqNub0Nyhb1Egta/GMT3KGcPlkHLEfcVEIgUt0wdsOghHjMCtrJRnTb7AE0ZL4xCVtkWLXsV+CAG7bprvjpFoNRdo92LCH5+tZXXYgnmGdK/Mkem5cgobe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eC1OCMqT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id B32BE20C5D6F;
	Thu, 31 Oct 2024 11:47:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B32BE20C5D6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730400451;
	bh=nff/hc36DIoTlMOGJ09z8nvWVNZRYH5gfv3Ti6i/dfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eC1OCMqT39nv4qeMrmizrUxVULbAWTY3YorJekiK1jSbbjQdno99pAOLs96SQ5QX4
	 KUeN6CwYJHVOkiCVev37eGfclzakwJpvbR/7WUMc2+5sLmJpwU7b5N8wnYgzwyfk1v
	 425UI9/AN5eE4TYcNONqfQr5yQ9dYLkgir2QvEYE=
Message-ID: <90364f44-98e7-4a9a-af57-881cae8e81a7@linux.microsoft.com>
Date: Thu, 31 Oct 2024 11:47:30 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hyperv: Remove unnecessary #includes
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
 <1727985064-18362-3-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41576686E491F8EEA9FDB5F3D4782@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41576686E491F8EEA9FDB5F3D4782@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/2024 11:21 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, October 3, 2024 12:51 PM
>>
>> asm/hyperv-tlfs.h is already included implicitly wherever mshyperv.h
>> or linux/hyperv.h is included. Remove those redundancies.
> 
> I've been under the impression that it is preferable to directly include
> .h files for all definitions that a source code file uses, even if the
> needed .h file is indirectly included by some other .h file. I looked through

I've also heard this idea, and generally try to stick to it. I myself
haven't yet encountered a situation where doing this or not has greatly
impacted the readability of the code.

> the coding style documentation, and didn't find anything addressing
> this topic, so maybe I'm wrong. But I know I've seen patches to other
> parts of the kernel that were changes to follow the direct inclusion
> approach.  Direct inclusion is less fragile if the #include file nesting
> structure changes (and perhaps removes the indirect inclusion).
> 
> The mshyperv.h and linux/hyperv.h dependency on hyperv-tlfs.h is
> highly unlikely to change, so the chance of breakage is minimal. But

You probably already understood this after seeing the later patches, but
it's worth pointing out that the goal of this series is to change that
dependency (situationally), which is exactly why I created this precursor
patch.

> I wonder if your approach is going the wrong direction vs. preferred
> kernel practices.
> 

I could replace <asm/hyperv-tlfs.h> with <hyperv/hvhdk.h> in most of these
cases (in v2), to preserve the explicit include of the definitions before
mshyperv.h or linux/hyperv.h. I will give it a try in v2.

Thanks,
Nuno

> Michael
> 
>>
>> Remove includes of linux/hyperv.h and mshyperv.h where they are not
>> needed.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  arch/arm64/hyperv/hv_core.c        | 2 --
>>  arch/x86/hyperv/hv_apic.c          | 1 -
>>  arch/x86/hyperv/hv_init.c          | 2 --
>>  arch/x86/hyperv/hv_proc.c          | 1 -
>>  arch/x86/hyperv/ivm.c              | 1 -
>>  arch/x86/hyperv/mmu.c              | 1 -
>>  arch/x86/hyperv/nested.c           | 1 -
>>  arch/x86/include/asm/kvm_host.h    | 1 -
>>  arch/x86/include/asm/mshyperv.h    | 1 -
>>  arch/x86/kernel/cpu/mshyperv.c     | 1 -
>>  arch/x86/kvm/vmx/vmx_onhyperv.h    | 1 -
>>  arch/x86/mm/pat/set_memory.c       | 2 --
>>  drivers/clocksource/hyperv_timer.c | 1 -
>>  drivers/hv/hv_balloon.c            | 2 --
>>  drivers/hv/hv_common.c             | 1 -
>>  drivers/hv/hv_kvp.c                | 1 -
>>  drivers/hv/hv_snapshot.c           | 1 -
>>  drivers/hv/hyperv_vmbus.h          | 1 -
>>  net/vmw_vsock/hyperv_transport.c   | 1 -
>>  19 files changed, 23 deletions(-)
>>
>> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
>> index f1ebc025e1df..9d1969b875e9 100644
>> --- a/arch/arm64/hyperv/hv_core.c
>> +++ b/arch/arm64/hyperv/hv_core.c
>> @@ -11,11 +11,9 @@
>>  #include <linux/types.h>
>>  #include <linux/export.h>
>>  #include <linux/mm.h>
>> -#include <linux/hyperv.h>
>>  #include <linux/arm-smccc.h>
>>  #include <linux/module.h>
>>  #include <asm-generic/bug.h>
>> -#include <asm/hyperv-tlfs.h>
>>  #include <asm/mshyperv.h>
>>
>>  /*
>> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
>> index 0569f579338b..f022d5f64fb6 100644
>> --- a/arch/x86/hyperv/hv_apic.c
>> +++ b/arch/x86/hyperv/hv_apic.c
>> @@ -23,7 +23,6 @@
>>  #include <linux/vmalloc.h>
>>  #include <linux/mm.h>
>>  #include <linux/clockchips.h>
>> -#include <linux/hyperv.h>
>>  #include <linux/slab.h>
>>  #include <linux/cpuhotplug.h>
>>  #include <asm/hypervisor.h>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 17a71e92a343..fc3c3d76c181 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -19,7 +19,6 @@
>>  #include <asm/sev.h>
>>  #include <asm/ibt.h>
>>  #include <asm/hypervisor.h>
>> -#include <asm/hyperv-tlfs.h>
>>  #include <asm/mshyperv.h>
>>  #include <asm/idtentry.h>
>>  #include <asm/set_memory.h>
>> @@ -27,7 +26,6 @@
>>  #include <linux/version.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/mm.h>
>> -#include <linux/hyperv.h>
>>  #include <linux/slab.h>
>>  #include <linux/kernel.h>
>>  #include <linux/cpuhotplug.h>
>> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
>> index 3fa1f2ee7b0d..b74c06c04ff1 100644
>> --- a/arch/x86/hyperv/hv_proc.c
>> +++ b/arch/x86/hyperv/hv_proc.c
>> @@ -3,7 +3,6 @@
>>  #include <linux/vmalloc.h>
>>  #include <linux/mm.h>
>>  #include <linux/clockchips.h>
>> -#include <linux/hyperv.h>
>>  #include <linux/slab.h>
>>  #include <linux/cpuhotplug.h>
>>  #include <linux/minmax.h>
>> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
>> index 60fc3ed72830..b56d70612734 100644
>> --- a/arch/x86/hyperv/ivm.c
>> +++ b/arch/x86/hyperv/ivm.c
>> @@ -7,7 +7,6 @@
>>   */
>>
>>  #include <linux/bitfield.h>
>> -#include <linux/hyperv.h>
>>  #include <linux/types.h>
>>  #include <linux/slab.h>
>>  #include <asm/svm.h>
>> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
>> index 1cc113200ff5..cc8c3bd0e7c2 100644
>> --- a/arch/x86/hyperv/mmu.c
>> +++ b/arch/x86/hyperv/mmu.c
>> @@ -1,6 +1,5 @@
>>  #define pr_fmt(fmt)  "Hyper-V: " fmt
>>
>> -#include <linux/hyperv.h>
>>  #include <linux/log2.h>
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>> diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
>> index 9dc259fa322e..ee06d0315c24 100644
>> --- a/arch/x86/hyperv/nested.c
>> +++ b/arch/x86/hyperv/nested.c
>> @@ -11,7 +11,6 @@
>>
>>
>>  #include <linux/types.h>
>> -#include <asm/hyperv-tlfs.h>
>>  #include <asm/mshyperv.h>
>>  #include <asm/tlbflush.h>
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 4a68cb3eba78..3627eab994a3 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -24,7 +24,6 @@
>>  #include <linux/pvclock_gtod.h>
>>  #include <linux/clocksource.h>
>>  #include <linux/irqbypass.h>
>> -#include <linux/hyperv.h>
>>  #include <linux/kfifo.h>
>>
>>  #include <asm/apic.h>
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 390c4d13956d..47ca48062547 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -9,7 +9,6 @@
>>  #include <asm/hyperv-tlfs.h>
>>  #include <asm/nospec-branch.h>
>>  #include <asm/paravirt.h>
>> -#include <asm/mshyperv.h>
>>
>>  /*
>>   * Hyper-V always provides a single IO-APIC at this MMIO address.
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index e0fd57a8ba84..8e8fd23b1439 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -20,7 +20,6 @@
>>  #include <linux/random.h>
>>  #include <asm/processor.h>
>>  #include <asm/hypervisor.h>
>> -#include <asm/hyperv-tlfs.h>
>>  #include <asm/mshyperv.h>
>>  #include <asm/desc.h>
>>  #include <asm/idtentry.h>
>> diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h
>> b/arch/x86/kvm/vmx/vmx_onhyperv.h
>> index eb48153bfd73..f4b081eb6521 100644
>> --- a/arch/x86/kvm/vmx/vmx_onhyperv.h
>> +++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
>> @@ -3,7 +3,6 @@
>>  #ifndef __ARCH_X86_KVM_VMX_ONHYPERV_H__
>>  #define __ARCH_X86_KVM_VMX_ONHYPERV_H__
>>
>> -#include <asm/hyperv-tlfs.h>
>>  #include <asm/mshyperv.h>
>>
>>  #include <linux/jump_label.h>
>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> index 44f7b2ea6a07..85fa0d4509f0 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -32,8 +32,6 @@
>>  #include <asm/pgalloc.h>
>>  #include <asm/proto.h>
>>  #include <asm/memtype.h>
>> -#include <asm/hyperv-tlfs.h>
>> -#include <asm/mshyperv.h>
>>
>>  #include "../mm_internal.h"
>>
>> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
>> index b2a080647e41..1b7de45a7185 100644
>> --- a/drivers/clocksource/hyperv_timer.c
>> +++ b/drivers/clocksource/hyperv_timer.c
>> @@ -23,7 +23,6 @@
>>  #include <linux/acpi.h>
>>  #include <linux/hyperv.h>
>>  #include <clocksource/hyperv_timer.h>
>> -#include <asm/hyperv-tlfs.h>
>>  #include <asm/mshyperv.h>
>>
>>  static struct clock_event_device __percpu *hv_clock_event;
>> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>> index c38dcdfcb914..a120e9b80ded 100644
>> --- a/drivers/hv/hv_balloon.c
>> +++ b/drivers/hv/hv_balloon.c
>> @@ -28,8 +28,6 @@
>>  #include <linux/sizes.h>
>>
>>  #include <linux/hyperv.h>
>> -#include <asm/hyperv-tlfs.h>
>> -
>>  #include <asm/mshyperv.h>
>>
>>  #define CREATE_TRACE_POINTS
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 9c452bfbd571..a5217f837237 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -28,7 +28,6 @@
>>  #include <linux/slab.h>
>>  #include <linux/dma-map-ops.h>
>>  #include <linux/set_memory.h>
>> -#include <asm/hyperv-tlfs.h>
>>  #include <asm/mshyperv.h>
>>
>>  /*
>> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
>> index d35b60c06114..68e73ec7ab28 100644
>> --- a/drivers/hv/hv_kvp.c
>> +++ b/drivers/hv/hv_kvp.c
>> @@ -27,7 +27,6 @@
>>  #include <linux/connector.h>
>>  #include <linux/workqueue.h>
>>  #include <linux/hyperv.h>
>> -#include <asm/hyperv-tlfs.h>
>>
>>  #include "hyperv_vmbus.h"
>>  #include "hv_utils_transport.h"
>> diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
>> index 0d2184be1691..90fc935e89bd 100644
>> --- a/drivers/hv/hv_snapshot.c
>> +++ b/drivers/hv/hv_snapshot.c
>> @@ -12,7 +12,6 @@
>>  #include <linux/connector.h>
>>  #include <linux/workqueue.h>
>>  #include <linux/hyperv.h>
>> -#include <asm/hyperv-tlfs.h>
>>
>>  #include "hyperv_vmbus.h"
>>  #include "hv_utils_transport.h"
>> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
>> index 76ac5185a01a..321770d7ce25 100644
>> --- a/drivers/hv/hyperv_vmbus.h
>> +++ b/drivers/hv/hyperv_vmbus.h
>> @@ -15,7 +15,6 @@
>>  #include <linux/list.h>
>>  #include <linux/bitops.h>
>>  #include <asm/sync_bitops.h>
>> -#include <asm/hyperv-tlfs.h>
>>  #include <linux/atomic.h>
>>  #include <linux/hyperv.h>
>>  #include <linux/interrupt.h>
>> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>> index e2157e387217..f77f0ea1ddad 100644
>> --- a/net/vmw_vsock/hyperv_transport.c
>> +++ b/net/vmw_vsock/hyperv_transport.c
>> @@ -13,7 +13,6 @@
>>  #include <linux/hyperv.h>
>>  #include <net/sock.h>
>>  #include <net/af_vsock.h>
>> -#include <asm/hyperv-tlfs.h>
>>
>>  /* Older (VMBUS version 'VERSION_WIN10' or before) Windows hosts have some
>>   * stricter requirements on the hv_sock ring buffer size of six 4K pages.
>> --
>> 2.34.1
>>


