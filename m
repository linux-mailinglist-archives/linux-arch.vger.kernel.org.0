Return-Path: <linux-arch+bounces-1977-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9707845E41
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 18:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A88D281A1B
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC916088D;
	Thu,  1 Feb 2024 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="xopk6q0Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PA0m+sYx"
X-Original-To: linux-arch@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67C15F313;
	Thu,  1 Feb 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807640; cv=none; b=SRMZlFGg3nMbI9HEZy2aMDa/a/TRr6mR7E7YPHqt/kSPSCyXKRMEXacIkwymMPxwWBFGbdPcCDsUy0g+NJ3V8LYH+24P/Fgjs/hmFVBrul/qdQ9VGq4v0Ik3lVi3PIH7PmeeQeA9FJClQb8Mecztl3CNB9VJOuvLyvMiNkayX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807640; c=relaxed/simple;
	bh=FNJMXoesCASx0C5mvXo8pCpfD0E1Xdpp6ulUZEz0tK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUd4yA56sjpmuCLjb8gAccX9CQdKtxWq2I7DbGnccto6zYI+9rL8L04j1hJFXW6pqSrC7XmbmfQkbmftb+z0/wia2P+iIWM0zntlmgO6VQOB8lFOJn/luGkebforkxLeDpkOHwUjt26axYdMSDy5KwIi6dZ9L6PhQkd7a6S0xSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=xopk6q0Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PA0m+sYx; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A4EE35C00FB;
	Thu,  1 Feb 2024 12:13:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Feb 2024 12:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706807637;
	 x=1706894037; bh=lMjjV1buWDHIcimo2xOiRU3Rzznhm3EuA6XfF7iUovY=; b=
	xopk6q0Zn0HPx7bkzr4eFb11QFjmerO6GVID/tlAK+PXLXuMelBjuoSt368KmGaz
	FYgfoJOYucAKaNkavygZy1EhcNAlIGfDoFpqDzXdoAiypIDtLgcYKPFyB+2XNuzK
	u2vL+NrX4TwJ7KxJlbBs5ld9NT04u41yl7ZzKaicYc11F5m6RcuE0TnYO2U/NOIO
	eSeYwhFGGn3+wTAE8Ksrppiyy8bIEUdZ+O10tV23dw6R63LFgtb5xxsGzWL3VSdM
	REAQNxjRqteVLqXFELMlmJHAMQF/rSK1ZbbSkbazUVdYrT7fXaGah73xF+hRtcqr
	gi49nBiIoAl//ArC1D5rTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706807637; x=
	1706894037; bh=lMjjV1buWDHIcimo2xOiRU3Rzznhm3EuA6XfF7iUovY=; b=P
	A0m+sYxnohpGaGUB2DeVYRmpBlUvl3Brng3TgvMqoOucCrLKBd1xdawC/dL7CDpl
	/lC5Xyj4KAMRXFdAVGnch40AeZMIISRSSMwrrfru0lKkxn+zwyZdcbnCwARLGX4W
	/BGIqgSM7UIiZLK0AbP7TUhpE2ncyWhwp9IXyxVhF+gHkqeveiWf43h1Ff3snm/S
	JeHqvJSHyHbp9yMqu91ZFZQzkHwUQPv3LjqEoIGUvUyu5wm2vv8QAMNHmob/qHAJ
	v0uFik47BQrVM2eSakqC9pkeWtCL+80MXpmjkFrSYvUaNRTmszN/TDdREPqXH5Bf
	QCgtrxtidPcv+ZmQ6phjA==
X-ME-Sender: <xms:VdG7ZbsWEXNHR4ZEPE9H_opSzKAFcSGwhkuJgO_5yXYH_ijOJmHynQ>
    <xme:VdG7ZcfLDL_wANMraaEAPGqphSuvwjd-jl66k82j2yZSAivNLwoitQkkBtCMgQScp
    sqmr2HSun0xa1yqfTs>
X-ME-Received: <xmr:VdG7ZezlWzwc7xSRVa9BRI1RoTpypgJQw9b6URgVMiOq2pq_ffim8ABGs6bXoH51joKrCfSKJuvVttyaSi9bmxbWIWtcM0QNlEoTJ0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepudehjefgtedvkeevvdevieekleekhfevkeevleehieekfedu
    teeuffduhfehtdehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:VdG7ZaNZJiYGLcztyAA4g-zvcbDYMAfYjY9IqOMLoBO5L3aBo_-jrQ>
    <xmx:VdG7Zb9gZOv24Ff4dh9xV6d9AFQOpEzsR6L_86uX2giC3eOaMGHR_Q>
    <xmx:VdG7ZaVno7t3Q8pJjNKSmKogizZ1Tl00jp2JC6-D-58Fj39DUWInOg>
    <xmx:VdG7ZcPVbITOXa59vrr1t0UeZfPBYWdaoaW0y8YxgfjAda2dq88CBA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 12:13:55 -0500 (EST)
Message-ID: <61debd68-4262-431e-a017-163eb820f739@flygoat.com>
Date: Thu, 1 Feb 2024 17:13:54 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ptrace: Introduce exception_ip arch hook
To: Xi Ruoyao <xry111@xry111.site>, Oleg Nesterov <oleg@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ben Hutchings <ben@decadent.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com>
 <20240201-exception_ip-v1-1-aa26ab3ee0b5@flygoat.com>
 <9d1d51e69c3f96bf5992e9a988969515ba97f883.camel@xry111.site>
Content-Language: en-US
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com;
 keydata= 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
 HVO98ZmbMeg=
In-Reply-To: <9d1d51e69c3f96bf5992e9a988969515ba97f883.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/1 16:35, Xi Ruoyao 写道:
> On Thu, 2024-02-01 at 15:46 +0000, Jiaxun Yang wrote:
>> On architectures with delay slot, architecture level instruction
>> pointer (or program counter) in pt_regs may differ from where
>> exception was triggered.
>>
>> Introduce exception_ip hook to invoke architecture code and determine
>> actual instruction pointer to the exception.
>>
>> Link:
>> https://lore.kernel.org/lkml/00d1b813-c55f-4365-8d81-d70258e10b16@app.fastmail.com/
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> How about adding something like
>
> #ifndef arch_exception_ip
> #define exception_ip(regs) instruction_pointer(regs)
> #else
> #define exception_ip(regs) arch_exception_ip(regs)
> #endif
>
> into a generic header, instead of having to add exception_ip definition
> everywhere?

Actually I tried but failed, cuz there is no asm-generic version of 
ptrace.h, besides
exception_ip shall be used at many scenarios so extable.h is also a no go.

Thanks
- Jiaxun

>
>> ---
>>   arch/alpha/include/asm/ptrace.h        | 1 +
>>   arch/arc/include/asm/ptrace.h          | 1 +
>>   arch/arm/include/asm/ptrace.h          | 1 +
>>   arch/csky/include/asm/ptrace.h         | 1 +
>>   arch/hexagon/include/uapi/asm/ptrace.h | 1 +
>>   arch/loongarch/include/asm/ptrace.h    | 1 +
>>   arch/m68k/include/asm/ptrace.h         | 1 +
>>   arch/microblaze/include/asm/ptrace.h   | 3 ++-
>>   arch/mips/include/asm/ptrace.h         | 1 +
>>   arch/mips/kernel/ptrace.c              | 7 +++++++
>>   arch/nios2/include/asm/ptrace.h        | 3 ++-
>>   arch/openrisc/include/asm/ptrace.h     | 1 +
>>   arch/parisc/include/asm/ptrace.h       | 1 +
>>   arch/s390/include/asm/ptrace.h         | 1 +
>>   arch/sparc/include/asm/ptrace.h        | 2 ++
>>   arch/um/include/asm/ptrace-generic.h   | 1 +
>>   16 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/alpha/include/asm/ptrace.h
>> b/arch/alpha/include/asm/ptrace.h
>> index 3557ce64ed21..1ded3f2d09e9 100644
>> --- a/arch/alpha/include/asm/ptrace.h
>> +++ b/arch/alpha/include/asm/ptrace.h
>> @@ -8,6 +8,7 @@
>>   #define arch_has_single_step()		(1)
>>   #define user_mode(regs) (((regs)->ps & 8) != 0)
>>   #define instruction_pointer(regs) ((regs)->pc)
>> +#define exception_ip(regs) instruction_pointer(regs)
>>   #define profile_pc(regs) instruction_pointer(regs)
>>   #define current_user_stack_pointer() rdusp()
>>   
>> diff --git a/arch/arc/include/asm/ptrace.h
>> b/arch/arc/include/asm/ptrace.h
>> index 00b9318e551e..94084f1048df 100644
>> --- a/arch/arc/include/asm/ptrace.h
>> +++ b/arch/arc/include/asm/ptrace.h
>> @@ -105,6 +105,7 @@ struct callee_regs {
>>   #endif
>>   
>>   #define instruction_pointer(regs)	((regs)->ret)
>> +#define exception_ip(regs)		instruction_pointer(regs)
>>   #define profile_pc(regs)		instruction_pointer(regs)
>>   
>>   /* return 1 if user mode or 0 if kernel mode */
>> diff --git a/arch/arm/include/asm/ptrace.h
>> b/arch/arm/include/asm/ptrace.h
>> index 7f44e88d1f25..fb4dc23eba78 100644
>> --- a/arch/arm/include/asm/ptrace.h
>> +++ b/arch/arm/include/asm/ptrace.h
>> @@ -89,6 +89,7 @@ static inline long regs_return_value(struct pt_regs
>> *regs)
>>   }
>>   
>>   #define instruction_pointer(regs)	(regs)->ARM_pc
>> +#define
>> exception_ip(regs)			instruction_pointer(regs)
>>   
>>   #ifdef CONFIG_THUMB2_KERNEL
>>   #define frame_pointer(regs) (regs)->ARM_r7
>> diff --git a/arch/csky/include/asm/ptrace.h
>> b/arch/csky/include/asm/ptrace.h
>> index 0634b7895d81..a738630e64b0 100644
>> --- a/arch/csky/include/asm/ptrace.h
>> +++ b/arch/csky/include/asm/ptrace.h
>> @@ -22,6 +22,7 @@
>>   
>>   #define user_mode(regs) (!((regs)->sr & PS_S))
>>   #define instruction_pointer(regs) ((regs)->pc)
>> +#define exception_ip(regs) instruction_pointer(regs)
>>   #define profile_pc(regs) instruction_pointer(regs)
>>   #define trap_no(regs) ((regs->sr >> 16) & 0xff)
>>   
>> diff --git a/arch/hexagon/include/uapi/asm/ptrace.h
>> b/arch/hexagon/include/uapi/asm/ptrace.h
>> index 2a3ea14ad9b9..846471936237 100644
>> --- a/arch/hexagon/include/uapi/asm/ptrace.h
>> +++ b/arch/hexagon/include/uapi/asm/ptrace.h
>> @@ -25,6 +25,7 @@
>>   #include <asm/registers.h>
>>   
>>   #define instruction_pointer(regs) pt_elr(regs)
>> +#define exception_ip(regs) instruction_pointer(regs)
>>   #define user_stack_pointer(regs) ((regs)->r29)
>>   
>>   #define profile_pc(regs) instruction_pointer(regs)
>> diff --git a/arch/loongarch/include/asm/ptrace.h
>> b/arch/loongarch/include/asm/ptrace.h
>> index f3ddaed9ef7f..a34327f0e69d 100644
>> --- a/arch/loongarch/include/asm/ptrace.h
>> +++ b/arch/loongarch/include/asm/ptrace.h
>> @@ -160,6 +160,7 @@ static inline void regs_set_return_value(struct
>> pt_regs *regs, unsigned long val
>>   }
>>   
>>   #define instruction_pointer(regs) ((regs)->csr_era)
>> +#define exception_ip(regs) instruction_pointer(regs)
>>   #define profile_pc(regs) instruction_pointer(regs)
>>   
>>   extern void die(const char *str, struct pt_regs *regs);
>> diff --git a/arch/m68k/include/asm/ptrace.h
>> b/arch/m68k/include/asm/ptrace.h
>> index ea5a80ca1ab3..cb553e2ec73a 100644
>> --- a/arch/m68k/include/asm/ptrace.h
>> +++ b/arch/m68k/include/asm/ptrace.h
>> @@ -13,6 +13,7 @@
>>   
>>   #define user_mode(regs) (!((regs)->sr & PS_S))
>>   #define instruction_pointer(regs) ((regs)->pc)
>> +#define exception_ip(regs) instruction_pointer(regs)
>>   #define profile_pc(regs) instruction_pointer(regs)
>>   #define current_pt_regs() \
>>   	(struct pt_regs *)((char *)current_thread_info() +
>> THREAD_SIZE) - 1
>> diff --git a/arch/microblaze/include/asm/ptrace.h
>> b/arch/microblaze/include/asm/ptrace.h
>> index bfcb89df5e26..974c00fa7212 100644
>> --- a/arch/microblaze/include/asm/ptrace.h
>> +++ b/arch/microblaze/include/asm/ptrace.h
>> @@ -12,7 +12,8 @@
>>   #define user_mode(regs)			(!kernel_mode(regs))
>>   
>>   #define instruction_pointer(regs)	((regs)->pc)
>> -#define profile_pc(regs)		instruction_pointer(regs)
>> +#define
>> exception_ip(regs)			instruction_pointer(regs)
>> +#define
>> profile_pc(regs)			instruction_pointer(regs)
>>   #define user_stack_pointer(regs)	((regs)->r1)
>>   
>>   static inline long regs_return_value(struct pt_regs *regs)
>> diff --git a/arch/mips/include/asm/ptrace.h
>> b/arch/mips/include/asm/ptrace.h
>> index daf3cf244ea9..97589731fd40 100644
>> --- a/arch/mips/include/asm/ptrace.h
>> +++ b/arch/mips/include/asm/ptrace.h
>> @@ -154,6 +154,7 @@ static inline long regs_return_value(struct
>> pt_regs *regs)
>>   }
>>   
>>   #define instruction_pointer(regs) ((regs)->cp0_epc)
>> +extern unsigned long exception_ip(struct pt_regs *regs);
>>   #define profile_pc(regs) instruction_pointer(regs)
>>   
>>   extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, long
>> syscall);
>> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
>> index d9df543f7e2c..59288c13b581 100644
>> --- a/arch/mips/kernel/ptrace.c
>> +++ b/arch/mips/kernel/ptrace.c
>> @@ -31,6 +31,7 @@
>>   #include <linux/seccomp.h>
>>   #include <linux/ftrace.h>
>>   
>> +#include <asm/branch.h>
>>   #include <asm/byteorder.h>
>>   #include <asm/cpu.h>
>>   #include <asm/cpu-info.h>
>> @@ -48,6 +49,12 @@
>>   #define CREATE_TRACE_POINTS
>>   #include <trace/events/syscalls.h>
>>   
>> +unsigned long exception_ip(struct pt_regs *regs)
>> +{
>> +	return exception_epc(regs);
>> +}
>> +EXPORT_SYMBOL(exception_ip);
>> +
>>   /*
>>    * Called by kernel/ptrace.c when detaching..
>>    *
>> diff --git a/arch/nios2/include/asm/ptrace.h
>> b/arch/nios2/include/asm/ptrace.h
>> index 9da34c3022a2..136f5679ae79 100644
>> --- a/arch/nios2/include/asm/ptrace.h
>> +++ b/arch/nios2/include/asm/ptrace.h
>> @@ -66,7 +66,8 @@ struct switch_stack {
>>   #define user_mode(regs)	(((regs)->estatus & ESTATUS_EU))
>>   
>>   #define instruction_pointer(regs)	((regs)->ra)
>> -#define profile_pc(regs)		instruction_pointer(regs)
>> +#define
>> exception_ip(regs)			instruction_pointer(regs)
>> +#define
>> profile_pc(regs)			instruction_pointer(regs)
>>   #define user_stack_pointer(regs)	((regs)->sp)
>>   extern void show_regs(struct pt_regs *);
>>   
>> diff --git a/arch/openrisc/include/asm/ptrace.h
>> b/arch/openrisc/include/asm/ptrace.h
>> index 375147ff71fc..67c28484d17e 100644
>> --- a/arch/openrisc/include/asm/ptrace.h
>> +++ b/arch/openrisc/include/asm/ptrace.h
>> @@ -67,6 +67,7 @@ struct pt_regs {
>>   #define STACK_FRAME_OVERHEAD  128  /* size of minimum stack frame */
>>   
>>   #define instruction_pointer(regs)	((regs)->pc)
>> +#define
>> exception_ip(regs)			instruction_pointer(regs)
>>   #define user_mode(regs)			(((regs)->sr &
>> SPR_SR_SM) == 0)
>>   #define user_stack_pointer(regs)	((unsigned long)(regs)->sp)
>>   #define profile_pc(regs)		instruction_pointer(regs)
>> diff --git a/arch/parisc/include/asm/ptrace.h
>> b/arch/parisc/include/asm/ptrace.h
>> index eea3f3df0823..d7e8dcf26582 100644
>> --- a/arch/parisc/include/asm/ptrace.h
>> +++ b/arch/parisc/include/asm/ptrace.h
>> @@ -17,6 +17,7 @@
>>   #define user_mode(regs)			(((regs)->iaoq[0] &
>> 3) != PRIV_KERNEL)
>>   #define user_space(regs)		((regs)->iasq[1] !=
>> PRIV_KERNEL)
>>   #define instruction_pointer(regs)	((regs)->iaoq[0] & ~3)
>> +#define
>> exception_ip(regs)			instruction_pointer(regs)
>>   #define user_stack_pointer(regs)	((regs)->gr[30])
>>   unsigned long profile_pc(struct pt_regs *);
>>   
>> diff --git a/arch/s390/include/asm/ptrace.h
>> b/arch/s390/include/asm/ptrace.h
>> index d28bf8fb2799..a5255b2337af 100644
>> --- a/arch/s390/include/asm/ptrace.h
>> +++ b/arch/s390/include/asm/ptrace.h
>> @@ -211,6 +211,7 @@ static inline int
>> test_and_clear_pt_regs_flag(struct pt_regs *regs, int flag)
>>   
>>   #define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
>>   #define instruction_pointer(regs) ((regs)->psw.addr)
>> +#define exception_ip(regs) instruction_pointer(regs)
>>   #define user_stack_pointer(regs)((regs)->gprs[15])
>>   #define profile_pc(regs) instruction_pointer(regs)
>>   
>> diff --git a/arch/sparc/include/asm/ptrace.h
>> b/arch/sparc/include/asm/ptrace.h
>> index d1419e669027..41ae186f2245 100644
>> --- a/arch/sparc/include/asm/ptrace.h
>> +++ b/arch/sparc/include/asm/ptrace.h
>> @@ -63,6 +63,7 @@ extern union global_cpu_snapshot
>> global_cpu_snapshot[NR_CPUS];
>>   #define force_successful_syscall_return() set_thread_noerror(1)
>>   #define user_mode(regs) (!((regs)->tstate & TSTATE_PRIV))
>>   #define instruction_pointer(regs) ((regs)->tpc)
>> +#define exception_ip(regs) instruction_pointer(regs)
>>   #define instruction_pointer_set(regs, val) do { \
>>   		(regs)->tpc = (val); \
>>   		(regs)->tnpc = (val)+4; \
>> @@ -142,6 +143,7 @@ static inline bool pt_regs_clear_syscall(struct
>> pt_regs *regs)
>>   
>>   #define user_mode(regs) (!((regs)->psr & PSR_PS))
>>   #define instruction_pointer(regs) ((regs)->pc)
>> +#define exception_ip(regs) instruction_pointer(regs)
>>   #define user_stack_pointer(regs) ((regs)->u_regs[UREG_FP])
>>   unsigned long profile_pc(struct pt_regs *);
>>   #else /* (!__ASSEMBLY__) */
>> diff --git a/arch/um/include/asm/ptrace-generic.h
>> b/arch/um/include/asm/ptrace-generic.h
>> index adf91ef553ae..f9ada287ca12 100644
>> --- a/arch/um/include/asm/ptrace-generic.h
>> +++ b/arch/um/include/asm/ptrace-generic.h
>> @@ -26,6 +26,7 @@ struct pt_regs {
>>   #define PT_REGS_SYSCALL_NR(r) UPT_SYSCALL_NR(&(r)->regs)
>>   
>>   #define instruction_pointer(regs) PT_REGS_IP(regs)
>> +#define exception_ip(regs) instruction_pointer(regs)
>>   
>>   #define PTRACE_OLDSETOPTIONS 21
>>   
>>

-- 
---
Jiaxun Yang


