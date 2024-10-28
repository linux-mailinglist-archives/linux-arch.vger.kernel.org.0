Return-Path: <linux-arch+bounces-8640-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E459B2B3E
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 10:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B901F20978
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 09:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC4A192D65;
	Mon, 28 Oct 2024 09:21:19 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CFD15E8B
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107279; cv=none; b=DVPLpEyHn4NV+7P/WJFAX7avL6tEdRvaj6vafB3dbtzIZa6KfZOcjdb1YJUeTULg8D7oYaRIvyzcf8/eIRSHPHufy970ODgCAMikk3uNgjw1EsKkmbU1BPoz6pQo0ClsnhytC/maq4b8+9dJKEL4im/lOGrDcl2TGQ3fPmo8cDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107279; c=relaxed/simple;
	bh=DO7dwch+FeCW54o19Mz+LWyOppgNXX0IFEQI9vQHDtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poatx7sS/fsMfpJZ9HJ0ra3r028YQ6wjHJfaYeAFCp+Q5JH3/H/3kqxiiOpDeU02xf7cfejIFFE0d0LPpaH1Elro3mvfLck/KnV75HVUHUVjAIogaMlI9Jm/+Hu1kpNihZTVYCtj1aavupCR5XNdOjLtqMkioE4p1MtdACRFx5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 665BE497;
	Mon, 28 Oct 2024 02:21:45 -0700 (PDT)
Received: from [10.57.64.61] (unknown [10.57.64.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A42803F66E;
	Mon, 28 Oct 2024 02:21:13 -0700 (PDT)
Message-ID: <c9bc3c9d-fccf-41c4-8790-3d639f661e0a@arm.com>
Date: Mon, 28 Oct 2024 10:21:11 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests/powerpc: Use PKEY_UNRESTRICTED macro
To: Yury Khrustalev <yury.khrustalev@arm.com>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joey Gouly <joey.gouly@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sandipan Das <sandipan@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, nd@arm.com
References: <20241028090715.509527-1-yury.khrustalev@arm.com>
 <20241028090715.509527-4-yury.khrustalev@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241028090715.509527-4-yury.khrustalev@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/10/2024 10:07, Yury Khrustalev wrote:
> Replace literal 0 with macro PKEY_UNRESTRICTED where pkey_*() functions
> are used in mm selftests for memory protection keys for ppc target.
>
> Signed-off-by: Yury Khrustalev <yury.khrustalev@arm.com>
> Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

- Kevin

