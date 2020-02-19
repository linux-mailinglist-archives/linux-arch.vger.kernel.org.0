Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70998164C04
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgBSRfv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:35:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgBSRfv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 12:35:51 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB64920801;
        Wed, 19 Feb 2020 17:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582133750;
        bh=A+bwQiax4udXTp5OvTnyPDTZB+vscqkVcIUIsWlXDnE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zE9fhXO2ph0C/4v43LBZiTs/Cpw3Enx9ZyDazzLjj7yleERF+IGhJncrGi/JCJDcr
         DjBbA96LmCaGv+hh4EyTkxSYUELdKQzRHby5afh6kfepqjNYbTXeKyQ73xansIgCiz
         ECKjIRVe0PxtTNlX7xfHjAMP2J+geo4uTH7Zz0io=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A93F535209B0; Wed, 19 Feb 2020 09:35:50 -0800 (PST)
Date:   Wed, 19 Feb 2020 09:35:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v3 18/22] asm-generic/atomic: Use __always_inline for
 fallback wrappers
Message-ID: <20200219173550.GH2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200219144724.800607165@infradead.org>
 <20200219150745.416854783@infradead.org>
 <20200219165521.GG2935@paulmck-ThinkPad-P72>
 <20200219170609.GN18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219170609.GN18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 06:06:09PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2020 at 08:55:21AM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 19, 2020 at 03:47:42PM +0100, Peter Zijlstra wrote:
> > > While the fallback wrappers aren't pure wrappers, they are trivial
> > > nonetheless, and the function they wrap should determine the final
> > > inlining policy.
> > > 
> > > For x86 tinyconfig we observe:
> > >  - vmlinux baseline: 1315988
> > >  - vmlinux with patch: 1315928 (-60 bytes)
> > > 
> > > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > And this one and the previous one are also already in -tip, FYI.
> 
> That's where I found them ;-) Stole them from tip/locking/kcsan.

As long as the heist is official, then.  ;-)

							Thanx, Paul
