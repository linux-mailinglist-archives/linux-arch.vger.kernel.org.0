Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C7926D02C
	for <lists+linux-arch@lfdr.de>; Thu, 17 Sep 2020 02:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIQAsR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Sep 2020 20:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgIQAsJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Sep 2020 20:48:09 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:48:00 EDT
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3CCC061352;
        Wed, 16 Sep 2020 17:39:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BsJ5G6swKzB3yN;
        Thu, 17 Sep 2020 10:39:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1600303188;
        bh=COHpZK0BD0VqQ7amRyqQpQAYRPxhUDHH36Dg3xKyUzE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WtHyNl5RuVAVzBUi6IiSpYd32cWlj/8QiYwHDQkzF5qZ5lH+RSRxUrqR0jJQRNyIB
         dd+YPElX28UKWhi0pmBGjBXTiZJ7YYjbFN2MBhDFCciTSOUKrmQqbxiLUnjKh7DvgN
         i6InX4eNbxk9T6r7TkPxK7VSNrEkPvRSBVAHon5vxyAS8kiOBEMFoU+tQ0b3YHfl7S
         s3hH28Hm82++uC/v9pTrbcKb96vSqVf1I63KROvk1egNk1a8pCET65h3YcuEKSL4AB
         N/juH6rjcy5WGx/7h/q8qeCjkB68++E1Jc9hNYP9k8OwNI1eqMG89Dm9xYpSNJyzgu
         aFozBTXoBW4zw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Robert O'Callahan <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kyle Huey <me@kylehuey.com>
Subject: Re: [REGRESSION] x86/entry: Tracer no longer has opportunity to change the syscall number at entry via orig_ax
In-Reply-To: <202009141303.08B39E5783@keescook>
References: <CAP045Arc1Vdh+n2j2ELE3q7XfagLjyqXji9ZD0jqwVB-yuzq-g@mail.gmail.com> <87blj6ifo8.fsf@nanos.tec.linutronix.de> <87a6xzrr89.fsf@mpe.ellerman.id.au> <202009111609.61E7875B3@keescook> <87d02qqfxy.fsf@mpe.ellerman.id.au> <87o8m98rck.fsf@nanos.tec.linutronix.de> <202009141303.08B39E5783@keescook>
Date:   Thu, 17 Sep 2020 10:39:40 +1000
Message-ID: <875z8dp777.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Sun, Sep 13, 2020 at 08:27:23PM +0200, Thomas Gleixner wrote:
>> On Sun, Sep 13 2020 at 17:44, Michael Ellerman wrote:
>> > Kees Cook <keescook@chromium.org> writes:
>> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
>> > index 18683598edbc..901361e2f8ea 100644
>> > --- a/kernel/entry/common.c
>> > +++ b/kernel/entry/common.c
>> > @@ -60,13 +60,15 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>> >                         return ret;
>> >         }
>> >  
>> > +       syscall = syscall_get_nr(current, regs);
>> > +
>> >         if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
>> >                 trace_sys_enter(regs, syscall);
>> >  
>> >         syscall_enter_audit(regs, syscall);
>> >  
>> >         /* The above might have changed the syscall number */
>> > -       return ret ? : syscall_get_nr(current, regs);
>> > +       return ret ? : syscall;
>> >  }
>> 
>> Yup, this looks right. Can you please send a proper patch?
>
> I already did on Friday:
> https://lore.kernel.org/lkml/20200912005826.586171-1-keescook@chromium.org/

Thanks.

cheers
