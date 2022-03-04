Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160744CDD2F
	for <lists+linux-arch@lfdr.de>; Fri,  4 Mar 2022 20:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiCDTOP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Mar 2022 14:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCDTOO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2022 14:14:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8441C1E503D;
        Fri,  4 Mar 2022 11:13:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C72461967;
        Fri,  4 Mar 2022 19:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF926C340E9;
        Fri,  4 Mar 2022 19:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646421203;
        bh=qL6iqVP9OuyTm0GEY6s+DvIkOVU6QwersrNGlp/pNAQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qXFhsWwdJChSBrDiMNOy0W8bhNXVxM23uT12zfeia9Z23pQeNq4I5Uyrn1kQyQlIW
         kVtJ0+0yktLFpXWeTdWJz/Ef7ePZgmYXnhrh8pxGYaUTUYvD7JfZLCFWySSAtZxBb9
         HptwyzSm1L3GGbPU5l0sYvjP7ENIid06nY9cz3lAmiUAYX0wcl++MiSOwpwhVRxRYS
         PKnSglCpB63Tld61KR1bHnvp+avLCEt8V3GMXDhSOpH/fN9LXooTP2A5dYnpO9eNc0
         Z2xTgl8l0O4ojStWwDFwQ0mhdYxGSLlRl1qdptva51LvsQXc98hh4BXaeO/AwCke01
         MGyu/FC5Db62Q==
Message-ID: <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org>
Date:   Fri, 4 Mar 2022 11:13:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
References: <YgI1A0CtfmT7GMIp@kernel.org> <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
 <YgKiKEcsNt7mpMHN@grain>
 <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
 <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org>
 <Yh0wIMjFdDl8vaNM@kernel.org>
 <5a792e77-0072-4ded-9f89-e7fcc7f7a1d6@www.fastmail.com>
 <Yh0+9cFyAfnsXqxI@kernel.org>
 <05df964f-552e-402e-981c-a8bea11c555c@www.fastmail.com>
 <YiEZyTT/UBFZd6Am@kernel.org>
 <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
 <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/3/22 17:30, Edgecombe, Rick P wrote:
> On Thu, 2022-03-03 at 15:00 -0800, Andy Lutomirski wrote:
>>>> The intent of PTRACE_CALL_FUNCTION_SIGFRAME is push a signal
>>>> frame onto
>>>> the stack and call a function.  That function should then be able
>>>> to call
>>>> sigreturn just like any normal signal handler.
>>>
>>> Ok, let me reiterate.
>>>
>>> We have a seized and stopped tracee, use
>>> PTRACE_CALL_FUNCTION_SIGFRAME
>>> to push a signal frame onto the tracee's stack so that sigreturn
>>> could use
>>> that frame, then set the tracee %rip to the function we'd like to
>>> call and
>>> then we PTRACE_CONT the tracee. Tracee continues to execute the
>>> parasite
>>> code that calls sigreturn to clean up and restore the tracee
>>> process.
>>>
>>> PTRACE_CALL_FUNCTION_SIGFRAME also pushes a restore token to the
>>> shadow
>>> stack, just like setup_rt_frame() does, so that sys_rt_sigreturn()
>>> won't
>>> bail out at restore_signal_shadow_stack().
>>
>> That is the intent.
>>
>>>
>>> The only thing that CRIU actually needs is to push a restore token
>>> to the
>>> shadow stack, so for us a ptrace call that does that would be
>>> ideal.
>>>
>>
>> That seems fine too.  The main benefit of the SIGFRAME approach is
>> that, AIUI, CRIU eventually constructs a signal frame anyway, and
>> getting one ready-made seems plausibly helpful.  But if it's not
>> actually that useful, then there's no need to do it.
> 
> I guess pushing a token to the shadow stack could be done like GDB does
> calls, with just the basic CET ptrace support. So do we even need a
> specific push token operation?
> 
> I suppose if CRIU already used some kernel encapsulation of a seized
> call/return operation it would have been easier to make CRIU work with
> the introduction of CET. But the design of CRIU seems to be to have the
> kernel expose just enough and then tie it all together in userspace.
> 
> Andy, did you have any other usages for PTRACE_CALL_FUNCTION in mind? I
> couldn't find any other CRIU-like users of sigreturn in the debian
> source search (but didn't read all 819 pages that come up with
> "sigreturn"). It seemed to be mostly seccomp sandbox references.

I don't see a benefit compelling enough to justify the added complexity, 
given that existing mechanisms can do it.

The sigframe thing, OTOH, seems genuinely useful if CRIU would actually 
use it to save the full register state.  Generating a signal frame from 
scratch is a pain.  That being said, if CRIU isn't excited, then don't 
bother.
