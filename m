Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952AA25B769
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 01:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgIBXuh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 19:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgIBXuh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Sep 2020 19:50:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF386C061245
        for <linux-arch@vger.kernel.org>; Wed,  2 Sep 2020 16:50:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t9so678569pfq.8
        for <linux-arch@vger.kernel.org>; Wed, 02 Sep 2020 16:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=52j/Kh79WBTwfCoci6XyBRUD0B5MrM8lpRUZ53T6r6c=;
        b=is7KTIIg8tnyCVnXfRHW1zqu9WguvoK7VRQR0tcUVAhWNNnMt0afpmuqoSXKKDOqQ2
         lOAO+TSk5rH+E7grKoBSNXbOHUuujEINvuG0qGnZKYpTmhU6vdxg5CRkRTu1rYsU8etp
         18pwy0I0t8kxPw8tKuAkCYqCzyVFtBHogFDkbnP3g71YES9KWo4Llyc8PmixfyY9wyTq
         771YhdsEiYuR47KHutTFgf8C9HN9WcWKl23JavtyLkVdK2crr9obWC7v51eS1llbQ2Wv
         ZuPHC6zfpgTgxSwa+hRNbyOb+chRDJPOp8Co0swB/PVLeYptrdTFdIwobjnPq+6zfp9Z
         QJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=52j/Kh79WBTwfCoci6XyBRUD0B5MrM8lpRUZ53T6r6c=;
        b=duxlBbCCmbiJb3WzIK5z5XdfcEjbPpjucxD0vBP+MTdnDgzlqlg0n4yteVL07yMsI/
         OlNi1DuCeezWOgMLM2KlWSb0lprZK1oR1xc1Q5PhcGmJtxcdOIbPsxeYOqPZ4F1EVOna
         y/Pav+dAgJiDwM+B65kn9DKO1O1JHYS0YnWn1w4uSrIrNhLhTEgR7UyqyjsxTbElGAJs
         UwaoBeIASr7wWlF84pqitg56wNXQN/mXuMXK6jawjI8ASqEZ58TZBx4kTGiRPQ95PYCo
         Ozl5TGvcr9VRQHE3A4jkYp9HClOSQ4T1zYxyXuCqq04yprRIQIAoZMPyqZOmQpP3PtfX
         +RRw==
X-Gm-Message-State: AOAM533zbojL5vOJmREPsscVqZEmDo++sUSTBzBQFahSy33/4XkYO9/B
        9qWkkzXKOui7Zko5B977zDPEzw==
X-Google-Smtp-Source: ABdhPJzcvbgMHad+9bJRLvEwY0z3UAPXv89W/kGnXTDgXpqQW7lWsFy98cFptbURQTTLl+POUxJDqw==
X-Received: by 2002:aa7:9f50:: with SMTP id h16mr849195pfr.178.1599090635689;
        Wed, 02 Sep 2020 16:50:35 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:2197:2a30:2ff8:e80a? ([2601:646:c200:1ef2:2197:2a30:2ff8:e80a])
        by smtp.gmail.com with ESMTPSA id o15sm427033pgi.74.2020.09.02.16.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 16:50:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v11 6/9] x86/cet: Add PTRACE interface for CET
Date:   Wed, 2 Sep 2020 16:50:32 -0700
Message-Id: <A7775E11-8837-4727-921A-C88566FA01AF@amacapital.net>
References: <9be5356c-ec51-4541-89e5-05a1727a09a8@intel.com>
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
In-Reply-To: <9be5356c-ec51-4541-89e5-05a1727a09a8@intel.com>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
X-Mailer: iPhone Mail (17G80)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Sep 2, 2020, at 3:13 PM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>=20
> =EF=BB=BFOn 9/2/2020 1:03 PM, Jann Horn wrote:
>>> On Tue, Aug 25, 2020 at 2:30 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrot=
e:
>>> Add REGSET_CET64/REGSET_CET32 to get/set CET MSRs:
>>>=20
>>>     IA32_U_CET (user-mode CET settings) and
>>>     IA32_PL3_SSP (user-mode Shadow Stack)
>> [...]
>>> diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c=

>> [...]
>>> +int cetregs_get(struct task_struct *target, const struct user_regset *r=
egset,
>>> +               struct membuf to)
>>> +{
>>> +       struct fpu *fpu =3D &target->thread.fpu;
>>> +       struct cet_user_state *cetregs;
>>> +
>>> +       if (!boot_cpu_has(X86_FEATURE_SHSTK))
>>> +               return -ENODEV;
>>> +
>>> +       fpu__prepare_read(fpu);
>>> +       cetregs =3D get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER)=
;
>>> +       if (!cetregs)
>>> +               return -EFAULT;
>> Can this branch ever be hit without a kernel bug? If yes, I think
>> -EFAULT is probably a weird error code to choose here. If no, this
>> should probably use WARN_ON(). Same thing in cetregs_set().
>=20
> When a thread is not CET-enabled, its CET state does not exist.  I looked a=
t EFAULT, and it means "Bad address".  Maybe this can be ENODEV, which means=
 "No such device"?
>=20
> [...]
>=20
>>> @@ -1284,6 +1293,13 @@ static struct user_regset x86_32_regsets[] __ro_a=
fter_init =3D {
>> [...]
>>> +       [REGSET_CET32] =3D {
>>> +               .core_note_type =3D NT_X86_CET,
>>> +               .n =3D sizeof(struct cet_user_state) / sizeof(u64),
>>> +               .size =3D sizeof(u64), .align =3D sizeof(u64),
>>> +               .active =3D cetregs_active, .regset_get =3D cetregs_get,=

>>> +               .set =3D cetregs_set
>>> +       },
>>>  };
>> Why are there different identifiers for 32-bit CET and 64-bit CET when
>> they operate on the same structs and have the same handlers? If
>> there's a good reason for that, the commit message should probably
>> point that out.
>=20
> Yes, the reason for two regsets is that fill_note_info() does not expect a=
ny holes in a regsets.  I will put this in the commit log.
>=20
>=20

Perhaps we could fix that instead?=
