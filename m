Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210101E8A79
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 23:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgE2Vxk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 17:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2Vxj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 17:53:39 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB808C03E969;
        Fri, 29 May 2020 14:53:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id 18so3940470iln.9;
        Fri, 29 May 2020 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3oWtcgvnLy2OJwqhZ4HjTph7ubSImSz6YMLjpeez/1o=;
        b=oZq1+uVhMA7tlJTSPdth9oarjH1/FgwQgr6fCBPa9oihwcezWGfpKex/t58KfbG0GH
         AJ3H7lzziLC1eyFj3TAe6d1Ai0rerC/az+1+P9zcQwXKHhVJxkxGlbkD9m6N6w6XMOEn
         31KXVcl5EoyNR5Pr1BomlTxEzOldKE2ynPnWjj2YEvetW73kDosblxCUdN93aq8JkLxa
         HZoU94UHHYL2vFRJSLU/ZnIsNoSG/+267+gLWFKSySU0Qx5+LLcrN/slLA9UHjTugqp2
         rftOUdPQOf2vJ0KosAtnTPw9ItBJaZLV/ZqnLosLMoyIJBVX5RKTT5j6sxusJaiQN3DJ
         k26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oWtcgvnLy2OJwqhZ4HjTph7ubSImSz6YMLjpeez/1o=;
        b=Q5+7YAGDpLs0dwS225pZKR2l+M6TQDynJoejgqeJUQZ6NZSQr9DuwLzC2d9m8MgYI9
         KE0kZzQnaznzFb0qyylX5GvYcNHKR/v+EXiJTr0qJnP/8i6zLfrd8IjPr7hmGjGqdjlX
         W/Z52ZPnoCh1PieYYtVfaLNudFyJh2bfpLoh64Vt7gtpJs2iOgBgsxiWdHQCbG5wSLGr
         I61YlFZ6x2Dct9lZY44/gBrSgui+I9sxQmXqU3A6oREO3i7Oq6Jh2JLS6u6zot26siYW
         /967EHb8w2SlZsyQw6ohZAg3epXhyUFQV88NuKrBwPnYJfnNoCuxpnNH+kj6V5kXGenR
         HUHw==
X-Gm-Message-State: AOAM530RJoQNkuRkGyViGzsyUlNboSaU0zisTrRxlK+RDNQ+Kn13gSbk
        dftk3YTx5jeOyrkX8G9k7odGPBT5oja7uv5l5sxk34vv
X-Google-Smtp-Source: ABdhPJwmaAtIw0A1TYSYICCx/PsQELAZd/GGZ59TJr9xmSE0Q+Wrm0kXi7nrCUK3FXRfp/nZhZmo+okXpodQh+GWUtY=
X-Received: by 2002:a92:de4a:: with SMTP id e10mr8306547ilr.0.1590789219004;
 Fri, 29 May 2020 14:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com> <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com> <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <20200529213111.GA25882@shinobu>
In-Reply-To: <20200529213111.GA25882@shinobu>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sat, 30 May 2020 03:23:27 +0530
Message-ID: <CACG_h5oAAx7QbRGRUx=U__NO0g_K_bA2Y5emibsr-MwJDqBcAw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 30, 2020 at 3:01 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Sat, May 30, 2020 at 01:32:44AM +0530, Syed Nayyar Waris wrote:
> > On Sat, May 30, 2020 at 12:08 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Fri, May 29, 2020 at 11:38:18PM +0530, Syed Nayyar Waris wrote:
> > > > On Sun, May 24, 2020 at 8:15 PM kbuild test robot <lkp@intel.com> wrote:
> > >
> > > ...
> > >
> > > > >    579  static inline unsigned long bitmap_get_value(const unsigned long *map,
> > > > >    580                                                unsigned long start,
> > > > >    581                                                unsigned long nbits)
> > > > >    582  {
> > > > >    583          const size_t index = BIT_WORD(start);
> > > > >    584          const unsigned long offset = start % BITS_PER_LONG;
> > > > >    585          const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> > > > >    586          const unsigned long space = ceiling - start;
> > > > >    587          unsigned long value_low, value_high;
> > > > >    588
> > > > >    589          if (space >= nbits)
> > > > >  > 590                  return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> > > > >    591          else {
> > > > >    592                  value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> > > > >    593                  value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> > > > >    594                  return (value_low >> offset) | (value_high << space);
> > > > >    595          }
> > > > >    596  }
> > >
> > > > Regarding the above compilation warnings. All the warnings are because
> > > > of GENMASK usage in my patch.
> > > > The warnings are coming because of sanity checks present for 'GENMASK'
> > > > macro in include/linux/bits.h.
> > > >
> > > > Taking the example statement (in my patch) where compilation warning
> > > > is getting reported:
> > > > return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> > > >
> > > > 'nbits' is of type 'unsigned long'.
> > > > In above, the sanity check is comparing '0' with unsigned value. And
> > > > unsigned value can't be less than '0' ever, hence the warning.
> > > > But this warning will occur whenever there will be '0' as one of the
> > > > 'argument' and an unsigned variable as another 'argument' for GENMASK.
> > > >
> > > > This warning is getting cleared if I cast the 'nbits' to 'long'.
> > > >
> > > > Let me know if I should submit a next patch with the casts applied.
> > > > What do you guys think?
> > >
> > > Proper fix is to fix GENMASK(), but allowed workaround is to use
> > >         (BIT(nbits) - 1)
> > > instead.
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> >
> > Hi Andy. Thank You for your comment.
> >
> > When I used BIT macro (earlier), I had faced a problem. I want to tell
> > you about that.
> >
> > Inside functions 'bitmap_set_value' and 'bitmap_get_value' when nbits (or
> > clump size) is BITS_PER_LONG, unexpected calculation happens.
> >
> > Explanation:
> > Actually when nbits (clump size) is 64 (BITS_PER_LONG is 64 on my computer),
> > (BIT(nbits) - 1)
> > gives a value of zero and when this zero is ANDed with any value, it
> > makes it full zero. This is unexpected and incorrect calculation happening.
> >
> > What actually happens is in the macro expansion of BIT(64), that is 1
> > << 64, the '1' overflows from leftmost bit position (most significant
> > bit) and re-enters at the rightmost bit position (least significant
> > bit), therefore 1 << 64 becomes '0x1', and when another '1' is
> > subtracted from this, the final result becomes 0.
> >
> > Since this macro is being used in both bitmap_get_value and
> > bitmap_set_value functions, it will give unexpected results when nbits or clump
> > size is BITS_PER_LONG (32 or 64 depending on arch).
> >
> > William also knows about this issue:
> >
> > "This is undefined behavior in the C standard (section 6.5.7 in the N1124)"
> >
> > Andy, William,
> > Let me know what do you think ?
> >
> > Regards
> > Syed Nayyar Waris
>
> We can't use BIT here because nbits could be equal to BITS_PER_LONG in
> some cases. Casting to long should be fine because the nbits will never
> be greater than BITS_PER_LONG, so long should be safe to use.
>
> However, I agree with Andy that the proper solution is to fix GENMASK so
> that this warning does not come up. What's the actual line of code in
> the GENMASK macro that is throwing this warning? I'd like to understand
> better the logic of this sanity check.
>
> William Breathitt Gray

Here is the code snippet:

#define GENMASK_INPUT_CHECK(h, l) \
        (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
        __builtin_constant_p((l) > (h)), (l) > (h), 0)))

Above you can see the comparisons are being done in the last line.
And because of these comparisons, those compilation warnings are generated.

For full code related to GENMASK macro:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/tree/include/linux/bits.h

Yes I too agree, I can work on GENMASK.

Regards
Syed Nayyar Waris
