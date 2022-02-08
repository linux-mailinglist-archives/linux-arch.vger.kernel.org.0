Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C184ADE1D
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 17:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382952AbiBHQRs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 11:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiBHQRr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 11:17:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3FFC061576
        for <linux-arch@vger.kernel.org>; Tue,  8 Feb 2022 08:17:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D637BB81BDD
        for <linux-arch@vger.kernel.org>; Tue,  8 Feb 2022 16:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AF6C004E1;
        Tue,  8 Feb 2022 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337064;
        bh=jC6VMA8Sjd8HqhTCuSTd/fKRie9Nid3LAIoupAVCfTE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=mFWGq8uAmEYrM4KqTeIPAKdvUJpkRPXpSvPv8XwE3fiYaMXlMUbLu1WwQN7AL2xGb
         sRRyeogXF566C+wrWX7L/PCPdoQHFZDwjv5ixiTClH+JX8n/SumavGgUi2JPTvhf4u
         HJTpMglX6kmleSRSkZe4HeCXS6JBz+W54bs7q63PRyQr6RsP2v2sFEEji+dZaB6fTc
         xcBN3abEqZKglPSQac6tasuTziU0eEtpsXc3cWYsGH6OT8JFTgcB1G9DOClNQ/TW2G
         Kl8BnawvDjkNfaLgLHml0AvcTfTcpLopAz/VZVvWPbY10IQhaYYyxsAs1XP5RFQ2+e
         tnzvW+xcodPhA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id C69D527C0054;
        Tue,  8 Feb 2022 11:17:41 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Tue, 08 Feb 2022 11:17:41 -0500
X-ME-Sender: <xms:pJcCYmyQ-D4r7f7RLuyn2sI4TJBlIEUTxxo_SsXvxbLw2eShW_DqCw>
    <xme:pJcCYiSiHDVlmKJ_bx5T8hwv-bnRbpHohpq7r-UjB3CZ2l_vug11UwMX3ykacfI1h
    UE__rzajT_GlvQLVOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheejgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleffgfef
    vdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudekheei
    fedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrd
    hluhhtohdruhhs
X-ME-Proxy: <xmx:pJcCYoW5bf9iA3GFSMYFd0oYfgJCLB5Ur7zWmFzzuVIPO3vjqeuOcA>
    <xmx:pJcCYsjn5PdnQGjlN3hz12UubnRpK0zb-FEdOwH8r_ZJJWJ0-RdNcA>
    <xmx:pJcCYoAkWI2J4XKYOtKSffY77Z00QDgVRcp3cNlb2S1qFIHqB7DxXg>
    <xmx:pZcCYujI_qgvUILAndkfV21ruLnmNvrGzpFCJLTj6ieH_2W8JAqvUoaU-Jw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7B8AA21E0073; Tue,  8 Feb 2022 11:17:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4748-g31a5b5f50e-fm-cal2020-20220204.001-g31a5b5f5
Mime-Version: 1.0
Message-Id: <f4663ec8-7c69-40d7-b2ae-64cde71675b9@www.fastmail.com>
In-Reply-To: <87mtj1vh50.ffs@tglx>
References: <87fsozek0j.ffs@tglx>
 <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
 <3421da7fc8474b6db0e265b20ffd28d0@AcuMS.aculab.com>
 <CAMe9rOonepEiRyoAyTGkDMQQhuyuoP4iTZJJhKGxgnq9vv=dLQ@mail.gmail.com>
 <9f948745435c4c9273131146d50fe6f328b91a78.camel@intel.com>
 <6ba06196-0756-37a4-d6c4-2e47e6601dcd@kernel.org> <87mtj1vh50.ffs@tglx>
Date:   Tue, 08 Feb 2022 08:15:12 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "David Laight" <David.Laight@aculab.com>,
        "Adrian Reber" <adrian@lisas.de>,
        "Cyrill Gorcunov" <gorcunov@openvz.org>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        "Dmitry Safonov" <0x7f454c46@gmail.com>
Cc:     "Balbir Singh" <bsingharora@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Jann Horn" <jannh@google.com>, "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Pavel Machek" <pavel@ucw.cz>, "Oleg Nesterov" <oleg@redhat.com>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        "Borislav Petkov" <bp@alien8.de>, "Arnd Bergmann" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave Martin" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Cyrill Gorcunov" <gorcunov@gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 8, 2022, at 1:31 AM, Thomas Gleixner wrote:
> On Mon, Feb 07 2022 at 17:31, Andy Lutomirski wrote:
>> So this leaves altshadowstack.  If we want to allow userspace to handle 
>> a shstk overflow, I think we need altshadowstack.  And I can easily 
>> imagine signal handling in a coroutine or user-threading evironment (Go? 
>> UMCG or whatever it's called?) wanting this.  As noted, this obnoxious 
>> Andy person didn't like putting any shstk-related extensions in the FPU 
>> state.
>>
>> For better or for worse, altshadowstack is (I think) fundamentally a new 
>> API.  No amount of ucontext magic is going to materialize an entire 
>> shadow stack out of nowhere when someone calls sigaltstack().  So the 
>> questions are: should we support altshadowstack from day one and, if so, 
>> what should it look like?
>
> I think we should support them from day one.
>
>> So I don't have a complete or even almost complete design in mind, but I 
>> think we do need to make a conscious decision either to design this 
>> right or to skip it for v1.
>
> Skipping it might create a fundamental design fail situation as it might
> require changes to the shadow stack signal handling in general which
> becomes a nightmare once a non-altstack API is exposed.

It would also expose a range of kernels in which shstk is on but programs that want altshadowstack don't have it.  That would be annoying.

>
>> As for CRIU, I don't think anyone really expects a new kernel, running 
>> new userspace that takes advantage of features in the new kernel, to 
>> work with old CRIU.
>
> Yes, CRIU needs updates, but what ensures that CRIU managed user space
> does not use SHSTK if CRIU is not updated yet?

In some sense this is like any other feature.  If a program uses timerfd but CRIU doesn't support timerfd, then it won't work.  SHSTK is a bit unique because it's likely that all programs on a system will start using it all at once.
