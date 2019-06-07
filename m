Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90BC38273
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 03:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfFGBzB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 21:55:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38058 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfFGBzA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jun 2019 21:55:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so275403pgl.5
        for <linux-arch@vger.kernel.org>; Thu, 06 Jun 2019 18:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/XNZ/gn51wIkX7j4GJydFoEsiDY7sJR4sMnUtxZM9Ww=;
        b=S00yQNLRvIJQua4YR2yQ8RVqPpjOLFHnBiFwSeuMasOSY6c6h0vWJcYdiY0Z5PM7YO
         UipjM0ZF3UJgTbpzpruGqkllwmSh27VqFfBLmFFRQi48/y8vwP9lfsfd1fCr5GrWmx5U
         +mrmTnh77qX/LJSmeUNVANIViSYH3SG9JLjQyxwvqhhXs4F5aW2xz3ZH+yMIfMncHUn7
         BZCifuSpPT/N5rehXs3PF3WLzPimeqB/ooyW1/Bai8dhKtLnZ1mXZqIsmM2S1UwixE+q
         zrtDne+gd7Z1LmEC/CuXvREAfd8SGdoCJ9NGUyq3IAdCLPX1ELUdL2u8V6EHYI+JY9jt
         x5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/XNZ/gn51wIkX7j4GJydFoEsiDY7sJR4sMnUtxZM9Ww=;
        b=TXbzReP40XKFjMr7n/dDz42xteUAdFeuN/Hz1WsDGTa6dPJpLRhxPSdnjAdCxV45SH
         8pzCEJ/9IjR/zs0GKlwtIVu/6r2+FE3znt/G68WwGm/KJ1wy+2njuW5kmU8ZyvGqXWeE
         wEVr2Oqw9gYBJVvWtV6flTka/R7ptX/OdkIiTZmXVQyaxfHRBu80T23T58PgMeWlZq1t
         UtS8pXzFljcFL1p06DZhNbB57DvxuT5vVQb9zxiPchx8PXdTuH7eownTzuBuQWLbcSjW
         cKdDpgQ2P8qL2tjtFKLjxGWRifCU18fUvtWdYAvNbULonQj5LFj+itanK0zqVh/KyLV5
         cFww==
X-Gm-Message-State: APjAAAXzughczDT8fHQV+9+tMH4K3Pck0SnzyvPmhO2J7X09KZARQojL
        p1NbpiQAhmyAj1x8yZqsCG2pIA==
X-Google-Smtp-Source: APXvYqxx9s4fm3uOOHPSgMwgRlcgiy2DYwvEjaAWxVGCEthCLU5MAxClyI51h2SMQiGI5Wkj9aU4lw==
X-Received: by 2002:a65:508b:: with SMTP id r11mr631484pgp.387.1559872499664;
        Thu, 06 Jun 2019 18:54:59 -0700 (PDT)
Received: from ?IPv6:2600:1010:b02c:95e1:658b:ab88:7a44:1879? ([2600:1010:b02c:95e1:658b:ab88:7a44:1879])
        by smtp.gmail.com with ESMTPSA id w190sm391940pgw.51.2019.06.06.18.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 18:54:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 04/27] x86/fpu/xstate: Introduce XSAVES system states
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <4effb749-0cdc-6a49-6352-7b2d4aa7d866@intel.com>
Date:   Thu, 6 Jun 2019 18:54:56 -0700
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2F0417F1-DA1E-4632-AFA2-757C09B3C4B4@amacapital.net>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com> <20190606200646.3951-5-yu-cheng.yu@intel.com> <0a2f8b9b-b96b-06c8-bae0-b78b2ca3b727@intel.com> <5EE146A8-6C8C-4C5D-B7C0-AB8AD1012F1E@amacapital.net> <4effb749-0cdc-6a49-6352-7b2d4aa7d866@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jun 6, 2019, at 3:08 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
>=20
>=20
> On 6/6/19 3:04 PM, Andy Lutomirski wrote:
>>> But, that seems broken.  If we have supervisor state, we can't=20
>>> always defer the load until return to userspace, so we'll never??=20
>>> have TIF_NEED_FPU_LOAD.  That would certainly be true for=20
>>> cet_kernel_state.
>>=20
>> Ugh. I was sort of imagining that we would treat supervisor state
> completely separately from user state.  But can you maybe give
> examples of exactly what you mean?

I was imagining a completely separate area in memory for supervisor states. =
 I guess this might defeat the modified optimization and is probably a bad i=
dea.

>>=20
>>> It seems like we actually need three classes of XSAVE states: 1.=20
>>> User state
>>=20
>> This is FPU, XMM, etc, right?
>=20
> Yep.
>=20
>>> 2. Supervisor state that affects user mode
>>=20
>> User CET?
>=20
> Yep.
>=20
>>> 3. Supervisor state that affects kernel mode
>>=20
>> Like supervisor CET?  If we start doing supervisor shadow stack, the=20
>> context switches will be real fun.  We may need to handle this in=20
>> asm.
>=20
> Yeah, that's what I was thinking.
>=20
> I have the feeling Yu-cheng's patches don't comprehend this since
> Sebastian's patches went in after he started working on shadow stacks.

Do we need to have TIF_LOAD_FPU mean =E2=80=9Cwe need to load *some* of the x=
save state=E2=80=9D?  If so, maybe a bunch of the accessors should have thei=
r interfaces reviewed to make sure they=E2=80=99re sill sensible.

>=20
>> Where does PKRU fit in?  Maybe we can treat it as #3?
>=20
> I thought Sebastian added specific PKRU handling to make it always
> eager.  It's actually user state that affect kernel mode. :)

Indeed.  But, if we document a taxonomy of states, we should make sure it fi=
ts in. I guess it=E2=80=99s like supervisor CET except that user code can ca=
n also read and write it.

We should probably have self tests that make sure that the correct states, a=
nd nothing else, show up in ptrace and signal states, and that trying to wri=
te supervisor CET via ptrace and sigreturn is properly rejected.

Just to double check my mental model: it=E2=80=99s okay to XSAVES twice to t=
he same buffer with disjoint RFBM as long as we do something intelligent wit=
h XSTATE_BV afterwards, right?  Because, unless we split up the buffers, I t=
hink we will have to do this when we context switch while TIF_LOAD_FPU is se=
t.

Are there performance numbers for how the time needed to XRSTORS everything v=
ersus the time to XRSTORS supervisor CET and then separately XRSTORS the FPU=
?  This may affect whether we want context switches to have the new task eag=
erly or lazily restored.

Hmm. I wonder if we need some way for a selftest to reliably trigger TIF_LOA=
D_FPU.

=E2=80=94Andy=
