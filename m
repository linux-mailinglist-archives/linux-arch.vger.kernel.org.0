Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321EB25B507
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 22:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgIBUEH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 16:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgIBUEC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Sep 2020 16:04:02 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877B4C061247
        for <linux-arch@vger.kernel.org>; Wed,  2 Sep 2020 13:04:01 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id d26so499457ejr.1
        for <linux-arch@vger.kernel.org>; Wed, 02 Sep 2020 13:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F516FSLG1Fg8AtLKWaugsZmUz1NztosX6XlYqbdsuWY=;
        b=f6Y2z+4eUCL25q5+1hV+JdNT5QdsgtJQm4tYO85DSSJSP6ZbhVl0Pu/DGRtriAVW+b
         WfP1t1YBGF9QBZamybjj9qIxqSYyBtWhFH+UNdEsL5i46u/W/nO3/DaUVi8nknD45c6h
         dQmMY6/P3s7DaNBO12JbCBxZsP/wuCG5/ZPos3Yi4GFKwWHFNFcBd24JwwQsnu+v+meI
         WccDRMkKFTcytzbZsyNJYl4UWpZa3uO5ENrpsL8JMWimpV6NgRkETZKsp6Je7IDQx/14
         ZrGlSRPKBZHel/NtVFdQkQrr+l9Bnc9XSYPUtsdV77DkGFS9r+kfiSpO/cYOf/QQxkZV
         3PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F516FSLG1Fg8AtLKWaugsZmUz1NztosX6XlYqbdsuWY=;
        b=eNS7yPq+Ck7PseeBDdAi7TA1hDLzzz0GBiICM5qpEO3I21moNSWdaUdh9OdKYWM5Ik
         hWurYEjXsBnXHlfNS28gVGGjOb/j2la5LCze2HNXYMTLA9invlAQUe+F9rqKhfOYKkFE
         Zkst7o5Ey/6B4M81nPjfnlPtY1aIUqt7Py3pZS+0mIQeTpRvz2sAy/mY02Gs5fVJvxYJ
         yvdUTCE7d+tDmcY4Kj9bk1uT1ntnrS0V8FyZvMYYwl+EIBm8jx1kY2t/DwQEe+MMi6E9
         ctL2CX8KMwKT9PSxVxjlfcQxRLTJSs1gTRCgtRWOgMx2M7n0NB4rhRxiLcY62Nq1nslc
         OcrA==
X-Gm-Message-State: AOAM532cZSGy89a1L+IwIJrlaP3/5I/glXacEWlsF1tgFKIF2ozOAHFf
        A3ILAj/0NdFVUMVnfJX55ms7l+bI4i7yhR+PSbSpzQ==
X-Google-Smtp-Source: ABdhPJwnWyiUGJ5BXUL9kg40H50dxwEYKvN25v96OuWjX6DKbErT05o6VXF3YX5pYXjmTfRVQSjnap/k1SenzliIvsE=
X-Received: by 2002:a17:906:4088:: with SMTP id u8mr1814815ejj.184.1599077039554;
 Wed, 02 Sep 2020 13:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200825002645.3658-1-yu-cheng.yu@intel.com> <20200825002645.3658-7-yu-cheng.yu@intel.com>
In-Reply-To: <20200825002645.3658-7-yu-cheng.yu@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 2 Sep 2020 22:03:33 +0200
Message-ID: <CAG48ez21a_afHJrRQeweuHu8c+fxJ+VN1dezD18UOtZA5q-Shg@mail.gmail.com>
Subject: Re: [PATCH v11 6/9] x86/cet: Add PTRACE interface for CET
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 25, 2020 at 2:30 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> Add REGSET_CET64/REGSET_CET32 to get/set CET MSRs:
>
>     IA32_U_CET (user-mode CET settings) and
>     IA32_PL3_SSP (user-mode Shadow Stack)
[...]
> diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
[...]
> +int cetregs_get(struct task_struct *target, const struct user_regset *regset,
> +               struct membuf to)
> +{
> +       struct fpu *fpu = &target->thread.fpu;
> +       struct cet_user_state *cetregs;
> +
> +       if (!boot_cpu_has(X86_FEATURE_SHSTK))
> +               return -ENODEV;
> +
> +       fpu__prepare_read(fpu);
> +       cetregs = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
> +       if (!cetregs)
> +               return -EFAULT;

Can this branch ever be hit without a kernel bug? If yes, I think
-EFAULT is probably a weird error code to choose here. If no, this
should probably use WARN_ON(). Same thing in cetregs_set().

> +       return membuf_write(&to, cetregs, sizeof(struct cet_user_state));
> +}
[...]
> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
[...]
> @@ -52,7 +52,9 @@ enum x86_regset {
>         REGSET_IOPERM64 = REGSET_XFP,
>         REGSET_XSTATE,
>         REGSET_TLS,
> +       REGSET_CET64 = REGSET_TLS,
>         REGSET_IOPERM32,
> +       REGSET_CET32,
>  };
[...]
> @@ -1229,6 +1231,13 @@ static struct user_regset x86_64_regsets[] __ro_after_init = {
[...]
> +       [REGSET_CET64] = {
> +               .core_note_type = NT_X86_CET,
> +               .n = sizeof(struct cet_user_state) / sizeof(u64),
> +               .size = sizeof(u64), .align = sizeof(u64),
> +               .active = cetregs_active, .regset_get = cetregs_get,
> +               .set = cetregs_set
> +       },
>  };
[...]
> @@ -1284,6 +1293,13 @@ static struct user_regset x86_32_regsets[] __ro_after_init = {
[...]
> +       [REGSET_CET32] = {
> +               .core_note_type = NT_X86_CET,
> +               .n = sizeof(struct cet_user_state) / sizeof(u64),
> +               .size = sizeof(u64), .align = sizeof(u64),
> +               .active = cetregs_active, .regset_get = cetregs_get,
> +               .set = cetregs_set
> +       },
>  };

Why are there different identifiers for 32-bit CET and 64-bit CET when
they operate on the same structs and have the same handlers? If
there's a good reason for that, the commit message should probably
point that out.
