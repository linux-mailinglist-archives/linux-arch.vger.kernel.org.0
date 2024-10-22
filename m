Return-Path: <linux-arch+bounces-8419-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B579AA28E
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 14:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B729E1F23203
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2F919D8A4;
	Tue, 22 Oct 2024 12:56:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE6D19B3C5
	for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2024 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601809; cv=none; b=l1zMcnhY1yMD/EL+94joXCBzRZOupeeoBeQVlTmqciVtY7he6/sRi4foQdr5BxS1ceK/ipHafMJdzFGfJ8MD3PFpV6BXmUoP04BIZMjZtkeLnYQRNT48GZDwt7WskBQS/QcGmauQZoIgiAY/SFjfXbjGIcB2SSoeBgT6mNX5LLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601809; c=relaxed/simple;
	bh=THvmidjHPC6iSlXhtS6RsgFtabrPehi5V2L/7pXjNlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3iK758nj91enPBVolO1ql6zzYGcd4JfNEeWsPADByMNtyYFokOFdj9Hg9exgPpj+4KO9pLu/eXeQRNdBVMcj0PP5uGUVRYAOYVIBsja0KA1jRdTBugrPfpoCIN87IHEp3a4yEPUseJxLztxDgAYRIm5B9nwGGwPwgnrfSDMkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE26C4B2;
	Tue, 22 Oct 2024 05:57:16 -0700 (PDT)
Received: from [10.57.66.29] (unknown [10.57.66.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E386D3F73B;
	Tue, 22 Oct 2024 05:56:45 -0700 (PDT)
Message-ID: <cb591524-e4a7-4987-b60c-4ec74ea113a6@arm.com>
Date: Tue, 22 Oct 2024 14:56:42 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/pkey: Add PKEY_UNRESTRICTED macro
To: Yury Khrustalev <yury.khrustalev@arm.com>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joey Gouly <joey.gouly@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, nd@arm.com
References: <20241022120128.359652-1-yury.khrustalev@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241022120128.359652-1-yury.khrustalev@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2024 14:01, Yury Khrustalev wrote:
> Memory protection keys (pkeys) uapi previously used two macros:

Nit: I would remove "previously" as it's not clear what it means here.

>  - PKEY_DISABLE_ACCESS 0x1
>  - PKEY_DISABLE_WRITE  0x2
>
> with implicit literal value of 0x0 that means "unrestricted". Code that
> works with pkeys has to use this literal value when implying that a pkey
> imposes no restrictions. This may reduce readability because 0 can be
> written in various ways (e.g. 0x0 or 0) and also because 0 in the context
> of pkeys can be mistaken for "no permissions" (akin PROT_NONE) while it
> actually means "no restrictions". This is important because pkeys are
> oftentimes used near mprotect() that uses PROT_ macros.
>
> This patch adds PKEY_UNRESTRICTED macro defined as 0x0.

Your Signed-off-by is missing.

With that fixed:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

- Kevin

> ---
> Applies to 42f7652d3eb5 (tag: v6.12-rc4).
>
> For context, this change will also allow for more consistent update of the
> Glibc manual [1] which in turn will help with introducing memory protection
> keys on AArch64 targets [2].
>
> [1] https://inbox.sourceware.org/libc-alpha/20241022073837.151355-1-yury.khrustalev@arm.com/
> [2] https://inbox.sourceware.org/libc-alpha/20241011153614.3189334-1-yury.khrustalev@arm.com/
>
> Is this patch OK?
>
> Kind regards,
> Yury
>
> ---
>  include/uapi/asm-generic/mman-common.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index 6ce1f1ceb432..ea40e27e6dea 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -82,6 +82,7 @@
>  /* compatibility flags */
>  #define MAP_FILE	0
>  
> +#define PKEY_UNRESTRICTED	0x0
>  #define PKEY_DISABLE_ACCESS	0x1
>  #define PKEY_DISABLE_WRITE	0x2
>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\


