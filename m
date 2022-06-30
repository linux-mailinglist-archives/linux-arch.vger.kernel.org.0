Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065AF5620A6
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jun 2022 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiF3Q5K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jun 2022 12:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiF3Q5J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jun 2022 12:57:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B188393DC;
        Thu, 30 Jun 2022 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656608229; x=1688144229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bL9nkQHpWXRcPQiclQNvTJObFea+2bIOo5Icywa3vMA=;
  b=fmrnj/6XuSpY1hnOWZabHa7oDtPIZ/7Bh+RzopLp14OHknBAX57nHps+
   hL5jBriVpX/QkW93R0zu0Im+Scz9SCMknY/iOCVSHSS2S8n+mKecZgyHQ
   Bj7eBMp9wg9++qnorxgkRFae5QI68Ufol1Zw3FVTWM9ltXapLCo//Tj26
   9Kxt8LZ2qLG3s4QZZ6QJUPHIBI+jiJrwD8thm/mMC7PGeyX+J3CV/8SMn
   PUlmia2grWt0+sj7f7hIdMOsNypeNBNyPtP/nF2FJrYVf6/8tUDwXrhTm
   a/SMH+lmmn9h8jAOslm763iFDv28yTpVnQqU9eUHwUpe3DyX9d9HKP6LI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="271175238"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="271175238"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 09:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="623800223"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2022 09:57:02 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25UGv0GF022621;
        Thu, 30 Jun 2022 17:57:00 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v5 0/9] bitops: let optimize out non-atomic bitops on compile-time constants
Date:   Thu, 30 Jun 2022 18:56:11 +0200
Message-Id: <20220630165611.1551808-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Fri, 24 Jun 2022 14:13:04 +0200

> While I was working on converting some structure fields from a fixed
> type to a bitmap, I started observing code size increase not only in
> places where the code works with the converted structure fields, but
> also where the converted vars were on the stack. That said, the
> following code:

Hey,

Seems like everything is fine this time. I got some reports, but
those aren't caused by any of the changes from the series.
Maybe we can take it to -next and see how it goes?

[...]

>  arch/alpha/include/asm/bitops.h               |  32 ++--
>  arch/hexagon/include/asm/bitops.h             |  24 ++-
>  arch/ia64/include/asm/bitops.h                |  42 ++---
>  arch/ia64/include/asm/processor.h             |   2 +-
>  arch/m68k/include/asm/bitops.h                |  49 ++++--
>  arch/s390/include/asm/bitops.h                |  61 +++----
>  arch/sh/include/asm/bitops-op32.h             |  34 ++--
>  arch/sparc/include/asm/bitops_32.h            |  18 +-
>  arch/sparc/lib/atomic32.c                     |  12 +-
>  arch/x86/include/asm/bitops.h                 |  22 +--
>  drivers/net/ethernet/intel/ice/ice_switch.c   |   2 +-
>  .../asm-generic/bitops/generic-non-atomic.h   | 161 ++++++++++++++++++
>  .../bitops/instrumented-non-atomic.h          |  35 ++--
>  include/asm-generic/bitops/non-atomic.h       | 121 +------------
>  .../bitops/non-instrumented-non-atomic.h      |  16 ++
>  include/linux/bitmap.h                        |  22 ++-
>  include/linux/bitops.h                        |  50 ++++++
>  lib/test_bitmap.c                             |  62 +++++++
>  tools/include/asm-generic/bitops/non-atomic.h |  34 ++--
>  tools/include/linux/bitops.h                  |  16 ++
>  20 files changed, 544 insertions(+), 271 deletions(-)
>  create mode 100644 include/asm-generic/bitops/generic-non-atomic.h
>  create mode 100644 include/asm-generic/bitops/non-instrumented-non-atomic.h
> 
> -- 
> 2.36.1

Thanks,
Olek
