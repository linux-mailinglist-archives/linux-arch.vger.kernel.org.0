Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B7D14C474
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2020 02:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgA2Bjy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jan 2020 20:39:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37608 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgA2Bjx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jan 2020 20:39:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id v17so16730517ljg.4
        for <linux-arch@vger.kernel.org>; Tue, 28 Jan 2020 17:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4/ClYYJ+5YTTgIua33qLOnbZHxhbde9Yd+Epr2e4yE=;
        b=IT5+OqaWPelc9z2VULl83XxNj/7NowpOHZFU4nhYW8T24uKH/JOKHXgmjK3eGy1CKc
         1aNzJ0uf2K5syWkqTSVYUXMAzxQW/rli8DGH+ho4akKgsewUQ7Ctyzmu0I+MziI/Y0GO
         kiQh82G3dgvUsiGzEA3WNpJo8N++k1GDppFsx5RiXBFMBTVkrwqrwd5JrJQz4zVb11Cn
         5YhZigNsgW5uma91wXVJcN2/GG//BH3v0mCRmrOIH52SBCnqncxfYbNjvFilEhyMv6Zg
         aGDDoDADdLwTJ49rDhAG6W/nAGHZK36Xi/t6WB4p0O2qoK378FMwLwmgg26qsbKjulIn
         OABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4/ClYYJ+5YTTgIua33qLOnbZHxhbde9Yd+Epr2e4yE=;
        b=p0Ff90Cqg9SWnhvYgOTEeWSttLDdYASyRiuwEgS6OGZHlsmUHWvdebhn8UZJ4S9lGY
         NVmvqmPrZMBEtxgDPdD9OC9vr7xW3z9y114Z6gx5tfvghZeKIQv2qzMNDaSKBbnsLhXh
         EABuDU54UG/1pfvgcmPHSE4oVcTiYykIw/UWo2TIFhZWs1yp+yJXuUc4X7+gfeomh8To
         u9Lv3a7nMazJ5B9GM33GZIqndTitXwiYAOec/p6WhlKAU9bPKejIJPDbyoHj6GpcSMBA
         BQ4FnlTgKj55swHZyTkgIk9xeePjB5ZDTuwoxYndNzzO/960Wb4IgOjl7jtiX48cULPN
         lV+A==
X-Gm-Message-State: APjAAAWjCGSW7CzUS5F9TPapDyEHruoDMDoQzl/epdxM12den02Zv1VI
        ZqXOmcra5hKM6zFFjJBBIHaVc34QuYlTZOJJqtkfDg==
X-Google-Smtp-Source: APXvYqzsDL/zXrUdChz0I/F5naUgMjYLewZ+cychLHXTiyPNiyUzUhcyRqmIiYs7ji2jAVA4/Wc9SdlBZMHyZjmL/yc=
X-Received: by 2002:a2e:3e0d:: with SMTP id l13mr10931600lja.70.1580261990708;
 Tue, 28 Jan 2020 17:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20200115035920.54451-1-alex.kogan@oracle.com> <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
 <4F71A184-42C0-4865-9AAA-79A636743C25@oracle.com> <CAC4j=Y_SMHe4WNpaaS0kK1JYfnufM+AAiwwUMBx27L8U6bD8Yg@mail.gmail.com>
 <CAC4j=Y--5UQR7Oc5n+sxAwLxd_PKi0Eb-7aiZjDTUW0FTJy8Tw@mail.gmail.com> <25401561-CD1F-4FDC-AED5-256EBE56B9F6@oracle.com>
In-Reply-To: <25401561-CD1F-4FDC-AED5-256EBE56B9F6@oracle.com>
From:   Lihao Liang <lihaoliang@google.com>
Date:   Wed, 29 Jan 2020 01:39:38 +0000
Message-ID: <CAC4j=Y8ZiCeZdj2CFVoBMH2j-Nen5f5PM0nwg+MR5OgDk7Hybw@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, longman@redhat.com
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        Will Deacon <will@kernel.org>,
        Lihao Liang <lihao.liang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alex and Waiman,

On Mon, Jan 27, 2020 at 4:02 PM Alex Kogan <alex.kogan@oracle.com> wrote:
>
> Hi, Lihao.
>
> >>>
> >>>> This is particularly relevant
> >>>> in high contention situations when new threads keep arriving on the same
> >>>> socket as the lock holder.
> >>> In this case, the lock will stay on the same NUMA node/socket for
> >>> 2^numa_spinlock_threshold times, which is the worst case scenario if we
> >>> consider the long-term fairness. And if we have multiple nodes, it will take
> >>> up to 2^numa_spinlock_threshold X (nr_nodes - 1) + nr_cpus_per_node
> >>> lock transitions until any given thread will acquire the lock
> >>> (assuming 2^numa_spinlock_threshold > nr_cpus_per_node).
> >>>
> >>
> >> You're right that the latest version of the patch handles long-term fairness
> >> deterministically.
> >>
> >> As I understand it, the n-th thread in the main queue is guaranteed to
> >> acquire the lock after N lock handovers, where N is bounded by
> >>
> >> n - 1 + 2^numa_spinlock_threshold * (nr_nodes - 1)
> >>
> >> I'm not sure what role the variable nr_cpus_per_node plays in your analysis.
> >>
> >> Do I miss anything?
> >>
> >
> > If I understand correctly, there are two phases in the algorithm:
> >
> > MCS phase: when the secondary queue is empty, as explained in your emails,
> > the algorithm hands the lock to threads in the main queue in an FIFO order.
> > When probably(SHUFFLE_REDUCTION_PROB_ARG) returns false (with default
> > probability 1%), if the algorithm finds the first thread running on the same
> > socket as the lock holder in cna_scan_main_queue(), it enters the following
> > CNA phase
> Yep. When probably() returns false, we scan the main queue. If as the result of
> this scan the secondary queue becomes not empty, we enter what you call
> the CNA phase.
>

As I understand it, the probability of making a transition from the
MCS to CNA phase
in less than N lock handovers is 1 - p^N, where p is the probability
that probably()
returns true (default 99%). So in high contention situations where N can become
quite large in a relatively short period of time, the probability of
getting into the CNA
phase is high, e.g. 95% when N = 300.

I was wondering whether it would be possible to detect contention and make a
phase transition deterministically, maybe by reusing the intra_count
variable to keep
track of the processing rate in the MCS phase?

As Will pointed out earlier, this would make formal analysis and
verification of the
CNA qspinlock much more feasible.

> > .
> >
> > CNA phase: when the secondary queue is not empty, the algorithm keeps
> > handing the lock to threads in the main queue that run on the same socket as
> > the lock holder. When 2^numa_spinlock_threshold is reached, it splices
> > the secondary queue to the front of the main queue. And we are back to the
> > MCS phase above.
> Correct.
>
> > For the n-th thread T in the main queue, the MCS phase handles threads that
> > arrived in the main queue before T. In high contention situations, the CNA
> > phase handles two kinds of threads:
> >
> > 1. Threads ahead of T that run on the same socket as the lock holder when
> > a transition from the MCS to CNA phase was made. Assume there are m such
> > threads.
> >
> > 2. Threads that keep arriving on the same socket as the lock holder. There
> > are at most 2^numa_spinlock_threshold of them.
> >
> > Then the number of lock handovers in the CNA phase is max(m,
> > 2^numa_spinlock_threshold). So the total number of lock handovers before T
> > acquires the lock is at most
> >
> > n - 1 + 2^numa_spinlock_threshold * (nr_nodes - 1)
> >
> > Please let me know if I misunderstand anything.
> I think you got it right (modulo nr_cpus_per_node instead of n, as mentioned in
> my other response).
>

Make sense. Thanks a lot for the clarification :)

Best,
Lihao.
