Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5314D070C
	for <lists+linux-arch@lfdr.de>; Mon,  7 Mar 2022 19:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241792AbiCGS6E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Mar 2022 13:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243341AbiCGS6D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2022 13:58:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9F92D30;
        Mon,  7 Mar 2022 10:57:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCB1861387;
        Mon,  7 Mar 2022 18:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9316CC340E9;
        Mon,  7 Mar 2022 18:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646679427;
        bh=kzPVR0Ts7EvL4cw43owr5qE2dp0dCtf1msIC/h6ja3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWt3NTUbKn9a8SzZ7LbBwKtKZCBQX3n8AciKZPGl1KpM2+i7OpUqh8VWt11+/jsNp
         KjxrMVQFwaVZyyh0sO2G8Klttr+Je2FWqjrNV3OrvR1V5893sxrksMVjYjNn2kWEox
         oITR2QtoXvgaoFUOtKuliF7ce1I4JjDomW4yS5EzHMhBbJdJTG8osUKLmzQbPzk5Ih
         33mRGl8VIswmhVlNEivsIZEjlV1PMnRmuQrBCDPuyg33dWVBmOBF5pE+WPKkcMW4Mn
         JKkGQVk3mWdVACaEHCjPK9n8iC9rXLc6J49S2tDo6cfdt9MeWkvkdTQkTpv6caMSoQ
         kMvttHPSMcGEA==
Date:   Mon, 7 Mar 2022 20:56:44 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "adrian@lisas.de" <adrian@lisas.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Message-ID: <YiZVbPwlgSFnhadv@kernel.org>
References: <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
 <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org>
 <Yh0wIMjFdDl8vaNM@kernel.org>
 <5a792e77-0072-4ded-9f89-e7fcc7f7a1d6@www.fastmail.com>
 <Yh0+9cFyAfnsXqxI@kernel.org>
 <05df964f-552e-402e-981c-a8bea11c555c@www.fastmail.com>
 <YiEZyTT/UBFZd6Am@kernel.org>
 <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
 <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
 <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 04, 2022 at 11:13:19AM -0800, Andy Lutomirski wrote:
> On 3/3/22 17:30, Edgecombe, Rick P wrote:
> > On Thu, 2022-03-03 at 15:00 -0800, Andy Lutomirski wrote:
> > > > > The intent of PTRACE_CALL_FUNCTION_SIGFRAME is push a signal
> > > > > frame onto
> > > > > the stack and call a function.  That function should then be able
> > > > > to call
> > > > > sigreturn just like any normal signal handler.
> > > > 
> > > > Ok, let me reiterate.
> > > > 
> > > > We have a seized and stopped tracee, use
> > > > PTRACE_CALL_FUNCTION_SIGFRAME
> > > > to push a signal frame onto the tracee's stack so that sigreturn
> > > > could use
> > > > that frame, then set the tracee %rip to the function we'd like to
> > > > call and
> > > > then we PTRACE_CONT the tracee. Tracee continues to execute the
> > > > parasite
> > > > code that calls sigreturn to clean up and restore the tracee
> > > > process.
> > > > 
> > > > PTRACE_CALL_FUNCTION_SIGFRAME also pushes a restore token to the
> > > > shadow
> > > > stack, just like setup_rt_frame() does, so that sys_rt_sigreturn()
> > > > won't
> > > > bail out at restore_signal_shadow_stack().
> > > 
> > > That is the intent.
> > > 
> > > > 
> > > > The only thing that CRIU actually needs is to push a restore token
> > > > to the
> > > > shadow stack, so for us a ptrace call that does that would be
> > > > ideal.
> > > > 
> > > 
> > > That seems fine too.  The main benefit of the SIGFRAME approach is
> > > that, AIUI, CRIU eventually constructs a signal frame anyway, and
> > > getting one ready-made seems plausibly helpful.  But if it's not
> > > actually that useful, then there's no need to do it.
> > 
> > I guess pushing a token to the shadow stack could be done like GDB does
> > calls, with just the basic CET ptrace support. So do we even need a
> > specific push token operation?

I've tried to follow gdb CET push implementation, but got lost.
What is "basic CET ptrace support"? I don't see any ptrace changes in this
series.
 
> > I suppose if CRIU already used some kernel encapsulation of a seized
> > call/return operation it would have been easier to make CRIU work with
> > the introduction of CET. But the design of CRIU seems to be to have the
> > kernel expose just enough and then tie it all together in userspace.
> > 
> > Andy, did you have any other usages for PTRACE_CALL_FUNCTION in mind? I
> > couldn't find any other CRIU-like users of sigreturn in the debian
> > source search (but didn't read all 819 pages that come up with
> > "sigreturn"). It seemed to be mostly seccomp sandbox references.
> 
> I don't see a benefit compelling enough to justify the added complexity,
> given that existing mechanisms can do it.
> 
> The sigframe thing, OTOH, seems genuinely useful if CRIU would actually use
> it to save the full register state.  Generating a signal frame from scratch
> is a pain.  That being said, if CRIU isn't excited, then don't bother.

CRIU is excited :)

I just was looking for the minimal possible interface that will allow us to
call sigreturn. Rick is right and CRIU does try to expose as little as
possible and handle the pain in the userspace.

The SIGFRAME approach is indeed very helpful, especially if we can make it
work on other architectures eventually. 

-- 
Sincerely yours,
Mike.
