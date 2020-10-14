Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A00528D767
	for <lists+linux-arch@lfdr.de>; Wed, 14 Oct 2020 02:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgJNAYh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Oct 2020 20:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgJNAYh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Oct 2020 20:24:37 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F418B2078A;
        Wed, 14 Oct 2020 00:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602635076;
        bh=LRPijYgatHCn0K1sBVHskJ6cFM70zQL1PZjCi1E3ev4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kMOrUWGHiyNsSgp7HlGa3N5B6DQWICWHPmQIE9QKsdwAfAaVpllQMg3iyHS5G4rXh
         3zWmeYjKaAGdGKmLYJ2ndR/Erlrp0VpmhX1BY6KqFLqdHgcGwjqbZzSs0MbJK8PPwA
         hNanIFvXZwh44EWX310ZhFPKa7WWnjv/FrRy0kY0=
Date:   Wed, 14 Oct 2020 09:24:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v5 17/21] llist: Add nonatomic __llist_add() and
 __llist_dell_all()
Message-Id: <20201014092431.c5b428e2c328cea910e42c4b@kernel.org>
In-Reply-To: <20201012162454.GA3687261@gmail.com>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
        <159870619318.1229682.13027387548510028721.stgit@devnote2>
        <20201012162454.GA3687261@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 12 Oct 2020 18:24:54 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Because you are forwarding this patch here, I've added your SOB:
> 
>   Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> (Let me know if that's not OK.)

OK, I keep it in mind next time.

Thanks Ingo!

> 
> Thanks,
> 
> 	Ingo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
