Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3402166D0
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jul 2020 08:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgGGGvU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jul 2020 02:51:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46739 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbgGGGvU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Jul 2020 02:51:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B1Cl86QFpz9sT6;
        Tue,  7 Jul 2020 16:51:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1594104676;
        bh=mSc7ZlijM9jYtm2c8+HUAgy7pwbP8QyWMOMDkWVm4O8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LwSUNUtDs2cuWpV/Zglq+yiqLNmNZWXBp+A8oyJUqac2a2y0eDXpeMw8n5+NLMvXe
         pmRvsCnxzFiY5ayGCwANTTe8Hvoifob5OwojW/8mmx456MjuXjy44ss3dE43xNA5qn
         XDR28REueOivUI4JQZkuAMtpxjzTmZYsMBgf+rDOlHXseYFs5/oVsDH9B9DwkWNs4N
         9mB7bRLq4QhJCl0ehhUdbvBmGnZynLYQBmXGdoMP5CsJWKGMbbyn7lWxh6rI4rPL7Q
         8fphVU6A5pZqQ65at7xEbCcqxCB5a0/Ae1warSVG/89wW2F6b5Wg1w65HDKbqaXF7+
         YYiAVL98rqhuA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@ozlabs.org
Cc:     linux-arch@vger.kernel.org, hughd@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] powerpc/mm: Remove custom stack expansion checking
In-Reply-To: <fb3aad5f-17a1-93cc-1a3a-c50fe16ab711@csgroup.eu>
References: <20200703141327.1732550-1-mpe@ellerman.id.au> <20200703141327.1732550-4-mpe@ellerman.id.au> <fb3aad5f-17a1-93cc-1a3a-c50fe16ab711@csgroup.eu>
Date:   Tue, 07 Jul 2020 16:53:32 +1000
Message-ID: <87d0574xzn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 03/07/2020 =C3=A0 16:13, Michael Ellerman a =C3=A9crit=C2=A0:
>> We have powerpc specific logic in our page fault handling to decide if
>> an access to an unmapped address below the stack pointer should expand
>> the stack VMA.
>>=20
>> The logic aims to prevent userspace from doing bad accesses below the
>> stack pointer. However as long as the stack is < 1MB in size, we allow
>> all accesses without further checks. Adding some debug I see that I
>> can do a full kernel build and LTP run, and not a single process has
>> used more than 1MB of stack. So for the majority of processes the
>> logic never even fires.
>>=20
>> We also recently found a nasty bug in this code which could cause
>> userspace programs to be killed during signal delivery. It went
>> unnoticed presumably because most processes use < 1MB of stack.
>>=20
>> The generic mm code has also grown support for stack guard pages since
>> this code was originally written, so the most heinous case of the
>> stack expanding into other mappings is now handled for us.
>>=20
>> Finally although some other arches have special logic in this path,
>> from what I can tell none of x86, arm64, arm and s390 impose any extra
>> checks other than those in expand_stack().
>>=20
>> So drop our complicated logic and like other architectures just let
>> the stack expand as long as its within the rlimit.
>
> I agree that's probably not worth a so complicated logic that is nowhere=
=20
> documented.
>
> This patch looks good to me, minor comments below.

Thanks.

>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index ed01329dd12b..925a7231abb3 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -42,39 +42,7 @@
>>   #include <asm/kup.h>
>>   #include <asm/inst.h>
>>=20=20=20
>> -/*
>> - * Check whether the instruction inst is a store using
>> - * an update addressing form which will update r1.
>> - */
>> -static bool store_updates_sp(struct ppc_inst inst)
>> -{
>> -	/* check for 1 in the rA field */
>> -	if (((ppc_inst_val(inst) >> 16) & 0x1f) !=3D 1)
>> -		return false;
>> -	/* check major opcode */
>> -	switch (ppc_inst_primary_opcode(inst)) {
>> -	case OP_STWU:
>> -	case OP_STBU:
>> -	case OP_STHU:
>> -	case OP_STFSU:
>> -	case OP_STFDU:
>> -		return true;
>> -	case OP_STD:	/* std or stdu */
>> -		return (ppc_inst_val(inst) & 3) =3D=3D 1;
>> -	case OP_31:
>> -		/* check minor opcode */
>> -		switch ((ppc_inst_val(inst) >> 1) & 0x3ff) {
>> -		case OP_31_XOP_STDUX:
>> -		case OP_31_XOP_STWUX:
>> -		case OP_31_XOP_STBUX:
>> -		case OP_31_XOP_STHUX:
>> -		case OP_31_XOP_STFSUX:
>> -		case OP_31_XOP_STFDUX:
>> -			return true;
>> -		}
>> -	}
>> -	return false;
>> -}
>> +
>
> Do we need this additional blank line ?

I usually leave two blank lines between the end of the includes and the
start of the code, which is what I did here I guess.

>>   /*
>>    * do_page_fault error handling helpers
>>    */
>> @@ -267,54 +235,6 @@ static bool bad_kernel_fault(struct pt_regs *regs, =
unsigned long error_code,
>>   	return false;
>>   }
>>=20=20=20
>> -static bool bad_stack_expansion(struct pt_regs *regs, unsigned long add=
ress,
>> -				struct vm_area_struct *vma, unsigned int flags,
>> -				bool *must_retry)
>> -{
>> -	/*
>> -	 * N.B. The POWER/Open ABI allows programs to access up to
>> -	 * 288 bytes below the stack pointer.
>> -	 * The kernel signal delivery code writes up to 4KB
>> -	 * below the stack pointer (r1) before decrementing it.
>> -	 * The exec code can write slightly over 640kB to the stack
>> -	 * before setting the user r1.  Thus we allow the stack to
>> -	 * expand to 1MB without further checks.
>> -	 */
>> -	if (address + 0x100000 < vma->vm_end) {
>> -		struct ppc_inst __user *nip =3D (struct ppc_inst __user *)regs->nip;
>> -		/* get user regs even if this fault is in kernel mode */
>> -		struct pt_regs *uregs =3D current->thread.regs;
>> -		if (uregs =3D=3D NULL)
>> -			return true;
>> -
>> -		/*
>> -		 * A user-mode access to an address a long way below
>> -		 * the stack pointer is only valid if the instruction
>> -		 * is one which would update the stack pointer to the
>> -		 * address accessed if the instruction completed,
>> -		 * i.e. either stwu rs,n(r1) or stwux rs,r1,rb
>> -		 * (or the byte, halfword, float or double forms).
>> -		 *
>> -		 * If we don't check this then any write to the area
>> -		 * between the last mapped region and the stack will
>> -		 * expand the stack rather than segfaulting.
>> -		 */
>> -		if (address + 4096 >=3D uregs->gpr[1])
>> -			return false;
>> -
>> -		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
>> -		    access_ok(nip, sizeof(*nip))) {
>> -			struct ppc_inst inst;
>> -
>> -			if (!probe_user_read_inst(&inst, nip))
>> -				return !store_updates_sp(inst);
>> -			*must_retry =3D true;
>> -		}
>> -		return true;
>> -	}
>> -	return false;
>> -}
>> -
>>   #ifdef CONFIG_PPC_MEM_KEYS
>>   static bool access_pkey_error(bool is_write, bool is_exec, bool is_pke=
y,
>>   			      struct vm_area_struct *vma)
>> @@ -480,7 +400,6 @@ static int __do_page_fault(struct pt_regs *regs, uns=
igned long address,
>>   	int is_user =3D user_mode(regs);
>>   	int is_write =3D page_fault_is_write(error_code);
>>   	vm_fault_t fault, major =3D 0;
>> -	bool must_retry =3D false;
>>   	bool kprobe_fault =3D kprobe_page_fault(regs, 11);
>>=20=20=20
>>   	if (unlikely(debugger_fault_handler(regs) || kprobe_fault))
>> @@ -569,30 +488,15 @@ static int __do_page_fault(struct pt_regs *regs, u=
nsigned long address,
>>   	vma =3D find_vma(mm, address);
>>   	if (unlikely(!vma))
>>   		return bad_area(regs, address);
>> -	if (likely(vma->vm_start <=3D address))
>> -		goto good_area;
>> -	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
>> -		return bad_area(regs, address);
>>=20=20=20
>> -	/* The stack is being expanded, check if it's valid */
>> -	if (unlikely(bad_stack_expansion(regs, address, vma, flags,
>> -					 &must_retry))) {
>> -		if (!must_retry)
>> +	if (unlikely(vma->vm_start > address)) {
>> +		if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
>
> We are already in an unlikely() branch, I don't think it is worth having=
=20
> a second level of unlikely(), better let gcc decide what's most efficient.

Yeah I did wonder if we need so many unlikelys in here, but I thought
that should be done in a separate patch with some actual analysis of the
generated code.

cheers
