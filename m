Return-Path: <linux-arch+bounces-4827-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CFE903EF7
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 16:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCCB1C21DBA
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 14:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90A317D8A3;
	Tue, 11 Jun 2024 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZvnjD6af"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E77E17D898;
	Tue, 11 Jun 2024 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116813; cv=none; b=Wd9tvTZymhPSx+43nYQfJYT1w1uB3H9KzDdoukcM+j/LBQQZ5/HTfglf6eGmsQ9itdABCktiFuCGvyELxX3vzYEbxziDvPIesOXFnwqMVMeGn3C6yzjmnxkd3dCyx77YgLQfZVNCbYHZ2aTlYmY+DGIiOd7BXSQehcvGNt26RWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116813; c=relaxed/simple;
	bh=A1FEg7ltx3koVJ0637jaDye1tYyR+9Rknil/cpFqJK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKCJiJItd14X4QWwsSzIsuSApIrNU5WlmJsM1HohHt5hscLjqSpoDHb4ve61pgi8JzlUMaTyNJxreKKRJyFEOSg8FRi5tmZ+VDJDEQ1jLnB5nRP98f8hk1SZZvtp8dHovRsFJo1FSRUyYVuJ3tTy9hn0x4aI+kkXFtr+7AZvw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZvnjD6af; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id DCB6020693FF;
	Tue, 11 Jun 2024 07:40:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCB6020693FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718116806;
	bh=a9CAv3s1qYotxGwtMJnrvJEe5hLreWZBGAxAb4s8gn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZvnjD6afhGDk2GmULYFhxmz04NhcOOEoxvJDet8SrNI3Q4M/Q6VKN38VxszQy1f7Y
	 4gOCRQb/+pd308jL2/KYUBIKmeARbeUJYUGiTnBRIVFgEmr+TVSvrk6xQGBs68tPUC
	 kDRnmKiCvXehq2hUvwvjwi46UiEf3bkSGXWMmUSk=
Message-ID: <be1a6a4c-252e-468b-be67-1ddd158ba957@linux.microsoft.com>
Date: Tue, 11 Jun 2024 07:40:05 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] drivers/pci/hyperv/arm64: vPCI MSI IRQ domain from
 DT
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, arnd@arndb.de,
 bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, kw@linux.com, kys@microsoft.com, lenb@kernel.org,
 lpieralisi@kernel.org, mingo@redhat.com, mhklinux@outlook.com,
 rafael@kernel.org, robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240607195501.GA858122@bhelgaas>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20240607195501.GA858122@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/7/2024 12:55 PM, Bjorn Helgaas wrote:
> On Wed, May 15, 2024 at 01:12:38PM -0500, Bjorn Helgaas wrote:
>> On Wed, May 15, 2024 at 09:34:09AM -0700, Roman Kisel wrote:
>>>
>>>
>>> On 5/15/2024 2:48 AM, Saurabh Singh Sengar wrote:
>>>> On Tue, May 14, 2024 at 03:43:53PM -0700, Roman Kisel wrote:
>>>>> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration
>>>>> on arm64 thereby it won't be able to do that in the VTL mode where
>>>>> only DeviceTree can be used.
>>>>>
>>>>> Update the hyperv-pci driver to discover interrupt configuration
>>>>> via DeviceTree.
>>>>
>>>> Subject prefix should be "PCI: hv:"
> 
> I forgot to also suggest that the subject line begin with a verb,
> e.g., "Get vPCI MSI IRQ domain from DT" or similar, again so it reads
> consistently with previous commits.
> 
> Oh, I see patch 5/6, "Get the irq number from DeviceTree" is also very
> similar.  It would be nice if they matched, e.g., both used "IRQ" and
> "DT".
> 
> Bjorn

Will update, thanks! Going to send another version during the next week 
most likely.

-- 
Thank you,
Roman

