Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37C04CC99A
	for <lists+linux-arch@lfdr.de>; Fri,  4 Mar 2022 00:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbiCCXBn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Mar 2022 18:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiCCXBm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Mar 2022 18:01:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C8F11B8
        for <linux-arch@vger.kernel.org>; Thu,  3 Mar 2022 15:00:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CECF8B82706
        for <linux-arch@vger.kernel.org>; Thu,  3 Mar 2022 23:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79002C36AF9
        for <linux-arch@vger.kernel.org>; Thu,  3 Mar 2022 23:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646348453;
        bh=FYI/8Y1WBT4HzXcUE12f554+O6V/H3p/NTj/MzLSdWk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sJ22pLyfo4SwdnyPR1TPpzG4XTwr7HOvlPSTg9CLhbH9fJf1Y4yiZbJk5l9LxqoGr
         jceF9VVuMY54RS8QavmAHxO4msQMLJaJp/5xbNt6bN3BBGFuLEfXPzGZvOu8DvbHeE
         QftAuFTbzjALHOjXPomGJNG3sntvLR7yPAQGR9nc6s06SiVJP3/AC529jyzPvUuP65
         JUVsSBlOnoKZT9RGuwx7DvZVLmuJYDus1vjnsYR6bMVZzGXPAHTrIQEOwByLKmF1nc
         mU1uKosE1UJI6QzHX+kmNMzyGmrIM/rv1W+cWWjjL7mD1ekyGEliMgd0ISd/vOLbk+
         LUW0C1sQjwBbw==
Received: by mail-lj1-f169.google.com with SMTP id v22so8753126ljh.7
        for <linux-arch@vger.kernel.org>; Thu, 03 Mar 2022 15:00:53 -0800 (PST)
X-Gm-Message-State: AOAM5303Kip7igRKnggglb96DYgdXfdNqkXLPbENO4AvHMh0M/XzeIx1
        EipWbEK+OX2bDbiKJzUgRGxqKNsP7ecV/LgODpGbDg==
X-Google-Smtp-Source: ABdhPJz3cl4jMqcvfSKVHunCPtaNdRheKNjy3rSm1wymcJSedk+TallQEQF6erOXFO+yao9Hp2Eo8ER04EB83dGMZ7o=
X-Received: by 2002:a05:6402:2c6:b0:415:b06c:de71 with SMTP id
 b6-20020a05640202c600b00415b06cde71mr11466619edx.50.1646348441080; Thu, 03
 Mar 2022 15:00:41 -0800 (PST)
MIME-Version: 1.0
References: <YgI1A0CtfmT7GMIp@kernel.org> <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com> <YgKiKEcsNt7mpMHN@grain>
 <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
 <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org> <Yh0wIMjFdDl8vaNM@kernel.org>
 <5a792e77-0072-4ded-9f89-e7fcc7f7a1d6@www.fastmail.com> <Yh0+9cFyAfnsXqxI@kernel.org>
 <05df964f-552e-402e-981c-a8bea11c555c@www.fastmail.com> <YiEZyTT/UBFZd6Am@kernel.org>
In-Reply-To: <YiEZyTT/UBFZd6Am@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 3 Mar 2022 15:00:29 -0800
X-Gmail-Original-Message-ID: <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
Message-ID: <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Dave Martin <dave.martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 3, 2022 at 11:43 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Feb 28, 2022 at 02:55:30PM -0800, Andy Lutomirski wrote:
> >
> >
> > On Mon, Feb 28, 2022, at 1:30 PM, Mike Rapoport wrote:
> > > On Mon, Feb 28, 2022 at 12:30:41PM -0800, Andy Lutomirski wrote:
> > >>
> > >>
> > >> On Mon, Feb 28, 2022, at 12:27 PM, Mike Rapoport wrote:
> > >> > On Wed, Feb 09, 2022 at 06:37:53PM -0800, Andy Lutomirski wrote:
> > >> >> On 2/8/22 18:18, Edgecombe, Rick P wrote:
> > >> >> > On Tue, 2022-02-08 at 20:02 +0300, Cyrill Gorcunov wrote:
> > >> >> >
> > >> >
> > >> > Even with the current shadow stack interface Rick proposed, CRIU can restore
> > >> > the victim using ptrace without any additional knobs, but we loose an
> > >> > important ability to "self-cure" the victim from the parasite in case
> > >> > anything goes wrong with criu control process.
> > >> >
> > >> > Moreover, the issue with backward compatibility is not with ptrace but with
> > >> > sigreturn and it seems that criu is not its only user.
> > >>
> > >> So we need an ability for a tracer to cause the tracee to call a function
> > >> and to return successfully.  Apparently a gdb branch can already do this
> > >> with shstk, and my PTRACE_CALL_FUNCTION_SIGFRAME should also do the
> > >> trick.  I don't see why we need a sigretur-but-dont-verify -- we just
> > >> need this mechanism to create a frame such that sigreturn actually works.
> > >
> > > If I understand correctly, PTRACE_CALL_FUNCTION_SIGFRAME() injects a frame
> > > into the tracee and makes the tracee call sigreturn.
> > > I.e. the tracee is stopped and this is used pretty much as PTRACE_CONT or
> > > PTRACE_SYSCALL.
> > >
> > > In such case this defeats the purpose of sigreturn in CRIU because it is
> > > called asynchronously by the tracee when the tracer is about to detach or
> > > even already detached.
> >
> > The intent of PTRACE_CALL_FUNCTION_SIGFRAME is push a signal frame onto
> > the stack and call a function.  That function should then be able to call
> > sigreturn just like any normal signal handler.
>
> Ok, let me reiterate.
>
> We have a seized and stopped tracee, use PTRACE_CALL_FUNCTION_SIGFRAME
> to push a signal frame onto the tracee's stack so that sigreturn could use
> that frame, then set the tracee %rip to the function we'd like to call and
> then we PTRACE_CONT the tracee. Tracee continues to execute the parasite
> code that calls sigreturn to clean up and restore the tracee process.
>
> PTRACE_CALL_FUNCTION_SIGFRAME also pushes a restore token to the shadow
> stack, just like setup_rt_frame() does, so that sys_rt_sigreturn() won't
> bail out at restore_signal_shadow_stack().

That is the intent.

>
> The only thing that CRIU actually needs is to push a restore token to the
> shadow stack, so for us a ptrace call that does that would be ideal.
>

That seems fine too.  The main benefit of the SIGFRAME approach is
that, AIUI, CRIU eventually constructs a signal frame anyway, and
getting one ready-made seems plausibly helpful.  But if it's not
actually that useful, then there's no need to do it.
