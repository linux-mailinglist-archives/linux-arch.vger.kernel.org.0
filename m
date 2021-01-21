Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0612FF61A
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 21:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbhAUUjw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 15:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbhAUUji (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jan 2021 15:39:38 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E16AC06174A;
        Thu, 21 Jan 2021 12:38:58 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z22so6742646ioh.9;
        Thu, 21 Jan 2021 12:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7mqf+OnHHgmEasThOeWv/Cz0OSsuhGVfQUCMVskmlM=;
        b=k+6Mr4g1BWhGj8+NP3PAO4u1Ueou82T/GKsrvkujtMj+xcDstE3hn853F0Cpor9WMy
         hzYeM98UCgt5PMNklfFnublFNEHYTwmJAIoLshgGOIOTq3NL3pnkgHqm58d1J0gczFnE
         QqeSvJl2Lolsex4OuoAKizFwdtqnMQ7PGhYcFmD4p1o2pyZJRyunYCccAQLG6Z3pMxeK
         YN4iZ82xmyaCXui9sLbFc0rgUPJyEmrUj2ql7+C5NCPm8D6snxMsnCBziQn7f/jIuQXm
         8roNKxm5b8x1I5gTjBz/qVzjVRVmuFb1Us9nNZDZw8ibGymLpxgUdm5ZkXds2aCQGriM
         3r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7mqf+OnHHgmEasThOeWv/Cz0OSsuhGVfQUCMVskmlM=;
        b=al6gtgmqvjZPoThFG53pvAli2pJbKqZF197FvBrWllDB64rNOKQCdRpXEbFaLdLtSp
         NZmOS/fE+PIkIJ6nNATCTQZI2UzJztKP8/bFueEwbi7q9JuQx3dh3nSuYknAE25+yYa8
         9xbyO61UUM6vEp6J+JO3qp0woohNmsR8H7kY6+/PS/w5NyEJEk8GnBssmI3VgejYP8/X
         wm4V0eyazD2zgWH04kAvxr66/J/4AsUpOefVMkgM2SuKWOmNp7lNST6lS/+yXNDxmI70
         T8Wh8RHTPDhcYt1fdlCAOFPAl58TWDb195jFZqVRrIBjCa4zVOt0SIcltP6qVYB0p/D3
         DaBQ==
X-Gm-Message-State: AOAM532/Vzfxq0Boy4Ma5XbnsVW3lr2zoJjjhHkDbg+m3NykHqNzgviw
        A5ljg3RnW9A8yP43d6tc0E2r/AtHFgeBmxxYgZ8=
X-Google-Smtp-Source: ABdhPJyQhycjgpb/B7dvMelEUuvwJXyOeWQcu7j6qPKfCoCN5La7YNeuaKa1QsTyFXiJ4QW4C3tC0OcDSSMsL2QAGBc=
X-Received: by 2002:a05:6638:110a:: with SMTP id n10mr827873jal.29.1611261537592;
 Thu, 21 Jan 2021 12:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20210121000630.371883-1-yury.norov@gmail.com> <20210121000630.371883-3-yury.norov@gmail.com>
 <YAlVScX1d9KKvSZN@smile.fi.intel.com>
In-Reply-To: <YAlVScX1d9KKvSZN@smile.fi.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Thu, 21 Jan 2021 12:38:46 -0800
Message-ID: <CAAH8bW_YuHWD9KcMNzbzN2zg7CvRmqMKj0qkf7NSJmeT+NC+yQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] bitmap: move some macros from linux/bitmap.h to linux/bitops.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 21, 2021 at 2:18 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jan 20, 2021 at 04:06:26PM -0800, Yury Norov wrote:
> > In the following patches of the series they are used by
> > find_bit subsystem.
>
> s/subsystem/API/
>
> ...
>
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -7,6 +7,17 @@
> >
> >  #include <uapi/linux/kernel.h>
> >
> > +#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
> > +#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
>
> Hmm... Naming here is not in the bitops namespace.
> I would expect BITS rather than BITMAP for these two.
>
> So, we have at least the following options:
>  - split to a separate header, like bitmap_macros.h
>  - s/BITMAP/BITS/ and either define BITMAP_* as respective BITS_* or rename it
>    everywhere in bitmap.*
>  - your variant
>  - ...???...

We have GENMASK in linux/bits.h. I think we should use it here and
drop local ones.
It will also cover the case of  OFFSET macro that you suggested in
your comment to
patch #5.
