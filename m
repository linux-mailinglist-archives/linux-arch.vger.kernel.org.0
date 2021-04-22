Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA613688D2
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 00:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbhDVWEr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 22 Apr 2021 18:04:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:27625 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239650AbhDVWEq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Apr 2021 18:04:46 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-256-gvvl59V8ObOmYuCwWGLDrg-1; Thu, 22 Apr 2021 23:04:08 +0100
X-MC-Unique: gvvl59V8ObOmYuCwWGLDrg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 22 Apr 2021 23:04:07 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Thu, 22 Apr 2021 23:04:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Bae, Chang Seok'" <chang.seok.bae@intel.com>
CC:     "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "jannh@google.com" <jannh@google.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 5/6] x86/signal: Detect and prevent an alternate signal
 stack overflow
Thread-Topic: [PATCH v8 5/6] x86/signal: Detect and prevent an alternate
 signal stack overflow
Thread-Index: AQHXNzOfB++Ln2WD/U+jOvjJUzWT2qrAORRggABxogCAAGjMcA==
Date:   Thu, 22 Apr 2021 22:04:07 +0000
Message-ID: <1955da4c211f4d4fbbf74a6b8bdae0f6@AcuMS.aculab.com>
References: <20210422044856.27250-1-chang.seok.bae@intel.com>
 <20210422044856.27250-6-chang.seok.bae@intel.com>
 <854d6aefdf604b559e37e82669b5e67f@AcuMS.aculab.com>
 <9C452E66-0C41-462B-9971-56825444AD65@intel.com>
In-Reply-To: <9C452E66-0C41-462B-9971-56825444AD65@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Bae, Chang Seok
> Sent: 22 April 2021 17:31

> 
> On Apr 22, 2021, at 01:46, David Laight <David.Laight@ACULAB.COM> wrote:
> > From: Chang S. Bae
> >> Sent: 22 April 2021 05:49
> >>
> >> The kernel pushes context on to the userspace stack to prepare for the
> >> user's signal handler. When the user has supplied an alternate signal
> >> stack, via sigaltstack(2), it is easy for the kernel to verify that the
> >> stack size is sufficient for the current hardware context.
> >>
> >> Check if writing the hardware context to the alternate stack will exceed
> >> it's size. If yes, then instead of corrupting user-data and proceeding with
> >> the original signal handler, an immediate SIGSEGV signal is delivered.
> >
> > What happens if SIGSEGV is caught?
> 
> Boris pointed out the relevant notes before [1]. I think "unpredictable
> results" is a somewhat vague statement but process termination is unavoidable
> in this situation.
> 
> In the thread [1], a new signal number was discussed for the signal delivery
> failure, but my takeaway is this SIGSEGV is still recognizable.
> 
> FWIW, Len summarized other possible approaches as well [2].

Let's see...
I use an on-stack buffer for the alternate stack and then setup
siglongjmp() to return back from whatever ran out of stack space
back to the processing loop.

So my attempts to trap over-deep recursion cause the main stack
to get corrupted - this is a normal stack overwrite that might
be exploitable!

Alternatively I used malloc() and we have a potentially exploitable
heap overrun.

The only thing the kernel can do is to immediately kill the process
(possibly with a core dump).
Since signals can get nested the kernel needs to ensure there
is a reasonably amount of space left after the signal info is
written to the alternate stack.

> 
> >> Refactor the stack pointer check code from on_sig_stack() and use the new
> >> helper.
> >>
> >> While the kernel allows new source code to discover and use a sufficient
> >> alternate signal stack size, this check is still necessary to protect
> >> binaries with insufficient alternate signal stack size from data
> >> corruption.
> > ...
> >> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> >> index 3f6a0fcaa10c..ae60f838ebb9 100644
> >> --- a/include/linux/sched/signal.h
> >> +++ b/include/linux/sched/signal.h
> >> @@ -537,6 +537,17 @@ static inline int kill_cad_pid(int sig, int priv)
> >> #define SEND_SIG_NOINFO ((struct kernel_siginfo *) 0)
> >> #define SEND_SIG_PRIV	((struct kernel_siginfo *) 1)
> >>
> >> +static inline int __on_sig_stack(unsigned long sp)
> >> +{
> >> +#ifdef CONFIG_STACK_GROWSUP
> >> +	return sp >= current->sas_ss_sp &&
> >> +		sp - current->sas_ss_sp < current->sas_ss_size;
> >> +#else
> >> +	return sp > current->sas_ss_sp &&
> >> +		sp - current->sas_ss_sp <= current->sas_ss_size;
> >> +#endif
> >> +}
> >> +
> >
> > Those don't look different enough.
> 
> The difference is on the SS_AUTODISARM flag check.  This refactoring was
> suggested as on_sig_stack() brought confusion [3].

I was just confused by the #ifdef.
Whether %sp points to the last item or the next space is actually
independent of the stack direction.
A stack might usually use pre-decrement and post-increment but it
doesn't have to.
The stack pointer can't be right at one end of the alt-stack
area (because that is the address you'd use when you switch to it),
and if you are any where near the other end you are hosed.
So a common test:
	return (unsigned long)(sp - current->sas_ss_sp) < current->sas_ss_size;
will always work.

It isn't as though the stack pointer should be anywhere else
other than the 'real' thread stack.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

