Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6B9380425
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 09:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhENH1e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 03:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhENH1e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2021 03:27:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D82C061574;
        Fri, 14 May 2021 00:26:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b2c00f343c5c4aba7bf62.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2c00:f343:c5c4:aba7:bf62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44F091EC04DA;
        Fri, 14 May 2021 09:26:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620977179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SB6w37OHx1PdPBc4bwK76h7qxqDhGJZd+afOOaADJR4=;
        b=LoDJXrxapPrxUEQji+/rq3rjQtVd+L1dSzB2VtHiMQmBj06wUZ9Qmzdf24P0xsdG/lEsrJ
        4jnPXCCYN0ARkA0wvmEZBdj9iJd211rAUvucoiwckF6q9+dVaTfpr2x5BvpJgLncAuuvBF
        7VXHHuox+cp/i0y6/szo7WyxUxBMoDc=
Date:   Fri, 14 May 2021 09:26:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
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
Subject: Re: [PATCH v8 5/6] x86/signal: Detect and prevent an alternate
 signal stack overflow
Message-ID: <YJ4mDQA0rG/UsjhC@zn.tnic>
References: <20210422044856.27250-1-chang.seok.bae@intel.com>
 <20210422044856.27250-6-chang.seok.bae@intel.com>
 <YJrOsbyYhMndI5jd@zn.tnic>
 <B8EF2379-0AF6-4D00-B6B8-214CA9073BFC@intel.com>
 <87pmxv65av.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pmxv65av.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 12, 2021 at 10:55:04PM +0200, Thomas Gleixner wrote:
> On Wed, May 12 2021 at 18:48, Chang Seok Bae wrote:
> > On May 11, 2021, at 11:36, Borislav Petkov <bp@alien8.de> wrote:
> >> 
> >> I clumsily tried to register a SIGSEGV handler with
> >> 
> >>        act.sa_sigaction = my_sigsegv;
> >>        sigaction(SIGSEGV, &act, NULL);
> >> 
> >> but that doesn't fire - task gets killed. Maybe I'm doing it wrong.
> >
> > Since the altstack is already overflowed, perhaps set the flag like this -- not
> > using it to get the handler:
> >
> > 	act.sa_sigaction = my_sigsegv;
> > +	act.sa_flags = SA_SIGINFO;
> > 	sigaction(SIGSEGV, &act, NULL);
> >
> > FWIW, I think this is just a workaround for this case; in practice, altstack is
> > rather a backup for normal stack corruption.
> 
> That's the intended usage, but it's not limited to that and there exists
> creative (ab)use of sigaltstack beyond catching the overflow of the
> regular stack.

Right, with the above sa_flags setting (SA_ONSTACK removed) it does run the
SIGSEGV handler:

# [NOTE]        the stack size is 2048, AT_MINSIGSTKSZ: 3632
TAP version 13
1..3
ok 1 Initial sigaltstack state was SS_DISABLE
# sstack: 0x7f4e2e4d1000, ss_size: 2048
# [NOTE]        sigaltstack success
# [NOTE]        Will mmap user stack
# [NOTE]        Will getcontext
# [NOTE]        Will makecontext
# [NOTE]        Will raise SIGUSR1
# [NOTE]        signal SEGV
^^^^^^^^^^^

# [NOTE]        Will sigaltstack
ok 2 sigaltstack is still SS_AUTODISARM after signal
# Planned tests != run tests (3 != 2)
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

and exits normally. dmesg has:

[220514.661048] signal: get_sigframe: nested_altstack: 0, sp: 0x7ffc2846bca0, ka->sa.sa_flags: 0xc000004
[220514.661058] signal: get_sigframe: SA_ONSTACK, sas_ss_flags(sp): 0x0
[220514.661061] signal: get_sigframe: sp: 0x7f4e2e4d1800, entering_altstack
[220514.661064] signal: get_sigframe: nested_altstack: 0, entering_altstack: 1, __on_sig_stack: 0
[220514.661067] signal: sas[77819] overflowed sigaltstack

so at least we've warned that we've overflowed the sigaltstack.

[220514.661072] signal: get_sigframe: nested_altstack: 0, sp: 0x7ffc2846bca0, ka->sa.sa_flags: 0x4000004
[220514.661075] signal: get_sigframe: nested_altstack: 0, entering_altstack: 0, __on_sig_stack: 0

So I'm not even going to think about claiming that this is taking care
of the other productive ways of (ab)using the sigaltstack contraption
but from where I'm standing, it is not making it worse, AFAICT.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
