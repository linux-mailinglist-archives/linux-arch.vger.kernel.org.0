Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39F822D1E0
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jul 2020 00:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgGXWkx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 18:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgGXWkx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jul 2020 18:40:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E220206EB;
        Fri, 24 Jul 2020 22:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595630452;
        bh=SxPVDdP6OkqBpUuq6d4bfLuZk9VZENEV/pSw/HUBnCg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=12lC1cOLKD7jvtFqwJd/pStvqC+TPSqiftoCstfYanSQCfUaoaHuYYFfHHYNx2EwV
         tn8llZGp100/e0Ra5ZYkf9YV9kAkbm2I1PZIqbFF7vSi3H8a3HntGH6zRWfDiBbU3E
         iX6NB0PKnLYCRu69u3EGKENM3dwOfliLXsyvPl38=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 882023522749; Fri, 24 Jul 2020 15:40:52 -0700 (PDT)
Date:   Fri, 24 Jul 2020 15:40:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, will@kernel.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/8] kcsan: Compound read-write instrumentation
Message-ID: <20200724224052.GX9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200724070008.1389205-1-elver@google.com>
 <20200724083920.GV10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724083920.GV10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 24, 2020 at 10:39:20AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 24, 2020 at 09:00:00AM +0200, Marco Elver wrote:
> 
> > Marco Elver (8):
> >   kcsan: Support compounded read-write instrumentation
> >   objtool, kcsan: Add __tsan_read_write to uaccess whitelist
> >   kcsan: Skew delay to be longer for certain access types
> >   kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
> >   kcsan: Test support for compound instrumentation
> >   instrumented.h: Introduce read-write instrumentation hooks
> >   asm-generic/bitops: Use instrument_read_write() where appropriate
> >   locking/atomics: Use read-write instrumentation for atomic RMWs
> 
> Looks good to me,
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Applied with ack, thank you both!

							Thanx, Paul
