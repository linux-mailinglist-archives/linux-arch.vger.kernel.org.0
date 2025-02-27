Return-Path: <linux-arch+bounces-10448-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04978A48CB2
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14687A58D9
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF3276D0C;
	Thu, 27 Feb 2025 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZGgsU1Ox"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5630276D04;
	Thu, 27 Feb 2025 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698480; cv=none; b=AoVNxIOHQEJxYTcLvlqSc05Xslw8R28fKplCDXFwEekylcvqk/mCIiZ9pW9kWlRGToXm+HFi5YE7exxmIx2vU2XFGjwGr6KojJ0uHFp/X6uMcO2J7vuzYTYEIOuZCofgNZX5EQc6omwFOz/2qZkxS6KmTBi/0yo1ILYlOWJIoH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698480; c=relaxed/simple;
	bh=DyQ3lPngaEdqpa+SNLvVCZjzHFr5L++cSW2TJIYKOtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqLxmVXFsMGoQ7t1Ydr3ZzlKHVbrxR5A6+HzkPY5eU2JNwBhJAoM8tsheIyUm+w0P7TX0TrCukkVTnoiJm2KRnJsM0pf+9kwhWlSukWeFSJSurHeKY7ZDjNy5ZxpTpn2/hxD1BVWxG1e7dz5V57XxkdJVD+lRejkNKVdNhKMFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZGgsU1Ox; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D4954210D0F2;
	Thu, 27 Feb 2025 15:21:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4954210D0F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740698479;
	bh=EiYVaoXbtdVeqdOIjPOIL+TQYlIQmgqlmJX0DgXhCSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZGgsU1Ox1cQX31aaBLp4RLR7Ct4s9L78MTyYhRvvM4obhge2PYIUmXflaMQPr6qxD
	 vDZ9RIa6tzCLJBcZd7GkKr5DDIzXQYIBYS0qvUsV9ZaFdp/0D65u8nPd3bH0DzGWS2
	 ZmGBG9mZl+qWpxpArzPuAcf0HDoEWs1++Nt3ykis=
Message-ID: <b9317a6c-5427-45bf-af93-2b78a8c97863@linux.microsoft.com>
Date: Thu, 27 Feb 2025 15:21:18 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
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
 <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
 <74af19c4-639f-4bcc-b667-b5f102bbb312@linux.microsoft.com>
 <8338dd00-3aa4-418f-a547-1c19623358cb@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <8338dd00-3aa4-418f-a547-1c19623358cb@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/2025 2:54 PM, Easwar Hariharan wrote:
> On 2/27/2025 9:02 AM, Roman Kisel wrote:

[...]

> 
> Sorry, I have to disagree with this, a recent commit of mine[1] closed a WSL
> issue that was open for over 2 years for, partly, the utter uselessness of
> the hex return code of the hypercall.

What hypercall was that? I see

		storvsc_log_ratelimited(device, loglevel,
			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
			scsi_cmd_to_rq(request->cmd)->tag,
			stor_pkt->vm_srb.cdb[0],
			vstor_packet->vm_srb.scsi_status,
			vstor_packet->vm_srb.srb_status,
			vstor_packet->status);

in your patch where `vstor_packet->status` is claimed to be a hypercall
status? I'd be surprised if the hypervisor concerned itself with
the details of visualized SCSI storage. The VMM on the host might and
should.

I'll look through the code to gain more confidence in my suspicion that
calling the SCSI virt storage packet status a hv status causd the
frustration with debugging, and if no counter examples found, will send
a patch to fix that log statement above.

> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d2138eab8cde61e0e6f62d0713e45202e8457d6d
> 
> Thanks,
> Easwar (he/him)

-- 
Thank you,
Roman


