Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1437113B
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 07:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhECFbQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 01:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhECFbQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2021 01:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620019823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ImziyibmNpjZjYvVSPJaUYDeRAagmIBqgDVCp2uxPw=;
        b=URgylLQNA2EIDIfSsBNsegCjU8ju/YRyosD6UzyMn4Yjbex6ErkXMHj78NYJ4yZONgN3nF
        Rz9bsCzXaTGciwknWNd+hoS3Cn+bAzOGFHTffULJnDnTUxLIi1hdhEKb09rZloPjuqhJoF
        behnxbiDDHouBVOHcRIDzcyzLWq87Z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-KMI4Pi7mNRq9RpokUIjc1g-1; Mon, 03 May 2021 01:30:21 -0400
X-MC-Unique: KMI4Pi7mNRq9RpokUIjc1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F2921922036;
        Mon,  3 May 2021 05:30:18 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-137.ams2.redhat.com [10.36.112.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 119CC67890;
        Mon,  3 May 2021 05:30:08 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
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
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
        <20210316065215.23768-6-chang.seok.bae@intel.com>
        <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
        <20210325185435.GB32296@zn.tnic>
        <CALCETrXQZuvJQrHDMst6PPgtJxaS_sPk2JhwMiMDNPunq45YFg@mail.gmail.com>
        <20210326103041.GB25229@zn.tnic>
        <DB68C825-25F9-48F9-AFAD-4F6C7DCA11F8@intel.com>
        <20210414101250.GD10709@zn.tnic>
        <87o8eh9k7w.fsf@oldenburg.str.redhat.com>
        <20210414120608.GE10709@zn.tnic>
Date:   Mon, 03 May 2021 07:30:21 +0200
In-Reply-To: <20210414120608.GE10709@zn.tnic> (Borislav Petkov's message of
        "Wed, 14 Apr 2021 14:06:08 +0200")
Message-ID: <877dkg8jv6.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Borislav Petkov:

>> One possibility is that the sigaltstack size check prevents application
>> from running which work just fine today because all they do is install a
>> stack overflow handler, and stack overflow does not actually happen.
>
> So sigaltstack(2) says in the NOTES:
>
>        Functions  called  from  a signal handler executing on an alternat=
e signal stack
>        will also use the alternate signal stack.  (This also applies  to =
 any  handlers
>        invoked for other signals while the process is executing on the al=
ternate signal
>        stack.)  Unlike the standard stack, the system does not automatica=
lly extend the
>        alternate  signal  stack.   Exceeding the allocated size of the al=
ternate signal
>        stack will lead to unpredictable results.
>
>> So if sigaltstack fails and the application checks the result of the
>> system call, it probably won't run at all. Shifting the diagnostic to
>> the pointer where the signal would have to be delivered is perhaps the
>> only thing that can be done.
>
> So using the example from the same manpage:
>
>        The most common usage of an alternate signal stack is to handle th=
e SIGSEGV sig=E2=80=90
>        nal that is generated if the space available for the normal proces=
s stack is ex=E2=80=90
>        hausted: in this case, a signal handler for SIGSEGV cannot  be  in=
voked  on  the
>        process stack; if we wish to handle it, we must use an alternate s=
ignal stack.
>
> and considering these "unpredictable results" would it make sense or
> even be at all possible to return SIGFAIL from that SIGSEGV signal
> handler which should run on the sigaltstack but that sigaltstack
> overflows?
>
> I think we wanna be able to tell the process through that previously
> registered SIGSEGV handler which is supposed to run on the sigaltstack,
> that that stack got overflowed.

Just to be clear, I'm worried about the case where an application
installs a stack overflow handler, but stack overflow does not regularly
happen at run time.  GNU m4 is an example.  Today, for most m4 scripts,
it's totally fine to have an alternative signal stack which is too
small.  If the kernel returned an error for the sigaltstack call, m4
wouldn't start anymore, independently of the script.  Which is worse
than memory corruption with some scripts, I think.

> Or is this use case obsolete and this is not what people do at all?

It's widely used in currently-maintained software.  It's the only way to
recover from stack overflows without boundary checks on every function
call.

Does the alternative signal stack actually have to contain the siginfo_t
data?  I don't think it has to be contiguous.  Maybe the kernel could
allocate and map something behind the processes back if the sigaltstack
region is too small?

And for the stack overflow handler, the kernel could treat SIGSEGV with
a sigaltstack region that is too small like the SIG_DFL handler.  This
would make m4 work again.

Thanks,
Florian

