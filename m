Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93BEA1640EA
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 10:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgBSJ6W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 04:58:22 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgBSJ6W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 04:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ju7RNVO+JUQObhm5lTREw7ao6b53xwESyy/6/lACiL0=; b=L+1ewkA6EVs5oN2GGY8MYky2gE
        9FunJgfuBsZQMomY5BEFobzJYMRAV5WYcTILodEJv/m9cNLedZOgWt5q2BTUlG8U3XMEBLNZz0fFX
        ivkdkw3tgSXLX4zD28oQwm7PPgSJ7I/nAkUpRGImCRcloi7irGrVkRwbBRY1vxZyXRFOSMPpXKH7j
        xEbthzvAKo2Fd3hbxjrJNDvmbUrEMfiBFkcqePLsP4wec8M0QQnFCTTmzQxd5fg5OzzBqlVA/Y6ar
        ekLUf0CdybblQZ92NvyFT+xHHdhCsVcpqPbnOwaALl34bXOgBW56VmxxbjPAEqImQiLoyJiZ1DiR7
        jfxsrp3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4M71-0002Lw-IW; Wed, 19 Feb 2020 09:57:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6076330008D;
        Wed, 19 Feb 2020 10:55:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 963B92B959662; Wed, 19 Feb 2020 10:57:43 +0100 (CET)
Date:   Wed, 19 Feb 2020 10:57:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200219095743.GA18400@hirez.programming.kicks-ass.net>
References: <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
 <20200213135138.GB2935@paulmck-ThinkPad-P72>
 <20200213164031.GH14914@hirez.programming.kicks-ass.net>
 <20200213185612.GG2935@paulmck-ThinkPad-P72>
 <20200213204444.GA94647@google.com>
 <20200218195831.GD11457@worktop.programming.kicks-ass.net>
 <20200218201728.GH2935@paulmck-ThinkPad-P72>
 <20200218204021.GJ11457@worktop.programming.kicks-ass.net>
 <20200218213925.GL2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218213925.GL2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 18, 2020 at 01:39:25PM -0800, Paul E. McKenney wrote:
> OK.  I will drop it later today, but leave tag in_nmi.2020.02.18a
> pointing at it for future reference.

Thanks, I've picked it up in my series.
