Return-Path: <linux-arch+bounces-8974-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED929C445C
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 19:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDCAB3248C
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F28F1A9B53;
	Mon, 11 Nov 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U3qtqAJF"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E491A76D5;
	Mon, 11 Nov 2024 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347992; cv=none; b=QIWsv0h8kTBllJAN6madciIUQ4tSyaMzdrK+zrMAcTZ6rDDWlH1nXVE6pw8D7RS57dRa/3s9EQUp53PoboW0r9qTGrEEil4Ce8QoxbHcR2ZC4E0KjVT2npQT1ABDyoYvQUR8USeJIV7luu2q2qD1J/LCHe2585zC9rcIwkgrr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347992; c=relaxed/simple;
	bh=OXz8PGAKsAmwwbSENzkyb9bWe6kDTj8N038P+dU8ZmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFyVPD/nSkpCf55waimAGVY/IdKbXrMtbmYqDhon5OiW1uzRe0c5KgV0PWPeyjQvcu0IeCeaSeDc+opITtdA3CzV/SvotSA8J5Rw/lfmghhhSoKOG08IjdUpfWTh0ffapX7bFCnLYEuUma8jYDjcyw1BOyXGbYwu9kY/0aTGLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U3qtqAJF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.115] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 87E182171FA8;
	Mon, 11 Nov 2024 09:59:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87E182171FA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731347990;
	bh=6ZtSE/zbiO29bga7So1mH/XX9EiAiKPJFgpQdc0RuDA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U3qtqAJFUvj3LJ7K80wastcf4faahRCEaDAvU1OUqLJOFFXiQxRXtoEbkc+o8UiRW
	 muUgkxrJ+AhjB2NPxjjqj69Wen8GJPOLz+pk1e8fdEEhrAs1xmhsbaaMGp4k0wkyl8
	 qTTxXXfKsEU7bfZh+sh8pnHWTh3MamDzBvSX5eXM=
Message-ID: <8f0433ed-4d5a-4ec1-9552-86870419c79c@linux.microsoft.com>
Date: Mon, 11 Nov 2024 09:59:34 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add new headers for Hyper-V Dom0
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
 <BN7PR02MB41485DAD2E066D417FE12020D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <BN7PR02MB41485DAD2E066D417FE12020D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2024 8:12 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, November 7, 2024 2:32 PM
>>
>> To support Hyper-V Dom0 (aka Linux as root partition), many new
>> definitions are required.
> 
> Using "dom0" terminology here and in the Subject: line is likely to
> be confusing to folks who aren't intimately involved in Hyper-V work.
> Previous Linux kernel commit messages and code for running in the
> Hyper-V root partition use "root partition" terminology, and I couldn't
> find "dom0" having been used before. "root partition" would be more
> consistent, and it also matches the public documentation for Hyper-V.
> "dom0" is Xen specific terminology, and having it show up in Hyper-V
> patches would be confusing for the casual reader. I know "dom0" has
> been used internally at Microsoft as shorthand for "Hyper-V root
> partition", but it's probably best to completely avoid such shorthand
> in public Linux kernel patches and code.
> 
> Just my $.02 ....
> 

Noted - I will update the terminology in v3 and generally avoid "Dom0",
except possibly by way of explanation (i.e. to compare it to Xen Dom0).

Thanks
Nuno

>>
>> The plan going forward is to directly import definitions from
>> Hyper-V code without waiting for them to land in the TLFS document.
>> This is a quicker and more maintainable way to import definitions,
>> and is a step toward the eventual goal of exporting headers directly
>> from Hyper-V for use in Linux.
>>
>> This patch series introduces new headers (hvhdk.h, hvgdk.h, etc,
>> see patch #3) derived directly from Hyper-V code. hyperv-tlfs.h is
>> replaced with hvhdk.h (which includes the other new headers)
>> everywhere.
>>
>> No functional change is expected.
>>
>> Summary:
>> Patch 1-2: Minor cleanup patches
>> Patch 3: Add the new headers (hvhdk.h, etc..) in include/hyperv/
>> Patch 4: Switch to the new headers
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>> Changelog:
>> v2:
>> - Rework the series to simply use the new headers everywhere
>>   instead of fiddling around to keep hyperv-tlfs.h used in some
>>   places, suggested by Michael Kelley and Easwar Hariharan
> 
> Thanks! That should be simpler all around.
> 
> Michael
> 
>> - Fix compilation errors with some configs by adding missing
>>   definitions and changing some names, thanks to Simon Horman for
>>   catching those
>> - Add additional definitions to the new headers to support them now
>>   replacing hyperv-tlfs.h everywhere
>> - Add additional context in the commit messages for patches #3 and #4
>> - In patch #2, don't remove indirect includes. Only remove includes
>>   which truly aren't used, suggested by Michael Kelley
>>
>> ---
>> Nuno Das Neves (4):
>>   hyperv: Move hv_connection_id to hyperv-tlfs.h
>>   hyperv: Clean up unnecessary #includes
>>   hyperv: Add new Hyper-V headers in include/hyperv
>>   hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h
>>
>>  arch/arm64/hyperv/hv_core.c        |    3 +-
>>  arch/arm64/hyperv/mshyperv.c       |    4 +-
>>  arch/arm64/include/asm/mshyperv.h  |    2 +-
>>  arch/x86/hyperv/hv_apic.c          |    1 -
>>  arch/x86/hyperv/hv_init.c          |   21 +-
>>  arch/x86/hyperv/hv_proc.c          |    3 +-
>>  arch/x86/hyperv/ivm.c              |    1 -
>>  arch/x86/hyperv/mmu.c              |    1 -
>>  arch/x86/hyperv/nested.c           |    2 +-
>>  arch/x86/include/asm/kvm_host.h    |    3 +-
>>  arch/x86/include/asm/mshyperv.h    |    3 +-
>>  arch/x86/include/asm/svm.h         |    2 +-
>>  arch/x86/kernel/cpu/mshyperv.c     |    2 +-
>>  arch/x86/kvm/vmx/hyperv_evmcs.h    |    2 +-
>>  arch/x86/kvm/vmx/vmx_onhyperv.h    |    2 +-
>>  arch/x86/mm/pat/set_memory.c       |    2 -
>>  drivers/clocksource/hyperv_timer.c |    2 +-
>>  drivers/hv/hv_balloon.c            |    4 +-
>>  drivers/hv/hv_common.c             |    2 +-
>>  drivers/hv/hv_kvp.c                |    2 +-
>>  drivers/hv/hv_snapshot.c           |    2 +-
>>  drivers/hv/hyperv_vmbus.h          |    2 +-
>>  include/asm-generic/hyperv-tlfs.h  |    9 +
>>  include/asm-generic/mshyperv.h     |    2 +-
>>  include/clocksource/hyperv_timer.h |    2 +-
>>  include/hyperv/hvgdk.h             |  303 +++++++
>>  include/hyperv/hvgdk_ext.h         |   46 +
>>  include/hyperv/hvgdk_mini.h        | 1295 ++++++++++++++++++++++++++++
>>  include/hyperv/hvhdk.h             |  733 ++++++++++++++++
>>  include/hyperv/hvhdk_mini.h        |  310 +++++++
>>  include/linux/hyperv.h             |   11 +-
>>  net/vmw_vsock/hyperv_transport.c   |    2 +-
>>  32 files changed, 2729 insertions(+), 52 deletions(-)
>>  create mode 100644 include/hyperv/hvgdk.h
>>  create mode 100644 include/hyperv/hvgdk_ext.h
>>  create mode 100644 include/hyperv/hvgdk_mini.h
>>  create mode 100644 include/hyperv/hvhdk.h
>>  create mode 100644 include/hyperv/hvhdk_mini.h
>>
>> --
>> 2.34.1


