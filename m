Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E12C549B6A
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 20:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiFMSYb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jun 2022 14:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiFMSXH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 14:23:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34436ABF4B;
        Mon, 13 Jun 2022 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655130745; x=1686666745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ujiwlsqt2KBvF1qvv4tJ1iHQFhwag7L0iIc7Ytjnd0s=;
  b=lsUuFmEZ1hsnq4DkDDWYnAH+0vL3lI1K0PJ+FEMnm7NEjCvk/HkEeGJa
   X9UWYbHa0Rxm5JHw9PA47BoHbCyxLOU5ZWlC9ivwPSEAt7zJnTSH/LLEe
   ajIwmWbkbg2RA6DEyMFhal+zn7ehfpubB++WUWpvuCYtANGQgNDmDEZpw
   OCHHoQrv5w3a2CaLCjwYSLKrwrn6HrcCnElNyyeNxveKwgJDLStApYXHX
   rP9sxl9Cz3s0vxstU3NajnA3+eLtSYVkvkectRZRV9VRv5dIaFPbWX3Vy
   DeI6eVNqHQJsrbk+lQeEc0KgZvAwkOOa97MiHNqMJ8B504IGrkVOn2WcG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="275831886"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="275831886"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 07:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="673325163"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2022 07:32:09 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25DEW7CD026902;
        Mon, 13 Jun 2022 15:32:07 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
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
Subject: Re: [PATCH v2 4/6] bitops: define const_*() versions of the non-atomics
Date:   Mon, 13 Jun 2022 16:30:34 +0200
Message-Id: <20220613143034.1176680-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <YqNNjKRja7KelljA@smile.fi.intel.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com> <20220610113427.908751-5-alexandr.lobakin@intel.com> <YqNNjKRja7KelljA@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 10 Jun 2022 16:56:28 +0300

> On Fri, Jun 10, 2022 at 01:34:25PM +0200, Alexander Lobakin wrote:
> > Define const_*() variants of the non-atomic bitops to be used when
> > the input arguments are compile-time constants, so that the compiler
> > will be always to resolve those to compile-time constants as well.
> > Those are mostly direct aliases for generic_*() with one exception
> > for const_test_bit(): the original one is declared atomic-safe and
> > thus doesn't discard the `volatile` qualifier, so in order to let
> > optimize the code, define it separately disregarding the qualifier.
> > Add them to the compile-time type checks as well just in case.
> 
> ...
> 
> >  /* Check that the bitops prototypes are sane */
> >  #define __check_bitop_pr(name)						\
> > -	static_assert(__same_type(arch_##name, generic_##name) &&	\
> > +	static_assert(__same_type(const_##name, generic_##name) &&	\
> > +		      __same_type(arch_##name, generic_##name) &&	\
> >  		      __same_type(name, generic_##name))
> 
> Can't it be a one line change and actually keeping ordering at the same time?

Sure. Wanted to sort them "semantically", but it doesn't really make
any sense in here.

> 
> -- 
> With Best Regards,
> Andy Shevchenko

Thanks,
Olek
