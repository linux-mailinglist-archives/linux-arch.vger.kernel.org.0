Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788DD231E63
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jul 2020 14:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgG2MSY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jul 2020 08:18:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41764 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2MSY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jul 2020 08:18:24 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596025102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ly5lKlt5+T8rjsxUijX+AknXGpRtZhyO/+W9xI8yMEs=;
        b=NrlJIt3zQ4aIa5wj65OpStrRFgZ5MSXz6spZIAKfO1kOjA9cXNBgP2bQW54pLpkCrCwvIb
        UggMJU1I06R0lCphDduHZWs7fjdN9tW6mx69Y3wFRsK9QMfQJ5gOspgJPTNpuN+eMaxCyB
        N6wE4NyBf8jk80309EsKGumgG6nmIXYgOL4bI+naj2pHY4Kiu3OHDFz/ZCjbSAdSHWz3Lh
        IfTXldmzK6EFUKRniALL0q8K3pdWszisJfzdQlgjC7Uka/Uq6ZHoZOEUVbI4eZWIW4wbyZ
        5OenmVSN3Kn48CnT506PbQyZwEKjBwHNnWnpFWdAwGJUgbbI0zyPj3mnk1EEZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596025102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ly5lKlt5+T8rjsxUijX+AknXGpRtZhyO/+W9xI8yMEs=;
        b=IWZv7P3FRyXOaZUh/YYV0zCmYLJzVjlqQZR8JHuVqqKiihPN/iUlTmP03IWU7z3fPY95NV
        LZAG0I0FiRvbiKAA==
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V4 04/15] entry: Provide generic interrupt entry/exit code
In-Reply-To: <CALCETrUBQa=L_Chd=RAPDEihvUWC_9KoHG00zYsGOwiYg87naQ@mail.gmail.com>
References: <20200721105706.030914876@linutronix.de> <20200721110808.671110583@linutronix.de> <CALCETrUBQa=L_Chd=RAPDEihvUWC_9KoHG00zYsGOwiYg87naQ@mail.gmail.com>
Date:   Wed, 29 Jul 2020 14:18:22 +0200
Message-ID: <87sgdaa50x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> On Tue, Jul 21, 2020 at 4:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> Like the syscall entry/exit code interrupt/exception entry after the real
>> low level ASM bits should not be different accross architectures.
>>
>> Provide a generic version based on the x86 code.
>
> I don't like the name.  Sure, idtentry is ugly and x86-specific, but
> irq gives the wrong impression.  This is an entry path suitable for
> any entry that is guaranteed not to hit during entry/exit handling.
> Syscalls, page faults, etc are not "irqs".

Yeah, it's exceptions and interrupts, but I did not come up with a
better name so far.

Thanks,

        tglx
