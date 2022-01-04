Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9044845E2
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 17:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiADQTf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 11:19:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:64173 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbiADQTf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jan 2022 11:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641313175; x=1672849175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9cYKoIOc9MOqqEbpXJd7uYlTuY1MUgX4CIdWto2c7jc=;
  b=Ty2QYcmPtSliliWbzMq3NA3ajMtEStlrwfAEXtEhepyWVb7/aT0B2VeM
   FjUG2DhrvnpyvpIEKjwsTTl6ggmo0lM3CckkxsGiOwF5Lp11UUEGDdQel
   5nE9Zoe891D5hPfl5NSapODGuHaRSmuNbf8TdxeASEFLNA1DnEc+YSqdb
   kxdo3JUzr+EmDf2M5wtRMPE4MVarAjSAHfiTeu7vBkEEfgegSsKbneT0e
   e1309wkh+hPtCi0wpQ8/Vd9nzTHV4UlcR9DzlGHcrSQ+4poO06cu1Q17N
   pqLeYhQC/o2WyYj9tQgMz8HUL3T3MhJwIsF8e2yJc4AIXLefc2Puc9yK9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242208596"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="242208596"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 08:19:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="488242337"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 08:19:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1n4mVp-006H9Y-45;
        Tue, 04 Jan 2022 18:18:13 +0200
Date:   Tue, 4 Jan 2022 18:18:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdRzRLqihstavvyd@smile.fi.intel.com>
References: <YdIfz+LMewetSaEB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdIfz+LMewetSaEB@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 02, 2022 at 10:57:35PM +0100, Ingo Molnar wrote:
> 
> I'm pleased to announce the first public version of my new "Fast Kernel 
> Headers" project that I've been working on since late 2020, which is a 
> comprehensive rework of the Linux kernel's header hierarchy & header 
> dependencies, with the dual goals of:
> 
>  - speeding up the kernel build (both absolute and incremental build times)
> 
>  - decoupling subsystem type & API definitions from each other
> 
> The fast-headers tree consists of over 25 sub-trees internally, spanning 
> over 2,200 commits, which can be found here:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
> 
> As most kernel developers know, there's around ~10,000 main .h headers in 
> the Linux kernel, in the include/ and arch/*/include/ hierarchies. Over the 
> last 30+ years they have grown into a complicated & painful set of 
> cross-dependencies we are affectionately calling 'Dependency Hell'.

$ git grep -n -w kernel.h mingo/sched/headers -- include/ | wc -l
138
$ git grep -n -w kernel.h next/master -- include/ | wc -l
96

Can we rather split kernel.h more? In some cases kernel.h is used just as a
bundle instead of ~2-3 headers.


And I can't get why kernel.h is returned in the drm headers. AFAICT there are no
dependencies:

mingo/sched/headers:include/drm/drm_gem_ttm_helper.h:6:#include <linux/kernel.h>
mingo/sched/headers:include/drm/drm_gem_vram_helper.h:15:#include <linux/kernel.h> /* for container_of() */
mingo/sched/headers:include/drm/drm_mm.h:44:#include <linux/kernel.h>
mingo/sched/headers:include/drm/drm_property.h:28:#include <linux/kernel.h>
mingo/sched/headers:include/drm/intel-gtt.h:9:#include <linux/kernel.h>

Ah, it may be due to base on the vanilla rather than on next, it would be
nice to see this rebased on top of v5.17-rc1 when it's out.


-- 
With Best Regards,
Andy Shevchenko


