Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007F431CFC8
	for <lists+linux-arch@lfdr.de>; Tue, 16 Feb 2021 19:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBPSBa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Feb 2021 13:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhBPSBZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Feb 2021 13:01:25 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A038C061786;
        Tue, 16 Feb 2021 10:00:44 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id x3so1927420qti.5;
        Tue, 16 Feb 2021 10:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MZv88LoGDyoqj+JUsBfVabeWm3XvrAKVtmhQ8+/+qO4=;
        b=noA0wnAT0o9cRCGQUDoWCay8HcKLJOp41CqraJbgr0dUVJgXnzgQUAbSsAcgKYFWrz
         ZX4/8YMQjlkIrdJpgK7JvG7txBlCksTyIhn5WVGDX8YoSuEYB9bscqYA+I1tlZKObnNT
         9gMnfORrhEIAw+8s/tjErap/Fe1hn98xqNTAjMhkziAaXL7kJAb+84hE4+WGPBMhVrIU
         j4DhjZH7IM+6wbQnSY9MM5SKq/XkmovP+72t7oEF85pbrMehGtV2+DkPBnCl6YUpMLv7
         WepA5REasHrXHRgJBWvi/WiOJxxbgPUhgbMLwoenvZ0Du9OfqIw1VKee4tVQKsoPzQGC
         lxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZv88LoGDyoqj+JUsBfVabeWm3XvrAKVtmhQ8+/+qO4=;
        b=nGSOPpQqlgQ6NEVwNQiChA/GECX0nF7+z4kc3htPleph3pkjIcb2IKexbFe7nLPT//
         90pSKPRThd4Y4e6G70SQ4TZtPwjGtibEeI0u/HPt1UVTaPM47C6Z0Jd20p2LqdJ9H1wJ
         uICLh91OUrTKyJ1z68WdynAONl2mUTi/OhLD4wnlAJSdKMxZOfmZdEm1+W/RHjlPnvoz
         P9lsneSdKAvWJyaLQK1y3G0T8WdTSHGIm8mf+QU2duEaI/LkBkkAgzrC3NvewhZecxVM
         qpMriPm1bZRW027ketoOsKv64zPznqJIatLbc1jG7/L6MOkgbweZk3/NmZLA2kURXiGE
         ifOw==
X-Gm-Message-State: AOAM530vQ5r5xHlxBLu189qh4/Pr4UqSDvWNeheaFWFdliF1T0L7UZVu
        XfR94SBjIFwoTFfVWv1cGJCRIX16rt0=
X-Google-Smtp-Source: ABdhPJwYR92x2g6usp+e+eae7hovcmvLl8Gibk+9FAtpv8JCfKDcc7oYg5seY7OMZNn+EkTx8nA98A==
X-Received: by 2002:a05:622a:8:: with SMTP id x8mr20156343qtw.359.1613498443928;
        Tue, 16 Feb 2021 10:00:43 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id c81sm14537171qkb.88.2021.02.16.10.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 10:00:43 -0800 (PST)
Date:   Tue, 16 Feb 2021 10:00:42 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Joe Perches <joe@perches.com>
Subject: Re: [RESEND PATCH v2 0/6] lib/find_bit: fast path for small bitmaps
Message-ID: <20210216180042.GA421019@yury-ThinkPad>
References: <20210130191719.7085-1-yury.norov@gmail.com>
 <20210215213044.GB394846@yury-ThinkPad>
 <YCuM7yzMoXjpuj8Y@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCuM7yzMoXjpuj8Y@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 16, 2021 at 11:14:23AM +0200, Andy Shevchenko wrote:
> On Mon, Feb 15, 2021 at 01:30:44PM -0800, Yury Norov wrote:
> > [add David Laight <David.Laight@ACULAB.COM> ]
> > 
> > On Sat, Jan 30, 2021 at 11:17:11AM -0800, Yury Norov wrote:
> > > Bitmap operations are much simpler and faster in case of small bitmaps
> > > which fit into a single word. In linux/bitmap.h we have a machinery that
> > > allows compiler to replace actual function call with a few instructions
> > > if bitmaps passed into the function are small and their size is known at
> > > compile time.
> > > 
> > > find_*_bit() API lacks this functionality; despite users will benefit from
> > > it a lot. One important example is cpumask subsystem when
> > > NR_CPUS <= BITS_PER_LONG. In the very best case, the compiler may replace
> > > a find_*_bit() call for such a bitmap with a single ffs or ffz instruction.
> > > 
> > > Tools is synchronized with new implementation where needed.
> > > 
> > > v1: https://www.spinics.net/lists/kernel/msg3804727.html
> > > v2: - employ GENMASK() for bitmaps;
> > >     - unify find_bit inliners in;
> > >     - address comments to v1;
> > 
> > Comments so far:
> >  - increased image size (patch #8) - addressed by introducing
> >    CONFIG_FAST_PATH;
> 
> >  - split tools and kernel parts - not clear why it's better.
> 
> Because tools are user space programs and sometimes may not follow kernel
> specifics, so they are different logically and changes should be separated.

In this specific case tools follow kernel well.

Nevertheless, if you think it's a blocker for the series, I can split. What
option for tools is better for you - doubling the number of patches or 
squashing everything in a patch bomb?
