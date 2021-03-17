Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EBE33F928
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 20:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhCQTaD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 15:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhCQTaB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 15:30:01 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A5AC06175F;
        Wed, 17 Mar 2021 12:30:00 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 30so1948388qva.9;
        Wed, 17 Mar 2021 12:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RI9Yge4VCvfLN/+w+NDMbTqUaUdyNl42E2BlDToEhF4=;
        b=rjA9EYKkzULtcYtNckNpuEN+hT13LkqbBV4DSfp/tFIIy2T10YnrKip48+6Liod0iu
         RTXyG3s6zqNh+ZjbrPvzmgQEOWWz6vEqqgkq9zCCSaUbfp+YDCT4j1/wHWez7nyapo0p
         uLiOU7D6v+XNlyXRb+o7sm+016LwZgsA77AB3otFaEvZuPPAJCTowcR+z9qyGBTnbIS0
         bdgCpT/oqV/jIUbyNYVNJAelCr0nS28ojdPeznmXkMKzVWtu3bCN9tnMcJKGfLGmqduX
         9yzOMBvMUVES0djVHtryodewWh7zLHOBHgocZ3zFuXSpF4TR4Cos2kRUM2Zgfat5j6VC
         SeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RI9Yge4VCvfLN/+w+NDMbTqUaUdyNl42E2BlDToEhF4=;
        b=tjnrS0Ji1boployygr7afoe7jkD6b0RXMH5C2bpam6dXSmtxRu/GnUzNtNqgyjrKqy
         NPYbhq7tYHDG8GN1WefPL8H1RuC5sb+ZibXBK5yUSl3Ob4PHLsdvxCvqpFbQW/7gOdtT
         QefIOPoekl+iaiiC34GTbkt/2TxV2ZtSpuTR0hJHXf+SWjALsCZUTrKKNRcsILxQpmiS
         rFSjUR/oh4t5Q8MSVJHY33UY2m270zX8RzsM9mzqL1LZwHbGmbaeAZ+rX1vfjB+7a/ra
         AKo/G/LmWapf8LNuF6oKvX78BKTQm9uSpnSyH/d0txJri9UYAIt2LEgZinR2Bcm1BKOH
         jUog==
X-Gm-Message-State: AOAM5312iNpJlW2n404jUAJ39Jym9i5uTQVzija8/2KalI5kYZQ99kY/
        RlFLHjDoj1N5ww+2klgBl9s=
X-Google-Smtp-Source: ABdhPJyzlT768NJl7SxXB+bC5RpnzqTi1q66iaAstHbq/NLE4Jb2Bao2QLGgRkGOat34uKo0uCdUUw==
X-Received: by 2002:a05:6214:aae:: with SMTP id ew14mr779116qvb.24.1616009399965;
        Wed, 17 Mar 2021 12:29:59 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id a19sm18503446qkl.126.2021.03.17.12.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:29:59 -0700 (PDT)
Date:   Wed, 17 Mar 2021 12:29:58 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
        linux-sh@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH 13/13] MAINTAINERS: Add entry for the bitmap API
Message-ID: <20210317192958.GA2139254@yury-ThinkPad>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-14-yury.norov@gmail.com>
 <YFCabyt9pfPtoQiZ@smile.fi.intel.com>
 <20210317044759.GA2114775@yury-ThinkPad>
 <eff989d0ceaede15216f1046c24829f1113c035f.camel@perches.com>
 <CAKXUXMx9SFAxT_GoRw+Un7XyAuXh4LY0+RFwcKVOCG0vr2XUxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMx9SFAxT_GoRw+Un7XyAuXh4LY0+RFwcKVOCG0vr2XUxw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 17, 2021 at 07:40:04AM +0100, Lukas Bulwahn wrote:
> On Wed, Mar 17, 2021 at 5:57 AM Joe Perches <joe@perches.com> wrote:
> >
> > On Tue, 2021-03-16 at 21:47 -0700, Yury Norov wrote:
> > > [CC Andy Whitcroft, Joe Perches, Dwaipayan Ray, Lukas Bulwahn]
> > >
> > > On Tue, Mar 16, 2021 at 01:45:51PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Mar 15, 2021 at 06:54:24PM -0700, Yury Norov wrote:
> > > > > Add myself as maintainer for bitmap API and Andy and Rasmus as reviewers.
> > > > >
> > > > > I'm an author of current implementation of lib/find_bit and an active
> > > > > contributor to lib/bitmap. It was spotted that there's no maintainer for
> > > > > bitmap API. I'm willing to maintain it.
> > > > >
> > > > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > > > ---
> > > > >  MAINTAINERS | 16 ++++++++++++++++
> > > > >  1 file changed, 16 insertions(+)
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 3dd20015696e..44f94cdd5a20 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -3151,6 +3151,22 @@ F: Documentation/filesystems/bfs.rst
> > > > >  F:       fs/bfs/
> > > > >  F:       include/uapi/linux/bfs_fs.h
> > > > >
> > > > >
> > > > > +BITMAP API
> > > > > +M:       Yury Norov <yury.norov@gmail.com>
> > > > > +R:       Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > +R:       Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > > > +S:       Maintained
> > > > > +F:       include/asm-generic/bitops/find.h
> > > > > +F:       include/linux/bitmap.h
> > > > > +F:       lib/bitmap.c
> > > > > +F:       lib/find_bit.c
> > > >
> > > > > +F:       lib/find_find_bit_benchmark.c
> > > >
> > > > Does this file exist?
> > > > I guess checkpatch.pl nowadays has a MAINTAINER data base validation.
> > >
> > > No lib/find_find_bit_benchmark.c doesn't exist. It's a typo, it should
> > > be lib/find_bit_benchmark.c. Checkpatch doesn't warn:
> > >
> > > yury:linux$ scripts/checkpatch.pl 0013-MAINTAINERS-Add-entry-for-the-bitmap-API.patch
> > > total: 0 errors, 0 warnings, 22 lines checked
> >
> > checkpatch does not validate filenames for each patch.
> >
> > checkpatch does have a --self-test=patterns capability that does
> > validate file accessibility.
> 
> Joe meant: get_maintainers does have a --self-test=patterns capability
> that does validate file accessibility.
> 
> You can run that before patch submission; otherwise, I run that script
> on linux-next once a week and send out correction patches as far as my
> "spare" time allows to do so.

Thanks for the hint. I see it's able to detect the issue.
