Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB03917E9C5
	for <lists+linux-arch@lfdr.de>; Mon,  9 Mar 2020 21:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCIUQR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 16:16:17 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53217 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgCIUQR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 16:16:17 -0400
Received: by mail-pj1-f66.google.com with SMTP id f15so373412pjq.2
        for <linux-arch@vger.kernel.org>; Mon, 09 Mar 2020 13:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=hmz7wPe81dzHCyk8vtSMtwBBBBwZYq3jRplov8Ww+C4=;
        b=ZRaiCHGEl38L7KRBnErstw4bimBDz87AHqw51Xkkbqe8mwiwaum46PZHXbMEgOOA0j
         Mwyf6ObvRwr7G2hs8Uj+hpnHhTmm/J8upQOk3D/fFQm05iw67GgRr+tyo+BLdhHy5nB5
         Lwwt/y/AF+8OL42TzE087xDA1gbjLJ4boZbPZTHMsE3SeiOU9i8j90C6EyxoOBaxPp5A
         wprxkqzTwjQRhbgX5n/yY6UyfpmWQRavyv88zmVrNjeeHEmd2qDUM+SZ7oWZZscU3Kii
         PPT1iRwszjNEqvOJzEFaD43kNCwMl9myIn1ub/f1VW1KDm9Dn4q/kySbYkWX0GbNjPwC
         7XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=hmz7wPe81dzHCyk8vtSMtwBBBBwZYq3jRplov8Ww+C4=;
        b=XIF1Ax7WKt4b1mwSuRxq38tJhHvTrPHlPoceoc6kH8g3gnVm7RPzeIVGfR1Ap2KGqU
         PpJ+zgoWDx3U5AMBG/DvZZMJ7iz16mtaxLWf6lfIZfxwas5dsqTsPp3djsZ6OdRIs5lO
         jAkKBbzym9j6HFpiCk+Kz9ZWDqeG5dTIskyZQLk0lSJ9rAKBGjsd/pdBuEzMY5sbdp/A
         hKGOTkpuRbG67DWTWmEHFRd7Yt74xLfZ+FD/d+aIY63xkjJCB4lacr9coaSU9c2zRtnN
         AQHYV8bhUVMTz3eYTPOAsQBSEco2LdjDz1zpx9bB6iJAldh0ROQ6mlJjNMOQG8lInNca
         zwvg==
X-Gm-Message-State: ANhLgQ3riSixRQN00vYndxISXMPspZyc09fDgr9ylGom1vKMryPXuNv/
        UR7EqEA/63cb7MjMkqIugLIB5Q==
X-Google-Smtp-Source: ADFU+vufTMP65N8WnOzHoWZtLu1mlwMdUeuo8lDWUX7ChArVxhlmQwIZxREHkmUUUFy0pcgRqvHV6A==
X-Received: by 2002:a17:902:7607:: with SMTP id k7mr17287063pll.175.1583784976613;
        Mon, 09 Mar 2020 13:16:16 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:61f8:fe1:ddbe:5c19? ([2601:646:c200:1ef2:61f8:fe1:ddbe:5c19])
        by smtp.gmail.com with ESMTPSA id h2sm44306210pgv.40.2020.03.09.13.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 13:16:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
Date:   Mon, 9 Mar 2020 13:16:14 -0700
Message-Id: <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net>
References: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
In-Reply-To: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Mar 9, 2020, at 12:50 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>=20
> =EF=BB=BFOn Mon, Mar 9, 2020 at 12:35 PM Dave Hansen <dave.hansen@intel.co=
m> wrote:
>>=20
>>> On 3/9/20 12:27 PM, Yu-cheng Yu wrote:
>>> On Mon, 2020-03-09 at 10:21 -0700, Dave Hansen wrote:
>>>> On 3/9/20 10:00 AM, Yu-cheng Yu wrote:
>>>>> On Wed, 2020-02-26 at 09:57 -0800, Dave Hansen wrote>>>>> +Note:
>>>>>>> +  There is no CET-enabling arch_prctl function.  By design, CET is
>>>>>>> +  enabled automatically if the binary and the system can support it=
.
>>>>>>=20
>>>>>> This is kinda interesting.  It means that a JIT couldn't choose to
>>>>>> protect the code it generates and have different rules from itself?
>>>>>=20
>>>>> JIT needs to be updated for CET first.  Once that is done, it runs wit=
h CET
>>>>> enabled.  It can use the NOTRACK prefix, for example.
>>>>=20
>>>> Am I missing something?
>>>>=20
>>>> What's the direct connection between shadow stacks and Indirect Branch
>>>> Tracking other than Intel marketing umbrellas?
>>>=20
>>> What I meant is that JIT code needs to be updated first; if it skips RET=
s,
>>> it needs to unwind the stack, and if it does indirect JMPs somewhere it
>>> needs to fix up the branch target or use NOTRACK.
>>=20
>> I'm totally lost.  I think we have very different models of how a JIT
>> might generate and run code.
>>=20
>> I can totally see a scenario where a JIT goes and generates a bunch of
>> code, then forks a new thread to go run that code.  The control flow of
>> the JIT thread itself *NEVER* interacts with the control flow of the
>> program it writes.  They never share a stack and nothing ever jumps or
>> rets between the two worlds.
>>=20
>> Does anything actually do that?  I've got no idea.  But, I can clearly
>> see a world where the entirety of Chrome and Firefox and the entire rust
>> runtime might not be fully recompiled and CET-enabled for a while.  But,
>> we still want the JIT-generated code to be CET-protected since it has
>> the most exposed attack surface.
>>=20
>> I don't think that's too far-fetched.
>=20
> CET support is all or nothing.   You can mix and match, but you will get
> no CET protection, similar to NX feature.
>=20

Can you explain?

If a program with the magic ELF CET flags missing can=E2=80=99t make a threa=
d with IBT and/or SHSTK enabled, then I think we=E2=80=99ve made an error an=
d should fix it.

> --=20
> H.J.
