Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6635339318F
	for <lists+linux-arch@lfdr.de>; Thu, 27 May 2021 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhE0O5S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 May 2021 10:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhE0O5S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 May 2021 10:57:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58404C061574;
        Thu, 27 May 2021 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h+ribFfVIk329pe0p3tIyYOdBOtZCkKF+HnqMs1ehyM=; b=WYGVpiEixpBSdl2wAok68xEwTI
        M8GhhPdN5o6HfOKT4cuaGbQBJh/k/AI8irIdK9XmR9tZ1WvddhlNhvAbyMxem4onjg9pO8T2PiCeI
        4D+Q7afmXuDAp1GQv5327Z5uWK7XlwLuRcKKjog0Ft0QulMDaMiqRRGY1APG9H1VuaHUv+0Rs8bZQ
        8TcblaHKv6zYdu78gOTaqFdQ9chtD1O2c6lLhPQvUVA+XFJCbFrMMC8UhCFZgeScnoiosnkunvHSq
        tQPWlLWAb/VJy+fq6tEmuGuxYxIx7KOyPYqj/wEdjIO8BC98Tsgq+2fFysrvSsGl45saCF3MSS4jq
        6OewL+bw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmHPz-00123b-6c; Thu, 27 May 2021 14:55:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2CDBC300221;
        Thu, 27 May 2021 16:55:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 127C12011BE77; Thu, 27 May 2021 16:55:33 +0200 (CEST)
Date:   Thu, 27 May 2021 16:55:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 16/22] sched: Defer wakeup in ttwu() for unschedulable
 frozen tasks
Message-ID: <YK+y5OE5N1FTkT/J@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-17-will@kernel.org>
 <YK+oSPlNQJKiMYYc@hirez.programming.kicks-ass.net>
 <YK+tV/DTNlpGJ7J8@hirez.programming.kicks-ass.net>
 <20210527144412.GB23086@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527144412.GB23086@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 27, 2021 at 03:44:12PM +0100, Will Deacon wrote:
> I'm not seeing how this handles tasks which weren't put in the freezer
> because they have PF_FREEZER_SKIP set. For these tasks, we need to make
> sure that they don't become runnable before we have onlined a core which
> is capable of running them, and this could occur because of any old
> wakeup (i.e. whatever it was that they blocked on).

I was under the impression that userspace tasks could not have
PF_FREEZER_SKIP set.. let me look harder.
