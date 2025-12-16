Return-Path: <linux-arch+bounces-15455-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F6BCC1469
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 08:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA83B3033DF0
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 07:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCA633CEB5;
	Tue, 16 Dec 2025 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dmxmx1Fv"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4380F33FE01;
	Tue, 16 Dec 2025 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869504; cv=none; b=J8mgAzTmlgd+3QiGo3/jCnso/Jqx6MXgR/80h4x4qMWW3HeV0zRjaFVy5PvzDqLKjFETHKkSLj1TMkS/qKpi2uYKw+Y4wMwePHlCuXaGCTuav4l8ygeCzsk0OQq8y/ZY+AC02Klm8OeO1G3XQPpy5hI4JbavLUocvceMIsab7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869504; c=relaxed/simple;
	bh=AEYGuJEEEYmmmJXdme01cBI/6wB0Oph/64QmJVnKM74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rmg5JlQhfUNRC/j81B8CHSenqIN6mjjMSR6CmuaQOke7ORHQpcVh2k+ZAgmC75tq+/IS0zk+ishbMVT8KFZq1NYcek7+4qfPl7t3LcI2J2d89XC/lB82Xfw8BwM0ngVWnujuAwTU4Z7KQ7npFZzBGyA0re2JGPX/24fqnlqITZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dmxmx1Fv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VJk0H7KdNrMiS7Qd0o8Uv7On5HN+SnJoFk1KRPPZ2Fk=; b=dmxmx1FvSFfIFY4oXSCMwCTj4E
	Kdd5MnIDvEdswcqw5moYk5tkJaCZhgePsa7byaHwEzuOA1YaJP3k0KZT7XZCW7dlWb7XoRrEutpzn
	eeB4duKxzfKocD6L293ywFFHXaK/0UL4/IePKqs0LziPBKuVnzqOYo9BjTCNZANmaYc6bTBZstGTj
	Nso8/WqieagrlwDHrjeE3Cdr6xAhMuIq2q4RGhYvY07Lab2BHJpGpfTtuqth68r2claDzuWk+FC1l
	vOY8Qy1a8Z9xztVkBKwBrEujkwweQ46kdN6xKSnJdxS1CEsShyl0rIE9n140ZYx7ooBHd7KcofxHP
	DUpc3DOg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVPK5-00000004pyN-2hXc;
	Tue, 16 Dec 2025 07:18:17 +0000
Message-ID: <d1dcaa6c-98fc-4d02-a958-209c54d8374b@infradead.org>
Date: Mon, 15 Dec 2025 23:18:16 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 07/11] rseq: Implement time slice extension enforcement
 timer
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ron Geva <rongevarg@gmail.com>,
 Waiman Long <longman@redhat.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.068329497@linutronix.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251215155709.068329497@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ouch. Would you mind rearranging parts of the first sentence?

On 12/15/25 10:24 AM, Thomas Gleixner wrote:
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1228,6 +1228,14 @@ reboot-cmd (SPARC only)
>  ROM/Flash boot loader. Maybe to tell it what to do after
>  rebooting. ???
>  
> +rseq_slice_extension_nsec
> +=========================
> +
> +A task can request to delay its scheduling if it is in a critical section
> +via the prctl(PR_RSEQ_SLICE_EXTENSION_SET) mechanism. This sets the maximum
> +allowed extension in nanoseconds before scheduling of the task is enforced.
> +Default value is 30000ns (30us). The possible range is 10000ns (10us) to
> +50000ns (50us).

Maybe
A task that is in a critical section can request to delay its scheduling via
the prctl(PR_RSEQ_SLICE_EXTENSION_SET) mechanism.

-- 
~Randy


