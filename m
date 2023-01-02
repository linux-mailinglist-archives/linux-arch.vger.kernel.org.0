Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607DB65B517
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jan 2023 17:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjABQbp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Jan 2023 11:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjABQbg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jan 2023 11:31:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91331090;
        Mon,  2 Jan 2023 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672677096; x=1704213096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jxPL4ZWd87JdmRzXlFCwvVerbRVrIW34N3tcLFvjMNM=;
  b=Twyoi/cJ/KiLGryNvU+Sc1LKkSSHFzNCS65788nuBiYaN6cBLDnPjS5S
   ORZ7QCEwD+BHTD6QKelnAGOL6TA9t8dHphnxsWM/GahwhYnWyOUYfL3M7
   3hESljtix6G8+74XhN6rf7MHME+Z3ZI6o0GmZGXJ4ZnClzkAwAdZXsh84
   xE5hXijDmrZD90nSRQFq8etnXKtOQXrng/IJb04q96XKVIJ/gDTcrDUZq
   dcrPnG+F+M9PJVRmocgLFvxP+9XXZ0uCbWN5GyeJuk8zRA4Vy/gXLAEp9
   MRBs7LWUjuMQ/iO6B7wOD47vryBfqJOIZZbqfx1XnHD3zKl7o/pABTLpN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="301197631"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="301197631"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 08:31:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="686940992"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="686940992"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga001.jf.intel.com with ESMTP; 02 Jan 2023 08:31:09 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 302GV7DR021496;
        Mon, 2 Jan 2023 16:31:07 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
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
Subject: Re: [PATCH v5 2/9] bitops: always define asm-generic non-atomic bitops
Date:   Mon,  2 Jan 2023 17:30:59 +0100
Message-Id: <20230102163059.3556962-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <Y7MC5/wxgGZz/met@boxer>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com> <20220624121313.2382500-3-alexandr.lobakin@intel.com> <Y7MC5/wxgGZz/met@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 2 Jan 2023 17:14:31 +0100

> On Fri, Jun 24, 2022 at 02:13:06PM +0200, Alexander Lobakin wrote:
> > Move generic non-atomic bitops from the asm-generic header which
> > gets included only when there are no architecture-specific
> > alternatives, to a separate independent file to make them always
> > available.
> > Almost no actual code changes, only one comment added to
> > generic_test_bit() saying that it's an atomic operation itself
> > and thus `volatile` must always stay there with no cast-aways.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # comment
> > Suggested-by: Marco Elver <elver@google.com> # reference to kernel-doc
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Marco Elver <elver@google.com>
> > ---
> >  .../asm-generic/bitops/generic-non-atomic.h   | 130 ++++++++++++++++++
> >  include/asm-generic/bitops/non-atomic.h       | 110 ++-------------
> >  2 files changed, 138 insertions(+), 102 deletions(-)
> >  create mode 100644 include/asm-generic/bitops/generic-non-atomic.h
> > 
> 
> Hi,
> 
> this patch gives me a headache when trying to run sparse against a module.
> 
> Olek please help :D

It was fixed shortly after the build bots turned on on the original
series with [0]. Hovewer, no release tag's been made after the fix.
There's also a short discussion regarding packaging Sparse 0.6.4 for
Debian with that fix cherry-picked[1], not sure if it led anywhere.

> 
> $ sudo make C=2 -C . M=drivers/net/ethernet/intel/ice/
> make: Entering directory '/home/mfijalko/bpf-next'
>   CHECK   drivers/net/ethernet/intel/ice/ice_main.c
> drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
> ./arch/x86/include/asm/bitops.h:66:1: warning: unreplaced symbol 'return'

[...]

> drivers/net/ethernet/intel/ice/ice_main.c: note: in included file (through arch/x86/include/asm/bitops.h, include/linux/bitops.h, include/linux/kernel.h, drivers/net/ethernet/intel/ice/ice.h):
> ./include/asm-generic/bitops/instrumented-non-atomic.h:142:9: warning: unreplaced symbol 'return'
> ./include/asm-generic/bitops/instrumented-non-atomic.h:139:1: warning: unreplaced symbol 'return'
> 
> that's for a single file, there's no point in including same output for
> every other file being checked.
> 
> Thanks,
> Maciej

[0] https://git.kernel.org/pub/scm/devel/sparse/sparse.git/commit/?id=0e1aae55e49cad7ea43848af5b58ff0f57e7af99
[1] https://lore.kernel.org/all/Yr7kPM1wLZnOqxOA@smile.fi.intel.com

Thanks,
Olek
