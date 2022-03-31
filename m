Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142E14ED923
	for <lists+linux-arch@lfdr.de>; Thu, 31 Mar 2022 14:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiCaMDj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 31 Mar 2022 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbiCaMCu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Mar 2022 08:02:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC223C6EC4;
        Thu, 31 Mar 2022 04:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gjM65KpA0vNRhkW6BTOes5PJMxyCJQiBa6LAwzsgitM=; b=uUq3v8mnX6pXflbOjhitICD/xV
        d8r5C/KCuIzUYw8FhcBWsUPwgldnBwPL3CHfsVMWVYB70Jx1ztDyCBKpKJEuA7OPD2IGjMnbxMJRf
        9R2LzYIGcYGq603xH2fM7tR4IYabi97VGkfCsIfGMqM2HusnveGsd28cz7gvnTTO/VppMLwO5csyk
        VCtef3RLpxaW0CGal/jOxe8yd8Xvm1NmFaX9AkfqZzgYmVm04qJpqvG5sDGhnXOT0dnFIBeiHUMSD
        2wZscNNT6Cb2S6mo8NziBzdRDgN3J1bXCiir1W7WGfBBjQEmaxx/M337uzbPW6/G14HbG4Puv/TfS
        DaxpgOKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZtSQ-002BMA-1C; Thu, 31 Mar 2022 11:59:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52D3B9861D6; Thu, 31 Mar 2022 13:59:16 +0200 (CEST)
Date:   Thu, 31 Mar 2022 13:59:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow
 path
Message-ID: <20220331115916.GU8939@worktop.programming.kicks-ass.net>
References: <20220322185709.141236-1-namhyung@kernel.org>
 <20220322185709.141236-3-namhyung@kernel.org>
 <20220328113946.GA8939@worktop.programming.kicks-ass.net>
 <CAM9d7ciQQEypvv2a2zQLHNc7p3NNxF59kASxHoFMCqiQicKwBA@mail.gmail.com>
 <20220330110853.GK8939@worktop.programming.kicks-ass.net>
 <CAM9d7cjQnThKgsUfnqJDcmBFseSTk-56a6f0sefo1x8D7LWSZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjQnThKgsUfnqJDcmBFseSTk-56a6f0sefo1x8D7LWSZw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 30, 2022 at 12:03:06PM -0700, Namhyung Kim wrote:
> On Wed, Mar 30, 2022 at 4:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Mar 28, 2022 at 10:48:59AM -0700, Namhyung Kim wrote:
> > > > Also, if you were to add LCB_F_MUTEX then you could have something like:
> > >
> > > Yep, I'm ok with having the mutex flag.  Do you want me to send
> > > v5 with this change or would you like to do it by yourself?
> >
> > I'll frob my thing on top. No need to repost.
> 
> Cool, thanks for doing this!

I've since pushed out the lot to:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core

It builds, but I've not actually used it. Much appreciated if you could
test.
