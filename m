Return-Path: <linux-arch+bounces-13477-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878B1B51AC3
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 17:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAB15637DF
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281FC35335D;
	Wed, 10 Sep 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lQikHWe4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5M+9Xa76"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3235334B;
	Wed, 10 Sep 2025 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515853; cv=none; b=KrcZf5zyNBIKfXETH1mZU8JcwNBAX82rbpZf1SpmVeKhwA8GgMYv+lFDRnIZDeQ6AzzDg49wBB25GX04wc4sJ4fNRXTKpMNF07o5rAATeJ2ijBJMYp5poey+kZoLPsYV8D+IsCvAp+9RZs6Z1HC/wWS2VO68Spt1JvZo8FuQwF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515853; c=relaxed/simple;
	bh=DJptd2zjz28L10C0JfTENFJ7zo1YVNAAOo/+zOOeXu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=As+lvgWZdadjBO83rBRglb/LfqymlsCxxbusVaveT+fDhhnPLPzycFzDqbmoJwVCrhZcRVaQsmaTINSjwWRMadnI4baQbmdpgjhYWEAQJXXBhiWsAfDXbXEnhVbH2Kvchgali0A6UH4uE0ESibJ6tNXYwj0H08Z4on2z+Z8G89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lQikHWe4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5M+9Xa76; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757515849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxEWlS+AG6TfpOIhmnMfpD037DMEs6bTLT6xRjibUFU=;
	b=lQikHWe4wkB1v9hpe3EhDjzyKRK5otgG6msDwIaSiaZBCCQIjZw/KK8f0B4kv4TTekNiRK
	SQuv9mjUz9ZUJh/Nr7tHvj4cx/DIbV2qNJLr2LzjnW9Z2wWSGx+LDan+VvpkHnnsid91f5
	Hu0mUsEHjkRQD5JemaLC8WBNb/Cm9p3/8MWueWcGxL4jfAm1tVjEZRsRmaUZsmC4szto/H
	8SJEXOXNvdUQhUV2R6VBDvZfnUsHTLOUxhDZLHDNqnP42QI1I3x2ghPYo0J1MLo9fmCcAk
	ntYWy0FJ57FFXlJKL7Q/GG+zISN5WmyodREzd7RJI274VWVlSaPVtDpbb6/Vuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757515849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxEWlS+AG6TfpOIhmnMfpD037DMEs6bTLT6xRjibUFU=;
	b=5M+9Xa76PKfE2O4m3bELqoh/C7E2WN0BYOmRPJa6GOUGRbYDWSabnqhH6K1BW5KivlRuEc
	U69vKoKQRib65VCg==
To: K Prateek Nayak <kprateek.nayak@amd.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zilstra <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash
 Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch 00/12] rseq: Implement time slice extension mechanism
In-Reply-To: <e2b2d2dc-adfd-46db-85ec-a09590fcb399@amd.com>
References: <20250908225709.144709889@linutronix.de>
 <e2b2d2dc-adfd-46db-85ec-a09590fcb399@amd.com>
Date: Wed, 10 Sep 2025 16:50:48 +0200
Message-ID: <87ecsetl87.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 10 2025 at 16:58, K. Prateek Nayak wrote:
> On 9/9/2025 4:29 AM, Thomas Gleixner wrote:
>> For your convenience all of it is also available as a conglomerate from
>> git:
>> 
>>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice
>
> Apart from a couple of nit picks, I couldn't spot anything out of place
> and the overall approach looks solid. Please feel free to include:
>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thanks a lot for going through it and testing.

Do you have a real workload or a mockup at hand, which benefits
from that slice extension functionality?

It would be really nice to have more than a pretty lame selftest.

thanks,

        tglx

