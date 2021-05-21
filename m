Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95438D179
	for <lists+linux-arch@lfdr.de>; Sat, 22 May 2021 00:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhEUW1y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 18:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhEUW1u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 May 2021 18:27:50 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B63C0613ED
        for <linux-arch@vger.kernel.org>; Fri, 21 May 2021 15:26:25 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id s7so5584676iov.2
        for <linux-arch@vger.kernel.org>; Fri, 21 May 2021 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/XkWG9p3vuThMnzF5+jHBK0yD8kKyiYj1CsPVcIZG2k=;
        b=NbxYYDnKLkoxAba68BqL9ZpD3lb2ScBJAQcY7Ca85CXetGoTwjl6vkFeBlTcN0YXWC
         cakB/2NABQKb7tNbJ2MKqdWXSJWkXwDc/wdJ8H7ra+iLPE55/qTgRwSHMrd07MrYUY75
         Kgl+MdH4q6qoh3P/D/eA9hwhI9aygyHy6++nMr5XZJFn3YbAGBkxb+ubQgrwI1dJD3OY
         9vRWqUhp82BhFUfhdlge9Gw7weWCJYd2vfR0waS4FJhMBieNYCihC9+e4aQthIz0cPw7
         nPcq/dSyh3TQ2iYZM3164IV6Hk3xNVVeEtw/KweHzEb/39DcVr+NmfeTkJfTD0gaB7bH
         HDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/XkWG9p3vuThMnzF5+jHBK0yD8kKyiYj1CsPVcIZG2k=;
        b=LbpSI7ifBbPoNSFjCuSQbj0g1HjNruF0bVKekcKJ/NF0vLXJ3XXGT8WC3tdBdAA7DP
         ofeHlcYBC17CFPDRoMzTaBodODqSckgF5sHHA4k4DiJ957AwPyAhqG9YaPacTtre94o/
         2JJFrzk6YqqVRa3QPPvG9Z/gbgKFmJb/3pGqhX2JMGKzL/vtwGh3XCQwXh+ZSsM1+TJE
         FyE5xhZebEGYTN2vqDqF3OUam26DCv4UhxB+yG84J6kiLL2KUs519Ev+5h9EV3nr7aKe
         90nZMuD6F3ZeK1ei16m4MBkA4SLWuex2b4ujzYmdXPx/9CaTyy4Qs6HPiRk3In3uIS5U
         sN6A==
X-Gm-Message-State: AOAM530j+Ld7KhIMHrjoKHtOw82Tm8JPCn7DfmhyF2uc9wHQwiKFrdSm
        7drdqZu82eaaV/sjyNl7v4I613mKM2HyKhPHuusJkA==
X-Google-Smtp-Source: ABdhPJzlwY4snWFXpxBlNWlDJVr5O/yWYAqwfXJReVJK7U77qf3035eHhy3r6Qq2WuRy8RNFs9VDtvKPjIC+Z+H1LKQ=
X-Received: by 2002:a02:aa85:: with SMTP id u5mr7968024jai.75.1621635984233;
 Fri, 21 May 2021 15:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210521221211.29077-1-yu-cheng.yu@intel.com> <20210521221211.29077-14-yu-cheng.yu@intel.com>
In-Reply-To: <20210521221211.29077-14-yu-cheng.yu@intel.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 21 May 2021 15:25:47 -0700
Message-ID: <CAJHvVcjsecq-nOVE1ew1ctG2UpK0F0d0MjNncUgK0L=R4eyDqA@mail.gmail.com>
Subject: Re: [PATCH v27 13/31] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This seems reasonable to me. The particular bit used isn't so
important from my perspective. I can't think of a way this would break
backward compatibility or such. So:

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

On Fri, May 21, 2021 at 3:13 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> To introduce VM_SHADOW_STACK as VM_HIGH_ARCH_BIT (37), and make all
> VM_HIGH_ARCH_BITs stay together, move VM_UFFD_MINOR_BIT from 37 to 38.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c274f75efcf9..923f89b9f1b5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -373,7 +373,7 @@ extern unsigned int kobjsize(const void *objp);
>  #endif
>
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> -# define VM_UFFD_MINOR_BIT     37
> +# define VM_UFFD_MINOR_BIT     38
>  # define VM_UFFD_MINOR         BIT(VM_UFFD_MINOR_BIT)  /* UFFD minor faults */
>  #else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>  # define VM_UFFD_MINOR         VM_NONE
> --
> 2.21.0
>
