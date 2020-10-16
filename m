Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C50290446
	for <lists+linux-arch@lfdr.de>; Fri, 16 Oct 2020 13:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406869AbgJPLqE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Oct 2020 07:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406868AbgJPLqE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Oct 2020 07:46:04 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AC5C061755;
        Fri, 16 Oct 2020 04:46:02 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p9so2270121ilr.1;
        Fri, 16 Oct 2020 04:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4tob09KVNT/yT+aT+mT1Cog8S7hbLpEBmGFyWWZcwA=;
        b=B+hUCeB4/Sm0mE8SalFPQ67jhnQnKhPQj+VqoVVsoJltjWF4Qik6QVid3M8L17VGwC
         MZne/s1rxQtMtCRk128P5/uMWtbUYlW3uD5/38CUm1H/SGEvvtvZ+eAcKbjaQ8X2Z9QY
         VkE5qNhGPsQ1nA6QV9kCr9KL/NT6lOaMZqStHucHQGGWAs199yy/n0lkK7ej4IOmMMNk
         1iqON4WaAgN3kLmuv2CUpEJA+Xnkrc8t3Jz2jJoBlkHcD1ETA7qJaXcSCASFA9YC+d3h
         PMgCXDQleJ7t6fqnst6kcsLOaYg7sDHe11v8d6ByRI3O19q8Us12PFj6WV5uskcKqcd9
         w4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4tob09KVNT/yT+aT+mT1Cog8S7hbLpEBmGFyWWZcwA=;
        b=cQX6uOfG33FF/rZcTeLrRBewoTkpcOaikPs2zMNzn1uOSxuFyR161PcJgRprGRMpI6
         ijZJKj5I1KY864slpUWOCp4c/Wh9H/M3/5PlTgud2SSQwf46iPuPYbUl4eUfsDu2qFc1
         c4UDnt1UkVGVFmdglNEAVifrAnqC32qvHDMKz5JbvVhJ3diZsBWwn4byP1Mx/BPH5n2+
         quDoFaGM6yiMn8ev/gvtvFdKomSEe6fwvd/FXX6340GFB+OmaXTrj2hwGUJcOX0RPrut
         sU6uhKCWfc4IreDuPOVXrZtfoRCiI3KOPYuy58zP2U4Veo1+FHnq9lIEy1+9TH+EUK0i
         k9/Q==
X-Gm-Message-State: AOAM533exZTcfGRWjllwsTIi/lwmEemLX3p3mo3CsZrhJXkMxx1lP8gt
        kemPLtHiSLpLwZrTPXMB9tBx3qTw2Xv5gNk1+F8=
X-Google-Smtp-Source: ABdhPJz4YYVb5NM3Dgaqza0MP8X4+RjrS5C/GhQchr0yFEkZ68mpW2SCJa1fWQBnyPVXVT/7DE72Yn8sB8SZN8KWfTM=
X-Received: by 2002:a92:bb58:: with SMTP id w85mr2401049ili.40.1602848761525;
 Fri, 16 Oct 2020 04:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601974764.git.syednwaris@gmail.com> <33de236870f7d3cf56a55d747e4574cdd2b9686a.1601974764.git.syednwaris@gmail.com>
 <20201006112745.GG4077@smile.fi.intel.com> <CACG_h5pYL+HbJpPcCTp=dR8rDbm07RsRDaX8Uc0HYc2LG--w_Q@mail.gmail.com>
 <20201016091704.GE4077@smile.fi.intel.com>
In-Reply-To: <20201016091704.GE4077@smile.fi.intel.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Fri, 16 Oct 2020 17:15:48 +0530
Message-ID: <CACG_h5raZ5T3X2xHbB5NnPaRS0aqmFDigtjtdmFkmh94qCdNDg@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] bitops: Introduce the for_each_set_clump macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 16, 2020 at 2:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 16, 2020 at 04:23:05AM +0530, Syed Nayyar Waris wrote:
> > On Tue, Oct 6, 2020 at 4:56 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Oct 06, 2020 at 02:52:16PM +0530, Syed Nayyar Waris wrote:
>
> ...
>
> > > > +             return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> > >
> > > Have you considered to use rather BIT{_ULL}(nbits) - 1?
> > > It maybe better for code generation.
> >
> > Yes I have considered using BIT{_ULL} in earlier versions of patchset.
> > It has a problem:
> >
> > This macro when used in both bitmap_get_value and
> > bitmap_set_value functions, it will give unexpected results when nbits or clump
> > size is BITS_PER_LONG (32 or 64 depending on arch).
> >
> > Actually when nbits (clump size) is 64 (BITS_PER_LONG is 64, for example),
> > (BIT(nbits) - 1)
> > gives a value of zero and when this zero is ANDed with any value, it
> > makes it full zero. This is unexpected, and incorrect calculation occurs.
> >
> > What actually happens is in the macro expansion of BIT(64), that is 1
> > << 64, the '1' overflows from leftmost bit position (most significant
> > bit) and re-enters at the rightmost bit position (least significant
> > bit), therefore 1 << 64 becomes '0x1', and when another '1' is
> > subtracted from this, the final result becomes 0.
> >
> > This is undefined behavior in the C standard (section 6.5.7 in the N1124)
>
> I see, indeed, for 64/32 it is like this.
>
> ...
>
> > Yes I have incorporated your suggestion to use the '<<' operator. Thank You.
>
> One side note, consider the use round_up() vs. roundup(). I don't remember
> which one is optimized to divisor being power of 2.

Yes. changed 'roundup' to 'round_up'. 'round_up' is optimized for
power-of-2. Thank you.

Syed Nayyar Waris
