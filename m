Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450EF164494
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 13:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgBSMqO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 07:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgBSMqO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 07:46:14 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4928724654;
        Wed, 19 Feb 2020 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582116374;
        bh=HQv/hCM1qUUqyPZSyfsNzd0vfsAlFzJduxoWeJPzwZY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YHtCaZf29YP2Sy1hvl5gP7bgjMIvhsvAMzQFlj0nD65rkdz3+kd3WHukcwYR1V1Pp
         dhv83JfDTNUpa16QBXDxgmfBzACeMp0JLxvmE1hpVqxYPOSM7xQlSPLZpIzNulp6aD
         9aDyox6Fw87UN0ucp5Mvmi30xPvaOmBTz1czMADY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 29DB935229ED; Wed, 19 Feb 2020 04:46:14 -0800 (PST)
Date:   Wed, 19 Feb 2020 04:46:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200219124614.GT2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200213082716.GI14897@hirez.programming.kicks-ass.net>
 <20200213135138.GB2935@paulmck-ThinkPad-P72>
 <20200213164031.GH14914@hirez.programming.kicks-ass.net>
 <20200213185612.GG2935@paulmck-ThinkPad-P72>
 <20200213204444.GA94647@google.com>
 <20200218195831.GD11457@worktop.programming.kicks-ass.net>
 <20200218201728.GH2935@paulmck-ThinkPad-P72>
 <20200218204021.GJ11457@worktop.programming.kicks-ass.net>
 <20200218213925.GL2935@paulmck-ThinkPad-P72>
 <20200219095743.GA18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219095743.GA18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 10:57:43AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 18, 2020 at 01:39:25PM -0800, Paul E. McKenney wrote:
> > OK.  I will drop it later today, but leave tag in_nmi.2020.02.18a
> > pointing at it for future reference.
> 
> Thanks, I've picked it up in my series.

Very good, thank you!

							Thanx, Paul
