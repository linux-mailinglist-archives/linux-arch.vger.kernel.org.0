Return-Path: <linux-arch+bounces-15742-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E825DD0E902
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 11:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEF9A300A34D
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706152FFF94;
	Sun, 11 Jan 2026 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moDtzZ+z"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D37843ABC;
	Sun, 11 Jan 2026 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768126929; cv=none; b=sgPyUVrx/SuJNyU9VLwE9HqTpEiCli7ZZIAb6VkfgY/l2PSmBrOSJAtgRJTrMaZxFbwg0kchcvBfgjg7waArnPXOf5bIokN9SGW+lci83tS7xu4QQ7iPDNT7MEUjgKVpUtvSpV44nAnQ2ncS4I1NOjfZN8dwm19Fopf7hoK+JWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768126929; c=relaxed/simple;
	bh=7DI9kCX35eJ8qUqgGHB1vnzVUdRCiYAyMXIE2aCaAqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NMp1qYZWpLV6+QwTCREl7PY/dDezWT3Ir/3V133vUFNvBN3oLKX0Po6ojKIEqtcgt4POxqN03KQkP1wIZrKjtJGJKCUx0jN1iSqrKec2jGW1+KwwwSOmu+16e31oojT+y3P0jqiouxnhOSjVYVmZOFtlIvB21ZTKbjaqSSLDRRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moDtzZ+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EDDC4CEF7;
	Sun, 11 Jan 2026 10:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768126929;
	bh=7DI9kCX35eJ8qUqgGHB1vnzVUdRCiYAyMXIE2aCaAqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=moDtzZ+znJjhUfCWG/SHtr7IK6xjJZamsHcsYQHKKdGg6HDcBTfGUgbKwIbp9irRg
	 8BtZeDv3z+FnoBPZVA4DB/yX8wVedVvaXdcwQH3zwNZAW0lvxe2d4SdRSvsJjpZltM
	 kCMBLeV9S1Qg3yoUDMABgy2+ay5JcRwMn0m2QUiYSlWuTZJ1BtZpalmNlydO1/PiAl
	 dl/D6jDTpYv5vnNa+trtJV6ynAAMcQ153aP6p5WOPuLCxLAEJaUUnL1FcPQZHOrJJm
	 XtOw6Bc6cez95Cbn6POmvJK0GwE/1jXwqFWeBFediYy4wO+uVPr1KDS27JRVqlDbRr
	 O3NV0Y2VAuwVQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Prakash Sangappa
 <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Peter
 Zijlstra <peterz@infradead.org>, Ron Geva <rongevarg@gmail.com>, Waiman
 Long <longman@redhat.com>
Subject: Re: [patch V6 09/11] rseq: Implement rseq_grant_slice_extension()
In-Reply-To: <87bjjvbc99.ffs@tglx>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.195303303@linutronix.de>
 <0cb26892-c68e-4a57-8029-8c582f868505@efficios.com> <87bjjvbc99.ffs@tglx>
Date: Sun, 11 Jan 2026 11:22:05 +0100
Message-ID: <87bjj0ih4i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 19 2025 at 00:28, Thomas Gleixner wrote:
> On Tue, Dec 16 2025 at 10:25, Mathieu Desnoyers wrote:
>> On 2025-12-15 13:24, Thomas Gleixner wrote:
>> [...]
>>> In case that the user space access faults or invalid state is detected, the
>>> task is terminated with SIGSEGV.
>>
>> It appears that only access faults trigger SIGSEGV. Perhaps removing
>> "or invalid state is detected" should be removed, or the code is missing
>> some state validation ?
>
> Seems I dropped a debug path somewhere down the road.

On purpose, so I reword the change log.

