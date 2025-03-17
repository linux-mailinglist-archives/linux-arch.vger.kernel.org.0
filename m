Return-Path: <linux-arch+bounces-10918-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51940A659AD
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 18:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8AD168928
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10011A238C;
	Mon, 17 Mar 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XSBhoPps"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373CE186E2D;
	Mon, 17 Mar 2025 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231263; cv=none; b=O3x7E3zjHpX8sXGjNp6nsU3v2Hk3ylFrx/odf2f3Mq9ENyKPiNoftQ5eNhiPoAvBvZ/zTUwpic9WsfWlFj22ekXAfHKx5VtWMWpUW5mjt+8UfGOT09Oc963Dqb4gx53SYyD+XioW9tOIKlxlXcOqqkUSFfGW1FhMxTkEw70Ma5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231263; c=relaxed/simple;
	bh=JL8vSU7tQ3+QoGzw+/APuflPMIAYCi6VkHHm4HkXgTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RK1Cj9oX2SPhEuB9VMuADce48Eg1s/3NFYgxrOLnE3kr0wN0Ggt7nRlHvgEqGT90huhYQnGahl3eXEOPjcsVKtpgmNk7Hg1y9Jp8fPlbfbRsFgfIHAxU1GoDC265JSslIiPxQJnowASKEN5Tsk5IxKzTmj/SjVHCZizTcaYXw64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XSBhoPps; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7BFBB2033444;
	Mon, 17 Mar 2025 10:07:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7BFBB2033444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742231261;
	bh=PBKO3+sFdf3j+9DusQSeJkY76BUx4yGl9KDAQjeRCo8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XSBhoPpsdkLkmTk3qErtq7Cuq1UaChiFkw6kXGiD9sH8+hspF1i5lsiqiYkjwRCBB
	 iVqT5cJe8xu+9gjgWPR9s5bH/kyVP+cnsNNF6iCaun/zsXbZKBgMHGCF5/NSR3KwU5
	 ysZtQjFJVoI5LvU9qesC/3ZFeWH6kGQ7Jq/AFHfI=
Message-ID: <091001a7-7398-4f5f-b9b6-d220a5a226cb@linux.microsoft.com>
Date: Mon, 17 Mar 2025 10:07:41 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v6 07/11] dt-bindings: microsoft,vmbus: Add
 interrupt and DMA coherence properties
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dan.carpenter@linaro.org,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com,
 kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, mark.rutland@arm.com, maz@kernel.org,
 mingo@redhat.com, oliver.upton@linux.dev, rafael@kernel.org,
 robh@kernel.org, ssengar@linux.microsoft.com, sudeep.holla@arm.com,
 suzuki.poulose@arm.com, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, yuzenghui@huawei.com, devicetree@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
References: <20250315001931.631210-1-romank@linux.microsoft.com>
 <20250315001931.631210-8-romank@linux.microsoft.com>
 <20250316-versed-trogon-of-serendipity-bf7ea7@krzk-bin>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250316-versed-trogon-of-serendipity-bf7ea7@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/16/2025 10:36 AM, Krzysztof Kozlowski wrote:
> On Fri, Mar 14, 2025 at 05:19:27PM -0700, Roman Kisel wrote:
>>   
>> +  dma-coherent: true
>> +
>> +  interrupts:
> 
>> +    maxItems: 1
>> +    description: |
>> +      This interrupt is used to report a message from the host.
> 
> These could be just two lines:
> 
> items:
>    - description: Interrupt used to report a message from the host.
> 
> (and note that just like we do not use "This" in commit msg, there is
> really no benefit of using it in hardware descruption for simple
> statements)
> 

Appreciate your help very much!! Will fix the formatting.

> Regardless:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

-- 
Thank you,
Roman


