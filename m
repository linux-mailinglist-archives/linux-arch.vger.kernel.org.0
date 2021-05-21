Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB70438BDDC
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 07:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhEUF1V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 01:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhEUF1V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 01:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621574758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NN95LuSG9lt6UBs1OZNbmtIU5UiQ0VNWpg97nfPRDng=;
        b=h+JknRU4aufXddGScpDwIyQnvGDZ9v1Ot8A89liXULljcZH4DG18atx7vqZ5FYwEJcqXhv
        QhY/ejudtqsXmRtPSaBsFxJaozurUCjkmLpr3sujq0qJIEqK3M5boR+460IYSze936fAtO
        okx8+2oq2JPgKf7u4NBgHYM0FdAkFIo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-1-kqt142O-CiY634dbW_Hw-1; Fri, 21 May 2021 01:25:56 -0400
X-MC-Unique: 1-kqt142O-CiY634dbW_Hw-1
Received: by mail-ed1-f70.google.com with SMTP id i3-20020aa7dd030000b029038ce772ffe4so10796850edv.12
        for <linux-arch@vger.kernel.org>; Thu, 20 May 2021 22:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NN95LuSG9lt6UBs1OZNbmtIU5UiQ0VNWpg97nfPRDng=;
        b=VX5maovZmBwQHWN5ynxGq4Zl3T/zssU4tkS4V1zK8C7f/MdWEEY00g2gjTikziZp3G
         Ti25c5SI9zNA81vcm08YIjg0LfYtjG0y+UvEooBnj65PPNpjoaCmcM+2WD7g7+bSZxgQ
         Hm49attSrYPd3L7lYFeRPY4BWNXiMCzT1Dv53xQu310qqAENy+Jl2xD2hKaK6Fk8xvh6
         GgN6lziFPWuGyux242vYyYRie9iM4NCbAfX+DX/SzOChrEnt+X4jO0TtZHGLllWAmX+X
         udaxzW4a3Gdp5E6NB33YaWy+ij0Ra2Mx2/xFwHYm07pCWpAsA6qwccG0AAXDhWkSxOi5
         stGg==
X-Gm-Message-State: AOAM532ioOugT51ucgr1RN5NhVPACANGn8iGVyEz47eYOBBPYXWD+SXG
        xCHWFOJojiH61L+CJo2RQN/mExzG92i05aWEo02fLXo4k40kteYjSLVH2Jb/MUOF40SXVtUps9D
        D6ADrBms9E5wckPDneYRd7A==
X-Received: by 2002:a05:6402:5201:: with SMTP id s1mr9159623edd.86.1621574754961;
        Thu, 20 May 2021 22:25:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDj2qLE+eU39++y33z008QMpxv+OzxdP+Z0YeDDYLpbTGKarkq8rqlJ9w1DYybMGwzhh4fWQ==
X-Received: by 2002:a05:6402:5201:: with SMTP id s1mr9159602edd.86.1621574754772;
        Thu, 20 May 2021 22:25:54 -0700 (PDT)
Received: from localhost.localdomain ([151.29.18.58])
        by smtp.gmail.com with ESMTPSA id c3sm3217847edn.16.2021.05.20.22.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 22:25:54 -0700 (PDT)
Date:   Fri, 21 May 2021 07:25:51 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Quentin Perret <qperret@google.com>,
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
Message-ID: <YKdEX9uaQXy8g/S/@localhost.localdomain>
References: <YKOU9onXUxVLPGaB@google.com>
 <20210518102833.GA7770@willie-the-truck>
 <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com>
 <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck>
 <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <20210520180138.GA10523@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520180138.GA10523@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 20/05/21 19:01, Will Deacon wrote:
> On Thu, May 20, 2021 at 02:38:55PM +0200, Daniel Bristot de Oliveira wrote:
> > On 5/20/21 12:33 PM, Quentin Perret wrote:
> > > On Thursday 20 May 2021 at 11:16:41 (+0100), Will Deacon wrote:
> > >> Ok, thanks for the insight. In which case, I'll go with what we discussed:
> > >> require admission control to be disabled for sched_setattr() but allow
> > >> execve() to a 32-bit task from a 64-bit deadline task with a warning (this
> > >> is probably similar to CPU hotplug?).
> > > 
> > > Still not sure that we can let execve go through ... It will break AC
> > > all the same, so it should probably fail as well if AC is on IMO
> > > 
> > 
> > If the cpumask of the 32-bit task is != of the 64-bit task that is executing it,
> > the admission control needs to be re-executed, and it could fail. So I see this
> > operation equivalent to sched_setaffinity(). This will likely be true for future
> > schedulers that will allow arbitrary affinities (AC should run on affinity
> > change, and could fail).
> > 
> > I would vote with Juri: "I'd go with fail hard if AC is on, let it
> > pass if AC is off (supposedly the user knows what to do)," (also hope nobody
> > complains until we add better support for affinity, and use this as a motivation
> > to get back on this front).
> 
> I can have a go at implementing it, but I don't think it's a great solution
> and here's why:
> 
> Failing an execve() is _very_ likely to be fatal to the application. It's
> also very likely that the task calling execve() doesn't know whether the
> program it's trying to execute is 32-bit or not. Consequently, if we go
> with failing execve() then all that will happen is that people will disable
> admission control altogether. That has a negative impact on "pure" 64-bit
> applications and so I think we end up with the tail wagging the dog because
> admission control will be disabled for everybody just because there is a
> handful of 32-bit programs which may get executed. I understand that it
> also means that RT throttling would be disabled.

Completely understand your perplexity. But how can the kernel still give
guarantees to "pure" 64-bit applications if there are 32-bit
applications around that essentially broke admission control when they
were restricted to a subset of cores?

> Allowing the execve() to continue with a warning is very similar to the
> case in which all the 64-bit CPUs are hot-unplugged at the point of
> execve(), and this is much closer to the illusion that this patch series
> intends to provide.

So, for hotplug we currently have a check that would make hotplug
operations fail if removing a CPU would mean not enough bandwidth to run
the currently admitted set of DEADLINE tasks.

> So, personally speaking, I would prefer the behaviour where we refuse to
> admit 32-bit tasks vioa sched_set_attr() if the root domain contains
> 64-bit CPUs, but we _don't_ fail execve() of a 32-bit program from a
> 64-bit deadline task.

OK, this is interesting and I guess a very valid alternative. That would
force users to create exclusive domains for 32-bit tasks, right?

> However, you're the deadline experts so ultimately I'll implement what
> you prefer. I just wanted to explain why I think it's a poor interface.
> 
> Have I changed anybody's mind?

Partly! :)

Thanks a lot for the discussion so far.

Juri

