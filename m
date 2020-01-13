Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A9C1391B6
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2020 14:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgAMNEB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jan 2020 08:04:01 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:40195 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgAMNEB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jan 2020 08:04:01 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MEVJq-1iti7w3NCE-00G04S; Mon, 13 Jan 2020 14:03:59 +0100
Received: by mail-qt1-f181.google.com with SMTP id g1so8941152qtr.13;
        Mon, 13 Jan 2020 05:03:58 -0800 (PST)
X-Gm-Message-State: APjAAAWCFSNQ1Q4E4kjOTf4HO1jGXHbo2GpDQVXZXV1mQRx8hfNOwIk1
        Szk1kpSSTnhglI6ewYhNw6eh284iL3JpvXCcJP8=
X-Google-Smtp-Source: APXvYqzl6nl/Rc4LFh6LhQjNQZSuGpJyRnmRp6IEY4UIoutr1yllHQvObeSobYOiZleBm+lywh9WsVB+UExLm/ptqtg=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr13626947qtr.142.1578920637682;
 Mon, 13 Jan 2020 05:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org> <CAK8P3a1UzSOHdihbzOn5CZZfo1kvCdj7BAzdQE=PgYS9GBF4Hw@mail.gmail.com>
 <CAHk-=wggv_LmrL85Ez0TLcAku8iz05VZmJxDGo=2aP2VvQtrsA@mail.gmail.com>
In-Reply-To: <CAHk-=wggv_LmrL85Ez0TLcAku8iz05VZmJxDGo=2aP2VvQtrsA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Jan 2020 14:03:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Qvz+HB-ROy2cmtPtE2m113iBhWbdibpdQ4ycNp9u=ng@mail.gmail.com>
Message-ID: <CAK8P3a1Qvz+HB-ROy2cmtPtE2m113iBhWbdibpdQ4ycNp9u=ng@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:maIhxSVsvJZGSYRWgJ+4V38fF6YeStUy48VybSPlgFgP1JyKGr6
 Ub7zz3shDsXosbuv7IHqU+wlX03r5MZw4T+YcKrhqoqFpeczcxestZtYEkEtSnYxyaM4QPW
 DkmIWJFra5EDRDgQBk+R5dMQWwMRlM3pVzJF3BZMI9uU8jfDfHNl3GCcvtMKSWbOrBO0DqV
 vdak92mO4zStkY7hV/XWg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vnUSi9YgTdI=:Q3ODEJlx7TOUea5RffFqF2
 Ghd0fjf86pSLMTdYUmQcz2Zge0dRiPAWdwGP5AhO6+isct9Ju6hEr5oD3EI3kxmSMWmF6mE3R
 oc6tyI/TEJQ+wElQyoJsjJRgDDRS2lhdrSK7s7hfVeWfiMKyu1Z0nqt5gPwpXhY+fR7lhm+DL
 k+ZShW+NDkMC8nJkdbKpIWtz3/ty7SLKAWPlpLs7nhuPAgbF6olWBM1WV8oP/EXyYmaMnv4dh
 jphNJfIG2StfBoQBLG7xO2BRgO2u4KcOIrhjO8CfNAh//pC6KH3BgDMPr1LgK+81mJZ2gIBeV
 mEs2W1S0M5jN0NdYBtiJr+YfjAEmWjONRQeBBox/jsh07mzWwa93qSTF2WWJ9D+vWiY7vciFj
 sy4FITZTuVTt4b3xd/fUHYSdKWX1MwE5rNYpCls/LFO1oQB7SQClVr8CLTuQcIGXsra1fGFOS
 r+XkW+A1MclJ3Ws0oGl2SFsftVdPO4Q+zWkVeDYR+qKj4KLoceG14SrgaXB1FsOdhztypg+EX
 xiAj5mMkKSbZSb3slNcSgRFAzEqyUtt3LnN2er0IlfQM8JyTozknz/IE7NW3AgSw3q8mmV0YO
 GCP9u2fDCpvnl2wa5e6TOLa6g0dZlHRZcCshprPSfGCvFf/xOAkAbHAt1U00/nUbbZ7uMsLZY
 CbbERH7NBRUCTSyxaF5fiyaNAmrNYak50E20a9kDy9R6UUVIdF03a9DmuXf4pocaMurfilSNS
 iOAoad30dL3dpMcY1DV63rRvBuW0u44RnDF/XeGvm2h1j9o1gk0FoDLxZAHVo4Vv9JejzCvGb
 SoVDBv3XnsN7EZCbm1RzrAR+7zRknFayRPp2WifdLbzaeFkjIGe3odkxW1OOwS9+FN3rTXUd4
 lZwy28m1tUgjTn/YOOtw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 10, 2020 at 9:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jan 10, 2020 at 11:47 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Isn't the read_barrier_depends() the only reason for actually needing
> > the temporary local variable that must not be volatile?
> >
> > If you make alpha provide its own READ_ONCE() as the first
> > step, it would seem that the rest of the series gets much easier
> > as the others can go back to the simple statement from your
>
> Hmm.. The union still would cause that "take the address of a volatile
> thing on the stack" problem, wouldn't it? And that was what caused
> most of the issues.

Ah, I was missing that there is still the union in smp_load_acquire(),
I only saw that the one in READ_ONCE() is needed only on alpha.

The number of files using smp_load_acquire() is fairly small though,
so we could consider changing it to pass both source and destination
as macro arguments and use typeof(dest) instad of typeof(source)
to avoid the volatile pointer access.

> I think the _real_ issue is how KASAN forces that odd pair of inline
> functions in order to have the annotations on the accesses.

But the inline functions (I assume you mean __write_once_size
and __read_once_size_nocheck?) are completely removed after
Will's series, so those no longer cause harm, right?

      Arnd
