Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3531A393177
	for <lists+linux-arch@lfdr.de>; Thu, 27 May 2021 16:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhE0OxS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 May 2021 10:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhE0OxP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 May 2021 10:53:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58691C061574;
        Thu, 27 May 2021 07:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=npPt/wweDD4gAB4M4/7EGJsgjBLetKg+ztbe714ojBI=; b=OFjWhLUkQrqv2SnNjS8xOO9wI2
        AMs5Ygrsa+ZgSvyCvnHpZwTIX8sH7eQSlZyqVAaMthIQ1449j49eiH+OiNIIEE5ivHZbK8EpsvZvn
        kDeWsEa6amY3VJaPkCsu6OQx0mzSAeG+/wh3Tshe5rTa2dPMYqvEegtbQy/i8kximwzXQiK1nw4QF
        TF77C+MAPmLPBWcNmdEq9Q6+z1el34oN6iJXvxpLlaFhJkITsoA4hd6PAQmbcvQtAsCZiG4m6nz5Q
        01RKYnYeXcPaI3FjTO2EexNqa5X/Y09r5E9+OGyfDW8M0mvoFIMT/XHPrZZ3ys7psTIyzrjNQR8a3
        AwyAB1PQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lmHLg-005dw6-4v; Thu, 27 May 2021 14:51:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1076B300221;
        Thu, 27 May 2021 16:50:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9AFA2018A4FC; Thu, 27 May 2021 16:50:58 +0200 (CEST)
Date:   Thu, 27 May 2021 16:50:58 +0200
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
Message-ID: <YK+x0tA/Xlm+N/vw@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-17-will@kernel.org>
 <YK+oSPlNQJKiMYYc@hirez.programming.kicks-ass.net>
 <YK+tV/DTNlpGJ7J8@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK+tV/DTNlpGJ7J8@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 27, 2021 at 04:31:51PM +0200, Peter Zijlstra wrote:
> @@ -149,7 +144,7 @@ void __thaw_task(struct task_struct *p)
>  
>  	spin_lock_irqsave(&freezer_lock, flags);
>  	if (frozen(p))
> -		wake_up_process(p);
> +		wake_up_state(p, TASK_FROZEN);

Possibly, that wants | TASK_NORMAL added.

>  	spin_unlock_irqrestore(&freezer_lock, flags);
>  }
