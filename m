Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D032C5F48E1
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 19:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJDRqu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 13:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJDRqs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 13:46:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9C55EDE0;
        Tue,  4 Oct 2022 10:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B405B815CB;
        Tue,  4 Oct 2022 17:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBC2C433D6;
        Tue,  4 Oct 2022 17:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664905601;
        bh=4BSaUvrlCCPRQCV8MWBWOtBwSsI5CjjkAG/AXZX56MU=;
        h=In-Reply-To:References:Date:From:To:Subject:From;
        b=nGHzwTtzDeAUdK1Nz3MDl8munGmB9RGTvZ9Lh4V2lRA4KkSgzw91WY2jfgYMzAW3J
         QiZFo4t8IrZJmj5RabGjxlxGYdb1HaVYKHwjX0b9KMYVd9e8ngyPMItDRzYHWdLCt+
         0wPD+bfhofunIetIX/r0SlgisZJx5jp8T7ul+/loOh/Vv08EGyXdDAdBCkv9RP56Qh
         liS/n1Q9Odvq91rXOIw6lRS+KqvHcFLdGfti7tCLbceZyzrbiuGXclGErGozW4yjBZ
         f/mNTNp15tiEUqAoFDLrkNZGw/KrKwqLA2JJR7w3y1uMlgswgCtjHrlqP7ZpotMHgx
         AUpOHdCijBjbg==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 665E827C0054;
        Tue,  4 Oct 2022 13:46:38 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 04 Oct 2022 13:46:38 -0400
X-ME-Sender: <xms:fXE8YzcfH_ZqjDhKv8jKZx4ZWOo5aJhQ2NzUZ7Apd-X1VPczHbQJkg>
    <xme:fXE8Y5PQ9YGDUn6YjYZNvSKLEh_b89vZOvzqZI7U4y70GKUmHm2cW2UiC-m5yjj5W
    K1gt7Fts6L5gleQCO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiuddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:fXE8Y8g48ud7sjY8IxGAZFP7i-IQ0_v7nq-mBGxl3tjg63-Po2mZTQ>
    <xmx:fXE8Y09JaW5ll0h_VbziYaHUDa8_oWzJxvjHsj2LuWQV9ZZB7Hlc2w>
    <xmx:fXE8Y_v0yO1-kT9OCYG_W-Fl5FmGYkucmyIY3gEha-8GDs7nV1dQbw>
    <xmx:fnE8Y2P76YiRlxcWGtqIKdhjcFLYnbo3_cGNYiF4sWmyo3TPAlaA_Q>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B662E31A0062; Tue,  4 Oct 2022 13:46:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <dbc11c79-44bd-48aa-8548-21d86ac8fc0f@app.fastmail.com>
In-Reply-To: <b22748f80c4993192bc7113b2ed28231dfaee94f.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-40-rick.p.edgecombe@intel.com>
 <ed5f3a95-2854-8b36-7ed9-f1d7ad0a2e51@kernel.org>
 <b22748f80c4993192bc7113b2ed28231dfaee94f.camel@intel.com>
Date:   Tue, 04 Oct 2022 10:46:17 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        "Balbir Singh" <bsingharora@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Jann Horn" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Oleg Nesterov" <oleg@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        "Pavel Machek" <pavel@ucw.cz>, "Arnd Bergmann" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Cyrill Gorcunov" <gorcunov@gmail.com>
Subject: Re: [OPTIONAL/RFC v2 39/39] x86: Add alt shadow stack support
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Tue, Oct 4, 2022, at 9:12 AM, Edgecombe, Rick P wrote:
> On Mon, 2022-10-03 at 16:21 -0700, Andy Lutomirski wrote:
>> On 9/29/22 15:29, Rick Edgecombe wrote:
>> > To handle stack overflows, applications can register a separate
>> > signal alt
>> > stack to use for the stack to handle signals. To handle shadow
>> > stack
>> > overflows the kernel can similarly provide the ability to have an
>> > alt
>> > shadow stack.
>> 
>> 
>> The overall SHSTK mechanism has a concept of a shadow stack that is 
>> valid and not in use and a shadow stack that is in use.  This is
>> used, 
>> for example, by RSTORSSP.  I would like to imagine that this serves
>> a 
>> real purpose (presumably preventing two different threads from using
>> the 
>> same shadow stack and thus corrupting each others' state).
>> 
>> So maybe altshstk should use exactly the same mechanism.  Either
>> signal 
>> delivery should do the atomic very-and-mark-busy routine or
>> registering 
>> the stack as an altstack should do it.
>> 
>> I think your patch has this maybe 1/3 implemented
>
> I'm not following how it breaks down into 3 parts, so hopefully I'm not
> missing something. We could do a software busy bit for the token at the
> end of alt shstk though. It seems like a good idea.

I didn't mean there were three parts.  I just wild @&! guessed the amount of code written versus needed :)

>
> The busy-like bit in the RSTORSSP-type token is not called out as a
> busy bit, but instead defined as reserved (must be 0) in some states.
> (Note, it is different than the supervisor shadow stack format). Yea,
> we could just probably use it like RSTORSSP does for this operation.
>
> Or just invent another new token format and stay away from bits marked
> reserved. Then it wouldn't have to be atomic either, since userspace
> couldn't use it.

But userspace *can* use it by delivering a signal.  I consider the scenario where two user threads set up the same altshstk and take signals concurrently to be about as dangerous and about as likely (under accidental or malicious conditions) as two user threads doing RSTORSSP at the same time.  Someone at Intel thought the latter was a big deal, so maybe we should match its behavior.
