Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CD32CFD5F
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 19:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgLEScX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 13:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgLES3P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 13:29:15 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D60C0613D1;
        Sat,  5 Dec 2020 10:21:03 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z5so9228418iob.11;
        Sat, 05 Dec 2020 10:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZLvqFTb5/J4M6JQB9XxMDARCyWF1a0adeRBulBpK/K4=;
        b=eNyYwrXbW4u74Fe8Nl8OeoT1Za2ijOz1r7tODG3w0Kv4bbP6DsEI/EY98/Nw/tW2Ch
         4OPxR/busTL4VDAtly0hpnFgVd6eWdCzDOj126PBMM7GikeURwshOisM/dtFwvwpL8AU
         zErEwdoMrVqrAw70WlV5IFJWqxu2Lvv0hEPQN+EY+1RSWpDpdLv4m9pILSZsDfnaFk0i
         PRsuYdUimpLBCjmXJ9XXUQ0zvheXgkm6FCUzPCKKhTR5ow+KvsFEPEpEmLpgTDZTJ9vp
         /Ok8gSGKEGTTogh39QhXVJBOWiDCdat0lSEHptYbWtHWcjjhuo1g96WeLMQ0yQOGBOXz
         RWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLvqFTb5/J4M6JQB9XxMDARCyWF1a0adeRBulBpK/K4=;
        b=PPRicMeO5TLn0bNelHVRfyBYhYGOd3F0i4Szo75k2f5aPMlLYnUf1w+jKs9/obRSqu
         8jZ3hH3G3HeIPGkjgieQnftKlKhDVaKEu9M8F2gUL2muDB+biReRtHH2ZxBaGg4gCFB2
         +lxyQ/y2VD7yygc2hGfmSHCYfPlOkbtU7/SLSpvSu0wZv2h/oUb5XDNfN8qVKTvnyJPT
         BsaS/Ej7pM0OVlsIeYX+iFBZ1Rm9yJl7vqx06YIRXj2d4W7LqXa/bw7lKvdad8/mvZGY
         oZ+UDhqim4Y3fSGUIktv6OvaTPszcguLj92LjtVhkQLOvIxlrEXXfCzOpCQjnA1xG8C2
         JRRA==
X-Gm-Message-State: AOAM531VmAwchsyB56aRnZ8aAMSdLulYPXVPyMK9kPKMsQVAMqETlZ6r
        jxzLSbD3iR5xGOWwNxKdYYmLB5rJHmGyJfXUIyE=
X-Google-Smtp-Source: ABdhPJwa3IjxBS+tIstAWV3UyopVOQ4GyFlTv83vA+hsWm4Cat2zaqt8u19FoRVkA0QHndrOsIustXeEX0mEQ4V6Nlw=
X-Received: by 2002:a02:9f19:: with SMTP id z25mr9238088jal.30.1607192462871;
 Sat, 05 Dec 2020 10:21:02 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com> <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
 <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
 <CAM7-yPRBPP6SFzdmwWF5Y99g+aWcp=OY9Uvp-5h1MSDPmsORNw@mail.gmail.com>
 <CAAH8bW-+XnNsd9p3xZ1utmyY24gaBa0ko4tngBii4T+2cMkcYg@mail.gmail.com>
 <CAM7-yPQCWj6rOyLEgOqF3HGkFV1WKtqyVhEtDbS3HW=2A-HuBA@mail.gmail.com>
 <CAM7-yPTtiVnUztE=xpNYgRcZTGd1aX_V9ZHd=2YZYc1uQNBXtw@mail.gmail.com>
 <a0cc0d2e-9c55-8546-f070-26feed5de37f@rasmusvillemoes.dk> <CAM7-yPQrvYUwX-cbgpzhomCTFEi9sQ9iGuLNcL-Fsj7XZ0knhw@mail.gmail.com>
 <CAAH8bW9=J_now4SU=-WzvBOa=ftStgGVpspyw_g7oafbuNHNHQ@mail.gmail.com> <65bcccd3-db04-8056-e57c-0976a1eccfd5@rasmusvillemoes.dk>
In-Reply-To: <65bcccd3-db04-8056-e57c-0976a1eccfd5@rasmusvillemoes.dk>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Sat, 5 Dec 2020 10:20:51 -0800
Message-ID: <CAAH8bW8vToBZ80QHgjybakwUuvFyPfpcismaLEjz2hAOFG3HrA@mail.gmail.com>
Subject: Re:
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yun Levi <ppbuk5246@gmail.com>, dushistov@mail.ru,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Dec 5, 2020 at 3:10 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 03/12/2020 19.46, Yury Norov wrote:
>
> > I would prefer to avoid changing the find*bit() semantics. As for now,
> > if any of find_*_bit()
> > finds nothing, it returns the size of the bitmap it was passed.
>
> Yeah, we should actually try to fix that, it causes bad code generation.
> It's hard, because callers of course do that "if ret == size" check. But
> it's really silly that something like find_first_bit needs to do that
> "min(i*BPL + __ffs(word), size)" - the caller does a comparison anyway,
> that comparison might as well be "ret >= size" rather than "ret ==
> size", and then we could get rid of that branch (which min() necessarily
> becomes) at the end of find_next_bit.

We didn't do that 5 years ago because it's too invasive and the improvement
is barely measurable, the difference is 2 instructions (on arm64).e.
Has something
changed since that?

20000000000000000 <find_first_bit_better>:
   0:   aa0003e3        mov     x3, x0
   4:   aa0103e0        mov     x0, x1
   8:   b4000181        cbz     x1, 38 <find_first_bit_better+0x38>
   c:   f9400064        ldr     x4, [x3]
  10:   d2800802        mov     x2, #0x40                       // #64
  14:   91002063        add     x3, x3, #0x8
  18:   b40000c4        cbz     x4, 30 <find_first_bit_better+0x30>
  1c:   14000008        b       3c <find_first_bit_better+0x3c>
  20:   f8408464        ldr     x4, [x3], #8
  24:   91010045        add     x5, x2, #0x40
  28:   b50000c4        cbnz    x4, 40 <find_first_bit_better+0x40>
  2c:   aa0503e2        mov     x2, x5
  30:   eb00005f        cmp     x2, x0
  34:   54ffff63        b.cc    20 <find_first_bit_better+0x20>  //
b.lo, b.ul, b.last
  38:   d65f03c0        ret
  3c:   d2800002        mov     x2, #0x0                        // #0
  40:   dac00084        rbit    x4, x4
  44:   dac01084        clz     x4, x4
  48:   8b020080        add     x0, x4, x2
  4c:   d65f03c0        ret

0000000000000050 <find_first_bit_worse>:
  50:   aa0003e4        mov     x4, x0
  54:   aa0103e0        mov     x0, x1
  58:   b4000181        cbz     x1, 88 <find_first_bit_worse+0x38>
  5c:   f9400083        ldr     x3, [x4]
  60:   d2800802        mov     x2, #0x40                       // #64
  64:   91002084        add     x4, x4, #0x8
  68:   b40000c3        cbz     x3, 80 <find_first_bit_worse+0x30>
  6c:   14000008        b       8c <find_first_bit_worse+0x3c>
  70:   f8408483        ldr     x3, [x4], #8
  74:   91010045        add     x5, x2, #0x40
  78:   b50000c3        cbnz    x3, 90 <find_first_bit_worse+0x40>
  7c:   aa0503e2        mov     x2, x5
  80:   eb02001f        cmp     x0, x2
  84:   54ffff68        b.hi    70 <find_first_bit_worse+0x20>  // b.pmore
  88:   d65f03c0        ret
  8c:   d2800002        mov     x2, #0x0                        // #0
  90:   dac00063        rbit    x3, x3
  94:   dac01063        clz     x3, x3
  98:   8b020062        add     x2, x3, x2
  9c:   eb02001f        cmp     x0, x2
  a0:   9a829000        csel    x0, x0, x2, ls  // ls = plast
  a4:   d65f03c0        ret

> I haven't dug very deep into this, but I could also imagine the
> arch-specific parts of this might become a little easier to do if the
> semantics were just "if no such bit, return an indeterminate value >=
> the size".
>
> > Changing this for
> > a single function would break the consistency, and may cause problems
> > for those who
> > rely on existing behaviour.
>
> True. But I think it should be possible - I suppose most users are via
> the iterator macros, which could all be updated at once. Changing ret ==
> size to ret >= size will still work even if the implementations have not
> been switched over, so it should be doable.

Since there's no assembler users for it, we can do just:
#define find_first_bit(bitmap, size)
min(better_find_first_bit((bitmap), (size)), (size))

... and deprecate find_first_bit.

> > Passing non-positive size to find_*_bit() should produce undefined
> > behaviour, because we cannot dereference a pointer to the bitmap in
> > this case; this is most probably a sign of a problem on a caller side
> > anyways.
>
> No, the out-of-line bitmap functions should all handle the case of a
> zero-size bitmap sensibly.

I could be more specific, the behaviour is defined: don't dereference
the address and return undefined value (which now is always 0).

> Is bitmap full? Yes (all the 0 bits are set).
> Is bitmap empty? Yes, (none of the 0 bits are set).
> Find the first bit set (returns 0, there's no such bit)

I can't answer because this object is not a map of bits - there's no room for
bits inside.

> Etc. The static inlines for small_const_nbits do assume that the pointer
> can be dereferenced, which is why small_const_nbits was updated to mean
> 1<=bits<=BITS_PER_LONG rather than just bits<=BITS_PER_LONG.

I don't want to do something like

if (size == 0)
        return -1;

... because it legitimizes this kind of usage and hides problems on
callers' side.
Instead, I'd add WARN_ON(size == 0), but I don't think it's so
critical to bother with it.

Yury

> Rasmus
