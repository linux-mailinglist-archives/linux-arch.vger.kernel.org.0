Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58EA109554
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2019 23:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKYWCR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Nov 2019 17:02:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37208 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWCR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 17:02:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so1027901wmf.2
        for <linux-arch@vger.kernel.org>; Mon, 25 Nov 2019 14:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Siahvh+RN3JBEPcY4HC2+CrgvWiJj3EvQGXrV37Qh98=;
        b=OII9ZI9714IwrXeLwLBmD9Fm3xINuYGIwm/zdiM4hVqMNOvJzvHBrTOaO9oCxqJWNl
         NnRc2IwxqqIW3JOqV2GPtQcZKWySxkxABl/ANwwFkGV/gktuObcZpym2Xxtc3DuGgl6b
         inLGqqN0uuTi/p+yoQ2ZjMKn18X/zXpRYWovB3tyND7hMUyuDHdwuli6tq153X5qdjT4
         /Qz+MQg7BYndlixqPLXdr0vVJRHLa6FjHCP8ErNripInhAVwwcgugrkYSszGIbtRZ3pI
         bfeeEPo47PVepMQFqCwWVx3lgT/YclmgwPWPtAoUPVfz8qaGs3xCybFA04320iSZ9au6
         QElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Siahvh+RN3JBEPcY4HC2+CrgvWiJj3EvQGXrV37Qh98=;
        b=i2Qa2i4rtZPgajodRpfPYqfgK0qJABEg3VZfHjMLs0LTpKUWRcF56d+NyZ0yo+Ojh9
         3hJ8pdFuvYHNhO5stBpvMwzmy164ngMnSJTZmL/EYxYiFPRj4DFk7A8iQgxb8KZ1BIY5
         PCgtIuF8K9gkQ5qWSJ8EehJAy6UjUX/XQJEc0qQhPoHyYo3KVVdq4h7Hj5WCwTkfqlxK
         XhVTz2BE4aQNgt+ZsplDrWB6WLvgXYU1CvJuyRyc4NRU+JJ21Zj/erhkoRYFiTLi5iik
         EQKNHVBBR8C38HqNLxHSa1M1/DoWZciBiIS0XMNAsaa7PjTbHesNtKayM4D0oXAZbgHs
         pmYg==
X-Gm-Message-State: APjAAAV5bO+NxQwC220sflsLAJuTVeb0Hk04sdkJVhV3glPSii6hUF2u
        0TlZFTac+unoejtKR0Zt3MN+ejfz02Co34mW2gc=
X-Google-Smtp-Source: APXvYqz9JiXDbAZQRCTwuOtVpnuyn/5fzZTQ/dslF6XeKtqpYlrUBUQQCjcIfdaQytFhopC9JO8xKbddtaKLAcsr7e0=
X-Received: by 2002:a1c:3c86:: with SMTP id j128mr849466wma.137.1574719335520;
 Mon, 25 Nov 2019 14:02:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com> <3ed3c306fc51b0073fcf3a222f7314fcaf50ccf4.1573179553.git.thehajime@gmail.com>
In-Reply-To: <3ed3c306fc51b0073fcf3a222f7314fcaf50ccf4.1573179553.git.thehajime@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 25 Nov 2019 23:02:04 +0100
Message-ID: <CAFLxGvzXv7pHaY8i_RBs2BL5qHLMQJO97MWGF5cnh34kmeGZJg@mail.gmail.com>
Subject: Re: [RFC v2 01/37] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
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
> With CONFIG_64BIT enabled, atomic64 via CONFIG_GENERIC_ATOMIC64 options
> are not compiled due to type conflict of atomic64_t defined in
> linux/type.h.
>
> This commit fixes the issue and allow using generic atomic64 ops.

Hmm, why is this specific to LKL?
This need a review from core developers.

> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
> ---
>  include/asm-generic/atomic64.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> index 370f01d4450f..9b15847baae5 100644
> --- a/include/asm-generic/atomic64.h
> +++ b/include/asm-generic/atomic64.h
> @@ -9,9 +9,11 @@
>  #define _ASM_GENERIC_ATOMIC64_H
>  #include <linux/types.h>
>
> +#ifndef CONFIG_64BIT
>  typedef struct {
>         s64 counter;
>  } atomic64_t;
> +#endif
>
>  #define ATOMIC64_INIT(i)       { (i) }
>
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
