Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6F21EC03
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgGNJBr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 05:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNJBq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 05:01:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BDEC061755;
        Tue, 14 Jul 2020 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IEtrkLlps7g52f3KP4zftkc/KLK6f+C0uXLbsSjl3uQ=; b=RLz9MrfHLmONZpFpC3K3FlC3Fr
        TPk0T+JjqliICOmcZq8FaHFbIpxjaj7Zj5MvC5z3HSM04AcgptnCTRFzNrJkzySwPvuXi8jg2BSwM
        mIkcy6wD0cBETlP/w8NhrPb0+MqJm90qMZfumCkLb+vN4qWg5tDt1N3Q6s/qDOlPyWxuOvpi254wk
        RqXLOzAshCSOT04yao6ZNjhgkfu3fY82YQ//zG/W2kRfYPH2jhT/2iCikeZiG4xQlEQD+9sg72Nm5
        fzMKLwMrofbyCWOE/m+0XojzSDjLh7EUMIY7LQQuLInA7YX7U6raXqcUkQ7MUKJpPohSaLpqnDXxh
        CEKyTQ3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvGob-00014B-6s; Tue, 14 Jul 2020 09:01:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A43CF305C22;
        Tue, 14 Jul 2020 11:01:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86E1628B91075; Tue, 14 Jul 2020 11:01:26 +0200 (CEST)
Date:   Tue, 14 Jul 2020 11:01:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Optionally store lock holder
 cpu into lock
Message-ID: <20200714090126.GR10769@hirez.programming.kicks-ass.net>
References: <20200711182128.29130-1-longman@redhat.com>
 <20200711182128.29130-3-longman@redhat.com>
 <20200712173452.GB10769@hirez.programming.kicks-ass.net>
 <bed22603-e347-8bff-f586-072a18987946@redhat.com>
 <1594613637.ds7pt1by9l.astroid@bobo.none>
 <e850b327-d747-fbe8-95db-4e2fbb1d7871@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e850b327-d747-fbe8-95db-4e2fbb1d7871@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 13, 2020 at 10:48:00PM -0400, Waiman Long wrote:
> Storing the cpu number into the lock can be useful for other reason too. It
> is not totally related to PPC support.

Well, the thing you did only works for 'small' (<253 CPU) systems.
There's a number of Power systems that's distinctly larger than that. So
it simply cannot work as anything other than a suggestion/hint. It must
not be a correctness thing.
