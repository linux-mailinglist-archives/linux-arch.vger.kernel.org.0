Return-Path: <linux-arch+bounces-10825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E1A61A62
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 20:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44DA19C4AAF
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 19:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5897B204C3D;
	Fri, 14 Mar 2025 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lcwAW6o9"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FCC1FF1AF;
	Fri, 14 Mar 2025 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980342; cv=none; b=Dodr5lIvTlw4GXHVN86dEMd6w4TkvVge6wkCMd4expOdrKEYwJOrVZMtfv0T3nRwXdk0RE+oN7C81HGe/UjgoKWkS9Y5VkamTW/YwqM5+qMAMZQwwLWKvY5vufVq8aVF+ZQvs492orTlnDcBHaJ4Lv0ZFOPzEF4KdLirr080AFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980342; c=relaxed/simple;
	bh=NAjBZOcRL9XA+Uu28PqNgr5pcAL0JKdI0XNjmjZA0Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IdH6NXv9yp9le3QT5n6rBhwklvL1fL1nQHAM2p/1HWxhl710NQH/RaH4nPjjJyLpp9Oxgna4frbSkBl99XflVtGMiEHelnSazmp4vfaDMRzgJ9exnCJEbKIyrsev4WQUzfc58aSstI84YJMaAzIPfB4AGge2TKMYqySEfvxqIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lcwAW6o9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.107] (76-14-231-56.or.wavecable.com [76.14.231.56])
	by linux.microsoft.com (Postfix) with ESMTPSA id 068C52033454;
	Fri, 14 Mar 2025 12:25:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 068C52033454
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741980333;
	bh=uumL/iMZWLeatJCRzK/5OqmHs1yyifX8CVVlfPUqW88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lcwAW6o9/himPCT2tEXXsKoXHWO8oRb1H+x24X7ywVm5YDb+pGWilcslz1ctKgD2Q
	 GFC+AqJBc2u+TzfWQJOXhlLuVrZvFJflC3ZhteSn1bhAyI+98O5uSfCvvTUlOFsxju
	 DJnw4BKFc9L2OEScqPySBUc6fAC0f5am1INgXf3w=
Message-ID: <c480e790-0abb-41af-a0cb-e358ff7b671f@linux.microsoft.com>
Date: Fri, 14 Mar 2025 12:25:32 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
 <fcd132af-03e4-496d-ba70-0097e90a83cf@oss.qualcomm.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <fcd132af-03e4-496d-ba70-0097e90a83cf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/2025 11:01 AM, Jeff Johnson wrote:
> On 2/26/25 15:08, Nuno Das Neves wrote:
> ...
>> +
>> +MODULE_AUTHOR("Microsoft");
>> +MODULE_LICENSE("GPL");
>> +
> 
> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning with make W=1. Please add a MODULE_DESCRIPTION()
> to avoid this warning.
> 
> This is a canned review based upon finding a MODULE_LICENSE without a
> MODULE_DESCRIPTION.
> 
> /jeff

Thanks Jeff. Fixed in v6.

Nuno

