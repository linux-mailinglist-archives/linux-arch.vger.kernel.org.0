Return-Path: <linux-arch+bounces-8634-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F09B29F3
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 09:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEAE1C21BE5
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65731922DA;
	Mon, 28 Oct 2024 08:09:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E961925B3
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730102965; cv=none; b=nNHGmw0vXz8WLJ/bd7EiiidHAXvsuYtNVFkjc5EqPMt9C8GztGW0e/phFgiemu98mqFNhywpf6oC9eTW2ns3I/oqf5Xrlp24H9PvCCTHIBg8GlWpBrQFYxz8grzSlsFvmlBWrb0w/4qBT8ROEM/QdBmMNLYqjGOJ4C5SeZaU22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730102965; c=relaxed/simple;
	bh=JBMV7VVX64bQcFEvHdxiyhLzj0YH8ToSggG10thDwdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R62/WROTt+B56D4HGUqhWV0CxLdYGd424NfCdghW89yFDRIzQiWjmwYSVVOT8pFQ+cHHWaoTelySefNLL2f6xbUvc1Ay0n7fHWHqxkSG/KuEhbznZTLAJE/NheD7J+CDwRIFERreM5Ub98fY76M0xFwkOqDOCsUc/kSlFfG2ppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EFFC497;
	Mon, 28 Oct 2024 01:09:51 -0700 (PDT)
Received: from [10.57.64.61] (unknown [10.57.64.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E36553F66E;
	Mon, 28 Oct 2024 01:09:19 -0700 (PDT)
Message-ID: <8b23455a-8941-4ffc-bbbb-83df0ea11270@arm.com>
Date: Mon, 28 Oct 2024 09:09:19 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/powerpc/mm: Use PKEY_UNRESTRICTED macro
To: Yury Khrustalev <yury.khrustalev@arm.com>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joey Gouly <joey.gouly@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sandipan Das <sandipan@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, nd@arm.com
References: <20241027170006.464252-1-yury.khrustalev@arm.com>
 <20241027170006.464252-4-yury.khrustalev@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241027170006.464252-4-yury.khrustalev@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2024 18:00, Yury Khrustalev wrote:
> Replace literal 0 with macro PKEY_UNRESTRICTED where pkey_*() functions
> are used in mm selftests for memory protection keys for ppc target.
>
> Note that I couldn't build these tests so I would appreciate if someone
> could check this patch. Thank you!

This shouldn't be in the commit message presumably (you could add it
below ---). More importantly the ppc folks need to be cc'ed,
get_maintainer.pl is telling me that means at least:

linuxppc-dev@lists.ozlabs.org
Michael Ellerman <mpe@ellerman.id.au>

> Signed-off-by: Yury Khrustalev <yury.khrustalev@arm.com>
> Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  tools/testing/selftests/powerpc/mm/pkey_exec_prot.c | 2 +-
>  tools/testing/selftests/powerpc/mm/pkey_siginfo.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
> index 0af4f02669a1..29b91b7456eb 100644
> --- a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
> +++ b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
> @@ -72,7 +72,7 @@ static void segv_handler(int signum, siginfo_t *sinfo, void *ctx)
>  
>  		switch (fault_type) {
>  		case PKEY_DISABLE_ACCESS:
> -			pkey_set_rights(fault_pkey, 0);
> +			pkey_set_rights(fault_pkey, PKEY_UNRESTRICTED);
>  			break;
>  		case PKEY_DISABLE_EXECUTE:
>  			/*
> diff --git a/tools/testing/selftests/powerpc/mm/pkey_siginfo.c b/tools/testing/selftests/powerpc/mm/pkey_siginfo.c
> index 2db76e56d4cb..e89a164c686b 100644
> --- a/tools/testing/selftests/powerpc/mm/pkey_siginfo.c
> +++ b/tools/testing/selftests/powerpc/mm/pkey_siginfo.c
> @@ -83,7 +83,7 @@ static void segv_handler(int signum, siginfo_t *sinfo, void *ctx)
>  	    mprotect(pgstart, pgsize, PROT_EXEC))
>  		_exit(1);
>  	else
> -		pkey_set_rights(pkey, 0);
> +		pkey_set_rights(pkey, PKEY_UNRESTRICTED);
>  
>  	fault_count++;
>  }

Patch 2 made me realise there are quite a few sys_pkey_alloc(0, 0) calls
in the ppc tests, those could be converted as well.

Kevin


