Return-Path: <linux-arch+bounces-9283-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856469E669E
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 06:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EAD11884038
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 05:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD61194C6E;
	Fri,  6 Dec 2024 05:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="evohsIOa"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA16A193078;
	Fri,  6 Dec 2024 05:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733461983; cv=none; b=KmKhLnb6kIrzkkc56kRNBpw8htva6LIHAjGM+eshQRCqj9/JpiJhDGgGWrgIqj7Dp2wkRt/oM+D/vmj/dRrPBfepeAK9nPWWYHEBOo7razN6FFTcf+xZfL8LothlIx7zviaO22DFfSfwxY85DAw6C2+NArybxcH6M6cpQYAMQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733461983; c=relaxed/simple;
	bh=VSTof/Uj6masKJoLaAu/3mhUUtoihlT9CA4iZ2vzN2Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ekb+TogfBsXnFsmzrWa3bS7q9DlPIs+G1pakW5bTYkrDI/RCGUqCQ+tuMogtQBAN+i+4ir5gjiYmH4zhLpIV6l6vreNVax860UKmuNzK/zySuZmTq0oYD++OKXn+MWtE2m4Bbvvb0RUvsS8uKadiz2L1os4Od9D2MtNX75edVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=evohsIOa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.0.192] (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id DB58D20ACD8D;
	Thu,  5 Dec 2024 21:12:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB58D20ACD8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733461980;
	bh=UeJKj87W9UR5iJRJm8EOVLO3pStgIR+TvO1cTQt7BXk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=evohsIOaYFfQe1eCWrL35euPbFbUcU8YiFIo4DvXuomC5z7qvwnPVNWkVkvtyTO46
	 Yn0Oy0b5pR4/G+4koxJ9PiOD5s1K5XjZ34R/WB69cjeMhwcBdjYJtzQxfZiLMnvung
	 JyqqH7VS1El1YbPoIX5fiIB9chqShvN25PcFIgO8=
Message-ID: <3c5ec65e-93a9-48a2-a18f-f5b89e83e999@linux.microsoft.com>
Date: Thu, 5 Dec 2024 21:12:56 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, virtualization@lists.linux.dev,
 eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, luto@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, sgarzare@redhat.com,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mukeshrathor@microsoft.com,
 vkuznets@redhat.com, ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 horms@kernel.org
Subject: Re: [PATCH v3 3/5] hyperv: Add new Hyper-V headers in include/hyperv
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1732577084-2122-4-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1732577084-2122-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/2024 3:24 PM, Nuno Das Neves wrote:
> These headers contain definitions for regular Hyper-V guests (as in
> hyperv-tlfs.h), as well as interfaces for more privileged guests like
> the root partition (aka Dom0).
> 
> These files are derived from headers exported from Hyper-V, rather than
> being derived from the TLFS document. (Although, to preserve
> compatibility with existing Linux code, some definitions are copied
> directly from hyperv-tlfs.h too).
> 
> The new files follow a naming convention according to their original
> use:
> - hdk "host development kit"
> - gdk "guest development kit"
> With postfix "_mini" implying userspace-only headers, and "_ext" for
> extended hypercalls.
> 
> The use of multiple files and their original names is primarily to
> keep the provenance of exactly where they came from in Hyper-V
> code, which is helpful for manual maintenance and extension
> of these definitions. Microsoft maintainers importing new definitions
> should take care to put them in the right file. However, Linux kernel
> code that uses any of the definitions need not be aware of the multiple
> files or assign any meaning to the new names. Linux kernel code should
> always just include hvhdk.h
> 
> Note the new headers contain both arm64 and x86_64 definitions. Some are
> guarded by #ifdefs, and some are instead prefixed with the architecture,
> e.g. hv_x64_*. These conventions are kept from Hyper-V code as another
> tactic to simplify the process of importing and maintaining the
> definitions, rather than splitting them up into their own files in
> arch/x86/ and arch/arm64/.
> 
> These headers are a step toward importing headers directly from Hyper-V
> in the future, similar to Xen public files in include/xen/interface/.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  MAINTAINERS                 |    5 +
>  include/hyperv/hvgdk.h      |  308 +++++++++
>  include/hyperv/hvgdk_ext.h  |   46 ++
>  include/hyperv/hvgdk_mini.h | 1306 +++++++++++++++++++++++++++++++++++
>  include/hyperv/hvhdk.h      |  733 ++++++++++++++++++++
>  include/hyperv/hvhdk_mini.h |  311 +++++++++
>  6 files changed, 2709 insertions(+)
>  create mode 100644 include/hyperv/hvgdk.h
>  create mode 100644 include/hyperv/hvgdk_ext.h
>  create mode 100644 include/hyperv/hvgdk_mini.h
>  create mode 100644 include/hyperv/hvhdk.h
>  create mode 100644 include/hyperv/hvhdk_mini.h

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

