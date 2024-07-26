Return-Path: <linux-arch+bounces-5637-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508C93CD05
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 05:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5E41F21D00
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 03:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535751CAB1;
	Fri, 26 Jul 2024 03:34:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A9B23A8;
	Fri, 26 Jul 2024 03:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964862; cv=none; b=PBEgztoSojQ+UGvK3jH4/HLnd+eLhRCgPmXHXfLfZM8RbB9ShkyouN3W2YA4E6LclzrSpLaVuGsElOyYydBK0SNMVs0AqqRqN+DWcupLghpHMnsC2NfiqbTwkt4xApyOMc2Z3e1IT9Gm0CrRaTEML0ng6EBMlDhpWIPdMRpwTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964862; c=relaxed/simple;
	bh=ajVacYBsFhjD2CL799v4iybDrl0wE3lytQX/0xv44Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=noHPzADRf9c1c8Bd0goskuOPOU5bWZfUSZ6qzipf6/rq38qTTmLLAE1sUECvHSiGPVhTFIDJQYvGpLSUHUA0ROxDt0tQeSF4nDRes8/cT3kirJ3ThLLYZaNAdU1SIhfcL3i21tR8WwYQb8DQqsDNoM/hBRx4p4a3LY9qHoHtSqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A13E01007;
	Thu, 25 Jul 2024 20:34:43 -0700 (PDT)
Received: from [10.163.53.239] (unknown [10.163.53.239])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAB143F766;
	Thu, 25 Jul 2024 20:34:15 -0700 (PDT)
Message-ID: <980dac50-8b7d-4bef-98a3-e410949737a9@arm.com>
Date: Fri, 26 Jul 2024 09:04:12 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] uapi: Add support for GENMASK_U128()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
References: <20240725054808.286708-1-anshuman.khandual@arm.com>
 <20240725140543.9601ffdb94b5a6103dfd906f@linux-foundation.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240725140543.9601ffdb94b5a6103dfd906f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/26/24 02:35, Andrew Morton wrote:
> On Thu, 25 Jul 2024 11:18:06 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> This adds support for GENMASK_U128() and some corresponding tests as well.
>> GENMASK_U128() generated 128 bit masks will be required later on the arm64
>> platform for enabling FEAT_SYSREG128 and FEAT_D128 features.
> 
> If this will be required for ongoing ARM development prior to the 6.11
> release then it would make sense for these changes to be carried in the
> relevant ARM tree.

Hello Andrew,

These changes are not required prior to 6.11, hence being taken via the mm
tree is fine.

- Anshuman

