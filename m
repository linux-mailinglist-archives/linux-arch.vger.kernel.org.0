Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB038C788
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhEUNN6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 09:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbhEUNN5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 May 2021 09:13:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D12CC061574
        for <linux-arch@vger.kernel.org>; Fri, 21 May 2021 06:12:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x8so21026728wrq.9
        for <linux-arch@vger.kernel.org>; Fri, 21 May 2021 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mAjk0S+UpNUqwhT8eJhAogvnWkfFNLPiDvekTv19GD0=;
        b=VsyUFe5OmlUqsGOd3dQwNCB0z0RSAQOBSADnYOEe8sMCMdFU3L7qSg9IxKF2qSqHAC
         cYlQoy1oWU4026exxAWAFhiuSoMQIp4wjir4+69ySxMrkpOHcWRuqrzz+Cqk8ucWqqNY
         a4Qugx3ZA31d6VPsCz7gxT73DESb551AVp6NEneY7m3ku41ubtKfDUNjplg4o9gt0QLf
         X/CnuF6kYo8x47LPlUposST5uxaGygy9i60H5dRvmXGrRttHzeMG8Q9ZtxR2s1E8P39/
         pFq4lPXvNgN2bHellK1jfvRWOTN90ZEA5Z8WCPslXN8SaFD2DpeMdDB81p50mMu+TcaC
         XJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mAjk0S+UpNUqwhT8eJhAogvnWkfFNLPiDvekTv19GD0=;
        b=OWe7upfErrZ7pEwuO/ecxePdBKQAw20rjNH+auIEsa+VG8NYbVOuPE1kitBgw0CERg
         b0vismNhCoq7BM/sn+SSf40FJ0wMiUYT31N2u9ysB0fDlsOa+Y5FTmSRS/i24eEoPE1V
         PSfQw0DmW8KmbdlywzJgsr3digJq4XyG7EtXzXg84pFE+PwIrrAIiJMkR2PukFMGE/bL
         rhAiXV9BEIbBoKMwMfoQRDWitX0yldE63r2AyAvCg0RVLA3kayLScoGcwyr6nRW1IZgD
         /1gnQB51AGk6O89rJpWHOT2SPTWKCBvIfYYWeEY1/LyL8J74P6oaoZb/DFkN5Nr5euYv
         Wwgg==
X-Gm-Message-State: AOAM531884snKpgfqmFcyMJhUfTDlDRNdXGZ/V08/DCsVory0cU+dtVZ
        QF4wwu4ia/O6HGTNrZ6PEOJmaQ==
X-Google-Smtp-Source: ABdhPJxwcRmT9rcPrheowVpO7PWRSo/GBx/N8FRmPc1y1zTxqeO9zVUG3ETKQYsgE+dKpqkobaTcxw==
X-Received: by 2002:a05:6000:4d:: with SMTP id k13mr9790235wrx.98.1621602751913;
        Fri, 21 May 2021 06:12:31 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id l18sm2067425wrt.97.2021.05.21.06.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 06:12:31 -0700 (PDT)
Date:   Fri, 21 May 2021 13:12:28 +0000
From:   Quentin Perret <qperret@google.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
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
Message-ID: <YKexvNwTbaLJd9Kl@google.com>
References: <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck>
 <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <20210520180138.GA10523@willie-the-truck>
 <YKdEX9uaQXy8g/S/@localhost.localdomain>
 <YKdsOBCjASzFSzLm@google.com>
 <YKdxxDfu81W28n1A@localhost.localdomain>
 <20210521103724.GA11680@willie-the-truck>
 <b7182444-1385-214f-4526-6e83be3d7f02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7182444-1385-214f-4526-6e83be3d7f02@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Friday 21 May 2021 at 15:00:42 (+0200), Daniel Bristot de Oliveira wrote:
> On 5/21/21 12:37 PM, Will Deacon wrote:
> > Interesting, thanks. Thinking about this some more, it strikes me that with
> > these silly asymmetric systems there could be an interesting additional
> > problem with hotplug and deadline tasks. Imagine the following sequence of
> > events:
> > 
> >   1. All online CPUs are 32-bit-capable
> >   2. sched_setattr() admits a 32-bit deadline task
> >   3. A 64-bit-only CPU is onlined
> 
> At the point 3, the global scheduler assumption is broken. For instance, in a
> system with four CPUs and five ready 32-bit-capable tasks, when the fifth CPU as
> added, the working conserving rule is violated because the five highest priority
> thread are not running (only four are) :-(.
> 
> So, at this point, for us to keep to the current behavior, the addition should
> be.. blocked? :-((
> 
> >   4. Some of the 32-bit-capable CPUs are offlined
> 
> Assuming that point 3 does not exist (i.e., all CPUs are 32-bit-capable). At
> this point, we will have an increase in the pressure on the 32-bit-capable CPUs.
> 
> This can also create bad effects for 64-bit tasks, as the "contended" 32-bit
> tasks will still be "queued" in a future time where they were supposed to be
> done (leaving time for the 64-bit tasks).
> 
> > I wonder if we can get into a situation where we think we have enough
> > bandwidth available, but in reality the 32-bit task is in trouble because
> > it can't make use of the 64-bit-only CPU.
> 
> I would have to think more, but there might be a case where this contended
> 32-bit tasks could cause deadline misses for the 64-bit too.
> 
> > If so, then it seems to me that admission control is really just
> > "best-effort" for 32-bit deadline tasks on these systems because it's based
> > on a snapshot in time of the available resources.
> 
> The admission test as is now is "best-effort" in the sense that it allows a
> workload higher than it could handle (it is necessary, but not sufficient AC).
> But it should not be considered "best-effort" because of violations in the
> working conserving property as a result of arbitrary affinities among tasks.
> Overall, we have been trying to close any "exception left" to this later case.
> 
> I know, it is a complex situation, I am just trying to illustrate our concerns,
> because, in the near future we might have a scheduler that handles arbitrary
> affinity correctly. But that might require us to stick to an AC. The AC is
> something precious for us.

FWIW, I agree with the above. As pointed out in another reply, this
looks like an existing bug and there is nothing specific to 32bits tasks
here.

But I don't think the existence of this bug should be a reason for
breaking AC even more than it is. So it still feels cleaner to block
execve() into 32bit if AC is on until we have proper support for
affinities in DL. And if folks want to use 32bit DL tasks on these
systems they'll have to disable AC, but at least they know what they are
getting ...

Thanks,
Quentin
