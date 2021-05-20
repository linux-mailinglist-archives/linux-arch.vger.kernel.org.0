Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818A638A0A4
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 11:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhETJPH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 05:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230469AbhETJPG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 05:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621502025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=59HPsGZmbzpogUicaNHmrUD8Ii9KkB0f2xmqCHspsTo=;
        b=LQAZUEv5YMShFMGwZ7wluDVqOj9HbUIVSk90lyzrNkx5EbNxblVFq09Ot0PXRRj0Mmyy7b
        6gLgUItsgFMt4UsGjLmG8GFwC8unbMMagx8wiu/zouHCQQFTyyVE1tvRmGECWk0s9LxXT/
        6GsmQNeda6/3IoDAPMc+jX9OYbHFc4U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-IL4rFM8UNl-X4ObAQCDUvw-1; Thu, 20 May 2021 05:13:44 -0400
X-MC-Unique: IL4rFM8UNl-X4ObAQCDUvw-1
Received: by mail-ej1-f70.google.com with SMTP id w13-20020a170906384db02903d9ad6b26d8so2855689ejc.0
        for <linux-arch@vger.kernel.org>; Thu, 20 May 2021 02:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=59HPsGZmbzpogUicaNHmrUD8Ii9KkB0f2xmqCHspsTo=;
        b=X49t1Udq0p7IQvZxfGCUiPUduXQ6MZGy2Eb3VusUBNphnfVu5PGJPShLe3aH5sQxdp
         QBS/DNEoiWvOrLanYNBSwFELkAlzQqztPY4Do1zRvUPXzdV4y8odDwjBNQgR69tMLQGY
         ge+82feHpyfMx3p9Rc6XzvAjhtw4zJfu7/PlF7+lEnE2NEIWTmoTTmh0UYToBvS+SKSe
         z3OTPPSOgIwUiP3kAqGA5TSi+EkL7B1qCc1clkJJAOOcNGWIrsGlf7CoQUKyIzuF9e3F
         hTO/z7gVLh9alBDwiIYiGdukd1SB/u3ON/94JxkUoJDbcZaBxlBtYGaeJAS7yroNKKJK
         jYtQ==
X-Gm-Message-State: AOAM5302EwkIgvWIzOidc9jCc4qJqPNWHx4Bv5t2MNt2ECVjaqGKcmc1
        pcc4Q3MnEc3Aos2Hk4YPzZjT0+iioCnA5eABW9VXbslnZhFA5p7swDNAHy8qmlxMxPFVEDUYtQh
        XTeDQuKzJ/kSTXFMI/EGLZg==
X-Received: by 2002:aa7:cf03:: with SMTP id a3mr3881010edy.314.1621502022602;
        Thu, 20 May 2021 02:13:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO5bplhisfH9RW1Z9F0sJ6j+LdGZBEEI9k9SIWx/hvQL387V2z51rP68w514cHUGZf41f4WQ==
X-Received: by 2002:aa7:cf03:: with SMTP id a3mr3880983edy.314.1621502022394;
        Thu, 20 May 2021 02:13:42 -0700 (PDT)
Received: from localhost.localdomain ([151.29.18.58])
        by smtp.gmail.com with ESMTPSA id gt12sm1047058ejb.60.2021.05.20.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 02:13:41 -0700 (PDT)
Date:   Thu, 20 May 2021 11:13:39 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Will Deacon <will@kernel.org>,
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <YKYoQ0ezahSC/RAg@localhost.localdomain>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-14-will@kernel.org>
 <YKOU9onXUxVLPGaB@google.com>
 <20210518102833.GA7770@willie-the-truck>
 <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKO+9lPLQLPm4Nwt@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Quentin and Will,

Apologies for the delay in replying.

On 18/05/21 13:19, Quentin Perret wrote:
> On Tuesday 18 May 2021 at 11:59:51 (+0100), Will Deacon wrote:
> > On Tue, May 18, 2021 at 10:48:07AM +0000, Quentin Perret wrote:
> > > On Tuesday 18 May 2021 at 11:28:34 (+0100), Will Deacon wrote:
> > > > I don't have strong opinions on this, but I _do_ want the admission via
> > > > sched_setattr() to be consistent with execve(). What you're suggesting
> > > > ticks that box, but how many applications are prepared to handle a failed
> > > > execve()? I suspect it will be fatal.
> > > 
> > > Yep, probably.
> > > 
> > > > Probably also worth pointing out that the approach here will at least
> > > > warn in the execve() case when the affinity is overridden for a deadline
> > > > task.
> > > 
> > > Right so I think either way will be imperfect, so I agree with the
> > > above.
> > > 
> > > Maybe one thing though is that, IIRC, userspace _can_ disable admission
> > > control if it wants to. In this case I'd have no problem with allowing
> > > this weird behaviour when admission control is off -- the kernel won't
> > > provide any guarantees. But if it's left on, then it's a different
> > > story.
> > > 
> > > So what about we say, if admission control is off, we allow execve() and
> > > sched_setattr() with appropriate warnings as you suggest, but if
> > > admission control is on then we fail both?
> > 
> > That's an interesting idea. The part that I'm not super keen about is
> > that it means admission control _also_ has an effect on the behaviour of
> > execve()
> 
> Right, that's a good point. And it looks like fork() behaves the same
> regardless of admission control being enabled or not -- it is forbidden
> from DL either way. So I can't say there is a precedent :/
> 
> > so practically you'd have to have it disabled as long as you
> > have the possibility of 32-bit deadline tasks anywhere in the system,
> > which impacts 64-bit tasks which may well want admission control enabled.
> 
> Indeed, this is a bit sad, but I don't know if the kernel should pretend
> it can guarantee to meet your deadlines and at the same time allow to do
> something that wrecks the underlying theory.
> 
> I'd personally be happy with saying that admission control should be
> disabled on these dumb systems (and have that documented), at least
> until DL gets proper support for affinities. ISTR there was work going
> in that direction, but some folks in the CC list will know better.
> 
> @Juri, maybe you would know if that's still planned?

I won't go as far as saying planned, but that is still under "our" radar
for sure. Daniel was working on it, but I don't think he had any time to
resume that bit of work lately.

So, until we have that, I think we have been as conservative as we could
for this type of decisions. I'm a little afraid that allowing
configuration to break admission control (even with a non fatal warning
is emitted) is still risky. I'd go with fail hard if AC is on, let it
pass if AC is off (supposedly the user knows what to do). But I'm not
familiar with the mixed 32/64 apps usecase you describe, so I might be
missing details.

Best,
Juri

