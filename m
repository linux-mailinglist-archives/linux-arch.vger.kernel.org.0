Return-Path: <linux-arch+bounces-14418-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3576C1D24F
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 21:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2203A4A92
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 20:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB1311C3C;
	Wed, 29 Oct 2025 20:08:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA5331A6E;
	Wed, 29 Oct 2025 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768506; cv=none; b=L4bCuOrtd15InXKbEe3XSf0IgaWmyLcJDZ3JTF39IAqewyuwVmLVm8CswcLoaTH4BMGQtIgErF9YxEyJBa2VA4OdwnVqFA9TPFDJnQQfq7M56OgWQZZ9PL7CwD8jCEnTNeY6iWU1qA04G0cmxQgX4cioysqONxodjJnmzX0j7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768506; c=relaxed/simple;
	bh=t4qkp4EXFCUwyQ0JKP8LwtscZvc6HXW6xS2JDZ8kjeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTr9pfeNllDoC6oZjpw8e4fKavkA+IzVn75d0Ib6LJQj+sgHZ916VWicfXZfPTDj4BxbUk6lGQ8RbXIUyDQ6IrC5OIwVPlfi/7AFeRvb/V6fI6BSAbPJYxfLimBecYbb4i87XkNzhRFiK5f94KEGipWpWhw90JZKY4NlxoYNgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 1A994160848;
	Wed, 29 Oct 2025 20:08:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 65A3C3E;
	Wed, 29 Oct 2025 20:08:18 +0000 (UTC)
Date: Wed, 29 Oct 2025 16:08:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Prakash Sangappa
 <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann
 <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [patch V3 10/12] rseq: Implement rseq_grant_slice_extension()
Message-ID: <20251029160859.22bb6eed@gandalf.local.home>
In-Reply-To: <20251029130404.051555060@linutronix.de>
References: <20251029125514.496134233@linutronix.de>
	<20251029130404.051555060@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 65A3C3E
X-Stat-Signature: 1pbmnbxa6ha99bwb3sde7f73an68s98w
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18mzCRXSyzSXyTvEFHF8ygK8OlTYV1N8oM=
X-HE-Tag: 1761768498-215151
X-HE-Meta: U2FsdGVkX1+n/MPrQmom0gHqhc4MgYD2X4zaPJjjF61dcBqraHzAFiWVQYqnAbwzYqhPRsV2QFG/uFHl6lsmNsNI8BV5bTlle9Lf/YF67olBSvfYV8+x3mOKNsqKpsPiAsMTiOvrUepc8pD6RYDfdTD0MHnkZfawQYWK77RlPnL00qQc9nJQs5SnT9N0g71cOzbdWUtC7Ef0I5buq/WoYldUyoRTUVWveQOA+0jM9XQABajyKgimB7DZfRE8OBW58832jARDioVARgU1EiubA8pulcTS5A8MHZkuSsKhiX1dkgL4GlWsGPh6bD9lXBYP

On Wed, 29 Oct 2025 14:22:30 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> +static __always_inline bool rseq_grant_slice_extension(bool work_pending)
> +{
> +	struct task_struct *curr = current;
> +	struct rseq_slice_ctrl usr_ctrl;
> +	union rseq_slice_state state;
> +	struct rseq __user *rseq;
> +
> +	if (!rseq_slice_extension_enabled())
> +		return false;
> +
> +	/* If not enabled or not a return from interrupt, nothing to do. */
> +	state = curr->rseq.slice.state;
> +	state.enabled &= curr->rseq.event.user_irq;
> +	if (likely(!state.state))
> +		return false;
> +
> +	rseq = curr->rseq.usrptr;
> +	scoped_user_rw_access(rseq, efault) {
> +
> +		/*
> +		 * Quick check conditions where a grant is not possible or
> +		 * needs to be revoked.
> +		 *
> +		 *  1) Any TIF bit which needs to do extra work aside of
> +		 *     rescheduling prevents a grant.
> +		 *

I'm curious to why any other TIF bit causes this to refuse a grant?

If deferred unwinding gets implemented, and profiling is enabled, it uses
task_work. From my understanding, task_work will set a TIF bit. Would this
mean that we would not be able to profile this feature with the deferred
unwinder? As profiling it will prevent it from being used?

-- Steve


> +		 *  2) A previous rescheduling request resulted in a slice
> +		 *     extension grant.
> +		 */
> +		if (unlikely(work_pending || state.granted)) {
> +			/* Clear user control unconditionally. No point for checking */
> +			unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
> +			rseq_slice_clear_grant(curr);
> +			return false;
> +		}
> +
> +		unsafe_get_user(usr_ctrl.all, &rseq->slice_ctrl.all, efault);
> +		if (likely(!(usr_ctrl.request)))
> +			return false;
> +
> +		/* Grant the slice extention */
> +		usr_ctrl.request = 0;
> +		usr_ctrl.granted = 1;
> +		unsafe_put_user(usr_ctrl.all, &rseq->slice_ctrl.all, efault);
> +	}
> +

