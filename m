Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47419157217
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2020 10:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgBJJvd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Feb 2020 04:51:33 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:38851 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJJvd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Feb 2020 04:51:33 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 01A9pTct031646;
        Mon, 10 Feb 2020 18:51:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 01A9pTct031646
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581328290;
        bh=fNKuZ4BeColKJYzbO/lQDeGPMw/RVLynZL0azIAPAdM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NLiLyJONKPIV2MVN044skGMpcOIEpIZngXCbHBgqX7WPnLgN9SNPpzYEZ0C594pXQ
         UHVapCNR+sNBd/uBEkgC9mCNvNAKW+TlUo8LgSBSxl/hVu/+fj4U/feAdzAa+qvUex
         /bBNB6MFjPiB1n+Aul9K6hthV2o+HHuPQT6w3OLpFHvgKuGhv+8PswrsYIwP51Y23Q
         tfHWzDdBOc1UPFrpenMF6PX9PmPjJ65KBB4xb+ndnzhTuf10PY3nlhbYPuMFYOYdWI
         lKYlxbPQIElkkDYUPEEJYWDAmIiVH+l0oIXEoQQuU5ky3/0za3qwZ/M3b77gcy6EE6
         Qo10SG1CnjoTQ==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id g15so3717692vsf.1;
        Mon, 10 Feb 2020 01:51:30 -0800 (PST)
X-Gm-Message-State: APjAAAVtGFIaiSvEHwfsNQP55lC3mrMaAxAhFDQc38cIK3euo7YDaHiX
        pGvEF0TOGAU8tq32mG1hEDhVyhGoFoQejqdtZKw=
X-Google-Smtp-Source: APXvYqxq3f1kAL5bTVLwnhzv6Hm7mM4ERbXcXAsVJ48BcQvRAW9w15eCRVm//W8I52h9j+XTb0KnFn8CpkGVDOZZKF8=
X-Received: by 2002:a05:6102:190:: with SMTP id r16mr5621699vsq.215.1581328289249;
 Mon, 10 Feb 2020 01:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org> <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
 <20200124083307.GA14914@hirez.programming.kicks-ass.net>
In-Reply-To: <20200124083307.GA14914@hirez.programming.kicks-ass.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 10 Feb 2020 18:50:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=er+Vkvx+vurYMCHS2u1_Vj0zV+tvUzDkSwop3XP1gg@mail.gmail.com>
Message-ID: <CAK7LNAS=er+Vkvx+vurYMCHS2u1_Vj0zV+tvUzDkSwop3XP1gg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 24, 2020 at 5:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 23, 2020 at 09:59:03AM -0800, Linus Torvalds wrote:
> > On Thu, Jan 23, 2020 at 7:33 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > This is version two of the patches I previously posted as an RFC here:
> >
> > Looks fine to me, as far as I can tell,
>
> Awesome, I've picked them up with a target for tip/locking/core.

Were they really picked up?

The MW is closed now, but I do not them in Linus' tree.
I do not see them even in linux-next.




--
Best Regards

Masahiro Yamada
