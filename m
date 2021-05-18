Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AD43879BD
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhERNVO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 09:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242855AbhERNVN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 09:21:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578B0C061573
        for <linux-arch@vger.kernel.org>; Tue, 18 May 2021 06:19:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h4so10172986wrt.12
        for <linux-arch@vger.kernel.org>; Tue, 18 May 2021 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fl2hbnq4KTo11sm1rurPAiZ5nl2ffJf+gTd0frGhNMo=;
        b=m5PLNpLU1FyFg7I9oj9BuALAC/QcWw5Dv8rvdXmUmFEOzVPqJWjuRNhWM1uIeiKauB
         5CSLYCGqNyCCv6dV/WFrfWKU8lsgWPQySSv6artDRUhvhuVYinu6tdaHXBcqdiDOXr/e
         3ZO/6MmqSw4OwF1PI3r7AZFvMyXuIpnhBOSuBY5u7AutQcyvyK2aLTnabPKr2U8rSq9E
         ma0YawdRqqf8fN8/3O7iHBKuA43jq2QBiwjKTGCOmB71PO2ua9kX2q1+RGwIJ7NFpQ05
         85/jXgJA5boxxDLSGzic4iYHMnBeG9zYXW1VcckhRDuFfCswW2pUzfgAijFGfKUB2FDi
         IyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fl2hbnq4KTo11sm1rurPAiZ5nl2ffJf+gTd0frGhNMo=;
        b=pbCM/X7+MGNmMlVnGyST1Kj4679mgrwSieOvA3ID0PbRRw3PqSRizJRGUN2M9ZfH4l
         BtH0bAO41nM0TQinpqjjqu+LimkDJDcsur7Z8wTFUUPUa4bsJNye1RqPpLfS6Vhhb8ey
         v/8CgfVRrOhZmuxlSJFWb70/g32vDkGcC0+uajIgSDI+u4hsumc+IwWwg7p228jSmUga
         43a4mfj+Zf3ST28zEHlIoOd3c0Auh2fuTu9i/HGjMtCpxJgRWd7bK3J+QqPB5k4Rvrg/
         0NYz++8YMj+LgJhEUTBfWN7/ufpxj/BYpLZsAr0ChBMfL/hwOV2LaoICNadg+uNsEXfR
         9feg==
X-Gm-Message-State: AOAM532aK6WjPdYTqZ4RkV3hHD/kanhDjg5mq499CkEE6lH7c+XfGikM
        NKSCbrxN6Cuzmr+/kz4WuqxmVg==
X-Google-Smtp-Source: ABdhPJwtEm2cBRiEIt+snvROWKnxUOfuHq73a7rNECr6Qw9eykwLa7rdlkW34cJYL3rFLTjdPydmaA==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr7053213wrq.112.1621343993969;
        Tue, 18 May 2021 06:19:53 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id x8sm21590597wrs.25.2021.05.18.06.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 06:19:53 -0700 (PDT)
Date:   Tue, 18 May 2021 13:19:50 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
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
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <YKO+9lPLQLPm4Nwt@google.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-14-will@kernel.org>
 <YKOU9onXUxVLPGaB@google.com>
 <20210518102833.GA7770@willie-the-truck>
 <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518105951.GC7770@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tuesday 18 May 2021 at 11:59:51 (+0100), Will Deacon wrote:
> On Tue, May 18, 2021 at 10:48:07AM +0000, Quentin Perret wrote:
> > On Tuesday 18 May 2021 at 11:28:34 (+0100), Will Deacon wrote:
> > > I don't have strong opinions on this, but I _do_ want the admission via
> > > sched_setattr() to be consistent with execve(). What you're suggesting
> > > ticks that box, but how many applications are prepared to handle a failed
> > > execve()? I suspect it will be fatal.
> > 
> > Yep, probably.
> > 
> > > Probably also worth pointing out that the approach here will at least
> > > warn in the execve() case when the affinity is overridden for a deadline
> > > task.
> > 
> > Right so I think either way will be imperfect, so I agree with the
> > above.
> > 
> > Maybe one thing though is that, IIRC, userspace _can_ disable admission
> > control if it wants to. In this case I'd have no problem with allowing
> > this weird behaviour when admission control is off -- the kernel won't
> > provide any guarantees. But if it's left on, then it's a different
> > story.
> > 
> > So what about we say, if admission control is off, we allow execve() and
> > sched_setattr() with appropriate warnings as you suggest, but if
> > admission control is on then we fail both?
> 
> That's an interesting idea. The part that I'm not super keen about is
> that it means admission control _also_ has an effect on the behaviour of
> execve()

Right, that's a good point. And it looks like fork() behaves the same
regardless of admission control being enabled or not -- it is forbidden
from DL either way. So I can't say there is a precedent :/

> so practically you'd have to have it disabled as long as you
> have the possibility of 32-bit deadline tasks anywhere in the system,
> which impacts 64-bit tasks which may well want admission control enabled.

Indeed, this is a bit sad, but I don't know if the kernel should pretend
it can guarantee to meet your deadlines and at the same time allow to do
something that wrecks the underlying theory.

I'd personally be happy with saying that admission control should be
disabled on these dumb systems (and have that documented), at least
until DL gets proper support for affinities. ISTR there was work going
in that direction, but some folks in the CC list will know better.

@Juri, maybe you would know if that's still planned?

Thanks,
Quentin
