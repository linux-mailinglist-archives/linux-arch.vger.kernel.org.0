Return-Path: <linux-arch+bounces-14456-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11319C2883E
	for <lists+linux-arch@lfdr.de>; Sat, 01 Nov 2025 23:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D74E4E12CF
	for <lists+linux-arch@lfdr.de>; Sat,  1 Nov 2025 22:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8711E51EA;
	Sat,  1 Nov 2025 22:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k3jQ8zER";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PVLRq10B"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1234D3BE;
	Sat,  1 Nov 2025 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762037627; cv=none; b=pJzZlFadtKZYQzITPcw90x9z/SyJxP8+9+UZYEWYxegV6aITWU9PNMdrf6BdxFHPPP9KpqLpcaWD8NGAl6m8Df5Rb5u/mLrx/quAD24JBW2vLDdIbOvoRZKCRVTs2MKMwXF1De+hAUfJ/6WSKKDzdV2bWztj6OvE/YPSTHe5byg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762037627; c=relaxed/simple;
	bh=zXJ+sGw3zs0FhdG6bUZjfjOKwYnzGL+jOKmDWUnMMCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hSK2ddWerKjvoCFHs7hqE8eykV//mQGecXDFJBTjPu8D8vKrvjYpOkQM5xj5HeaLdGhrlt6CXUrW4jKWlK+aSJ/sFYeHZ4WYoTwTYw+3hTCUzNRT2TcB3Z+kr3F/koQ/Oogfn8fGj2CiRN6jUiM1sgqdcSJeAzkiAz0bxlaUUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k3jQ8zER; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PVLRq10B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762037623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFzxj3qRa7vOhFgaFuDmTmEPf4mtSZGwHydRG2r+8Aw=;
	b=k3jQ8zERnmk4nMMUqUZp1qxBxS2eNbaOKG48I+ZkUohO7vqAhdzx0M2kcKBMTW8W3xCP7F
	Dc94lCjm3kqKWYYoBb0ll1HYOvgdxvHiveVrEUAc1NZGoA/pSTwkvZBIHAtBYQwZoeqc0j
	HsXYIiP4DGM5p4i3BP75OzqAC9Wy9WXGeIts2rz3RqqwACwR6IqY5AxNIuzZKIpuEcKCXe
	RjpXk6wJCg9MfRtWNnVzZl+zvvWrvjmDyeh5QiFXFA0wjySp+k2VrkDYVFCRrWVC0h77sr
	Yq7aBMCKcf/QW8CrEfglNFSVtKXNNqdijjo266z7nOejwBQSxasj6ReqJmnksw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762037623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFzxj3qRa7vOhFgaFuDmTmEPf4mtSZGwHydRG2r+8Aw=;
	b=PVLRq10B/QGZxhXcPA2i8lGejwZlNfyGppFDlIpLOoMezHTHldZUTPlWj8lNyJuDu0bId4
	LUglI95p6sIg+GBg==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch V3 02/12] rseq: Add fields and constants for time slice
 extension
In-Reply-To: <87bjlmss8j.ffs@tglx>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.542731428@linutronix.de>
 <7e44ca0b-e898-4b7f-aaaa-30d8ac52c643@efficios.com> <87bjlmss8j.ffs@tglx>
Date: Sat, 01 Nov 2025 23:53:42 +0100
Message-ID: <87zf95weix.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 31 2025 at 21:58, Thomas Gleixner wrote:
> On Fri, Oct 31 2025 at 15:31, Mathieu Desnoyers wrote:
> That said I'm not completely against making this per process, but then
> it has to be enabled on the main thread _before_ it spawns threads and
> rejected otherwise.

It's actually not so trivial because contrary to CID, which is per MM
this is per process and as a newly created thread must register RSEQ
memory first there needs to be some 'inherited enablement on thread
creation' marker which then needs to be taken into account when the new
thread registers its RSEQ memory with the kernel.

And no, we are not going to make this unconditionally enabled when RSEQ
is registered. That's just wrong as that 'oh so tiny overhead' of user
space access accumulates nicely in high frequency scheduling scenarios
as you can see from the numbers provided with the rseq and cid cleanups.

So while it's doable the real question is whether this is worth the
trouble and extra state handling all over the place. I doubt it is and
keeping the kernel simple is definitely not the wrong approach.

Thanks,

        tglx

