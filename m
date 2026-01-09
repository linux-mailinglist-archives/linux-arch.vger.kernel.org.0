Return-Path: <linux-arch+bounces-15729-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB22D0BEB3
	for <lists+linux-arch@lfdr.de>; Fri, 09 Jan 2026 19:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB54030519E3
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jan 2026 18:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C92D97B7;
	Fri,  9 Jan 2026 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MPFwB040"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF3F28F935;
	Fri,  9 Jan 2026 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984451; cv=none; b=O41zE1K30UDQn0THWSAX5DjgZz0chDeeekRWyaMY7az0KXzVfoJ9so7/V+ztiCEpS/QY1nw61TJ/6Z5yglZztoK1EXxnp99GX2STgm3g9ytCxwU9hufHO7nwkT3agfR60tNrO13t0tpe4SOUQZvKbhEMHW5kuqdnLlgF+DFZcKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984451; c=relaxed/simple;
	bh=QtnFtLB4LQh+GlCunPoUOSHlMjoeOj8zc1rrM5LJF80=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GL08QTTw/XSsi8arAcVIIK13sd6D/1uXJxfp6g08uh62PbvIGTn79qadMqsOT6NjhAOTBwAUJ21hTSCEBAVFtub6yFQ2rfKetHgydFILGKNCxW9Y1CLikXAnkgMzwV4hAiufIpe0z6Scp8mxpFHKxsZRD6UrTrBZVMvYiexQB9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MPFwB040; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id A91A8201AC6A;
	Fri,  9 Jan 2026 10:47:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A91A8201AC6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767984449;
	bh=ESYWZ2JjkmfsLHKybfwiS/s3qSYrQMyZm1VKKiTBTOU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MPFwB040JrbNcca51rqfSX7LD/UkfY9dUmoL8CS42xKRGZ2679/3/vgSmyKN0iydy
	 pNlinI6zhMMziq6q9vaCAzCJPNIsUCNqSKEr3fUXop9LW8H4uqGGmz9PzOQO4DjRUf
	 ktausyPxqb7d/sJmO9WRKFTYBIN0XWuKTB0t1hbQ=
Message-ID: <330d26ac-f1a2-4ee9-8cd7-20fd17db9f92@linux.microsoft.com>
Date: Fri, 9 Jan 2026 10:47:20 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Yu Zhang <zhangyu1@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 easwar.hariharan@linux.microsoft.com, "kys@microsoft.com"
 <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
 "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [RFC v1 3/5] hyperv: Introduce new hypercall interfaces used by
 Hyper-V guest IOMMU
To: Michael Kelley <mhklinux@outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB415755B0CED30E8BEB062942D485A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <SN6PR02MB415755B0CED30E8BEB062942D485A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/2026 10:47 AM, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8, 2025 9:11 PM
>>
>> From: Wei Liu <wei.liu@kernel.org>
>>

<snip>

>> +struct hv_input_get_iommu_capabilities {
>> +	u64 partition_id;
>> +	u64 reserved;
>> +} __packed;
>> +
>> +struct hv_output_get_iommu_capabilities {
>> +	u32 size;
>> +	u16 reserved;
>> +	u8  max_iova_width;
>> +	u8  max_pasid_width;
>> +
>> +#define HV_IOMMU_CAP_PRESENT (1ULL << 0)
>> +#define HV_IOMMU_CAP_S2 (1ULL << 1)
>> +#define HV_IOMMU_CAP_S1 (1ULL << 2)
>> +#define HV_IOMMU_CAP_S1_5LVL (1ULL << 3)
>> +#define HV_IOMMU_CAP_PASID (1ULL << 4)
>> +#define HV_IOMMU_CAP_ATS (1ULL << 5)
>> +#define HV_IOMMU_CAP_PRI (1ULL << 6)
>> +
>> +	u64 iommu_cap;
>> +	u64 pgsize_bitmap;
>> +} __packed;
>> +
>> +enum hv_logical_device_property_code {
>> +	HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU = 10,
>> +};
>> +
>> +struct hv_input_get_logical_device_property {
>> +	u64 partition_id;
>> +	u64 logical_device_id;
>> +	enum hv_logical_device_property_code code;
> 
> Historically we've avoided "enum" types in structures that are part of
> the hypervisor ABI. Use u32 here?

<snip>
What has been the reasoning for that practice? Since the introduction of the
include/hyperv/ headers, we have generally wanted to import as directly as
possible the relevant definitions from the hypervisor code base. If there's
a strong reason, we could consider switching the enum for a u32 here
since, at least for the moment, there's only a single value being used.

Thanks,
Easwar (he/him)


