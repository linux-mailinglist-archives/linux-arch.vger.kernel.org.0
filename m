Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AB54ADE32
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 17:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242890AbiBHQVr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 11:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiBHQVq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 11:21:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E994C061576
        for <linux-arch@vger.kernel.org>; Tue,  8 Feb 2022 08:21:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF171616CD
        for <linux-arch@vger.kernel.org>; Tue,  8 Feb 2022 16:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F00C340EC;
        Tue,  8 Feb 2022 16:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337305;
        bh=cUXMYwV3FsUsTmiMnq+uhwE47soE1KcN2fh5D+proTA=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=SYdXu170xBHHUjtWDtgioa8Qvsdmh617pUIz2hpTg+v6xiUUBB9OVj4a8ioygzGSP
         5md+IpahrD5rW14xK8o5ixxtIgMCX9w5yp3ahVR5Xkp0ecGeXEWikrYFsV3WYAdPFa
         fWZpnU0b6YOjzCvjmMfapyOY1UFOnmLynludGChjdJwdDn/ueLf7pVoF0f3VJA+hb3
         B04vO1/hRv36Sc0EGyp5VQyCrQXaMEbYHOk6eMIm0ewlX27cUByN14msoA5tJqGFcN
         B3CWrkbNnSd4NCxzzPk6sd/ksgmuWlhv+BkH8LYcbuBfNY1FL9hJlYse+7Rpcsfbjh
         GvHiWrTP8wwMA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 73F7B27C005A;
        Tue,  8 Feb 2022 11:21:42 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Tue, 08 Feb 2022 11:21:42 -0500
X-ME-Sender: <xms:lJgCYuxKfDWChEaal5BYkheUS1FMr5Zalegy-cHkFrKbX9myLqpgvg>
    <xme:lJgCYqQKwnJmO8SJ6Tg6BxGcGM0X_j92vMPhWjkCJvXd3vJ1c1jf8zqrtzIatfbl0
    wSwrozruZNxZ2_yjoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheejgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleffgfef
    vdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudekheei
    fedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrd
    hluhhtohdruhhs
X-ME-Proxy: <xmx:lJgCYgU4vjA3ZAA_WNzaYnPPRn3GmXWb2rbCJKp5lA5YpH3NxN07HQ>
    <xmx:lJgCYkjE0eZ1DeQ4F8MK696KnkhBc29Txd5euZvkV-rECWFeXYkQBw>
    <xmx:lJgCYgAHTVwqjBqtEu2RiC6G1dsIUiS06sRPbyV9V7iOWKDZqB1L2w>
    <xmx:lpgCYq1Dw6pfcBEJcespJI4yxf_B2SmD0TIFNqBZNzC-qjIxaolZWzGYIFo>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D580121E0073; Tue,  8 Feb 2022 11:21:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4748-g31a5b5f50e-fm-cal2020-20220204.001-g31a5b5f5
Mime-Version: 1.0
Message-Id: <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
In-Reply-To: <YgI37n+3JfLSNQCQ@grain>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org> <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org> <YgI37n+3JfLSNQCQ@grain>
Date:   Tue, 08 Feb 2022 08:21:20 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Cyrill Gorcunov" <gorcunov@gmail.com>,
        "Mike Rapoport" <rppt@kernel.org>
Cc:     "Dave Hansen" <dave.hansen@intel.com>,
        "Adrian Reber" <adrian@lisas.de>,
        "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Balbir Singh" <bsingharora@gmail.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, "Jann Horn" <jannh@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Kees Cook" <keescook@chromium.org>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Oleg Nesterov" <oleg@redhat.com>, "Pavel Machek" <pavel@ucw.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Dave Martin" <Dave.Martin@arm.com>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "Andrei Vagin" <avagin@gmail.com>,
        "Dmitry Safonov" <0x7f454c46@gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Tue, Feb 8, 2022, at 1:29 AM, Cyrill Gorcunov wrote:
> On Tue, Feb 08, 2022 at 11:16:51AM +0200, Mike Rapoport wrote:
>>  
>> > Any thoughts on how you would _like_ to see this resolved?
>> 
>> Ideally, CRIU will need a knob that will tell the kernel/CET machinery
>> where the next RET will jump, along the lines of
>> restore_signal_shadow_stack() AFAIU.
>> 
>> But such a knob will immediately reduce the security value of the entire
>> thing, and I don't have good ideas how to deal with it :(
>
> Probably a kind of latch in the task_struct which would trigger off once
> returt to a different address happened, thus we would be able to jump inside
> paratite code. Of course such trigger should be available under proper
> capability only.

I'm not fully in touch with how parasite, etc works.  Are we talking about save or restore?  If it's restore, what exactly does CRIU need to do?  Is it just that CRIU needs to return out from its resume code into the to-be-resumed program without tripping CET?  Would it be acceptable for CRIU to require that at least one shstk slot be free at save time?  Or do we need a mechanism to atomically switch to a completely full shadow stack at resume?

Off the top of my head, a sigreturn (or sigreturn-like mechanism) that is intended for use for altshadowstack could safely verify a token on the altshdowstack, possibly compare to something in ucontext (or not -- this isn't clearly necessary) and switch back to the previous stack.  CRIU could use that too.  Obviously CRIU will need a way to populate the relevant stacks, but WRUSS can be used for that, and I think this is a fundamental requirement for CRIU -- CRIU restore absolutely needs a way to write the saved shadow stack data into the shadow stack.

So I think the only special capability that CRIU really needs is WRUSS, and we need to wire that up anyway.
