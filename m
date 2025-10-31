Return-Path: <linux-arch+bounces-14439-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F69BC25989
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 15:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB8FC4F425D
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 14:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80213271EB;
	Fri, 31 Oct 2025 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S7G8PDDT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gMH/vPZR"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AABD3446C4;
	Fri, 31 Oct 2025 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921241; cv=none; b=O6odbrKN3KjNg2pGb6eERNExdd7Mdn6XybQxusr8cewJpd85ycyOFyOKPiM47reTZ/xcGkQgYCj/SlElQA2E8J8R2XgW4ik5Cj7ht71eGy5HYFwWMN8y/kzj5ldpCgHimVNxDb1RLcyPrbGJMggYlHn/bdkLW5K75JRQaZMI0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921241; c=relaxed/simple;
	bh=oCd32TGYosUpHI2g3izm4DtPefSiFGd2NNA9FWdwD8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SHYqQXGB1mjpmnkbikjhtG0rCz4v/hq1B7O9Jdh64/MnLkwoYpcu7v4Sy3FML3F671sJY9bUXs6p5Ay93bJSE/W5WuqZLV4VSvdkaFPc+uUgVeG4p+u/qALPvgqUa8iuEdI8x9YFom87aOVcw1CyTrGdCozauNpzNf3DUtcAJYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S7G8PDDT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gMH/vPZR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761921238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gPrkOyHw+jtitSd/styaLzTyEK55/gfEC8zn4XBenY=;
	b=S7G8PDDTaMzYQXgvAKT7I1z+Htgj7YspvF/MjvT9K32jS7wWQCBWOD/2isW2alYn+ofsaa
	klEvAn4hF/q7Q3bK3k2+sroLczxPsfVhVyswCi/KNf5KQm/5H7UWS1eqf0/Wbtf/DaL+KT
	va+F68jq8hteaBWO7p55+r7aGNvrsmZ3bXmT++l2kO4M75Tn+F9cQgQaOWPd7iVVhLQMIb
	V6I1sCgQtQno3I6ezfam/098t8Z2DWGQVmlwupkfBq95uwFAXMs4/Cg5rfBYw4FLwbKP6N
	Eaakx2UZx/tbXhPD6B5RPRg9so5tqMRG8ieYbRB6AN0aM9aJB1KnpfVd7Bh8xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761921238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gPrkOyHw+jtitSd/styaLzTyEK55/gfEC8zn4XBenY=;
	b=gMH/vPZR8GcSIU/cE5e1OQ5x8erfDDZMfWClo+57aZEjik7nkfYqXgNgD91uVqUg2Oqtio
	t93M2uEF+r1uvHCA==
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann
 <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [patch V3 10/12] rseq: Implement rseq_grant_slice_extension()
In-Reply-To: <20251029180446.7b18c9a2@gandalf.local.home>
References: <20251029125514.496134233@linutronix.de>
 <20251029130404.051555060@linutronix.de>
 <20251029160859.22bb6eed@gandalf.local.home> <87jz0dtm8r.ffs@tglx>
 <20251029180446.7b18c9a2@gandalf.local.home>
Date: Fri, 31 Oct 2025 15:33:58 +0100
Message-ID: <87346zta21.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 29 2025 at 18:04, Steven Rostedt wrote:

> On Wed, 29 Oct 2025 22:46:12 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> Can you please trim your replies as anybody else does?
>
> I did trim it. I only kept the function in question, but deleted everything
> else.
>
> I do like to keep a bit of context, as sometimes I find people tend to trim
> a bit too much.

That's fine, but leaving stale quotes after

       Steve

is not.

