Return-Path: <linux-arch+bounces-11866-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD547AADA56
	for <lists+linux-arch@lfdr.de>; Wed,  7 May 2025 10:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B0B9859C4
	for <lists+linux-arch@lfdr.de>; Wed,  7 May 2025 08:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0F4221D88;
	Wed,  7 May 2025 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6P0hepD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D3212F89;
	Wed,  7 May 2025 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746607140; cv=none; b=XqRcWvpULv1YzBA6OrELiRObM3pWBTCOLypJFZMqpp+nHlO2/Oeu/gyl0scKdcIr9LXRKyx8z6jnWE8A92imrCtUtfVzYXwKYX7RDoODZKD0u1rxcaasLxYXOCBQLD+UOxbb5TcJ/dJmrO9jMb5RFlSSBwtdP3s4Va7nYH4oWKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746607140; c=relaxed/simple;
	bh=sfIRBWz57bESN0N5rP5vLWqllCJK87/7X7U2QAb9P2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys1D4VJB1GeZH/OT+3JJ14nWfMe+rGC/QXfX7wykzLldp1oM59KFPfVzH0rHLUeTMtVAk21W8jamFiHa5A/qqQrqQXAd+15hwfqCXrYF3N/ZizgfHjW5a+3hYJaO0b6T/lvrlqZHl9lmwcDvXyZs5DzqR8QxoQoGgOMa0gIeqXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6P0hepD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746607139; x=1778143139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sfIRBWz57bESN0N5rP5vLWqllCJK87/7X7U2QAb9P2Y=;
  b=O6P0hepD8bjcxmcnAfpF+qktukv3FvlmlOTTdHrUyrchG85ueFj0Bqbu
   EAN/+VfEG2lmjrs+Qp52e4ZHzLQovVWQFBdkNzuijnxKY5z4yl3s64+jp
   WJcOrk8HVC7vmj/dc+Fm3X2DZFPdlzYY5v1FWzaxLOlufEj5NXDSaj1lb
   k6JnAhGYpM3VOUDBksJ7ZqVBJCWm2GnGC57F0egT+Huuomd4H8DpdeDPv
   7kto4LJ/XyTUUzPP/VCALpF/s4v/RtpAnt/2iGgqQ8Q1Kvif29XRnEJ2Y
   HzUXhKq9wQZTEqoQArYIab34R84PuvMzqbSh8Z3rd4+bnlvNWAZRqvnXg
   w==;
X-CSE-ConnectionGUID: t/h16DumTe6trDu52E6gkw==
X-CSE-MsgGUID: uVlm0qcnSa2xcos7dCpYvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48195747"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="48195747"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 01:38:58 -0700
X-CSE-ConnectionGUID: u15cOkStSwm3lq+agpMLpw==
X-CSE-MsgGUID: REPlWn1oT96BVJFOJC63Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="136410621"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 May 2025 01:38:53 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCaIl-0007QF-04;
	Wed, 07 May 2025 08:38:51 +0000
Date: Wed, 7 May 2025 16:38:04 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Rogers <irogers@google.com>, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Leo Yan <leo.yan@arm.com>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/5] bitfield: Silence a clang -Wshorten-64-to-32
 warning
Message-ID: <202505071638.ZLhUrspy-lkp@intel.com>
References: <20250430171534.132774-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430171534.132774-2-irogers@google.com>

Hi Ian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on soc/for-next linus/master v6.15-rc5 next-20250506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/bitfield-Silence-a-clang-Wshorten-64-to-32-warning/20250501-011830
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20250430171534.132774-2-irogers%40google.com
patch subject: [PATCH v2 1/5] bitfield: Silence a clang -Wshorten-64-to-32 warning
config: mips-randconfig-r111-20250501 (https://download.01.org/0day-ci/archive/20250507/202505071638.ZLhUrspy-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce: (https://download.01.org/0day-ci/archive/20250507/202505071638.ZLhUrspy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071638.ZLhUrspy-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/bitfield_kunit.c: note: in included file (through include/linux/fortify-string.h, include/linux/string.h, include/linux/bitmap.h, ...):
>> include/linux/bitfield.h:200:1: sparse: sparse: cast to restricted __le16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast from restricted __le16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast to restricted __be16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast from restricted __be16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast to restricted __le16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast from restricted __le16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast to restricted __be16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast from restricted __be16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast to restricted __le16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast from restricted __le16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast to restricted __be16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast from restricted __be16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast to restricted __le16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast from restricted __le16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast to restricted __be16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast from restricted __be16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast to restricted __le16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast from restricted __le16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast to restricted __be16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast from restricted __be16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast to restricted __le16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast from restricted __le16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast to restricted __be16
>> include/linux/bitfield.h:200:1: sparse: sparse: cast from restricted __be16
>> include/linux/bitfield.h:201:1: sparse: sparse: cast to restricted __le32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast from restricted __le32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast to restricted __be32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast from restricted __be32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast to restricted __le32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast from restricted __le32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast to restricted __be32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast from restricted __be32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast to restricted __le32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast from restricted __le32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast to restricted __be32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast from restricted __be32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast to restricted __le32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast from restricted __le32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast to restricted __be32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast from restricted __be32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast to restricted __le32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast from restricted __le32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast to restricted __be32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast from restricted __be32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast to restricted __le32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast from restricted __le32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast to restricted __be32
>> include/linux/bitfield.h:201:1: sparse: sparse: cast from restricted __be32
>> include/linux/bitfield.h:202:1: sparse: sparse: cast to restricted __le64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast from restricted __le64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast to restricted __be64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast from restricted __be64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast to restricted __le64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast from restricted __le64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast to restricted __be64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast from restricted __be64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast to restricted __le64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast from restricted __le64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast to restricted __be64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast from restricted __be64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast to restricted __le64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast from restricted __le64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast to restricted __be64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast from restricted __be64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast to restricted __le64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast from restricted __le64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast to restricted __be64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast from restricted __be64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast to restricted __le64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast from restricted __le64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast to restricted __be64
>> include/linux/bitfield.h:202:1: sparse: sparse: cast from restricted __be64
   lib/bitfield_kunit.c: note: in included file (through include/linux/thread_info.h, include/asm-generic/preempt.h, arch/mips/include/generated/asm/preempt.h, ...):
   include/linux/bitops.h:274:19: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   include/linux/bitops.h:279:37: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   include/linux/bitops.h:274:19: sparse: sparse: cast truncates bits from constant value (7f00000000000000 becomes 0)
   include/linux/bitops.h:279:37: sparse: sparse: cast truncates bits from constant value (7f00000000000000 becomes 0)
   include/linux/bitops.h:274:19: sparse: sparse: cast truncates bits from constant value (1800000000000 becomes 0)
   include/linux/bitops.h:279:37: sparse: sparse: cast truncates bits from constant value (1800000000000 becomes 0)
   include/linux/bitops.h:274:19: sparse: sparse: cast truncates bits from constant value (1f8000000 becomes f8000000)
   include/linux/bitops.h:279:37: sparse: sparse: cast truncates bits from constant value (1f8000000 becomes f8000000)

vim +200 include/linux/bitfield.h

e2192de59e457a Johannes Berg   2023-01-18  120  
e2192de59e457a Johannes Berg   2023-01-18  121  /**
e2192de59e457a Johannes Berg   2023-01-18  122   * FIELD_PREP_CONST() - prepare a constant bitfield element
e2192de59e457a Johannes Berg   2023-01-18  123   * @_mask: shifted mask defining the field's length and position
e2192de59e457a Johannes Berg   2023-01-18  124   * @_val:  value to put in the field
e2192de59e457a Johannes Berg   2023-01-18  125   *
e2192de59e457a Johannes Berg   2023-01-18  126   * FIELD_PREP_CONST() masks and shifts up the value.  The result should
e2192de59e457a Johannes Berg   2023-01-18  127   * be combined with other fields of the bitfield using logical OR.
e2192de59e457a Johannes Berg   2023-01-18  128   *
e2192de59e457a Johannes Berg   2023-01-18  129   * Unlike FIELD_PREP() this is a constant expression and can therefore
e2192de59e457a Johannes Berg   2023-01-18  130   * be used in initializers. Error checking is less comfortable for this
e2192de59e457a Johannes Berg   2023-01-18  131   * version, and non-constant masks cannot be used.
e2192de59e457a Johannes Berg   2023-01-18  132   */
e2192de59e457a Johannes Berg   2023-01-18  133  #define FIELD_PREP_CONST(_mask, _val)					\
e2192de59e457a Johannes Berg   2023-01-18  134  	(								\
e2192de59e457a Johannes Berg   2023-01-18  135  		/* mask must be non-zero */				\
e2192de59e457a Johannes Berg   2023-01-18  136  		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
e2192de59e457a Johannes Berg   2023-01-18  137  		/* check if value fits */				\
e2192de59e457a Johannes Berg   2023-01-18  138  		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
e2192de59e457a Johannes Berg   2023-01-18  139  		/* check if mask is contiguous */			\
e2192de59e457a Johannes Berg   2023-01-18  140  		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
e2192de59e457a Johannes Berg   2023-01-18  141  		/* and create the value */				\
e2192de59e457a Johannes Berg   2023-01-18  142  		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
e2192de59e457a Johannes Berg   2023-01-18  143  	)
e2192de59e457a Johannes Berg   2023-01-18  144  
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  145  /**
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  146   * FIELD_GET() - extract a bitfield element
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  147   * @_mask: shifted mask defining the field's length and position
7240767450d6d8 Masahiro Yamada 2017-10-03  148   * @_reg:  value of entire bitfield
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  149   *
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  150   * FIELD_GET() extracts the field specified by @_mask from the
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  151   * bitfield passed in as @_reg by masking and shifting it down.
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  152   */
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  153  #define FIELD_GET(_mask, _reg)						\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  154  	({								\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  155  		__BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");	\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  156  		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  157  	})
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  158  
e7d4a95da86e0b Johannes Berg   2018-06-20  159  extern void __compiletime_error("value doesn't fit into mask")
00b0c9b82663ac Al Viro         2017-12-14  160  __field_overflow(void);
00b0c9b82663ac Al Viro         2017-12-14  161  extern void __compiletime_error("bad bitfield mask")
00b0c9b82663ac Al Viro         2017-12-14  162  __bad_mask(void);
00b0c9b82663ac Al Viro         2017-12-14  163  static __always_inline u64 field_multiplier(u64 field)
00b0c9b82663ac Al Viro         2017-12-14  164  {
00b0c9b82663ac Al Viro         2017-12-14  165  	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
00b0c9b82663ac Al Viro         2017-12-14  166  		__bad_mask();
00b0c9b82663ac Al Viro         2017-12-14  167  	return field & -field;
00b0c9b82663ac Al Viro         2017-12-14  168  }
00b0c9b82663ac Al Viro         2017-12-14  169  static __always_inline u64 field_mask(u64 field)
00b0c9b82663ac Al Viro         2017-12-14  170  {
00b0c9b82663ac Al Viro         2017-12-14  171  	return field / field_multiplier(field);
00b0c9b82663ac Al Viro         2017-12-14  172  }
e31a50162feb35 Alex Elder      2020-03-12  173  #define field_max(field)	((typeof(field))field_mask(field))
00b0c9b82663ac Al Viro         2017-12-14  174  #define ____MAKE_OP(type,base,to,from)					\
00b0c9b82663ac Al Viro         2017-12-14  175  static __always_inline __##type type##_encode_bits(base v, base field)	\
00b0c9b82663ac Al Viro         2017-12-14  176  {									\
e7d4a95da86e0b Johannes Berg   2018-06-20  177  	if (__builtin_constant_p(v) && (v & ~field_mask(field)))	\
00b0c9b82663ac Al Viro         2017-12-14  178  		__field_overflow();					\
38e224b77cde3b Ian Rogers      2025-04-30  179  	return to((__##type)((v & field_mask(field)) * field_multiplier(field))); \
00b0c9b82663ac Al Viro         2017-12-14  180  }									\
00b0c9b82663ac Al Viro         2017-12-14  181  static __always_inline __##type type##_replace_bits(__##type old,	\
00b0c9b82663ac Al Viro         2017-12-14  182  					base val, base field)		\
00b0c9b82663ac Al Viro         2017-12-14  183  {									\
00b0c9b82663ac Al Viro         2017-12-14  184  	return (old & ~to(field)) | type##_encode_bits(val, field);	\
00b0c9b82663ac Al Viro         2017-12-14  185  }									\
00b0c9b82663ac Al Viro         2017-12-14  186  static __always_inline void type##p_replace_bits(__##type *p,		\
00b0c9b82663ac Al Viro         2017-12-14  187  					base val, base field)		\
00b0c9b82663ac Al Viro         2017-12-14  188  {									\
00b0c9b82663ac Al Viro         2017-12-14  189  	*p = (*p & ~to(field)) | type##_encode_bits(val, field);	\
00b0c9b82663ac Al Viro         2017-12-14  190  }									\
00b0c9b82663ac Al Viro         2017-12-14  191  static __always_inline base type##_get_bits(__##type v, base field)	\
00b0c9b82663ac Al Viro         2017-12-14  192  {									\
00b0c9b82663ac Al Viro         2017-12-14  193  	return (from(v) & field)/field_multiplier(field);		\
00b0c9b82663ac Al Viro         2017-12-14  194  }
00b0c9b82663ac Al Viro         2017-12-14  195  #define __MAKE_OP(size)							\
00b0c9b82663ac Al Viro         2017-12-14  196  	____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu)	\
00b0c9b82663ac Al Viro         2017-12-14  197  	____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu)	\
00b0c9b82663ac Al Viro         2017-12-14  198  	____MAKE_OP(u##size,u##size,,)
37a3862e123826 Johannes Berg   2018-06-20  199  ____MAKE_OP(u8,u8,,)
00b0c9b82663ac Al Viro         2017-12-14 @200  __MAKE_OP(16)
00b0c9b82663ac Al Viro         2017-12-14 @201  __MAKE_OP(32)
00b0c9b82663ac Al Viro         2017-12-14 @202  __MAKE_OP(64)
00b0c9b82663ac Al Viro         2017-12-14  203  #undef __MAKE_OP
00b0c9b82663ac Al Viro         2017-12-14  204  #undef ____MAKE_OP
00b0c9b82663ac Al Viro         2017-12-14  205  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

