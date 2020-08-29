Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF28525663D
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgH2JP1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 05:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbgH2JP0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Aug 2020 05:15:26 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 059DE20776;
        Sat, 29 Aug 2020 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598692526;
        bh=iRDTespXVTvx6CS5lM7zVBWg9/uBKo9ho+raX1YWhk8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kLv9i3FE1KJO726SXimmRTd74h3DFZ+WHr/YOdiQVRxi6akRkbZlT2Q1sE3quZQc2
         mfyrjZ8GybJbykf+AMM2xXloYwjG0VYaMOxL0H0rc64Dj2cpjsWrdmjCmpeBSQpgxo
         2IUi676N4NIE3cu+b1ue+pu2Lz/zXplk2Y9BGb84=
Date:   Sat, 29 Aug 2020 18:15:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Cameron <cameron@moodycamel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org
Subject: Re: [RFC][PATCH 7/7] kprobes: Replace rp->free_instance with
 freelist
Message-Id: <20200829181520.ec52c425fc0a9d220559230a@kernel.org>
In-Reply-To: <CAFCw3dqDwP-RM20M7Uv=RS7aBHe=DLr3akhDY_XM8W0foiAEeQ@mail.gmail.com>
References: <20200827161237.889877377@infradead.org>
        <20200827161754.594247581@infradead.org>
        <20200828084851.GQ1362448@hirez.programming.kicks-ass.net>
        <20200828181341.c1da066360c6085d48850e22@kernel.org>
        <20200828091813.GU1362448@hirez.programming.kicks-ass.net>
        <CAFCw3dqhd35mdFE_SjUYtLrxNUYwdO-iFAonZ1OXu9CGBsyGrw@mail.gmail.com>
        <CAFCw3dqDwP-RM20M7Uv=RS7aBHe=DLr3akhDY_XM8W0foiAEeQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 22:31:17 -0400
Cameron <cameron@moodycamel.com> wrote:

> On Fri, Aug 28, 2020 at 10:29 PM Cameron <cameron@moodycamel.com> wrote:
> > I thought about this some more, and actually, it should be safe.
> 
> Although I should note that it's important that the flags/refcount are
> not overwritten
> even after the node is taken off the freelist.

Thanks for the check, but I personally would like to keep it separated
because the memory layouts of those in-kernel list-like data structures
can be changed by debug config option...

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
