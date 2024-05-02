Return-Path: <linux-arch+bounces-4156-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 982CF8BA42F
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 01:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433971F239CD
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 23:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD121586F1;
	Thu,  2 May 2024 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjbde47B"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF6920B20;
	Thu,  2 May 2024 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714693530; cv=none; b=o+IgPlRmcFywY6yVTJ+n9bsF4R9zOOApLXG9hfL4Z/draKisiUJI1WoADtzcdKI8t/OEJ0hOhxaDombStzZHY6XTXHh+FvNajsX1QO9xUuGwt5YHehUykCZYRr7NXJLfCKQFkc9iVf+yCfT0a07r+JEYBoJLYA2qdxxJgOagNj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714693530; c=relaxed/simple;
	bh=FSWB1xnA+87vQFSU9PyW5P5MFuSUupDK1oeWvd3K+Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLAmj6U4HKfRVfWOgu1m50SACEx6LTpuQuXAxgWSVZANd6Yma2eHKPuUqurOUVdTdp/wCJSco/4DobPT6QZXxl++sdar9Zispphm+4E9b1ur5RMCN5ZdLtTgFGBFE8aXy2c+4e2qEIzcgilKW4ZkN3eS0ojjkximP63oJGzTG7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjbde47B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04705C113CC;
	Thu,  2 May 2024 23:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714693530;
	bh=FSWB1xnA+87vQFSU9PyW5P5MFuSUupDK1oeWvd3K+Rc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tjbde47BGZ/LniOxo+HAxqo60qpsPQm9BXyHOxx4v2nLpZqvWtS3jZnAYOplMUbxn
	 N8x6DY0HPe0ywU7Kh/4RvRMTnhJzJEeIB6eXvHsAJgsecHCgt/LlJcGElWuqZpZhCq
	 ouzNLzdthaTG1Zkcn/Vh/OhA//36MgJzN6jlDVeGr9y3axX/7LYFFvINwfz3vQ9ClB
	 C2wkCheO9J1pgClNPvXWSZ3ovUtAw/pTRChCeHyt6yTDAYsAi7WVCnsZM/+lU3+pzM
	 pKDi7sLB2WXhkNuxZHQwUrJcaB1cUspiwnZuS8uybzdJ/hlaTAZIYNAY8D3+KlWxf7
	 EzMJStNyBCBVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 97FB8CE0991; Thu,  2 May 2024 16:45:29 -0700 (PDT)
Date: Thu, 2 May 2024 16:45:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
Message-ID: <9b0acc4c-6ba9-4743-bad7-2baa1e29b085@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240501230130.1111603-12-paulmck@kernel.org>
 <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
 <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
 <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop>
 <20240502205345.GK2118490@ZenIV>
 <0a429959-935d-4800-8d0c-4e010951996d@paulmck-laptop>
 <20240502220757.GL2118490@ZenIV>
 <3dac400c-d18f-4f4e-b598-cad6948362d6@paulmck-laptop>
 <20240502232447.GO2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502232447.GO2118490@ZenIV>

On Fri, May 03, 2024 at 12:24:47AM +0100, Al Viro wrote:
> On Thu, May 02, 2024 at 04:12:44PM -0700, Paul E. McKenney wrote:
> 
> > > I'm probably missing your point, though - what mix of cmpxchg and
> > > smp_store_release on 8bit values?
> > 
> > One of RCU's state machines uses smp_store_release() to start the
> > state machine (only one task gets to do this) and cmpxchg() to update
> > state beyond that point.  And the state is 8 bits so that it and other
> > state fits into 32 bits to allow a single check for multiple conditions
> > elsewhere.
> 
> Humm...  smp_store_release() of 8bit on old alpha is mb + fetch 64bit + replace
> 8 bits + store 64bit...

Agreed, which is why Arnd is moving his patches ahead.  (He and I
discussed this some weeks back, so not a surprise for him.)

For my part, I dropped 16-bit cmpxchg emulation when moving from the
RFC series to v1.

							Thanx, Paul

