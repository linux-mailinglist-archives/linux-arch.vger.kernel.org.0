Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECF115B6C5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 02:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgBMBlb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 20:41:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbgBMBlb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 20:41:31 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F067420873;
        Thu, 13 Feb 2020 01:41:29 +0000 (UTC)
Date:   Wed, 12 Feb 2020 20:41:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH v2 2/9] rcu: Mark rcu_dynticks_curr_cpu_in_eqs() inline
Message-ID: <20200212204128.20f5e8ba@oasis.local.home>
In-Reply-To: <20200212223818.GA115917@google.com>
References: <20200212210139.382424693@infradead.org>
        <20200212210749.915180520@infradead.org>
        <20200212223818.GA115917@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 12 Feb 2020 17:38:18 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> I think there are ways to turn off function inlining, such as gcc's:
> -fkeep-inline-functions
> 
> And just to be sure weird compilers (clang *cough*) don't screw this up,
> could we make it static inline notrace?

inline is defined as notrace, so not needed.

I did that because of surprises when functions marked as inline
suddenly became non inlined and traced, which caused issues with
function tracing (before I finally got recursion protection working).
But even then, I figured, if something is inlined and gcc actually
inlines it, it wont be traced. For consistency, if something is marked
inline, it should not be traced.

-- Steve
