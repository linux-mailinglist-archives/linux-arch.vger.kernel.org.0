Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3924155997F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 14:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiFXMN6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jun 2022 08:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiFXMNb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2022 08:13:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE371D32E;
        Fri, 24 Jun 2022 05:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656072810; x=1687608810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s360D3xYaquXVMD9j2K4GnltsFnSLS9FIRReSmtxs5o=;
  b=Kf0praOAE0l9yykxpGOLprTq2zgP1iE3vv3n4jXvdiB4+iYnbK8o/Ejg
   rm4H3iJupXiNjMqP3mD1qDv998Sy/EjYdDUzwq09mik4IdK1PzVXHBLJ0
   2GsxeR0fywY7QsP9q8ENE9DJrvgTYqOKpSD3kxp6XtcVeElGPUkwoTXPX
   brYUe4WIL5DDjA3bPo37vDVqEr1fcgeZv1TtBQMEpcfOdzAiiDfLtI0rP
   3G68G+URSLMinjytcwxoAol9xCeQEIXA1/K9f8xtGzFy4Qij0+OqI//GR
   0CFEAdapvDt7VzA/rnRWfWSYhiKtxtKnUka7U8nqQjPUzD+k4UFfRWlS5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367307203"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367307203"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 05:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="915659660"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jun 2022 05:13:23 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25OCDEo4014999;
        Fri, 24 Jun 2022 13:13:21 +0100
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
Subject: [PATCH v5 4/9] bitops: define const_*() versions of the non-atomics
Date:   Fri, 24 Jun 2022 14:13:08 +0200
Message-Id: <20220624121313.2382500-5-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
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

Define const_*() variants of the non-atomic bitops to be used when
the input arguments are compile-time constants, so that the compiler
will be always able to resolve those to compile-time constants as
well. Those are mostly direct aliases for generic_*() with one
exception for const_test_bit(): the original one is declared
atomic-safe and thus doesn't discard the `volatile` qualifier, so
in order to let optimize code, define it separately disregarding
the qualifier.
Add them to the compile-time type checks as well just in case.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../asm-generic/bitops/generic-non-atomic.h   | 31 +++++++++++++++++++
 include/linux/bitops.h                        |  1 +
 2 files changed, 32 insertions(+)

diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
index b85b8a2ac239..3d5ebd24652b 100644
--- a/include/asm-generic/bitops/generic-non-atomic.h
+++ b/include/asm-generic/bitops/generic-non-atomic.h
@@ -127,4 +127,35 @@ generic_test_bit(unsigned long nr, const volatile unsigned long *addr)
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
 
+/*
+ * const_*() definitions provide good compile-time optimizations when
+ * the passed arguments can be resolved at compile time.
+ */
+#define const___set_bit			generic___set_bit
+#define const___clear_bit		generic___clear_bit
+#define const___change_bit		generic___change_bit
+#define const___test_and_set_bit	generic___test_and_set_bit
+#define const___test_and_clear_bit	generic___test_and_clear_bit
+#define const___test_and_change_bit	generic___test_and_change_bit
+
+/**
+ * const_test_bit - Determine whether a bit is set
+ * @nr: bit number to test
+ * @addr: Address to start counting from
+ *
+ * A version of generic_test_bit() which discards the `volatile` qualifier to
+ * allow a compiler to optimize code harder. Non-atomic and to be called only
+ * for testing compile-time constants, e.g. by the corresponding macros, not
+ * directly from "regular" code.
+ */
+static __always_inline bool
+const_test_bit(unsigned long nr, const volatile unsigned long *addr)
+{
+	const unsigned long *p = (const unsigned long *)addr + BIT_WORD(nr);
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long val = *p;
+
+	return !!(val & mask);
+}
+
 #endif /* __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 87087454a288..d393297287d5 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -37,6 +37,7 @@ extern unsigned long __sw_hweight64(__u64 w);
 /* Check that the bitops prototypes are sane */
 #define __check_bitop_pr(name)						\
 	static_assert(__same_type(arch_##name, generic_##name) &&	\
+		      __same_type(const_##name, generic_##name) &&	\
 		      __same_type(name, generic_##name))
 
 __check_bitop_pr(__set_bit);
-- 
2.36.1

