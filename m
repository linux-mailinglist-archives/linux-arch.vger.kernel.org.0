Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C3F164916
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSPrn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:47:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgBSPrn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 10:47:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB7C2464E;
        Wed, 19 Feb 2020 15:47:41 +0000 (UTC)
Date:   Wed, 19 Feb 2020 10:47:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove()
 notrace/NOKPROBE
Message-ID: <20200219104739.5c8b1bf3@gandalf.local.home>
In-Reply-To: <20200219150744.604459293@infradead.org>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.604459293@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 19 Feb 2020 15:47:28 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Hitting the tracer or a kprobes from #DF is 'interesting', lets avoid
> that.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
