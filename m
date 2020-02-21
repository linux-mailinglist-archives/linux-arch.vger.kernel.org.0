Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D44168857
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 21:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgBUU2b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 15:28:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgBUU2b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 15:28:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C71C2072C;
        Fri, 21 Feb 2020 20:28:29 +0000 (UTC)
Date:   Fri, 21 Feb 2020 15:28:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <-
 "IN-NMI" inversions
Message-ID: <20200221152828.7fe59d51@gandalf.local.home>
In-Reply-To: <20200221202511.GB14897@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
        <20200221134215.090538203@infradead.org>
        <20200221100855.2f9bec3a@gandalf.local.home>
        <20200221202511.GB14897@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 21 Feb 2020 21:25:11 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > Nitpick, but the association with bit 16 and this mask really should be
> > defined as a macro somewhere and not have hard coded numbers.  
> 
> Right, I suppose I can do something like:
> 
> #define LOCKDEP_RECURSION_BITS	16
> #define LOCKDEP_OFF (1U << LOCKDEP_RECURSION_BITS)
> #define LOCKDEP_RECURSION_MASK (LOCKDEP_OFF - 1)

LGTM

-- Steve
