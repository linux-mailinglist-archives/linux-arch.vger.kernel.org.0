Return-Path: <linux-arch+bounces-14495-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93703C2E936
	for <lists+linux-arch@lfdr.de>; Tue, 04 Nov 2025 01:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 404F44E692B
	for <lists+linux-arch@lfdr.de>; Tue,  4 Nov 2025 00:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07414C5B0;
	Tue,  4 Nov 2025 00:20:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85591D554;
	Tue,  4 Nov 2025 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215652; cv=none; b=OBK66V1zX+D3U8ICF/GgkEIFuaJxvYskcVupZyvE7sl2NAJM68IYqIGd7r8Pr2Nl490Pt/yy+ep9MNjpeEvr943rSrit/jbSJ/Cdult0cG+2wHOWvj48qyux5V/nk3WTTSBPlOU60CaZ1SUirSowVYq1beAVqxq2GEdHpdj5E6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215652; c=relaxed/simple;
	bh=ogsulQFcm/S4TsyXnA/p9MVyjXdYMLo8/9KPK9KGI5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/3LGxIpjV2T1x3p3/yX2DM5QA97sMk2wrxalX/QwuX7+JnLHGMWGdeXu1jL35y2ETW5bDTk1DjDYXk10CdvHye8G7bsnOgNPPB7xktlqZgRnMMpEzMfoWrmfVdu1VcDGoWgwZ2QxoBZHYqsKOa4AOZ+G9//2/7lPZPUDQsXzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 7FC3412B70E;
	Tue,  4 Nov 2025 00:20:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 873882002C;
	Tue,  4 Nov 2025 00:20:38 +0000 (UTC)
Date: Mon, 3 Nov 2025 19:20:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Prakash Sangappa
 <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann
 <arnd@arndb.de>, linux-arch@vger.kernel.org, vineethrp@google.com
Subject: Re: [patch V3 02/12] rseq: Add fields and constants for time slice
 extension
Message-ID: <20251103192042.4820571b@gandalf.local.home>
In-Reply-To: <20251029130403.542731428@linutronix.de>
References: <20251029125514.496134233@linutronix.de>
	<20251029130403.542731428@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: m33k1hbbzoauu5pt6944f1sodr7zabzr
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 873882002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19o+h2IfWRb/8/hguwbWdaEbDTx2MDcwY4=
X-HE-Tag: 1762215638-279711
X-HE-Meta: U2FsdGVkX18FuPWqezhU8nvfOXC8rlxFK8NFxoxQde/ssp0jHbhITVxl77aPacP7GBDTl7TH0lzDv3LIl66Od6aHrULncbIlazxn5/Iuaftv5E1ocE+JGNN0VoDYgtwD/qrS0WSvKet99dDxrET1eUY8UoS9NvWVUhmgVKg/SGu8XThYJJ2Uny873CwwqiBd62lB36S3dgaRrjQAsCXf+hr5khtS5QENHfmOxRRcAz9Zvu6KAzUrHEc6ElIYd6+xIyaFy3j0++4deM7bLOQK+i3nIBWNUpnm3X1extqhp/re+Hlge38Qh8osKrSA4wnl

On Wed, 29 Oct 2025 14:22:14 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> +/**
> + * rseq_slice_ctrl - Time slice extension control structure
> + * @all:	Compound value
> + * @request:	Request for a time slice extension
> + * @granted:	Granted time slice extension
> + *
> + * @request is set by user space and can be cleared by user space or kernel
> + * space.  @granted is set and cleared by the kernel and must only be read
> + * by user space.
> + */
> +struct rseq_slice_ctrl {
> +	union {
> +		__u32		all;
> +		struct {
> +			__u8	request;
> +			__u8	granted;
> +			__u16	__reserved;
> +		};
> +	};
> +};
> +
>  /*
>   * struct rseq is aligned on 4 * 8 bytes to ensure it is always
>   * contained within a single cache-line.
> @@ -142,6 +174,12 @@ struct rseq {
>  	__u32 mm_cid;
>  
>  	/*
> +	 * Time slice extension control structure. CPU local updates from
> +	 * kernel and user space.
> +	 */
> +	struct rseq_slice_ctrl slice_ctrl;
> +

BTW, Google is interested in expanding this feature for VMs. As a VM kernel
spinlock also happens to be a user space spinlock. The KVM folks would
rather have this implemented via the normal user spaces method than to do
anything specific to the KVM internal code. Or at least, keep it as
non-intrusive as possible.

I talked with Mathieu and the KVM folks on how it could use the rseq
method, and it was suggested that qemu would set up a shared memory region
between the qemu thread and the virtual CPU and possibly submit a driver
that would expose this memory region. This could hook to a paravirt
spinlock that would set the bit stating the system is in a critical section
and clear it when all spin locks are released. If the vCPU was granted an
extra time slice, then it would call a hypercall that would do the yield.

When I mentioned this to Mathieu, he was against sharing the qemu's thread
rseq with the guest VM, as that would expose much more than what is needed
to the guest. Especially since it needs to be a writable memory location.

What could be done is that another memory range is mapped between the qemu
thread and the vCPU memory, and the rseq would have a pointer to that memory.

To implement that, the slice_ctrl would need to be a pointer, where the
kernel would need to do another indirection to follow that pointer to
another location within the thread's memory.

Now I do believe that the return back to guest goes through a different
path. So this doesn't actually need to use rseq. But it would require a way
for the qemu thread to pass the memory to the kernel. I'm guessing that the
return to guest logic could share the code with the return to user logic
with just passing a struct rseq_slice_ctrl pointer to a function?

I'm bringing this up so that this use case is considered when implementing
the extended time slice. As I believe this would be a more common case than
then user space spin lock would be.

Thanks,

-- Steve

