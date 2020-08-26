Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E911C25339C
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHZP0h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgHZP0g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 11:26:36 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9493CC061574;
        Wed, 26 Aug 2020 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+kbSD2yR9v2pWhwpsyiZqxkY0BVg0p/LK9dRxQLDYOQ=; b=cDsq/X5VEuKMenCLWm0q6T9jFP
        +BRjLwIXzwkTQriFPNTFD+XHjLROecLv6xlo2AVtE7RWIVb2VE6ZkUeVjQFEd6zQ0L6lltp/diJFI
        JK9K1IesrNG+lmPgJ8muvGVY8OsfoVAEcDc+BOfNagSbl+R8y9FtRKqeg4lKS21IUN6xLZ5QpeK+I
        cDXcvwgXjEq8PFwUBRJk5iZLmvobXSE62wlTXCunUYbd5mXv3DGAWZURMJlmDqTEdlYbJFSoxSwaR
        qeSLkbYm9Ux/t8vAAJzoKeecBSAKQG6D+tusUuxDWthKo9W9jA/jMelcb2tf1E6Ka/YmWdVrB+9W7
        ENW1KRRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAxJY-0004Pl-Tp; Wed, 26 Aug 2020 15:26:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D7D9303A02;
        Wed, 26 Aug 2020 17:26:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B1FC2BFF50C3; Wed, 26 Aug 2020 17:26:12 +0200 (CEST)
Date:   Wed, 26 Aug 2020 17:26:12 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 03/14] arm: kprobes: Use generic kretprobe trampoline
 handler
Message-ID: <20200826152612.GX2674@hirez.programming.kicks-ass.net>
References: <159844957216.510284.17683703701627367133.stgit@devnote2>
 <159844960343.510284.15315372011917043979.stgit@devnote2>
 <20200826140852.GG1362448@hirez.programming.kicks-ass.net>
 <20200826141025.GU35926@hirez.programming.kicks-ass.net>
 <20200827000405.60aa815dbb6f1417dc9da867@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827000405.60aa815dbb6f1417dc9da867@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 12:04:05AM +0900, Masami Hiramatsu wrote:

> > Argh, I replied to the wrong variant, I mean the one that uses
> > kernel_stack_pointer(regs).
> 
> Would you mean using kernel_stack_pointer() for the frame_pointer?
> Some arch will be OK, but others can not get the framepointer by that.
> (that is because the stack layout is different on the function prologue
> and returned address, e.g. x86...)

Yeah, I noticed :/

I was hoping to avoid some further duplication, but they're all sublty
different.
