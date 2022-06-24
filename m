Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFC1559944
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 14:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiFXMN2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jun 2022 08:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiFXMNZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2022 08:13:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA5913FA2;
        Fri, 24 Jun 2022 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656072804; x=1687608804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZYbglsUDaO7hYs/7+MP+nR5SAIt/pDO6vcxGBy8iU1Q=;
  b=i7J/+H4088/sXuDE4y2wxCYad5Hp9LCEbuCxcfWSp0XO8K5hYYtArBC+
   vk7JSJNlKEXrIDR8R1nvI4mL8vm3JTH1SESh3my176JVlykGpSks/6Yad
   t9Bfo2uJYGxeGnkhMiBre6S9XHRfzORvan31y2Kh7csyNmHPeSBtBefEU
   jCbur9X/hu9+cPLucZubk9T03jPWaT0v2G+TomXT0dROGIGOvtBsnpYE9
   pzISwqKurGmfDXezitjNgIivTrTvHmLEGN/DvWGOn+/UPCF6BrTwiGi+L
   Lj+djSVVnv7n2JFjX4u7t40kVIHAC+JIOxHI/403hNIAkNs5J0HqkyQzu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="342676755"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="342676755"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 05:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="615952843"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga008.jf.intel.com with ESMTP; 24 Jun 2022 05:13:17 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25OCDEo0014999;
        Fri, 24 Jun 2022 13:13:15 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/9] bitops: let optimize out non-atomic bitops on compile-time constants
Date:   Fri, 24 Jun 2022 14:13:04 +0200
Message-Id: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

While I was working on converting some structure fields from a fixed
type to a bitmap, I started observing code size increase not only in
places where the code works with the converted structure fields, but
also where the converted vars were on the stack. That said, the
following code:

	DECLARE_BITMAP(foo, BITS_PER_LONG) = { }; // -> unsigned long foo[1];
	unsigned long bar = BIT(BAR_BIT);
	unsigned long baz = 0;

	__set_bit(FOO_BIT, foo);
	baz |= BIT(BAZ_BIT);

	BUILD_BUG_ON(!__builtin_constant_p(test_bit(FOO_BIT, foo));
	BUILD_BUG_ON(!__builtin_constant_p(bar & BAR_BIT));
	BUILD_BUG_ON(!__builtin_constant_p(baz & BAZ_BIT));

triggers the first assertion on x86_64, which means that the
compiler is unable to evaluate it to a compile-time initializer
when the architecture-specific bitop is used even if it's obvious.
I found that this is due to that many architecture-specific
non-atomic bitop implementations use inline asm or other hacks which
are faster or more robust when working with "real" variables (i.e.
fields from the structures etc.), but the compilers have no clue how
to optimize them out when called on compile-time constants.

So, in order to let the compiler optimize out such cases, expand the
test_bit() and __*_bit() definitions with a compile-time condition
check, so that they will pick the generic C non-atomic bitop
implementations when all of the arguments passed are compile-time
constants, which means that the result will be a compile-time
constant as well and the compiler will produce more efficient and
simple code in 100% cases (no changes when there's at least one
non-compile-time-constant argument).
The condition itself:

if (
__builtin_constant_p(nr) &&	/* <- bit position is constant */
__builtin_constant_p(!!addr) &&	/* <- compiler knows bitmap addr is
				      always either NULL or not */
addr &&				/* <- bitmap addr is not NULL */
__builtin_constant_p(*addr)	/* <- compiler knows the value of
				      the target bitmap */
)
	/* then pick the generic C variant
else
	/* old code path, arch-specific

I also tried __is_constexpr() as suggested by Andy, but it was
always returning 0 ('not a constant') for the 2,3 and 4th
conditions.

The object code size changes are architecture, compiler and compiler
flags dependent, there could be 80 Kb saved in one case and then 5
Kb added in another, but what most important is that the bitops are
now often transparent for the compilers, e.g. the following:

	DECLARE_BITMAP(flags, __IP_TUNNEL_FLAG_NUM) = { };
	__be16 flags;

	__set_bit(IP_TUNNEL_CSUM_BIT, flags);

	tun_flags = cpu_to_be16(*flags & U16_MAX);

	if (test_bit(IP_TUNNEL_VTI_BIT, flags))
		tun_flags |= VTI_ISVTI;

	BUILD_BUG_ON(!__builtin_constant_p(tun_flags));

doesn't blow up anymore (which is being checked now at build time),
so that we can now e.g. use fixed bitmaps in compile-time assertions
etc.

Runtime-tested on x86_64 built with LLVM 14 and GCC 10-12,
compile-time tested on ARC (GCC 11), S390 (GCC 11-12, Clang 14,
Clang 15-git) (+ some tests on m68k and ARM64 from the reviewers).

From v4[0]:
* add a workaround to the bitmap compile-time tests code for Clang
  for s390: it is able to optimize the operations, but at the same
  time triggers the assertions (in a weird way) (lkp);
* added missed bits for unification the prototypes on s390 as well;
* fixed the issue in the ice driver code revealed by one of the
  optimizations (lkp);
* there also was one report that GCC 11 on Debian was unable to
  perform optimizations on x86 with v3 applied, but I couldn't
  reproduce it on generic GCC 10-12. Hope it was some random
  unrelated one-time issue.

From v3[1]:
* fix a typo in the comment in 0006 (Andy);
* pick more Reviewed-bys (Andy, Marco);
* don't assume compiler expands small mem*() builtins in bitmap_*()
  (me, with a small hint from lkp).

From v2[2]:
* collect several Reviewed-bys (Andy, Yury);
* add a comment to generic_test_bit() that it is atomic-safe and
  must always stay like that (the first version of this series
  erroneously tried to change this) (Andy, Marco);
* unify the way how architectures define platform-specific bitops,
  both supporting instrumentation and not: now they define only
  'arch_' versions and asm-generic includes take care of the rest;
* micro-optimize the diffstat of 0004/0007 (__check_bitop_pr())
  (Andy);
* add compile-time tests to lib/test_bitmap to make sure everything
  works as expected on any setup (Yury).

From v1[3]:
* change 'gen_' prefixes to '_generic' to disambiguate from
  'generated' etc. (Mark);
* define a separate 'const_' set to use in the optimization to keep
  the generic test_bit() atomic-safe (Marco);
* unify arch_{test,__*}_bit() as well and include them in the type
  check;
* add more relevant and up-to-date bloat-o-meter results, including
  ARM64 (me, Mark);
* pick a couple '*-by' tags (Mark, Yury).

Also available on my open GH[4].

[0] https://lore.kernel.org/linux-arch/20220621191553.69455-1-alexandr.lobakin@intel.com
[1] https://lore.kernel.org/linux-arch/20220617144031.2549432-1-alexandr.lobakin@intel.com
[2] https://lore.kernel.org/linux-arch/20220610113427.908751-1-alexandr.lobakin@intel.com
[3] https://lore.kernel.org/linux-arch/20220606114908.962562-1-alexandr.lobakin@intel.com
[4] https://github.com/alobakin/linux/commits/bitops

Alexander Lobakin (9):
  ia64, processor: fix -Wincompatible-pointer-types in ia64_get_irr()
  bitops: always define asm-generic non-atomic bitops
  bitops: unify non-atomic bitops prototypes across architectures
  bitops: define const_*() versions of the non-atomics
  bitops: wrap non-atomic bitops with a transparent macro
  bitops: let optimize out non-atomic bitops on compile-time constants
  net/ice: fix initializing the bitmap in the switch code
  bitmap: don't assume compiler evaluates small mem*() builtins calls
  lib: test_bitmap: add compile-time optimization/evaluations assertions

 arch/alpha/include/asm/bitops.h               |  32 ++--
 arch/hexagon/include/asm/bitops.h             |  24 ++-
 arch/ia64/include/asm/bitops.h                |  42 ++---
 arch/ia64/include/asm/processor.h             |   2 +-
 arch/m68k/include/asm/bitops.h                |  49 ++++--
 arch/s390/include/asm/bitops.h                |  61 +++----
 arch/sh/include/asm/bitops-op32.h             |  34 ++--
 arch/sparc/include/asm/bitops_32.h            |  18 +-
 arch/sparc/lib/atomic32.c                     |  12 +-
 arch/x86/include/asm/bitops.h                 |  22 +--
 drivers/net/ethernet/intel/ice/ice_switch.c   |   2 +-
 .../asm-generic/bitops/generic-non-atomic.h   | 161 ++++++++++++++++++
 .../bitops/instrumented-non-atomic.h          |  35 ++--
 include/asm-generic/bitops/non-atomic.h       | 121 +------------
 .../bitops/non-instrumented-non-atomic.h      |  16 ++
 include/linux/bitmap.h                        |  22 ++-
 include/linux/bitops.h                        |  50 ++++++
 lib/test_bitmap.c                             |  62 +++++++
 tools/include/asm-generic/bitops/non-atomic.h |  34 ++--
 tools/include/linux/bitops.h                  |  16 ++
 20 files changed, 544 insertions(+), 271 deletions(-)
 create mode 100644 include/asm-generic/bitops/generic-non-atomic.h
 create mode 100644 include/asm-generic/bitops/non-instrumented-non-atomic.h

-- 
2.36.1

