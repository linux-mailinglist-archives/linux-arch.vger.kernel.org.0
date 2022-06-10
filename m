Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4133F5467D9
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jun 2022 15:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349549AbiFJN5r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jun 2022 09:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349546AbiFJN5c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jun 2022 09:57:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D6100B24;
        Fri, 10 Jun 2022 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654869398; x=1686405398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rgp4lTJLX0ot2IhjAJHLXWfwVn1Hf1envZh9HGJ8MuU=;
  b=LL9TDN8rw3ofnJ0/yz8QuWpf4lPwstD6t+nWUuEoX0+cGassHsh0A1qw
   5x5FBh65NaEm9+peLkqTbvr4HE56LRqfrqeND5JtKXJ2VQl8kuKZYi48y
   49LbDsI+VvVbqmKxWXzpk7Di6fnQqxUml/piRmWOqbnNejQfjdHGeqNle
   h1MNEK7YwpuXhkVKh1ixtlHt+10YSeU4yVRD3T7a6zqdMIv8mWya9RYWg
   HWBRMS3emvcMWhASbaxIqgsJ8Lyp9V5zVyQ9Rz3t3kX/TkhQcY+ZUuV4E
   7mWdg1B5c3qpFuWeAJNKNkUp/w3PcKsKNrszHVM30xXg91/6FBmvRUR2r
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="258072404"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="258072404"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 06:56:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="556386807"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 06:56:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nzf7k-000Ypb-8i;
        Fri, 10 Jun 2022 16:56:28 +0300
Date:   Fri, 10 Jun 2022 16:56:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] bitops: define const_*() versions of the
 non-atomics
Message-ID: <YqNNjKRja7KelljA@smile.fi.intel.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <20220610113427.908751-5-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610113427.908751-5-alexandr.lobakin@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 10, 2022 at 01:34:25PM +0200, Alexander Lobakin wrote:
> Define const_*() variants of the non-atomic bitops to be used when
> the input arguments are compile-time constants, so that the compiler
> will be always to resolve those to compile-time constants as well.
> Those are mostly direct aliases for generic_*() with one exception
> for const_test_bit(): the original one is declared atomic-safe and
> thus doesn't discard the `volatile` qualifier, so in order to let
> optimize the code, define it separately disregarding the qualifier.
> Add them to the compile-time type checks as well just in case.

...

>  /* Check that the bitops prototypes are sane */
>  #define __check_bitop_pr(name)						\
> -	static_assert(__same_type(arch_##name, generic_##name) &&	\
> +	static_assert(__same_type(const_##name, generic_##name) &&	\
> +		      __same_type(arch_##name, generic_##name) &&	\
>  		      __same_type(name, generic_##name))

Can't it be a one line change and actually keeping ordering at the same time?

-- 
With Best Regards,
Andy Shevchenko


