Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B9930900C
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 23:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhA2W0w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 17:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhA2W0v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 17:26:51 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543BCC061573;
        Fri, 29 Jan 2021 14:26:11 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id d81so10984044iof.3;
        Fri, 29 Jan 2021 14:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hoREvCWvBJhszWnTWxhBJMWPAqucDBF6nB5BDpkHUw0=;
        b=PIFrlF4KJnO5gnjnMTf+6tcWWFUUzJDvEix0/K3rnsowx/gLtBhDcAj+AdVuyLrslv
         jvGJVBm25QCt5dkH7qVsV8lNNnLTJJke5psYyELACqmyS+R0ywhMp9JiBApUcp6V0aGx
         i7uP+MPCtx/4u8dfGV4i0vs4FaByF/KNIRJNPLphu9gA82ARNkxGiGDc4CzOM6OG+Cuq
         sNRnR6f9ZvRy2pLB/UCwSRUgDL97p0dVuPIpPSmygngIjhTaCVaxM2ibHkVH+G9Y731c
         GT2SXTKy/8e1jXM9hn9bloxAsb7kP5nI/3Ssnf8EDEkmG6g6Pwg7RFfGJVSlRvBceamg
         lWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoREvCWvBJhszWnTWxhBJMWPAqucDBF6nB5BDpkHUw0=;
        b=CQYJid3xOm0g1U3tFcP2jY8FSH8bAca18DXq27RZbESpc0Vlt6WvuEURSYbAhD4OZT
         yBdAGCR4G3G2Nt45Rjgd093Bqa1gECYXDoQ8y14g8WGo1CuGMSXDN8JA1DEYlw+HnRB6
         sb4VEfHErTzhemJy2EPPyIxQ39icG9PPCas4wNednrCWbC/fdSuwkaJs3YN+Q0OKh9oJ
         rDKf88awoFfGioyATi8/GBGUzyJyi5ctKxcMQFmhurPZpW++KL3m4uaJGrnITU2wh9c5
         dpeAY9sYlaNOcNA2fiw+YDFvSeWovnyPccCWa/mslKFARIVxID/od/wr3AhEjoTKB5PI
         Al0w==
X-Gm-Message-State: AOAM531OAkZ5m3SEZTvuiZ3iOmzeo8XN+MJ354jFY4gKra36jmh1Jsmn
        o48SCJ2ZXfkO18j49qJORj0/Ge3EdUqLpUrYm5s=
X-Google-Smtp-Source: ABdhPJxqqRwK8JdT3GzdfxL9UlffqvYdRrEY1TO8ZEn68c1kU0+hz/UGOOIWZtWQ3ziRx80FGZlUDabpmvvs1WtZvG8=
X-Received: by 2002:a6b:7501:: with SMTP id l1mr5068073ioh.92.1611959170750;
 Fri, 29 Jan 2021 14:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20210129204528.2118168-1-yury.norov@gmail.com>
 <20210129204528.2118168-4-yury.norov@gmail.com> <CAHp75VcSc=myrcvyBOkaUDguR6aPjJAFFXi2iSvmU21+1664Hw@mail.gmail.com>
In-Reply-To: <CAHp75VcSc=myrcvyBOkaUDguR6aPjJAFFXi2iSvmU21+1664Hw@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Fri, 29 Jan 2021 14:25:56 -0800
Message-ID: <CAAH8bW8MKh7LjsJ-9jaCRoTGFKSK_0+Gh5RuzVu-sMCO76=Oxg@mail.gmail.com>
Subject: Re: [PATCH 2/5] bits_per_long.h: introduce SMALL_CONST() macro
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 1:11 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jan 29, 2021 at 10:49 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Many algorithms become simplier if they are passed with relatively small
>
> simpler
>
> > input values. One example is bitmap operations when the whole bitmap fits
> > into one word. To implement such simplifications, linux/bitmap.h declares
> > small_const_nbits() macro.
> >
> > Other subsystems may also benefit from optimizations of this sort, like
> > find_bit API in the following patches. So it looks helpful to generalize
> > the macro and extend it's visibility.
>
> > It should probably go to linux/kernel.h, but doing that creates circular
> > dependencies. So put it in asm-generic/bitsperlong.h.

[]

> > diff --git a/tools/include/asm-generic/bitsperlong.h b/tools/include/asm-generic/bitsperlong.h
> > index 8f2283052333..432d272baf27 100644
> > --- a/tools/include/asm-generic/bitsperlong.h
> > +++ b/tools/include/asm-generic/bitsperlong.h
>
> I think a tools update would be better to have in a separate patch.

Do you mean a single sync-patch for all tools/*, or doubling the
patchset by splitting each patch
to tools and kernel parts? Why is it any better than I have now?
