Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E4B31F051
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 20:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhBRTqN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 14:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhBRTZF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Feb 2021 14:25:05 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D879C061574;
        Thu, 18 Feb 2021 11:24:22 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id s10so854878qvl.9;
        Thu, 18 Feb 2021 11:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mXM5l1A/rr2ByJpBGKJkreiRJB4kUscTTSOxZVH+5OE=;
        b=S/1Zj2rIHDp94Hy7Lrt4L/xh6dTEeTwa+m6A8XtFbEUiecdRcMxUk1NgfIGY2q39AK
         FzmYw7TJZUIqLjLFIZQpm1IhA43Glh72V3tlgVUnbXmG7chWrLq9i5YnB9GyhSoQdZKE
         FlQry+iTUyO0pUzY0s3qymVBa/mztuIOExwpxrc1WzGs0GIVA+gLoCmkTsDjixArpIlK
         V9wewO3y/NPHs66KUMNW8OtgcHb5o1ly+cOiawI8BHmX50kSY7Dx8qQyEf8YMiwaJfa5
         SCq9Ku2s2wNmZxoCeaYJMLt6jfju1GZKd2fzi6Y7eDR0DQD1hbMOoJJ3yVW2uULSmZhF
         Cu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mXM5l1A/rr2ByJpBGKJkreiRJB4kUscTTSOxZVH+5OE=;
        b=eAW3THML+phXszvRpmXxPK6G7lhlask2pEM/+CYDjQN/dFskfwOuS578PLZDxT71Su
         bTJgcVJEvZ9GxLWNcZ24Exbs8NpA1udz/VVFGaZnI4iMkjMh4+GzU6uCgHAI7WTryWjL
         xXACoOXL0TyF/ZWYIu6xJU8zv5yeWAtJeb5loGU8VBC7RwFZOEwX5yUjuFnRt6ayW7Cj
         IsawXjEIQe4kGf032JaG7+KCiOyDGSvkD2NFCmLlgqFWP/EsAFiRymqgiWyzLhmNr+Hu
         km1MfaW4AHM6dVWlxOa41WmJhlXhEgV9lpH+5i8zMojKzvDep8LSmNLJEPrc+N0kWV+7
         QoqQ==
X-Gm-Message-State: AOAM533o3kLrWXdP0lEeDhOzq1dEFjLwQKVoBjukoL8TYtrY7VSjQ9wl
        BV7GeERbcLEwsr59/w11MtQ=
X-Google-Smtp-Source: ABdhPJyMSh9g14GV26Z4i40nLxt6vVBDIr9z7jhPcJi5tm6xS2HnR/vD0o8ec2Yg+2YlHh+kg/WzCg==
X-Received: by 2002:a0c:90c9:: with SMTP id p67mr5761632qvp.14.1613676261132;
        Thu, 18 Feb 2021 11:24:21 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id f26sm4479242qkh.80.2021.02.18.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 11:24:20 -0800 (PST)
Date:   Thu, 18 Feb 2021 11:24:19 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 08/14] lib/Kconfig: introduce FAST_PATH option
Message-ID: <20210218192419.GA788573@yury-ThinkPad>
References: <20210218040512.709186-1-yury.norov@gmail.com>
 <20210218040512.709186-9-yury.norov@gmail.com>
 <YC6EnzFUXDuroy0+@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC6EnzFUXDuroy0+@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 18, 2021 at 05:15:43PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 17, 2021 at 08:05:06PM -0800, Yury Norov wrote:
> > This series introduces fast paths for find_bit() routines. It is
> > beneficial for typical systems, but those who limited in I-cache
> > may be concerned about increasing the .text size of the Image.
> > 
> > To address this concern, one can disable FAST_PATH option in the config
> > and some save memory.
> > 
> > The effect of this option on my arm64 next-20210217 build is:
> 
> (Maybe bloat-o-meter will give better view on this, i.e. more human-readable)

Never heard about this tool, thanks for the hint.

scripts/bloat-o-meter vmlinux vmlinux.new
add/remove: 16/13 grow/shrink: 111/439 up/down: 3616/-19352 (-15736)
Function                                     old     new   delta
find_next_bit.constprop                        -     220    +220
apply_wqattrs_cleanup                          -     176    +176
memcg_free_shrinker_maps                       -     172    +172
...
cpuset_hotplug_workfn                       2584    2288    -296
task_numa_fault                             3640    3320    -320
kmem_cache_free_bulk                        1684    1280    -404
Total: Before=26085140, After=26069404, chg -0.06%

The complete output is here:
https://pastebin.com/kBSdVJcK

So if I understand the output correctly, the size of .text is decreased...
Looks weird, but if it's true, we don't need the FAST_BIT config at all
because there's no tradeoff, and I should drop the patch.

Hmm...

> > +config FAST_PATH
> 
> I think the name is to broad for this cases, perhaps BITS_FAST_PATH? or BITMAP?

My logic was that since SMALL_CONST() is global, and FAST_PATH
controls the SMALL_CONST, it should also be global. I believe,
Linux should have a global switch to control the behaviour in
such cases, similarly to -Os compiler option. And I was surprized
when I found nothing like FAST_PATH in the config.

What about having FAST_PATH as a global option, and later if someone
will request for granularity, we'll introduce nested configs?

> > +	bool "Enable fast path code generation"
> > +	default y
> > +	help
> > +	  This option enables fast path optimization with the cost of increasing
> > +	  the text section.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
