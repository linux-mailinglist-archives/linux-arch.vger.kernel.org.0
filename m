Return-Path: <linux-arch+bounces-14687-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F0C54AA7
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 22:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66444340FEF
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC682E62C0;
	Wed, 12 Nov 2025 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MADdVJDY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GP6NBbif"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631F429B233;
	Wed, 12 Nov 2025 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984651; cv=none; b=W1CkSBm96HGVPDj5xsTVUKcijsUzdOvkXTqSr7kW8BHXi5KigUhaSAUh51gB34ukzcCyDJMf9joo2nnZTiUOByacVGCb1PyrRY8D4JvamvgugmDtqBHzMqX9fiHwWK/3E8AbltT6p6NDLGB54w9GmMb8B0fx5/X+nhD8YHP/ae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984651; c=relaxed/simple;
	bh=mkOEgj2acWYW3QgEMNEaG8bU+/P170whur803Yam0ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lVQSFz6G4WH2428dJMmcFJxHLuitZLRqq2l8lMtZZH2BR4gMq7u5T/hqD6YMKRvVy+NL7wMq8WbNJ1tLCR7QBXAiwtMd1bM3ZxxkkXugpQ/ZEsTzseqbuR+R92arK7pqo6SXghWX+5hAw4uzlJ4CthMCjqc7SOqE24p17jgpPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MADdVJDY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GP6NBbif; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762984648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQmPFrko68lFDC866Huq+wp9LzzLLlaGuL5IsTID5Qo=;
	b=MADdVJDYEPVjXl5hUf/4cAxdxnWEfoHCpsGhFnByHQKhbWtOomd23WXTn5ZGWVvQnLdmN0
	oz1iaNVvtd3kvhbgTWU5AYMPQjimP3jkntioflV2bqg1smN3HanPuLzwN1m3j5YoRIXZyC
	ytyLBVXaoTRXiPXwOGONNl1Jb6gZKSE7tvd65MJbXxEzZfpb+dyvc6q4qJYQNx2sL3YLLV
	j8I4jVJdmVPpO+3LWCiGI++LsnW+IqmvfMUNI+/sFphH2p4+egQtS8S534675Uj5RYvGAK
	Hq7ovANEDkNY//7SMy51HoHpp3PLm+PlgF+dZDcUwdccJIRkcWOG0q7Y6ZfgTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762984648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQmPFrko68lFDC866Huq+wp9LzzLLlaGuL5IsTID5Qo=;
	b=GP6NBbifM+KA2vlmk1e9Cn8NhjUfqZKJ3EdLeRmag3DNGdhKPsPncSfvpG2zXgp6mp2iIC
	Of1ATE8jlCJ9KWCA==
To: Prakash Sangappa <prakash.sangappa@oracle.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann
 <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
In-Reply-To: <F940B2E6-2B76-4008-98B9-B29C27512A60@oracle.com>
References: <20251029125514.496134233@linutronix.de>
 <03687B00-0194-4707-ABCB-FB3CD5340F11@oracle.com>
 <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
 <b28c9f26-7a79-473c-a390-f502b74b02ac@efficios.com>
 <F940B2E6-2B76-4008-98B9-B29C27512A60@oracle.com>
Date: Wed, 12 Nov 2025 22:57:27 +0100
Message-ID: <87cy5mewxk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 12 2025 at 06:30, Prakash Sangappa wrote:
> The problem reproduces on a 2 socket AMD(384 cpus) bare metal system.
> It occurs soon after system boot up.  Does not reproduce on a 64cpu VM.

Can you verify that the top most commit of the rseq/slice branch is:

    d2eb5c9c0693 ("selftests/rseq: Implement time slice extension test")

Thanks,

        tglx

