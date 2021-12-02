Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCCC4665E3
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 15:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358824AbhLBO7J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 09:59:09 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:44077 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358808AbhLBO7H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2021 09:59:07 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 526943201E78;
        Thu,  2 Dec 2021 09:55:42 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute5.internal (MEProxy); Thu, 02 Dec 2021 09:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=+NUeMvGno9VoUYgWj62BzbUCTMF03jM
        8iOcYMnHe6Jo=; b=fXW8aaVpmBW0/bI+IK7QhkiXw/PwfyVTQvdrQUgpwb8rtxt
        Bhj3LCCwa7h7WivXSanhF7lS3+yEHhQAPfAkkYHgounXWqC9/jjsYzyFbt6OkHXJ
        MY+6HDtAplln7oTeDwS3Z5nnSpBXGTH/1I1ki1LKkcLHdFJ7oMNy+O1QkntaqCVu
        I0e0wY0KtziawAx2fVgJnOfiPnawqPdhhg9A+EXR82D56bI5YQ5qwd2zjpeQAxgf
        azmL84TDqhKIa6oCbgDc3jWKUOB+KvQx2Upd9UfjxdwU6xaQgakjg754Ckqky/lc
        GnswU5ksKRovwMGoC28I22pNdNvhQdMJdG3v0uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+NUeMv
        Gno9VoUYgWj62BzbUCTMF03jM8iOcYMnHe6Jo=; b=N1vMm3qGdST4hCH7kL3RNl
        /GCF4UHXQUizEdUMjbVZhouOWFOooNfpT+sKg34sGMAm+npWbXBcnYpjEVmp11rZ
        MXsCs5vmcvCpEdzqm2VbENyZwVCamSbugXGI+ujFR75dSnaRJCrqrwDwyjgb0+FC
        OZXtbVcVRvqKngu/s5xe5plh6YHbXgqU16mumDwUmYCwHJnneMszqEsP2I/zFGLL
        WDURx63NSU4j9w7GlDUZZSZNlAufvNqH7OKHPPvvLKAyvFfnTOy9gEY43s6x4hmr
        +n5OKiWAUOS4N/uIh8tFV8cfSUEXoMUsu+A6gLHmp9lmRloVh7Hopr8ic3HXbSPA
        ==
X-ME-Sender: <xms:bd6oYTJIRs7SIavIDblVThWXtpVtILcxZaWGLjtG4V1ShjldXreNqw>
    <xme:bd6oYXLF1yriDEudSSU78SL6SmCNDjygbBHIezocgYR1D3yII4Vma4wksrQYngoI_
    Y7q2Gxr8Ua54ouaM1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfkggrtghk
    ucghvghinhgsvghrghdfuceoiigrtghksehofihlfhholhhiohdrohhrgheqnecuggftrf
    grthhtvghrnhephfeuhfevueffteffgfejtefgkeekheeftdeflefgheffffevheekleef
    gfehffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epiigrtghksehofihlfhholhhiohdrohhrgh
X-ME-Proxy: <xmx:bd6oYbvVu_Et3kkzuONhU23glxmXwesHDbn4RiGBk-QOAcNMIVMuvQ>
    <xmx:bd6oYcZuRyYC_eXeJJMCbIL7JTc2-aBPFynrjafJO5y_IcIvtyZ95A>
    <xmx:bd6oYabSu4i0RvdCrUTgNhJH4SeS9WZzBTty8aVM1k6OXFfG1ya-qQ>
    <xmx:bd6oYfMdfg56CVuu2VY762Pef75SJbhFPFwUpW4anNknuL3vF7OiAQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 13EC024A0074; Thu,  2 Dec 2021 09:55:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4458-g51a91c06b2-fm-20211130.004-g51a91c06
Mime-Version: 1.0
Message-Id: <b8d6f890-e5aa-44bf-8a55-5998efa05967@www.fastmail.com>
In-Reply-To: <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <1618289.1637686052@warthog.procyon.org.uk>
 <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com> <YaTAffbvzxGGsVIv@yuki>
 <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
Date:   Thu, 02 Dec 2021 09:55:20 -0500
From:   "Zack Weinberg" <zack@owlfolio.org>
To:     "Arnd Bergmann" <arnd@arndb.de>, "Cyril Hrubis" <chrubis@suse.cz>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        libc-alpha@sourceware.org,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David Howells" <dhowells@redhat.com>,
        "David Laight" <David.Laight@aculab.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 29, 2021, at 9:34 AM, Arnd Bergmann wrote:
> On Mon, Nov 29, 2021 at 12:58 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>>
>> What about guarding the change with __STDINT_COMPATIBLE_TYPES__

In user space, I don't see a compelling need for backward compatibility?  User space's expectation is that the types are *already* the same and we (glibc) regularly get bug reports because they aren't.

I could be persuaded otherwise with an example of a program for which changing
__s64 from 'long long' to 'long' would break *binary* backward compatibility, or
similarly for __u64.

> I don't think we can include stdint.h here, the entire point of the custom
> kernel types is to ensure the other kernel headers can use these types
> without relying on libc headers.

If __KERNEL__ is not defined, though, there should be no issue, right?

From user space's perspective, it's an ongoing source of problems whenever __uN isn't exactly the same "underlying type" as uintN_t, same for __sN and intN_t.  We would really like it if the uapi headers, when included from user space, deferred to the C library for the definitions of these types.

<stdint.h> does define a lot of things beyond just the fixed-width types, and it defines names in the application namespace (i.e. with no __ prefix).  Perhaps we could come to some agreement on a private header, provided by libcs, that *only* defined __{u,}int{8,16,32,64}_t.  glibc already has <bits/types.h> which promises
to define only __-prefix names, but it defines a lot of other types as well (__dev_t, __uid_t, __pid_t, __time_t, etc etc etc).

zw
