Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13993D91BE
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhG1PVU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 11:21:20 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:38684 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235457AbhG1PVU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jul 2021 11:21:20 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2021 11:21:19 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id A42F11811BA23
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 15:13:44 +0000 (UTC)
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 42E6D182CF666;
        Wed, 28 Jul 2021 15:13:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 349B1268E38;
        Wed, 28 Jul 2021 15:13:34 +0000 (UTC)
Message-ID: <7fd3eda0658e7ef4ba0463ecd39f7a17dbd4e5c3.camel@perches.com>
Subject: Re: [PATCH 0/8] all: use find_next_*_bit() instead of
 find_first_*_bit() where possible
From:   Joe Perches <joe@perches.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
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
Date:   Wed, 28 Jul 2021 08:13:32 -0700
In-Reply-To: <YQFxJnB+cH4SU9I3@yury-ThinkPad>
References: <20210612123639.329047-1-yury.norov@gmail.com>
         <YQFxJnB+cH4SU9I3@yury-ThinkPad>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 349B1268E38
X-Spam-Status: No, score=0.48
X-Stat-Signature: 6uu1mm4qmzqhb9fr9w8hcpruiaippn7o
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Yky/kvvqPA1H4x41Kh0vsDjYybApUtnQ=
X-HE-Tag: 1627485214-180011
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-07-28 at 08:00 -0700, Yury Norov wrote:
> Ping again.
> 
> The rebased series together with other bitmap patches can be found
> here:
> 
> https://github.com/norov/linux/tree/bitmap-20210716
[]
> >  .../bitops => include/linux}/find.h           | 149 +++++++++++++++++-

A file named find.h in a directory named bitops seems relatively sensible,
but a bitops specific file named find.h in include/linux does not.



