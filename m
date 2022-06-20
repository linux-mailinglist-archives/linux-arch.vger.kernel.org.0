Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF55D551F86
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbiFTO55 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 10:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiFTO5k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 10:57:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C928102C;
        Mon, 20 Jun 2022 07:19:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C859113E;
        Mon, 20 Jun 2022 07:19:55 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.70.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43E8E3F534;
        Mon, 20 Jun 2022 07:19:51 -0700 (PDT)
Date:   Mon, 20 Jun 2022 15:19:42 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH v3 0/7] bitops: let optimize out non-atomic bitops on
 compile-time constants
Message-ID: <YrCB/rz3RM6TCjij@FVFF77S0Q05N>
References: <20220617144031.2549432-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617144031.2549432-1-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 17, 2022 at 04:40:24PM +0200, Alexander Lobakin wrote:
> So, in order to let the compiler optimize out such cases, expand the
> test_bit() and __*_bit() definitions with a compile-time condition
> check, so that they will pick the generic C non-atomic bitop
> implementations when all of the arguments passed are compile-time
> constants, which means that the result will be a compile-time
> constant as well and the compiler will produce more efficient and
> simple code in 100% cases (no changes when there's at least one
> non-compile-time-constant argument).

> The savings are architecture, compiler and compiler flags dependent,
> for example, on x86_64 -O2:
> 
> GCC 12: add/remove: 78/29 grow/shrink: 332/525 up/down: 31325/-61560 (-30235)
> LLVM 13: add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)
> LLVM 14: add/remove: 10/3 grow/shrink: 93/138 up/down: 3705/-6992 (-3287)
> 
> and ARM64 (courtesy of Mark[0]):
> 
> GCC 11: add/remove: 92/29 grow/shrink: 933/2766 up/down: 39340/-82580 (-43240)
> LLVM 14: add/remove: 21/11 grow/shrink: 620/651 up/down: 12060/-15824 (-3764)

Hmm... with *this version* of the series, I'm not getting results nearly as
good as that when building defconfig atop v5.19-rc3:

  GCC 8.5.0:   add/remove: 83/49 grow/shrink: 973/1147 up/down: 32020/-47824 (-15804)
  GCC 9.3.0:   add/remove: 68/51 grow/shrink: 1167/592 up/down: 30720/-31352 (-632)
  GCC 10.3.0:  add/remove: 84/37 grow/shrink: 1711/1003 up/down: 45392/-41844 (3548)
  GCC 11.1.0:  add/remove: 88/31 grow/shrink: 1635/963 up/down: 51540/-46096 (5444)
  GCC 11.3.0:  add/remove: 89/32 grow/shrink: 1629/966 up/down: 51456/-46056 (5400)
  GCC 12.1.0:  add/remove: 84/31 grow/shrink: 1540/829 up/down: 48772/-43164 (5608)

  LLVM 12.0.1: add/remove: 118/58 grow/shrink: 437/381 up/down: 45312/-65668 (-20356)
  LLVM 13.0.1: add/remove: 35/19 grow/shrink: 416/243 up/down: 14408/-22200 (-7792)
  LLVM 14.0.0: add/remove: 42/16 grow/shrink: 415/234 up/down: 15296/-21008 (-5712)

... and that now seems to be regressing codegen with recent versions of GCC as
much as it improves it LLVM.

I'm not sure if we've improved some other code and removed the benefit between
v5.19-rc1 and v5.19-rc3, or whether something else it at play, but this doesn't
look as compelling as it did.

Overall that's mostly hidden in the Image size, due to 64K alignment and
padding requirements:

  Toolchain      Before      After       Difference

  GCC 8.5.0      36178432    36178432    0
  GCC 9.3.0      36112896    36112896    0
  GCC 10.3.0     36442624    36377088    -65536
  GCC 11.1.0     36311552    36377088    +65536
  GCC 11.3.0     36311552    36311552    0
  GCC 12.1.0     36377088    36377088    0

  LLVM 12.0.1    31418880    31418880    0
  LLVM 13.0.1    31418880    31418880    0
  LLVM 14.0.0    31218176    31218176    0

... so aside from the blip around GCC 10.3.0 and 11.1.0, there's not a massive
change overall (due to 64KiB alignment restrictions for portions of the kernel
Image).

Thanks,
Mark.
