Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1240953FCFF
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jun 2022 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242484AbiFGLLY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jun 2022 07:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242887AbiFGLKS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jun 2022 07:10:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD09B2D1E1;
        Tue,  7 Jun 2022 04:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654600093; x=1686136093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LehJpdli2K1kf6xsEwsX5oR/25DuYLSpUF31DPXQGNU=;
  b=Hxe0iItbIGbxHeLqEenzuHtMgUYwsX+vSY59uBIU2y6sY/JpwJetD+rF
   lnOXsnA99+RuqBeQLIao9cJXcDDKF4CyLphIbQl+Jej7/zLBlsB2j48Pm
   lodzC+HOWaNSB4ZPb7ZWsRBUIe6hBndIq4CY+UFolzmyMWdSEZIWBMuwO
   ZmVe0u1Ypueglv72qyh4a8FEI6O6fhFMuD35ZA1EnEPIPW7Vxrq7nmQ1W
   FKLybDrCUmw3Od5F8WU+Z2FupIJEgMN7/yVfE6075VL6+u80rmvzVdGYj
   p+CtZGTYWn5LZnix4t8iiXgEnbzgZiOQb0lhphZkR+zAdwI7G/RSyvXpn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="276758945"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="276758945"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 04:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="584155731"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jun 2022 04:08:08 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 257B86Ft021369;
        Tue, 7 Jun 2022 12:08:06 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] bitops: wrap non-atomic bitops with a transparent macro
Date:   Tue,  7 Jun 2022 13:07:05 +0200
Message-Id: <20220607110705.72887-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607105718.72434-1-alexandr.lobakin@intel.com>
References: <20220606114908.962562-1-alexandr.lobakin@intel.com> <20220606114908.962562-6-alexandr.lobakin@intel.com> <Yp4q5KlIxmlznvuh@FVFF77S0Q05N.cambridge.arm.com> <20220607105718.72434-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue, 7 Jun 2022 12:57:18 +0200

> From: Mark Rutland <mark.rutland@arm.com>
> Date: Mon, 6 Jun 2022 17:27:16 +0100
> 
> > On Mon, Jun 06, 2022 at 01:49:06PM +0200, Alexander Lobakin wrote:
> > > In preparation for altering the non-atomic bitops with a macro, wrap
> > > them in a transparent definition. This requires prepending one more
> > > '_' to their names in order to be able to do that seamlessly.
> > > sparc32 already has the triple-underscored functions, so I had to
> > > rename them ('___' -> 'sp32_').
> > 
> > Could we use an 'arch_' prefix here, like we do for the atomics, or is that
> > already overloaded?
> 
> Yeah it is, for example, x86 has 'arch_' functions defined in its
> architecture headers[0] and at the same time uses generic
> instrumented '__' helpers[1], so on x86 both underscored and 'arch_'
> are defined and they are not the same.

Oh well, forgot to attach the links. Can be found at the bottom of
this mail.

> Same with those sparc32 triple-underscored, sparc32 at the same time
> uses generic non-instrumented, so it has underscored, 'arch_' and
> triple-underscored.
> 
> In general, bitops are overloaded with tons of prefixes already :)
> I'm not really glad that I introduced one more level, but not that
> we have many options here.
> 
> > 
> > Thanks,
> > Mark.
> > 
> > > 
> > > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > > ---
> 
> [...]
> 
> > > -- 
> > > 2.36.1
> 
> Thanks,
> Olek

[0] https://elixir.bootlin.com/linux/v5.19-rc1/source/arch/x86/include/asm/bitops.h#L136
[1] https://elixir.bootlin.com/linux/v5.19-rc1/source/include/asm-generic/bitops/instrumented-non-atomic.h#L93

Thanks,
Olek
