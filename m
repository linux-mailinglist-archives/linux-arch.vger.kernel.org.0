Return-Path: <linux-arch+bounces-14271-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FD4BFD990
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 19:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F743ADEB9
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812E29B8DD;
	Wed, 22 Oct 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kQXFPqMv"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201929B78D;
	Wed, 22 Oct 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154110; cv=none; b=gW1HhEA8FlHAFlfJt7d8d+7wyBeI/0a4+Znb96StTTGdkC/00H+LK3ZeNITBqCEoBScfVI8XhTLWIGTzTWxRau2EyKQT5Kn1Q3LnHvYC1Hf9mG2096wFxlHOPjODPpnvvYPtncAiRrZq/I+YfPbupccyvKvypwWuaoRxvQy2Js8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154110; c=relaxed/simple;
	bh=XzpKKYk70n+O7csNDShGMEPOxFvJZZ6PB/Gl7PvoGoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tf3mNNf/Np8DEAAVUhQ9BkWzu8G/Gb7hYmIVfiEWV2ieherYwEMm16wKwcPSsEhwZ0sn4X6KFnTadVJr7MeAJ+sea3fnKiMJYbIj8RzqkFAWjDJziYkoSBmPVBqHeGYYw8fRjqNoPnBkdon7gxB+9V8A3F1nB8FUfHYs78/i1tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kQXFPqMv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0A86jCSTfoAmqfzHUOzrsEw1o6iDN86N57Hdat6jHAw=; b=kQXFPqMv0MosKqHkAwSI+LFRJp
	MwsxwRmyN6X8BnJCy32oeo2aUC4yukUf6mfKe4d98EpFgpl/mugH4KBq3swt7wlKi3WcnAJZI3LfU
	6ScMDn3DPnopurEfgcLpU/iWU4LOqn7QZ/erWq3HkDOlaErNX4EDmSG5+fNuwd5vOANjiWmsoxeFp
	UmfZaLYxLUK1fXwTe89rBz0tGbO7jEE1tXmkQX6n5TivWSk3ZnWOo0zdKg7F4V00eTP4PmUUcKIjT
	ai6XOoEAPyD9ZF2BUmeTr3xRKPF0J+0pPXq9p4npIORkpehuPfquXTUFlDorTHLdnWF8tqstOTCCk
	MUm6Linw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBcdM-00000003mua-06Dx;
	Wed, 22 Oct 2025 17:28:24 +0000
Message-ID: <3ff33b45-a47e-4a7b-86d9-45f44794071b@infradead.org>
Date: Wed, 22 Oct 2025 10:28:23 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 02/12] rseq: Add fields and constants for time slice
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
References: <20251022110646.839870156@linutronix.de>
 <20251022121427.028021177@linutronix.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251022121427.028021177@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/25 5:57 AM, Thomas Gleixner wrote:
> Aside of a Kconfig knob add the following items:
> 
>    - Two flag bits for the rseq user space ABI, which allow user space to
>      query the availability and enablement without a syscall.
> 
>    - A new member to the user space ABI struct rseq, which is going to be
>      used to communicate request and grant between kernel and user space.
> 
>    - A rseq state struct to hold the kernel state of this
> 
>    - Documentation of the new mechanism
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Prakash Sangappa <prakash.sangappa@oracle.com>
> Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> V2: Fix Kconfig indentation, fix typos and expressions - Randy
>     Make the control fields a struct and remove the atomicity requirement - Mathieu
> ---
>  Documentation/userspace-api/index.rst |    1 
>  Documentation/userspace-api/rseq.rst  |  118 ++++++++++++++++++++++++++++++++++
>  include/linux/rseq_types.h            |   26 +++++++
>  include/uapi/linux/rseq.h             |   38 ++++++++++
>  init/Kconfig                          |   12 +++
>  kernel/rseq.c                         |    7 ++
>  6 files changed, 202 insertions(+)
> 

> --- /dev/null
> +++ b/Documentation/userspace-api/rseq.rst
> @@ -0,0 +1,118 @@
> +=====================
> +Restartable Sequences
> +=====================
> +
> +Restartable Sequences allow to register a per thread userspace memory area
> +to be used as an ABI between kernel and userspace for three purposes:
> +
> + * userspace restartable sequences
> +
> + * quick access to read the current CPU number, node ID from userspace
> +
> + * scheduler time slice extensions
> +
> +Restartable sequences (per-cpu atomics)
> +---------------------------------------
> +
> +Restartables sequences allow userspace to perform update operations on

   Restartable

> +per-cpu data without requiring heavyweight atomic operations. The actual
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
> +    * A rseq userspace pointer has been registered for the thread

I would write:  An rseq ...
but it depends on how someone treats (or speaks or thinks) "rseq."
I say/think of it as are-seq, so using "An" makes sense.

> +
> +The thread has to enable the functionality via prctl(2)::
> +
> +    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
> +          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);
> +
> +prctl() returns 0 on success and otherwise with the following error codes:

                                or

> +
> +========= ==============================================================
> +Errorcode Meaning
> +========= ==============================================================
> +EINVAL	  Functionality not available or invalid function arguments.
> +          Note: arg4 and arg5 must be zero
> +ENOTSUPP  Functionality was disabled on the kernel command line
> +ENXIO	  Available, but no rseq user struct registered
> +========= ==============================================================


[snip]> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -73,12 +73,35 @@ struct rseq_ids {
>  };
>  
>  /**
> + * union rseq_slice_state - Status information for rseq time slice extension
> + * @state:	Compound to access the overall state
> + * @enabled:	Time slice extension is enabled for the task
> + * @granted:	Time slice extension was granted to the task
> + */
> +union rseq_slice_state {
> +	u16			state;
> +	struct {
> +		u8		enabled;
> +		u8		granted;
> +	};
> +};
> +
> +/**
> + * struct rseq_slice - Status information for rseq time slice extension
> + * @state:	Time slice extension state
> + */
> +struct rseq_slice {
> +	union rseq_slice_state	state;
> +};
> +
> +/**
>   * struct rseq_data - Storage for all rseq related data
>   * @usrptr:	Pointer to the registered user space RSEQ memory
>   * @len:	Length of the RSEQ region
>   * @sig:	Signature of critial section abort IPs

                             critical

>   * @event:	Storage for event management
>   * @ids:	Storage for cached CPU ID and MM CID
> + * @slice:	Storage for time slice extension data
>   */
>  struct rseq_data {
>  	struct rseq __user		*usrptr;
> @@ -86,6 +109,9 @@ struct rseq_data {
>  	u32				sig;
>  	struct rseq_event		event;
>  	struct rseq_ids			ids;
> +#ifdef CONFIG_RSEQ_SLICE_EXTENSION
> +	struct rseq_slice		slice;
> +#endif
>  };
>  
>  #else /* CONFIG_RSEQ */
-- 
~Randy


