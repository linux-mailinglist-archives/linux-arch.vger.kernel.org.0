Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D41112E29
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2019 16:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfLDPRj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 4 Dec 2019 10:17:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39507 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfLDPRi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Dec 2019 10:17:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so6624348oty.6;
        Wed, 04 Dec 2019 07:17:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fsokDCNhL4pai+t3v/JumPHu5Uv1VUcK2gbmN8Wh5bE=;
        b=Hp9LshcZeAeBGoyke9wPpHFR6vT5naujxsDhyojpBp8lv7MaGcUi3EiHnFeEgVavql
         HaFwpK5C/hN9+a1oNXJqmc8tgWflxA5jwRMpVDfF6VYv9ZVJKTPw7uAhuKB61IBxvDfU
         lBpDlMqjW/2u62JMLPy9NWJYKkcgtG/3SVv+aXnwpkFqVZplh7ddUeM/y9Dfnagl2Q/q
         O/lSVi8t9m1gamGz9zXOhwmk1MD3hB8eKqTHFhwFoyMBCEWqHXDSSGFB5gEUy0Z0BUQZ
         EH/4WcU8f0jLNFzze/AsWO5Tu+vpXsL6VnOF77B3oaq1KUWJ2RDf7Aivq2RQ0QKttAoX
         7x7w==
X-Gm-Message-State: APjAAAWFW0PUCXoMZGMwnjjBqVEEgNo8Or9NSt/aq9gZl/sB+FGUgEYf
        z/FQTjTH0NgH0ozmU3tjVmXg7rxYU0cjBUJYBzc=
X-Google-Smtp-Source: APXvYqxolX9i1mLMUhsyF5Ki7P3Rh+HKcBCkhB6IzXg1InjP/Ohy7W/cB4AfN2m6/vxD0bcVO9prjPO+O2KYzGvi2wY=
X-Received: by 2002:a9d:2073:: with SMTP id n106mr2843943ota.145.1575472657861;
 Wed, 04 Dec 2019 07:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20190219103148.192029670@infradead.org> <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net> <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
 <156fa92f-4c5a-08bd-bcda-20029724c0de@roeck-us.net>
In-Reply-To: <156fa92f-4c5a-08bd-bcda-20029724c0de@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Dec 2019 16:17:26 +0100
Message-ID: <CAMuHMdVKcTum5vMmT1TdttVnGnhnQihGU1jrguF26TW7ZeOJPg@mail.gmail.com>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Günter,

On Wed, Dec 4, 2019 at 2:22 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 12/4/19 4:32 AM, Geert Uytterhoeven wrote:
> > On Wed, Dec 4, 2019 at 11:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >> On Tue, Dec 03, 2019 at 12:19:00PM +0100, Geert Uytterhoeven wrote:
> >>> On Tue, Feb 19, 2019 at 11:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>>> Generic mmu_gather provides everything SH needs (range tracking and
> >>>> cache coherency).

> >>> I got remote access to an SH7722-based Migo-R again, which spews a long
> >>> sequence of BUGs during userspace startup.  I've bisected this to commit
> >>> c5b27a889da92f4a ("sh/tlb: Convert SH to generic mmu_gather").
> >>
> >> Whoopsy.. also, is this really the first time anybody booted an SH
> >> kernel in over a year ?!?
> >
> > Nah, but the v5.4-rc3 I booted recently on qemu -M r2d had
> > CONFIG_PGTABLE_LEVELS=2, so it didn't show the problem.
> >
>
> Guess that explains why I do not see the problem with my qemu boots.
> I use rts7751r2dplus_defconfig. Is it possible to reproduce the problem
> with qemu ? I don't think so, but maybe I am missing something.

Qemu seems to support r2d and shix only.
For the latter, the website pointed to by the qemu sources no longer exists.
But according to those sources, it's also sh7750-based, so no luck.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
