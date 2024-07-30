Return-Path: <linux-arch+bounces-5698-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80973940686
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 06:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B321C2267E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 04:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3C1662F4;
	Tue, 30 Jul 2024 04:30:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E5815B97B;
	Tue, 30 Jul 2024 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722313805; cv=none; b=Z2ZZQ5vteFbfnc+7tDwoIZ17NYWb6KavhUCPT23SnjnizmUYpqzjnAyR4iK4HgDYH76L01NMGaMCLsOVtGM4d4ipfVmhugpe9JR9Yqqv/TVskYp+L67SuQozbsT813z6829gJZEs89VAlcinCxQjgvhNHJMM6owP+WEkD88r8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722313805; c=relaxed/simple;
	bh=cRyCK6YwYZWYkTy60+4VjzRDRYOyaWlt+mdi969C3b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b14JNMVkOCNWB84jRFfIjRGChZUiCG3jSdxDMy4DtRe2S0aYK2jTBHX+6DQzS7+/BV1TvGLVy8JQGoLhbxo6eL4mpO1LeBMXIYMQlOa+v7lRhvi2sAUmWdIKSzZkQ6+K7/xyfnwCApfVvRksAuz/7ZVPkaxYM7wxE91lU+D294E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74C121007;
	Mon, 29 Jul 2024 21:30:20 -0700 (PDT)
Received: from [10.163.55.206] (unknown [10.163.55.206])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6698A3F64C;
	Mon, 29 Jul 2024 21:29:52 -0700 (PDT)
Message-ID: <08e6c85e-2c82-4c15-bfe7-d42900d1c68f@arm.com>
Date: Tue, 30 Jul 2024 09:59:50 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] uapi: Add support for GENMASK_U128()
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
References: <20240725054808.286708-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240725054808.286708-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/25/24 11:18, Anshuman Khandual wrote:
> This adds support for GENMASK_U128() and some corresponding tests as well.
> GENMASK_U128() generated 128 bit masks will be required later on the arm64
> platform for enabling FEAT_SYSREG128 and FEAT_D128 features.
> 
> Because GENMAKS_U128() depends on __int128 data type being supported in the
> compiler, its usage needs to be protected with CONFIG_ARCH_SUPPORTS_INT128.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arnd Bergmann <arnd@arndb.de>>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> 
> Changes in V2:
> 
> - Wrapped genmask_u128_test() with CONFIG_ARCH_SUPPORTS_INT128
> - Defined __BITS_PER_U128 unconditionally as 128
> - Defined __GENMASK_U128() via new _BIT128()
> - Dropped _U128() and _AC128()

Hello Arnd,

Does the changed series look good ? Please do let me know if something
further needs to be changed. Thank you.

- Anshuman

