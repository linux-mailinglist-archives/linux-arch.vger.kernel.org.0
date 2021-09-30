Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD75641DDE6
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345907AbhI3Prz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 11:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345751AbhI3Prz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Sep 2021 11:47:55 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F56DC06176C
        for <linux-arch@vger.kernel.org>; Thu, 30 Sep 2021 08:46:12 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id e16so6052001qte.13
        for <linux-arch@vger.kernel.org>; Thu, 30 Sep 2021 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8d6xo5L9QevHc/0Sduv9NQkae1fLgboqRLN/cOlHL94=;
        b=iR/rfVgiWHq5rw4NLK5OT9v5lYhcLGBGwNqvqBTHa8uM0K3LSI6Qds40sZdhqy343D
         nKF1AalapkTkhy/ypRBVypdug7o8/xaqtmHaWv9UPFEGjb1UhHpm/4rTjAiBbtASwfKx
         3JH/kVbQPqPEjk5/0bNv7k1/Y2BIonRHJ0vWOSQM3zvPY70Uxrv2rSgTrqGgUv6GDu7E
         chrKKhinXiSRYk/xsds2GtV3wz6HxpGI4jq2FDoKpBIlG6t+6bi34LoQK0m5uh10NjJQ
         5mDPrpUbvxQNLMegc4nJJFYKUu1kf5g3ZYgnxHtFO6ahoMuizo6fqj2+osS40oUSZmZK
         mhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8d6xo5L9QevHc/0Sduv9NQkae1fLgboqRLN/cOlHL94=;
        b=N1YTXlAVkNfuHe7Gpc+k5v8ff/WCJr0RPfLuIgYysG+iAtkYLPhkboT4DDBf3vbns5
         /sD1lIPK+8hZIefbjcLL0IP31rjDjWIEDRSRQY+4OQoyr6ZJiYknCcxtJ84ueNrdyaXf
         8hyIjTg9UQmXvgajH6am2U71vB69HWPhOmdSfSWWlD86nTE6TTV3StPJ7wE2WgZ9bQZK
         rucNpnX5HeYPrsgbaIo/IYjxL7q+5GWkpwRY76EQc1GM32y9rNvtn12SbLqXXGrOqwO8
         tlqoeCq+oHlNRbZ9lTLIthyv/zhu2A0KCbOY2oQvtW92aXznkAniOi5b3d08tow3uihH
         8lfg==
X-Gm-Message-State: AOAM530nv+YnGWi6dAHU/ZumkIRmjrXFvrlCBUf4N0OA3wwGiQsYeVTU
        vasoidMQ+WQZWFGpIIaIrtJU+kbXXmhjuCSluezN/g==
X-Google-Smtp-Source: ABdhPJwZ3uxL8AigS1SCTssbBbBxtSyTYvRLlSFXF7X1iRF0BIcI7ZsH6TQi0ZjmX4wm1iehH5EIvAVb3aaD1X5z2aM=
X-Received: by 2002:ac8:5ed1:: with SMTP id s17mr7389237qtx.196.1633016771378;
 Thu, 30 Sep 2021 08:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210930071143.63410-1-wangkefeng.wang@huawei.com> <20210930071143.63410-8-wangkefeng.wang@huawei.com>
In-Reply-To: <20210930071143.63410-8-wangkefeng.wang@huawei.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 30 Sep 2021 17:45:35 +0200
Message-ID: <CAG_fn=XD+nVgVRgj7KFsPWSuia+gZzpA3KAdqucjKodOvxSF6w@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] mm: kasan: Use is_kernel() helper
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, bpf@vger.kernel.org,
        linux-alpha@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 30, 2021 at 9:09 AM Kefeng Wang <wangkefeng.wang@huawei.com> wr=
ote:
>
> Directly use is_kernel() helper in kernel_or_module_addr().
>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/kasan/report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 3239fd8f8747..1c955e1c98d5 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -226,7 +226,7 @@ static void describe_object(struct kmem_cache *cache,=
 void *object,
>
>  static inline bool kernel_or_module_addr(const void *addr)
>  {
> -       if (addr >=3D (void *)_stext && addr < (void *)_end)
> +       if (is_kernel((unsigned long)addr))
>                 return true;
>         if (is_module_address((unsigned long)addr))
>                 return true;
> --
> 2.26.2
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
