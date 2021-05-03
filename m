Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FF637141F
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 13:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhECLR7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 07:17:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48030 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232868AbhECLR7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 May 2021 07:17:59 -0400
Received: from zn.tnic (p200300ec2f268e00596557e7a2777a9d.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:8e00:5965:57e7:a277:7a9d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 38F741EC0419;
        Mon,  3 May 2021 13:17:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620040624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MU1V7MQihEu+KJpscrtBmUqeHfxQ/TteggSascxCRdE=;
        b=YmlOlel2zQcfWUwcZjhQbd9PplzvrIA4gD0JDrWGUW1EtGky1JiWzVgj4aHSrlmaZdWT+t
        ZS/HTE3TvYw+RvljJhB+bT0M+WSH117CRt0Pb2v7ixGh6sBoziG6bWrbM2j0aJIgkJZ4Th
        Ir9iDO951GSCDzHWx2FAc7MdoimdObA=
Date:   Mon, 3 May 2021 13:17:02 +0200
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
Message-ID: <YI/brhlCsKd4PTDP@zn.tnic>
References: <20210316065215.23768-6-chang.seok.bae@intel.com>
 <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
 <20210325185435.GB32296@zn.tnic>
 <CALCETrXQZuvJQrHDMst6PPgtJxaS_sPk2JhwMiMDNPunq45YFg@mail.gmail.com>
 <20210326103041.GB25229@zn.tnic>
 <DB68C825-25F9-48F9-AFAD-4F6C7DCA11F8@intel.com>
 <20210414101250.GD10709@zn.tnic>
 <87o8eh9k7w.fsf@oldenburg.str.redhat.com>
 <20210414120608.GE10709@zn.tnic>
 <877dkg8jv6.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877dkg8jv6.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 03, 2021 at 07:30:21AM +0200, Florian Weimer wrote:
> Just to be clear, I'm worried about the case where an application
> installs a stack overflow handler, but stack overflow does not regularly
> happen at run time.  GNU m4 is an example.  Today, for most m4 scripts,
> it's totally fine to have an alternative signal stack which is too
> small.  If the kernel returned an error for the sigaltstack call, m4
> wouldn't start anymore, independently of the script.  Which is worse
> than memory corruption with some scripts, I think.

Oh lovely.

> 
> > Or is this use case obsolete and this is not what people do at all?
> 
> It's widely used in currently-maintained software.  It's the only way to
> recover from stack overflows without boundary checks on every function
> call.
> 
> Does the alternative signal stack actually have to contain the siginfo_t
> data?  I don't think it has to be contiguous.  Maybe the kernel could
> allocate and map something behind the processes back if the sigaltstack
> region is too small?

So there's an attempt floating around to address this:

https://lkml.kernel.org/r/20210422044856.27250-1-chang.seok.bae@intel.com

esp patch 3.

I'd appreciate having a look and sanity-checking this whether it makes
sense and could be useful this way...

> And for the stack overflow handler, the kernel could treat SIGSEGV with
> a sigaltstack region that is too small like the SIG_DFL handler.  This
> would make m4 work again.

/me searches a bit about SIG_DFL...

Do you mean that the default action in this case should be what SIGSEGV
does by default - to dump core?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
