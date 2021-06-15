Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06163A7447
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 04:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFOCsi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 22:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhFOCsh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Jun 2021 22:48:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35A78613B6;
        Tue, 15 Jun 2021 01:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623719228;
        bh=rG3719QpCm03Pct6ZPmHY7NKA0ZnZcb/msTIuT6DEZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eZANhhaATJcoaqqX0CoZzMiB5xCfNlYG9Su3V18leTk1kBzL+YIkFqHlxg/UX47Ec
         nThGgd50wdgXkXS9MLOBIdYfmlZgT7VWzuhOZMWPDnMtb2Ywfxy1uVvuUJINMWiF2+
         gdzUpU6w6uD2uzM6UDARM48ODr7UcAhW6S9+huTM=
Date:   Mon, 14 Jun 2021 18:07:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.osdn.me>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Hildenbrand <david@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Lobakin <alobakin@pm.me>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 7/8] all: replace find_next{,_zero}_bit with
 find_first{,_zero}_bit where appropriate
Message-Id: <20210614180706.1e8564854bfed648dd4c039b@linux-foundation.org>
In-Reply-To: <CAHp75VeXJcPai=w3Fbx11TPf_CZTusD6U_E2R+XSaCcebV7uBw@mail.gmail.com>
References: <20210612123639.329047-1-yury.norov@gmail.com>
        <20210612123639.329047-8-yury.norov@gmail.com>
        <CAHp75VerU1NJMweWCR7MsE9hiMFZyJP8m751OFKmGrJ1gVhMWw@mail.gmail.com>
        <YMVSHCY9yEocmfVD@yury-ThinkPad>
        <CAHp75VeXJcPai=w3Fbx11TPf_CZTusD6U_E2R+XSaCcebV7uBw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 13 Jun 2021 12:41:38 +0300 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sunday, June 13, 2021, Yury Norov <yury.norov@gmail.com> wrote:
> 
> > On Sun, Jun 13, 2021 at 12:47:31AM +0300, Andy Shevchenko wrote:
> > > On Sat, Jun 12, 2021 at 3:39 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > >
> > > > find_first{,_zero}_bit is a more effective analogue of 'next' version
> > if
> > > > start == 0. This patch replaces 'next' with 'first' where things look
> > > > trivial.
> > >
> > > Depending on the maintainers (but I think there will be at least few
> > > in this case) they would like to have this be split on a per-driver
> > > basis.
> > > I counted 17 patches. I would split.
> > >
> > > Since many of them are independent you may send without Cc'ing all
> > > non-relevant people in each case.
> >
> > submitting-patches.rst says:
> >
> >         On the other hand, if you make a single change to numerous files,
> >         group those changes into a single patch.  Thus a single logical
> > change
> >         is contained within a single patch.
> >
> > Also refer 96d4f267e40f9 ("Remove 'type' argument from access_ok()
> > functioin.")
> 
> 
> Mixing arch and non arch is not good, fs stuff can be separated as well,
> so, at least 4 patches. Otherwise it might be not good for bissection /
> reverting.

Actually I don't have a problem taking/merging splatterpatches like
this one, as long as all relevant maintainers are cc'ed throughout. 

If they review/test/ack then great.  If they don't then their stuff
breaks during -rc and they get to fix it (this almost never happens
anyway).

If the splatterpatch is prepared as a series of patches then that's OK
as well.  I'll queue them all up behind linux-next so I can see when
maintainers have merged them and drop the individual patches as/when
needed.

On balance...  I guess individual patches is a bit better because the
more diligent maintainers will sometimes merge them and get them better
tested.  But in practice, 95% of maintainers will eyeball it, say "yeah
fine" and let Andrew handle it.

