Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E6C4E3EFD
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 14:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiCVNAx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 09:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbiCVNAu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 09:00:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDE05EBC7;
        Tue, 22 Mar 2022 05:59:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4898B81CE8;
        Tue, 22 Mar 2022 12:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2637C340EE;
        Tue, 22 Mar 2022 12:59:16 +0000 (UTC)
Date:   Tue, 22 Mar 2022 08:59:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow
 path
Message-ID: <20220322085915.6c2e7ff9@gandalf.local.home>
In-Reply-To: <CAM9d7cgCEsH6grH556Js6VX-cXAO_3hT7C+RSm+sxxBDgxHvig@mail.gmail.com>
References: <20220316224548.500123-1-namhyung@kernel.org>
        <20220316224548.500123-3-namhyung@kernel.org>
        <YjSBRNxzaE9c+F/1@boqun-archlinux>
        <YjS2rlezTh9gdlDh@hirez.programming.kicks-ass.net>
        <CAM9d7cjUR6shddKM2h9uFXgQf+0F504fnJmKRSfc3+PG3TmEyg@mail.gmail.com>
        <20220318180750.744f08d4@gandalf.local.home>
        <CAM9d7ci-91efxreUvLBhkAcs0rpngzR9+3BnZBDb4zLai2Ewcw@mail.gmail.com>
        <CAM9d7cgCEsH6grH556Js6VX-cXAO_3hT7C+RSm+sxxBDgxHvig@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 21 Mar 2022 22:31:30 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> > Thanks for the info.  But it's unclear to me if it provides the custom
> > event with the same or different name.  Can I use both of the original
> > and the custom events at the same time?  

Sorry, missed your previous question.

> 
> I've read the code and understood that it's a separate event that can
> be used together.  Then I think we can leave the tracepoint with the
> return value and let users customize it for their needs later.

Right, thanks for looking deeper at it.

-- Steve
