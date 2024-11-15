Return-Path: <linux-arch+bounces-9111-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2EF9CF6DF
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2024 22:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EFE6B2C0CF
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2024 21:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA6D1E2835;
	Fri, 15 Nov 2024 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Vx946PRA"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309381D5ADD;
	Fri, 15 Nov 2024 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731705303; cv=none; b=ibBEVthDbxi8BjSaYaQY6CqaXs3FcF82R7+uPVLfwA/cpjC/nLhmIj3voAClT6LZ/u4QGhuFn5RrMT9qWBBPSzSflsj/skF6ud0k0b5RbD1EPNvFO6HmeIkxRcfFxmjW4ROfueHfeYOTxheF+vbFM6qIoIb8jPpoM62Ma+lH1oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731705303; c=relaxed/simple;
	bh=hmZyID0xTDejqUdHbnNnIfCcRfkvqbnrZ7rK8Oz9WJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=br/Ais40koezOOPn+jEb7ln5YqKYcjbqGzAlwvtq/K2Cw129IUYX5G6YqfLeMcnGlvX2v+Vq78NbODNRgibP6uHBKcB+1sbdgUopq+/CbldGbfGZ/7ntRiUnvWjSTBwdz9pPVfxcWBIPs2vhLSlTFpWNWG+UTIMnP7Ik/YlqLFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Vx946PRA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.115] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6AE7820BEBD0;
	Fri, 15 Nov 2024 13:14:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6AE7820BEBD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705294;
	bh=IOtJqBKEB6hW5aqrE09EdKHehH+hQljR82pxvDiFOrU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vx946PRAHZaunNzhrBN6r6Eunx0XJSwCvezU7p34uq8bmwkx0jTPCzMuPBGb2qBPT
	 A8LE/xwEbQJ+NzGbNgrWZCTjrkQQVzzzg2vG5xZdBjRK88CM1qYOR49k0z4NdpInur
	 6MRDszJnBx80i9qdoXbBprb9zFmFTUmTZOmbumlQ=
Message-ID: <e832dd94-04f3-413a-a1a9-870849b4bc53@linux.microsoft.com>
Date: Fri, 15 Nov 2024 13:14:52 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] hyperv: Switch from hyperv-tlfs.h to
 hyperv/hvhdk.h
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
 "mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "apais@linux.microsoft.com" <apais@linux.microsoft.com>
References: <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1731018746-25914-5-git-send-email-nunodasneves@linux.microsoft.com>
 <BN7PR02MB4148513F8ABA50392E11C616D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <BN7PR02MB4148513F8ABA50392E11C616D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2024 8:13 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, November 7, 2024 2:32 PM
>>
>> Switch to using hvhdk.h everywhere in the kernel. This header includes
>> all the new Hyper-V headers in include/hyperv, which form a superset of
>> the definitions found in hyperv-tlfs.h.
>>
>> This makes it easier to add new Hyper-V interfaces without being
>> restricted to those in the TLFS doc (reflected in hyperv-tlfs.h).
>>
>> To be more consistent with the original Hyper-V code, the names of some
>> definitions are changed slightly. Update those where needed.
>>
>> hyperv-tlfs.h is no longer included anywhere - hvhdk.h can serve
>> the same role, but with an easier path for adding new definitions.
> 
> Is hyperv-tlfs.h and friends being deleted? If not, the risk is that
> someone adds a new #include of it without realizing that it has been
> superseded by hvhdk.h.
> 

I was hesitant to delete it because I thought someone may still have
a use for a header file that (mostly) reflects the TLFS document and
nothing more.

But in practical terms, this patchset makes it much more difficult to
use because all the helper code (i.e. mshyperv.h) now uses hvhdk.h.
So, maybe there is no point keeping it.

> Note also that this patch does not apply cleanly to 6.12 rc's, or to
> current linux-next trees. There's an unrelated #include added to
> arch/x86/include/asm/kvm_host.h that causes a merge failure
> in that file.
> 

I've been developing this series based on hyperv-next. Should I be
basing it on linux-next?

> Michael
> 
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  arch/arm64/hyperv/hv_core.c        |  2 +-
>>  arch/arm64/hyperv/mshyperv.c       |  4 ++--
>>  arch/arm64/include/asm/mshyperv.h  |  2 +-
>>  arch/x86/hyperv/hv_init.c          | 20 ++++++++++----------
>>  arch/x86/hyperv/hv_proc.c          |  2 +-
>>  arch/x86/hyperv/nested.c           |  2 +-
>>  arch/x86/include/asm/kvm_host.h    |  2 +-
>>  arch/x86/include/asm/mshyperv.h    |  2 +-
>>  arch/x86/include/asm/svm.h         |  2 +-
>>  arch/x86/kernel/cpu/mshyperv.c     |  2 +-
>>  arch/x86/kvm/vmx/hyperv_evmcs.h    |  2 +-
>>  arch/x86/kvm/vmx/vmx_onhyperv.h    |  2 +-
>>  drivers/clocksource/hyperv_timer.c |  2 +-
>>  drivers/hv/hv_balloon.c            |  4 ++--
>>  drivers/hv/hv_common.c             |  2 +-
>>  drivers/hv/hv_kvp.c                |  2 +-
>>  drivers/hv/hv_snapshot.c           |  2 +-
>>  drivers/hv/hyperv_vmbus.h          |  2 +-
>>  include/asm-generic/mshyperv.h     |  2 +-
>>  include/clocksource/hyperv_timer.h |  2 +-
>>  include/linux/hyperv.h             |  2 +-
>>  net/vmw_vsock/hyperv_transport.c   |  2 +-
>>  22 files changed, 33 insertions(+), 33 deletions(-)
>>
>> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
>> index 7a746a5a6b42..69004f619c57 100644
>> --- a/arch/arm64/hyperv/hv_core.c
>> +++ b/arch/arm64/hyperv/hv_core.c
>> @@ -14,7 +14,7 @@
>>  #include <linux/arm-smccc.h>
>>  #include <linux/module.h>
>>  #include <asm-generic/bug.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>  #include <asm/mshyperv.h>
>>
>>  /*
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index b1a4de4eee29..fc49949b7df6 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -49,12 +49,12 @@ static int __init hyperv_init(void)
>>  	hv_set_vpreg(HV_REGISTER_GUEST_OS_ID, guest_id);
>>
>>  	/* Get the features and hints from Hyper-V */
>> -	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
>> +	hv_get_vpreg_128(HV_REGISTER_PRIVILEGES_AND_FEATURES_INFO, &result);
>>  	ms_hyperv.features = result.as32.a;
>>  	ms_hyperv.priv_high = result.as32.b;
>>  	ms_hyperv.misc_features = result.as32.c;
>>
>> -	hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &result);
>> +	hv_get_vpreg_128(HV_REGISTER_FEATURES_INFO, &result);
>>  	ms_hyperv.hints = result.as32.a;
>>
>>  	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc
>> 0x%x\n",
>> diff --git a/arch/arm64/include/asm/mshyperv.h
>> b/arch/arm64/include/asm/mshyperv.h
>> index a975e1a689dd..7595fb35fae6 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -20,7 +20,7 @@
>>
>>  #include <linux/types.h>
>>  #include <linux/arm-smccc.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>
>>  /*
>>   * Declare calls to get and set Hyper-V VP register values on ARM64, which
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 1a6354b3e582..3f9aef157c88 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -19,7 +19,7 @@
>>  #include <asm/sev.h>
>>  #include <asm/ibt.h>
>>  #include <asm/hypervisor.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>  #include <asm/mshyperv.h>
>>  #include <asm/idtentry.h>
>>  #include <asm/set_memory.h>
>> @@ -416,24 +416,24 @@ static void __init hv_get_partition_id(void)
>>  static u8 __init get_vtl(void)
>>  {
>>  	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
>> -	struct hv_get_vp_registers_input *input;
>> -	struct hv_get_vp_registers_output *output;
>> +	struct hv_input_get_vp_registers *input;
>> +	struct hv_register_assoc *output;
>>  	unsigned long flags;
>>  	u64 ret;
>>
>>  	local_irq_save(flags);
>>  	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> -	output = (struct hv_get_vp_registers_output *)input;
>> +	output = (struct hv_register_assoc *)input;
>>
>> -	memset(input, 0, struct_size(input, element, 1));
>> -	input->header.partitionid = HV_PARTITION_ID_SELF;
>> -	input->header.vpindex = HV_VP_INDEX_SELF;
>> -	input->header.inputvtl = 0;
>> -	input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
>> +	memset(input, 0, struct_size(input, names, 1));
>> +	input->partition_id = HV_PARTITION_ID_SELF;
>> +	input->vp_index = HV_VP_INDEX_SELF;
>> +	input->input_vtl.as_uint8 = 0;
>> +	input->names[0] = HV_X64_REGISTER_VSM_VP_STATUS;
>>
>>  	ret = hv_do_hypercall(control, input, output);
>>  	if (hv_result_success(ret)) {
>> -		ret = output->as64.low & HV_X64_VTL_MASK;
>> +		ret = output->value.reg8 & HV_X64_VTL_MASK;
>>  	} else {
>>  		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
>>  		BUG();
>> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
>> index b74c06c04ff1..ac4c834d4435 100644
>> --- a/arch/x86/hyperv/hv_proc.c
>> +++ b/arch/x86/hyperv/hv_proc.c
>> @@ -176,7 +176,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index,
>> u32 flags)
>>  		input->partition_id = partition_id;
>>  		input->vp_index = vp_index;
>>  		input->flags = flags;
>> -		input->subnode_type = HvSubnodeAny;
>> +		input->subnode_type = HV_SUBNODE_ANY;
>>  		input->proximity_domain_info = hv_numa_node_to_pxm_info(node);
>>  		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
>>  		local_irq_restore(irq_flags);
>> diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
>> index 9dc259fa322e..1083dc8646f9 100644
>> --- a/arch/x86/hyperv/nested.c
>> +++ b/arch/x86/hyperv/nested.c
>> @@ -11,7 +11,7 @@
>>
>>
>>  #include <linux/types.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>  #include <asm/mshyperv.h>
>>  #include <asm/tlbflush.h>
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 3627eab994a3..38cd609f37c7 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -34,7 +34,7 @@
>>  #include <asm/asm.h>
>>  #include <asm/kvm_page_track.h>
>>  #include <asm/kvm_vcpu_regs.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>
>>  #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
>>
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 47ca48062547..f0564e599b7f 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -6,9 +6,9 @@
>>  #include <linux/nmi.h>
>>  #include <linux/msi.h>
>>  #include <linux/io.h>
>> -#include <asm/hyperv-tlfs.h>
>>  #include <asm/nospec-branch.h>
>>  #include <asm/paravirt.h>
>> +#include <hyperv/hvhdk.h>
>>
>>  /*
>>   * Hyper-V always provides a single IO-APIC at this MMIO address.
>> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
>> index f0dea3750ca9..913af68ad660 100644
>> --- a/arch/x86/include/asm/svm.h
>> +++ b/arch/x86/include/asm/svm.h
>> @@ -5,7 +5,7 @@
>>  #include <uapi/asm/svm.h>
>>  #include <uapi/asm/kvm.h>
>>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>
>>  /*
>>   * 32-bit intercept words in the VMCB Control Area, starting
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index e0fd57a8ba84..be0d1f4491d9 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -20,7 +20,7 @@
>>  #include <linux/random.h>
>>  #include <asm/processor.h>
>>  #include <asm/hypervisor.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>  #include <asm/mshyperv.h>
>>  #include <asm/desc.h>
>>  #include <asm/idtentry.h>
>> diff --git a/arch/x86/kvm/vmx/hyperv_evmcs.h b/arch/x86/kvm/vmx/hyperv_evmcs.h
>> index a543fccfc574..6536290f4274 100644
>> --- a/arch/x86/kvm/vmx/hyperv_evmcs.h
>> +++ b/arch/x86/kvm/vmx/hyperv_evmcs.h
>> @@ -6,7 +6,7 @@
>>  #ifndef __KVM_X86_VMX_HYPERV_EVMCS_H
>>  #define __KVM_X86_VMX_HYPERV_EVMCS_H
>>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>
>>  #include "capabilities.h"
>>  #include "vmcs12.h"
>> diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h
>> b/arch/x86/kvm/vmx/vmx_onhyperv.h
>> index eb48153bfd73..2b94ff301712 100644
>> --- a/arch/x86/kvm/vmx/vmx_onhyperv.h
>> +++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
>> @@ -3,7 +3,7 @@
>>  #ifndef __ARCH_X86_KVM_VMX_ONHYPERV_H__
>>  #define __ARCH_X86_KVM_VMX_ONHYPERV_H__
>>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>  #include <asm/mshyperv.h>
>>
>>  #include <linux/jump_label.h>
>> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
>> index b2a080647e41..c1cc96a168c7 100644
>> --- a/drivers/clocksource/hyperv_timer.c
>> +++ b/drivers/clocksource/hyperv_timer.c
>> @@ -23,7 +23,7 @@
>>  #include <linux/acpi.h>
>>  #include <linux/hyperv.h>
>>  #include <clocksource/hyperv_timer.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>  #include <asm/mshyperv.h>
>>
>>  static struct clock_event_device __percpu *hv_clock_event;
>> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>> index c38dcdfcb914..d792df113962 100644
>> --- a/drivers/hv/hv_balloon.c
>> +++ b/drivers/hv/hv_balloon.c
>> @@ -28,7 +28,7 @@
>>  #include <linux/sizes.h>
>>
>>  #include <linux/hyperv.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>
>>  #include <asm/mshyperv.h>
>>
>> @@ -1585,7 +1585,7 @@ static int hv_free_page_report(struct
>> page_reporting_dev_info *pr_dev_info,
>>  		return -ENOSPC;
>>  	}
>>
>> -	hint->type = HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD;
>> +	hint->heat_type = HV_EXTMEM_HEAT_HINT_COLD_DISCARD;
>>  	hint->reserved = 0;
>>  	for_each_sg(sgl, sg, nents, i) {
>>  		union hv_gpa_page_range *range;
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 9c452bfbd571..9ea05cbbf50d 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -28,7 +28,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/dma-map-ops.h>
>>  #include <linux/set_memory.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>  #include <asm/mshyperv.h>
>>
>>  /*
>> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
>> index d35b60c06114..bfb7a518b4ed 100644
>> --- a/drivers/hv/hv_kvp.c
>> +++ b/drivers/hv/hv_kvp.c
>> @@ -27,7 +27,7 @@
>>  #include <linux/connector.h>
>>  #include <linux/workqueue.h>
>>  #include <linux/hyperv.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>
>>  #include "hyperv_vmbus.h"
>>  #include "hv_utils_transport.h"
>> diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
>> index 0d2184be1691..097ebd58f14e 100644
>> --- a/drivers/hv/hv_snapshot.c
>> +++ b/drivers/hv/hv_snapshot.c
>> @@ -12,7 +12,7 @@
>>  #include <linux/connector.h>
>>  #include <linux/workqueue.h>
>>  #include <linux/hyperv.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>
>>  #include "hyperv_vmbus.h"
>>  #include "hv_utils_transport.h"
>> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
>> index 76ac5185a01a..2bea654858e3 100644
>> --- a/drivers/hv/hyperv_vmbus.h
>> +++ b/drivers/hv/hyperv_vmbus.h
>> @@ -15,10 +15,10 @@
>>  #include <linux/list.h>
>>  #include <linux/bitops.h>
>>  #include <asm/sync_bitops.h>
>> -#include <asm/hyperv-tlfs.h>
>>  #include <linux/atomic.h>
>>  #include <linux/hyperv.h>
>>  #include <linux/interrupt.h>
>> +#include <hyperv/hvhdk.h>
>>
>>  #include "hv_trace.h"
>>
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 8fe7aaab2599..138e416a0f9c 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -25,7 +25,7 @@
>>  #include <linux/cpumask.h>
>>  #include <linux/nmi.h>
>>  #include <asm/ptrace.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>
>>  #define VTPM_BASE_ADDRESS 0xfed40000
>>
>> diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
>> index 6cdc873ac907..a4c81a60f53d 100644
>> --- a/include/clocksource/hyperv_timer.h
>> +++ b/include/clocksource/hyperv_timer.h
>> @@ -15,7 +15,7 @@
>>
>>  #include <linux/clocksource.h>
>>  #include <linux/math64.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>
>>  #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
>>  #define HV_MIN_DELTA_TICKS 1
>> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
>> index d0893ec488ae..ed65b20defea 100644
>> --- a/include/linux/hyperv.h
>> +++ b/include/linux/hyperv.h
>> @@ -24,7 +24,7 @@
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/reciprocal_div.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>
>>  #define MAX_PAGE_BUFFER_COUNT				32
>>  #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
>> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>> index e2157e387217..152b6ed8877d 100644
>> --- a/net/vmw_vsock/hyperv_transport.c
>> +++ b/net/vmw_vsock/hyperv_transport.c
>> @@ -13,7 +13,7 @@
>>  #include <linux/hyperv.h>
>>  #include <net/sock.h>
>>  #include <net/af_vsock.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <hyperv/hvhdk.h>
>>
>>  /* Older (VMBUS version 'VERSION_WIN10' or before) Windows hosts have some
>>   * stricter requirements on the hv_sock ring buffer size of six 4K pages.
>> --
>> 2.34.1


