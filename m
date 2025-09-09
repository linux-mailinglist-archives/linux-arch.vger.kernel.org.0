Return-Path: <linux-arch+bounces-13435-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE86EB49DCF
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 02:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E30F3BCC8C
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 00:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4BC639;
	Tue,  9 Sep 2025 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wi6vX0iw"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AC71EA65;
	Tue,  9 Sep 2025 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757376266; cv=none; b=syQOtjmU+524Vxl8ShWXfZRb6LYV5IJ9dkn6uAavleO2iG37+AT3gMAQzB0pCrasP1q0YnIN25vchRAAzzFw2QLjefb2YdJbSz24qjLWVYat/1M5/RYgkHIiyflHLNC+paDNRXPZGfQIx0LkuKBnOSn8C/ifRbJ9VaVVvmZKce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757376266; c=relaxed/simple;
	bh=pRZjHQoFH62EYaeMpsF4DR0l84AzCwps4zDvT4iDhU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWYyH6k4IzXQF00y/q2OEbWTyz5gr/CJ24iGE3Jn75CmSRW+FxDaqe4qodDDSK5JFbQFMLJmkoul5XGoK8SVovxyq5YVS8oqMR1qIitnzQG0z3/du8hQNh+DjxiR7MBaRMe7n5lonnZ/5wtaYpwRgJ9HJB8lKIVHajAHUCpqisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wi6vX0iw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=PLJuzxS4XydjJQvP7zCb6sZSVl2ofWt7QvMJnd1o/8Q=; b=wi6vX0iwjKg2ehIRoRPHG6QaNT
	AjcHBXYW6Xr4kmIEytTALJSer340j9SXaoz8mZ5dstagUx/UuM4fpdX/8C6ZdMnTtXRV8URAQVBO9
	dKeLPR97eeeNtQ+giryXShgDL9EdCyl1NyQYu4mxrT7XWQ3VHjJbM97gA455YYfiYWQNJuv1JjHql
	g5k/sXeAndm5BURdBZYXc8DCX6hDwUtLQornAIUT7nbk2tXsG7J1wv9eVpWs7uV5T5S453voNoH6Y
	RAjD0ie5O0vvthPKV2tq+VwGrAQiQyaUS2BfCDM7Dcia96sxOMu2l2RWJHdvdXwSYsRZ6A4eaZS2/
	gNyvxHMw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvlqR-000000038vC-3Urr;
	Tue, 09 Sep 2025 00:04:23 +0000
Message-ID: <f014e40a-a994-4c49-bcaa-c29be885fd3d@infradead.org>
Date: Mon, 8 Sep 2025 17:04:23 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 02/12] rseq: Add fields and constants for time slice
 extension
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.679815003@linutronix.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250908225752.679815003@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thomas,

On 9/8/25 3:59 PM, Thomas Gleixner wrote:
> Aside of a Kconfig knob add the following items:
> 

> ---
>  Documentation/userspace-api/index.rst |    1 
>  Documentation/userspace-api/rseq.rst  |  129 ++++++++++++++++++++++++++++++++++
>  include/linux/rseq_types.h            |   26 ++++++
>  include/uapi/linux/rseq.h             |   28 +++++++
>  init/Kconfig                          |   12 +++
>  kernel/rseq.c                         |    8 ++
>  6 files changed, 204 insertions(+)
> 

> --- /dev/null
> +++ b/Documentation/userspace-api/rseq.rst
> @@ -0,0 +1,129 @@
> +=====================
> +Restartable Sequences
> +=====================
> +
> +Restartable Sequences allow to register a per thread userspace memory area
> +to be used as an ABI between kernel and user-space for three purposes:

userspace or user-space or user space -- be consistent, please.
(above 2 times, and more below)

FWIW, "userspace" overwhelmingly wins in the kernel source tree.
On the $internet it looks like "user space" wins (quick look).


> +
> + * user-space restartable sequences
> +
> + * quick access to read the current CPU number, node ID from user-space
> +
> + * scheduler time slice extensions
> +
> +Restartable sequences (per-cpu atomics)
> +---------------------------------------
> +
> +Restartables sequences allow user-space to perform update operations on
> +per-cpu data without requiring heavy-weight atomic operations. The actual
just                              heavyweight

> +ABI is unfortunately only available in the code and selftests.
> +
> +Quick access to CPU number, node ID
> +-----------------------------------
> +
> +Allows to implement per CPU data efficiently. Documentation is in code and
> +selftests. :(
> +
> +Scheduler time slice extensions
> +-------------------------------
> +
> +This allows a thread to request a time slice extension when it enters a
> +critical section to avoid contention on a resource when the thread is
> +scheduled out inside of the critical section.
> +
> +The prerequisites for this functionality are:
> +
> +    * Enabled in Kconfig
> +
> +    * Enabled at boot time (default is enabled)
> +
> +    * A rseq user space pointer has been registered for the thread

                ^^^^^^^^^^

> +
> +The thread has to enable the functionality via prctl(2)::
> +
> +    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
> +          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);
> +
> +prctl() returns 0 on success and otherwise with the following error codes:
> +
> +========= ==============================================================
> +Errorcode Meaning
> +========= ==============================================================
> +EINVAL	  Functionality not available or invalid function arguments.
> +          Note: arg4 and arg5 must be zero
> +ENOTSUPP  Functionality was disabled on the kernel command line
> +ENXIO	  Available, but no rseq user struct registered
> +========= ==============================================================
> +
> +The state can be also queried via prctl(2)::
> +
> +  prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_GET, 0, 0, 0);
> +
> +prctl() returns ``PR_RSEQ_SLICE_EXT_ENABLE`` when it is enabled or 0 if
> +disabled. Otherwise it returns with the following error codes:
> +
> +========= ==============================================================
> +Errorcode Meaning
> +========= ==============================================================
> +EINVAL	  Functionality not available or invalid function arguments.
> +          Note: arg3 and arg4 and arg5 must be zero
> +========= ==============================================================
> +
> +The availability and status is also exposed via the rseq ABI struct flags
> +field via the ``RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT`` and the
> +``RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT``. These bits are read only for user

                                                          read-only for

> +space and only for informational purposes.

   userspace ?

> +
> +If the mechanism was enabled via prctl(), the thread can request a time
> +slice extension by setting the ``RSEQ_SLICE_EXT_REQUEST_BIT`` in the struct
> +rseq slice_ctrl field. If the thread is interrupted and the interrupt
> +results in a reschedule request in the kernel, then the kernel can grant a
> +time slice extension and return to user space instead of scheduling

                                      ^^^^^^^^^^

> +out.
> +
> +The kernel indicates the grant by clearing ``RSEQ_SLICE_EXT_REQUEST_BIT``
> +and setting ``RSEQ_SLICE_EXT_GRANTED_BIT`` in the rseq::slice_ctrl
> +field. If there is a reschedule of the thread after granting the extension,
> +the kernel clears the granted bit to indicate that to user space.

                                                         ?

> +
> +If the request bit is still set when the leaving the critical section, user
> +space can clear it and continue.

   ?

> +
> +If the granted bit is set, then user space has to invoke rseq_slice_yield()

                                       ?

> +when leaving the critical section to relinquish the CPU. The kernel
> +enforces this by arming a timer to prevent misbehaving user space from

OK, I think that you like "user space".  :)

> +abusing this mechanism.
> +
> +If both the request bit and the granted bit are false when leaving the
> +critical section, then this indicates that a grant was revoked and no
> +further action is required by user space.
> +
> +The required code flow is as follows::
> +
> +    rseq->slice_ctrl = REQUEST;
> +    critical_section();
> +    if (!local_test_and_clear_bit(REQUEST, &rseq->slice_ctrl)) {
> +        if (rseq->slice_ctrl & GRANTED)
> +                rseq_slice_yield();
> +    }
> +
> +local_test_and_clear_bit() has to be local CPU atomic to prevent the
> +obvious RMW race versus an interrupt. On X86 this can be achieved with BTRL
> +without LOCK prefix. On architectures, which do not provide lightweight CPU

                          no comma      ^

> +local atomics this needs to be implemented with regular atomic operations.
> +
> +Setting REQUEST has no atomicity requirements as there is no concurrency
> +vs. the GRANTED bit.
> +
> +Checking the GRANTED has no atomicity requirements as there is obviously a
> +race which cannot be avoided at all::
> +
> +    if (rseq->slice_ctrl & GRANTED)
> +      -> Interrupt results in schedule and grant revocation
> +        rseq_slice_yield();
> +
> +So there is no point in pretending that this might be solved by an atomic
> +operation.
> +
> +The kernel enforces flag consistency and terminates the thread with SIGSEGV
> +if it detects a violation.

> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -23,9 +23,15 @@ enum rseq_flags {
>  };
>  
>  enum rseq_cs_flags_bit {
> +	/* Historical and unsupported bits */
>  	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
>  	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
>  	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
> +	/* (3) Intentional gap to put new bits into a seperate byte */

	                                              separate
("There is a rat in separate." -- old clue)
           'arat'

> +
> +	/* User read only feature flags */
> +	RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT	= 4,
> +	RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT	= 5,
>  };
>  
>  enum rseq_cs_flags {

> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1908,6 +1908,18 @@ config RSEQ_DEBUG_DEFAULT_ENABLE
>  
>  	  If unsure, say N.
>  
> +config RSEQ_SLICE_EXTENSION
> +	bool "Enable rseq based time slice extension mechanism"

	             rseq-based

> +	depends on RSEQ && HIGH_RES_TIMERS && GENERIC_ENTRY && HAVE_GENERIC_TIF_BITS
> +	help
> +          Allows userspace to request a limited time slice extension when

Use tab + 2 spaces above instead of N spaces.

> +	  returning from an interrupt to user space via the RSEQ shared
> +	  data ABI. If granted, that allows to complete a critical section,
> +	  so that other threads are not stuck on a conflicted resource,
> +	  while the task is scheduled out.
-- 
~Randy


