Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16366255A55
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgH1Mhg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 08:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgH1Mhe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 08:37:34 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05A5E2078A;
        Fri, 28 Aug 2020 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598618254;
        bh=An3L22TmRcfX000BNuwZ5uCqAfiTYo6+waUJ67sacTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WPZnpNBiLi0wM5wZ7/sn+ySRZgD7aZu6kpCcqhwPq2n/Raj0eBVT4ZQ/YSzplSzez
         SJxMfc8nsyRgb0POzv8BmML2V4UYi6eIMcEBQLtssWVYu6crF1kUUOwhcOWk2gHUnP
         KVt0K2rwi/qwTiY4SfRKhnEViF2S9pv/meN3HJxI=
Date:   Fri, 28 Aug 2020 21:37:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v4 00/23] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Message-Id: <20200828213729.68bb199c02812e24c2ffe942@kernel.org>
In-Reply-To: <159861759775.992023.12553306821235086809.stgit@devnote2>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 21:26:38 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 4th version of the series to unify the kretprobe trampoline handler
> and make kretprobe lockless.
> 
> Previous version is here;
> 
>  https://lkml.kernel.org/r/159854631442.736475.5062989489155389472.stgit@devnote2
> 
> In this version, I updated the generic trampoline handler a bit, merge 
> the Peter's lockless patches(*), and add an RFC "remove task scan" patch
> as [20/23].
> 
> (*) https://lkml.kernel.org/r/20200827161237.889877377@infradead.org
> 
> I ran some tests and ftracetest on x86-64. Mostly OK, but hit a BUG in the
> trampoline handler once. I'm trying to reproduce it but not succeeded yet.
> So this may need a careful review and tests.

The series is also available on
git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git lockless-kretprobe-v4

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
