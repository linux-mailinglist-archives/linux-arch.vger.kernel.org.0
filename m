Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F148E28C
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jan 2022 03:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiANCex (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jan 2022 21:34:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46776 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiANCew (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jan 2022 21:34:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5915AB823F5;
        Fri, 14 Jan 2022 02:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EC7C36AE3;
        Fri, 14 Jan 2022 02:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642127690;
        bh=1zycz2e46vXoUD4sZJQiVQh6Wt3eKK/5paZ5/M+Am9k=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=EoCfiU2jgjQfdrsiRLL4qry/kpJj+bEZ7S+J4ipvnWI6vyHd6mrARwMKEbU01Na3X
         mDLRSIWU1DSKjE7iRLjiecfJvsd2NFV/B4xBO668n9/bczVcsL5Ysrwu8LNzpdE2h6
         JkU5VhFGRLL2qiNEgNo46CG85+osyXeTwc47k5ZbN+AZEgirzkXzIfq65BDP3q9+AF
         Ps8WQdmrgJQZ1oBXyIyle/4L14Y/iZ1CkU7+wZanJpyK77f8LnFC9kAVpL/aGesQ9U
         qmMfqNq1gGoaECfDNenA6jpGOQJ4fhpTJ1qp6IXq/DIq9ZiOp1DY7l+Y+KqW94JlHB
         GwvbWA/EpYLMg==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6150427C0054;
        Thu, 13 Jan 2022 21:34:48 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Thu, 13 Jan 2022 21:34:48 -0500
X-ME-Sender: <xms:R-HgYYKeqp_Pf6vT461iO_w1CsQPy2fiKC1xl0b8ZhdO4cxRvKR17Q>
    <xme:R-HgYYJl3GkF7zK7kuKktneJDAEpwQSU2XN_cj0XvMGVb47hyrjG67z1BcOhh_Osf
    gt80WUE-yN9G8hFz_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdeggdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhephfegffegkeefkedvffehleehgfeileeutdfhieegkeeuheegvdektdet
    fffhtedvnecuffhomhgrihhnpehouhhtrdhtohholhhsnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlhhuthhope
    epkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:R-HgYYtcQl2oyw4bWnOw_izI-NxIW2JF6wL7D2aa6bQVdO0t58aQ4A>
    <xmx:R-HgYVa1bXNSWpCOtIxItKMJGQsJO_cMiPMiEEMgeR5bi_Pf2K2cUQ>
    <xmx:R-HgYfY9LbILUfGpQFrFlnJpDFm0Dej8dSCDyRk2roSmwkYf7C0d8Q>
    <xmx:SOHgYcQ513uXepiIzysiDcFz4JVeK6o1sHQuKIrL4lWIDlEtkHvdyodkBP8>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B567B21E0073; Thu, 13 Jan 2022 21:34:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <5a4f01f4-cd16-47dd-880b-dcfb7ec5daeb@www.fastmail.com>
In-Reply-To: <87lezjxpnc.fsf@oldenburg.str.redhat.com>
References: <3a1c8280967b491bf6917a18fbff6c9b52e8df24.1641398395.git.fweimer@redhat.com>
 <54ae0e1f8928160c1c4120263ea21c8133aa3ec4.1641398395.git.fweimer@redhat.com>
 <034075bd-aac5-9b97-6d09-02d9dd658a0b@kernel.org>
 <87lezjxpnc.fsf@oldenburg.str.redhat.com>
Date:   Thu, 13 Jan 2022 18:34:20 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Florian Weimer" <fweimer@redhat.com>
Cc:     linux-arch@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, "the arch/x86 maintainers" <x86@kernel.org>,
        musl@lists.openwall.com,
        "Dave Hansen via Libc-alpha" <libc-alpha@sourceware.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Andrei Vagin" <avagin@gmail.com>
Subject: Re: [PATCH v3 2/3] selftests/x86/Makefile: Support per-target $(LIBS)
 configuration
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 13, 2022, at 2:00 PM, Florian Weimer wrote:
> * Andy Lutomirski:
>
>> On 1/5/22 08:03, Florian Weimer wrote:
>>> And avoid compiling PCHs by accident.
>>> 
>>
>> The patch seems fine, but I can't make heads or tails of the
>> $SUBJECT. Can you help me?
>
> What about this?
>
> selftests/x86/Makefile: Set linked libraries using $(LIBS)
>
> I guess that it's possible to use make features to set this per target
> isn't important.

I think that's actually important -- it's nice to explain to make dummies (e.g. me) what the purpose is is.  I assume it's so that a given test can override the libraries.  Also, you've conflated two different changes into one patch: removal of .h and addition of LIBS.

--Andy



>
> Thanks,
> Florian
>
>>> Signed-off-by: Florian Weimer <fweimer@redhat.com>
>>> ---
>>> v3: Patch split out.
>>>   tools/testing/selftests/x86/Makefile | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>> diff --git a/tools/testing/selftests/x86/Makefile
>>> b/tools/testing/selftests/x86/Makefile
>>> index 8a1f62ab3c8e..0993d12f2c38 100644
>>> --- a/tools/testing/selftests/x86/Makefile
>>> +++ b/tools/testing/selftests/x86/Makefile
>>> @@ -72,10 +72,12 @@ all_64: $(BINARIES_64)
>>>   EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
>>>     $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
>>> -	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
>>> +	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $(filter-out %.h, $^) \
>>> +		$(or $(LIBS), -lrt -ldl -lm)
>>>     $(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h
>>> -	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
>>> +	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $(filter-out %.h, $^) \
>>> +		$(or $(LIBS), -lrt -ldl -lm)
>>>     # x86_64 users should be encouraged to install 32-bit libraries
>>>   ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)
