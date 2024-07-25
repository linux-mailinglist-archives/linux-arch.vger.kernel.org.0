Return-Path: <linux-arch+bounces-5623-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0DE93BBAF
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 06:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B331F227A5
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 04:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0E11C683;
	Thu, 25 Jul 2024 04:19:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB231CAA2;
	Thu, 25 Jul 2024 04:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881184; cv=none; b=XZtZjkK+KhR314aMcwi4wG5eL6fbrKO31roRPI/aRgYDel3SE9Sf64zPn1Vsyq/V/6HttAVZ9d6+s355lF8hiykTfDEN0TKDR/kBLZxABdaH0vFO18P1RsXDg8bx+zgusXCt0yKh279EM86V7TtCuc9pFUGHwmDP5GMRSMTFQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881184; c=relaxed/simple;
	bh=S0cRj+oMwg12+CCQ+W84mXsrDS/1Vyw1BM28Fjx6tlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOqpqsWSxoCLZA42U6/S/cL0uKjS8tHJz0oB6hiH/D4PhHo6H+QkRbUCOYGIecFlL02v4fJqiENbnjRimcE8qMxCti24qPY8hYg68w43plmwNA7TIDiKWGGVikAbadmWGt1glaXTIqWZ3pCLXTJpKku2e9vIirLzPJvHBQBWP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F14FD1007;
	Wed, 24 Jul 2024 21:20:00 -0700 (PDT)
Received: from [10.162.40.19] (a077893.blr.arm.com [10.162.40.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 248C23F73F;
	Wed, 24 Jul 2024 21:19:31 -0700 (PDT)
Message-ID: <e394cf97-df7e-4eec-8ef5-3aba2075f89f@arm.com>
Date: Thu, 25 Jul 2024 09:49:28 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lib/test_bits.c: Add tests for GENMASK_U128()
To: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
References: <20240724103142.165693-3-anshuman.khandual@arm.com>
 <202407250853.f3pSzob6-lkp@intel.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <202407250853.f3pSzob6-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/25/24 06:34, kernel test robot wrote:
> Hi Anshuman,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on arnd-asm-generic/master]
> [also build test ERROR on akpm-mm/mm-nonmm-unstable akpm-mm/mm-everything linus/master v6.10 next-20240724]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/uapi-Define-GENMASK_U128/20240724-184809
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> patch link:    https://lore.kernel.org/r/20240724103142.165693-3-anshuman.khandual%40arm.com
> patch subject: [PATCH 2/2] lib/test_bits.c: Add tests for GENMASK_U128()
> config: m68k-sun3x_defconfig (https://download.01.org/0day-ci/archive/20240725/202407250853.f3pSzob6-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240725/202407250853.f3pSzob6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407250853.f3pSzob6-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from lib/test_bits.c:6:
>    lib/test_bits.c: In function 'genmask_u128_test':
>>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
>       24 | #define _AC128(X)       ((unsigned __int128)(X))
>          |                                    ^~~~~~~~
>    include/kunit/test.h:708:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
>      708 |         const typeof(right) __right = (right);                                 \
>          |                      ^~~~~
>    include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
>      903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
>      900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
>          |         ^~~~~~~~~~~~~~~~~~~
>    lib/test_bits.c:45:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
>       45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
>          |         ^~~~~~~~~~~~~~~
>    include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
>       29 | #define _U128(x)        (_AC128(x))
>          |                          ^~~~~~
>    include/uapi/linux/bits.h:16:13: note: in expansion of macro '_U128'
>       16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
>          |             ^~~~~
>    include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
>       39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
>          |                                      ^~~~~~~~~~~~~~
>    lib/test_bits.c:45:54: note: in expansion of macro 'GENMASK_U128'
>       45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);

This is probably triggered with GENMASK_U128() usage which is not protected
with ARCH_SUPPORTS_INT128. Will respin the series with required fixes.

