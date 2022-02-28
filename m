Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E26D4C7DDE
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 23:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiB1W4k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 17:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiB1W4j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 17:56:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD38D68A;
        Mon, 28 Feb 2022 14:55:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BD09B816A6;
        Mon, 28 Feb 2022 22:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118EAC340EE;
        Mon, 28 Feb 2022 22:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646088957;
        bh=IrKyR4KsaGy6ILEoSjvY+Pfikinwp5UgDQ/3sdpyfQg=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=JTti+7gOLMySTeqWwRBxm9JF/LxEc36hF/DllbnINKGysrNoAZbJLJCN29tzVQpEC
         OPBNdIDfbz1a4MXrk6S84RC/ZiOGeWwOxLpW2V9hRJc+e7F2oPRIOxlhmAfsR40EkZ
         Q2pS4vFDlD+ecf+evWmIf7r7ooWXN3k3Pfc74WjAyCK5yndZ0W3PF081gZa2AVB1LT
         qIfQUnlwqzaDII5e8dWe49KxurJ1CpD4xSdpKFvkS+qWBTA9snzhIQ6jB54mE10KcI
         jijFO4uIy/i+6CAtuUZ+BqilyatRAWqJ7H624wNXOLvWOzS4C5e8sn1XGZbRzI/A4w
         RX+lyfAqXFcag==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id B3D1A27C0054;
        Mon, 28 Feb 2022 17:55:53 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Mon, 28 Feb 2022 17:55:53 -0500
X-ME-Sender: <xms:-FIdYsLIH8xSXNZkBj6DK83xIzUn_W9DsfVQwWcVMCVCOzeKk1MKzQ>
    <xme:-FIdYsLitA72qcFv2KAsG4rt4hYfQ-yzQUiflwB2j5Gq_sovTK47ksE4Xj0VPodt9
    vn1SyG-Tz7OMJvj2yU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtuddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:-FIdYssw9wS50EE9pmpETO-NcmotanHVlmsg84NE43g3fXEk307dsg>
    <xmx:-FIdYpaUHX3OArm88Um26oVtVLfGpJZ6c4f2XxZPmdtCJEAqDNfk6Q>
    <xmx:-FIdYjbMoiMfJTvRwgFi78iSWM11ZclQ9BUpPVva3-tJJlRFBp_zwg>
    <xmx:-VIdYpuR9Y186Dyd0VlVgshdQ9Q02sP-GkUSmwD_NWUNx-bFblctiTHSWgI>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2E51821E006E; Mon, 28 Feb 2022 17:55:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4778-g14fba9972e-fm-20220217.001-g14fba997
Mime-Version: 1.0
Message-Id: <05df964f-552e-402e-981c-a8bea11c555c@www.fastmail.com>
In-Reply-To: <Yh0+9cFyAfnsXqxI@kernel.org>
References: <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org> <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
 <YgKiKEcsNt7mpMHN@grain>
 <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
 <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org>
 <Yh0wIMjFdDl8vaNM@kernel.org>
 <5a792e77-0072-4ded-9f89-e7fcc7f7a1d6@www.fastmail.com>
 <Yh0+9cFyAfnsXqxI@kernel.org>
Date:   Mon, 28 Feb 2022 14:55:30 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Mike Rapoport" <rppt@kernel.org>
Cc:     "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        "Cyrill Gorcunov" <gorcunov@gmail.com>,
        "Balbir Singh" <bsingharora@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Dmitry Safonov" <0x7f454c46@gmail.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Adrian Reber" <adrian@lisas.de>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Jann Horn" <jannh@google.com>, "Andrei Vagin" <avagin@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Oleg Nesterov" <oleg@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Pavel Machek" <pavel@ucw.cz>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        "Dave Martin" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Content-Type: text/plain
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Mon, Feb 28, 2022, at 1:30 PM, Mike Rapoport wrote:
> On Mon, Feb 28, 2022 at 12:30:41PM -0800, Andy Lutomirski wrote:
>> 
>> 
>> On Mon, Feb 28, 2022, at 12:27 PM, Mike Rapoport wrote:
>> > On Wed, Feb 09, 2022 at 06:37:53PM -0800, Andy Lutomirski wrote:
>> >> On 2/8/22 18:18, Edgecombe, Rick P wrote:
>> >> > On Tue, 2022-02-08 at 20:02 +0300, Cyrill Gorcunov wrote:
>> >> > 
>> >
>> > Even with the current shadow stack interface Rick proposed, CRIU can restore
>> > the victim using ptrace without any additional knobs, but we loose an
>> > important ability to "self-cure" the victim from the parasite in case
>> > anything goes wrong with criu control process.
>> >
>> > Moreover, the issue with backward compatibility is not with ptrace but with
>> > sigreturn and it seems that criu is not its only user.
>> 
>> So we need an ability for a tracer to cause the tracee to call a function
>> and to return successfully.  Apparently a gdb branch can already do this
>> with shstk, and my PTRACE_CALL_FUNCTION_SIGFRAME should also do the
>> trick.  I don't see why we need a sigretur-but-dont-verify -- we just
>> need this mechanism to create a frame such that sigreturn actually works.
>
> If I understand correctly, PTRACE_CALL_FUNCTION_SIGFRAME() injects a frame
> into the tracee and makes the tracee call sigreturn.
> I.e. the tracee is stopped and this is used pretty much as PTRACE_CONT or
> PTRACE_SYSCALL.
>
> In such case this defeats the purpose of sigreturn in CRIU because it is
> called asynchronously by the tracee when the tracer is about to detach or
> even already detached.

The intent of PTRACE_CALL_FUNCTION_SIGFRAME is push a signal frame onto the stack and call a function.  That function should then be able to call sigreturn just like any normal signal handler.  There should be no requirement that the tracer still be attached when this happens, although the code calling sigreturn still needs to be mapped.

(Specifically, on modern arches, the user runtime is expected to provide a "restorer" that calls sigreturn.  A hypotheticall PTRACE_CALL_FUNCTION_SIGFRAME would either need to call sigreturn directly or provide a restorer.)
