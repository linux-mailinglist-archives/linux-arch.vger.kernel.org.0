Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF59D352476
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 02:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhDBAdB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 20:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233677AbhDBAdB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 20:33:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2111D6100C;
        Fri,  2 Apr 2021 00:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617323580;
        bh=l5OBmZolqQt7kxKdrbukEJTSt9ja/UZ2NhAmGHQ3zxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kG/JulKQ/j7q300El8hcUdl9djvCOTMS316bPRU5+zmo9B22mCs+usRR8Evbkkn3N
         vA22n5vywmXywzyPXhGzM0UbJXdoQ9BA2ttE7BZclCb+sTtuAmm/YGdbm35L7i53EV
         glVlMEwvdxswxe9y/dSTG3XBRgE8mCchA/H3Kpqg=
Date:   Thu, 1 Apr 2021 17:32:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Sterba <dsterba@suse.com>,
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
        Yoshinori Sato <ysato@users.osdn.me>
Subject: Re: [PATCH v6 00/12] lib/find_bit: fast path for small bitmaps
Message-Id: <20210401173258.1f9a107ef13f210fb4896780@linux-foundation.org>
In-Reply-To: <CAHp75VdTndAD1gyLE_e8m9AaxrRMCNpYEu22+tWe1xrAz8oKBw@mail.gmail.com>
References: <20210401003153.97325-1-yury.norov@gmail.com>
        <CAHp75VdzRXPsQ7Jvivm5UU+mfkgQ_0rmnegp04v-v9fwrjdrqg@mail.gmail.com>
        <CAK8P3a2EGc4BS7UTyC6=ySgLEoyqbswh1Gh_=M21NmhRThssYQ@mail.gmail.com>
        <CAHp75VdTndAD1gyLE_e8m9AaxrRMCNpYEu22+tWe1xrAz8oKBw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 1 Apr 2021 12:50:31 +0300 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> > I normally don't have a lot of material for asm-generic either, half
> > the time there are no pull requests at all for a given release. I would
> > expect future changes to the bitmap implementation to only need
> > an occasional bugfix, which could go through either the asm-generic
> > tree or through mm and doesn't need another separate pull request.
> >
> > If it turns out to be a tree that needs regular updates every time,
> > then having a top level repository in linux-next would be appropriate.
> 
> Agree. asm-generic may serve for this. My worries are solely about how
> much burden we add on Andrew's shoulders.

Is fine.  Saving other developers from having to maintain tiny trees is
a thing I do.

