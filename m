Return-Path: <linux-arch+bounces-4471-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1628CA2AE
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 21:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE32C1F2257D
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 19:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2AF1384A8;
	Mon, 20 May 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WQl4upsy"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A44137C41;
	Mon, 20 May 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233139; cv=none; b=A7HarkYwzujTRUhLYFhsBragZujmKrAk6USA6pL4O95xcdJTXjkq11H/9fIt/LT8LU085Lgg2GHRII8/0Ok3Hz2Ag67YIAI776CdCgpdeJL/kjOmfUsuf8YcVR8gtdUvnetiswh4GrZXfzvDD4usO8JawQip2TEPTeYlyav9urw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233139; c=relaxed/simple;
	bh=5LBXzjzDAPTZBUaBcHE7waTQatRc3TVSXvGyu/MVk7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbJenvo1Zs01+zFb/rrMI5f5vvETSkH7nPGmwngr19Iu1kZt7+Md9NHBhvcO0BhAVWFAW/AJHrOpQAJbdW1dxxmlmYwV8cB3vs5qKh38WR8HPpY+A9P3TtI1zLVIcnhLvla9jv2vLlMH/XMx4G1L6ewKKpA4xCTF87ci9blhvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WQl4upsy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86661205421D;
	Mon, 20 May 2024 12:25:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86661205421D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716233136;
	bh=MBxWBiadl4sTqBaO3ScFCEQXblE9CV7k2QIVsB3rijA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WQl4upsytkSNzZMYUQzV1c6k/uK8n/Tv1YX48+vP5jmz2O1aGpKlw9raxHIiMiZ5P
	 B+wcmw0OFEA5NIqDtjca44j/FSezEkjxTUQXuuyOj2+auBaDgpuqexIy8PMHYe2WgC
	 1SS0WAGK5pORppu92rp4lKsTZ8uMRlKBEdno0aPU=
Message-ID: <ec8c1b9e-6ada-49c1-a3e3-47452208d26c@linux.microsoft.com>
Date: Mon, 20 May 2024 12:25:35 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] drivers/hv/vmbus: Get the irq number from
 DeviceTree
To: Rob Herring <robh@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, decui@microsoft.com,
 haiyangz@microsoft.com, hpa@zytor.com, kw@linux.com, kys@microsoft.com,
 lenb@kernel.org, lpieralisi@kernel.org, mingo@redhat.com,
 mhklinux@outlook.com, rafael@kernel.org, tglx@linutronix.de,
 wei.liu@kernel.org, will@kernel.org, linux-acpi@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, x86@kernel.org, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-6-romank@linux.microsoft.com>
 <CAL_JsqKXejxzixzwQO4U_00WAaV_iaEh8Mndf6R5BhLQsgVwLQ@mail.gmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <CAL_JsqKXejxzixzwQO4U_00WAaV_iaEh8Mndf6R5BhLQsgVwLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/17/2024 10:14 AM, Rob Herring wrote:
> On Tue, May 14, 2024 at 5:45 PM Roman Kisel <romank@linux.microsoft.com> wrote:
>>
>> The vmbus driver uses ACPI for interrupt assignment on
>> arm64 hence it won't function in the VTL mode where only
>> DeviceTree can be used.
>>
>> Update the vmbus driver to discover interrupt configuration
>> via DeviceTree.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   drivers/hv/vmbus_drv.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index e25223cee3ab..52f01bd1c947 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/syscore_ops.h>
>>   #include <linux/dma-map-ops.h>
>>   #include <linux/pci.h>
>> +#include <linux/of_irq.h>
> 
> If you are using this header in a driver, you are doing it wrong. We
> have common functions which work on both ACPI or DT, so use them if
> you have a need to support both.
> 
Understood, thank you! I'll look more for the examples. If you happen to 
have in mind the place where the idiomatic/more preferred approach is 
used, please let me know, would owe you a great debt of gratitude.


> Though my first question on a binding will be the same as on every
> 'hypervisor binding'.  Why can't you make your hypervisor interfaces
> discoverable? It's all s/w, not some h/w device which is fixed.
> 
I've taken a look at the related art. AWS's Firecracker, Intel's Cloud 
Hypervisor, Google's CrosVM, QEmu allow the guest use the 
well-established battle-tested generic approaches (ACPI, 
DeviceTree/OpenFirmware) of describing the virtual hardware and its 
resources rather than making the guest use their own specific 
interfaces. That holds true for the s/w devices like 
"vcpu-stall-detector" and VirtIO that do not have counterparts built as 
hardware, too.

Here, the guest needs to set up VMBus (the intra-partition communication 
transport) to be able to talk to the host partition. Receiving a message 
needs an interrupt service routine attached to the interrupt injected 
into the guest virtual processor, and DeviceTree lets provide the 
interrupt number. If a custom interface were used here, it'd look less 
expected due to others relying on ACPI and DT for configuring virtual 
devices and busses. A specialized interface would add more code (new 
code) instead of relying on the approach that is widely used.


> Rob

-- 
Thank you,
Roman

