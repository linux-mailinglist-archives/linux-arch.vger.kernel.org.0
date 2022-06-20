Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5A055209F
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbiFTPX4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245388AbiFTPXh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 11:23:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EE92DFD;
        Mon, 20 Jun 2022 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655738424; x=1687274424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cw5NQyynR7ghE5FtblfyyewHSqrS21SURI3e+e9d2nU=;
  b=U7x2ZlFbbCvxPQtxw2xwS9g7nOoNFhzOEr4XHlyYCmkzssIM424pCIFm
   fYALvqkjLYEnmbCeCAriXNLqidesZaZIpHyi3wVN5Foi9mablDSTLWedM
   z8snqyp1arXVYUkq+WBZq7igCl+zIr2fmgJJeA0dLzn6D5bwsb7OIIlKf
   134fGgIpYI7uGb2VaOROGvaqbzB7mkwJUyI2bQ7wr/v/GpK4zUKTsb1oK
   RuWQ4dqpigsMLNp0q4Z4hP95ttPg14vSLOCQPqopXPXjlSRCyGxlN5TQb
   CSLuoS+9YLRwVdR25SFez+Dy80QZ3xFh4kFVoOvbAhAqhSEpyMNZmYnN3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="262955342"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="262955342"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 08:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="643166185"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2022 08:20:17 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25KFKF3L026144;
        Mon, 20 Jun 2022 16:20:15 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
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
Subject: Re: [PATCH v3 0/7] bitops: let optimize out non-atomic bitops on compile-time constants
Date:   Mon, 20 Jun 2022 17:08:55 +0200
Message-Id: <20220620150855.2630784-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <YrCB/rz3RM6TCjij@FVFF77S0Q05N>
References: <20220617144031.2549432-1-alexandr.lobakin@intel.com> <YrCB/rz3RM6TCjij@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 20 Jun 2022 15:19:42 +0100

> On Fri, Jun 17, 2022 at 04:40:24PM +0200, Alexander Lobakin wrote:
> > So, in order to let the compiler optimize out such cases, expand the
> > test_bit() and __*_bit() definitions with a compile-time condition
> > check, so that they will pick the generic C non-atomic bitop
> > implementations when all of the arguments passed are compile-time
> > constants, which means that the result will be a compile-time
> > constant as well and the compiler will produce more efficient and
> > simple code in 100% cases (no changes when there's at least one
> > non-compile-time-constant argument).
> 
> > The savings are architecture, compiler and compiler flags dependent,
> > for example, on x86_64 -O2:
> > 
> > GCC 12: add/remove: 78/29 grow/shrink: 332/525 up/down: 31325/-61560 (-30235)
> > LLVM 13: add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)
> > LLVM 14: add/remove: 10/3 grow/shrink: 93/138 up/down: 3705/-6992 (-3287)
> > 
> > and ARM64 (courtesy of Mark[0]):
> > 
> > GCC 11: add/remove: 92/29 grow/shrink: 933/2766 up/down: 39340/-82580 (-43240)
> > LLVM 14: add/remove: 21/11 grow/shrink: 620/651 up/down: 12060/-15824 (-3764)
> 
> Hmm... with *this version* of the series, I'm not getting results nearly as
> good as that when building defconfig atop v5.19-rc3:
> 
>   GCC 8.5.0:   add/remove: 83/49 grow/shrink: 973/1147 up/down: 32020/-47824 (-15804)
>   GCC 9.3.0:   add/remove: 68/51 grow/shrink: 1167/592 up/down: 30720/-31352 (-632)
>   GCC 10.3.0:  add/remove: 84/37 grow/shrink: 1711/1003 up/down: 45392/-41844 (3548)
>   GCC 11.1.0:  add/remove: 88/31 grow/shrink: 1635/963 up/down: 51540/-46096 (5444)
>   GCC 11.3.0:  add/remove: 89/32 grow/shrink: 1629/966 up/down: 51456/-46056 (5400)
>   GCC 12.1.0:  add/remove: 84/31 grow/shrink: 1540/829 up/down: 48772/-43164 (5608)
> 
>   LLVM 12.0.1: add/remove: 118/58 grow/shrink: 437/381 up/down: 45312/-65668 (-20356)
>   LLVM 13.0.1: add/remove: 35/19 grow/shrink: 416/243 up/down: 14408/-22200 (-7792)
>   LLVM 14.0.0: add/remove: 42/16 grow/shrink: 415/234 up/down: 15296/-21008 (-5712)
> 
> ... and that now seems to be regressing codegen with recent versions of GCC as
> much as it improves it LLVM.
> 
> I'm not sure if we've improved some other code and removed the benefit between
> v5.19-rc1 and v5.19-rc3, or whether something else it at play, but this doesn't
> look as compelling as it did.

Mostly likely it's due to that in v1 I mistakingly removed
`volatile` from gen[eric]_test_bit(), so there was an impact for
non-constant cases as well.
+5 Kb sounds bad tho. Do you have CONFIG_TEST_BITMAP enabled, does
it work? Probably the same reason as for m68k, more constant
optimization -> more aggressive inlining or inlining rebalance ->
larger code. OTOH I've no idea why sometimes compiler decides to
uninline really tiny functions where due to this patch series some
bitops have been converted to constants, like it goes on m68k.

> 
> Overall that's mostly hidden in the Image size, due to 64K alignment and
> padding requirements:
> 
>   Toolchain      Before      After       Difference
> 
>   GCC 8.5.0      36178432    36178432    0
>   GCC 9.3.0      36112896    36112896    0
>   GCC 10.3.0     36442624    36377088    -65536
>   GCC 11.1.0     36311552    36377088    +65536
>   GCC 11.3.0     36311552    36311552    0
>   GCC 12.1.0     36377088    36377088    0
> 
>   LLVM 12.0.1    31418880    31418880    0
>   LLVM 13.0.1    31418880    31418880    0
>   LLVM 14.0.0    31218176    31218176    0
> 
> ... so aside from the blip around GCC 10.3.0 and 11.1.0, there's not a massive
> change overall (due to 64KiB alignment restrictions for portions of the kernel
> Image).
> 
> Thanks,
> Mark.

Thanks,
Olek
