Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536094C7A73
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 21:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiB1Ubu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 15:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiB1Ubs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 15:31:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FE9F11
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 12:31:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE82DB81652
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 20:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6BAC340F2;
        Mon, 28 Feb 2022 20:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646080266;
        bh=zsRjDMSjqdrecF0uQGK53RtaJnJbg2cIMw159uLcH/4=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=TNHidC4nRa4lVBOlnn6tRGQQuV2FY1QmuuKHcFSzdPuJYPImuOfiCnSw8tIsTi0/1
         CB4pHgu6TKDwzbi6gYcRH/5n0ucsTM2Q/uA5PeZWRgAoNj/u1QXO2jzstfKEIxLurk
         +a9c6DxmoTOam0L1LZD0nugBeDGH4aa1QbjWuJkGuCezADIqIgWqZLfUx4x4NrAJgF
         HfqZ4YHjJEas1B3CiT+8nLAVp7nYPCE6ci7OATgZTZYINfiiqAz2vApMgDzMLF3hFH
         Udisi3mVHUw3LTkuIXhVbFKA8ydZjm0UuWFADoLofteyggP/W2VsOnYg1c4sLj7P2X
         rsUp4xA06nKfA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9494827C0054;
        Mon, 28 Feb 2022 15:31:03 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Mon, 28 Feb 2022 15:31:03 -0500
X-ME-Sender: <xms:BjEdYlUapsVPI10asxGthD5Bhhb4bc-sn-fi0pHzOX7Snvu8pACgLg>
    <xme:BjEdYlmws6dI9KpCslRZ9xMxJTaJefmy8itaxPm64NFA48YdbddErE6RKmmgmHnHE
    qMjbe5y6iEp40cEI84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddttddgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:BjEdYhZkXo9K-qypaX0ASYBP845titqnUhlPkcUY6PGmL8BPc2X85Q>
    <xmx:BjEdYoXNR3YOj0Mr7Q5gI2DkA-HXfaljCVJExNmksoWI7lsaqaxQjw>
    <xmx:BjEdYvnDF-hJuu6YASafTavymLVX5lfS_KrcRk798jlsdHnbItIVig>
    <xmx:BzEdYtpypV6SEhjvecGiLJGsA3OTdkYM96WJUX2RGKoMVRPB60J4JZAyK1I>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 161F021E006E; Mon, 28 Feb 2022 15:31:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4778-g14fba9972e-fm-20220217.001-g14fba997
Mime-Version: 1.0
Message-Id: <5a792e77-0072-4ded-9f89-e7fcc7f7a1d6@www.fastmail.com>
In-Reply-To: <Yh0wIMjFdDl8vaNM@kernel.org>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org> <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org> <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
 <YgKiKEcsNt7mpMHN@grain>
 <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
 <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org>
 <Yh0wIMjFdDl8vaNM@kernel.org>
Date:   Mon, 28 Feb 2022 12:30:41 -0800
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



On Mon, Feb 28, 2022, at 12:27 PM, Mike Rapoport wrote:
> On Wed, Feb 09, 2022 at 06:37:53PM -0800, Andy Lutomirski wrote:
>> On 2/8/22 18:18, Edgecombe, Rick P wrote:
>> > On Tue, 2022-02-08 at 20:02 +0300, Cyrill Gorcunov wrote:
>> > 
>> > Still wrapping my head around the CRIU save and restore steps, but
>> > another general approach might be to give ptrace the ability to
>> > temporarily pause/resume/set CET enablement and SSP for a stopped
>> > thread. Then injected code doesn't need to jump through any hoops or
>> > possibly run into road blocks. I'm not sure how much this opens things
>> > up if the thread has to be stopped...
>> 
>> Hmm, that's maybe not insane.
>> 
>> An alternative would be to add a bona fide ptrace call-a-function mechanism.
>> I can think of two potentially usable variants:
>> 
>> 1. Straight call.  PTRACE_CALL_FUNCTION(addr) just emulates CALL addr,
>> shadow stack push and all.
>> 
>> 2. Signal-style.  PTRACE_CALL_FUNCTION_SIGFRAME injects an actual signal
>> frame just like a real signal is being delivered with the specified handler.
>> There could be a variant to opt-in to also using a specified altstack and
>> altshadowstack.
>
> Using ptrace() will not solve CRIU's issue with sigreturn because sigreturn
> is called from the victim context rather than from the criu process that
> controls the dump and uses ptrace().

I'm not sure I follow.

>
> Even with the current shadow stack interface Rick proposed, CRIU can restore
> the victim using ptrace without any additional knobs, but we loose an
> important ability to "self-cure" the victim from the parasite in case
> anything goes wrong with criu control process.
>
> Moreover, the issue with backward compatibility is not with ptrace but with
> sigreturn and it seems that criu is not its only user.

So we need an ability for a tracer to cause the tracee to call a function and to return successfully.  Apparently a gdb branch can already do this with shstk, and my PTRACE_CALL_FUNCTION_SIGFRAME should also do the trick.  I don't see why we need a sigretur-but-dont-verify -- we just need this mechanism to create a frame such that sigreturn actually works.

--Andy
