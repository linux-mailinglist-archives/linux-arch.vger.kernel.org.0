Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB86435F296
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 13:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhDNLbL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 07:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232810AbhDNLbH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 07:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618399846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LyIC5RGvBzIiVUIrXj69K0tPPcpcceqwQSx58Xx++U8=;
        b=CrxBHDJ0hOuuE/x6a3Lwiiekj8z9k/zbbc80K9pfuirHdkWtUax3VAwVqV8GE/NUPgqRhM
        0yyXoLaUEWiE/xHkmsdAsv3OdHZNO7HNm5LbN4wLMOLuEhZFI4Ld/RDwjz+iN6YhhMcMFG
        wULTmkjUSGn1Ib5XsYVaoZ+UoLHBdSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-7XJ8A4JPOw6Z2S_tI1lLHw-1; Wed, 14 Apr 2021 07:30:42 -0400
X-MC-Unique: 7XJ8A4JPOw6Z2S_tI1lLHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22D1D80D6A8;
        Wed, 14 Apr 2021 11:30:40 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-148.ams2.redhat.com [10.36.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32FC76F99C;
        Wed, 14 Apr 2021 11:30:29 +0000 (UTC)
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
Date:   Wed, 14 Apr 2021 13:30:43 +0200
In-Reply-To: <20210414101250.GD10709@zn.tnic> (Borislav Petkov's message of
        "Wed, 14 Apr 2021 12:12:50 +0200")
Message-ID: <87o8eh9k7w.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Borislav Petkov:

> On Mon, Apr 12, 2021 at 10:30:23PM +0000, Bae, Chang Seok wrote:
>> On Mar 26, 2021, at 03:30, Borislav Petkov <bp@alien8.de> wrote:
>> > On Thu, Mar 25, 2021 at 09:56:53PM -0700, Andy Lutomirski wrote:
>> >> We really ought to have a SIGSIGFAIL signal that's sent, double-fault
>> >> style, when we fail to send a signal.
>> >=20
>> > Yeap, we should be able to tell userspace that we couldn't send a
>> > signal, hohumm.
>>=20
>> Hi Boris,
>>=20
>> Let me clarify some details as preparing to include this in a revision.
>>=20
>> So, IIUC, a number needs to be assigned for this new SIGFAIL. At a glanc=
e, not
>> sure which one to pick there in signal.h -- 1-31 fully occupied and the =
rest
>> for 33 different real-time signals.
>>=20
>> Also, perhaps, force_sig(SIGFAIL) here, instead of return -1 -- to die w=
ith
>> SIGSEGV.
>
> I think this needs to be decided together with userspace people so that
> they can act accordingly and whether it even makes sense to them.
>
> Florian, any suggestions?

Is this discussion about better behavior (at least diagnostics) for
existing applications, without any code changes?  Or an alternative
programming model?

Does noavx512 acutally reduce the XSAVE size to AVX2 levels?  Or would
you need noxsave?

One possibility is that the sigaltstack size check prevents application
from running which work just fine today because all they do is install a
stack overflow handler, and stack overflow does not actually happen.  So
if sigaltstack fails and the application checks the result of the system
call, it probably won't run at all.  Shifting the diagnostic to the
pointer where the signal would have to be delivered is perhaps the only
thing that can be done.

As for SIGFAIL in particular, I don't think there are any leftover
signal numbers.  It would need a prctl to assign the signal number, and
I'm not sure if there is a useful programming model because signals do
not really compose well even today.  SIGFAIL adds another point where
libraries need to collaborate, and we do not have a mechanism for that.
(This is about what Rich Felker termed =E2=80=9Clibrary-safe code=E2=80=9D,=
 proper
maintenance of process-wide resources such as the current directory.)

Thanks,
Florian

