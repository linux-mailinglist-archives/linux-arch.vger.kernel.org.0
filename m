Return-Path: <linux-arch+bounces-14350-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4CEC0C902
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 10:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC4F3A2BD1
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78032EB84E;
	Mon, 27 Oct 2025 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3mlvFFMW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OASgF+9v"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224DB2F12BD;
	Mon, 27 Oct 2025 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555554; cv=none; b=B+jQ+I0vzGLzPxDZbhO7rEr1NK74qafh46CBGWmmgPVGLROe5zYsT/B47cqurr416HeQHGSdHlT/L4GtXWHtIiX1nnxWIeuhmFdSpeJ1HrxxGeIxckbyB7aVEPE9pxn/fz54jqEL3xUqSUuYNAegHTGz/NSEaTzUnxNnzmt1v2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555554; c=relaxed/simple;
	bh=63EUfleC8k9SyhPinqj6etUEidjorI7/1qLKw5KmnFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucDK4vrcO7ZGWAl9av11mDm+klY1kUNyJpPVSyEb2n1yfdf8EvBb7V8zKNGpxRwA3oj5i3cC1O5PJF+oG7XBy729joJ2Pk8IJBqnhb5gibokLv6WVHz9TFptzH278+wCrradXRpwhghiuyodWvmdnV0ZUEEpi6t+Kix2kgjR/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3mlvFFMW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OASgF+9v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 09:59:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761555551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ybiaUV4a6Vsi88Uvq6dlmsIATshHK9O4Qf7SiufJNw=;
	b=3mlvFFMWWW+1yae50FHUn8SRExPsshTC7J+/HQ6ljkB3ZUH2WRE5FThXwiXgIRjsBvtGft
	8ndqjpaLrtwvwkBwS+NONQ6TJAsQuStQSyTkN+O0UszKzrSEgltqk7Wx97eckvnQprgzLU
	FC7iWGf5yVXEQ43UKhVxmsyRHGfrLRS9cj0Y6M1cUYzCFf38Q1nqyDkWO9JfYEqw9q2l2X
	ij8kJy2zq/dNZptXwn0GCQzemjcjLSorDdBMjJat+/WSKyqrHpYZQCtGqPHyGRq/WRI68c
	WhHJfziRoTjbJHYn2kfJ2aZDRMnsZHVXQHogLR0/AK/dCgqTzV0oH6SZOq84kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761555551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ybiaUV4a6Vsi88Uvq6dlmsIATshHK9O4Qf7SiufJNw=;
	b=OASgF+9vW2CDwvx5oCFIS9G6EIeSZhb0dnrygKYWYHyCse3FFjKTP93Dsj40jqWt+xZnlf
	SpUTEqgO+X1ZugBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zilstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: Re: [patch V2 01/12] sched: Provide and use
 set_need_resched_current()
Message-ID: <20251027085910.zpFdjX8e@linutronix.de>
References: <20251022110646.839870156@linutronix.de>
 <20251022121426.964563578@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022121426.964563578@linutronix.de>

On 2025-10-22 14:57:29 [+0200], Thomas Gleixner wrote:
> set_tsk_need_resched(current) requires set_preempt_need_resched(current) to
> work correctly outside of the scheduler.
> 
> Provide set_need_resched_current() which wraps this correctly and replace
> all the open coded instances.
> 
> Signed-off-by: Peter Zilstra <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Peter's SOB comes first be he is not the author. Is this meant to be
Co-developed-by or is his authorship lost?

Sebastian

