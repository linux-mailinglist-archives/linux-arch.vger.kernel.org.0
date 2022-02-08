Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176534ACE1D
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 02:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbiBHBsC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 20:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiBHBbu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 20:31:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88041C061355;
        Mon,  7 Feb 2022 17:31:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01D4661253;
        Tue,  8 Feb 2022 01:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBC3C004E1;
        Tue,  8 Feb 2022 01:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644283908;
        bh=FVFHKY6Lf5v9k+9f7XtvYdS9xaoSxDGnNdiLfTk98cU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ACca6sfW0QhhOG37xqghFUEPFAHu4/cLZldK6AHO0fxPfRvY3L4hh+OEOPczU4+qh
         tcWFYCnMamYIhnLcfqrVMmk1kNOg/FfCASuXegdI8zfobB8vFXd4z9xhtiNfVVIt0U
         1PVZBcrQkhAIXkJ2bGHilOJ9ZYhfsCDevYyYwYcz8Zx/Ze497rwvb0xgAsPWok5ZQU
         0FYOGpRGw0tB5CEScLBU+nN+3FcE+gQuRbB3qXgnrcDhYNi2nKQdq8h+8oH68CXwuG
         rezvbXBxOGpu+UU2lXOLKqYBownzcqmsEnhJObimWYidnnd5BJd2fk35E45dwoNQib
         mmLcy1YKo5msA==
Message-ID: <6ba06196-0756-37a4-d6c4-2e47e6601dcd@kernel.org>
Date:   Mon, 7 Feb 2022 17:31:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        Adrian Reber <adrian@lisas.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
References: <87fsozek0j.ffs@tglx>
 <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
 <3421da7fc8474b6db0e265b20ffd28d0@AcuMS.aculab.com>
 <CAMe9rOonepEiRyoAyTGkDMQQhuyuoP4iTZJJhKGxgnq9vv=dLQ@mail.gmail.com>
 <9f948745435c4c9273131146d50fe6f328b91a78.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <9f948745435c4c9273131146d50fe6f328b91a78.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/5/22 12:15, Edgecombe, Rick P wrote:
> On Sat, 2022-02-05 at 05:29 -0800, H.J. Lu wrote:
>> On Sat, Feb 5, 2022 at 5:27 AM David Laight <David.Laight@aculab.com>
>> wrote:
>>>
>>> From: Edgecombe, Rick P
>>>> Sent: 04 February 2022 01:08
>>>> Hi Thomas,
>>>>
>>>> Thanks for feedback on the plan.
>>>>
>>>> On Thu, 2022-02-03 at 22:07 +0100, Thomas Gleixner wrote:
>>>>>> Until now, the enabling effort was trying to support both
>>>>>> Shadow
>>>>>> Stack and IBT.
>>>>>> This history will focus on a few areas of the shadow stack
>>>>>> development history
>>>>>> that I thought stood out.
>>>>>>
>>>>>>         Signals
>>>>>>         -------
>>>>>>         Originally signals placed the location of the shadow
>>>>>> stack
>>>>>> restore
>>>>>>         token inside the saved state on the stack. This was
>>>>>> problematic from a
>>>>>>         past ABI promises perspective. So the restore location
>>>>>> was
>>>>>> instead just
>>>>>>         assumed from the shadow stack pointer. This works
>>>>>> because in
>>>>>> normal
>>>>>>         allowed cases of calling sigreturn, the shadow stack
>>>>>> pointer
>>>>>> should be
>>>>>>         right at the restore token at that time. There is no
>>>>>> alternate shadow
>>>>>>         stack support. If an alt shadow stack is added later
>>>>>> we
>>>>>> would
>>>>>>         need to
>>>>>
>>>>> So how is that going to work? altstack is not an esoteric
>>>>> corner
>>>>> case.
>>>>
>>>> My understanding is that the main usages for the signal stack
>>>> were
>>>> handling stack overflows and corruption. Since the shadow stack
>>>> only
>>>> contains return addresses rather than large stack allocations,
>>>> and is
>>>> not generally writable or pivotable, I thought there was a good
>>>> possibility an alt shadow stack would not end up being especially
>>>> useful. Does it seem like reasonable guesswork?
>>>
>>> The other 'problem' is that it is valid to longjump out of a signal
>>> handler.
>>> These days you have to use siglongjmp() not longjmp() but it is
>>> still used.
>>>
>>> It is probably also valid to use siglongjmp() to jump from a nested
>>> signal handler into the outer handler.
>>> Given both signal handlers can have their own stack, there can be
>>> three
>>> stacks involved.
> 
> So the scenario is?
> 
> 1. Handle signal 1
> 2. sigsetjmp()
> 3. signalstack()
> 4. Handle signal 2 on alt stack
> 5. siglongjmp()
> 
> I'll check that it is covered by the tests, but I think it should work
> in this series that has no alt shadow stack. I have only done a high
> level overview of how the shadow stack stuff, that doesn't involve the
> kernel, works in glibc. Sounds like I'll need to do a deeper dive.
> 
>>>
>>> I think the shadow stack pointer has to be in ucontext - which also
>>> means the application can change it before returning from a signal.
> 
> Yes we might need to change it to support alt shadow stacks. Can you
> elaborate why you think it has to be in ucontext? I was thinking of
> looking at three options for storing the ssp:
>   - Stored in the shadow stack like a token using WRUSS from the kernel.
>   - Stored on the kernel side using a hashmap that maps ucontext or
>     sigframe userspace address to ssp (this is of course similar to
>     storing in ucontext, except that the user can’t change the ssp).
>   - Stored writable in userspace in ucontext.
> 
> But in this version, without alt shadow stacks, the shadow stack
> pointer is not stored in ucontext. This causes the limitation that
> userspace can only call sigreturn when it has returned back to a point
> where there is a restore token on the shadow stack (which was placed
> there by the kernel).



I'll reply here and maybe cover multiple things.


User code already needs to rewind the regular stack to call sigreturn -- 
sigreturn find the signal frame based on ESP/RSP.  So if you call it 
from the wrong place, you go boom.  I think that the Linux SHSTK ABI 
should have the property that no amount of tampering with just the 
ucontext and associated structures can cause sigreturn to redirect to 
the wrong IP -- there should be something on the shadow stack that also 
gets verified in sigreturn.  IIRC the series does this, but it's been a 
while.  The post-sigreturn SSP should be entirely implied by 
pre-sigreturn SSP (or perhaps something on the shadow stack), so, in the 
absence of an altshadowstack feature, no ucontext changes should be needed.

We can also return from a signal or from more than one signal at once, 
as above, using siglongjmp.  It seems like this should Just Work (tm), 
at least in the absence of altshadowstack.

So this leaves altshadowstack.  If we want to allow userspace to handle 
a shstk overflow, I think we need altshadowstack.  And I can easily 
imagine signal handling in a coroutine or user-threading evironment (Go? 
UMCG or whatever it's called?) wanting this.  As noted, this obnoxious 
Andy person didn't like putting any shstk-related extensions in the FPU 
state.

For better or for worse, altshadowstack is (I think) fundamentally a new 
API.  No amount of ucontext magic is going to materialize an entire 
shadow stack out of nowhere when someone calls sigaltstack().  So the 
questions are: should we support altshadowstack from day one and, if so, 
what should it look like?

If we want to be clever, we could attempt to make altstadowstack 
compatible with RSTORSSP.  Signal delivery pushes a restore token to the 
old stack (hah!  what if the old stack is full?) and pushes the RSTORSSP 
busy magic to the new stack, and sigreturn inverts it.  Code that wants 
to return without sigreturn does it manually with RSTORSSP.  (Assuming 
that I've understood the arcane RSTORSSP sequence right.  Intel wins 
major points for documentation quality here.)  Or we could invent our 
own scheme.  In either case, I don't immediately see any reason that the 
ucontext needs to contain a shadow stack pointer.

There's a delightful wart to consider, though.  siglongjmp, at least as 
currently envisioned, can't return off an altshadowstack: the whole 
point of the INCSSP distance restrictions to to avoid incrementing right 
off the top of the current stack, but siglongjmp off an altshadowstack 
fundamentally switches stacks.  So either siglongjmp off an 
altshadowstack needs to be illegal or it needs to work differently.  (By 
incssp-ing to the top of the altshadowstack, then switching, then 
incssp-ing some more?  How does it even find the top of the current 
altshadowstack?)  And the plot thickens if one tries to siglongjmp off 
two nested altshadowstack-using signals in a single call.   Fortunately, 
since altshadowstack is a new API, it's not entirely crazy to have 
different rules.

So I don't have a complete or even almost complete design in mind, but I 
think we do need to make a conscious decision either to design this 
right or to skip it for v1.

As for CRIU, I don't think anyone really expects a new kernel, running 
new userspace that takes advantage of features in the new kernel, to 
work with old CRIU.  Upgrading to a SHSTK kernel should still allow 
using CRIU with non-SHSTK userspace, but I don't see how it's possible 
for CRIU to handle SHSTK without updates.  We should certainly do our 
best to make CRIU's life easy, though.

  This doesn’t mean it can’t switch to a different
> shadow stack or handle a nested signal, but it limits the possibility
> for calling sigreturn with a totally different sigframe (like CRIU and
> SROP attacks do). It should hopefully be a helpful, protective
> limitation for most apps and I'm hoping CRIU can be fixed without
> removing it.
> 
> I am not aware of other limitations to signals (besides normal shadow
> stack enforcement), but I could be missing it. And people's skepticism
> is making me want to go back over it with more scrutiny.
> 
>>> In much the same way as all the segment registers can be changed
>>> leading to all the nasty bugs when the final 'return to user' code
>>> traps in kernel when loading invalid segment registers or executing
>>> iret.
> 
> I don't think this is as difficult to avoid because userspace ssp has
> its own register that should not be accessed at that point, but I have
> not given this aspect enough analysis. Thanks for bringing it up.
> 
>>>
>>> Hmmm... do shadow stacks mean that longjmp() has to be a system
>>> call?
>>
>> No.  setjmp/longjmp save and restore shadow stack pointer.
>>
> 
> It sounds like it would help to write up in a lot more detail exactly
> how all the signal and specialer stack manipulation scenarios work in
> glibc.
> 

