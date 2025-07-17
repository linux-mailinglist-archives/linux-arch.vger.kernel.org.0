Return-Path: <linux-arch+bounces-12835-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F312DB08CEE
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 14:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519AB1C25890
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 12:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF1529B239;
	Thu, 17 Jul 2025 12:32:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41061F3FED;
	Thu, 17 Jul 2025 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755559; cv=none; b=BnhMponQMPzbo8PyHc5Bz1bGOcRk6ZCN/mjkaKigM0H+Xm6J7pC8palNtvZlnLtcagtAqhS9gZ21MczTkG+RDEsPM0mqW17gl2iE2N0fgZjHu78H/PunedQcpzmz1JbPBIk5iZYptccIJX8mYB77xSWP2ELWYxHajEv6cWUovwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755559; c=relaxed/simple;
	bh=rX9JCEg2df6Y1wPL64VzIsvYcWQA6WjXvIl7M/SMcD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwZFjCOUcGvZsYl2ExNSa5lex537LxSZbnH7147JZogqVIkYg0KNVrxpWHJYGr45OyV2c/KZQZzhhW+tStY2p8boFJC3/F1N43ZY9ouJxcAd9paxc/okJU2X4o3s9sS92zRS2fW/TPi0Y8csyz2ht4OLkBAuXVeqzDeGSXxSjwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 9F33EBAF59;
	Thu, 17 Jul 2025 12:32:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id D71BC20030;
	Thu, 17 Jul 2025 12:32:21 +0000 (UTC)
Date: Thu, 17 Jul 2025 08:32:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux RCU <rcu@vger.kernel.org>, Linux CPU
 Architectures Development <linux-arch@vger.kernel.org>, Linux LKMM
 <lkmm@lists.linux.dev>, Linux KVM <kvm@vger.kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Jonathan Corbet
 <corbet@lwn.net>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri
 <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave
 <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa
 <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Mark Rutland
 <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long
 <longman@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, "Mike Rapoport
 (Microsoft)" <rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>, Dan
 Williams <dan.j.williams@intel.com>, Xavier <xavier_qy@163.com>, Randy
 Dunlap <rdunlap@infradead.org>, Maarten Lankhorst <dev@lankhorst.se>,
 Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/4] Convert atomic_*.txt and memory-barriers.txt to
 reST
Message-ID: <20250717083242.40df5ad6@gandalf.local.home>
In-Reply-To: <20250717105554.GA1479557@noisy.programming.kicks-ass.net>
References: <20250717080617.35577-1-bagasdotme@gmail.com>
	<20250717105554.GA1479557@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7u763mm1ctzngdaryswszahnyy8y871i
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: D71BC20030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/YLoExnDFum8tu+2MnhikZQqR7InCKRAs=
X-HE-Tag: 1752755541-699290
X-HE-Meta: U2FsdGVkX18xlzwPkAba7/TysdbayY7PydE5DXeYoq5OJORdEoU0hKlFMZttv4UWKUFIpt6mFNcEbXhvnxXmv8On61UzOSV+8jeJtLXFftvkWYxmPHZX4s+NACcJSlO/JfG78ZFIPboSRWJ/CpoJ353SiREHX8xeGJ3fPoEna1I/Ro9tJ+MXOJjGe6Q027FoniM5n4iV+yWccqoAUW5N+ajxnZ14sYqVLWO2Gfkh1LK8kt28PunqsSrRny6G8njeDUPq0ws2cefBl4qpvYc5zHFEqQIOezpjqKSwCL40khje7RvDhOdtVldZB5v4NaD2oKC/nfGFRGMAqH23VnfBsU4AcU/4xVVVoBvRvviG9nlHcGmSJQcgk1r/d/u9UclZ

On Thu, 17 Jul 2025 12:55:54 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jul 17, 2025 at 03:06:13PM +0700, Bagas Sanjaya wrote:
> > Atomic types, atomic bitops, and memory barriers docs are included in kernel
> > docs build since commit e40573a43d163a ("docs: put atomic*.txt and
> > memory-barriers.txt into the core-api book") as a wrapper stub for
> > corresponding uncoverted txt docs. Let's turn them into full-fledged reST docs. 
> > 
> > Bagas Sanjaya (4):
> >   Documentation: memory-barriers: Convert to reST format
> >   Documentation: atomic_bitops: Convert to reST format
> >   Documentation: atomic_t: Convert to reST format
> >   Documentation: atomic_bitops, atomic_t, memory-barriers: Link to
> >     newly-converted docs  
> 
> NAK
> 
> If these are merged I will no longer touch / update these files.

One way a human discovers why something is the way it is, is to change it,
and see what the fallout is for that change.

  ;-)

-- Steve

