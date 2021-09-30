Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D4741E450
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 00:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349248AbhI3W7r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 18:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhI3W7q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Sep 2021 18:59:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F4AC061771;
        Thu, 30 Sep 2021 15:58:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id dn26so27767700edb.13;
        Thu, 30 Sep 2021 15:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XWANcquiC3OT/k9PEu3qx71OxUdcpZJWv4aU3uSky5s=;
        b=SDE9WHQtL/a9M0clbm0TCl7lNza8vukyFjIcehlRUTJ2tYNz2gpfdRWku/XgIJY78e
         T6WddEkciw7Eze35I1x2HEr/LjeUPp1Ju0aWb2eOiJ5SK4WvvpkJUKrlpAA+tofpOebP
         TBhAGkjFZak2w3Ih50qnbrxY34I/g8mUCU8Ogwpar26o0K/svWEvI8DDIpJwhC8Wjnsw
         kXWgO/fUJDuh2t7UFcrTfqyJZSU80xvbX7EU1d2fPvIwHRHgRIvUJca3NakZCoRpjeuf
         zYE8fR8mlqVWHwNBwEMZ4ATkh3/XCIpPGy6Oj1PuMr7UDZz6OHDa1QwyfbPyFja9GLlI
         DZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XWANcquiC3OT/k9PEu3qx71OxUdcpZJWv4aU3uSky5s=;
        b=xvrM/x/aDAQBGtgjEvsRoJLJbjEyPsRPvhmKSkfKvafRr/EguHM/y8uxg+E9ncKlv4
         j1TAWtVbxijCOb/JTv7DH3ne1CJ9kQY+KtAPlTeRPYIIc/Blm0vG+2KTlP7Sqqljj6G/
         d152qosBFBQbyB4MJelRo9frwD4OaYAlWcXKOLCBf/0Tgj+kuVoOiPenBjXNFX420hpC
         +9Icx7+xC+4diF+ZkTnHDwDJ3m0BLog/RiBjPTfLrrdUBJwBjpE2k6OiJvwg9aMXSlie
         4N1gexc7OZ1vw2bUsjnDaA+/+SX1wdHtWFAg3SBwjN1hqUxgJcXuYBWcbPeP+YH2B93K
         fr1w==
X-Gm-Message-State: AOAM530j6cGQ1bicg5JXs8Dwn5CCxlFlqKfqHK/bSXdNUozgBfdRbVPs
        mp2hbUulZfmBphDPBRBsSaVDcRJ8HXaitdJMn78=
X-Google-Smtp-Source: ABdhPJz/YMmmeE5YFvsQBtzY8jRRBhr1m6d+5MtRxBBdFR8Khw3S3Y5hJKORenGCFsIVpvNAsPOKrDagnO48N5mKHTA=
X-Received: by 2002:aa7:d7d5:: with SMTP id e21mr10586747eds.27.1633042681168;
 Thu, 30 Sep 2021 15:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210930094447.9719-1-21cnbao@gmail.com> <a6340beb-3b4a-2518-9340-ea0fc7583dbe@redhat.com>
In-Reply-To: <a6340beb-3b4a-2518-9340-ea0fc7583dbe@redhat.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 1 Oct 2021 11:57:49 +1300
Message-ID: <CAGsJ_4wtyLOSwYH0n5vbJ3YFyXcxyVstXxn7q=nr=bPuX5oNaQ@mail.gmail.com>
Subject: Re: [PATCH v15 0/6] Add NUMA-awareness to qspinlock
To:     Waiman Long <llong@redhat.com>
Cc:     alex.kogan@oracle.com, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, guohanjun@huawei.com,
        "H. Peter Anvin" <hpa@zytor.com>, jglauber@marvell.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux@armlinux.org.uk,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        steven.sistare@oracle.com, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 1, 2021 at 5:58 AM Waiman Long <llong@redhat.com> wrote:
>
> On 9/30/21 5:44 AM, Barry Song wrote:
> >> We have done some performance evaluation with the locktorture module
> >> as well as with several benchmarks from the will-it-scale repo.
> >> The following locktorture results are from an Oracle X5-4 server
> >> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
> >> cores each). Each number represents an average (over 25 runs) of the
> >> total number of ops (x10^7) reported at the end of each run. The
> >> standard deviation is also reported in (), and in general is about 3%
> >> from the average. The 'stock' kernel is v5.12.0,
> > I assume x5-4 server has the crossbar topology and its numa diameter is
> > 1hop, and all tests were done on this kind of symmetrical topology. Am
> > I right?
> >
> >      =E2=94=8C=E2=94=80=E2=94=90                 =E2=94=8C=E2=94=80=E2=
=94=90
> >      =E2=94=82 =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4 =E2=94=82
> >      =E2=94=94=E2=94=80=E2=94=A41               1=E2=94=94=E2=94=AC=E2=
=94=98
> >        =E2=94=82  1           1   =E2=94=82
> >        =E2=94=82    1       1     =E2=94=82
> >        =E2=94=82      1   1       =E2=94=82
> >        =E2=94=82        1         =E2=94=82
> >        =E2=94=82      1   1       =E2=94=82
> >        =E2=94=82     1      1     =E2=94=82
> >        =E2=94=82   1         1    =E2=94=82
> >       =E2=94=8C=E2=94=BC=E2=94=901             1  =E2=94=9C=E2=94=80=E2=
=94=90
> >       =E2=94=82=E2=94=BC=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4 =E2=94=82
> >       =E2=94=94=E2=94=80=E2=94=98                 =E2=94=94=E2=94=80=E2=
=94=98
> >
> >
> > what if the hardware is using the ring topology and other topologies wi=
th
> > 2-hops or even 3-hops such as:
> >
> >       =E2=94=8C=E2=94=80=E2=94=90                 =E2=94=8C=E2=94=80=E2=
=94=90
> >       =E2=94=82 =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4 =E2=94=82
> >       =E2=94=94=E2=94=80=E2=94=A4                 =E2=94=94=E2=94=AC=E2=
=94=98
> >         =E2=94=82                  =E2=94=82
> >         =E2=94=82                  =E2=94=82
> >         =E2=94=82                  =E2=94=82
> >         =E2=94=82                  =E2=94=82
> >         =E2=94=82                  =E2=94=82
> >         =E2=94=82                  =E2=94=82
> >         =E2=94=82                  =E2=94=82
> >        =E2=94=8C=E2=94=A4                  =E2=94=9C=E2=94=80=E2=94=90
> >        =E2=94=82=E2=94=BC=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4 =E2=94=82
> >        =E2=94=94=E2=94=80=E2=94=98                 =E2=94=94=E2=94=80=
=E2=94=98
> >
> >
> > or:
> >
> >
> >      =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=90       =E2=94=8C=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90      =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90      =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=90
> >      =E2=94=82   =E2=94=82       =E2=94=82   =E2=94=82      =E2=94=82  =
  =E2=94=82      =E2=94=82     =E2=94=82
> >      =E2=94=82   =E2=94=82       =E2=94=82   =E2=94=82      =E2=94=82  =
  =E2=94=82      =E2=94=82     =E2=94=82
> >      =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=A4
> >      =E2=94=82   =E2=94=82       =E2=94=82   =E2=94=82      =E2=94=82  =
  =E2=94=82      =E2=94=82     =E2=94=82
> >      =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=98       =E2=94=94=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98      =E2=94=94=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98      =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98
> >
> > do we need to consider the distances of numa nodes in the secondary
> > queue? does it still make sense to treat everyone else equal in
> > secondary queue?
>
> The purpose of this patch series is to minimize cacheline transfer from
> one numa node to another. Taking the fine grained detail of the numa
> topology into account will complicate the code without much performance
> benefit from my point of view. Let's keep it simple first. We can always
> improve it later on if one can show real benefit of doing so.

for sure i am not expecting the complex  NUMA topology taken into account f=
or
this moment. I am just curious how things will be different if topology isn=
't a
crossbar with 1-hop only.

when the master queue is empty, the distance of the numa node spinlock will
jump to will affect the performance. but I am not quite sure how much it wi=
ll
be. just like a disk, bumping back and forth between far cylinders and sect=
ors
might waste a lot of time.

On the other hand, some numa nodes might be very close while some others
might be very far. for example, if one socket has several DIEs, and the mac=
hine
has several sockets, cacheline coherence overhead for NUMA nodes of DIEs wi=
thin
one socket might be much less than that of NUMA nodes which are in differen=
t
sockets. I assume maintaining the master/secondary queues need some
overhead especially while the system has many cores and multiple NUMA nodes=
,
in this case, making neighbor NUMA nodes share one master queue might win.

Anyway, we need a lot of benchmarking on this before we can really do anyth=
ing
on it.  For this moment, ignoring the complicated topology should be a
better way
to start.

>
> Cheers,
> Longman

Thanks
barry
