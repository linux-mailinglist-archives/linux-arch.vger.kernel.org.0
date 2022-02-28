Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5C34C7C0B
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 22:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiB1Vb2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 16:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiB1Vb1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 16:31:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB16112F156;
        Mon, 28 Feb 2022 13:30:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 793BF61178;
        Mon, 28 Feb 2022 21:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E4CC340F1;
        Mon, 28 Feb 2022 21:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646083846;
        bh=AM6TeTTQzrvCkefOt+QPZqOwQUTdBvNLhJX5phHONLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GnBVmgo4+8bhttIsNW4CIKc/50E3eVPyAU3WPHvIbZFh526BGoJDDPu9euSQBUDKD
         Hqa0yD2zHl/5viZcYelhCVWRM+sSGX89helGbR2G+NGXJYs+5igCjCAg21SlRAQtDZ
         rLmwcFj0dsqhceZW4/xjGYZ2S/n/ZUup7B9zx22+H49wHPnutO4iwea5ckkuIJwsjj
         eXXNOQyW7txN+VuS5I09mUcPBI3iQcBIYWr/TRup9fbPGQxbfZB3wEiDs98vDtZ3Qb
         ucimmN+ZslCHwheAq1x9BrTHx3oXb0uPUMNIhWsbl1SNq+6FwFrtl+Y726NXn/lDXz
         3V9QuTESvr1aA==
Date:   Mon, 28 Feb 2022 23:30:29 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Adrian Reber <adrian@lisas.de>,
        Florian Weimer <fweimer@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>, Andrei Vagin <avagin@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, Borislav Petkov <bp@alien8.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Message-ID: <Yh0+9cFyAfnsXqxI@kernel.org>
References: <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org>
 <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
 <YgKiKEcsNt7mpMHN@grain>
 <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
 <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org>
 <Yh0wIMjFdDl8vaNM@kernel.org>
 <5a792e77-0072-4ded-9f89-e7fcc7f7a1d6@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a792e77-0072-4ded-9f89-e7fcc7f7a1d6@www.fastmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 28, 2022 at 12:30:41PM -0800, Andy Lutomirski wrote:
> 
> 
> On Mon, Feb 28, 2022, at 12:27 PM, Mike Rapoport wrote:
> > On Wed, Feb 09, 2022 at 06:37:53PM -0800, Andy Lutomirski wrote:
> >> On 2/8/22 18:18, Edgecombe, Rick P wrote:
> >> > On Tue, 2022-02-08 at 20:02 +0300, Cyrill Gorcunov wrote:
> >> > 
> >
> > Even with the current shadow stack interface Rick proposed, CRIU can restore
> > the victim using ptrace without any additional knobs, but we loose an
> > important ability to "self-cure" the victim from the parasite in case
> > anything goes wrong with criu control process.
> >
> > Moreover, the issue with backward compatibility is not with ptrace but with
> > sigreturn and it seems that criu is not its only user.
> 
> So we need an ability for a tracer to cause the tracee to call a function
> and to return successfully.  Apparently a gdb branch can already do this
> with shstk, and my PTRACE_CALL_FUNCTION_SIGFRAME should also do the
> trick.  I don't see why we need a sigretur-but-dont-verify -- we just
> need this mechanism to create a frame such that sigreturn actually works.

If I understand correctly, PTRACE_CALL_FUNCTION_SIGFRAME() injects a frame
into the tracee and makes the tracee call sigreturn.
I.e. the tracee is stopped and this is used pretty much as PTRACE_CONT or
PTRACE_SYSCALL.

In such case this defeats the purpose of sigreturn in CRIU because it is
called asynchronously by the tracee when the tracer is about to detach or
even already detached.

For synchronous use-case PTRACE_SETREGSET will be enough, the rest of the
sigframe can be restored by other means.

And with 'criu restore' there may be even no tracer by the time sigreturn
is called.

> --Andy

-- 
Sincerely yours,
Mike.
