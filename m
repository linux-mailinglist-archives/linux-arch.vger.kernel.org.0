Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB931EE07
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 19:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhBRSIp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 13:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhBRPfe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Feb 2021 10:35:34 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7388EC061574;
        Thu, 18 Feb 2021 07:34:26 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id b24so1612158qtp.13;
        Thu, 18 Feb 2021 07:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qdUGE0ei1PeIqXVirzz2L2hmAvJjnRfr69rW6TULXQM=;
        b=evSDWFVK1uXHuQBlCdLbHM2UlZh8PIg2tlI0ar+EYH15gZMFZ/WvisEj1M+4ssKAgO
         QoCwbWFk2xYFvYtfwpqfXDCGv2MlvCk9bMvErepQTW49NcvBp75VJZF1EyfbTNrGBqoD
         QHuzKtGevEeo4/Hnhh5i5tuCGoYUurqoSTuLbno9W9NOv0PeioJl1VP/qDu/LdS0Q4yU
         jLe8eJzHn7fYI+QiqMRLDhN/HgkHfooH0L4tsZhuj95u7yc2p4h+sbLTnx8FYUyYXSZt
         u3lfQJfDh3gtt8HuzuQfKS9yqBlzgOjf/ReUWtOH+RLXB8zni0ZvDLz1EY0nrCLEV7ED
         1nGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qdUGE0ei1PeIqXVirzz2L2hmAvJjnRfr69rW6TULXQM=;
        b=CzHRK1U1CA8Up+mLZ73MeMSFREuDKlg4GSAggMghnNsL1dAqJTRRVW2MTeHsSYfKs6
         GgtvRJc9PnaFJr53KRvWnqnZ6IajceXke0Wf+ZTgh4F4CAmxTUiepGEcfnky8lkYwiGn
         M2OVbUCAo11SOxRhBOhriLiGj15YJq8iXzfBxBr1pEOG0MHvQJm5dFNlsV2cB1567ksA
         4ikabRlrzASOFliKY3Y2OnpaSoq0WrIQHnKGpDk2OTbIglf2R9j17AB6Ul8IoWyBrlea
         DBqHKt5K4RyhjBACWgY6CWxUt3JSCwkAmeRSNBCKQvBQNsocK4OZs6E7w17a/MwLmdn3
         uHZA==
X-Gm-Message-State: AOAM530y7cO6k1LJfOH4/eVh1Yta+LPTd+5rJJsmi+s3yYuHS4TQnm7h
        SYMzyrPeEJS3D/JTkG0fw/4=
X-Google-Smtp-Source: ABdhPJzKLm03m2ZM2weJmDc19njdUFo0p+tamBbKYBwgzzZL1EUg/dGEX0ItuZg3We5eXCMPQXGIrg==
X-Received: by 2002:ac8:59cd:: with SMTP id f13mr4786833qtf.258.1613662465537;
        Thu, 18 Feb 2021 07:34:25 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id m5sm4072260qke.134.2021.02.18.07.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 07:34:25 -0800 (PST)
Date:   Thu, 18 Feb 2021 07:34:24 -0800
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
Subject: Re: [PATCH 14/14] MAINTAINERS: Add entry for the bitmap API
Message-ID: <20210218153424.GA701246@yury-ThinkPad>
References: <20210218040512.709186-1-yury.norov@gmail.com>
 <20210218040512.709186-15-yury.norov@gmail.com>
 <YC6HoF2lhSlrYs3j@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC6HoF2lhSlrYs3j@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 18, 2021 at 05:28:32PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 17, 2021 at 08:05:12PM -0800, Yury Norov wrote:
> > Add myself as maintainer for bitmap API.
> > 
> > I'm an author of current implementation of lib/find_bit and an
> > active contributor to lib/bitmap. It was spotted that there's no
> > maintainer for bitmap API. I'm willing to maintain it.
> 
> Perhaps reviewers as well, like Rasmus, if he is okay with that, of course?

I'll be happy if you and Rasmus join the team. :) Guys, just let me
know and I'll update the patch.
 
> Otherwise, why not?
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  MAINTAINERS | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7bdf12d3e0a8..9f8540a9dabf 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3146,6 +3146,20 @@ F:	Documentation/filesystems/bfs.rst
> >  F:	fs/bfs/
> >  F:	include/uapi/linux/bfs_fs.h
> >  
> > +BITMAP API
> > +M:	Yury Norov <yury.norov@gmail.com>
> > +S:	Maintained
> > +F:	include/asm-generic/bitops/find.h
> > +F:	include/linux/bitmap.h
> > +F:	lib/bitmap.c
> > +F:	lib/find_bit.c
> > +F:	lib/find_find_bit_benchmark.c
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
