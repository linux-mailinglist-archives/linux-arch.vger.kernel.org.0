Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9618E37EB6
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 22:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfFFU15 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 16:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfFFU15 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 16:27:57 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E634208E4
        for <linux-arch@vger.kernel.org>; Thu,  6 Jun 2019 20:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559852876;
        bh=V7Uq2AYQOlpquEHSKTkBWDviou8MRCFEnqb/lAamoAk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ci44e+1HjYkBXHk1NXaSKaCK1CuA9I7JHv13wyv1lEnO/sidJI4tB6xS6yrL8RyS4
         u1c38WXLlfjZOrTvgSqTEJ1fe0gBzGjB9GSQBqk9RYWMj7SGnOV8OTBZSJy9XfJr6z
         mc+nJ+Htrap+uCUHep75lsy4tzge8nmCXsv3MFek=
Received: by mail-wm1-f51.google.com with SMTP id a15so1189111wmj.5
        for <linux-arch@vger.kernel.org>; Thu, 06 Jun 2019 13:27:56 -0700 (PDT)
X-Gm-Message-State: APjAAAUHGix8oRbweZ1ZlQ1h0MaXwZlgfr9NeH8CbxAriQJHIjm81JRI
        Sc3FVwQFsMpfhv156vvX+S8S+SlK0ER/pSz45boZlg==
X-Google-Smtp-Source: APXvYqw4QxWNcnpeIW5dyukxUpCDU5vd9HJGUulP8KUyfEWWyRle1lYXjWBak+DMiNxJGFv5DZOd/i/pJ6NTOXQuXA4=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr1192848wmj.79.1559852874993;
 Thu, 06 Jun 2019 13:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-13-yu-cheng.yu@intel.com>
In-Reply-To: <20190606200926.4029-13-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Jun 2019 13:27:43 -0700
X-Gmail-Original-Message-ID: <CALCETrXfBCFKB2SwhEngABPCkAfgmb+YkRL3Xx3-=haN9H+V_g@mail.gmail.com>
Message-ID: <CALCETrXfBCFKB2SwhEngABPCkAfgmb+YkRL3Xx3-=haN9H+V_g@mail.gmail.com>
Subject: Re: [PATCH v7 12/14] x86/vsyscall/64: Fixup shadow stack and branch
 tracking for vsyscall
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 6, 2019 at 1:17 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> When emulating a RET, also unwind the task's shadow stack and cancel
> the current branch tracking status.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/entry/vsyscall/vsyscall_64.c | 28 +++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index d9d81ad7a400..6869ef9d1e8b 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -38,6 +38,8 @@
>  #include <asm/fixmap.h>
>  #include <asm/traps.h>
>  #include <asm/paravirt.h>
> +#include <asm/fpu/xstate.h>
> +#include <asm/fpu/types.h>
>
>  #define CREATE_TRACE_POINTS
>  #include "vsyscall_trace.h"
> @@ -92,6 +94,30 @@ static int addr_to_vsyscall_nr(unsigned long addr)
>         return nr;
>  }
>
> +void fixup_shstk(void)
> +{
> +#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> +       u64 r;
> +
> +       if (current->thread.cet.shstk_enabled) {
> +               rdmsrl(MSR_IA32_PL3_SSP, r);
> +               wrmsrl(MSR_IA32_PL3_SSP, r + 8);
> +       }
> +#endif
> +}
> +
> +void fixup_ibt(void)
> +{
> +#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
> +       u64 r;
> +
> +       if (current->thread.cet.ibt_enabled) {
> +               rdmsrl(MSR_IA32_U_CET, r);
> +               wrmsrl(MSR_IA32_U_CET, r & ~MSR_IA32_CET_WAIT_ENDBR);
> +       }
> +#endif
> +}

These should be static.

But please just inline them directly in their one call site.  The code
will be a lot easier to understand.

--Andy
