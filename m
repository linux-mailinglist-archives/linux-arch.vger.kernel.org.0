Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A06109559
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2019 23:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfKYWDI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Nov 2019 17:03:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39479 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKYWDI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 17:03:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id t26so1017588wmi.4
        for <linux-arch@vger.kernel.org>; Mon, 25 Nov 2019 14:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EzOmcmNHJdjS3Y2PaRjjbyy934rGJTZugK/pwbwbb3g=;
        b=nsPsx6SfKAY6dgvf13xQZCtgM7ygn595xGFhwvE0B5tLMUyxzkVIzPDDalMPq4E/2O
         hrv7hVxohXzwZML1VYhQ25BklRdZ3oC1vwb/i9EBWJH92VNPM3jtSSkRt0BHVISzYeFI
         bdjI7VC8P1mVt+hcYqW+I6Hc5J94s5m2nIRqUdoGTMAfLls7/XlcCYWUuRTT3zep89aW
         lZzx4duyXy9AIlmmJZsDtTTmP4E39prAe6wN8nf4S66LTjZv1++CzHYJoCkHhzOD+a+8
         naykuQ6AAntIjJoCeFUgT5Fm+Cgqf4F+6GxHnmLGztggfBd+hMg8QchZmlLglUIdUmuP
         hUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EzOmcmNHJdjS3Y2PaRjjbyy934rGJTZugK/pwbwbb3g=;
        b=hOdyebi6UvBW2BhcwGQqcUVGIsdI7zt6b/yZdAI7i4OU0tLLT5X8Osud/YdfH6VHbi
         /ENOt4zZ0I5UQTl+JhaAU0sx6gIo9XnfmreLUl7l+dWriIsDXjghoNs5u0TYtsv7g+Nw
         07KoQZBmTJuWxHiKZmsOPhGdzPYMdGGh5tVti+I6U5gsWq0qhne/jbxxfUJXbpXT75eU
         TTBxLr1MarP4zNP14IxNGUOqmJGjVabSyF5TzLlvZ+dPZosNYh1O3qj/2ydeDDa7Z/IH
         mpEkkpKi5irUqNV68QsACEbK+jE9QrrvEFFXs+1mj15ha/NeZC24bldEkZYdKDxjJi8x
         pwaA==
X-Gm-Message-State: APjAAAXLUxApP1PevASCDLryekzS8xRs/60e+H4egvdo0L7cQUNY/OnX
        DuAdnKJlCgSUkD7eJ0hUuDRw56txnXbfXxwgTsc=
X-Google-Smtp-Source: APXvYqyOvmJ23ZWAdclliOXwtrLgKRKOlnx7ntGHWUeymvVxt4BIF0v2s6A8/PBlYSukX7GFyJlFqwB+brTCEY1aU3Y=
X-Received: by 2002:a1c:8055:: with SMTP id b82mr903209wmd.176.1574719385674;
 Mon, 25 Nov 2019 14:03:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com> <d2d52cac3eff859b8cef0bc755cb6ae4590f27a6.1573179553.git.thehajime@gmail.com>
In-Reply-To: <d2d52cac3eff859b8cef0bc755cb6ae4590f27a6.1573179553.git.thehajime@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 25 Nov 2019 23:02:54 +0100
Message-ID: <CAFLxGvyQhi+uKoAv34RE8LSgQMLGwDEWgCT4un1K_-mMvz29vA@mail.gmail.com>
Subject: Re: [RFC v2 02/37] arch: add __SYSCALL_DEFINE_ARCH
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org,
        Octavian Purdila <tavi.purdila@gmail.com>,
        linux-kernel-library@freelists.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> This allows the architecture code to process the system call
> definitions. It is used by LKL to create strong typed function
> definitions for system calls.
>
> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
> ---
>  include/linux/syscalls.h | 6 ++++++

Same here, core developers need to agree on this.

>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 88145da7d140..77e52fe19923 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -203,9 +203,14 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>  }
>  #endif
>
> +#ifndef __SYSCALL_DEFINE_ARCH
> +#define __SYSCALL_DEFINE_ARCH(x, sname, ...)
> +#endif
> +
>  #ifndef SYSCALL_DEFINE0
>  #define SYSCALL_DEFINE0(sname)                                 \
>         SYSCALL_METADATA(_##sname, 0);                          \
> +       __SYSCALL_DEFINE_ARCH(0, _##sname);                     \
>         asmlinkage long sys_##sname(void);                      \
>         ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);              \
>         asmlinkage long sys_##sname(void)
> @@ -222,6 +227,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>
>  #define SYSCALL_DEFINEx(x, sname, ...)                         \
>         SYSCALL_METADATA(sname, x, __VA_ARGS__)                 \
> +       __SYSCALL_DEFINE_ARCH(x, sname, __VA_ARGS__)            \
>         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>
>  #define __PROTECT(...) asmlinkage_protect(__VA_ARGS__)
> --
> 2.20.1 (Apple Git-117)
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um



-- 
Thanks,
//richard
