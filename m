Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52751470D6
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2019 17:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfFOPaM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Jun 2019 11:30:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40188 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfFOPaL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Jun 2019 11:30:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so2267893pla.7
        for <linux-arch@vger.kernel.org>; Sat, 15 Jun 2019 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/jcKk2/19vs459JoYUsaRTHxKiAzDVN8TgUMdkzJK98=;
        b=L1UiC6nRuC3WJJyU4c429mSMn+pt8bbs3SLZ3/ixeDlvWes+s1uY9J4EILqskN4rXb
         fcFioaFdINs25jtQGQF5qZ2rz4p5MOv7Y/AYkenKBgA3ZKQ0mFZ+llpN/qByte1CrNMD
         c5cTCshV0XRXLeLNGARAUHukmOrufQ04fPKFD0HjybCZiZw/SImj09huQbCbm8aCrUMr
         TU5YUAeHmbjni7zoyDuZEyuUQoa3Qp3fG/qd+979UGnjN8hSVuXm/kcVhSlWZN4WAPU0
         fjyhF3NeYYZyQjjTCZ6u0skIxl3jWLS+jEUDnprxySkwYzDUXrg5LZMv4R2K14mjW4Hv
         MV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/jcKk2/19vs459JoYUsaRTHxKiAzDVN8TgUMdkzJK98=;
        b=mMC9sots5p540LLljJQxf8YPn0szFBVJiaXXiHOxaKWpJSSjubvFOEG+yjd03YAUh5
         R3jh39EbmCe+rHOU7dO1LqBb7okFg/mJfjl/gws7VzbUWAaGvUUnF0lUzdBNd6uirWMq
         UVmsloZilMkWFLOVgfp6PtHLLxUAwbiTw3RZBbarzgnnEN4j26q3ufDlms7/CAd7PalV
         53DB0PwEg/mQukkqDlVB4sRdhPqkjeG12IAgrPWtlDos6FpTUBslhwZdJ2792yCekoUb
         REfYNNrIOj9yOxm4Cqw5cJqMNTB1ol8gl27jBp+gV22QUcOCzMH0ArPLhBsEzl9JAcne
         mhUA==
X-Gm-Message-State: APjAAAVoQ0DrFRisPsc2P3VQVg/U1nSV7kgVt0SEZvUagw6BeSi0znVk
        4K720mBjUdFrDkxbIAgeChO1Yg==
X-Google-Smtp-Source: APXvYqxMtmluM9P/M5dWN/Lor2GlhEt5GnTEIv5uBTV8Q2z4c6iDoqESId4Kmw0F8ERpcyEBPtKqlg==
X-Received: by 2002:a17:902:ab83:: with SMTP id f3mr8554100plr.122.1560612610934;
        Sat, 15 Jun 2019 08:30:10 -0700 (PDT)
Received: from ?IPv6:2600:1010:b01c:6f69:f4c4:438f:f883:452a? ([2600:1010:b01c:6f69:f4c4:438f:f883:452a])
        by smtp.gmail.com with ESMTPSA id g8sm7859239pgd.29.2019.06.15.08.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 08:30:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup function
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <5d7012f6-7ab9-fd3d-4a11-294258e48fb5@intel.com>
Date:   Sat, 15 Jun 2019 08:30:08 -0700
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E68459DD-53D3-42A6-B120-180203791E24@amacapital.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <7e0b97bf1fbe6ff20653a8e4e147c6285cc5552d.camel@intel.com>
 <25281DB3-FCE4-40C2-BADB-B3B05C5F8DD3@amacapital.net> <e26f7d09376740a5f7e8360fac4805488b2c0a4f.camel@intel.com>
 <3f19582d-78b1-5849-ffd0-53e8ca747c0d@intel.com> <5aa98999b1343f34828414b74261201886ec4591.camel@intel.com>
 <0665416d-9999-b394-df17-f2a5e1408130@intel.com> <5c8727dde9653402eea97bfdd030c479d1e8dd99.camel@intel.com>
 <ac9a20a6-170a-694e-beeb-605a17195034@intel.com> <328275c9b43c06809c9937c83d25126a6e3efcbd.camel@intel.com>
 <92e56b28-0cd4-e3f4-867b-639d9b98b86c@intel.com> <1b961c71d30e31ecb22da2c5401b1a81cb802d86.camel@intel.com>
 <ea5e333f-8cd6-8396-635f-a9dc580d5364@intel.com> <cf0d1470e95e0a8b88742651d06601a53d6655c1.camel@intel.com>
 <5ddf59e2-c701-3741-eaa1-f63ee741ea55@intel.com> <b5a915602020a6ce26ea1254f7f60e239c91bc9f.camel@intel.com>
 <598edca7-c36a-a236-3b72-08b2194eb609@intel.com> <359e6f64d646d5305c52f393db5296c469630d11.camel@intel.com>
 <5d7012f6-7ab9-fd3d-4a11-294258e48fb5@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jun 14, 2019, at 3:06 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
>> On 6/14/19 2:34 PM, Yu-cheng Yu wrote:
>> On Fri, 2019-06-14 at 13:57 -0700, Dave Hansen wrote:
>>>> I have a related question:
>>>>=20
>>>> Do we allow the application to read the bitmap, or any fault from the
>>>> application on bitmap pages?
>>>=20
>>> We have to allow apps to read it.  Otherwise they can't execute
>>> instructions.
>>=20
>> What I meant was, if an app executes some legacy code that results in bit=
map
>> lookup, but the bitmap page is not yet populated, and if we then populate=
 that
>> page with all-zero, a #CP should follow.  So do we even populate that zer=
o page
>> at all?
>>=20
>> I think we should; a #CP is more obvious to the user at least.
>=20
> Please make an effort to un-Intel-ificate your messages as much as
> possible.  I'd really prefer that folks say "missing end branch fault"
> rather than #CP.  I had to Google "#CP".
>=20
> I *think* you are saying that:  The *only* lookups to this bitmap are on
> "missing end branch" conditions.  Normal, proper-functioning code
> execution that has ENDBR instructions in it will never even look at the
> bitmap.  The only case when we reference the bitmap locations is when
> the processor is about do do a "missing end branch fault" so that it can
> be suppressed.  Any population with the zero page would be done when
> code had already encountered a "missing end branch" condition, and
> populating with a zero-filled page will guarantee that a "missing end
> branch fault" will result.  You're arguing that we should just figure
> this out at fault time and not ever reach the "missing end branch fault"
> at all.
>=20
> Is that right?
>=20
> If so, that's an architecture subtlety that I missed until now and which
> went entirely unmentioned in the changelog and discussion up to this
> point.  Let's make sure that nobody else has to walk that path by
> improving our changelog, please.
>=20
> In any case, I don't think this is worth special-casing our zero-fill
> code, FWIW.  It's not performance critical and not worth the complexity.
> If apps want to handle the signals and abuse this to fill space up with
> boring page table contents, they're welcome to.  There are much easier
> ways to consume a lot of memory.

Isn=E2=80=99t it a special case either way?  Either we look at CR2 and popul=
ate a page, or we look at CR2 and the =E2=80=9Ctracker=E2=80=9D state and se=
nd a different signal.  Admittedly the former is very common in the kernel.

>=20
>>> We don't have to allow them to (popuating) fault on it.  But, if we
>>> don't, we need some kind of kernel interface to avoid the faults.
>>=20
>> The plan is:
>>=20
>> * Move STACK_TOP (and vdso) down to give space to the bitmap.
>=20
> Even for apps with 57-bit address spaces?
>=20
>> * Reserve the bitmap space from (mm->start_stack + PAGE_SIZE) to cover a c=
ode
>> size of TASK_SIZE_LOW, which is (TASK_SIZE_LOW / PAGE_SIZE / 8).
>=20
> The bitmap size is determined by CR4.LA57, not the app.  If you place
> the bitmap here, won't references to it for high addresses go into the
> high address space?
>=20
> Specifically, on a CR4.LA57=3D0 system, we have 48 bits of address space,
> so 128TB for apps.  You are proposing sticking the bitmap above the
> stack which is near the top of that 128TB address space.  But on a
> 5-level paging system with CR4.LA57=3D1, there could be valid data at
> 129GB.  Is there something keeping that data from being mistaken for
> being part of the bitmap?
>=20

I think we need to make the vma be full sized =E2=80=94 it should cover the e=
ntire range that the CPU might access. If that means it spans the 48-bit bou=
ndary, so be it.

> Also, if you're limiting it to TASK_SIZE_LOW, please don't forget that
> this is yet another thing that probably won't work with the vsyscall
> page.  Please make sure you consider it and mention it in your next post.

Why not?  The vsyscall page is at a negative address.

>=20
>> * Mmap the space only when the app issues the first mark-legacy prctl.  T=
his
>> avoids the core-dump issue for most apps and the accounting problem that
>> MAP_NORESERVE probably won't solve

What happens if there=E2=80=99s another VMA there by the time you map it?=
