Return-Path: <linux-arch+bounces-4157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8658BA471
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 02:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19BA1F2465E
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 00:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB136B;
	Fri,  3 May 2024 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE9MBYW0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BCD193;
	Fri,  3 May 2024 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714695404; cv=none; b=UbLAFCsnFXc46wxr+4VN8PoeW5/GCvrmDiTvNCJJLK9oYeWdy5M8gs09SWJOviQA88tpCNsKm699g9s1qpuagg1yMaQP8sruOfCLlsZpcPoZTJB1woSAT6TIjUtvhQzVSN1cBHnPBD2T3YSWeaGwkwWO34+A2/EtJZD5yhtZG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714695404; c=relaxed/simple;
	bh=rF9pMJbFN+/L4ZoAlKzy29Ti9M/pRpKGV6oAQsWdR1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TldA1HSUdQY98zpPCdVb247szETIQhxneaBONMiLDdJyiIm5vBHDLgU28Gvm7RfxilEB+YRQnYkRSfrHcsCfZqyI7jXDhq6fN3qcjAZxtlqP7xxMc5dWeV0mXbyXkXxwUxY9cIWixvjjxAS6s++BiCxazYHRHZqppcnrf5bF3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jE9MBYW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5AEC113CC;
	Fri,  3 May 2024 00:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714695403;
	bh=rF9pMJbFN+/L4ZoAlKzy29Ti9M/pRpKGV6oAQsWdR1U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jE9MBYW0/uaiCob3sBSXc2FxZEpI/ydtwE3pxzz5xa2XMBRbKxWJQqBuHx4GxhoMG
	 UV2PnD7x/vzSR1Q4Pg6hyuWqDlr0iBM9NO/Tr/d9ILgFtJlvvLVEcVKhljk0NYlG89
	 t5xNgfMtE3mw4AIOahzMQ65c8Ca8uiDA0+1ym/EhJA1I53mR1aOuSwJlHpnSsHZmYW
	 mpqtznkmFzkVVioPIyVBgmeWuDpb4V4P4hV9w6qEfCMXjtSWUho4OVhG+Igqr60ov7
	 dyFgeqK/1gwvKD0bgzMkyXMrV2OsA8+S8Xf/VmSjeXwsOHm43y5OwM1Vf/3NoFO6mu
	 cpcW2JKaHJVqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 754DCCE0991; Thu,  2 May 2024 17:16:43 -0700 (PDT)
Date: Thu, 2 May 2024 17:16:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, kernel-team@meta.com,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
Message-ID: <628950f5-b220-48cb-a3a6-818be9e46f40@paulmck-laptop>
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
 <CAHk-=whaCSxengJHP82WUwrjKjYsVeD_zEN_We+gmyHpJJayoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whaCSxengJHP82WUwrjKjYsVeD_zEN_We+gmyHpJJayoQ@mail.gmail.com>

On Thu, May 02, 2024 at 04:32:35PM -0700, Linus Torvalds wrote:
> On Thu, 2 May 2024 at 16:12, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > One of RCU's state machines uses smp_store_release() to start the
> > state machine (only one task gets to do this) and cmpxchg() to update
> > state beyond that point.  And the state is 8 bits so that it and other
> > state fits into 32 bits to allow a single check for multiple conditions
> > elsewhere.
> 
> Note that since alpha lacks the release-acquire model, it's always
> going to be a full memory barrier before the store.
> 
> And then the store turns into a load-mask-store for older alphas.
> 
> So it's going to be a complete mess from a performance standpoint regardless.

And on those older machines, a mess functionally because the other
three bytes in that same 32-bit word can be concurrently updated.
Hence Arnd's patch being necessary here.

EV56 and later all have single-byte stores, so they are OK.  They were
introduced in the mid-1990s, so even they are antiques.  ;-)

> Happily, I doubt anybody really cares.

Here is hoping!

> I've occasionally wondered if we have situations where the
> "smp_store_release()" only cares about previous *writes* being ordered
> (ie a "smp_wmb()+WRITE_ONCE" would be sufficient).

Back in the day, rcu_assign_pointer() worked this way.  But later there
were a few use cases where ordering prior reads was needed.

And in this case, we just barely need that full store-release
functionality.  There is a preceding mutex lock-unlock pair that provides
a full barrier post-boot on almost all systems.

> It makes no difference on x86 (all stores are relases), power64 (wmb
> and store_release are both LWSYNC) or arm64 (str is documentated to be
> cheaper than DMB).
> 
> On alpha, smp_wmb()+WRITE_ONCE() is cheaper than smp_store_release(),
> but nobody sane cares.
> 
> But *if* we have a situation where the "smp_store_release()" might be
> just a "previous writes need to be visible" rather than ordering
> previous reads too, we could maybe introduce that kind of op. I
> _think_ the RCU writes tend to be of that kind?

Most of the time, rcu_assign_pointer() only needs to order prior writes,
not both reads and writes.  In theory, we could make an something like
an rcu_assign_pointer_reads_too(), though hopefully with a shorter name,
and go back to smp_wmb() for rcu_assign_pointer().

But in practice, I am having a really hard time convincing myself that
it would be worth it.

							Thanx, Paul

