Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07D1D8D28
	for <lists+linux-arch@lfdr.de>; Tue, 19 May 2020 03:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgESBf2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 21:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgESBf1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 May 2020 21:35:27 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC7DC05BD0A
        for <linux-arch@vger.kernel.org>; Mon, 18 May 2020 18:35:27 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u22so4949724plq.12
        for <linux-arch@vger.kernel.org>; Mon, 18 May 2020 18:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=eH46HFXVZAPfiSp4yenoocGuq08o9xIexbUXyqPElZM=;
        b=MUO3gqmIH8arkfIZPDEnbj00SQROT+XbT+rDPd75eB/HjRGwYyynILINnbvrKpXwEh
         xjH/zddHN9oG2KUZQh2WDdjrzRHcWR924fHvxZmLPfTJdee4nGqk/TmPTpHq6UOnoSUY
         Nozsfy/yQQHZDuEJxIwU5re+Vw3ej5MOtr0VWeszUDlEBFOlzqSCZf1+kGB36LV8nFUS
         p31AewNcXmp3fgPUaHEiV6z+GZWbHK2/pYqyfvA+Oz5jvNqeI9q2Bg9FM+0TD4x/ahM5
         lWrAfGLCf1+679BxrayorUF3lrsFQlGBbjKB8TlTMIVRgW1CavVzF3C1QAL1cnXt1ks1
         8d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=eH46HFXVZAPfiSp4yenoocGuq08o9xIexbUXyqPElZM=;
        b=ikkODV0TaT8Dop3CP2HLVOyWuAZudXKAgJYCNdZXk9K4b3QkPQz7y9Otd+zdxVPD8u
         GWX5OEWofj9g69O2gmaMVLdmDprUbAkVP6OOM6sRNp5DwrmGkZ1RIQRVHSMswABl6/jk
         eP7kkEAisbap4vuljZCPeHiZ5n9jVhB3N4yeWSekwdyGNd7aKTlEtHVmJjwQe6KpAd6t
         DJgXROFE042gzQLnLFCWJHVB8QrOz4TmQRrp3ST/By6wfNJwJIyFZWTjZFnKerjkw3/Z
         GXDuzKtDEAWBcjBfzZVbKf2oH2TA84dBhT6veo7VlXZohVwrdRU9tBC1jmKFY37+pQfS
         oq3w==
X-Gm-Message-State: AOAM530prF/zelVOmX7SekVxwx6cslChKo/Ifli2b6ORVRqoOEcRlvDy
        wIeBSktsuHhAh8zdPp/wkJpK9A==
X-Google-Smtp-Source: ABdhPJy8HG2dxYu85sQ/k3xohgNFNrRpKa2Z8TapTI/kGsGKDc/vL2nDP6aXUMn7J4JK7jLX6crAhg==
X-Received: by 2002:a17:90a:930b:: with SMTP id p11mr2442189pjo.46.1589852126573;
        Mon, 18 May 2020 18:35:26 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:9c3c:ad41:e2e7:d4f4? ([2601:646:c200:1ef2:9c3c:ad41:e2e7:d4f4])
        by smtp.gmail.com with ESMTPSA id 206sm4735467pfy.97.2020.05.18.18.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 18:35:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
Date:   Mon, 18 May 2020 18:35:21 -0700
Message-Id: <58319765-891D-44B9-AF18-64492B01FF36@amacapital.net>
References: <2eb98637-bd2d-dda6-7729-f06ea84256ca@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
In-Reply-To: <2eb98637-bd2d-dda6-7729-f06ea84256ca@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On May 18, 2020, at 5:38 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 5/18/20 4:47 PM, Yu-cheng Yu wrote:
>>> On Fri, 2020-05-15 at 19:53 -0700, Yu-cheng Yu wrote:
>>> On Fri, 2020-05-15 at 16:56 -0700, Dave Hansen wrote:
>>>> On 5/15/20 4:29 PM, Yu-cheng Yu wrote:
>>>>> [...]
>>>>> I have run them with CET enabled.  All of them pass, except for the fo=
llowing:
>>>>> Sigreturn from 64-bit to 32-bit fails, because shadow stack is at a 64=
-bit
>>>>> address.  This is understandable.
>>>> [...]
>>>> One a separate topic: You ran the selftests and one failed.  This is a
>>>> *MASSIVE* warning sign.  It should minimally be described in your cover=

>>>> letter, and accompanied by a fix to the test case.  It is absolutely
>>>> unacceptable to introduce a kernel feature that causes a test to fail.
>>>> You must either fix your kernel feature or you fix the test.
>>>>=20
>>>> This code can not be accepted until this selftests issue is rectified.
>> The x86/sigreturn test constructs 32-bit ldt entries, and does sigreturn f=
rom
>> 64-bit to 32-bit context.  We do not have a way to construct a static 32-=
bit
>> shadow stack.
>=20
> Why? What's the limiting factor?  Hardware architecture?  Something in
> the kernel?
>=20
>> Why do we want that?  I think we can simply run the test with CET
>> disabled.
>=20
> The sadistic parts of selftests/x86 come from real bugs.  Either bugs
> where the kernel fell over, or where behavior changed that broke apps.
> I'd suggest doing some research on where that particular test case came
> from.  Find the author of the test, look at the changelogs.
>=20
> If this is something that a real app does, this is a problem.  If it's a
> sadistic test that Andy L added because it was an attack vector against
> the entry code, it's a different story.

There are quite a few tests that do these horrible things in there. IN my pe=
rsonal opinion, sigreturn.c is one of the most important tests we have =E2=80=
=94 it does every horrible thing to the entry code that I thought of and tha=
t I could come up with a way of doing.  We have been saved from regressing m=
any times by these tests.  CET, and especially the CPL0 version of CET, is i=
ts own set of entry horror, and we need to keep these tests working.

I assume the basic issue is that we call raise(), the context magically chan=
ges to 32-bit, but SSP has a 64-bit value, and horrors happen.  So I think t=
wo things need to happen:

1. Someone needs to document what happens when IRET tries to put a 64-bit va=
lue into SSP but CS is compat. Because Intel has plenty of history of doing c=
olossally broken things here. IOW you could easily be hitting a hardware des=
ign problem, not a software issue per se.

2. The test needs to work. Assuming the hardware doesn=E2=80=99t do somethin=
g utterly broken, either the 32-bit code needs to be adjusted to avoid any C=
ALL
or RET, or you need to write a little raise_on_32bit_shstk() func that switc=
hes to an SSP that fits in 32 bits, calls raise(), and switches back.  =46rom=
 memory, I didn=E2=80=99t think there was a CALl or RET, so I=E2=80=99m gues=
sing that SSP is getting truncated when we round trip through CPL3 compat mo=
de and the result is that the kernel invoked the signal handler with the wro=
ng SSP.  Whoops.

>=20
> I don't personally know the background, but the changelogs can help you
> find the person that does.
