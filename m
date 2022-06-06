Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F41C53E752
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiFFLuW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiFFLuV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 07:50:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FF023B548;
        Mon,  6 Jun 2022 04:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654516220; x=1686052220;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tok61MYj1lPncNWg8YTmTokMBB2SXOwOPzh2SXZuY+c=;
  b=XKoxWk72FsxbJ1jHDPwgCphlSNC7DZ8yZKOj+aZm3GrMNuWfrVRw+ZGK
   6MsXi9Z5kNlRC1YfU5Bob140DdatfXw3pOVWkphUiNrsngtTFFBfnBQlD
   lm30Ku/l9+K69HEQ7XKyqj3xMso5E9Gfr16SzIJIsj0fVU1ZRB3HnjN63
   pgQyokJUCf6URizRg5eL8HXc2mPgds47/a4BoaMgIG7saogmWfo9fmRvq
   WDkUqhTvO3eDCRMcVLFZtqlLmveErdTzuCUknxWdm/NklTsFiDmwOu5fk
   mMS4VkLQTYVcJXqZZxbUfNvcCyfBlvw+T5bMWwsrPYhPxlZbyxDbgXNcC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276623897"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276623897"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 04:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="669452616"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2022 04:50:14 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 256BoDHf010626;
        Mon, 6 Jun 2022 12:50:13 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Henderson <rth@twiddle.net>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] bitops: let optimize out non-atomic bitops on compile-time constants
Date:   Mon,  6 Jun 2022 13:49:01 +0200
Message-Id: <20220606114908.962562-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

The savings on x86_64 with LLVM are insane (.text):

$ scripts/bloat-o-meter -c vmlinux.{base,test}
add/remove: 72/75 grow/shrink: 182/518 up/down: 53925/-137810 (-83885)

$ scripts/bloat-o-meter -c vmlinux.{base,mod}
add/remove: 7/1 grow/shrink: 1/19 up/down: 1135/-4082 (-2947)

$ scripts/bloat-o-meter -c vmlinux.{base,all}
add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)

And the following:

	DECLARE_BITMAP(flags, __IP_TUNNEL_FLAG_NUM) = { };
	__be16 flags;

	__set_bit(IP_TUNNEL_CSUM_BIT, flags);

	tun_flags = cpu_to_be16(*flags & U16_MAX);

	if (test_bit(IP_TUNNEL_VTI_BIT, flags))
		tun_flags |= VTI_ISVTI;

	BUILD_BUG_ON(!__builtin_constant_p(tun_flags));

doesn't blow up anymore.

The series has been in intel-next for a while with no reported issues.
Also available on my open GH[0].

[0] https://github.com/alobakin/linux/commits/bitops

Alexander Lobakin (6):
  ia64, processor: fix -Wincompatible-pointer-types in ia64_get_irr()
  bitops: always define asm-generic non-atomic bitops
  bitops: define gen_test_bit() the same way as the rest of functions
  bitops: unify non-atomic bitops prototypes across architectures
  bitops: wrap non-atomic bitops with a transparent macro
  bitops: let optimize out non-atomic bitops on compile-time constants

 arch/alpha/include/asm/bitops.h               |  28 ++--
 arch/hexagon/include/asm/bitops.h             |  23 ++--
 arch/ia64/include/asm/bitops.h                |  40 +++---
 arch/ia64/include/asm/processor.h             |   2 +-
 arch/m68k/include/asm/bitops.h                |  47 +++++--
 arch/sh/include/asm/bitops-op32.h             |  32 +++--
 arch/sparc/include/asm/bitops_32.h            |  18 +--
 arch/sparc/lib/atomic32.c                     |  12 +-
 .../asm-generic/bitops/generic-non-atomic.h   | 128 ++++++++++++++++++
 .../bitops/instrumented-non-atomic.h          |  35 +++--
 include/asm-generic/bitops/non-atomic.h       | 123 ++---------------
 include/linux/bitops.h                        |  45 ++++++
 tools/include/asm-generic/bitops/non-atomic.h |  34 +++--
 tools/include/linux/bitops.h                  |  16 +++
 14 files changed, 363 insertions(+), 220 deletions(-)
 create mode 100644 include/asm-generic/bitops/generic-non-atomic.h

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

