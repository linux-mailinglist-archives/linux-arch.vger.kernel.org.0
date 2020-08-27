Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CC62545B7
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 15:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgH0NKj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 09:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgH0NKe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 09:10:34 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599CD22CAF;
        Thu, 27 Aug 2020 13:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598533381;
        bh=y/lp9qyaaM7Bpx+/gb8wqjGJ5T/lQhnVCnSMOeuYfec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U4je+28DrKs6l2GyNXB1ys9+ccco2w261d7RE1Vl8JuZ/56fFCHHV0q5WApIvhWXz
         OUxmf/ltt8gsBFjbuogwRYMvlSDrAfam0HzbNjIKbTLZoeie5CV61Acmp+KjMo12TV
         nIi07CTolp4VkXD2kQbGeKT1tFn5byQJybruDHRo=
Date:   Thu, 27 Aug 2020 22:02:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Eddy Wu <Eddy_Wu@trendmicro.com>,
        x86@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 15/15] kprobes: Free kretprobe_instance with rcu
 callback
Message-Id: <20200827220256.9aaedd03e3eeec8d7b765132@kernel.org>
In-Reply-To: <20200827114919.GB2674@hirez.programming.kicks-ass.net>
References: <159852811819.707944.12798182250041968537.stgit@devnote2>
        <159852826969.707944.15092569392287597887.stgit@devnote2>
        <20200827114919.GB2674@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 27 Aug 2020 13:49:19 +0200
peterz@infradead.org wrote:

> On Thu, Aug 27, 2020 at 08:37:49PM +0900, Masami Hiramatsu wrote:
> 
> > +void recycle_rp_inst(struct kretprobe_instance *ri)
> 
> Also note, that at this point there is no external caller of this
> function anymore.

OK, actually, there are more local functions are exported without any
reason. Let's make all static.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
