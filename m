Return-Path: <linux-arch+bounces-15432-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD2BCBF6CB
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 19:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F0843006629
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 18:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A47E268690;
	Mon, 15 Dec 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bU0vWHk7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jgIDXhtN"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979431ACEDF;
	Mon, 15 Dec 2025 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823079; cv=none; b=MNQ0+H/gG4ifXDKkwq/BvOreaGPHlTSqx6S/vW4+4TVM+IU14U5C1LXi0Y4LgnPMcMjozWQt015SC/1XcG+lr6w2/0gk1/6gi+ZDhsydAeal6jHmG2S37d26RiIIG8b121MlTCtx8BbIW3KEyeMwRo4SZON4t+OZZYA/nea+OS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823079; c=relaxed/simple;
	bh=qMC/3WaPWPsEC8GpkNEeJ/+onzOIu61ZnRMKgIhJqWs=;
	h=Message-ID:From:To:Cc:Subject:Date; b=ipVfjT+KbqCRXpi9+wVfQNNxXr3pYVsiwup0oLl7jfe/vM7/pNWw+MTPD29U8fnBzJ096pJfhRZ5fGr4JhsjuMQplG6RwUvsU47OaEe5Pyqq3+JImv4Jh7qpmVEoxr4eAWrTZ4uGXzXXtP4HdCN3XkdwzSZqaJ/Fi1ub8lB6Y/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bU0vWHk7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jgIDXhtN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251215155615.870031952@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765823074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=4dTT3aJAqWsVF4pZKsCUZEHviWLQKtu1DpUBLD2IFv0=;
	b=bU0vWHk7OyPo10w95SZQ43KVTDuobHID84tPcbamZ7dCVtDXHqARupRM3Ftyxrj+jAYGe9
	4jQa+8gZ8Ie4PmNK+xhw+Ik6OtzBAx4nF68ZmmWqoL9pI0tiaMVu9972PZVLYzHByfFGfE
	4NnZMG8COi55vsAAnr6N1efp+OSh26Lz+hxVuKHPkX6DxLBlbYy8O/MzJH8Ag508C1Rwu1
	P3Ey01w6bzTxk+7GydFlVYivlCAeLiPpbbBx90sxk+0pvlr52SCZ/JftB1DtFYbAvaxtf9
	PoWQ3UMRNMIgA4DSH+tiqc38U0X0vVWhPG+1JtDEkyXD//b91eFulMfiNNuSDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765823074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=4dTT3aJAqWsVF4pZKsCUZEHviWLQKtu1DpUBLD2IFv0=;
	b=jgIDXhtNsjOzNN3/7mREKkZ1wsORur0dcqQYA39B0B0ZK45CU+gF68ftLOdIy0fAMreEQo
	VhktQEhzph02MaDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ron Geva <rongevarg@gmail.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch V6 00/11] rseq: Implement time slice extension mechanism
Date: Mon, 15 Dec 2025 19:24:33 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This is a follow up on the V5 version:

     https://lore.kernel.org/20251128225931.959481199@linutronix.de

V1 contains a detailed explanation:

     https://lore.kernel.org/20250908225709.144709889@linutronix.de

TLDR: Time slice extensions are an attempt to provide opportunistic
priority ceiling without the overhead of an actual priority ceiling
protocol, but also without the guarantees such a protocol provides.

The intent is to avoid situations where a user space thread is interrupted
in a critical section and scheduled out, while holding a resource on which
the preempting thread or other threads in the system might block on. That
obviously prevents those threads from making progress in the worst case for
at least a full time slice. Especially in the context of user space
spinlocks, which are a patently bad idea to begin with, but that's also
true for other mechanisms.

This series uses the existing RSEQ user memory to implement it.

Changes vs. V5:

   - Rebase on v6.19-rc1

   - Fold typo fixes - Sebastian

   - Switch to syscall number 471

The series is based on v6.19-rc1 and is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice

Thanks,

	tglx

