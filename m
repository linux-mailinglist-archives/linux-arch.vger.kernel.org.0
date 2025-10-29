Return-Path: <linux-arch+bounces-14426-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91233C1DD08
	for <lists+linux-arch@lfdr.de>; Thu, 30 Oct 2025 00:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E05434C6F6
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 23:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425FC221721;
	Wed, 29 Oct 2025 23:53:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C72D9ED9;
	Wed, 29 Oct 2025 23:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781998; cv=none; b=jj6tq8VsYIC6t0xSf1tEXbcLABbBF83eZ6y5qX2P/EuoKXXuCUdTJvSDcddC2nBntsTDnH7oCK2Id4l9VWr00gJ0GRKs2jZ9ZwuSEppn1yebHFroCyJ2eTfy1/kTEJniCnkKYXzxE5gKgOYw/sYMmXfBPpADQ/Vf7ZWfI2lvksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781998; c=relaxed/simple;
	bh=wfSqE46Nhm/GGeUEdRBWTl4dn0/xzwfUfYVQ3nJhjWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIzFPewyBG6qTfkMTWjSM0v0W44msrA/+uHpQ8e78Ygfpy7dgTBZ9tv9Vs6qCaOwaklc4ARD96WzSRMDMzfAPazKdO5RllwPgRznHfNogNKYoLMLHauRr7DI4lOIex8teuk1u3nYntLZc6LFIljkrLaif//sxauAV1+pGWr1HuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id C6CB0140921;
	Wed, 29 Oct 2025 23:53:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 1D5606000B;
	Wed, 29 Oct 2025 23:53:11 +0000 (UTC)
Date: Wed, 29 Oct 2025 19:53:52 -0400
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
Subject: Re: [patch V3 08/12] rseq: Implement time slice extension
 enforcement timer
Message-ID: <20251029195352.1920e7fa@gandalf.local.home>
In-Reply-To: <87ms59tmnm.ffs@tglx>
References: <20251029125514.496134233@linutronix.de>
	<20251029130403.923191772@linutronix.de>
	<20251029144538.5eb5c772@gandalf.local.home>
	<87ms59tmnm.ffs@tglx>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rw1hfcfx9tzpsytg55tqeqfxatofm3ht
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 1D5606000B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19CVbaMKVxM80mbhftWYDBYPUPkAKVCKkM=
X-HE-Tag: 1761781991-937842
X-HE-Meta: U2FsdGVkX19c53o3wpYakGMzAH7rA2FyZZvJMWpStytwCfoFLaUiMe9EftkaKYucz1LPid/HM1KLo4YJCD3/tbxuGOguCQThcdq+AkkW5qghbHhe78f206sgkpIxiR8lE/BJzH7dX+PEZCEWcMqnMScpV1Ys/PvCJ6y+QUzlRXQPQgnffBQOLZbkrS1U9RyZutemoSq5OHFlpKUi3U2uh+14Foz0tD1d9x34qe4IBl9KlI+JiBOb4mwawJM70kLPj3OGoakqM0hLpZaDzlPkH22BFk8ACCZS7gtL0el5/q/OQbDCplhcdGeJCUcMVtif

On Wed, 29 Oct 2025 22:37:17 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> >> +	 * This check prevents that a granted time slice extension exceeds  
> >
> >	   This check prevents a granted time slice ...
> >  
> >> +	 * the maximum scheduling latency when the grant expired before  
> 
> I'm not a native speaker, but your suggested edit is bogus. Let me
> put it into the full sentence:
> 
> 	   This check prevents a granted time slice extension exceeds
>            the maximum ....
> 
> Can you spot the fail?

Ah, I should have updated the entire sentence, as the original still sounds
funny to me, but you are correct, that update wasn't enough.

Perhaps:

   This check prevents a granted time slice extension from exceeding the
   maximum scheduling latency when the grant expires before going back out
   to user space.

-- Steve

