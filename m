Return-Path: <linux-arch+bounces-10481-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFDEA4A78E
	for <lists+linux-arch@lfdr.de>; Sat,  1 Mar 2025 02:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C296B7AB7C4
	for <lists+linux-arch@lfdr.de>; Sat,  1 Mar 2025 01:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9999735962;
	Sat,  1 Mar 2025 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VBJyQn4I"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3A2182D7;
	Sat,  1 Mar 2025 01:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793086; cv=none; b=YWdiJ2/obK+GnJn9j19Jmt/NaPqI78gYWn+OLuH640PUwMntFweGU1F22evfSlt6JjSowqaazi6ekjMOnR932byeRIsCqif41lcKFDRfKQgW7tSxnFNhcV8CO0A2TTJZvUXUjmZ2tULl4Zy24yo4xjLlnYKkDRi1jWyX4xJwk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793086; c=relaxed/simple;
	bh=MRySq0VswusZ4YKSZr5pKh3kiER+G1pU5MqAUOj/Jtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQdMS6gnHjTXESwSpONQNTfvFcru6vds8706fVgMH9RaYVQq4tQkepkqOmdS747SY9FsaVx2xy8ADN2+aACcWa967IhEUulTva/6Z19GzLKED9Mq0WP9MjXUzrKiuO6WMffyNpQp7z19PZvFU1/jz1fuERZpAz20Jtl9JNWEQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VBJyQn4I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id EABF02038A20;
	Fri, 28 Feb 2025 17:38:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EABF02038A20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740793084;
	bh=SwI2RPp0lc2nI+b9PwlTDvKqHyEE6M7HzsQHovIJa8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VBJyQn4In+Z6OoD5b3tU9zACXIqUuuGyTy9YFEoBwVxvJ8gxMvk7GLb1YfVzwFMNa
	 MZ8P4/K9yMIFqxYCeT9cetKxvXCUpEfmrHCnZy1M1IRPhUWK6daGHv6lNZ/YA/J8gg
	 mlyLZ5ytzxYgjDEsIlhr6XLI37+XeT9ZA3oJ/ehw=
Message-ID: <bcb300dd-762f-495d-9d07-16b81ff70602@linux.microsoft.com>
Date: Fri, 28 Feb 2025 17:38:00 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
To: Roman Kisel <romank@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-acpi@vger.kernel.org
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
 <f332b77a-940f-4007-a44a-de64878d5201@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <f332b77a-940f-4007-a44a-de64878d5201@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/27/2025 10:50 AM, Roman Kisel wrote:
> 
> 
> 
> On 2/26/2025 3:08 PM, Nuno Das Neves wrote:
>> Provide a set of IOCTLs for creating and managing child partitions when
>> running as root partition on Hyper-V. The new driver is enabled via
>> CONFIG_MSHV_ROOT.
>>
> 
> [...]
> 
> 
> As I understood, the changes fall into these buckets:
> 
> 1. Partition management (VPs and memory). Built of the top of fd's which
>    looks as the right approach. There is ref counting etc.
> 2. Scheduling. Here, there is the mature KVM and Xen code dto find
>    inspiration in. Xen being the Type 1 hypervisor should likely be
>    closer to MSHV in my understanding.
> 3. IOCTL code allocation. Not sure how this is allocated yet given that
>    the patch series has been through a multi-year review, that must be
>    settled by now.
> 4. IOCTLs themselves. The majority just marshals data to the
>    hypervisor.
> 
This is a good summary, thanks.

> Despite the rather large size of the patch, I spot-checked the places
> where I have the chance to make an informed decision, and could not find
> anything that'd stand out as suspicious to me. Going to extrapolate that
> the patch itself should be good enough. Given that this code has been in
> development and validation for a few years, I'd vote to merge it. That
> will also enable upstreaming the rest of the VTL mode code that powers
> Azure Boost (https://github.com/microsoft/OHCL-Linux-Kernel)
> 
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> 


