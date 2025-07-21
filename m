Return-Path: <linux-arch+bounces-12882-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 264C8B0C94B
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 19:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5804E744A
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 17:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4CA2E041E;
	Mon, 21 Jul 2025 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TEfADhWT"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A092DC32B;
	Mon, 21 Jul 2025 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118098; cv=none; b=eWfrnjrfpoqPe3FPqL5/2hPntTz+UJuDHRYvILGLyIfO1RAHbbjg3RYCJbIOPhjMYI6P9dPFO+Bhz6+GCQu5ZFJEeSGcoFdWl2qKUG/Y84afTsjGiIfJpBumtZrR+RLSrrlZZJYLfcMe0q1AVHjzhTnZb41kpg0tz/MuQWMdNbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118098; c=relaxed/simple;
	bh=VzaP6plla0IzIB8La71/m58RDyiFEZH/its7k6NFmow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgU62wlRBecFAgIAEC1aWFtUsrASX+xW35AY+uYwEgPcF8paLLzkTi1V8WvKvbKONX/Au3gTVxynox5ra31wpbXBNltD4sjgH7Z/3awl915nOl4Q22mvrUVNB0/fJNEs7UTn/6hOpC1ORaEHHmsYOIC0iu6k/u2RMkGcQ65Ozs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TEfADhWT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9BDB621175B2;
	Mon, 21 Jul 2025 10:14:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BDB621175B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753118096;
	bh=nywGOgRNOK1+NZYE9n1C5lkTaY7eYmFhzUr5fR8qd0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TEfADhWTSj5VW8U4ZOVvbnid0L0gJlkyg34sANdF9OUlqrTb0tfxyMPrtubbg+09a
	 O3YwsvjalIDCgoY0S7vHT39in9CPm4mYN+IF0dmqNDvOQvSFyoB8MoDz/KEr2+Ekqd
	 DGUx6nXlHzqyDDlA20d+TqjLOpcAW6etgGS8ItO4=
Message-ID: <5264d73d-ae1b-4173-b304-b92e18a3befb@linux.microsoft.com>
Date: Mon, 21 Jul 2025 10:14:56 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hyperv: Introduce new way to manage hypercall args
To: Michael Kelley <mhklinux@outlook.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "x86@kernel.org" <x86@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <c5d4d351-a7ff-4762-8bb3-61554d4f9731@linux.microsoft.com>
 <SN6PR02MB41570625E2F061C5E494C7F4D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <43f8be57-a330-455f-8f9e-f5718ff1aa1a@linux.microsoft.com>
 <ed1e8508-7085-4620-af25-3a8795c1afe8@linux.microsoft.com>
 <SN6PR02MB4157A2A90910918AE9B6327BD45DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157A2A90910918AE9B6327BD45DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/20/2025 7:19 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 18, 2025 6:16 PM

[...]

> 
> Thanks for any testing you can do on standalone test machines without
> needing test clusters in Azure. It will be hard to get test coverage on
> *every* hypercall call site that is modified by the patch set, but doing
> basic smoke testing of running in the root partition and in VTL2 will
> cover more than I can cover running in a VTL0 guest on my laptop or
> in Azure. Fortunately, the changes overall in this patch set are pretty
> straightforward, and my testing of VTL0 guests didn’t turn up any bugs.
> I'm hoping that additional smoke testing is more about gaining
> confidence than finding actual bugs.  (Famous last words ....)
> 

Thank you a million times for pushing the bar higher and supporting the
code :)

>> VTL2 currently uses a limited number hypercalls that are set as enabled
>> in the OpenVMM code (`set_allowed_hypercalls`). You could take a look
>> and conclude if these hypercalls require any adjustments in the patches.
> 
> My patch set already covers all the hypercall call sites that originate in
> VTL2 code. Again, a basic smoke test should help gain confidence, or
> show that any confidence is misplaced :-)
> 

Very nice, should be smooth sailing then :)

>> My opinion has been to have two pages (input and output ones). As the
>> new code introduces just one page I do feel a bit apprehensive, got no
>> hard evidence that this is a bad approach though. If we tweak the code
>> to have 2 pages, perhaps there would be no need to run a full-blown
>> validation, and even smoke tests will suffice?
> 
> My view is that the 1 page vs. 2 pages is much less of a risk than just
> some coding error in introducing the new interfaces. The 1 page vs.
> 2 pages should only affect the batch size for rep hypercalls, and the
> existing code already handles different batch sizes. So I'm not as
> concerned about that risk. Wei Liu in the maintainer here, so I'll
> certainly follow his judgment and guidance on what is needed to
> be confident in this patch set.
> 

I agree with your risk assessment. Perhaps I am playing too much of
a spec lawyer yet it states

1) Input and output area may not intersect,
2) Either can be up to 4KiB of size.

Hence, one (be that for feature development or one-off debugging) would
be within their right to implement a hypercall that accepts 4KiB of
data and returns 4KiB of data. My understanding that after this patch,
that won't work out-of-the-box, and would need some fixing in the
kernel.

Perhaps, we could have a KConfig option to let the user choose if they
need 2 pages instead of making the user figure out what needs to be
fixed in the kernel?

> Michael

-- 
Thank you,
Roman


