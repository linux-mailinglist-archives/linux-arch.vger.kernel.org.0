Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBCF16493C
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgBSPws (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:52:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgBSPws (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 10:52:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 739BB24656;
        Wed, 19 Feb 2020 15:52:46 +0000 (UTC)
Date:   Wed, 19 Feb 2020 10:52:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 12/22] tracing: Employ trace_rcu_{enter,exit}()
Message-ID: <20200219105245.05072de5@gandalf.local.home>
In-Reply-To: <20200219150745.060958307@infradead.org>
References: <20200219144724.800607165@infradead.org>
        <20200219150745.060958307@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 19 Feb 2020 15:47:36 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Replace the opencoded (and incomplete) RCU manipulations with the new
> helpers to ensure a regular RCU context when calling into
> __ftrace_trace_stack().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---


Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
