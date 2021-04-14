Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7559435F321
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 14:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345830AbhDNMGg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 08:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbhDNMGf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Apr 2021 08:06:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB40C061574;
        Wed, 14 Apr 2021 05:06:13 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e8f000d8b3334e5756a5b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8f00:d8b:3334:e575:6a5b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0ACE51EC0258;
        Wed, 14 Apr 2021 14:06:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618401971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bOwwcL9Kvry/JIj9MWAQh0BzulfnML/XsdeCNjF41M=;
        b=EsuYHJF3Mmmb93XzYTaMkibkCmffFwBslbVFH03vanOMA4FczPFO8Se8D0necJ6pPRe4eC
        vlU/Opqz1DYiJYhxQRuxEwS6CSX+TH9OaavRMct5Wi5VSGSGX30KGZnJI+9F2RmPi4TjgY
        WkJ4fvykBHrcHCYEHYJPvusUTO96L9k=
Date:   Wed, 14 Apr 2021 14:06:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Carlos O'Donell <carlos@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate
 signal stack overflow
Message-ID: <20210414120608.GE10709@zn.tnic>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210316065215.23768-6-chang.seok.bae@intel.com>
 <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
 <20210325185435.GB32296@zn.tnic>
 <CALCETrXQZuvJQrHDMst6PPgtJxaS_sPk2JhwMiMDNPunq45YFg@mail.gmail.com>
 <20210326103041.GB25229@zn.tnic>
 <DB68C825-25F9-48F9-AFAD-4F6C7DCA11F8@intel.com>
 <20210414101250.GD10709@zn.tnic>
 <87o8eh9k7w.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8eh9k7w.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 14, 2021 at 01:30:43PM +0200, Florian Weimer wrote:
> Is this discussion about better behavior (at least diagnostics) for
> existing applications, without any code changes?  Or an alternative
> programming model?

Former.

> Does noavx512 acutally reduce the XSAVE size to AVX2 levels?

Yeah.

> Or would you need noxsave?

I don't think so.

> One possibility is that the sigaltstack size check prevents application
> from running which work just fine today because all they do is install a
> stack overflow handler, and stack overflow does not actually happen.

So sigaltstack(2) says in the NOTES:

       Functions  called  from  a signal handler executing on an alternate signal stack
       will also use the alternate signal stack.  (This also applies  to  any  handlers
       invoked for other signals while the process is executing on the alternate signal
       stack.)  Unlike the standard stack, the system does not automatically extend the
       alternate  signal  stack.   Exceeding the allocated size of the alternate signal
       stack will lead to unpredictable results.

> So if sigaltstack fails and the application checks the result of the
> system call, it probably won't run at all. Shifting the diagnostic to
> the pointer where the signal would have to be delivered is perhaps the
> only thing that can be done.

So using the example from the same manpage:

       The most common usage of an alternate signal stack is to handle the SIGSEGV sig‐
       nal that is generated if the space available for the normal process stack is ex‐
       hausted: in this case, a signal handler for SIGSEGV cannot  be  invoked  on  the
       process stack; if we wish to handle it, we must use an alternate signal stack.

and considering these "unpredictable results" would it make sense or
even be at all possible to return SIGFAIL from that SIGSEGV signal
handler which should run on the sigaltstack but that sigaltstack
overflows?

I think we wanna be able to tell the process through that previously
registered SIGSEGV handler which is supposed to run on the sigaltstack,
that that stack got overflowed.

Or is this use case obsolete and this is not what people do at all?

> As for SIGFAIL in particular, I don't think there are any leftover
> signal numbers.  It would need a prctl to assign the signal number, and
> I'm not sure if there is a useful programming model because signals do
> not really compose well even today.  SIGFAIL adds another point where
> libraries need to collaborate, and we do not have a mechanism for that.
> (This is about what Rich Felker termed “library-safe code”, proper
> maintenance of process-wide resources such as the current directory.)

Oh fun.

I guess if Linux goes and does something, people would adopt it and
it'll become standard. :-P

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
