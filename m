Return-Path: <linux-arch+bounces-8633-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D609B29C5
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 09:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6B0284420
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 08:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6687D1922EF;
	Mon, 28 Oct 2024 07:59:43 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02D1191F85
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730102383; cv=none; b=ZwVYn2oYyyLabHXE22lBfwWjykzAsn1Yoi84yuNP6VobfDoh9Z3nYLHKmbw/IGmNEA5MmZyTFf3bCA/XUe6aVYRj50+Lx8bMAthSBYvjnYMQoUbPRNHu2Cq25dlEYrhVaQToWYsYpTpPEqhjwlCGmEtJ8iYWSLkQPWy9Fdhk+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730102383; c=relaxed/simple;
	bh=47eyJtaiEQ6QFqs01PK9YIyRdoEaUnfO6OkDJnTdjzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aToo+Ju7Qr3TFFyueM61kIboh2csVLDCjC7l5w+rjTW7RFiZiEnWXiiWaBkpq0W3c592HkZOUFUup4WqR9nDu9N/OBAkwMiqJtuIOEuEtMWxjto0KqKbM69cLFBQZiouFCjee+MVbNA6HPJjs/b8PL1qyjMxtayg/w0woRrY/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7435D497;
	Mon, 28 Oct 2024 01:00:08 -0700 (PDT)
Received: from [10.57.64.61] (unknown [10.57.64.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D07533F66E;
	Mon, 28 Oct 2024 00:59:36 -0700 (PDT)
Message-ID: <b5c403c6-c0e1-4050-b36e-428b8d80936b@arm.com>
Date: Mon, 28 Oct 2024 08:59:34 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/mm: Use PKEY_UNRESTRICTED macro
To: Yury Khrustalev <yury.khrustalev@arm.com>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joey Gouly <joey.gouly@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sandipan Das <sandipan@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, nd@arm.com
References: <20241027170006.464252-1-yury.khrustalev@arm.com>
 <20241027170006.464252-3-yury.khrustalev@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241027170006.464252-3-yury.khrustalev@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/10/2024 18:00, Yury Khrustalev wrote:
> Replace literal 0 with macro PKEY_UNRESTRICTED where pkey_*() functions
> are used in mm selftests for memory protection keys.
>
> Signed-off-by: Yury Khrustalev <yury.khrustalev@arm.com>
> Suggested-by: Joey Gouly <joey.gouly@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  tools/testing/selftests/mm/mseal_test.c            | 4 ++--
>  tools/testing/selftests/mm/pkey-helpers.h          | 3 ++-
>  tools/testing/selftests/mm/pkey_sighandler_tests.c | 4 ++--
>  tools/testing/selftests/mm/protection_keys.c       | 2 +-
>  4 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index 01675c412b2a..eab214997de0 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -218,7 +218,7 @@ bool seal_support(void)
>  bool pkey_supported(void)
>  {
>  #if defined(__i386__) || defined(__x86_64__) /* arch */
> -	int pkey = sys_pkey_alloc(0, 0);
> +	int pkey = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
>  
>  	if (pkey > 0)
>  		return true;
> @@ -1671,7 +1671,7 @@ static void test_seal_discard_ro_anon_on_pkey(bool seal)
>  	setup_single_address_rw(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
>  
> -	pkey = sys_pkey_alloc(0, 0);
> +	pkey = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
>  	FAIL_TEST_IF_FALSE(pkey > 0);
>  
>  	ret = sys_mprotect_pkey((void *)ptr, size, PROT_READ | PROT_WRITE, pkey);

Found one more case just below:

diff --git a/tools/testing/selftests/mm/mseal_test.c
b/tools/testing/selftests/mm/mseal_test.c
index 01675c412b2a..cb0671de1299 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -1683,7 +1683,7 @@ static void test_seal_discard_ro_anon_on_pkey(bool
seal)
     }
 
     /* sealing doesn't take effect if PKRU allow write. */
-    set_pkey(pkey, 0);
+    set_pkey(pkey, PKEY_UNRESTRICTED);
     ret = sys_madvise(ptr, size, MADV_DONTNEED);
     FAIL_TEST_IF_FALSE(!ret);


- Kevin

> [...]


