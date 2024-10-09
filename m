Return-Path: <linux-arch+bounces-7897-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BBA996660
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 12:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851361F26274
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8735418B482;
	Wed,  9 Oct 2024 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fT+uLwJG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pwxhsujb"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2270517CA04;
	Wed,  9 Oct 2024 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468254; cv=none; b=nfOg0E5OK/FXL7rQdJv0exXgS+08o+MuO4KdT60BKXV+S0PdhchTS6JAC4siDetEL1ua4/fIZPOotRnXATMpCvewoY/fvkOsUjbx+cYTOw/sqVvP8183vDaYpN+6qlEog2N1bRcBnB9o8LHYx94e9KlsTQosTZAkEuMjj0nHfho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468254; c=relaxed/simple;
	bh=uqux3LZjBiH35wR54jDv1DxdNgwapSWmE2ElMrJUX2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RNXsIJHSN6YZevfRD6vqV7NaLrLxZWAu6aFh7gzP3VccaOkWlt/oFot3ESdFgZEzso7ckTxdEqPX9XMiuc9IOfu6XW10k8uqGuYmP77fFENDdgWvIDv6LH4oNVWdQPHzRG8v6vaBV+v9kTXADNzb6x/XM1gcnU2Vj3RkUT9mfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fT+uLwJG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pwxhsujb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728468251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VqM5mJyDw9Ql1uPyq64L7WIHHRrQGw9HNJdOd80gGrI=;
	b=fT+uLwJG6gzAO8cpH9Ta7tMQszEwa4jBtcXMkb4lpKC25PJdTW97I5jxnI/ZdkHNZhmMZu
	j2YJwDxdImHSwbTVm0CsAm2HY7tu77/ll9taoXaTtR3EnAKrMjj1XJjRcRv7/T8LLmF2UH
	y8g75t4O9ojVNEIZ5z2pdBJyuUHcq4b5ffRWb7ZSQd9f6140RxNFeZA0q7KdQGSco4IQap
	k1LUcKHhWcXFnYvykJKJfPLnuWYcytDkVSFZEbYZGHXO8N4aFlue9x50a2G9qhfXMoGzrj
	RIUuwPKch/d39yOjbtX2xrnG0kfAfohwpGb5rv2ZrX+JVNNRPdKf34vR+uwZXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728468251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VqM5mJyDw9Ql1uPyq64L7WIHHRrQGw9HNJdOd80gGrI=;
	b=PwxhsujbwsPChlrjAC+K8L88Nq+Mp1cXdMkoZP2CHMgWh7gRbtCgQYI2dC5rWIK34bLIKf
	wmvbUSGFPQVp0gCQ==
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Andy Lutomirski
 <luto@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann
 <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
In-Reply-To: <87wmihr49g.ffs@tglx>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-3-vincenzo.frascino@arm.com> <87wmihr49g.ffs@tglx>
Date: Wed, 09 Oct 2024 12:04:10 +0200
Message-ID: <87ttdlr3s5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 09 2024 at 11:53, Thomas Gleixner wrote:
> On Thu, Oct 03 2024 at 16:29, Vincenzo Frascino wrote:

Hit send too early.

>> +#if defined(CONFIG_PHYS_ADDR_T_64BIT)
>> +#define PAGE_MASK	(~((1 << CONFIG_PAGE_SHIFT) - 1))

This really wants a comment. The magic reliance on integer sign
expansion is any thing than obvious.

Thanks,

         tglx

