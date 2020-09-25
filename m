Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924DE278F17
	for <lists+linux-arch@lfdr.de>; Fri, 25 Sep 2020 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgIYQvS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Sep 2020 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgIYQvS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Sep 2020 12:51:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC008C0613D4
        for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2020 09:51:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d13so3081683pgl.6
        for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2020 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=4XOAAiIQRCCNU86tnCHCg8fQuqW/LCTSjYNlXVnzp2A=;
        b=X0DpLV6lbBuvB1scwWVNnCPJ80OMbFrr6SBJC0ex7XH+Ht2IzQxNvwOFji/qqPWGjF
         S5LnN+V0Xzbst7EJrAmht8e/NuEC2LQ3hryzKnae6jiw3KuTdH89kIZOv9crXVRpEV0d
         kztSv1hhTmHEUXwWQUnZ5aBZd3ET54DExUFdo08fB9vDiB1dqarhPK006pwMdCRR2Eet
         U0vFIe+YManXCc5WhujOi61ob2w/wPWE6BRy2GzmlbDNvzXBQ4ByT/RO4D0YSx/F75It
         5gN41S6u7ob0ZU2i4eqvy5ibWW8yTZ4WTFNAj1A588SY/4pzv09gKFujgnwCULdpsKNT
         Ee0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=4XOAAiIQRCCNU86tnCHCg8fQuqW/LCTSjYNlXVnzp2A=;
        b=b3pWCElte4GdO3Xh+i48jWrAdGTVd+UhFwdcGCEHe9+sxJWVLfj+adP8zgMgBiWnTw
         R7j4PMtJVOEzW9rByKNro7h6dZgS9zVmkdF0L2Q7lHyWY+E4n9y5Lt1ZmQn9vBUdUT12
         +3kzxWvqgirSpz9y0PPd8ElnAGT3F03+aEDp5WHnwCpxSAr8NK4yr8h5bBUxBiQk1j2z
         CbSXBBSzAvQQeIN7ftrC+7OrqCCRLysQQv3FZ8Jrf0XOJFjNTvJG8L0fTlkmoZR2yIvo
         MCqMxwhovA0XAOoJi86Vst3p0dbN3be3xq5rrgd077vcHfO2OO809kz2kIVuOV2puJB0
         BQAg==
X-Gm-Message-State: AOAM530glqc3nfQdjLRmrez5BXC+Q6vcs75HftkRzOIWQa5KNrUpq2Wp
        mcZX3KVXfkuODV+m2ngGfQCmgA==
X-Google-Smtp-Source: ABdhPJzmrvzRE0ItT8WGaJW6i9EQyNgQz1eC7YkG4/zQ1uzyIKPyWaVCi2nURst6I0Tm6/QcDV8Ebg==
X-Received: by 2002:a17:902:fe0e:b029:d1:e5ec:28d6 with SMTP id g14-20020a170902fe0eb02900d1e5ec28d6mr298326plj.66.1601052677488;
        Fri, 25 Sep 2020 09:51:17 -0700 (PDT)
Received: from localhost.localdomain (c-67-180-165-146.hsd1.ca.comcast.net. [67.180.165.146])
        by smtp.gmail.com with ESMTPSA id w185sm3382485pfc.36.2020.09.25.09.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 09:51:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and Indirect Branch Tracking for vsyscall emulation
Date:   Fri, 25 Sep 2020 09:51:14 -0700
Message-Id: <99B32E59-CFF2-4756-89BD-AEA0021F355F@amacapital.net>
References: <d0e4077e-129f-6823-dcea-a101ef626e8c@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
In-Reply-To: <d0e4077e-129f-6823-dcea-a101ef626e8c@intel.com>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
X-Mailer: iPhone Mail (18A373)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Sep 25, 2020, at 9:48 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>=20
> =EF=BB=BFOn 9/25/2020 9:31 AM, Andy Lutomirski wrote:
>>> On Fri, Sep 25, 2020 at 7:58 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrot=
e:
>>>=20
>=20
> [...]
>=20
>>> @@ -286,6 +289,37 @@ bool emulate_vsyscall(unsigned long error_code,
>>>         /* Emulate a ret instruction. */
>>>         regs->ip =3D caller;
>>>         regs->sp +=3D 8;
>>> +
>>> +#ifdef CONFIG_X86_CET
>>> +       if (tsk->thread.cet.shstk_size || tsk->thread.cet.ibt_enabled) {=

>>> +               struct cet_user_state *cet;
>>> +               struct fpu *fpu;
>>> +
>>> +               fpu =3D &tsk->thread.fpu;
>>> +               fpregs_lock();
>>> +
>>> +               if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
>>> +                       copy_fpregs_to_fpstate(fpu);
>>> +                       set_thread_flag(TIF_NEED_FPU_LOAD);
>>> +               }
>>> +
>>> +               cet =3D get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_U=
SER);
>>> +               if (!cet) {
>>> +                       fpregs_unlock();
>>> +                       goto sigsegv;
>> I *think* your patchset tries to keep cet.shstk_size and
>> cet.ibt_enabled in sync with the MSR, in which case it should be
>> impossible to get here, but a comment and a warning would be much
>> better than a random sigsegv.
>=20
> Yes, it should be impossible to get here.  I will add a comment and a warn=
ing, but still do sigsegv.  Should this happen, and the function return, the=
 app gets a control-protection fault.  Why not let it fail early?

I=E2=80=99m okay with either approach as long as we get a comment and warnin=
g.

>=20
>>=20
>> Shouldn't we have a get_xsave_addr_or_allocate() that will never
>> return NULL but instead will mark the state as in use and set up the
>> init state if the feature was previously not in use?
>=20
> We already have a static __raw_xsave_addr(), which returns a pointer to th=
e requested xstate.  Maybe we can export __raw_xsave_addr(), if that is need=
ed.

I don=E2=80=99t think that=E2=80=99s what we want in general =E2=80=94 we wa=
nt the whole construct of initializing the state if needed.=
