Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B52560F3
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 21:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgH1TDO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 15:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1TDN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 15:03:13 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A336BC061264;
        Fri, 28 Aug 2020 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=78NCZFUBGKKYCpzTi7cqwpzpPqm0sGVhrlGpxwxSMsw=; b=JXjXh/j7C9T4NMLIkSb8dTRg2S
        mEAq23rpza3JWhOYcxfiEcnLMM9L3HxSBuQsWyhm7+wFWfyCm69rcVLkYcZLl7MRFZYZ9fUpDYvYq
        O8FR9iElo/UiNoV8qsi2j9feJbituEkvTRsfsl0RD+JeHpzPedHY+toiUsfJhBYitutN0n3s5i4lV
        d8nQQqpRhlwR+hizKvL9g/N59xA1VXFuNWoehpodBIs3sQOnnMvWLYzmFNIUk9VafyH+p+n4XKS+I
        +YkAbdPhfRJImz/VXnOXvpC10wawkLveNhM4AJGUmDxn5XCIIYsrpS53YiOASmSfOLhifikrY7vKd
        6cWw+Fmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBjeE-0005IR-Lq; Fri, 28 Aug 2020 19:02:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A131030015A;
        Fri, 28 Aug 2020 21:02:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A91220D27A76; Fri, 28 Aug 2020 21:02:45 +0200 (CEST)
Date:   Fri, 28 Aug 2020 21:02:45 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v4 19/23] kprobes: Remove kretprobe hash
Message-ID: <20200828190245.GH1362448@hirez.programming.kicks-ass.net>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
 <159861780638.992023.16486601398173945135.stgit@devnote2>
 <20200829033726.68547b37624d3510ebc33ab1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829033726.68547b37624d3510ebc33ab1@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 29, 2020 at 03:37:26AM +0900, Masami Hiramatsu wrote:
> cd /sys/kernel/debug/tracing/
> 
> echo r:schedule schedule >> kprobe_events
> echo 1 > events/kprobes/enable
> 
> sleep 333

Thanks! that does indeed trigger it reliably. Let me go have dinner and
then I'll try and figure out where it goes side-ways.
