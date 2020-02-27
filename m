Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56271718C9
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 14:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgB0Nel (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 08:34:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729076AbgB0Nel (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 08:34:41 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 568AF24656;
        Thu, 27 Feb 2020 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582810480;
        bh=hd1EH5Kj0MHO9MQew6AELGq5JlBOz3GHWDMW12fIy1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9A0+DH5dBJgKnDVpjQb91A7WXwDFyWWxlMo9svI3aYgBDaJ12zZA54pFqYcg/VOj
         05+PE6RScxbPG/Z9EoLZWmis+g2iqcO9njxxKiHhcV82O4/rtQov/ZMPQN8BDdW7OR
         F5vF6SQos7BU4qr1AQOzyXgO0Ly3N5bkPoskBM00=
Date:   Thu, 27 Feb 2020 14:34:38 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        mhiramat@kernel.org, Will Deacon <will@kernel.org>,
        Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 02/27] hardirq/nmi: Allow nested nmi_enter()
Message-ID: <20200227133437.GB21795@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.149193474@infradead.org>
 <20200221222129.GB28251@lenoir>
 <20200224161318.GG14897@hirez.programming.kicks-ass.net>
 <20200225030905.GB28329@lenoir>
 <20200225154111.GM18400@hirez.programming.kicks-ass.net>
 <20200225221031.GB9599@lenoir>
 <20200227091042.GG18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227091042.GG18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 27, 2020 at 10:10:42AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 25, 2020 at 11:10:32PM +0100, Frederic Weisbecker wrote:
> > So here is my previous proposal, based on a simple counter, this time
> > with comments and a few fixes:
> 
> I've presumed your SoB and made this your patch.

Ok, thanks!
