Return-Path: <linux-arch+bounces-10570-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD5A57030
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 19:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABFB189883A
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 18:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0195C23F296;
	Fri,  7 Mar 2025 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kfOgPVr5"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A5A1A7AF7;
	Fri,  7 Mar 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371160; cv=none; b=Q+hyPWexkKMzytD613ZOeLiM/TsgzBFvwvPEXPGwPtcz3/TeLmgQyHCJMA76jKou1C1q1HW3ZCZG4NYb/c19egrSlJ0lP6FcQhytpNp+Pt5hpamhhvs3DY0UPEFxPgelPDvaCli4Kf2bAO0sz7bfCpwWoRdOrpOYnAOf67MKF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371160; c=relaxed/simple;
	bh=NAWLZyERU1mrVLoBZ/xNqI1pIF9+w43e2HDxORnVkHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHWx48ErSDcDh+QXusIk/0lXAoO7XwueP1iVCsNgsrAJp/DL/VXWqCDwpsvzBqKLgMMn9s+Vs5a0z98qxUBz7HX6LLp1RFXZbqOJDO8jUlNgBsqksSfkpkH4xLctbOxalketQ59WxkmQyBTuJ2urAhHS5jQhlv6MS6XphLwzHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kfOgPVr5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id CAD852038F37;
	Fri,  7 Mar 2025 10:06:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAD852038F37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741370808;
	bh=fkpzWS7kKQxS7iHBM5+/9vLioYcucl4kL46RR98FB2o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kfOgPVr5LJFN2ld3861YnCyoXBzp+thWEeMvJ+YweMjJBiArD9U7tYwudHEyeNoat
	 igt1898SeJwvGyscPq6VaPbrQalQZt8Xwoxkv4MYmortZR1uJCXtyOKomZaHk/Sq4b
	 ZHHPwTwLAQWLTYwV6XCRICP5BGc3MKiHJftH/nzw=
Message-ID: <efb43459-4136-43cd-adac-2179d9985e9d@linux.microsoft.com>
Date: Fri, 7 Mar 2025 10:06:47 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
To: Wei Liu <wei.liu@kernel.org>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, mhklinux@outlook.com, decui@microsoft.com,
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
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
 <f332b77a-940f-4007-a44a-de64878d5201@linux.microsoft.com>
 <Z8ncFkwzxi9qJFD3@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z8ncFkwzxi9qJFD3@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/2025 9:32 AM, Wei Liu wrote:
> On Thu, Feb 27, 2025 at 10:50:30AM -0800, Roman Kisel wrote:

[...]

>> 2. Scheduling. Here, there is the mature KVM and Xen code to find
>>     inspiration in. Xen being the Type 1 hypervisor should likely be
>>     closer to MSHV in my understanding.
> 
> Yes and no.
> 
> When a hypervisor-based scheduler (either classic or core) is used, the
> scheduling model is the same as Xen. In this model, the hypervisor makes
> the scheduling decisions.
> 
> There is a second scheduler model. In that model, the hypervisor
> delegates scheduling to the Linux kernel. The Linux scheduler makes the
> scheduling decisions. It is similar to KVM.
> 
> We support both. Which model to use largely depends on the workload and
> the desired behaviors of the system.
> 
> This is purely informational in case people wonder why the run vp
> function branches off to two different code paths.
> 

Thanks, now I understand that better :)

[...]

>> -- 
>> Thank you,
>> Roman
>>

-- 
Thank you,
Roman


