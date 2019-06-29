Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F115ADC9
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jun 2019 01:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfF2XpI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jun 2019 19:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfF2XpI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Jun 2019 19:45:08 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FEF4217D6
        for <linux-arch@vger.kernel.org>; Sat, 29 Jun 2019 23:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561851907;
        bh=NO9SldPrvEHCV9L05HomDu1WyC6FUgdLlHc97KSTRsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L9zsQCD3SME4yCdiZ91gR5mu3dTU7iHytvauDPWLVWJ5PVYhrkz4Xa1e7uv4wAgV3
         dn6A6uxhscIfZ/fM0Q/M50uV8Zprd9O/fI/u2BZF1R7eLQPpJWxVUZ9macy7ZQ9u1d
         B6qcP8VfgVBU5+U66FxTgTcWis+nQEC2Uneo6t/g=
Received: by mail-wm1-f44.google.com with SMTP id v19so12253647wmj.5
        for <linux-arch@vger.kernel.org>; Sat, 29 Jun 2019 16:45:06 -0700 (PDT)
X-Gm-Message-State: APjAAAWsUieAYehw+GvA17HuSMEJbrhb3qWKrqGcZcodQ710+HTXq0ZW
        0uYk/aRFL5DIjCE1fOjanCTest/OZI/gz/d+u7yLJA==
X-Google-Smtp-Source: APXvYqw7AqV0riQVWfNq9DWyOR0lQPRhOlZu5oCeDxSJhE/lHbPusIgX678jLiDRugcnqjeaEdrl0RkDIaMs4WKe0VE=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr11059844wme.173.1561851905663;
 Sat, 29 Jun 2019 16:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190628194158.2431-1-yu-cheng.yu@intel.com> <20190628194158.2431-3-yu-cheng.yu@intel.com>
In-Reply-To: <20190628194158.2431-3-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 29 Jun 2019 16:44:54 -0700
X-Gmail-Original-Message-ID: <CALCETrXsXXJWTSJxUO8YxHUo=QJKmHyJa7iz+jOBjWMRhno4rA@mail.gmail.com>
Message-ID: <CALCETrXsXXJWTSJxUO8YxHUo=QJKmHyJa7iz+jOBjWMRhno4rA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] Prevent user from writing to IBT bitmap.
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

On Fri, Jun 28, 2019 at 12:50 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> The IBT bitmap is visiable from user-mode, but not writable.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>
> ---
>  arch/x86/mm/fault.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 59f4f66e4f2e..231196abb62e 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1454,6 +1454,13 @@ void do_user_addr_fault(struct pt_regs *regs,
>          * we can handle it..
>          */
>  good_area:
> +#define USER_MODE_WRITE (FAULT_FLAG_WRITE | FAULT_FLAG_USER)
> +       if (((flags & USER_MODE_WRITE)  == USER_MODE_WRITE) &&
> +           (vma->vm_flags & VM_IBT)) {
> +               bad_area_access_error(regs, hw_error_code, address, vma);
> +               return;
> +       }
> +

Just make the VMA have VM_WRITE and VM_MAYWRITE clear.  No new code
like this should be required.
