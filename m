Return-Path: <linux-arch+bounces-14425-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C4C1D8D8
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 23:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19C894E2F16
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 22:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF52F5A32;
	Wed, 29 Oct 2025 22:04:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108382D3728;
	Wed, 29 Oct 2025 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761775458; cv=none; b=l12QJm7ZK9VgObXHilmIcm8Wo73y1OQbsjD7sSMFRqiENgpZn1fov4I7DAdj9X6bC2eBAxvfo/OGpvldyzjqtdHL6yp9NYPMpvw5Y3kbjuRRglZzC0WEYEK6vpVW4LBpve9i4BWPUw5rGfJSfSiG5EWE/qYcLR4Nbe5XZS34C+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761775458; c=relaxed/simple;
	bh=0wXBB55h3J8kYp+h0C+vMfIEmTVmrRzpv6PS3VrDfe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSWjbng8N85n+GoKIcRJQQXjTmIb2FUvXg574goND7NkhGtLUdM9VZxdz7CQqvEki4ZWotnXOs2iRJvUCpbsrz4iYp/1iXWJSSTP2HNTlw+wmimW30/Ul4uQZxLer2JQuSv03BBz/yh1kBY6tfiXjB5XuLyKQZOAu80wJfJplqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id B821949B89;
	Wed, 29 Oct 2025 22:04:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 1B1FA18;
	Wed, 29 Oct 2025 22:04:05 +0000 (UTC)
Date: Wed, 29 Oct 2025 18:04:46 -0400
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
Message-ID: <20251029180446.7b18c9a2@gandalf.local.home>
In-Reply-To: <87jz0dtm8r.ffs@tglx>
References: <20251029125514.496134233@linutronix.de>
	<20251029130404.051555060@linutronix.de>
	<20251029160859.22bb6eed@gandalf.local.home>
	<87jz0dtm8r.ffs@tglx>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xarz6641f6bjm7onnrm85wteihsmhrx9
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 1B1FA18
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/666O0KN0e2CvIP26g20/zbTRuauAGAOI=
X-HE-Tag: 1761775445-203404
X-HE-Meta: U2FsdGVkX181YGM6KIyA9vosF/KQVc+Q6JbjllTvvHbuv6c5BQjXKF4cGNBAof89+3EgcPs3H63iK4cdBgZtiJyWDCQeFyrvY91sx0iMtx9gJ3lIYzkMm9HJuRhP+ZE8HIbemCemmYxNUScmwc0k1rX6PHFchljmt01subYbSQYfXWik5SIY2X6OReINKe0UA0lNZggtsLA+9C/x6Gctx3c8YyCaVVflxPnJIA4UIU6YeEAkX3u+eR0P35ihOSux11EF+3OELzcKFQ2X0CPHHeeUqg/T5OSp0I0acN6LOT7nqdVwm+ckmGe6Y/X80gjTMqqkJ0KHLh/zuqD7gwy8jgklrp7wZoNeVskcfgPWMNo=

On Wed, 29 Oct 2025 22:46:12 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> Can you please trim your replies as anybody else does?

I did trim it. I only kept the function in question, but deleted everything
else.

I do like to keep a bit of context, as sometimes I find people tend to trim
a bit too much.

-- Steve

