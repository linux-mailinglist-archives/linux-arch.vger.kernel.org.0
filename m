Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F1B38C21B
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhEUIlD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 04:41:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233446AbhEUIlB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 04:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621586378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SIGUda3zFfWUzAh5vPjq/XAaI8wuK0BcxP3Vanw6sXM=;
        b=dQL6fZ1+nBW5NF/17rEr4V+COyjV9q6kLTln/JHWqtamCnFTMy6sKyEV8/2I1OGsyAbvul
        x4ih/HI20AfusBaSnYdvNcULsyCTPOGoz7QstA41rApjRCRxm2gyZf4rXfwfTm7dluh2zA
        sDGqicOnNS7Q3qqSBSBq6xLz1VoB7pc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-RAR4gnToPnef0_c6PVLc7g-1; Fri, 21 May 2021 04:39:36 -0400
X-MC-Unique: RAR4gnToPnef0_c6PVLc7g-1
Received: by mail-ej1-f71.google.com with SMTP id w13-20020a170906384db02903d9ad6b26d8so4049228ejc.0
        for <linux-arch@vger.kernel.org>; Fri, 21 May 2021 01:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SIGUda3zFfWUzAh5vPjq/XAaI8wuK0BcxP3Vanw6sXM=;
        b=RyFwgaxiKC1ykXOxb05qjo59r2WPyPiHrJyvS6y/Tlp3/XlHan2IjdHcLPxuangsRm
         O71MlNMKw7K0OrqC/Gian3jlfQMHOf09/cSR5qzsggZ69hW6fW9lqfA0h0MAGoS1mzRT
         NbA4pQcYXlwcIuTMT/ji0CbDEQcNodSyyQzjlT2fwY0xXSSq3UVVGRsTqiqsA4r7Bvya
         eWh6iJZb3EiFzPuI/o0pt/rVTePyUj4Zo+DU4pXcRv81Pvu9pIcZGCOlv8LPx3zRVIab
         Lqne6MmW84jZWh7UIHXQ7sWmsLP/bbZGnMa4sytRo2Tdkdbm7+tMMnhywCYDwIg561H3
         LHeg==
X-Gm-Message-State: AOAM532KTSorIM9D0OHjO6cfca3A9RPS/9+/8HxQmV21iHnm7emYXWQC
        fIp/YbPOm2BlCrlt6pMaVsm7n6bHYVbq1ExXzeiY6pb8Ru6n4Y8b3tfpmrOIgfXQQ57g0KKB76V
        4sl+fqTtoF6nAfFnYoOrkCg==
X-Received: by 2002:a17:906:c352:: with SMTP id ci18mr9001140ejb.149.1621586375374;
        Fri, 21 May 2021 01:39:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdd5WRAKk/AQzDdmZXxSEP43ND8VjF/XIffF9cLdHoFc07C/2r7v1/7V15PQS5O81Wo7ngWQ==
X-Received: by 2002:a17:906:c352:: with SMTP id ci18mr9001125ejb.149.1621586375131;
        Fri, 21 May 2021 01:39:35 -0700 (PDT)
Received: from localhost.localdomain ([151.29.18.58])
        by smtp.gmail.com with ESMTPSA id d5sm3444716edt.49.2021.05.21.01.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 01:39:34 -0700 (PDT)
Date:   Fri, 21 May 2021 10:39:32 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <YKdxxDfu81W28n1A@localhost.localdomain>
References: <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com>
 <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck>
 <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <20210520180138.GA10523@willie-the-truck>
 <YKdEX9uaQXy8g/S/@localhost.localdomain>
 <YKdsOBCjASzFSzLm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKdsOBCjASzFSzLm@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 21/05/21 08:15, Quentin Perret wrote:
> On Friday 21 May 2021 at 07:25:51 (+0200), Juri Lelli wrote:
> > On 20/05/21 19:01, Will Deacon wrote:
> > > On Thu, May 20, 2021 at 02:38:55PM +0200, Daniel Bristot de Oliveira wrote:
> > > > On 5/20/21 12:33 PM, Quentin Perret wrote:
> > > > > On Thursday 20 May 2021 at 11:16:41 (+0100), Will Deacon wrote:
> > > > >> Ok, thanks for the insight. In which case, I'll go with what we discussed:
> > > > >> require admission control to be disabled for sched_setattr() but allow
> > > > >> execve() to a 32-bit task from a 64-bit deadline task with a warning (this
> > > > >> is probably similar to CPU hotplug?).
> > > > > 
> > > > > Still not sure that we can let execve go through ... It will break AC
> > > > > all the same, so it should probably fail as well if AC is on IMO
> > > > > 
> > > > 
> > > > If the cpumask of the 32-bit task is != of the 64-bit task that is executing it,
> > > > the admission control needs to be re-executed, and it could fail. So I see this
> > > > operation equivalent to sched_setaffinity(). This will likely be true for future
> > > > schedulers that will allow arbitrary affinities (AC should run on affinity
> > > > change, and could fail).
> > > > 
> > > > I would vote with Juri: "I'd go with fail hard if AC is on, let it
> > > > pass if AC is off (supposedly the user knows what to do)," (also hope nobody
> > > > complains until we add better support for affinity, and use this as a motivation
> > > > to get back on this front).
> > > 
> > > I can have a go at implementing it, but I don't think it's a great solution
> > > and here's why:
> > > 
> > > Failing an execve() is _very_ likely to be fatal to the application. It's
> > > also very likely that the task calling execve() doesn't know whether the
> > > program it's trying to execute is 32-bit or not. Consequently, if we go
> > > with failing execve() then all that will happen is that people will disable
> > > admission control altogether.
> 
> Right, but only on these dumb 32bit asymmetric systems, and only if we
> care about running 32bits deadline tasks -- which I seriously doubt for
> the Android use-case.
> 
> Note that running deadline tasks is also a privileged operation, it
> can't be done by random apps.
> 
> > > That has a negative impact on "pure" 64-bit
> > > applications and so I think we end up with the tail wagging the dog because
> > > admission control will be disabled for everybody just because there is a
> > > handful of 32-bit programs which may get executed. I understand that it
> > > also means that RT throttling would be disabled.
> > 
> > Completely understand your perplexity. But how can the kernel still give
> > guarantees to "pure" 64-bit applications if there are 32-bit
> > applications around that essentially broke admission control when they
> > were restricted to a subset of cores?
> > 
> > > Allowing the execve() to continue with a warning is very similar to the
> > > case in which all the 64-bit CPUs are hot-unplugged at the point of
> > > execve(), and this is much closer to the illusion that this patch series
> > > intends to provide.
> > 
> > So, for hotplug we currently have a check that would make hotplug
> > operations fail if removing a CPU would mean not enough bandwidth to run
> > the currently admitted set of DEADLINE tasks.
> 
> Aha, wasn't aware. Any pointers to that check for my education?

Hotplug ends up calling dl_cpu_busy() (after the cpu being hotplugged out
got removed), IIRC. So, if that fails the operation in undone.

> > > So, personally speaking, I would prefer the behaviour where we refuse to
> > > admit 32-bit tasks vioa sched_set_attr() if the root domain contains
> > > 64-bit CPUs, but we _don't_ fail execve() of a 32-bit program from a
> > > 64-bit deadline task.
> > 
> > OK, this is interesting and I guess a very valid alternative. That would
> > force users to create exclusive domains for 32-bit tasks, right?
> 
> FWIW this is not practical at all for our use-cases, the implications of
> splitting the system in independent root-domains are way too important
> for us to be able to recommend that. Disabling AC, OTOH, sounds simple
> enough. The RT throttling part is the only 'worrying' part, but even
> that may not be the end of the world.

Note that RT throttling (SCHED_{FIFO,RR}) is not handled by DEADLINE
servers yet.

Best,
Juri

