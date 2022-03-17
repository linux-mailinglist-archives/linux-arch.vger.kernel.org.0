Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E173B4DCAC7
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 17:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiCQQJR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbiCQQJQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 12:09:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95850616E;
        Thu, 17 Mar 2022 09:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 484CCB81F12;
        Thu, 17 Mar 2022 16:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5493BC340EF;
        Thu, 17 Mar 2022 16:07:55 +0000 (UTC)
Date:   Thu, 17 Mar 2022 12:07:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        paulmck <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 1/2] locking: Add lock contention tracepoints
Message-ID: <20220317120753.4cd73f9e@gandalf.local.home>
In-Reply-To: <636955156.156341.1647523975127.JavaMail.zimbra@efficios.com>
References: <20220316224548.500123-1-namhyung@kernel.org>
        <20220316224548.500123-2-namhyung@kernel.org>
        <636955156.156341.1647523975127.JavaMail.zimbra@efficios.com>
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

On Thu, 17 Mar 2022 09:32:55 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Unless there is a particular reason for using preprocessor defines here, the
> following form is typically better because it does not pollute the preprocessor
> defines, e.g.:
> 
> enum lock_contention_flags {
>         LCB_F_SPIN =   1U << 0;
>         LCB_F_READ =   1U << 1;
>         LCB_F_WRITE =  1U << 2;
>         LCB_F_RT =     1U << 3;
>         LCB_F_PERCPU = 1U << 4;
> };

If you do this, then to use the __print_flags(), You'll also need to add:

TRACE_DEFINE_ENUM(LCB_F_SPIN);
TRACE_DEFINE_ENUM(LCB_F_READ);
TRACE_DEFINE_ENUM(LCB_F_WRITE);
TRACE_DEFINE_ENUM(LCB_F_RT);
TRACE_DEFINE_ENUM(LCB_F_PERCPU);

Which does slow down boot up slightly.

-- Steve
