Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2F111C936
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 10:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfLLJeb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 04:34:31 -0500
Received: from foss.arm.com ([217.140.110.172]:39692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbfLLJeb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Dec 2019 04:34:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB8CA328;
        Thu, 12 Dec 2019 01:34:30 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 047A83F6CF;
        Thu, 12 Dec 2019 01:34:28 -0800 (PST)
Date:   Thu, 12 Dec 2019 09:34:26 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 12/22] arm64: mte: Add specific SIGSEGV codes
Message-ID: <20191212093425.GA18258@arrakis.emea.arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-13-catalin.marinas@arm.com>
 <CAK8P3a1-eaR7NddhDce65vXKCGeZD3xUMrTTAWN4U3oW0ecN=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1-eaR7NddhDce65vXKCGeZD3xUMrTTAWN4U3oW0ecN=g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 08:31:28PM +0100, Arnd Bergmann wrote:
> On Wed, Dec 11, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >
> > Add MTE-specific SIGSEGV codes to siginfo.h.
> >
> > Note that the for MTE we are reusing the same SPARC ADI codes because
> > the two functionalities are similar and they cannot coexist on the same
> > system.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > [catalin.marinas@arm.com: renamed precise/imprecise to sync/async]
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  include/uapi/asm-generic/siginfo.h | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> > index cb3d6c267181..a5184a5438c6 100644
> > --- a/include/uapi/asm-generic/siginfo.h
> > +++ b/include/uapi/asm-generic/siginfo.h
> > @@ -227,8 +227,13 @@ typedef struct siginfo {
> >  # define SEGV_PKUERR   4       /* failed protection key checks */
> >  #endif
> >  #define SEGV_ACCADI    5       /* ADI not enabled for mapped object */
> > -#define SEGV_ADIDERR   6       /* Disrupting MCD error */
> > -#define SEGV_ADIPERR   7       /* Precise MCD exception */
> > +#ifdef __aarch64__
> > +# define SEGV_MTEAERR  6       /* Asynchronous MTE error */
> > +# define SEGV_MTESERR  7       /* Synchronous MTE exception */
> > +#else
> > +# define SEGV_ADIDERR  6       /* Disrupting MCD error */
> > +# define SEGV_ADIPERR  7       /* Precise MCD exception */
> > +#endif
> 
> SEGV_ADIPERR/SEGV_ADIDERR were added together with SEGV_ACCADI,
> it seems a bit odd to make only two of them conditional but not the others.

Ah, I missed this. I think we should drop the #ifdef entirely. There is
no harm in having two different macros with the same value.

> I think we are generally working towards having the same constants
> across architectures even for features that only exist on one of them.

I'd rather keep both the ARM and SPARC naming here as the behaviour may
be subtly different between the two architectures. IIUC, the disrupting
SPARC MCD error on means a memory corruption trap sent to the
hypervisor. On ARM MTE, the asynchronous tag check fault is a pretty
much benign setting of a status flag. The kernel, when detecting this
flag, injects a SIGSEGV on the ret_to_user path. If there's no switch
into the kernel, a user program cannot become aware of the asynchronous
MTE tag check fault.

We also don't have the equivalent of ACCADI.

-- 
Catalin
