Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D08532B59
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2019 11:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfFCJDn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jun 2019 05:03:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34150 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfFCJDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2019 05:03:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id l17so15383417otq.1
        for <linux-arch@vger.kernel.org>; Mon, 03 Jun 2019 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VCvRg4+mMJ/yKzCQebn8clHJnLDYyzYIHqLnBJ4zrI=;
        b=H/dToC9rVgyO60IieVWtYVTFQ1+mQqRSqm7v+uDMC1JFRW6hoq3rdcMjJGt9aQAIaH
         mvwyuRkWbUoNOyCBYn6MwVr6/BdJhcTk06MVITyowa6mOgyUH9nBiAvZtjtGzy2TTkda
         EAF67zsrU7hR7HeHdu/j+sq2s3b8F9Icz0URNmQ1Rh17LYo05PTttkSfR1u2coSXZRtQ
         tqZZJCE1G1U4VD7OF+rDL6FcRsoI1FklrQXZiMF2/4vOHdaaiTaGerKo7Cs+Inh712v9
         uB61H8IfL5Wmv7x9BdPISh8Mu7FAQiQ8nbHfWItpIqQV08wnaeX6MA4FCit0UuEXiTwb
         8j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VCvRg4+mMJ/yKzCQebn8clHJnLDYyzYIHqLnBJ4zrI=;
        b=GiZn2ErLHXI50Oo+KsoCAupo6sCyBLGJVAROiyPRcht/Yc7nwaIR+gRiZeneHJ7I06
         F+A0slwqRF00UgetVY9RS4Eknr18iJ6fgtFwgrWTy9wMyRz0jfMWckKeAeWw+h2jVeSd
         L0OyFCoaIJd4AZEc/kVbG30W0P/Mw2yNWwG1xiZigdaI0W1dKI6CjIx7toY/xNC70r3i
         hYcQDgIPoN7JdWJ++GeE1KsUhrO5Pruk5yEN5KqJZ6uMBc4sjbke0hXVe0WuR3pZti1c
         Y6SjUWi120+LHA0xODLB9QwOAc61A/pQTsHi0c+p3rmvGBIjJUBLiFSg70Q60tZYKKxh
         KomA==
X-Gm-Message-State: APjAAAW4u9tPSRp+1LCMgQcO4HXmHSnO/RmgehLJw2Ky2rJQfV3ENTQB
        8N40ap/BLVEbaURpID/DrlDZz/fMVBg5Hh7eL9pO/w==
X-Google-Smtp-Source: APXvYqzgegu9IcBC8sASS/9V/OPbAvth7UyhRrha31CWInyM6XSL4/wuA+jy2xZziSKYavPoDOqnLF4KhOatOj4Biuw=
X-Received: by 2002:a05:6830:1688:: with SMTP id k8mr378583otr.233.1559552622037;
 Mon, 03 Jun 2019 02:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190529141500.193390-1-elver@google.com> <20190529141500.193390-3-elver@google.com>
 <EE911EC6-344B-4EB2-90A4-B11E8D96BEDC@zytor.com> <CANpmjNOsPnVd50cTzUW8UYXPGqpSnRLcjj=JbZraTYVq1n18Fw@mail.gmail.com>
 <3B49EF08-147F-451C-AA5B-FC4E1B8568EE@zytor.com>
In-Reply-To: <3B49EF08-147F-451C-AA5B-FC4E1B8568EE@zytor.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 3 Jun 2019 11:03:30 +0200
Message-ID: <CANpmjNMt8QK+j6yo8ut1UNe0wS3_B4iqG5N_eTmJcWj4TpZaDQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86: Move CPU feature test out of uaccess region
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks for the clarification.

I found that static_cpu_has was replaced by static_cpu_has_safe:
https://lkml.org/lkml/2016/1/24/29 -- so is it fair to assume that
both are equally safe at this point?

I have sent a follow-up patch which uses static_cpu_has:
http://lkml.kernel.org/r/20190531150828.157832-3-elver@google.com

Many thanks!
-- Marco

On Sat, 1 Jun 2019 at 03:13, <hpa@zytor.com> wrote:
>
> On May 31, 2019 2:57:36 AM PDT, Marco Elver <elver@google.com> wrote:
> >On Wed, 29 May 2019 at 16:29, <hpa@zytor.com> wrote:
> >>
> >> On May 29, 2019 7:15:00 AM PDT, Marco Elver <elver@google.com> wrote:
> >> >This patch is a pre-requisite for enabling KASAN bitops
> >> >instrumentation:
> >> >moves boot_cpu_has feature test out of the uaccess region, as
> >> >boot_cpu_has uses test_bit. With instrumentation, the KASAN check
> >would
> >> >otherwise be flagged by objtool.
> >> >
> >> >This approach is preferred over adding the explicit kasan_check_*
> >> >functions to the uaccess whitelist of objtool, as the case here
> >appears
> >> >to be the only one.
> >> >
> >> >Signed-off-by: Marco Elver <elver@google.com>
> >> >---
> >> >v1:
> >> >* This patch replaces patch: 'tools/objtool: add kasan_check_* to
> >> >  uaccess whitelist'
> >> >---
> >> > arch/x86/ia32/ia32_signal.c | 9 ++++++++-
> >> > 1 file changed, 8 insertions(+), 1 deletion(-)
> >> >
> >> >diff --git a/arch/x86/ia32/ia32_signal.c
> >b/arch/x86/ia32/ia32_signal.c
> >> >index 629d1ee05599..12264e3c9c43 100644
> >> >--- a/arch/x86/ia32/ia32_signal.c
> >> >+++ b/arch/x86/ia32/ia32_signal.c
> >> >@@ -333,6 +333,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal
> >> >*ksig,
> >> >       void __user *restorer;
> >> >       int err = 0;
> >> >       void __user *fpstate = NULL;
> >> >+      bool has_xsave;
> >> >
> >> >       /* __copy_to_user optimizes that into a single 8 byte store
> >*/
> >> >       static const struct {
> >> >@@ -352,13 +353,19 @@ int ia32_setup_rt_frame(int sig, struct
> >ksignal
> >> >*ksig,
> >> >       if (!access_ok(frame, sizeof(*frame)))
> >> >               return -EFAULT;
> >> >
> >> >+      /*
> >> >+       * Move non-uaccess accesses out of uaccess region if not
> >strictly
> >> >+       * required; this also helps avoid objtool flagging these
> >accesses
> >> >with
> >> >+       * instrumentation enabled.
> >> >+       */
> >> >+      has_xsave = boot_cpu_has(X86_FEATURE_XSAVE);
> >> >       put_user_try {
> >> >               put_user_ex(sig, &frame->sig);
> >> >               put_user_ex(ptr_to_compat(&frame->info),
> >&frame->pinfo);
> >> >               put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
> >> >
> >> >               /* Create the ucontext.  */
> >> >-              if (boot_cpu_has(X86_FEATURE_XSAVE))
> >> >+              if (has_xsave)
> >> >                       put_user_ex(UC_FP_XSTATE,
> >&frame->uc.uc_flags);
> >> >               else
> >> >                       put_user_ex(0, &frame->uc.uc_flags);
> >>
> >> This was meant to use static_cpu_has(). Why did that get dropped?
> >
> >I couldn't find any mailing list thread referring to why this doesn't
> >use static_cpu_has, do you have any background?
> >
> >static_cpu_has also solves the UACCESS warning.
> >
> >If you confirm it is safe to change to static_cpu_has(), I will change
> >this patch. Note that I should then also change
> >arch/x86/kernel/signal.c to mirror the change for 32bit  (although
> >KASAN is not supported for 32bit x86).
> >
> >Thanks,
> >-- Marco
>
> I believe at some point the intent was that boot_cpu_has() was safer and could be used everywhere.
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
