Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982391E8FD8
	for <lists+linux-arch@lfdr.de>; Sat, 30 May 2020 10:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgE3Ipm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 May 2020 04:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgE3Ipl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 May 2020 04:45:41 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781E3C03E969;
        Sat, 30 May 2020 01:45:40 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k18so1926532ion.0;
        Sat, 30 May 2020 01:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FwSC2AMRfcDtu2KYVqxdYpNUHJ8zNAGOiDtCzdUYjdI=;
        b=bLEU2K4xEBOo3itAlkXlHBgwWe/HgI5nYwfv8zmn3jJh6XTBB9hL2W/d0/jC/vcqIO
         CaE3gbunqGJnPSOYkrhyLrSyHTusX3lvFHkGb7y1HvnBfsRHE5sKLFSXD1/QI1lmuIu+
         OOZM6NF3eKiMNEl2VycJDxechxDSzCwYeYuI14YO/tEttobvgGJUAFcOC/BS182J4gSm
         TAUX+q/CnYwHr3hV0xGef4P/JPvH/Ui++FJp+rwlqdC6c7llYPvH7caVYnpLIW+Wrh33
         FtQ8m8g+Pv3aUgHBtD8dlzkMnWWpakh1blIaG5FFbWvpNiIZ6TftwE/CVZRJWDpUa75i
         7NiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwSC2AMRfcDtu2KYVqxdYpNUHJ8zNAGOiDtCzdUYjdI=;
        b=aGlq++M2Gwg9BioBalsBN5oRPW7T2CKmn6ejQMYWu0GZjy490jT3WbG2n0Hnk6z0Sv
         JtiRR965nVvNhqg++gBACoUNnMJTqqfM+qonMPn3n9FpgzhPoEt9nYpUgjYDVPodebFa
         QqKbqGjnPKC7dcNeTR7h0wlNGYxqrtBmoUlnDYB/NwfveSJVEM+7w4JJEZ2yuMt8tWPA
         UxhyM0sNzG97I8WVKk3kRDqACPIm1/XGvuImZuZd5e/V9g93/La9P69jJrqIbLdIg+iX
         OsfcUtOxMXLg4HIc/KRq7ygTyGfjeTVwQv5vAM1Fj8ildS/6fP00VgqTY/y+ha9/eWlj
         W65A==
X-Gm-Message-State: AOAM532juO+nx2HzPT8ChXY46ndGUb0JSWEvFilzUESGt1j6cGriMqzx
        IFxiz3WNsDyTyglxi8AcoPiQhdIYC+LU/SnfvTc=
X-Google-Smtp-Source: ABdhPJyZPathfKmbTyTWR015mWTyhfWIaC1GWkZfU12DczvLxtj0mTtbvpgi8fd4y5st7rCFwbdQ4pJT87ZwiR+GNcY=
X-Received: by 2002:a05:6638:54:: with SMTP id a20mr9093075jap.3.1590828339714;
 Sat, 30 May 2020 01:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com> <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com> <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
 <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com> <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
In-Reply-To: <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sat, 30 May 2020 14:15:28 +0530
Message-ID: <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 30, 2020 at 3:49 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, May 30, 2020 at 1:11 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > On Sat, May 30, 2020 at 3:13 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, May 29, 2020 at 11:07 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > > On Sat, May 30, 2020 at 12:08 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, May 29, 2020 at 11:38:18PM +0530, Syed Nayyar Waris wrote:
> > > > > > On Sun, May 24, 2020 at 8:15 PM kbuild test robot <lkp@intel.com> wrote:
> > >
> > > ...
> > >
> > > > > > Taking the example statement (in my patch) where compilation warning
> > > > > > is getting reported:
> > > > > > return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> > > > > >
> > > > > > 'nbits' is of type 'unsigned long'.
> > > > > > In above, the sanity check is comparing '0' with unsigned value. And
> > > > > > unsigned value can't be less than '0' ever, hence the warning.
> > > > > > But this warning will occur whenever there will be '0' as one of the
> > > > > > 'argument' and an unsigned variable as another 'argument' for GENMASK.
> > >
> > > > > Proper fix is to fix GENMASK(), but allowed workaround is to use
> > > > >         (BIT(nbits) - 1)
> > > > > instead.
> > >
> > > > When I used BIT macro (earlier), I had faced a problem. I want to tell
> > > > you about that.
> > > >
> > > > Inside functions 'bitmap_set_value' and 'bitmap_get_value' when nbits (or
> > > > clump size) is BITS_PER_LONG, unexpected calculation happens.
> > > >
> > > > Explanation:
> > > > Actually when nbits (clump size) is 64 (BITS_PER_LONG is 64 on my computer),
> > > > (BIT(nbits) - 1)
> > > > gives a value of zero and when this zero is ANDed with any value, it
> > > > makes it full zero. This is unexpected and incorrect calculation happening.
> > > >
> > > > What actually happens is in the macro expansion of BIT(64), that is 1
> > > > << 64, the '1' overflows from leftmost bit position (most significant
> > > > bit) and re-enters at the rightmost bit position (least significant
> > > > bit), therefore 1 << 64 becomes '0x1', and when another '1' is
> > > > subtracted from this, the final result becomes 0.
> > > >
> > > > Since this macro is being used in both bitmap_get_value and
> > > > bitmap_set_value functions, it will give unexpected results when nbits or clump
> > > > size is BITS_PER_LONG (32 or 64 depending on arch).
> > >
> > > I see, something like
> > > https://elixir.bootlin.com/linux/latest/source/include/linux/dma-mapping.h#L139
> > > should be done.
> > > But yes, let's try to fix GENMASK().
> > >
> > > So, if we modify the following
> > >
> > >   #define GENMASK_INPUT_CHECK(h, l) \
> > >     (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > >     __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > >
> > > to be
> > >
> > >   #define GENMASK_INPUT_CHECK(h, l) \
> > >     (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > >     __builtin_constant_p((l) > (h)), (l) ? (l) > (h) : 0, 0)))
> > >
> > > would it work?
> >
> > Sorry Andy it is not working. Actually the warning will be thrown,
> > whenever there will be comparison between 'h' and 'l'. If one of them
> > is '0' and the other is unsigned variable.
> > In above, still there is comparison being done between 'h' and 'l', so
> > the warning is getting thrown.
>
> Ah, okay
>
> what about (l) && ((l) > (h)) ?

When I finally changed:
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
to:
__builtin_constant_p((l) && ((l) > (h))), (l) ? (l) > (h) : 0, 0)))

It is still throwing same compilation error at the same location where
comparison is being done between 'l' and 'h'.

Actually the short-circuit logic is not happening. For:
(l) && ((l) > (h))
Even if 'l' is zero, it still proceeds to compare 'l' and 'h' , that
is '((l) > (h))' is checked.
I think it is happening because '__builtin_constant_p' will check the
complete argument: (l) && ((l) > (h)),
'__builtin_constant_p' checks whether the argument is compile time
constant or not, so therefore, it will evaluate the WHOLE argument,
that is (including) the comparison operation.
https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html

I am still investigating more on this. Let me know if you have any suggestions.

>
> > > > William also knows about this issue:
> > > > "This is undefined behavior in the C standard (section 6.5.7 in the N1124)"
> > >
> > > I think it is about 6.5.7.3  here, 1U << 31 (or 63) is okay.
> >
> > Actually for:
> > (BIT(nbits) - 1)
> > When nbits will be BITS_PER_LONG it will be 1U << 32 (or 64). Isn't it ?
> > The expression,
> > BIT(64) - 1
> > can become unexpectedly zero (incorrectly).
>
> Yes, that's why I pointed out to the paragraph. It's about right
> operand to be "great than or equal to" the size of type of left
> operand.
>

Thank You. I understand now. :-)

Regards
Syed Nayyar Waris
