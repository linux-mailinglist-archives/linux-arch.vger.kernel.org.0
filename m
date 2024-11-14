Return-Path: <linux-arch+bounces-9102-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63819C9496
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 22:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A8FB22851
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 21:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089E71AE875;
	Thu, 14 Nov 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NQqKMwIs"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C95487BF;
	Thu, 14 Nov 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731620157; cv=none; b=RmWVdMeNE4TzbsaeHpf9ys35T+VGDg4M9JaCGMS822AVIMXFO4XuK1vX/b6JkGAwiq8r8CK5bNz4aSa+f8/xJzERIQCBwmS2EyvB8eBx0Cv45MaoO9Vuul8t+iHu3lC+e3yDt57Qqsbbgxb/6MIBBWsYR4GiuqoeJBG6YvDovl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731620157; c=relaxed/simple;
	bh=+e79qdIDhXLlZ9c+P2Dc6YG0KRyU6RDSSxMlbTgd9g8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RjE5n90Q7nyTRSUNa4U0F7khJpCD4QMVdv0DjTHUmfebcftd/2VKQTMv7krcvCThBtqYgQu02dmioc9D7QwCmseFjBO9BjasI2Za7lS6LL991L2oWRbLm/MzRwC4y6rP5SOUsrNrXCt5rMszVYYeFP/xFuz4tRe5S0KYPocAcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NQqKMwIs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id B9C9C20C8BA9;
	Thu, 14 Nov 2024 13:35:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9C9C20C8BA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731620155;
	bh=XPm0EAc1K/nvytn2cDBsP3xI8cBGOIMbd0Cl3IWdsjU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=NQqKMwIsblJDQplTM3wYIQkHUxgOW2n632p2zFLlvECKHoCZPlToMzD5erEwPYfpe
	 0xAcZl2lQraCLw3r4lLsocd3IgabK8u3iSBdob3SxKEh55p874cPox288sd/GyuZhW
	 Ar0G9QMjSax+jhKvh5SSd5YXIokLKru/kSANZoeY=
Message-ID: <4743445a-09c4-4f14-b6a7-2e6509077680@linux.microsoft.com>
Date: Thu, 14 Nov 2024 13:35:53 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
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
 vkuznets@redhat.com, ssengar@linux.microsoft.com, apais@linux.microsoft.com
Subject: Re: [PATCH v2 4/4] hyperv: Switch from hyperv-tlfs.h to
 hyperv/hvhdk.h
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, virtualization@lists.linux.dev
References: <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1731018746-25914-5-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <1731018746-25914-5-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/2024 2:32 PM, Nuno Das Neves wrote:
> Switch to using hvhdk.h everywhere in the kernel. This header includes
> all the new Hyper-V headers in include/hyperv, which form a superset of
> the definitions found in hyperv-tlfs.h.
> 
> This makes it easier to add new Hyper-V interfaces without being
> restricted to those in the TLFS doc (reflected in hyperv-tlfs.h).
> 
> To be more consistent with the original Hyper-V code, the names of some
> definitions are changed slightly. Update those where needed.
> 
> hyperv-tlfs.h is no longer included anywhere - hvhdk.h can serve
> the same role, but with an easier path for adding new definitions.

Michael already mentioned this, I'd also agree that it's better to
remove hyperv-tlfs.h entirely since it's been superseded.

This looks good to me, I'll wait for v3 addressing the other comments to
take a look again.

- Easwar

<...>

