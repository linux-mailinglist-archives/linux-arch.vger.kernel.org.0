Return-Path: <linux-arch+bounces-5620-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DA993BA03
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 03:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C27CB20FA1
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 01:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867B42901;
	Thu, 25 Jul 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhkInb+i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32011876;
	Thu, 25 Jul 2024 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721869491; cv=none; b=G8QqR+F0xIIOvmbRf/WmFYLTmkz1HpXmS67eAMSdEzR3aIHsP/meuMnjrbLv0pqR7TiTZDuc8cTFuaCRvN0qY87AenjaV+W/MEIxoz+qj6qGQHa2bLoE4iH/XYZa/NaT9Opw3NroBnSt8EJyL8vUAQYxqtyS9yYwiV+RG1uaqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721869491; c=relaxed/simple;
	bh=NhHC86JKFaI3iP2K6cYRV9LwDPzEzbV/Pw9wmwn+YaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEqGwpisRnOc12CpaVN39SebmoJkeqc2ZZcLUAowFmKrqB7kHFWEaLtIHM3H3pRxXRVlHoYwO7sw9+FBHRAuZ1Q2wyH5kBNaH1kURkmFXDmWx2Z2nc62LBYKUEDhc6HM6NYyBaskibZ0riuX3tzv80MR7UIZZNM6hzIH3RwwNzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhkInb+i; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721869488; x=1753405488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NhHC86JKFaI3iP2K6cYRV9LwDPzEzbV/Pw9wmwn+YaY=;
  b=OhkInb+i6omm1atrzPboCERKs+DLZW9lik2lNxfYcHJR1gldSZJP8Cxr
   S/mEPrMzDz6gK9Mw075EU03Ibtuqgxc6//GaWjO1irUITAAiHmmmPZbIh
   G7KO/nKVj814LOhoDBEbYz3g3js6uW5Qo48uddHBZViukJeGwuPdUjI29
   pa4D4mfYW2+iIv8FKcJFTrTsmBhmhORQVVsdojYGGmz8q1MZK7GIRpu/O
   0Z/iHWUwBt/qUDh2x1VZ6fsRjewy5P3hTx97Hen6rYRmiWpxoSUB1G7Sv
   664rK9bmKzjz+G7BKJWVcqiPmsEXMCf0thaE8UZCgPDsh0iI1JetTa972
   w==;
X-CSE-ConnectionGUID: I+rJOvUITbybIFmPZlgpmg==
X-CSE-MsgGUID: M25DlkSGRgqT/EEqod0qDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="37102686"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="37102686"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 18:04:47 -0700
X-CSE-ConnectionGUID: LlPSCny/R8eVfvnqlvNN8w==
X-CSE-MsgGUID: uQD4ob+2R/Ol9sLlbRPqtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="57324379"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Jul 2024 18:04:44 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWmuP-000ncJ-2I;
	Thu, 25 Jul 2024 01:04:41 +0000
Date: Thu, 25 Jul 2024 09:04:37 +0800
From: kernel test robot <lkp@intel.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, anshuman.khandual@arm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/2] lib/test_bits.c: Add tests for GENMASK_U128()
Message-ID: <202407250853.f3pSzob6-lkp@intel.com>
References: <20240724103142.165693-3-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724103142.165693-3-anshuman.khandual@arm.com>

Hi Anshuman,

kernel test robot noticed the following build errors:

[auto build test ERROR on arnd-asm-generic/master]
[also build test ERROR on akpm-mm/mm-nonmm-unstable akpm-mm/mm-everything linus/master v6.10 next-20240724]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/uapi-Define-GENMASK_U128/20240724-184809
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20240724103142.165693-3-anshuman.khandual%40arm.com
patch subject: [PATCH 2/2] lib/test_bits.c: Add tests for GENMASK_U128()
config: m68k-sun3x_defconfig (https://download.01.org/0day-ci/archive/20240725/202407250853.f3pSzob6-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240725/202407250853.f3pSzob6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407250853.f3pSzob6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/test_bits.c:6:
   lib/test_bits.c: In function 'genmask_u128_test':
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:45:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:13: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |             ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:45:54: note: in expansion of macro 'GENMASK_U128'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:45:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:26: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |                          ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:45:54: note: in expansion of macro 'GENMASK_U128'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:45:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:17:12: note: in expansion of macro '_U128'
      17 |          (~_U128(0) >> (__BITS_PER_U128 - 1 - (h))))
         |            ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:45:54: note: in expansion of macro 'GENMASK_U128'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:45:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:13: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |             ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:45:54: note: in expansion of macro 'GENMASK_U128'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:45:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:26: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |                          ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:45:54: note: in expansion of macro 'GENMASK_U128'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:16:35: warning: left shift count >= width of type [-Wshift-count-overflow]
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |                                   ^~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:45:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:45:54: note: in expansion of macro 'GENMASK_U128'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:45:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:17:12: note: in expansion of macro '_U128'
      17 |          (~_U128(0) >> (__BITS_PER_U128 - 1 - (h))))
         |            ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:45:54: note: in expansion of macro 'GENMASK_U128'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:17:21: warning: right shift count >= width of type [-Wshift-count-overflow]
      17 |          (~_U128(0) >> (__BITS_PER_U128 - 1 - (h))))
         |                     ^~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:45:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:45:54: note: in expansion of macro 'GENMASK_U128'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |                                                      ^~~~~~~~~~~~
   lib/test_bits.c:45:75: warning: right shift count >= width of type [-Wshift-count-overflow]
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |                                                                           ^~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:45:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      45 |         KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
         |         ^~~~~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:13: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |             ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:26: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |                          ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:17:12: note: in expansion of macro '_U128'
      17 |          (~_U128(0) >> (__BITS_PER_U128 - 1 - (h))))
         |            ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:13: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |             ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:26: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |                          ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:16:35: warning: left shift count >= width of type [-Wshift-count-overflow]
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |                                   ^~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:17:12: note: in expansion of macro '_U128'
      17 |          (~_U128(0) >> (__BITS_PER_U128 - 1 - (h))))
         |            ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:17:21: warning: right shift count >= width of type [-Wshift-count-overflow]
      17 |          (~_U128(0) >> (__BITS_PER_U128 - 1 - (h))))
         |                     ^~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |         ^~~~~~~~~~~~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:46:54: note: in expansion of macro 'GENMASK_U128'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |                                                      ^~~~~~~~~~~~
   lib/test_bits.c:46:75: warning: right shift count >= width of type [-Wshift-count-overflow]
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |                                                                           ^~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:46:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      46 |         KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
         |         ^~~~~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:13: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |             ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:26: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |                          ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:17:12: note: in expansion of macro '_U128'
      17 |          (~_U128(0) >> (__BITS_PER_U128 - 1 - (h))))
         |            ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:13: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |             ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:26: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |                          ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:17:12: note: in expansion of macro '_U128'
      17 |          (~_U128(0) >> (__BITS_PER_U128 - 1 - (h))))
         |            ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/bits.h:17:21: warning: right shift count >= width of type [-Wshift-count-overflow]
      17 |          (~_U128(0) >> (__BITS_PER_U128 - 1 - (h))))
         |                     ^~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:47:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |         ^~~~~~~~~~~~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:47:54: note: in expansion of macro 'GENMASK_U128'
      47 |         KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:48:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      48 |         KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:13: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |             ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:48:54: note: in expansion of macro 'GENMASK_U128'
      48 |         KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
         |                                                      ^~~~~~~~~~~~
>> include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:48:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      48 |         KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:26: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |                          ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:48:54: note: in expansion of macro 'GENMASK_U128'
      48 |         KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:48:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      48 |         KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:17:12: note: in expansion of macro '_U128'
      17 |          (~_U128(0) >> (__BITS_PER_U128 - 1 - (h))))
         |            ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:48:54: note: in expansion of macro 'GENMASK_U128'
      48 |         KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:48:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      48 |         KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:13: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \
         |             ^~~~~
   include/linux/bits.h:39:38: note: in expansion of macro '__GENMASK_U128'
      39 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
         |                                      ^~~~~~~~~~~~~~
   lib/test_bits.c:48:54: note: in expansion of macro 'GENMASK_U128'
      48 |         KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
         |                                                      ^~~~~~~~~~~~
   include/uapi/linux/const.h:24:36: error: '__int128' is not supported on this target
      24 | #define _AC128(X)       ((unsigned __int128)(X))
         |                                    ^~~~~~~~
   include/kunit/test.h:708:40: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     708 |         const typeof(right) __right = (right);                                 \
         |                                        ^~~~~
   include/kunit/test.h:903:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     903 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:900:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     900 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   lib/test_bits.c:48:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      48 |         KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
         |         ^~~~~~~~~~~~~~~
   include/uapi/linux/const.h:29:26: note: in expansion of macro '_AC128'
      29 | #define _U128(x)        (_AC128(x))
         |                          ^~~~~~
   include/uapi/linux/bits.h:16:26: note: in expansion of macro '_U128'
      16 |         (((~_U128(0)) - (_U128(1) << (l)) + 1) & \


vim +/__int128 +24 include/uapi/linux/const.h

9d291e787b2b71 include/asm-x86_64/const.h Vivek Goyal         2007-05-02   6  
9d291e787b2b71 include/asm-x86_64/const.h Vivek Goyal         2007-05-02   7  /* Some constant macros are used in both assembler and
9d291e787b2b71 include/asm-x86_64/const.h Vivek Goyal         2007-05-02   8   * C code.  Therefore we cannot annotate them always with
6df95fd7ad9a84 include/linux/const.h      Randy Dunlap        2007-05-08   9   * 'UL' and other type specifiers unilaterally.  We
9d291e787b2b71 include/asm-x86_64/const.h Vivek Goyal         2007-05-02  10   * use the following macros to deal with this.
74ef649fe847fd include/linux/const.h      Jeremy Fitzhardinge 2008-01-30  11   *
74ef649fe847fd include/linux/const.h      Jeremy Fitzhardinge 2008-01-30  12   * Similarly, _AT() will cast an expression with a type in C, but
74ef649fe847fd include/linux/const.h      Jeremy Fitzhardinge 2008-01-30  13   * leave it unchanged in asm.
9d291e787b2b71 include/asm-x86_64/const.h Vivek Goyal         2007-05-02  14   */
9d291e787b2b71 include/asm-x86_64/const.h Vivek Goyal         2007-05-02  15  
9d291e787b2b71 include/asm-x86_64/const.h Vivek Goyal         2007-05-02  16  #ifdef __ASSEMBLY__
9d291e787b2b71 include/asm-x86_64/const.h Vivek Goyal         2007-05-02  17  #define _AC(X,Y)	X
74ef649fe847fd include/linux/const.h      Jeremy Fitzhardinge 2008-01-30  18  #define _AT(T,X)	X
bcf33156d03759 include/uapi/linux/const.h Anshuman Khandual   2024-07-24  19  #define _AC128(X)	X
9d291e787b2b71 include/asm-x86_64/const.h Vivek Goyal         2007-05-02  20  #else
9d291e787b2b71 include/asm-x86_64/const.h Vivek Goyal         2007-05-02  21  #define __AC(X,Y)	(X##Y)
9d291e787b2b71 include/asm-x86_64/const.h Vivek Goyal         2007-05-02  22  #define _AC(X,Y)	__AC(X,Y)
74ef649fe847fd include/linux/const.h      Jeremy Fitzhardinge 2008-01-30  23  #define _AT(T,X)	((T)(X))
bcf33156d03759 include/uapi/linux/const.h Anshuman Khandual   2024-07-24 @24  #define _AC128(X)	((unsigned __int128)(X))
9d291e787b2b71 include/asm-x86_64/const.h Vivek Goyal         2007-05-02  25  #endif
9d291e787b2b71 include/asm-x86_64/const.h Vivek Goyal         2007-05-02  26  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

