Return-Path: <linux-arch+bounces-14412-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9F6C1C150
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 17:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EE0563E7C
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510CF2EB87F;
	Wed, 29 Oct 2025 15:40:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3A3358A0;
	Wed, 29 Oct 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752421; cv=none; b=hXdoZqkHFCvsZ4X2Ld0CpISL1eOUvX0NFvCdYTumpnIIVn29nEhpKQe0IVhezM7bl3ECK+ittyzqIzmjAj0ClN6ulBog/H0lZRao6ikBqHMyM6Zk6CFASJEQ6NaNxGRe2x/kjAb0+mPrK4GGD2ABuRf7d+6615MLGWY1h5TY6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752421; c=relaxed/simple;
	bh=wcQ8IGFKbehv60Qvlp3njLD4yfBr3RovVxP1nGvSmw8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIp5l4JJKCp4UbUjGiBhRmut13JbY4qLbMFaVNq7sKXR9XIqrapIuNDtt/lG5O3nUHXVHWEKj/Skn4hzXRsFefVxGEj/QLZWdx4p9ALI6f2F145QAwGC7Nw8fFQPsJR4m4Gpxm4atUOHhvzInxzGODm9pRBlp3K5bxQRockYb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 80B8D49EC4;
	Wed, 29 Oct 2025 15:40:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id C6E8620027;
	Wed, 29 Oct 2025 15:40:08 +0000 (UTC)
Date: Wed, 29 Oct 2025 11:40:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
Message-ID: <20251029114049.1686a619@gandalf.local.home>
In-Reply-To: <20251029151055.SA-WMUQ_@linutronix.de>
References: <20251029125514.496134233@linutronix.de>
	<20251029151055.SA-WMUQ_@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: C6E8620027
X-Stat-Signature: bg1a9jc981s9q7ws1mmwqsc5sp1frpgn
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/yGtvNgo/ftBl+pn41DDvnv5l+1wGiMn0=
X-HE-Tag: 1761752408-769937
X-HE-Meta: U2FsdGVkX1928eAfm8v96ZRbrNSxVm164YIoSoaDtyQyWWKdkYy4PisP9DyX7Zu7CCifDc4HhieAewPkRrMiNo78Hron/VMfL44sF7/2xTX1x0YrxOUVknYq/JtdO+r4aib6ptfLcJ8/Qv4IlvZpBRUQCWEQzEwrSp1O4zwgSDToPrNNtWgOdYwF5hV1m6939tn3H4KCuO1aG2bug+DcLjraGkJ7tDnLxYPU7rsug/zaq7OQKXk2+kIT3tGK/VtpOiPzU030nAU+VsAb0N+Og2VGl+LklgYrDMGuvlNSvHmbAdaHSe5/XQfrB3L60dAVnFMzLO4GBA/qGFfZX7SrU1kjwgdTOvqVfCJ341nHaJgGVKoHIL5m9A==

On Wed, 29 Oct 2025 16:10:55 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > and in git:
> > 
> >     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/cid
> > 
> > For your convenience all of it is also available as a conglomerate from
> > git:
> > 
> >     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice  
> 
> rseq/slice is older than rseq/cid. rseq/slice has the
> __put_kernel_nofault typo. rseq/cid looks correct.

Yeah, I started looking at both too, and checking out req/slice and trying
to do a rebase on top of rseq/cid causes a bunch of conflicts.

I'm continuing the rebase and just skipping the changed commits.

-- Steve

