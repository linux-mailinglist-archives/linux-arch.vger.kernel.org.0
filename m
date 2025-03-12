Return-Path: <linux-arch+bounces-10687-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5ADA5E532
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 21:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1042D3B7D66
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 20:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39D51E98E0;
	Wed, 12 Mar 2025 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="opVjwjHW"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C951D5147;
	Wed, 12 Mar 2025 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810706; cv=none; b=GA/rQwI/+4+kGaGCtyfqGL8qEp7wDD75k/Zgye0i5yp1iFkCOGO/YQetamrXdPSAzTqHI4PGPXPz3WvpE0xpGfI/398haZklTiDuOJ/rYlPLOkm4sgdlYcq7H+WXjWmYRY4TAX30YYdtk1xMzuNpoWwW+iLhNalTz0VQiIMn8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810706; c=relaxed/simple;
	bh=pz/a8ZybWgnwBEZ2oost9LBHEmLLK5BCpdayrd/C8qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npLQ/zU1MRwX7ZH4VYCi6Kjw098RNWfg6toD7mLOANsWMGBrVWJnbMhoQfpXrqpOi7NCuY0NgLFGDw7LHEkXFEzt50HfdVgeeqmzmPaEw+xHGpHKvFHHGCnSB04KwTwxAFMJ+BZxgP/oHjNhSebJ4rWrSpXPq/Qma4q88FEhwT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=opVjwjHW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 27F73210B158;
	Wed, 12 Mar 2025 13:18:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 27F73210B158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741810704;
	bh=JIP94RdIzcPShqhb5Ttz2y0m5JI3DqpSY2PdMNKJqh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=opVjwjHW1DYaqZGWtQyH7EhxeIM3Kho3KwKBgx7n/6GH/XYtwElfY1e7qAHlPhqHC
	 sgS0P6cCSzwKt+aJ8KSdu9rflLngi86lSxWbISh3/KwxJMnrHg2raKMXakc5M9OQKY
	 oVsV+EJUhLR5AuapTRuL9NI44ASp+MlPJRHraDNk=
Message-ID: <dba492d0-8640-43c1-80b5-aa8bd1cd618f@linux.microsoft.com>
Date: Wed, 12 Mar 2025 13:17:59 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] hyperv: Add definitions for root partition
 driver to hv headers
To: Tianyu Lan <ltykernel@gmail.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org,
 joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-10-git-send-email-nunodasneves@linux.microsoft.com>
 <CAMvTesB5dCD5Cx+CE8oPQ35OHC+C=tyXbHQ0BNxSABEFVK53Tg@mail.gmail.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <CAMvTesB5dCD5Cx+CE8oPQ35OHC+C=tyXbHQ0BNxSABEFVK53Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/10/2025 5:40 AM, Tianyu Lan wrote:
> On Thu, Feb 27, 2025 at 7:11 AM Nuno Das Neves
> <nunodasneves@linux.microsoft.com> wrote:
>>
>> A few additional definitions are required for the mshv driver code
>> (to follow). Introduce those here and clean up a little bit while
>> at it.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
> 
> It may be better to unify data type u8, u16, u32, u64 or __u8, __u16,
> __u32, __u64 in the hvhdk.h.
> 
Agreed, this was an oversight. They should all be the kernel types
without the __ prefix.

Thanks
Nuno

> Others like good.
> 
> Reviewed-by: Tianyu Lan <tiala@microsoft.com>
> 


