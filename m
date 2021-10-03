Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6AF420316
	for <lists+linux-arch@lfdr.de>; Sun,  3 Oct 2021 19:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhJCRVM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Oct 2021 13:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhJCRVL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Oct 2021 13:21:11 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AECC0613EC;
        Sun,  3 Oct 2021 10:19:23 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p80so17603158iod.10;
        Sun, 03 Oct 2021 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LtNAm7zzl2qrgZZh/QTIxNxuRAfc7I+2wFFQB9vnTF0=;
        b=HPajL2gRll5UGOWQudiLfEhv04bZJLEY04ZU7ZSRAIC019LPw99IB3jcVbN4EN+uaa
         xyKMFFwUWxMYSoP4ZBJywqtND/RYthdauADK8DHtR06cFEMk7vPzapNi8yp+/BQqu9DS
         XOr3DnKVtkoe0wPl/79bKfHiDibk91+zdv0sLCel9UFYLCb9bmD47OsCKSwE0mGDtw8/
         6gdgpENhRKndxirmzsgGPXX1upChcdibaOTNC3bq+DmwPpNVd9cFYYXmPAmiOvESIXbo
         CSbSXebOc4mMaPqb0Px805lEkzhdOgcnojNc1+KreKV66iyssiTwe6WqQz88OHS1mJw/
         GXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LtNAm7zzl2qrgZZh/QTIxNxuRAfc7I+2wFFQB9vnTF0=;
        b=OlJvNQS4Y84OZTjs29lxUhu7NVJXGBUBlDEKWR77L5beT9+YJbW6ZE6vsZhKSORaNu
         Zjk7+snQ7f8+yIOuq594x7JkqAbRLCLUvMSZoxYfjtT6Fy3mM7PRGEZXBLn9E31o5Ii4
         pZJU3bUZ1KkQ1xCg9PnW0Yz0Mt8k9mPFRKQlMGiZw9Z8KxNum2RFQAJzx8kvd6+MITby
         +LUKlCmGPfmvWe6fp6px09cLOLoT9HjL8jLm6H/nYmOROprlbIWMhuskijP2ZHQTpipr
         8uIRvN1pmjqdFjwYVwVnFYR4R36YDceS+dptD32PcjJnyG1dhEK5kvB4nNLLvqOvUSni
         IGrA==
X-Gm-Message-State: AOAM530kCN3EUHHI7U5xQ2AzGAH6ur52saDb7ZLGzN6gc14eVZaeiig/
        E97KBM4k6Ot70DKFQGYBmN4GxfWf4Cov0KNNNBM=
X-Google-Smtp-Source: ABdhPJzE8E4NG+zryoNkkGJT+VnCZOOENDmogYIeJjU1ZUgffAvfm3SvEG54YtnyET4C9tYQXAL12Yepc0ZqQhXt644=
X-Received: by 2002:a05:6602:214f:: with SMTP id y15mr6480548ioy.127.1633281563293;
 Sun, 03 Oct 2021 10:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210930071143.63410-1-wangkefeng.wang@huawei.com> <20210930071143.63410-8-wangkefeng.wang@huawei.com>
In-Reply-To: <20210930071143.63410-8-wangkefeng.wang@huawei.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 3 Oct 2021 19:19:12 +0200
Message-ID: <CA+fCnZd6=sXgb-782KkijqJ7zgBj38oXLeLbi4HoUhm3MY4J8g@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] mm: kasan: Use is_kernel() helper
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        bpf <bpf@vger.kernel.org>, linux-alpha@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 30, 2021 at 9:09 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Directly use is_kernel() helper in kernel_or_module_addr().
>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/kasan/report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 3239fd8f8747..1c955e1c98d5 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -226,7 +226,7 @@ static void describe_object(struct kmem_cache *cache, void *object,
>
>  static inline bool kernel_or_module_addr(const void *addr)
>  {
> -       if (addr >= (void *)_stext && addr < (void *)_end)
> +       if (is_kernel((unsigned long)addr))
>                 return true;
>         if (is_module_address((unsigned long)addr))
>                 return true;
> --
> 2.26.2
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
