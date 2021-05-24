Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B460838E221
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 10:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhEXIEu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 04:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhEXIEu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 May 2021 04:04:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F99C061574
        for <linux-arch@vger.kernel.org>; Mon, 24 May 2021 01:03:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b7so13822205wmh.5
        for <linux-arch@vger.kernel.org>; Mon, 24 May 2021 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+lXZOkJT9ztp2JCl1bPRf8G039aIWHo+Vabd2KIAvY=;
        b=hE15bhqpuXbPdzqAazrfGMf6jpdb7Plfzzuf8Tg3BA6zCx8evuNi5OahN0lBSi6jy0
         gmL2pDkRxR+V6YGQV9V5IG0mTSsDV2iuox0/5/1IQawdULfqWvOg6DWh4BJg4fEGeK2E
         J2AQpGvMaXThT16y4SiEJuhqSbiUyYR3D+56Ik012/2/YQXTxBpjo/ebQAUY/pqFLjxY
         BcdjFYg6YKXxY2YcIZEYYwL+gRPsD5CEaNAlKZvfXvlhshNwe8bLJc/Nr73JUMDjdOQK
         ParA5bj6PXKxhEZ0fHTy1lfN+l7xXY9cQCLdHYnZ95OIjte1+fWjOUXB5M0A8iL1NkqS
         qU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+lXZOkJT9ztp2JCl1bPRf8G039aIWHo+Vabd2KIAvY=;
        b=OYEyOYpV2MJmavCjUI0LskfAot7hIC4O744ksQBBKgeaOh4p5T2+2kMhtmcOniuX2L
         O3Rhj7iwqSgr+sc3FpeIykmuklvXCMi14igW2Ja/rw0pKI+Oa6MpwBSDfsQbQt6Ybvh6
         UI/aPdW1etzU6ZkdE0oTKNmWK6zzLeMh6xe06doH9HEYfy/Yzw/w3IO6spzRSMXYtJnn
         JlD40i9t1wzJwBsHSWPjsXGDcw6y0G6l2/9YEc7HXbbjGCurBbJvX5AJAmjsOaZrwiak
         /WSt6JOZwHCj9N28j3vnYXgHgl5M0dfTzH9L/LuYZjpo0rQmUrPA8QVFdWAbGGqSDD5S
         MaAw==
X-Gm-Message-State: AOAM531bNCZKBFls1qe8Wt1+AxifYi2Ftz6Z4D4G945LEYSxzm3VuiHh
        yr7pnbZy08wncuVtdxrCkt4i6HA3Up155lElOUOkCw==
X-Google-Smtp-Source: ABdhPJyeURrTyE53pS9rjIrF1XyAYSlM5EIDZxsof/N3+lCkEYOm64yTb06OT7Z706TpnIKNx0pnoQ13EAD6f/Q4bPA=
X-Received: by 2002:a05:600c:b44:: with SMTP id k4mr19148969wmr.152.1621843400672;
 Mon, 24 May 2021 01:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <1621839068-31738-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1621839068-31738-1-git-send-email-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 24 May 2021 13:33:08 +0530
Message-ID: <CAAhSdy3ORUGqyL-9oMQCKYCXnG8M=xrZ8q+AiWg8s+v6zsk=_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: Fixup _PAGE_GLOBAL in _PAGE_KERNEL
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 24, 2021 at 12:22 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Kernel virtual address translation should avoid care asid or it'll
> cause more TLB-miss and TLB-refill. Because the current asid in satp
> belongs to the current process, but the target kernel va TLB entry's
> asid still belongs to the previous process.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>

First of all thanks for doing this series, I had similar changes in mind
as follow-up to the ASID allocator.

I went through all three patches and at least I don't see any
obvious issue but I think we should try testing it more on a few
existing platforms.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/pgtable.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 78f2323..017da15 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -135,6 +135,7 @@
>                                 | _PAGE_PRESENT \
>                                 | _PAGE_ACCESSED \
>                                 | _PAGE_DIRTY \
> +                               | _PAGE_GLOBAL \
>                                 | _PAGE_CACHE)
>
>  #define PAGE_KERNEL            __pgprot(_PAGE_KERNEL)
> --
> 2.7.4
>
