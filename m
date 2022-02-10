Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AB64B037C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 03:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiBJCh5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 21:37:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiBJChz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 21:37:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9C620F42;
        Wed,  9 Feb 2022 18:37:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0E1761A04;
        Thu, 10 Feb 2022 02:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF411C340E7;
        Thu, 10 Feb 2022 02:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644460676;
        bh=Hz8lGy4gshpW8UEDEsTd4W5QPRJ4DB6xlgp8dtJmJVs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qBoGpg3x7UdPi5W24ulRcPFLrg5AX4Vwf8vlXAVP8tXZooNbKLpjRx+HwugslUA1U
         A1uiJqFP0r/cM7S3kT2Naj4yn+Bm+ufOmPXbGHyqhEJR8TowGrp1eJiIm/NyoDy5Cj
         rBQIbHJPI8il1HrAUl7GVs7Hyvin8cPoUzuWvTmEFxhOFH/CQ3Dko7Itpwm5EzF2F2
         EP2bGeCDzGMzDfPtAB21ITDZjhX5K+X6bAZCQ93e36CJn5oH7TtT8B68mkGE2zLqdE
         3BChVLbpuin+iwBD5fdIeeZ0qdXKM6tjCHde41DmMo5Lg+fUwqRteJfktFGf3GTS/d
         ilUECoKuBJnIQ==
Message-ID: <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org>
Date:   Wed, 9 Feb 2022 18:37:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "adrian@lisas.de" <adrian@lisas.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org> <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org> <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
 <YgKiKEcsNt7mpMHN@grain>
 <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/8/22 18:18, Edgecombe, Rick P wrote:
> On Tue, 2022-02-08 at 20:02 +0300, Cyrill Gorcunov wrote:
>> On Tue, Feb 08, 2022 at 08:21:20AM -0800, Andy Lutomirski wrote:
>>>>> But such a knob will immediately reduce the security value of
>>>>> the entire
>>>>> thing, and I don't have good ideas how to deal with it :(
>>>>
>>>> Probably a kind of latch in the task_struct which would trigger
>>>> off once
>>>> returt to a different address happened, thus we would be able to
>>>> jump inside
>>>> paratite code. Of course such trigger should be available under
>>>> proper
>>>> capability only.
>>>
>>> I'm not fully in touch with how parasite, etc works.  Are we
>>> talking about save or restore?
>>
>> We use parasite code in question during checkpoint phase as far as I
>> remember.
>> push addr/lret trick is used to run "injected" code (code injection
>> itself is
>> done via ptrace) in compat mode at least. Dima, Andrei, I didn't look
>> into this code
>> for years already, do we still need to support compat mode at all?
>>
>>> If it's restore, what exactly does CRIU need to do?  Is it just
>>> that CRIU needs to return
>>> out from its resume code into the to-be-resumed program without
>>> tripping CET?  Would it
>>> be acceptable for CRIU to require that at least one shstk slot be
>>> free at save time?
>>> Or do we need a mechanism to atomically switch to a completely full
>>> shadow stack at resume?
>>>
>>> Off the top of my head, a sigreturn (or sigreturn-like mechanism)
>>> that is intended for
>>> use for altshadowstack could safely verify a token on the
>>> altshdowstack, possibly
>>> compare to something in ucontext (or not -- this isn't clearly
>>> necessary) and switch
>>> back to the previous stack.  CRIU could use that too.  Obviously
>>> CRIU will need a way
>>> to populate the relevant stacks, but WRUSS can be used for that,
>>> and I think this
>>> is a fundamental requirement for CRIU -- CRIU restore absolutely
>>> needs a way to write
>>> the saved shadow stack data into the shadow stack.
> 
> Still wrapping my head around the CRIU save and restore steps, but
> another general approach might be to give ptrace the ability to
> temporarily pause/resume/set CET enablement and SSP for a stopped
> thread. Then injected code doesn't need to jump through any hoops or
> possibly run into road blocks. I'm not sure how much this opens things
> up if the thread has to be stopped...

Hmm, that's maybe not insane.

An alternative would be to add a bona fide ptrace call-a-function 
mechanism.  I can think of two potentially usable variants:

1. Straight call.  PTRACE_CALL_FUNCTION(addr) just emulates CALL addr, 
shadow stack push and all.

2. Signal-style.  PTRACE_CALL_FUNCTION_SIGFRAME injects an actual signal 
frame just like a real signal is being delivered with the specified 
handler.  There could be a variant to opt-in to also using a specified 
altstack and altshadowstack.

2 would be more expensive but would avoid the need for much in the way 
of asm magic.  The injected code could be plain C (or Rust or Zig or 
whatever).

All of this only really handles save, not restore.  I don't understand 
restore enough to fully understand the issue.

--Andy
