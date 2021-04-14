Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42AD35F14E
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 12:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhDNKNL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 06:13:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47620 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232631AbhDNKNK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 06:13:10 -0400
Received: from zn.tnic (p200300ec2f0e8f0047b5d8db40ec11d2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8f00:47b5:d8db:40ec:11d2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0D021EC0528;
        Wed, 14 Apr 2021 12:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618395168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=v5HUY65OS78ET9NFUwXyXqIOqxRqJhTJ7DiNehOvsA4=;
        b=RLeFPTKrvHtvaFERYcN8XC52g3wEm7k4DwS6AYJnuoN3Fa0h+ssGq1e/w04BP0lfeeejkt
        MkUVJAyxPy6m7LbMD1Kukk60nerb9KyLenIMkWrfVmJB5B8J3uZmWyrICZDCZzYf6LXPEO
        3QHxyMi4wTomiOkxRs9v3XriVFHWRB0=
Date:   Wed, 14 Apr 2021 12:12:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20210414101250.GD10709@zn.tnic>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210316065215.23768-6-chang.seok.bae@intel.com>
 <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
 <20210325185435.GB32296@zn.tnic>
 <CALCETrXQZuvJQrHDMst6PPgtJxaS_sPk2JhwMiMDNPunq45YFg@mail.gmail.com>
 <20210326103041.GB25229@zn.tnic>
 <DB68C825-25F9-48F9-AFAD-4F6C7DCA11F8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB68C825-25F9-48F9-AFAD-4F6C7DCA11F8@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 12, 2021 at 10:30:23PM +0000, Bae, Chang Seok wrote:
> On Mar 26, 2021, at 03:30, Borislav Petkov <bp@alien8.de> wrote:
> > On Thu, Mar 25, 2021 at 09:56:53PM -0700, Andy Lutomirski wrote:
> >> We really ought to have a SIGSIGFAIL signal that's sent, double-fault
> >> style, when we fail to send a signal.
> > 
> > Yeap, we should be able to tell userspace that we couldn't send a
> > signal, hohumm.
> 
> Hi Boris,
> 
> Let me clarify some details as preparing to include this in a revision.
> 
> So, IIUC, a number needs to be assigned for this new SIGFAIL. At a glance, not
> sure which one to pick there in signal.h -- 1-31 fully occupied and the rest
> for 33 different real-time signals.
> 
> Also, perhaps, force_sig(SIGFAIL) here, instead of return -1 -- to die with
> SIGSEGV.

I think this needs to be decided together with userspace people so that
they can act accordingly and whether it even makes sense to them.

Florian, any suggestions?

Subthread starts here:

https://lkml.kernel.org/r/CALCETrXQZuvJQrHDMst6PPgtJxaS_sPk2JhwMiMDNPunq45YFg@mail.gmail.com

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
