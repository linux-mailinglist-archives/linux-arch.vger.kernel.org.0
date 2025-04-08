Return-Path: <linux-arch+bounces-11336-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7DEA81219
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 18:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99B71893FE7
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 16:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7676922CBE5;
	Tue,  8 Apr 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j1ES0ym5"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04894218584;
	Tue,  8 Apr 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128979; cv=none; b=iCaT02V3rLXJamBKeUPsyxSaOGfcPQcdH6Q8iBTHjxHMIcRccN1PvugTtzrJCgmiwW+gB+C5SbWwDKk8VC0sLzGzlU0kIjl5ca7/yB9Dg2c3aZoc2xR2iJI4aCcVI7eYDzuyRfdfuZFfpRz3kHFZj9nzHbbLdg/0xh6JQw88v4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128979; c=relaxed/simple;
	bh=/eZ4b8l/VXJtWh+FH94pc5TZfV6mqG/4nYqWaQCWQ8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg+ddZfPOcWwRLJLrGnoUHA4MTgNkLKT/lthF7Y/hCXpH775OjKdEMR6s3Y71GQipcJxG4O6cg7vWYBiG0dVsrozRsBoYlHZfdMHF45j+FIwsXu8YQ63Vpgm4nxRCUWtAKhPLdP1WJIx8ZvBllrMgSThWolC7nLPFA4Rg3CV964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j1ES0ym5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A6912027DEF;
	Tue,  8 Apr 2025 09:16:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A6912027DEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744128977;
	bh=QlxEL9VL5GBxv0J9u6K3DMLa5NYfTy2VRFDYnyudgvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j1ES0ym5sbrgD3pdb0PoqBafFIEPGdc0EYOnjXVL+OYKUrGI2Q1Y40bDZZ+1kq+y8
	 kTo/HsxUdggQ5dhmHYSDjbs/eS47iNdNi+LcisiFu2Bnp0CUSqsDg3kJrhJGChUqNv
	 L7NnLJBQ7avTM3huC+oyN74Y7Q7XMlUJQFpTZvtw=
Message-ID: <c9bea07c-3a0e-41bb-a8d8-12d9f8776e07@linux.microsoft.com>
Date: Tue, 8 Apr 2025 09:16:16 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v7 01/11] arm64: kvm, smccc: Introduce and use
 API for getting hypervisor UUID
To: Marc Zyngier <maz@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dan.carpenter@linaro.org,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com,
 kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, mark.rutland@arm.com, mingo@redhat.com,
 oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org,
 rafael.j.wysocki@intel.com, ssengar@linux.microsoft.com,
 sudeep.holla@arm.com, suzuki.poulose@arm.com, tglx@linutronix.de,
 wei.liu@kernel.org, will@kernel.org, yuzenghui@huawei.com,
 devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250407201336.66913-1-romank@linux.microsoft.com>
 <20250407201336.66913-2-romank@linux.microsoft.com>
 <86semjku7x.wl-maz@kernel.org>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <86semjku7x.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/8/2025 12:06 AM, Marc Zyngier wrote:
> On Mon, 07 Apr 2025 21:13:26 +0100,
> Roman Kisel <romank@linux.microsoft.com> wrote:

[...]

>>   
>>   #include <linux/args.h>
>>   #include <linux/init.h>
>> +
>> +#ifndef __ASSEMBLER__
>> +#include <linux/uuid.h>
>> +#endif
> 
> That's a pretty unusual guard in arm64 land. Looking at the current
> state of the kernel:
> 
> $ git grep -w __ASSEMBLER__ arch/arm64/ | wc -l
> 2
> $ git grep -w __ASSEMBLY__ arch/arm64/ | wc -l
> 122
> 
> I'd suggest the later rather than the former.

Thanks for catching this! I'll be sure to change this to use the arm64
coding conventions in the next version.

> 
> Thanks,
> 
> 	M.
> 

-- 
Thank you,
Roman


