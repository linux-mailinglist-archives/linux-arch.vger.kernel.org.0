Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26E33D92BE
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 18:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbhG1QIF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 12:08:05 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:48740 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237707AbhG1QHD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jul 2021 12:07:03 -0400
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BD60A183C7631;
        Wed, 28 Jul 2021 16:06:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 38B461A29FA;
        Wed, 28 Jul 2021 16:06:20 +0000 (UTC)
Message-ID: <911b290063ecab50aef8da606ddbc2e27dffa6d7.camel@perches.com>
Subject: Re: [PATCH 0/8] all: use find_next_*_bit() instead of
 find_first_*_bit() where possible
From:   Joe Perches <joe@perches.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Date:   Wed, 28 Jul 2021 09:06:18 -0700
In-Reply-To: <YQF97Q1a0NL9VBr9@yury-ThinkPad>
References: <20210612123639.329047-1-yury.norov@gmail.com>
         <YQFxJnB+cH4SU9I3@yury-ThinkPad>
         <7fd3eda0658e7ef4ba0463ecd39f7a17dbd4e5c3.camel@perches.com>
         <YQF97Q1a0NL9VBr9@yury-ThinkPad>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38B461A29FA
X-Spam-Status: No, score=-0.56
X-Stat-Signature: aj4gi8ripoqgyzad7npab69s56hu9a3c
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+FrxhVqumFzssxLoZaxyh5do3Usq3FKbI=
X-HE-Tag: 1627488380-718719
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-07-28 at 08:55 -0700, Yury Norov wrote:
> On Wed, Jul 28, 2021 at 08:13:32AM -0700, Joe Perches wrote:
> > On Wed, 2021-07-28 at 08:00 -0700, Yury Norov wrote:
> > > Ping again.
> > > 
> > > The rebased series together with other bitmap patches can be found
> > > here:
> > > 
> > > https://github.com/norov/linux/tree/bitmap-20210716
> > []
> > > >  .../bitops => include/linux}/find.h           | 149 +++++++++++++++++-
> > 
> > A file named find.h in a directory named bitops seems relatively sensible,
> > but a bitops specific file named find.h in include/linux does not.
>  
> 
> I'm OK with any name, it's not supposed to be included directly. What
> do you think about bitmap_find.h, or can you suggest a better name?

Dunno.

But I'm a bit curious about the duplicate function naming (conflicts?)
with functions in include/linux/bitmap.h



