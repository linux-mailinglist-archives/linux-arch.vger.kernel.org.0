Return-Path: <linux-arch+bounces-15148-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 185C9CA4930
	for <lists+linux-arch@lfdr.de>; Thu, 04 Dec 2025 17:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F0C1301BCD8
	for <lists+linux-arch@lfdr.de>; Thu,  4 Dec 2025 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CCC30ACF4;
	Thu,  4 Dec 2025 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wlU468Da";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nUWe7I08"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD7309EE5;
	Thu,  4 Dec 2025 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866142; cv=none; b=gFxDNSnekG0GKdhWIejlPfkhXqDtIJnfnXqf6D0Lsl2X9SWjIfHW+dQBp7Y+8rHgFulKxvwJQCCo1yHvPECEpxWpKso/gvOjlKHyGqjInyTTDIJYWZf4CVVpK4rtcyCeNZL4LPt59n/Bm0YqachO5qIKHpx0Bi2s6PMp+rEZiM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866142; c=relaxed/simple;
	bh=ZK5j4Mos9erTcnvY7uZcmV5BQINEcSPUXHRTvwzDEc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDeh1W/yNMTSKS998XJlxrHoWDiDQ3A3cjlrsfU+oqsZBpBtDBwdQfGpEjUwXDQq3oMbP+HD+3iAgGfaOSlUtPlvuzy9SKKTXCMnKgBCjLcfpfXl+M0ERf7utjZJ0r92YeXa6Y8KHT53iaPfRzZZZsc6qqwhY085gPiz/mxZ0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wlU468Da; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nUWe7I08; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Dec 2025 17:35:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764866138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u5OOvu0YVSd1nLnufJ14TYvhWRWFJuHvTPNPdB4XYBM=;
	b=wlU468DaKMO8EkpZvkkCkhq9J4E4iVbsbCUmVEDTcrPHrYGCkvTXSgGVjlEprCP/WbZVfM
	5YnaBfb1Oy5X/GaYmBYdArBYQelPQKLEjYHcBycmHLMB//H5YJYU/aHiEn6m9D3rRF/liV
	aIM7OTWIW3RCv51/TZKUXk9zldV9r4zIvlwtsqZXTgbVjEgSVp5qnadXa8mh0yTqS5JRl5
	9Wtd2PiaoaA0mq+dCou+fIbAXzPX3KB5ZBLttbGXnOsgpt2DpxWF2g7n4KOZGaPjCH9nzR
	DN0XPdIepokJi3aqtwqnT7eFUfV9KtX8biXC3tHc5eO6Uo6D5s4OHLLEOA7Tyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764866138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u5OOvu0YVSd1nLnufJ14TYvhWRWFJuHvTPNPdB4XYBM=;
	b=nUWe7I08GZRKhgZcGjG8ZfRC9Xl7GaLqca/h+8GyYmG3F/VxcQCHGqbJij7HA3HteQCHJ9
	HL7OoPj3zAJbo4CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH] rseq: Correct typo in the documentation.
Message-ID: <20251204163537.NXLRyaSa@linutronix.de>
References: <20251128225931.959481199@linutronix.de>
 <20251128230240.713174771@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251128230240.713174771@linutronix.de>

for consistency:
  s/slice_ctrl.request/slice_ctrl::request/
  s/reqeust/request

Please fold.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/userspace-api/rseq.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/rseq.rst b/Documentation/userspace-api/rseq.rst
index c7d1c651514a5..e1fdb0d5ce695 100644
--- a/Documentation/userspace-api/rseq.rst
+++ b/Documentation/userspace-api/rseq.rst
@@ -75,13 +75,13 @@ field via the ``RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT`` and the
 space and only for informational purposes.
 
 If the mechanism was enabled via prctl(), the thread can request a time
-slice extension by setting rseq::slice_ctrl.request to 1. If the thread is
+slice extension by setting rseq::slice_ctrl::request to 1. If the thread is
 interrupted and the interrupt results in a reschedule request in the
 kernel, then the kernel can grant a time slice extension and return to
 userspace instead of scheduling out. The length of the extension is
 determined by the ``rseq_slice_extension_nsec`` sysctl.
 
-The kernel indicates the grant by clearing rseq::slice_ctrl::reqeust and
+The kernel indicates the grant by clearing rseq::slice_ctrl::request and
 setting rseq::slice_ctrl::granted to 1. If there is a reschedule of the
 thread after granting the extension, the kernel clears the granted bit to
 indicate that to userspace.
-- 
2.51.0


