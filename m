Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4626B34A594
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 11:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhCZKbQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 06:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhCZKaq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2021 06:30:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2841FC0613AA;
        Fri, 26 Mar 2021 03:30:45 -0700 (PDT)
Received: from zn.tnic (p200300ec2f075f005a8cb2de3dea7159.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:5f00:5a8c:b2de:3dea:7159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9CA41EC0527;
        Fri, 26 Mar 2021 11:30:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616754643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W+8JSi+jUutInDYaNQdxHTb+gXqbdXr/OzLah6NLmkM=;
        b=OIayWCHp1dvLNkQjVAGc5/tMcCL43oiq0F0QPBO48+ycq2QZFnxx6DAmc7uY7ssnR3Cdrc
        nNG4CohAjAxZbAb910qTZMgQjwGNDscbhlcl9ddipRaX3ZW9fFA5K3I+jMnMtW2r/DcHqD
        W6ebeYOTP/HQajqeSQOvsPocTnxQlOs=
Date:   Fri, 26 Mar 2021 11:30:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Carlos O'Donell <carlos@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate
 signal stack overflow
Message-ID: <20210326103041.GB25229@zn.tnic>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210316065215.23768-6-chang.seok.bae@intel.com>
 <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
 <20210325185435.GB32296@zn.tnic>
 <CALCETrXQZuvJQrHDMst6PPgtJxaS_sPk2JhwMiMDNPunq45YFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXQZuvJQrHDMst6PPgtJxaS_sPk2JhwMiMDNPunq45YFg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 25, 2021 at 09:56:53PM -0700, Andy Lutomirski wrote:
> Nope.  on_sig_stack() is a horrible kludge and won't work here.  We
> could have something like __on_sig_stack() or sp_is_on_sig_stack() or
> something, though.

Yeah, see my other reply. Ack to either of those carved out helpers.

> I figure that the people whose programs spontaneously crash should get
> a hint why if they look at dmesg.  Maybe the message should say
> "overflowed sigaltstack -- try noavx512"?

I guess, as long as it is ratelimited. I mean, we can remove it later if
it starts gettin' annoying.

> We really ought to have a SIGSIGFAIL signal that's sent, double-fault
> style, when we fail to send a signal.

Yeap, we should be able to tell userspace that we couldn't send a
signal, hohumm.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
