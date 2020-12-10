Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065342D500C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Dec 2020 02:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbgLJBFN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Dec 2020 20:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731357AbgLJBFJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2020 20:05:09 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D66C0613CF
        for <linux-arch@vger.kernel.org>; Wed,  9 Dec 2020 17:04:28 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id 4so1163220uap.8
        for <linux-arch@vger.kernel.org>; Wed, 09 Dec 2020 17:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yB16PIlbuGxFsiWV8oZf3gYq1QL0L6wWKXHXLLEyFBM=;
        b=tjLJkPuP9VfGGRRESQGgX8Vsp+QNvwZ9qRgzUTQsftZyC/WO3uWzhAYg9n8G4vTQF5
         fqsx/X485RXHYLPw7yftHthBxXC0Re42wDIxHN2tCNoNXgfVBx2Sb5MstdjJ+iyv7/9W
         peXWVD0C+8EsJJ58i4Jyrkf2zlxR+cbAaRoBVXvEyiBFikSUl8G3mZKf4GYcMrOaREWV
         3vkECCeGZJN9l8RE01cL131+yBD3cghhLTQLSwsf0gRCIgyJBhQ7CACHmqa3ykormvwN
         vGLJjMNF3taa+q89aJJ1yXr4fLLuhFizGdAsWrF+QcFLoI2STXG0Ct88fjJjKo5nWftQ
         FwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yB16PIlbuGxFsiWV8oZf3gYq1QL0L6wWKXHXLLEyFBM=;
        b=IAgXZ93RiZpsgSAgV08oanVq1rrz8HJWUU4X/odwesB40p2bwJeBD7fgywN2NMjapY
         97Dt9clHbSC32nHH3a1VC58MiWMK8uPLpuC96VKv5p1XavA6Ex/qS+34Hskpp1XABkyi
         dVzqQxPM2VdqrpmhwzkBChEtYCJOg9Uo6SIcCjTZoanhE9HejBTvQUmy9I2hXihALYfx
         sJqx8rKO9ZyULBH5kCUx5teoY1rY2MLVz89ohJgRETc6pDMSmovGhq9Vq34wWE9GpMFL
         p6zvsn8UU4P4lqhCEgpFP8I3dIP5mC/wo7N3doH0/QPpeMzO75SaVH9W4LZvnWko4bNt
         JMMA==
X-Gm-Message-State: AOAM533yzQRHJS8TY6wGEEgHkk+GaHk6jNH3uo9IRrOPjjp43VZs+cFk
        uaM6lzSpxjtj2U/6tg+2hmFujV4BbolDyw==
X-Google-Smtp-Source: ABdhPJy0G1GMrA+uOp2KtsEQktnkVqlXG3slXkhkhI4M9Ki+7wGcgID+wcVtrp+6ODR8nMs8ow5+Tw==
X-Received: by 2002:ab0:240c:: with SMTP id f12mr5049750uan.117.1607562266973;
        Wed, 09 Dec 2020 17:04:26 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id f1sm335502vkb.46.2020.12.09.17.04.24
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 17:04:24 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id u7so1972928vsg.11
        for <linux-arch@vger.kernel.org>; Wed, 09 Dec 2020 17:04:24 -0800 (PST)
X-Received: by 2002:a05:6102:1173:: with SMTP id k19mr5046476vsg.51.1607562263528;
 Wed, 09 Dec 2020 17:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20201209143707.13503-1-erez.geva.ext@siemens.com>
 <20201209143707.13503-2-erez.geva.ext@siemens.com> <CA+FuTScWkYn0Ur+aSuz1cREbQJO0fB6powOm8PFxze4v8JwBaw@mail.gmail.com>
 <VI1PR10MB244654C4B42E47DB5EBE0B05ABCC0@VI1PR10MB2446.EURPRD10.PROD.OUTLOOK.COM>
 <CA+FuTSd7oB0qO707W6htvs=FOJn10cgSQ4_iGFz4Sk9URXtZiw@mail.gmail.com> <VI1PR10MB2446ACEACAE1F3671682407FABCC0@VI1PR10MB2446.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VI1PR10MB2446ACEACAE1F3671682407FABCC0@VI1PR10MB2446.EURPRD10.PROD.OUTLOOK.COM>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 9 Dec 2020 20:03:47 -0500
X-Gmail-Original-Message-ID: <CA+FuTSd-YRc6aGsudgaeSHwmAb_748ay1ssip64G1jeE=mKwmg@mail.gmail.com>
Message-ID: <CA+FuTSd-YRc6aGsudgaeSHwmAb_748ay1ssip64G1jeE=mKwmg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Add TX sending hardware timestamp.
To:     "Geva, Erez" <erez.geva.ext@siemens.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Alexei Starovoitov <ast@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Eyal Birger <eyal.birger@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Ogness <john.ogness@linutronix.de>,
        Jon Rosen <jrosen@cisco.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Martin KaFai Lau <kafai@fb.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Or Cohen <orcohen@paloaltonetworks.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Xie He <xie.he.0141@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladis Dronov <vdronov@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        "Molzahn, Ines" <ines.molzahn@siemens.com>,
        "Sudler, Simon" <simon.sudler@siemens.com>,
        "Meisinger, Andreas" <andreas.meisinger@siemens.com>,
        "Bucher, Andreas" <andreas.bucher@siemens.com>,
        "henning.schild@siemens.com" <henning.schild@siemens.com>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "Zirkler, Andreas" <andreas.zirkler@siemens.com>,
        "Sakic, Ermin" <ermin.sakic@siemens.com>,
        "anninh.nguyen@siemens.com" <anninh.nguyen@siemens.com>,
        "Saenger, Michael" <michael.saenger@siemens.com>,
        "Maehringer, Bernd" <bernd.maehringer@siemens.com>,
        "gisela.greinert@siemens.com" <gisela.greinert@siemens.com>,
        Erez Geva <ErezGeva2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 9, 2020 at 3:57 PM Geva, Erez <erez.geva.ext@siemens.com> wrote:
>
>
> On 09/12/2020 18:37, Willem de Bruijn wrote:
> > On Wed, Dec 9, 2020 at 10:25 AM Geva, Erez <erez.geva.ext@siemens.com> wrote:
> >>
> >>
> >> On 09/12/2020 15:48, Willem de Bruijn wrote:
> >>> On Wed, Dec 9, 2020 at 9:37 AM Erez Geva <erez.geva.ext@siemens.com> wrote:
> >>>>
> >>>> Configure and send TX sending hardware timestamp from
> >>>>    user space application to the socket layer,
> >>>>    to provide to the TC ETC Qdisc, and pass it to
> >>>>    the interface network driver.
> >>>>
> >>>>    - New flag for the SO_TXTIME socket option.
> >>>>    - New access auxiliary data header to pass the
> >>>>      TX sending hardware timestamp.
> >>>>    - Add the hardware timestamp to the socket cookie.
> >>>>    - Copy the TX sending hardware timestamp to the socket cookie.
> >>>>
> >>>> Signed-off-by: Erez Geva <erez.geva.ext@siemens.com>
> >>>
> >>> Hardware offload of pacing is definitely useful.
> >>>
> >> Thanks for your comment.
> >> I agree, it is not limited of use.
> >>
> >>> I don't think this needs a new separate h/w variant of SO_TXTIME.
> >>>
> >> I only extend SO_TXTIME.
> >
> > The patchset passes a separate timestamp from skb->tstamp along
> > through the ip cookie, cork (transmit_hw_time) and with the skb in
> > shinfo.
> >
> > I don't see the need for two timestamps, one tied to software and one
> > to hardware. When would we want to pace twice?
>
> As the Net-Link uses system clock and the network interface hardware uses it's own PHC.
> The current ETF depends on synchronizing the system clock and the PHC.

If I understand correctly, essentially you are trying to achieve a
single delivery time. The need for two separate timestamps passed
along is only because the kernel is unable to do the time base
conversion. Else, ETF could program the qdisc watchdog in system time
and later, on dequeue, convert skb->tstamp to the h/w time base before
passing it to the device.

It's still not entirely clear to me why the packet has to be held by
ETF initially first, if it is held until delivery time by hardware
later. But more on that below.

So far, the use case sounds a bit narrow and the use of two timestamp
fields for a single delivery event a bit of a hack. And that does
impose a cost in the hot path of many workloads by adding a field the
ip cookie, cork and writing to (possibly cold) skb_shinfo for every
packet.

> >>> Indeed, we want pacing offload to work for existing applications.
> >>>
> >> As the conversion of the PHC and the system clock is dynamic over time.
> >> How do you propse to achive it?
> >
> > Can you elaborate on this concern?
>
> Using single time stamp have 3 possible solutions:
>
> 1. Current solution, synchronize the system clock and the PHC.
>     Application uses the system clock.
>     The ETF can use the system clock for ordering and pass the packet to the driver on time
>     The network interface hardware compare the time-stamp to the PHC.
>
> 2. The application convert the PHC time-stamp to system clock based.
>      The ETF works as solution 1
>      The network driver convert the system clock time-stamp back to PHC time-stamp.
>      This solution need a new Net-Link flag and modify the relevant network drivers.
>      Yet this solution have 2 problems:
>      * As applications today are not aware that system clock and PHC are not synchronized and
>         therefore do not perform any conversion, most of them only use the system clock.
>      * As the conversion in the network driver happens ~300 - 600 microseconds after
>         the application send the packet.
>         And as the PHC and system clock frequencies and offset can change during this period.
>         The conversion will produce a different PHC time-stamp from the application original time-stamp.
>         We require a precession of 1 nanoseconds of the PHC time-stamp.
>
> 3. The application uses PHC time-stamp for skb->tstamp
>     The ETF convert the  PHC time-stamp to system clock time-stamp.
>     This solution require implementations on supporting reading PHC clocks
>     from IRQ/kernel thread context in kernel space.

ETF has to release the packet well in advance of the hardware
timestamp for the packet to arrive at the device on time. In practice
I would expect this delta parameter to be at least at usec timescale.
That gives some wiggly room with regard to s/w tstamp, at least.

If changes in clock distance are relatively infrequent, could this
clock diff be a qdisc parameter, updated infrequently outside the
packet path?

It would even be preferable if the qdisc and core stack could be
ignorant of such hardware clocks and the time base is converted by the
device driver when encoding skb->tstamp into the tx descriptor. Is the
device hardware clock readable by the driver? (I don't know which
exact device you're targeting). From the above, it sounds like this is
not trivial.

> Just for clarification:
> ETF as all Net-Link, only uses system clock (the TAI)
> The network interface hardware only uses the PHC.
> Nor Net-Link neither the driver perform any conversions.
> The Kernel does not provide and clock conversion beside system clock.
> Linux kernel is a single clock system.
>
> >
> > The simplest solution for offloading pacing would be to interpret
> > skb->tstamp either for software pacing, or skip software pacing if the
> > device advertises a NETIF_F hardware pacing feature.
>
> That will defy the purpose of ETF.
> ETF exist for ordering packets.
> Why should the device driver defer it?
> Simply do not use the QDISC for this interface.

ETF queues packets until their delivery time is reached. It does not
order for any other reason than to calculate the next qdisc watchdog
event, really.

If h/w can do the same and the driver can convert skb->tstamp to the
right timebase, indeed no qdisc is needed for pacing. But there may be
a need for selective h/w offload if h/w has additional constraints,
such as on the number of packets outstanding or time horizon.

> >> I did not use "Fair Queue traffic policing".
> >> As for ETF, it is all about ordering packets from different applications.
> >> How can we achive it with skiping queuing?
> >> Could you elaborate on this point?

On which note: with this patch set all applications have to agree to
use either h/w or system time base when sorting by delivery time in
etf_enqueue_timesortedlist. I imagine that in practice that makes this
h/w mode a qdisc used by a single process?

> >
> > The qdisc can only defer pacing to hardware if hardware can ensure the
> > same invariants on ordering, of course.
>
> Yes, this is why we suggest ETF order packets using the hardware time-stamp.
> And pass the packet based on system time.
> So ETF query the system clock only and not the PHC.
>
> >
> > Btw: this is quite a long list of CC:s
> >
> I need to update my company colleagues as well as the Linux group.

Of course. But even ignoring your colleagues this is still quite a
large list (> 40).
