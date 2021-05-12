Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7764C37EEB0
	for <lists+linux-arch@lfdr.de>; Thu, 13 May 2021 01:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348196AbhELWFF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 May 2021 18:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389927AbhELVEB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 May 2021 17:04:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A686DC0611B5;
        Wed, 12 May 2021 13:55:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620852905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L34T/UenUIuq4jeGVl6/Hdv4Eqp08Y7XCNJ8f0KJUjw=;
        b=Kg6kVYoIgblFaV2cgbUMCuWDceMtbJKTH7blWXawUSb9swAZzsfkOgzIqfxU5BtUj3AY7f
        YY55SOAhpRrVy03NlQRTSQeJWiEK6V6ttfRw7nZEqMTL2q9Sc4aq+rtQlEvRuckkyeXk/U
        x0tNZajCa7SboBoCLmjsoNNzHs9hcZpBsPbYIeq68GhoORMLQPyWQqPzoWMbzOS4gQmTqe
        Ba/Z7AkzJjEdwsUreBxEx7bEPAy5saURcxpKEBy3rkC1tj8mBcR8H7dMiMMdKanVDx5gW4
        rwL2hqIaBrcSMhrGhn3qBF/eBYzDtmqTrty4b4UeOKxvIMLslWdo4Lczwrm8jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620852905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L34T/UenUIuq4jeGVl6/Hdv4Eqp08Y7XCNJ8f0KJUjw=;
        b=JvwFIWeD/Oq7qlJnp6Q65ddy634JUD+/dlVZhUnx7W3Ov7Mqdcu0qt/GeIbtd9/FTKxIpc
        ONMasOCGz62hbLCA==
To:     "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>, "bp\@suse.de" <bp@suse.de>,
        "mingo\@kernel.org" <mingo@kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        "Brown\, Len" <len.brown@intel.com>,
        "Hansen\, Dave" <dave.hansen@intel.com>,
        "hjl.tools\@gmail.com" <hjl.tools@gmail.com>,
        "Dave.Martin\@arm.com" <Dave.Martin@arm.com>,
        "jannh\@google.com" <jannh@google.com>,
        "mpe\@ellerman.id.au" <mpe@ellerman.id.au>,
        "carlos\@redhat.com" <carlos@redhat.com>,
        "Luck\, Tony" <tony.luck@intel.com>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch\@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api\@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 5/6] x86/signal: Detect and prevent an alternate signal stack overflow
In-Reply-To: <B8EF2379-0AF6-4D00-B6B8-214CA9073BFC@intel.com>
References: <20210422044856.27250-1-chang.seok.bae@intel.com> <20210422044856.27250-6-chang.seok.bae@intel.com> <YJrOsbyYhMndI5jd@zn.tnic> <B8EF2379-0AF6-4D00-B6B8-214CA9073BFC@intel.com>
Date:   Wed, 12 May 2021 22:55:04 +0200
Message-ID: <87pmxv65av.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 12 2021 at 18:48, Chang Seok Bae wrote:
> On May 11, 2021, at 11:36, Borislav Petkov <bp@alien8.de> wrote:
>> 
>> I clumsily tried to register a SIGSEGV handler with
>> 
>>        act.sa_sigaction = my_sigsegv;
>>        sigaction(SIGSEGV, &act, NULL);
>> 
>> but that doesn't fire - task gets killed. Maybe I'm doing it wrong.
>
> Since the altstack is already overflowed, perhaps set the flag like this -- not
> using it to get the handler:
>
> 	act.sa_sigaction = my_sigsegv;
> +	act.sa_flags = SA_SIGINFO;
> 	sigaction(SIGSEGV, &act, NULL);
>
> FWIW, I think this is just a workaround for this case; in practice, altstack is
> rather a backup for normal stack corruption.

That's the intended usage, but it's not limited to that and there exists
creative (ab)use of sigaltstack beyond catching the overflow of the
regular stack.

Thanks,

        tglx
