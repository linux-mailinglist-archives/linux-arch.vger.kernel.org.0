Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD8A467E8D
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 20:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353649AbhLCUBP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 15:01:15 -0500
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:62956 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353557AbhLCUBO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 15:01:14 -0500
X-Greylist: delayed 667 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2021 15:01:13 EST
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 28F2B3126D;
        Fri,  3 Dec 2021 14:46:41 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=e8GgRkOhPDs0qbjQ+TyMJjHJwoc=; b=VlY0jw
        I3S9UFo0N8mAzqUxKilSQw88vfBvUEQ+fPSIZVVtiZo4uN9UfL+MzH/YW89QLGU0
        ThZifqctfrlukloFaxmmfeK6aE6/5fEgll7I+GJkp5FeuJwSXuhkxpZOUmvn6+YI
        Qqyj9v7b2fDNyfRezv90mlbrGCZI3XsUujbkA=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 065DD3126A;
        Fri,  3 Dec 2021 14:46:41 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=0KiVSGYQPApVsC/eIr9S8dRge8YHqZbB1plM/jwiKw0=; b=kmMPHM+dF+VxidAAH0bLmn6Nrlkq+z+DGVgxeG3CfuOtP/X4kZMQv70fgjnm1WftLsHj2g4UdhCug2PKw2S6fcR3DQ4rlIQnRIsVk+D4WRMLH3J/7so1oMK8fCeAqm9kGkFvm1bD4rQh+j0pRaTeVn12mFS2NwhrSv27gGvypcw=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5CE5BEA5F7;
        Fri,  3 Dec 2021 14:46:40 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 329B92DA0092;
        Fri,  3 Dec 2021 14:46:39 -0500 (EST)
Date:   Fri, 3 Dec 2021 14:46:39 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev, hjl.tools@gmail.com
Subject: Re: [PATCH v8 05/14] x86: conditionally place regular ASM functions
 into separate sections
In-Reply-To: <20211203163424.GK16608@worktop.programming.kicks-ass.net>
Message-ID: <28856p61-r54s-791n-q6s1-27575s62r2q9@syhkavp.arg>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com> <20211202223214.72888-6-alexandr.lobakin@intel.com> <Yanm6tJ2obi1aKv6@hirez.programming.kicks-ass.net> <20211203141051.82467-1-alexandr.lobakin@intel.com>
 <20211203163424.GK16608@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: BC045B9E-5471-11EC-B3F6-62A2C8D8090B-78420484!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 3 Dec 2021, Peter Zijlstra wrote:

> On Fri, Dec 03, 2021 at 03:10:51PM +0100, Alexander Lobakin wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Fri, 3 Dec 2021 10:44:10 +0100
> > 
> > > On Thu, Dec 02, 2021 at 11:32:05PM +0100, Alexander Lobakin wrote:
> > > > Use the newly introduces macros to create unique separate sections
> > > > for (almost) every "regular" ASM function (i.e. for those which
> > > > aren't explicitly put into a specific one).
> > > > There should be no leftovers as input .text will be size-asserted
> > > > in the LD script generated for FG-KASLR.
> > > 
> > > *groan*...
> > > 
> > > Please, can't we do something like:
> > > 
> > > #define SYM_PUSH_SECTION(name)	\
> > > .if section == .text		\
> > > .push_section .text.##name	\
> > > .else				\
> > > .push_section .text		\
> > > .endif
> > > 
> > > #define SYM_POP_SECTION()	\
> > > .pop_section
> > > 
> > > and wrap that inside the existing SYM_FUNC_START*() SYM_FUNC_END()
> > > macros.
> > 
> > Ah I see. I asked about this in my previous mail and you replied
> > already (: Cool stuff, I'll use it, it simplifies things a lot.
> 
> Note, I've no idea if it works. GAS and me aren't really on speaking
> terms. It would be my luck for that to be totally impossible, hjl?

Surely this would do it:

http://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=451133cefa839104


Nicolas
