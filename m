Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6329E25B887
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 04:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgICCCd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 22:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgICCCc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Sep 2020 22:02:32 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55BC82071B;
        Thu,  3 Sep 2020 02:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599098552;
        bh=oXS2G4ZGoJ1ZSfjgka22/QmGCif9MbzQQtgewSUYIgc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iGBysdCDoQ7S5l2sM4OOTwhGD85kpcOGwAZRZPInk0byviyBFEHh+BAjY6AFu/XGq
         dg9YYWydzm5vxEBic16jogzrdIJVi5Hs7pgfLpEO1bfLab+UV5mw6PaXlzxLoyYMP1
         S+ItB222EMS6Adt+KWv/seS7slNhVvdlJCkuaqNI=
Date:   Thu, 3 Sep 2020 11:02:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     peterz@infradead.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org,
        systemtap@sourceware.org
Subject: Re: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Message-Id: <20200903110226.8963179e6a7c978e2d56c595@kernel.org>
In-Reply-To: <20200903103954.68f0c97da57b3679169ce3a7@kernel.org>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
        <20200901190808.GK29142@worktop.programming.kicks-ass.net>
        <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
        <20200902070226.GG2674@hirez.programming.kicks-ass.net>
        <20200902171755.b126672093a3c5d1b3a62a4f@kernel.org>
        <20200902093613.GY1362448@hirez.programming.kicks-ass.net>
        <20200902221926.f5cae5b4ad00b8d8f9ad99c7@kernel.org>
        <20200902134252.GH1362448@hirez.programming.kicks-ass.net>
        <20200903103954.68f0c97da57b3679169ce3a7@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 3 Sep 2020 10:39:54 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> OK, I've confirmed that the lockdep warns on kretprobe from INT3
> with your fix. Of course make it lockless then warning is gone.
> But even without the lockless patch, this warning can be false-positive
> because we prohibit nested kprobe call, right?
> 
> If the kprobe user handler uses a spinlock, the spinlock is used
> only in that handler (and in the context between kprobe_busy_begin/end),
> it will be safe since the spinlock is not nested.
> But if the spinlock is shared with other context, it will be dangerous
> because it can be interrupted by NMI (including INT3). This also applied
> to the function which is called from kprobe user handlers, thus user
> has to take care of it.

Sorry, for noticing this point, I Cc'd to systemtap. Is systemtap taking
care of spinlock too?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
