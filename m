Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349A128242F
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgJCNDC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Oct 2020 09:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgJCNDA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Oct 2020 09:03:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7377C0613D0;
        Sat,  3 Oct 2020 06:02:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e10so2838637pfj.1;
        Sat, 03 Oct 2020 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5e/GWfMR/+SuunvSGOcvgPLoxHRm9LD0bTOHU6oHCk=;
        b=KhHrgLOt0wICgYy3TwMwJO14yTK7PmBdJAqdBPO3n82JRAIxJQmOMkB6A8Uv/S0l7m
         jyx1iCz1cody1muREz/WtEedjmHpS114Qcoehf8DseI0dj48AXb16P4ELeGSjorogo5F
         giQrRyXcCbYf0MnJoUusYQINRf7IJDD18UBBeNnUcXbn5bO/IuDCo4wKzjvtXSr+Y3Yt
         w99/tAb3bQhHPXLZe1HDYjq4DRqd3Ci49A+cJNg/WPCfsB0CVVaecUgLb7DNQWFGjruZ
         gvpS0k2AWNZs4XvhsgHzx0l23c93WRhlQ0vE64Ps6P4OpHDcVEOsXSFkeslmiwjdpV8B
         y3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5e/GWfMR/+SuunvSGOcvgPLoxHRm9LD0bTOHU6oHCk=;
        b=TXWyMfekuoPTyOMXSBRIyL2vLBy6xGVeoGVHC44wt4BgIHFUWCy2hvRCyML0xYwMkC
         doHQ8Kapm96VjrmCYTIBiJ3QfdejHs6hkK22WJNYM723EDSr22Ksmo1OnhecKd76p17T
         AtbamUmJTNvsSlpQQfsoJbxtdy3R4WB6y+k1H1HaMoJOLLP7vi/qAHOu13DTgF9kSKko
         wfHeBBbJftjpD5GPHzPn9b7AEv5ZSwFYJKBj+gXZLW5LB7Z1mc94cYqgNx55qQCn0mAX
         lidrU2g+8mZw384rMxl31h2Ebdnj0hUCBEJZutyf1jwX05FDJjs2RC13GD2IoutH8wCf
         A/Rw==
X-Gm-Message-State: AOAM531qerAHc8T3osfOm6NMVw74NM5JlCCLuxmmZ9qP39ThJSpyjdGb
        UcGJAoqjLRjIQrCYFdFpwXTtgc0BQYwnMffFpvQ=
X-Google-Smtp-Source: ABdhPJw5C9LzS3jeKR3LWVcEwQMOqBB9vfwMkohRYXrPXBnVRuaIje6Y25EdfXHLA7vaxc4BqzNyH9sDXF0mJ8Cit38=
X-Received: by 2002:a63:4c1d:: with SMTP id z29mr6614962pga.203.1601730178122;
 Sat, 03 Oct 2020 06:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601679791.git.syednwaris@gmail.com> <dcd0580812ebae079e6f5035b990b195ccc6b709.1601679791.git.syednwaris@gmail.com>
 <CAHp75VcoGAjrPa7rcORsaDXZLb-n+U3hG0k6O+weMVYweSPVxg@mail.gmail.com>
 <CACG_h5pianK4DRL5YeuSuN0gv6Jvcndc=_wLCL4QgmZyR=bOMw@mail.gmail.com>
 <CAHp75VdC+eH0ScksdAVp==HnDMTMY3vVUZM5NZy6mfVSR0YoLA@mail.gmail.com> <20201003125626.GA3732@shinobu>
In-Reply-To: <20201003125626.GA3732@shinobu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 3 Oct 2020 16:02:41 +0300
Message-ID: <CAHp75VdfGCnoyOEn9-c0O4cx7t8GRTH+Ux_gYiRvZeOnDyQryg@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] bitops: Introduce the for_each_set_clump macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 3, 2020 at 3:56 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Sat, Oct 03, 2020 at 03:45:04PM +0300, Andy Shevchenko wrote:
> > On Sat, Oct 3, 2020 at 2:37 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > On Sat, Oct 3, 2020 at 2:14 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Sat, Oct 3, 2020 at 2:51 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

...

> > > > > +               map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> > > > > +               map[index] |= value << offset;
> >
> > Side note: I would prefer + 0 here and there, but it's up to you.
> >
> > > > > +               map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> > > > > +               map[index + 1] |= (value >> space);
> >
> > By the way, what about this in the case of start=0, nbits > 64?
> > space == 64 -> UB.
> >
> > (And btw parentheses are redundant here)
>
> I think this is the same situation as before: we should document that
> nbits must be between 1 and BITS_PER_LONG.

At least documented, yes.

-- 
With Best Regards,
Andy Shevchenko
