Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B079149853
	for <lists+linux-arch@lfdr.de>; Sun, 26 Jan 2020 01:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgAZAcl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jan 2020 19:32:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40010 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgAZAcl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jan 2020 19:32:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18so6904678ljo.7
        for <linux-arch@vger.kernel.org>; Sat, 25 Jan 2020 16:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bwME4l4EJ6oZ8cjrQesmcLreWjxQta3M1Gv1X7S2+NY=;
        b=WX0tMtclJs/LJDkjtQA30eyVDlONVFUD9AJSP870n9xXtNaiUQ9/w+NHTT/MrCxdn/
         k+sGc3DDZc+YFnAMtWt10RFUxKXQNhzyjKmgAkzHHWGJLgkZMUqsVk51hr8nxgf92Exy
         H3QZlOjccPfM+EkeIFx9hE25eEPLQaxeT20usw82uyuHd87IC+o2l9UkX3wLSIzLjG+2
         NoTB6IggXHZDL1LK4Z9Lm0YYZS5ACZu5hw2ATihuzIdlNgXynL4u5UMSOo9VePOEploP
         H+seCHqzlIYGxgTEJdNa72RSoBs2JQSkmbxuhuaRZCRCDtj8Iv/pHb7NbZrhkB+p2NEu
         /rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bwME4l4EJ6oZ8cjrQesmcLreWjxQta3M1Gv1X7S2+NY=;
        b=rw4bfDqAv0xq+Q+53YYXzsEmIY2Yn8CI+buZY//isUTgVF5m9AgNkXUqzrC4iA9VjG
         ChJI1aN/U8WBF/X1y/HqTAMNpdIQS6HFXDgNcXFetTqGeHs5Ehob3+Z2z74J+EL7sQT6
         1pJvuY0POs46iOkD6ugDvV0J169YhHgby7luflbNl6amjh4LpgdSHT3eQrs4+JMHuCSc
         gEOvI79s4VCbt7+iMLhE9kOUDYWyrckViyN3W3g5U48DAtC4teVTYQ6XAjRSFaNrDSza
         kG038VSeH+/MBXYlnyuT3Xr28/bQNn6PFeFRCt5Zw8nGFrnn/Tnj3VzNTAYsH9k4oC5G
         d04A==
X-Gm-Message-State: APjAAAVFc9yBhN33yHTkrudrpgMrLUEfFkOU6LyueIyyu8rA3mIAgsw7
        FL8M+tKcU2jyz/VWXQYYIZq0oTcxe8y9cJt8UVhNVQ==
X-Google-Smtp-Source: APXvYqwdyZCQ+1g7pWUu8b3HV1fpGTluvmsD4O1UOCtJ24Bhz8zFImZoK7A4i7GNgyZ34ldyCjZyEe64BVBSE0ZO99Y=
X-Received: by 2002:a2e:7009:: with SMTP id l9mr5996081ljc.96.1579998757482;
 Sat, 25 Jan 2020 16:32:37 -0800 (PST)
MIME-Version: 1.0
References: <20200115035920.54451-1-alex.kogan@oracle.com> <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
 <4F71A184-42C0-4865-9AAA-79A636743C25@oracle.com>
In-Reply-To: <4F71A184-42C0-4865-9AAA-79A636743C25@oracle.com>
From:   Lihao Liang <lihaoliang@google.com>
Date:   Sun, 26 Jan 2020 00:32:26 +0000
Message-ID: <CAC4j=Y_SMHe4WNpaaS0kK1JYfnufM+AAiwwUMBx27L8U6bD8Yg@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alex and Waiman,

Thanks a lot for your swift response and clarification.

On Wed, Jan 22, 2020 at 7:30 PM Alex Kogan <alex.kogan@oracle.com> wrote:
>
> Hi, Lihao.
>
> > On Jan 22, 2020, at 6:45 AM, Lihao Liang <lihaoliang@google.com> wrote:
> >
> > Hi Alex,
> >
> > On Wed, Jan 22, 2020 at 10:28 AM Alex Kogan <alex.kogan@oracle.com> wro=
te:
> >>
> >> Summary
> >> -------
> >>
> >> Lock throughput can be increased by handing a lock to a waiter on the
> >> same NUMA node as the lock holder, provided care is taken to avoid
> >> starvation of waiters on other NUMA nodes. This patch introduces CNA
> >> (compact NUMA-aware lock) as the slow path for qspinlock. It is
> >> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
> >>
> >
> > Thanks for your patches. The experimental results look promising!
> >
> > I understand that the new CNA qspinlock uses randomization to achieve
> > long-term fairness, and provides the numa_spinlock_threshold parameter
> > for users to tune.
> This has been the case in the first versions of the series, but is not tr=
ue anymore.
> That is, the long-term fairness is achieved deterministically (and you ar=
e correct
> that it is done through the numa_spinlock_threshold parameter).
>
> > As Linux runs extremely diverse workloads, it is not
> > clear how randomization affects its fairness, and how users with
> > different requirements are supposed to tune this parameter.
> >
> > To this end, Will and I consider it beneficial to be able to answer the
> > following question:
> >
> > With different values of numa_spinlock_threshold and
> > SHUFFLE_REDUCTION_PROB_ARG, how long do threads running on different
> > sockets have to wait to acquire the lock?
> The SHUFFLE_REDUCTION_PROB_ARG parameter is intended for performance
> optimization only, and *does not* affect the long-term fairness (or, at t=
he
> very least, does not make it any worse). As Longman correctly pointed out=
 in
> his response to this email, the shuffle reduction optimization is relevan=
t only
> when the secondary queue is empty. In that case, CNA hands-off the lock
> exactly as MCS does, i.e., in the FIFO order. Note that when the secondar=
y
> queue is not empty, we do not call probably().
>
> > This is particularly relevant
> > in high contention situations when new threads keep arriving on the sam=
e
> > socket as the lock holder.
> In this case, the lock will stay on the same NUMA node/socket for
> 2^numa_spinlock_threshold times, which is the worst case scenario if we
> consider the long-term fairness. And if we have multiple nodes, it will t=
ake
> up to 2^numa_spinlock_threshold X (nr_nodes - 1) + nr_cpus_per_node
> lock transitions until any given thread will acquire the lock
> (assuming 2^numa_spinlock_threshold > nr_cpus_per_node).
>

You're right that the latest version of the patch handles long-term fairnes=
s
deterministically.

As I understand it, the n-th thread in the main queue is guaranteed to
acquire the lock after N lock handovers, where N is bounded by

n - 1 + 2^numa_spinlock_threshold * (nr_nodes - 1)

I'm not sure what role the variable nr_cpus_per_node plays in your analysis=
.

Do I miss anything?

Many thanks,
Lihao.

> Hopefully, it addresses your concern. Let me know if you have any further
> questions.
>
> Best regards,
> =E2=80=94 Alex
>
