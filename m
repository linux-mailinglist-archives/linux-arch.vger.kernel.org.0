Return-Path: <linux-arch+bounces-10419-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 048F8A474F7
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 06:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0887C3B1598
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 04:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B811E835E;
	Thu, 27 Feb 2025 05:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Bd4YPgQL"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63A03FB0E;
	Thu, 27 Feb 2025 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632400; cv=none; b=INruISpa6ShoVW/nksRGuyRuxc2dcM+HNztnBIOdxFDTEYPR8KFH2AFfeCy5pNmOjDv0nCBOSFAR3vVEVbKUEFMcyuOyv0S86YMgMSaQWsGXgX8W05I/1wdF76jTD+mukt9HO4Lq3fuBFEedGIxakOehdfIGOv88nJ2XSpxmPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632400; c=relaxed/simple;
	bh=tZM6XTfOJi3C13iuQd5oy2JaY3TTl1SUye4RoiDKHGo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OjmaOd4/gIDdxdEEE0ZBBhpJJJUdiu82ThGv13ekEZvQ7mwB3ZN2iABbWyVcJOk0iHuAYmMhZBldWZmWl3+NfHTHRncGNcpj9ke8GZVB2Pv3YtPW5kLZSvFBSi8YVYUc0XlNwQVemKY5Gd/s0KKQ1WR+/bkJCg+2lme4EOU9qiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Bd4YPgQL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.224.197] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 14C3F210C33B;
	Wed, 26 Feb 2025 20:59:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14C3F210C33B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740632398;
	bh=Iea2p7PLsuC3Pv9hWcZqc+g7MssOtTN4ntA2Qor9cYQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Bd4YPgQLvmbfbncvYfFew/zguQ0HiCvJ9aEWoQUT66Fxhg2c83GG4VCicn4NMl6VV
	 IyiUwx/KjkHQ7sR1bQl28wWBQedX+tg9LD8TRuABFxlGaHvLvHBu9o4/+SzhJbQvVn
	 xORRfFxbcKDfCxDjSFQbTdoGYEFlrd8fTVax2D6g=
Message-ID: <8ce2dc94-d4e7-45d7-8228-e8afd2bef3bc@linux.microsoft.com>
Date: Wed, 26 Feb 2025 20:59:55 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
 eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 arnd@arndb.de, jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 3:08 PM, Nuno Das Neves wrote:
> Provide a set of IOCTLs for creating and managing child partitions when
> running as root partition on Hyper-V. The new driver is enabled via
> CONFIG_MSHV_ROOT.
> 
> A brief overview of the interface:
> 
> MSHV_CREATE_PARTITION is the entry point, returning a file descriptor
> representing a child partition. IOCTLs on this fd can be used to map
> memory, create VPs, etc.
> 
> Creating a VP returns another file descriptor representing that VP which
> in turn has another set of corresponding IOCTLs for running the VP,
> getting/setting state, etc.
> 
> MSHV_ROOT_HVCALL is a generic "passthrough" hypercall IOCTL which can be
> used for a number of partition or VP hypercalls. This is for hypercalls
> that do not affect any state in the kernel driver, such as getting and
> setting VP registers and partition properties, translating addresses,
> etc. It is "passthrough" because the binary input and output for the
> hypercall is only interpreted by the VMM - the kernel driver does
> nothing but insert the VP and partition id where necessary (which are
> always in the same place), and execute the hypercall.
> 
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Co-developed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> Co-developed-by: Muminul Islam <muislam@microsoft.com>
> Signed-off-by: Muminul Islam <muislam@microsoft.com>
> Co-developed-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---

I see some issues reported by checkpatch, both vanilla and --strict.
<snip>

Thanks,
Easwar (he/him)

