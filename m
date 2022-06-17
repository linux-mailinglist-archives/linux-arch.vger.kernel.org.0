Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190D754FB7F
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382926AbiFQQve (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 12:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382945AbiFQQvQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 12:51:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411CA5AA69;
        Fri, 17 Jun 2022 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655484611; x=1687020611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eVOsPXGOnxBBdqmEHxWZRZJJ9DlSeZf0/Z49Pzz2lag=;
  b=MIbr6q/flU8pDbuUKwWsWz3C2zqp5hZwzMnPnnHdbV7MUsGjsrAdsh1i
   qsOhZQv+2caXLN7VCqYFknQkg4NHDNUaQTGR6PTxCs4v00msSKebyvBNi
   ZTjy97ns4VF/us+m5rlrRQOaP7YbFMKIcXokVwjtvRukHJAhA+U7fclSi
   kXon7CezrDHF/+YhK7h4uZhMNm5OIUsKsoxQo1hrwpDIplZz+WGEFn+IZ
   MeROj94Dv4nuSt7uxRrIKR0KWSPhAuFMd6eWgubhyy7A1htZlHeJJBJ90
   rQ/gpULMgJaXA03THCDRUjS9/z31g4lP7DmhzJVIkDNq0kLisrkRzYEQI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259941427"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259941427"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 07:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="578081656"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga002.jf.intel.com with ESMTP; 17 Jun 2022 07:40:35 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25HEeXl2024161;
        Fri, 17 Jun 2022 15:40:33 +0100
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
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] bitops: let optimize out non-atomic bitops on compile-time constants
Date:   Fri, 17 Jun 2022 16:40:24 +0200
Message-Id: <20220617144031.2549432-1-alexandr.lobakin@intel.com>
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

The savings are architecture, compiler and compiler flags dependent,
for example, on x86_64 -O2:

GCC 12: add/remove: 78/29 grow/shrink: 332/525 up/down: 31325/-61560 (-30235)
LLVM 13: add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)
LLVM 14: add/remove: 10/3 grow/shrink: 93/138 up/down: 3705/-6992 (-3287)

and ARM64 (courtesy of Mark[0]):

GCC 11: add/remove: 92/29 grow/shrink: 933/2766 up/down: 39340/-82580 (-43240)
LLVM 14: add/remove: 21/11 grow/shrink: 620/651 up/down: 12060/-15824 (-3764)

And the following:

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

The series has been in intel-next for a while with no reported issues.

From v2[1]:
* collect several Reviewed-bys (Andy, Yury);
* add a comment to generic_test_bit() that it is atomic-safe and
  must always stay like that (the first version of this series
  errorneously tried to change this) (Andy, Marco);
* unify the way how architectures define platform-specific bitops,
  both supporting instrumentation and not: now they define only
  'arch_' versions and asm-generic includes take care of the rest;
* micro-optimize the diffstat of 0004/0007 (__check_bitop_pr())
  (Andy);
* add compile-time tests to lib/test_bitmap to make sure everything
  works as expected on any setup (Yury).

From v1[2]:
* change 'gen_' prefixes to '_generic' to disambiguate from
  'generated' etc. (Mark);
* define a separate 'const_' set to use in the optimization to keep
  the generic test_bit() atomic-safe (Marco);
* unify arch_{test,__*}_bit() as well and include them in the type
  check;
* add more relevant and up-to-date bloat-o-meter results, including
  ARM64 (me, Mark);
* pick a couple '*-by' tags (Mark, Yury).

Also available on my open GH[3].

[0] https://lore.kernel.org/all/Yp4GQFQYD32Rs9Cw@FVFF77S0Q05N
[1] https://lore.kernel.org/linux-arch/20220610113427.908751-1-alexandr.lobakin@intel.com
[2] https://lore.kernel.org/all/20220606114908.962562-1-alexandr.lobakin@intel.com
[3] https://github.com/alobakin/linux/commits/bitops

Alexander Lobakin (7):
  ia64, processor: fix -Wincompatible-pointer-types in ia64_get_irr()
  bitops: always define asm-generic non-atomic bitops
  bitops: unify non-atomic bitops prototypes across architectures
  bitops: define const_*() versions of the non-atomics
  bitops: wrap non-atomic bitops with a transparent macro
  bitops: let optimize out non-atomic bitops on compile-time constants
  lib: test_bitmap: add compile-time optimization/evaluations assertions

 arch/alpha/include/asm/bitops.h               |  32 ++--
 arch/hexagon/include/asm/bitops.h             |  24 ++-
 arch/ia64/include/asm/bitops.h                |  42 ++---
 arch/ia64/include/asm/processor.h             |   2 +-
 arch/m68k/include/asm/bitops.h                |  49 ++++--
 arch/sh/include/asm/bitops-op32.h             |  34 ++--
 arch/sparc/include/asm/bitops_32.h            |  18 +-
 arch/sparc/lib/atomic32.c                     |  12 +-
 arch/x86/include/asm/bitops.h                 |  22 +--
 .../asm-generic/bitops/generic-non-atomic.h   | 161 ++++++++++++++++++
 .../bitops/instrumented-non-atomic.h          |  35 ++--
 include/asm-generic/bitops/non-atomic.h       | 121 +------------
 .../bitops/non-instrumented-non-atomic.h      |  16 ++
 include/linux/bitops.h                        |  50 ++++++
 lib/test_bitmap.c                             |  45 +++++
 tools/include/asm-generic/bitops/non-atomic.h |  34 ++--
 tools/include/linux/bitops.h                  |  16 ++
 17 files changed, 476 insertions(+), 237 deletions(-)
 create mode 100644 include/asm-generic/bitops/generic-non-atomic.h
 create mode 100644 include/asm-generic/bitops/non-instrumented-non-atomic.h

-- 
2.36.1

