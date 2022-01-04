Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2EF4845CA
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 17:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiADQHn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 11:07:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:44504 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233501AbiADQHn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jan 2022 11:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641312463; x=1672848463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=54/n2VZV0aW1Y4beFknzec/M2TrweRJqO5yjjHBYyi4=;
  b=VH5dvJ5TxV+KlU55+XV+P1wYQ1eJSiYuaKxMygMHf2gVdkL9Wj/3V2/8
   A/GRLTPm1n4vpqyW58A4EDpADhpPwZzt4Johy5suYSJKVsVxbZkjsq9GU
   7MrA8syh5G78jIezWt9bcLwL8dS8jfPIWc4nRZ5GXWF18JwRo2dXeme/D
   +RWENYXsPqUswJuKSbWCn5QClSQy/DFPpLBzY20AI0cumhtfwyqLP2RL8
   Yh6zI/uw+IW1ign0LR9X/yJnhyR6zzg5T2W7efpeQO+rnRLJACet/s7pY
   2judEdiImBvgFa4F/cFyGPX6r9sA/ZNvUICkPtXPa9ADEb1n2wOfv8VnK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="303000805"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="303000805"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 08:07:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="556206106"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 08:07:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1n4mJi-006Gvl-Fh;
        Tue, 04 Jan 2022 18:05:42 +0200
Date:   Tue, 4 Jan 2022 18:05:42 +0200
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
Message-ID: <YdRwVgv+GyUw5iKW@smile.fi.intel.com>
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

In the 64e013748e61 ("headers/deps: Optimize <linux/kernel.h>")
the linux/container_of.h and linux/stdarg.h are moved around (in the
linux/kernel.h) without any explanation in the commit message. Is it
necessary? If so, can you add a background note.

-- 
With Best Regards,
Andy Shevchenko


