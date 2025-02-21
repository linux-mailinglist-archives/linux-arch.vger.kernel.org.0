Return-Path: <linux-arch+bounces-10306-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDB0A3FE67
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 19:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C70163C59
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D92512C9;
	Fri, 21 Feb 2025 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pX36bqGy"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6027250BFC;
	Fri, 21 Feb 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161406; cv=none; b=FPllPrucTgJL0VNwT10bCFMSOyswg5amMA+aCaouUas8s/mYzm/3+g4sVIAzTaX8almkb4U4u5H+bNWCVfKOe/PxKk08vkJwOMW3aZJyZky4iH/dVBA0etQyZWYDa90384diu5ExMskGkiXj0K/fxaiXHK3SEpXG7TX6Vw2xb+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161406; c=relaxed/simple;
	bh=pRnZuPrU9M8shnH6T9iQhO7+NmgMgoDkb4KpaM3FRxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpBnXNiF9HlrzupDB6qVXPxAIGlt21Da+JZ+KGrFi42q/tMrSoyTJAPd/q6MkuqWoz9KBLtMVjyI6TOyFTEx6uEFwadqucqm9t32oicyISH9VVz6jAEoBCyoVjdQVl2jq8pRcRTYLpfx73d0NDBF+Ok2diStCYgZncHrso9PHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pX36bqGy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8C1B0204E5BD;
	Fri, 21 Feb 2025 10:10:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C1B0204E5BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740161404;
	bh=ctZGnlszNAEiyGeHFSMVBfLyM+0PtIeMkQSIV0dR0u4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pX36bqGypY/zOUYlEK9rRUK1oLe1vm52665jNhuvSz5Sa6UbfPh4/CJHKykrsbUiM
	 rnsa2fU6iBW0LsdcKXvlWU5d0uU9REHty5Tv6nrMy9+tda4Ka3qgpOGpkTlAyGnkmq
	 pdVs7lrUaUSWdddlBa8cOmnvn1x5zEKi1bApSdP0=
Message-ID: <5ae3454f-61e4-4739-816c-20525e2087be@linux.microsoft.com>
Date: Fri, 21 Feb 2025 10:10:02 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hyperv: Change hv_root_partition into a function
To: MUKESH RATHOR <mukeshrathor@microsoft.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "mhklinux@outlook.com" <mhklinux@outlook.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
References: <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740076396-15086-3-git-send-email-nunodasneves@linux.microsoft.com>
 <5980eaf9-2e77-d0ec-e39b-b48913c8b72f@microsoft.com>
 <a29af204-e4a9-4ef2-b5b8-f99f2ac0a836@linux.microsoft.com>
 <f5366d52-1714-87bc-5fa5-94230f2acca1@microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <f5366d52-1714-87bc-5fa5-94230f2acca1@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/2025 2:59 PM, MUKESH RATHOR wrote:
> 
> 
> On 2/20/25 14:56, Easwar Hariharan wrote:
>  > On 2/20/2025 1:59 PM, MUKESH RATHOR wrote:
>  >>
>  >>
>  >> On 2/20/25 10:33, Nuno Das Neves wrote:
>  >>   > Introduce hv_current_partition_type to store the partition type
>  >>   > as an enum.
>  >>   >
>  >>   > Right now this is limited to guest or root partition, but there will
>  >>   > be other kinds in future and the enum is easily extensible.
>  >>   >
>  >>   > Set up hv_current_partition_type early in Hyper-V initialization
> with
>  >>   > hv_identify_partition_type(). hv_root_partition() just queries this
>  >>   > value, and shouldn't be called before that.
>  >>   >
>  >>   > Making this check into a function sets the stage for adding a config
>  >>   > option to gate the compilation of root partition code. In
> particular,
>  >>   > hv_root_partition() can be stubbed out always be false if root
>  >>   > partition support isn't desired.
>  >>   >
>  >>   > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>  >>   > ---
>  >>   >   arch/arm64/hyperv/mshyperv.c       |  2 ++
>  >>   >   arch/x86/hyperv/hv_init.c          | 10 ++++-----
>  >>   >   arch/x86/kernel/cpu/mshyperv.c     | 24 ++------------------
>  >>   >   drivers/clocksource/hyperv_timer.c |  4 ++--
>  >>   >   drivers/hv/hv.c                    | 10 ++++-----
>  >>   >   drivers/hv/hv_common.c             | 35
> +++++++++++++++++++++++++-----
>  >>   >   drivers/hv/vmbus_drv.c             |  2 +-
>  >>   >   drivers/iommu/hyperv-iommu.c       |  4 ++--
>  >>   >   include/asm-generic/mshyperv.h     | 15 +++++++++++--
>  >>   >   9 files changed, 61 insertions(+), 45 deletions(-)
>  >>   >
>  >
>  > <snip>
>  >
>  >>   > @@ -34,8 +34,11 @@
>  >>   >   u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
>  >>   >   EXPORT_SYMBOL_GPL(hv_current_partition_id);
>  >>   >
>  >>   > +enum hv_partition_type hv_current_partition_type;
>  >>   > +EXPORT_SYMBOL_GPL(hv_current_partition_type);
>  >>   > +
>  >>
>  >> nit: if possible and not too late, can we please use more Unix
>  >> style naming, eg, hv_curr_ptid and hv_curr_pt_type rather than this
>  >> long windows style names that causes unnecessary line wraps/splits.
>  >>
>  >> Thanks,
>  >> -Mukesh
>  >>
>  >
>  > Per
> https://docs.kernel.org/process/coding-style.html#naming
>  >
>  > GLOBAL variables (to be used only if you really need them) need to
> have descriptive names,
>  > as do global functions. If you have a function that counts the number
> of active users,
>  > you should call that count_active_users() or similar, you should not
> call it cntusr().
> 
> Thant's hardly a fair comparison. Suggestion was NOT hvptid.
> 
I'm in favor of shortening the names when the abbreviation is common and
therefore still perfectly clear to anyone reading it - e.g. "curr" is
a perfectly acceptable abbreviation of "current", in my view.

I think abbreviating "partition" to "pt" is probably not a good fit for
global variables. Anyone seeing a variable with the word "partition"
(and hv_ prefix) can go look up what a Hyper-V partition is if they don't
know, but "pt" would be completely impenetrable without reading through a
fair amount of the code that uses it to figure out what it refers to.

I think even slightly longer abbreviations like "part", "ptn", "prt", or
"prtn" are not good enough unfortunately... the word "partition" just
doesn't lend itself to abbreviation in an obvious way.

So, for this patch I'm fine with changing it to "hv_curr_partition_type"
which saves a few characters.

Feel free to post a followup for "hv_curr_partition_id" if you like.

Note - For the driver code which isn't as exposed to the rest of the
kernel, I think we can continue to use "pt" or similar to keep the names
shorter.

Thanks
Nuno

