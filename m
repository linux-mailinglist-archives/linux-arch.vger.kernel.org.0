Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928A617159D
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 12:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgB0LGC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 06:06:02 -0500
Received: from foss.arm.com ([217.140.110.172]:48644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgB0LGC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 06:06:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C6ED1FB;
        Thu, 27 Feb 2020 03:06:02 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F11E3F73B;
        Thu, 27 Feb 2020 03:06:00 -0800 (PST)
Date:   Thu, 27 Feb 2020 11:05:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 09/19] arm64: mte: Add specific SIGSEGV codes
Message-ID: <20200227110558.GB3281767@arrakis.emea.arm.com>
References: <20200226180526.3272848-10-catalin.marinas@arm.com>
 <202002270627.YYGOStB9%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002270627.YYGOStB9%lkp@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 27, 2020 at 06:33:14AM +0800, kbuild test robot wrote:
> url:    https://github.com/0day-ci/linux/commits/Catalin-Marinas/arm64-Memory-Tagging-Extension-user-space-support/20200227-041230
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
> config: x86_64-defconfig (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/export.h:43:0,
>                     from include/linux/linkage.h:7,
>                     from arch/x86/include/asm/cache.h:5,
>                     from include/linux/cache.h:6,
>                     from include/linux/time.h:5,
>                     from include/linux/compat.h:10,
>                     from arch/x86/kernel/signal_compat.c:2:
>    In function 'signal_compat_build_tests',
>        inlined from 'sigaction_compat_abi' at arch/x86/kernel/signal_compat.c:166:2:
> >> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_30' declared with attribute error: BUILD_BUG_ON failed: NSIGSEGV != 7

I haven't realised that x86 has a build check for NSIGSEGV. I'll fold in
the diff below (there are no new fields added to siginfo, so no other
changes necessary):

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 9ccbf0576cd0..a7f3e12cfbdb 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
 	 */
 	BUILD_BUG_ON(NSIGILL  != 11);
 	BUILD_BUG_ON(NSIGFPE  != 15);
-	BUILD_BUG_ON(NSIGSEGV != 7);
+	BUILD_BUG_ON(NSIGSEGV != 9);
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 5);
 	BUILD_BUG_ON(NSIGCHLD != 6);

-- 
Catalin
