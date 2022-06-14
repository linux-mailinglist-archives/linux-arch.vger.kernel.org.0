Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1227A54B250
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jun 2022 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiFNNcl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 09:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiFNNcj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 09:32:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDA52DF1
        for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2022 06:32:37 -0700 (PDT)
Received: from mail-yw1-f169.google.com ([209.85.128.169]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MgeXk-1nV4gx1ueK-00h6Cx for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2022
 15:32:35 +0200
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-30ce6492a60so29523857b3.8
        for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2022 06:32:35 -0700 (PDT)
X-Gm-Message-State: AJIora+rJ5VSKNIoA3nMTzZjFubZKL2w2eR6eqTEQlQb4khgP0j3pTO4
        3Lhbo7umwp66FvZAvlCDHZ8qZ0lxjkTACPi8FTQ=
X-Google-Smtp-Source: AGRyM1vvlZ7ZgOyN/gjzYy4lLmPxp+43A+lk1OmJzrbyTRheVplfc8iYLgvR/4CBVOfab2vEG1EiBin3Pugulr6GciM=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr5789036ywk.209.1655213554213; Tue, 14
 Jun 2022 06:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220613182746.114115-1-bigeasy@linutronix.de>
 <CAK8P3a18cCESYki+4_3UgALRUq1MKmjSZvfXEyKHxgSENYfnXw@mail.gmail.com>
 <Yqg0sNLrtyMvhMNY@linutronix.de> <CAK8P3a2KxBgdu66tbc4YEUDsjZrRRs3t78NNPLj3K9XFB+BFAg@mail.gmail.com>
 <YqhnUNzINOkhvfRb@linutronix.de>
In-Reply-To: <YqhnUNzINOkhvfRb@linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jun 2022 15:32:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Aqid+YXr_9J=G-uL7qfmk4uc9mzDOdAOK6S2KY4rPOg@mail.gmail.com>
Message-ID: <CAK8P3a0Aqid+YXr_9J=G-uL7qfmk4uc9mzDOdAOK6S2KY4rPOg@mail.gmail.com>
Subject: Re: [PATCH] generic/softirq: Disable softirq stacks on PREEMPT_RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:57LVLkaPl97eW1cAY+rULcz7QuF6aDqaqCnVviO7DiI/WCtq/KJ
 pY5mBrurzf408Rr5GlUDmnsWP9xvFF84hFJ9dYHx9KWGYDNN/+j41x0KpmnmaZMwToeTrBJ
 IddqOvIlE/zrTcy1HPJQ8Y3Y+08Zns5089sZZaV5glBDT12kf33ooREg+OTH1k1ud0NYbus
 4w+0fZnU5/PruEsU8z2yA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C5WQojcM7t4=:i/6q7/+ghHMzXOIyVY9Xx1
 hTDbPZO3okr9R7/iKHSoDCU624Vi5OgTy+2RBF7+y4LxBP4Os3CY2TKb5+SRAzXxuQ5XDHCxg
 ipQ+P9gUOqR4uaFw3LhvysghB0nmd1TLZpEGvq+QZcHhE+lQ64Q7Ql9wuGEUv8dhGq1ud5GB6
 82AjeSSXTlQ1rx4AjZVBDyECPfeN76kTdo015qUAUK1645y5Jl+DV8TpjmvERwCjOBWmmIQgm
 i7ia1iG1oorW9mtjk95m9PdQ2pmFgKYJcBwYYyx2ZtvmtEx2PbGxVPwnWoZ4Qq101wv/fm4lA
 QFHfkpuwTLYcgqa3x1Z2HqZ0lbQwnDe6IL+ttTiJGwrtgpIDvus0ZYkBivU5wpsN50Dz9txOk
 zZffq4Ao9aU5a0/RfzoDed4QWxny1hDY3xUD7Srggn8oP5qAxVGH0e2iEhgIvoo4Y1st1E0Qf
 75c8T3IwzDhZ72fEKWI+KcO74PUj5KspmgAidCQM7t9kTLGhH3XtzIn5a7t7sTCoFj2yBtxzl
 m9V9MmTAO4jKz1hPckoPmD+phSHuHaR9ipO196zg3kd2JxuU402PjDwLpUrV8JTacBxwNvOZZ
 h1xOSMSZdpt3a5zcA+5TrBMiiEe1uzdnPbFmd0y9Jm9Iz76Xf0q6ymQPsTNDea4d8rYNj3ZDL
 zbg7p6p6C+LHePqE4+OmTymOWXBvr+8F7zHsDh8DB6SM17uH18FZpSMQqO3HyZnWBnojV0YSk
 HoMC23BSqWq66WgkYrud+Y2NMHK6iSsngo5riA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 14, 2022 at 12:47 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-06-14 12:07:48 [+0200], Arnd Bergmann wrote:
> > > So where do I put this patch to? If I remember correctly then arm64 is
> > > using this. ARM has its own thing and x86 has this change already.
> >
> > I don't see HAVE_SOFTIRQ_ON_OWN_STACK for arm, parisc, powerpc,
> > s390, sh, sparc and x86, but not arm64. I would suggest having a single
> > patch that does the same change across all architectures that don't already do
> > this, and then merging it either through tip or through my asm-generic tree.
>
> Oh. I posted the ARM bits with my other ARM patch as a mini two patch
> series a few secs before this.

Yes, I saw these, and that's why I wondered about it, because they looked
like they should not be applied independently.

> I could group this softirq change for all architectures in a single
> patch. But then powerpc didn't want the "PREEMPT_RT" annotation for the
> warning/ stack backtrace and they may not be too keen about this. So for
> powerpc I was thinking to present them all at once.
> Looking at sparc and parisc, there might be more to it than just this.
> Both were never tested while I have the missing bits for arm* and
> powerpc in my queue.
>
> Eitherway, if you want I can regroup and send you the softirq bits for
> all arches.

Yes, I think this would be good. These are still targeted for next, right?

> > > - ksoftirqd thread.
> > > - in the force-threaded interrupt after the main handler.
> > > - any time after bh-counter hits zero due local_bh_enable().
> > >
> > > The last one will cause higher task stacks.
> >
> > Does this mean it only happens when a softirq gets raised from task context
> > (which would be predictable), or also at an arbitrary time if it gets raised
> > by a non-threaded hardirq or IPI?
>
> If the softirq gets raised from non-task context (hardirq or IPI) then
> it will be deferred to ksoftirqd (and not invoked on irq-exit path).

Ok, got it, that means the stack usage is still going to be reproducible.

I wonder how common this case is in practice, but it clearly makes
sense at least from a time accounting perspective.

      Arnd
