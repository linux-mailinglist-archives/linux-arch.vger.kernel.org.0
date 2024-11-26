Return-Path: <linux-arch+bounces-9173-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A863A9D9C95
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 18:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E707B27E1F
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E349C1DB52D;
	Tue, 26 Nov 2024 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sXLbEnkQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E071DACB4;
	Tue, 26 Nov 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642135; cv=none; b=FlHlGmpLTsYImI7Hr59xNPpa/UreAzZx3MrPw4Pz0bSzrrOg4THZx0ZbyUVp3etJ6EDRWBYUbwCvBcsg3nm3KIjvX846xxk54Ruga/QOt7BYmgojNj8l0oUnf5VW6/oLnPJuETh0MiiIWmHHEsvQBTuU4JobJd2utJsUr8Tfchw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642135; c=relaxed/simple;
	bh=PlMMIc4AQSbkLcvBzrHB9wgiuJrm21ESzo2se5IDeG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVm/4ofvj/shJs2rtXNiU2EmrJUcZjRcZyhZYHqH/ddT/qq6Wh459sxxVwXkEpBK+T7u6CeXc9W1bi+Kbc/R3ly4OB3r3GVGxzomUuK/KjDb1eh4SWEb6XlNeYcQ9WIEGODqcoQ1Va7PqBOzVtKuSGYeUj1FtewHMDdz3SCxTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sXLbEnkQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.115] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1A72420545AE;
	Tue, 26 Nov 2024 09:28:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A72420545AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1732642133;
	bh=H94+kE6a6Z3TCvsv5IQfa8koOq42a44wDuStW4E/6+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sXLbEnkQ61nv6hbtZZ2ZQwagIwQ3s57qp+UTpK189JiX/cAYSvAH5zo9QDJA5ey8k
	 Dwt4CCS4FMIH15sSObKql/pyGsegy+eu+jPnazasSvIj/u/dhKQ5vboJ68gY5vxkaU
	 Ik00OhGi1r1Ksyj94O5yXx79fuqOSlgwKrm8eO6s=
Message-ID: <074bacbe-2823-4653-a6fb-a50b7785a027@linux.microsoft.com>
Date: Tue, 26 Nov 2024 09:28:52 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] hyperv: Remove the now unused hyperv-tlfs.h files
To: Michael Kelley <mhklinux@outlook.com>,
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
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
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
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
 "eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
 "horms@kernel.org" <horms@kernel.org>
References: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1732577084-2122-6-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41570E0108D4E3B45571EE9FD42F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41570E0108D4E3B45571EE9FD42F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/2024 9:59 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, November 25, 2024 3:25 PM
>>
>> Remove all hyperv-tlfs.h files. These are no longer included
>> anywhere. hyperv/hvhdk.h serves the same role, but with an easier
>> path for adding new definitions.
>>
>> Remove the relevant lines in MAINTAINERS.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Thanks for the reviews on this series Michael!

