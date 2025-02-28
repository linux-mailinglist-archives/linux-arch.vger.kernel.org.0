Return-Path: <linux-arch+bounces-10455-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161CEA48D2D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 01:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2199616C853
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670B9211C;
	Fri, 28 Feb 2025 00:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rO2aj4Cu"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A86175BF;
	Fri, 28 Feb 2025 00:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702106; cv=none; b=V0zZpVpYnWtLh+m/ljU5lLwb1vGZeBFOPKuVQOTxu4a1I+uqQcgqk9OT+Tx+bbs+0tnW0KcZQ/adL+zr2XLbbO32LNQ7PRbi+ub/umJWHmqeW8HjmPb9aW1a7lzrL2aheLDtvNNk/0B1LW9Voibxu96zAwDZGuT2FkHHmWs6EQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702106; c=relaxed/simple;
	bh=fnbRBzQp+fcMejleRa4ySLM5Rd37akHgiqwA98kULkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMZS4BZ20CZpKlY1QM/M+dhu0vltUSdCJMvwILkrg78I9W4CrRbUSB2e/nrA+phBZLoyiFlOHjckHTwwksGtzspzWxp2l7/H3rkbZD0UtYg3guEv/ynTGHu4C/C39Ibco1WVfCmSDekttPVlrde9pjzWzCCJp3gX5qQyu4EE1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rO2aj4Cu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0B9F1210EAC1;
	Thu, 27 Feb 2025 16:21:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B9F1210EAC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740702104;
	bh=laxQUa2iwGyTNDtBa6S1LG374rW09RB1CYSVN9bF2Ew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rO2aj4Cu80fRwlpTq389v36uTw+53TKIzBHJgNH9RbHbV31yyxs7t5moGAqalVVLz
	 pW3c3b2Rbgis+2faahPrWY0gcG+RyLONFYtSrWhG5J6Di1GR5AyCqPSI3n7BcZYYcr
	 OPv5FPMPhyWA5pMcsXLrORKizHmr2coZx3nGe46w=
Message-ID: <9c8b92d3-d3fc-42a6-9493-2e18508c5890@linux.microsoft.com>
Date: Thu, 27 Feb 2025 16:21:43 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] hyperv: Introduce hv_recommend_using_aeoi()
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
 <1740611284-27506-5-git-send-email-nunodasneves@linux.microsoft.com>
 <f509907e-019b-4d16-a0d4-1a5acfe8592e@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <f509907e-019b-4d16-a0d4-1a5acfe8592e@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/2025 10:04 AM, Roman Kisel wrote:
> 
> 
> On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
>> Factor out the check for enabling auto eoi, to be reused in root
>> partition code.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
> 
> I think adding "No functional changes" would bring some benefit:
> that's an additional invariant to check against when reviewing.
> 
Thanks, I can add it for next version :)

