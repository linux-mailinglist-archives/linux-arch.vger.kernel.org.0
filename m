Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2177325B9CB
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 06:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgICEgB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 00:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgICEgA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 00:36:00 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20CCC061246
        for <linux-arch@vger.kernel.org>; Wed,  2 Sep 2020 21:35:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gf14so835278pjb.5
        for <linux-arch@vger.kernel.org>; Wed, 02 Sep 2020 21:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=c4AodrXdr1y4XfEvpz1cwzbqc0Ntf48J70eL2aX9oQI=;
        b=2TRg6Pt2o98tfWujTDiLLf6/VEGtI649lNEM2WkQGpk5OujV684ZLl1+qouHnVzCxI
         ToSXizqAPkBQ6AVBn1hMw0OAXSQYfxGE+Cd7YpFLxFHGLySOQlE4kNo98rNNCUXhNf0c
         arXqJo4aLZK1ppcDlHPJks8e3VOXyXWWVLeJEapUQJBuJ4hMrixSWr1qgns1jUDjIWTx
         pdxrHsyVQ1Z/mAfec2PKKlgYL0dGUd7OABGH/Sq4mWZiDXD0WghrDhnCj/k2bluv3Zsk
         z/YObrYdwUpa0M6OjGrUwZtO5PSXH20kWbGxRS0XihZlJktcT2tnAMU9AWWtGZEscSCp
         lx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=c4AodrXdr1y4XfEvpz1cwzbqc0Ntf48J70eL2aX9oQI=;
        b=hFga3V0uei3zWX4L60e3mDA+k+B05tnQ9yFHUW2MM5Z6lB3KIS/9h4sr5fOHuyAeUI
         PQqPmhVAqMmbZ1qcU8emu6cKNb1R/jmQcWZpZ09dpcGjGKlA1aWE/fDfZEDEXLTEoT/R
         s46inAj2P9r5n3VnW1gkCpQXkyWb+B5cqNvMB6baiNW7Vu0Sp4SJqh22BT4jCRL/1CQP
         MzEky5Ug+7PD2zYsgFXUm4XBNQ/njfbJ1z83s/rWhI9AM1oe7Up6BnuhIVvAx4tyD9GZ
         aAnsNAk2VrJsO2HRg9lnI0gFvJLoL9uWFDlPHH1gC+OPN8V9Q2QTg0onN6XoLjL/OJ8g
         fd/Q==
X-Gm-Message-State: AOAM532WggByWYuBaRGsupdfXvK3Umt86tfrCyICsx+XOIjNcccizFKq
        lRZOrL7NN9xzI3DkM1vf2BgkJA==
X-Google-Smtp-Source: ABdhPJwaRQQGkv4eqs7ZIu/88dhYc9SDUGZTxIHWO2yBYvRFSnsqam/VW1c/u0PoJZoI8hvFN36jkw==
X-Received: by 2002:a17:90a:160f:: with SMTP id n15mr1310345pja.75.1599107759363;
        Wed, 02 Sep 2020 21:35:59 -0700 (PDT)
Received: from ?IPv6:2600:1010:b068:276f:834:4bae:7a0f:cb7d? ([2600:1010:b068:276f:834:4bae:7a0f:cb7d])
        by smtp.gmail.com with ESMTPSA id q34sm917533pgl.28.2020.09.02.21.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 21:35:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v11 6/9] x86/cet: Add PTRACE interface for CET
Date:   Wed, 2 Sep 2020 21:35:56 -0700
Message-Id: <40BC093A-F430-4DCC-8DC0-2BA90A6FC3FA@amacapital.net>
References: <46e42e5e-0bca-5f3f-efc9-5ab15827cc0b@intel.com>
Cc:     Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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
In-Reply-To: <46e42e5e-0bca-5f3f-efc9-5ab15827cc0b@intel.com>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
X-Mailer: iPhone Mail (17G80)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Sep 2, 2020, at 7:53 PM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>=20
> =EF=BB=BFOn 9/2/2020 4:50 PM, Andy Lutomirski wrote:
>>>> On Sep 2, 2020, at 3:13 PM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:=

>>>=20
>>> =EF=BB=BFOn 9/2/2020 1:03 PM, Jann Horn wrote:
>>>>> On Tue, Aug 25, 2020 at 2:30 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wr=
ote:
>>>>> Add REGSET_CET64/REGSET_CET32 to get/set CET MSRs:
>>>>>=20
>>>>>     IA32_U_CET (user-mode CET settings) and
>>>>>     IA32_PL3_SSP (user-mode Shadow Stack)
>>>> [...]
>>>>> diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset=
.c
>>>> [...]
>>>>> +int cetregs_get(struct task_struct *target, const struct user_regset *=
regset,
>>>>> +               struct membuf to)
>>>>> +{
>>>>> +       struct fpu *fpu =3D &target->thread.fpu;
>>>>> +       struct cet_user_state *cetregs;
>>>>> +
>>>>> +       if (!boot_cpu_has(X86_FEATURE_SHSTK))
>>>>> +               return -ENODEV;
>>>>> +
>>>>> +       fpu__prepare_read(fpu);
>>>>> +       cetregs =3D get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USE=
R);
>>>>> +       if (!cetregs)
>>>>> +               return -EFAULT;
>>>> Can this branch ever be hit without a kernel bug? If yes, I think
>>>> -EFAULT is probably a weird error code to choose here. If no, this
>>>> should probably use WARN_ON(). Same thing in cetregs_set().
>>>=20
>>> When a thread is not CET-enabled, its CET state does not exist.  I looke=
d at EFAULT, and it means "Bad address".  Maybe this can be ENODEV, which me=
ans "No such device"?

Having read the code, I=E2=80=99m unconvinced. It looks like a get_xsave_add=
r() failure means =E2=80=9Cstate not saved; task sees INIT state=E2=80=9D.  S=
o *maybe* it=E2=80=99s reasonable -ENODEV this, but I=E2=80=99m not really c=
onvinced. I tend to think we should return the actual INIT state and that we=
 should permit writes and handle them correctly.

Dave, what do you think?

>>>=20
>>> [...]
>>>=20
>>>>> @@ -1284,6 +1293,13 @@ static struct user_regset x86_32_regsets[] __ro=
_after_init =3D {
>>>> [...]
>>>>> +       [REGSET_CET32] =3D {
>>>>> +               .core_note_type =3D NT_X86_CET,
>>>>> +               .n =3D sizeof(struct cet_user_state) / sizeof(u64),
>>>>> +               .size =3D sizeof(u64), .align =3D sizeof(u64),
>>>>> +               .active =3D cetregs_active, .regset_get =3D cetregs_ge=
t,
>>>>> +               .set =3D cetregs_set
>>>>> +       },
>>>>>  };
>>>> Why are there different identifiers for 32-bit CET and 64-bit CET when
>>>> they operate on the same structs and have the same handlers? If
>>>> there's a good reason for that, the commit message should probably
>>>> point that out.
>>>=20
>>> Yes, the reason for two regsets is that fill_note_info() does not expect=
 any holes in a regsets.  I will put this in the commit log.
>>>=20
>>>=20
>> Perhaps we could fix that instead?
>=20
> As long as we understand the root cause, leaving it as-is may be OK.

The regset mechanism=E2=80=99s interactions with compat are awful. Let=E2=80=
=99s please not make it worse.  One CET regret is good; two is not good.

>=20
> I had a patch in the past, but did not follow up on it.
>=20
> https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/=

>=20
> Yu-cheng
