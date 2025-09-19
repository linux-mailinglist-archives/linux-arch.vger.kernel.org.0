Return-Path: <linux-arch+bounces-13697-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ACCB8B0D4
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 21:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C19565B2B
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70D727FB0E;
	Fri, 19 Sep 2025 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qW1XfREq"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E531286421;
	Fri, 19 Sep 2025 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308963; cv=none; b=J48/c9CQrXZQ/YS5EjgCY/Hh48QlwMejWSGYlljJ1U9RwzsRqg3/8jJQsldTmDFeTXvJJ9Ar1I7tJB0k/1sRuTSLCVPMmAaIjJ3syWe879TGZVbGBkTG9CjC9YL8OQTk68mTdFdgOPs1ou7ArW40bVwlOFsV4IQrLYu5LCM7W1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308963; c=relaxed/simple;
	bh=hqBsSlm0f69a0Az1IYLkFKNLUIXCFEOmQU+t2l9tWQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgIkWVpBduIygfAwxoB2s3DEtHveNkS0I9oXCzxKhIx5+guJdnQTmwOIUk6Ki5myA78McJkaVZmDkNgHC3tAAfJa/+AkkP7MkiDdEFuZ6liGqfta2+eM5zoQH7USauRpMDQ6/WxPCDPNziYQ7RB9vKBgyL3hGLYp9g1JMUytEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qW1XfREq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9C65220154E7;
	Fri, 19 Sep 2025 12:09:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C65220154E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758308956;
	bh=vnotgj9GX9sgnIc7xDNYmuYaTExpOZ07oF+jN36uj+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qW1XfREqUSc3FYCvowVow3cg1LT6tmyimlxEzoW2DlFBG+2bCzJgw7UxNYPtWv0ws
	 99h+5FUbs01WZNBZTr4CP7hB/RGTF2BGXN2Y4mv4hvK2K+HrvQQ1hfHC+YnRZkkhyQ
	 zROS6BxI0N7L+vsLqaVNBBjrUeZIV/ELJfBAP7T4=
Message-ID: <f6ced912-3778-239c-33d0-ac7bbf362dd1@linux.microsoft.com>
Date: Fri, 19 Sep 2025 12:09:14 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 4/6] x86/hyperv: Add trampoline asm code to transition
 from hypervisor
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "arnd@arndb.de" <arnd@arndb.de>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-5-mrathor@linux.microsoft.com>
 <SN6PR02MB41570D14679ED23C930878CCD415A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <79f5d0ac-0b3e-70fc-2cbe-8a2352642746@linux.microsoft.com>
 <SN6PR02MB4157CAE4FA74E482A96471B1D416A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250919090625.GBaM0dEegelsB724bZ@fat_crate.local>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20250919090625.GBaM0dEegelsB724bZ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/25 02:06, Borislav Petkov wrote:
> On Thu, Sep 18, 2025 at 11:52:35PM +0000, Michael Kelley wrote:
>> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, September 16, 2025 2:31 PM
>>>
>>> On 9/15/25 10:55, Michael Kelley wrote:
>>>> From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, September 9, 2025 5:10 PM
>>>>>
>>>>> Introduce a small asm stub to transition from the hypervisor to linux
>>>>
>>>> I'd argue for capitalizing "Linux" here and in other places in commit
>>>> text and code comments throughout this patch set.
>>>
>>> I'd argue against it. A quick grep indicates it is a common practice,
>>> and in the code world goes easy on the eyes :).
> 
> But not in commit messages.
> 
> Commit messages should be maximally readable and things should start in
> capital letters if that is their common spelling.
> 
> When it comes to "Linux", yeah, that's so widespread so you have both. If I'm
> referring to what Linux does as a policy or in general or so on, I'd spell it
> capitalized but I don't think we've enforced that too strictly...
> 
>> I'll offer a final comment on this topic, and then let it be. There's
>> a history of Greg K-H, Marc Zyngier, Boris Petkov, Sean Christopherson,
>> and other maintainers giving comments to use the capitalized form
>> of "Linux", "MSR", "RAM", etc. See:
> 
> MSR, RAM and other abbreviations are capitalized and that's the only correct
> way to spell them.
> 
>>>>> upon devirtualization.
> 
> What is "devirtualization"?

Hypervisor is disabled, and it transfer control to the root/dom0
partition, so essentially hypervisor is gone when control comes back
to root/dom0 Linux.

>>> since control comes back to linux at the callback here, i fail to
>>> understand what is vague about it. when hyp completes devirt,
>>> devirt is complete.
> 
> This "speak" is what gets on my nerves. You're writing here as if everyone is
> in your head and everyone knows what "hyp" and "devirt" is.

that's just follow up conversation, commit comment says "hypervisor" and
"devirtualization".

> Commit mesages are not code and they should be maximally readable and
> accessible to the widest audience, not only to the three people who develop
> the feature.
>
> If this patch were aimed at the things I maintain, it'll need a serious commit
> message scrubbing and sanitizing first.
> 
> HTH.
> 


