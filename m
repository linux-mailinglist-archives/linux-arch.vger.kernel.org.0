Return-Path: <linux-arch+bounces-8433-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 408DF9ABA52
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 02:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2A15B21D8F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 00:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3F017F7;
	Wed, 23 Oct 2024 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W7B9glwO"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60016182;
	Wed, 23 Oct 2024 00:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729641845; cv=none; b=qQH4xvIHowR2uzKybLkLdTpT3tPnF+yZiGxgGw9K52Bqi/9KYoHUX3YIwO2ztVY8iENqFUlPwZ8lfA8pUmt+chTM49VkHBhTLw2kHsR64Ni0DK+oqu/0GNt7Fd/hrK9XaU/aMJ47mZsPNdg6dKY1KPm0f7AKnlDh/1eWT/9pKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729641845; c=relaxed/simple;
	bh=BS3twbZ5C6CqufKtgBl7yFiz4Th4SXUn3z0s0DmuctI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPa/f40MGfrflY5XrApMSKJs8UR1rKg4vzZRYgBu/3s0yyohR1Y3fkd4ufYxTPecsC/CnHJ/o5aAqvWkXbX/jjPLBAMsFFoMjUlEyiGAjeAebN9ISRMdEoPAirl8/AGD/Ogz+k5jUDF5X9mFscEpDy9yFmZZnQ3wV3CoHCn/xQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=W7B9glwO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0604621112FB;
	Tue, 22 Oct 2024 17:04:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0604621112FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729641843;
	bh=BSb0pSoDio3rfbTxA/Zn5HqyVgKFFvAwXvG36oPMm5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W7B9glwOso1LY6SeJ5JgRjNbXl8nw9FwsuxxkoDI1KlFSFB//2dXCNi0FWwhuCyFE
	 IOZ6i+ipbig3SDZ2Bz92iF0LOgqTgQxeWjJTR8AQbWPoSVm0ApXkTXAN9h1/uZLuu/
	 7kzQtW5Iw3AXshGs3dfUWNkGEtI/O2obLyU5wd28=
Message-ID: <c426d122-4ba3-4193-80d5-a40d7554d324@linux.microsoft.com>
Date: Tue, 22 Oct 2024 17:04:01 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] RE: [PATCH 0/5] Add new headers for Hyper-V Dom0
To: MUKESH RATHOR <mukeshrathor@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157F6EA7B2454D2F6CBF2ECD4782@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d70bbad7-bcad-2031-a4e1-755b502422a4@microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <d70bbad7-bcad-2031-a4e1-755b502422a4@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Michael - sorry for the delay, I just got back from vacation.

On 10/10/2024 6:34 PM, MUKESH RATHOR wrote:
> 
> 
> On 10/10/24 11:21, Michael Kelley wrote:
>  > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: 
> Thursday, October 3, 2024 12:51 PM
>  >>
>  >> To support Hyper-V Dom0 (aka Linux as root partition), many new
>  >> definitions are required.
>  >>
>  >> The plan going forward is to directly import headers from
>  >> Hyper-V. This is a more maintainable way to import definitions
>  >> rather than via the TLFS doc. This patch series introduces
>  >> new headers (hvhdk.h, hvgdk.h, etc, see patch #3) directly
>  >> derived from Hyper-V code.
>  >>
>  >> This patch series replaces hyperv-tlfs.h with hvhdk.h, but only
>  >> in Microsoft-maintained Hyper-V code where they are needed. This
>  >> leaves the existing hyperv-tlfs.h in use elsewhere - notably for
>  >> Hyper-V enlightenments on KVM guests.
>  >
>  > Could you elaborate on why the bifurcation is necessary? Is it an
>  > interim step until the KVM code can use the new scheme as well?

It's not strictly necessary. We chose this approach in order to
minimize any potential impact on KVM and other non-Microsoft-
maintained code that uses hyperv-tlfs.h. As Mukesh mentioned below,
eventually it will be better if everyone uses the new headers.

>  > Also, does "Hyper-V enlightenments on KVM guests" refer to
>  > nested KVM running at L1 on an L0 Hyper-V, and supporting L2 guests?
>  > Or is it the more general KVM support for mimicking Hyper-V for
>  > the purposes of running Windows guests? From these patches, it
>  > looks like your intention is for all KVM support for Hyper-V
>  > functionality to continue to use the existing hyperv-tlfs.h file.

You're correct - "all KVM support for Hyper-V" is really what I meant.
> 
> Like it says above, we are creating new dom0 (root/host) support
> that requires many new defs only available to dom0 and not any
> guest. Hypervisor makes them publicly available via hv*dk files.
> 
> Ideally, someday everybody will use those, I hope we can move in
> that direction, but I guess one step at a time. For now, KVM can
> continue to use the tlfs file, and if there is no resistance, we
> can move them to hv*dk files also as next step and obsolete the
> single tlfs file.
> 
> Since headers are the ultimate source of truth, this will allow
> better maintenance, better debug/support experience, and a more
> stable stack. It also enforces non-leaking of data structs from
> private header files (unfortunately has happened).
> 
> Thanks
> -Mukesh
> 

Thanks for providing the additional context, Mukesh.

Nuno


