Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D46B367CC9
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 10:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhDVIq7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 22 Apr 2021 04:46:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:45445 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235508AbhDVIq5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Apr 2021 04:46:57 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-80-mYnYClkmMvq7hiPeIZodaQ-1; Thu, 22 Apr 2021 09:46:19 +0100
X-MC-Unique: mYnYClkmMvq7hiPeIZodaQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 22 Apr 2021 09:46:14 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Thu, 22 Apr 2021 09:46:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Chang S. Bae'" <chang.seok.bae@intel.com>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "len.brown@intel.com" <len.brown@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "jannh@google.com" <jannh@google.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 5/6] x86/signal: Detect and prevent an alternate signal
 stack overflow
Thread-Topic: [PATCH v8 5/6] x86/signal: Detect and prevent an alternate
 signal stack overflow
Thread-Index: AQHXNzOfB++Ln2WD/U+jOvjJUzWT2qrAORRg
Date:   Thu, 22 Apr 2021 08:46:14 +0000
Message-ID: <854d6aefdf604b559e37e82669b5e67f@AcuMS.aculab.com>
References: <20210422044856.27250-1-chang.seok.bae@intel.com>
 <20210422044856.27250-6-chang.seok.bae@intel.com>
In-Reply-To: <20210422044856.27250-6-chang.seok.bae@intel.com>
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

From: Chang S. Bae
> Sent: 22 April 2021 05:49
> 
> The kernel pushes context on to the userspace stack to prepare for the
> user's signal handler. When the user has supplied an alternate signal
> stack, via sigaltstack(2), it is easy for the kernel to verify that the
> stack size is sufficient for the current hardware context.
> 
> Check if writing the hardware context to the alternate stack will exceed
> it's size. If yes, then instead of corrupting user-data and proceeding with
> the original signal handler, an immediate SIGSEGV signal is delivered.

What happens if SIGSEGV is caught?

> Refactor the stack pointer check code from on_sig_stack() and use the new
> helper.
> 
> While the kernel allows new source code to discover and use a sufficient
> alternate signal stack size, this check is still necessary to protect
> binaries with insufficient alternate signal stack size from data
> corruption.
...
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 3f6a0fcaa10c..ae60f838ebb9 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -537,6 +537,17 @@ static inline int kill_cad_pid(int sig, int priv)
>  #define SEND_SIG_NOINFO ((struct kernel_siginfo *) 0)
>  #define SEND_SIG_PRIV	((struct kernel_siginfo *) 1)
> 
> +static inline int __on_sig_stack(unsigned long sp)
> +{
> +#ifdef CONFIG_STACK_GROWSUP
> +	return sp >= current->sas_ss_sp &&
> +		sp - current->sas_ss_sp < current->sas_ss_size;
> +#else
> +	return sp > current->sas_ss_sp &&
> +		sp - current->sas_ss_sp <= current->sas_ss_size;
> +#endif
> +}
> +

Those don't look different enough.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

