Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94073222E03
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 23:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGPVdZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 17:33:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36106 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgGPVdY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 17:33:24 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594935202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5CsMjI9aQcGWcn47drYeuuGUUPH28S7NiRCV6XdURWs=;
        b=1bhpXeApWbtkbvSGYhWsDKvZdDydcP4ehLGkuE2WITWwKhNEwXNJ8lY8Svg5UV6WjEoK9J
        NE4M2xROmRfONtlPdMHWQTLpSguKdBN9p9hC2UReKlReVzE2e7JAZU2pE/NtmjLp10UKTT
        OZ/QyIG/0gzeYy5P7vRlOPKKFMRkQ8O5krpiNAv3dcPkTah17ACvGYKSiSXrekP4/03qyT
        4F9DI44067dc+tumHrRPdC4SdZqfasXGgVt0UjSjp0NQ9yFB8aZCKf/GUN5mhBAIpWZNBQ
        7kuiTTAN4tRb++m2WYn+8+rquMQM6zZJN3F6JzT8IjGaKFH/8ogYMgejYvQmsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594935202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5CsMjI9aQcGWcn47drYeuuGUUPH28S7NiRCV6XdURWs=;
        b=fPIc5sqdGm8Y0fsYjECBge8CE3I7sD1Pqzh4zvKUg77NBgtNSCRX3xBQa6Q6vv51j9Aabo
        CcEGWk/LqOe4WwCw==
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [patch V3 08/13] x86/entry: Use generic syscall entry function
In-Reply-To: <202007161359.AB211685@keescook>
References: <20200716182208.180916541@linutronix.de> <20200716185424.765294277@linutronix.de> <202007161359.AB211685@keescook>
Date:   Thu, 16 Jul 2020 23:33:21 +0200
Message-ID: <87ft9rtaam.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Thu, Jul 16, 2020 at 08:22:16PM +0200, Thomas Gleixner wrote:
>> +}
>> +#define arch_check_user_regs arch_check_user_regs
>
> Will architectures implement subsets of these functions? (i.e. instead
> of each of the defines, is CONFIG_ENTRY_GENERIC sufficient for the
> no-op inlines?)

Yes, some of these are optional as far as my analysis of the
architecture code went.

>> +}
>> +#define arch_syscall_enter_seccomp arch_syscall_enter_seccomp
>
> Actually, I've been meaning to clean this up. It's not needed at all.
> This was left over from the seccomp fast-path code that got ripped out a
> while ago. seccomp already has everything it needs to do this work, so
> just:
>
> 	__secure_computing(NULL);
>
> is sufficient for every architecture that supports seccomp. (See kernel/seccomp.c
> populate_seccomp_data().)

Nice. Was not aware of these details. Trivial enough to fix :)

> And if you want more generalization work, note that the secure_computing()
> macro performs a TIF test before calling __secure_computing(NULL). But
> my point is, I think arch_syscall_enter_seccomp() is not needed.

Cute. One horror gone.

>> +static inline void arch_syscall_enter_audit(struct pt_regs *regs)
>> +{
>> +#ifdef CONFIG_X86_64
>> +	if (in_ia32_syscall()) {
>> +		audit_syscall_entry(regs->orig_ax, regs->di,
>> +				    regs->si, regs->dx, regs->r10);
>> +	} else
>> +#endif
>> +	{
>> +		audit_syscall_entry(regs->orig_ax, regs->bx,
>> +				    regs->cx, regs->dx, regs->si);
>> +	}
>> +}
>> +#define arch_syscall_enter_audit arch_syscall_enter_audit
>
> Similarly, I think these can be redefined in the generic case
> using the existing accessors for syscall arguments, etc. e.g.
> arch_syscall_enter_audit() is not needed for any architecture, and the
> generic is:
>
> 	unsigned long args[6];
>
>         syscall_get_arguments(task, regs, args);
> 	audit_syscall_entry(syscall_get_nr(current, regs),
> 			    args[0], args[1], args[2], args[3]);

Nice. Another arch specific mess gone.

Thanks,

        tglx
