Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8482633E890
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 05:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhCQEs0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 00:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCQEsB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 00:48:01 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB3DC06175F;
        Tue, 16 Mar 2021 21:48:01 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id n79so37713928qke.3;
        Tue, 16 Mar 2021 21:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AvKUgJkyyQ65jXujXRSi4LBYBTUmkT7KkIKMeZrVAdo=;
        b=KE41bJLJ+162X8e94I0UFNQwCXc+qss+/i9doFeW3HqoqfEkCx5tzGx2JY4vz9vMR1
         SiEo5JgPk0r8J5Wgx8eZSxw/Yh42zgWo5vExKf/QUXc9GHoRlIYwszaMBcPqmEBrBd7h
         NSnMaq0iwheHoOoAooSn04VnlbUJQimysg/pH+woEcW8tu5kWkhqLZWngVozARysddan
         FjYXaFd3zBs9einx3QGeXH/aJAf5vt04wAGT5Z7CoQFcdQFy7sHywoHW35E8QRxhrLFt
         atIV5yC9K/1yAruECKW3sXqeDUbuBpHlYftG7mcPkBjGl9PqdnMgiZ9cIUkM+waf7HKW
         6/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AvKUgJkyyQ65jXujXRSi4LBYBTUmkT7KkIKMeZrVAdo=;
        b=Xa9Up5yNY7V4ckOupAnwagp7BYQ7P9dskYchIEKvkvC9fUgx6LXvffecFUy67hdRt5
         CFZ6gCsLXZJ5D9PBawKFUA6jNbkG0MFodELJqLp9+0KAc1KkCfvjWzNsGXaz3hZAor6t
         OFkgb5Pwhv9d9ibmDhY9DX6CieAMx5bo7O+iwEmZWRDOXpnWDc0M/JE9h4yWDWPFrkEf
         Uul6mctQ6/OgYCREhIUo3QU6t2GuOa0QDJoWQh20Mr9IvgEq9MGr39+fp6bwzDvezYjK
         1xI59hNQkg39ZIxIV/rfNYYYEEj4sMWeXRL0/G5MluZfFxcLFV8s/3JDnWFTNyvdgQp2
         Iv2w==
X-Gm-Message-State: AOAM5301h3bfLcZjp6NwgwqTxelNSWMK8NeDnIJLg+p7KD6SStw286tS
        ufIjUD2VYv+/3FS0wRykpik=
X-Google-Smtp-Source: ABdhPJxZ8lYjXxA3pAiLAVDoONL/005dYCt+qsk2muXPO7guFffCDiHagN6VTwwETZa+yLt1kobxpg==
X-Received: by 2002:a37:e315:: with SMTP id y21mr2760659qki.418.1615956480256;
        Tue, 16 Mar 2021 21:48:00 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id e14sm16348614qka.56.2021.03.16.21.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 21:47:59 -0700 (PDT)
Date:   Tue, 16 Mar 2021 21:47:59 -0700
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 13/13] MAINTAINERS: Add entry for the bitmap API
Message-ID: <20210317044759.GA2114775@yury-ThinkPad>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-14-yury.norov@gmail.com>
 <YFCabyt9pfPtoQiZ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFCabyt9pfPtoQiZ@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[CC Andy Whitcroft, Joe Perches, Dwaipayan Ray, Lukas Bulwahn]

On Tue, Mar 16, 2021 at 01:45:51PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 15, 2021 at 06:54:24PM -0700, Yury Norov wrote:
> > Add myself as maintainer for bitmap API and Andy and Rasmus as reviewers.
> > 
> > I'm an author of current implementation of lib/find_bit and an active
> > contributor to lib/bitmap. It was spotted that there's no maintainer for
> > bitmap API. I'm willing to maintain it.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> >  MAINTAINERS | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3dd20015696e..44f94cdd5a20 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3151,6 +3151,22 @@ F:	Documentation/filesystems/bfs.rst
> >  F:	fs/bfs/
> >  F:	include/uapi/linux/bfs_fs.h
> >  
> > +BITMAP API
> > +M:	Yury Norov <yury.norov@gmail.com>
> > +R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > +R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > +S:	Maintained
> > +F:	include/asm-generic/bitops/find.h
> > +F:	include/linux/bitmap.h
> > +F:	lib/bitmap.c
> > +F:	lib/find_bit.c
> 
> > +F:	lib/find_find_bit_benchmark.c
> 
> Does this file exist?
> I guess checkpatch.pl nowadays has a MAINTAINER data base validation.

No lib/find_find_bit_benchmark.c doesn't exist. It's a typo, it should
be lib/find_bit_benchmark.c. Checkpatch doesn't warn:

yury:linux$ scripts/checkpatch.pl 0013-MAINTAINERS-Add-entry-for-the-bitmap-API.patch
total: 0 errors, 0 warnings, 22 lines checked

> > +F:	lib/test_bitmap.c
> > +F:	tools/include/asm-generic/bitops/find.h
> > +F:	tools/include/linux/bitmap.h
> > +F:	tools/lib/bitmap.c
> > +F:	tools/lib/find_bit.c
> > +
> >  BLINKM RGB LED DRIVER
> >  M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
> >  S:	Maintained
> > -- 
> > 2.25.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
