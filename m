Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7F738767C
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348500AbhERKaB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 06:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348403AbhERK35 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 06:29:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5923E61002;
        Tue, 18 May 2021 10:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621333720;
        bh=jROP8po3PHoJPLBp5hT2Ed99bWiPnCq4HCpYcHosU5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dY9PsWH41vfE039KOYtoNvZdPHH6YPaLsRb7+M8zabd1d0vgUxqVszgt/TZprtwM0
         T3RRwSL1dYA5bhMMrLFQ2YYY7iNnEZ8IJsk98eXclkbQwzwKP+1IIoWjyvD8k5Yjt7
         CSIgIxFWLZmRASIu5GxPgto9EUFcKDlRy93QWDNvrgagncMik/d2rNw8t5/5adn0r9
         jBnFnpnzhZzvwwqgepTmaP+5Aujk8j/ESQ4sr5ByqdjayE/Nd6rGh0SGqYwwDYl3NV
         FPSuZOKypWOTKxXqAYNfVsyqo1/hQIiEUaIvYbSCmyDOZrcAWRdKL9bPngvDpjdSq3
         LYc5HfQkozGmg==
Date:   Tue, 18 May 2021 11:28:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
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
Message-ID: <20210518102833.GA7770@willie-the-truck>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-14-will@kernel.org>
 <YKOU9onXUxVLPGaB@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKOU9onXUxVLPGaB@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[Dropping Li Zefan as his mail is bouncing]

On Tue, May 18, 2021 at 10:20:38AM +0000, Quentin Perret wrote:
> On Tuesday 18 May 2021 at 10:47:17 (+0100), Will Deacon wrote:
> > On asymmetric systems where the affinity of a task is restricted to
> > contain only the CPUs capable of running it, admission to the deadline
> > scheduler is likely to fail because the span of the sched domain
> > contains incompatible CPUs. Although this is arguably the right thing to
> > do, it is inconsistent with the case where the affinity of a task is
> > restricted after already having been admitted to the deadline scheduler.
> > 
> > For example, on an arm64 system where not all CPUs support 32-bit
> > applications, a 64-bit deadline task can exec() a 32-bit image and have
> > its affinity forcefully restricted.
> 
> So I guess the alternative would be to fail exec-ing into 32bit from a
> 64bit DL task, and then drop this patch?
> 
> The nice thing about your approach is that existing applications won't
> really notice a difference (execve would still 'work'), but on the cons
> side it breaks admission control, which is sad.

Right, with your suggestion here we would forbid any 32-bit deadline tasks
on an asymmetric system, even if you'd gone to the extraordinary effort
to cater for that (e.g. by having a separate root domain).

> I don't expect this weird execve-to-32bit pattern from DL to be that
> common in practice (at the very least not in Android), so maybe we could
> start with the stricter version (fail the execve), and wait to see if
> folks complain? Making things stricter later will be harder.
> 
> Thoughts?

I don't have strong opinions on this, but I _do_ want the admission via
sched_setattr() to be consistent with execve(). What you're suggesting
ticks that box, but how many applications are prepared to handle a failed
execve()? I suspect it will be fatal.

Probably also worth pointing out that the approach here will at least
warn in the execve() case when the affinity is overridden for a deadline
task.

Will
