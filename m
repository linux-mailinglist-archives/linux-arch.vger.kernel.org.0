Return-Path: <linux-arch+bounces-14501-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4916C30FC0
	for <lists+linux-arch@lfdr.de>; Tue, 04 Nov 2025 13:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8FC64E4F17
	for <lists+linux-arch@lfdr.de>; Tue,  4 Nov 2025 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3796986329;
	Tue,  4 Nov 2025 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QA5/d8OR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AA71CD15;
	Tue,  4 Nov 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259417; cv=none; b=Vg9Y9H40VLJPWMuRaYGcu/kP1Xkw7BisQOkYVdi981B8X9EMa6THzH+Czf1rAod3qIfCF4bf+2p713KuxZweqv6o3kMUgdYsn9zjQecFT1zayu4uvkYMkJ7Ycr79AkXIMBHnuWxZGnV+8nSY0aQUWJWXXno+BwYj8VL1Km3/Ue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259417; c=relaxed/simple;
	bh=MZIP2Vo/gI1gRzCbLHz5bkWBJ3/2vubyG03MUxEOUI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qzgD7lScUN3vGN18vJ0COE9UQk59Mv3Y6tWAbzfqm9g4Xxt0f/NoK3UAMvfsvrNIoO5rPnGMjxUeTrpEeaw24wJLaX1HzahdXDH+EofFfSb5Au8H7YIlUbcCGhMSPaxaNuN4mADurfeVAkuQAO1etwVBr6Fvs+08ygZ0JZEJY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QA5/d8OR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2306C4CEF7;
	Tue,  4 Nov 2025 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762259416;
	bh=MZIP2Vo/gI1gRzCbLHz5bkWBJ3/2vubyG03MUxEOUI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QA5/d8OR7N25ood+uCzN+8M8eXNybgpsS0Zikk6JaS4iAYPAI6hc+uc6wUMin7Q1W
	 LXB7Twi1nRvFzC1fjvJCQHiKO4a/OwdsMB9/rfVtZzD/dla3WfmWwjHAULILSNMeip
	 7m7nx565NMH4YsxVGiXMg7BnKev/jvNKdI9vSWtI44ea4TYTCcafDXGuW3IFoXRkJg
	 4cF7pldCUU7+bawmis6HMkZaia+vCK2ClbdPnzLCtK4X8cYcbVNGa7rOlt8Romo14X
	 UcZsi/GPOes7998mBZ8s5ux0ljyYEcaLhUiVW9Z08X1BDxHBGy7aF8dzYTJEyDHrty
	 L1TZARslJQQRQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Almeida
 <daniel.almeida@collabora.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "maintainer:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Jinjie Ruan
 <ruanjinjie@huawei.com>, Ada Couprie Diaz <ada.coupriediaz@arm.com>,
 Juergen Christ <jchrist@linux.ibm.com>, Brian Gerst <brgerst@gmail.com>,
 Uros Bizjak <ubizjak@gmail.com>, "moderated list:ARM64 PORT (AARCH64
 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>, "open list:S390
 ARCHITECTURE" <linux-s390@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM
 HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v13 04/17] preempt: Introduce __preempt_count_{sub,
 add}_return()
In-Reply-To: <20251013155205.2004838-5-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-5-lyude@redhat.com>
Date: Tue, 04 Nov 2025 13:30:00 +0100
Message-ID: <87bjli7zg7.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude Paul <lyude@redhat.com> writes:

> From: Boqun Feng <boqun.feng@gmail.com>
>
> In order to use preempt_count() to tracking the interrupt disable
> nesting level, __preempt_count_{add,sub}_return() are introduced, as
> their name suggest, these primitives return the new value of the
> preempt_count() after changing it. The following example shows the usage
> of it in local_interrupt_disable():
>
> 	// increase the HARDIRQ_DISABLE bit
> 	new_count = __preempt_count_add_return(HARDIRQ_DISABLE_OFFSET);
>
> 	// if it's the first-time increment, then disable the interrupt
> 	// at hardware level.
> 	if (new_count & HARDIRQ_DISABLE_MASK == HARDIRQ_DISABLE_OFFSET) {
> 		local_irq_save(flags);
> 		raw_cpu_write(local_interrupt_disable_state.flags, flags);
> 	}
>
> Having these primitives will avoid a read of preempt_count() after
> changing preempt_count() on certain architectures.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>
> ---
> V10:
> * Add commit message I forgot
> * Rebase against latest pcpu_hot changes
> V11:
> * Remove CONFIG_PROFILE_ALL_BRANCHES workaround from
>   __preempt_count_add_return()
>
>  arch/arm64/include/asm/preempt.h | 18 ++++++++++++++++++
>  arch/s390/include/asm/preempt.h  | 10 ++++++++++
>  arch/x86/include/asm/preempt.h   | 10 ++++++++++
>  include/asm-generic/preempt.h    | 14 ++++++++++++++
>  4 files changed, 52 insertions(+)
>
> diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
> index 932ea4b620428..0dd8221d1bef7 100644
> --- a/arch/arm64/include/asm/preempt.h
> +++ b/arch/arm64/include/asm/preempt.h
> @@ -55,6 +55,24 @@ static inline void __preempt_count_sub(int val)
>  	WRITE_ONCE(current_thread_info()->preempt.count, pc);
>  }
>  
> +static inline int __preempt_count_add_return(int val)
> +{
> +	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
> +	pc += val;
> +	WRITE_ONCE(current_thread_info()->preempt.count, pc);
> +
> +	return pc;
> +}
> +
> +static inline int __preempt_count_sub_return(int val)
> +{
> +	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
> +	pc -= val;
> +	WRITE_ONCE(current_thread_info()->preempt.count, pc);
> +
> +	return pc;
> +}
> +

I am wondering how this works when preemption is enabled? Will the
kernel never preempt itself? I would think this would have to be atomic?
I can see the surrounding code is using the same pattern, so it is
probably fine. But I am curious as to why that is.


Best regards,
Andreas Hindborg




