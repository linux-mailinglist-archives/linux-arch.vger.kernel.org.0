Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBD52318DA
	for <lists+linux-arch@lfdr.de>; Sat,  1 Jun 2019 03:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfFABOT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 21:14:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33931 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbfFABOS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 May 2019 21:14:18 -0400
Received: from [IPv6:2607:fb90:3627:8679:c06a:8bb1:5a73:12ff] ([IPv6:2607:fb90:3627:8679:c06a:8bb1:5a73:12ff])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x511DX2t3668045
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 31 May 2019 18:13:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x511DX2t3668045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559351616;
        bh=CuGVe8YH5AlNt8m91Od8n8Cr+8ORd3+2zjg1HKvHIqA=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=Afsfgv0m4+6nQxKJuvaCREopIJhg9RquRuWXyShM9f4gSzVKBGcGZjyzmgEfgFlj0
         mcUniwOsDbu16hpWSYQUE1wK1C58Mh/WrErLuP5lijCcS5KLiY/22+XUHVQH+PJgch
         VoA+Le5ADa09H73d4upQ2g41TzL8LBvO0bPI2T/wE0exTFdyxnMVoe8ihAAvJj/72X
         klPaRjEsJ2LR5SsmHXzLqqfm3kx3F1N+7awmYfLl0FvbrypOXDvP+mPx5sVFdlFEn7
         pSE5cWaKyAOabuY+3m0gKKaWSBp6W1hTGm3c82BukTCNJl+4snoq0aPDBsF8sguVM9
         ZUnpB7cZS/vkA==
Date:   Fri, 31 May 2019 16:41:46 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CANpmjNOsPnVd50cTzUW8UYXPGqpSnRLcjj=JbZraTYVq1n18Fw@mail.gmail.com>
References: <20190529141500.193390-1-elver@google.com> <20190529141500.193390-3-elver@google.com> <EE911EC6-344B-4EB2-90A4-B11E8D96BEDC@zytor.com> <CANpmjNOsPnVd50cTzUW8UYXPGqpSnRLcjj=JbZraTYVq1n18Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] x86: Move CPU feature test out of uaccess region
To:     Marco Elver <elver@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
From:   hpa@zytor.com
Message-ID: <3B49EF08-147F-451C-AA5B-FC4E1B8568EE@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On May 31, 2019 2:57:36 AM PDT, Marco Elver <elver@google=2Ecom> wrote:
>On Wed, 29 May 2019 at 16:29, <hpa@zytor=2Ecom> wrote:
>>
>> On May 29, 2019 7:15:00 AM PDT, Marco Elver <elver@google=2Ecom> wrote:
>> >This patch is a pre-requisite for enabling KASAN bitops
>> >instrumentation:
>> >moves boot_cpu_has feature test out of the uaccess region, as
>> >boot_cpu_has uses test_bit=2E With instrumentation, the KASAN check
>would
>> >otherwise be flagged by objtool=2E
>> >
>> >This approach is preferred over adding the explicit kasan_check_*
>> >functions to the uaccess whitelist of objtool, as the case here
>appears
>> >to be the only one=2E
>> >
>> >Signed-off-by: Marco Elver <elver@google=2Ecom>
>> >---
>> >v1:
>> >* This patch replaces patch: 'tools/objtool: add kasan_check_* to
>> >  uaccess whitelist'
>> >---
>> > arch/x86/ia32/ia32_signal=2Ec | 9 ++++++++-
>> > 1 file changed, 8 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/arch/x86/ia32/ia32_signal=2Ec
>b/arch/x86/ia32/ia32_signal=2Ec
>> >index 629d1ee05599=2E=2E12264e3c9c43 100644
>> >--- a/arch/x86/ia32/ia32_signal=2Ec
>> >+++ b/arch/x86/ia32/ia32_signal=2Ec
>> >@@ -333,6 +333,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal
>> >*ksig,
>> >       void __user *restorer;
>> >       int err =3D 0;
>> >       void __user *fpstate =3D NULL;
>> >+      bool has_xsave;
>> >
>> >       /* __copy_to_user optimizes that into a single 8 byte store
>*/
>> >       static const struct {
>> >@@ -352,13 +353,19 @@ int ia32_setup_rt_frame(int sig, struct
>ksignal
>> >*ksig,
>> >       if (!access_ok(frame, sizeof(*frame)))
>> >               return -EFAULT;
>> >
>> >+      /*
>> >+       * Move non-uaccess accesses out of uaccess region if not
>strictly
>> >+       * required; this also helps avoid objtool flagging these
>accesses
>> >with
>> >+       * instrumentation enabled=2E
>> >+       */
>> >+      has_xsave =3D boot_cpu_has(X86_FEATURE_XSAVE);
>> >       put_user_try {
>> >               put_user_ex(sig, &frame->sig);
>> >               put_user_ex(ptr_to_compat(&frame->info),
>&frame->pinfo);
>> >               put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
>> >
>> >               /* Create the ucontext=2E  */
>> >-              if (boot_cpu_has(X86_FEATURE_XSAVE))
>> >+              if (has_xsave)
>> >                       put_user_ex(UC_FP_XSTATE,
>&frame->uc=2Euc_flags);
>> >               else
>> >                       put_user_ex(0, &frame->uc=2Euc_flags);
>>
>> This was meant to use static_cpu_has()=2E Why did that get dropped?
>
>I couldn't find any mailing list thread referring to why this doesn't
>use static_cpu_has, do you have any background?
>
>static_cpu_has also solves the UACCESS warning=2E
>
>If you confirm it is safe to change to static_cpu_has(), I will change
>this patch=2E Note that I should then also change
>arch/x86/kernel/signal=2Ec to mirror the change for 32bit  (although
>KASAN is not supported for 32bit x86)=2E
>
>Thanks,
>-- Marco

I believe at some point the intent was that boot_cpu_has() was safer and c=
ould be used everywhere=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
