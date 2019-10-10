Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D91DDD1E73
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 04:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfJJC3g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 22:29:36 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:47106 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfJJC3g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 22:29:36 -0400
X-Greylist: delayed 35730 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Oct 2019 22:29:34 EDT
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x9A2TQrh010258;
        Thu, 10 Oct 2019 11:29:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x9A2TQrh010258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570674567;
        bh=Q7utFN6RzuE8eM4XqhBr6De112exitRV2SZcLvRw+/Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lfR7F1noQwk6SX0ADbu5hKqkv67oZZhkBR8M6ERsWbkWf/LBefvJB7MvjzmMX3W0Q
         7L83VrJkxM1N+VrTTE4fgeC7YZcwg+yEC6YHciTFMF7TegJxQpPGoMoz8PmTaVxIyr
         +M8Zy5Fu94jMJYGO9Xv//G91R47IMsjmMAXaGmxZnLQq64JxF9yZfADZo5HMTn1OJp
         7V5g5Gy99M56A5Z0VFjxSkNCpDWYaB86VII91VcMNjRcvyhn9NikZboIxHeEYyL/q1
         XSK4qnIPuNqb61MSha+vSHUboZB28OxPNNruQmr1ebGCD2Zat3JKE5DWtAFja4OVoa
         WHnGEk3JR445Q==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id w7so1446634uag.4;
        Wed, 09 Oct 2019 19:29:27 -0700 (PDT)
X-Gm-Message-State: APjAAAX1QGhuxHrQAYuy+NsIKjkrzCraAou8bec8dD4x0BNrBUl69egu
        t1bH4nOZSdR/HWbV/lT8XKrusc9cdFYkTHWU5Jg=
X-Google-Smtp-Source: APXvYqxJHdHRSk8iJK5J8OgjOjbFblWwYJs3YgddSOljJ0wgWwB7NP2b6e2SsoVqJmZZ8fJTYDM1o8iI6Lmnx9UQtLs=
X-Received: by 2002:a9f:31c5:: with SMTP id w5mr3361388uad.40.1570674566294;
 Wed, 09 Oct 2019 19:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570633189.git.vilhelm.gray@gmail.com> <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570633189.git.vilhelm.gray@gmail.com>
 <CAK7LNATgW7bXUmqV=3QAaJ0Qu73Kox-TgDCQJb=s0=mwewSCUg@mail.gmail.com>
 <20191009170917.GG32742@smile.fi.intel.com> <CAMuHMdXyyrL4ibKvjMV6r8TuxpmK73=JxsWNEfcRk1NjwsnOjA@mail.gmail.com>
In-Reply-To: <CAMuHMdXyyrL4ibKvjMV6r8TuxpmK73=JxsWNEfcRk1NjwsnOjA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 10 Oct 2019 11:28:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVdqU_6+_iinWStb9ALqLw494pnZKr46fLW+WJ9nUo6A@mail.gmail.com>
Message-ID: <CAK7LNASVdqU_6+_iinWStb9ALqLw494pnZKr46fLW+WJ9nUo6A@mail.gmail.com>
Subject: Re: [PATCH v17 01/14] bitops: Introduce the for_each_set_clump8 macro
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Phil Reid <preid@electromag.com.au>,
        Lukas Wunner <lukas@wunner.de>, sean.nyekjaer@prevas.dk,
        morten.tiljeset@prevas.dk, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 3:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Andy,
>
> On Wed, Oct 9, 2019 at 7:09 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 10, 2019 at 01:28:08AM +0900, Masahiro Yamada wrote:
> > > On Thu, Oct 10, 2019 at 12:27 AM William Breathitt Gray
> > > <vilhelm.gray@gmail.com> wrote:
> > > >
> > > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > > within a bitmap memory region. For each iteration, "start" is set to the
> > > > bit offset of the found clump, while the respective clump value is
> > > > stored to the location pointed by "clump". Additionally, the
> > > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > > respectively get and set an 8-bit value in a bitmap memory region.
> >
> > > Why is the return type "unsigned long" where you know
> > > it return the 8-bit value ?
> >
> > Because bitmap API operates on unsigned long type. This is not only
> > consistency, but for sake of flexibility in case we would like to introduce
> > more calls like clump16 or so.
>
> TBH, that doesn't convince me: those functions explicitly take/return an
> 8-bit value, and have "8" in their name.  The 8-bit value is never
> really related to, retrieved from, or stored in a full "unsigned long"
> element of a bitmap, only to/from/in a part (byte) of it.
>
> Following your rationale, all of iowrite{8,16,32,64}*() should take an
> "unsigned long" value, too.
>

+1

Using u8/u16/u32/u64 looks more consistent with other bitmap helpers.

void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf, unsigned
int nbits);
void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap, unsigned int nbits);
static inline void bitmap_from_u64(unsigned long *dst, u64 mask);



If you want to see more examples from other parts,


int of_property_read_u8(const struct device_node *np,
                        const char *propname,
                        u8 *out_value)


int of_property_read_u16(const struct device_node *np,
                         const char *propname,
                         u16 *out_value)


-- 
Best Regards
Masahiro Yamada
