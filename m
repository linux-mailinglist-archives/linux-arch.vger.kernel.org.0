Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE881365C0D
	for <lists+linux-arch@lfdr.de>; Tue, 20 Apr 2021 17:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhDTPVr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Apr 2021 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhDTPVq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Apr 2021 11:21:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078D3C06174A;
        Tue, 20 Apr 2021 08:21:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h15so8094826pfv.2;
        Tue, 20 Apr 2021 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IubIvA+FZc+EgYaLla1wNxM0Nrtj3DHof/IpDLSwAko=;
        b=I4yP89FRP5i2uxVxl6i5lyAw3mredKc46Hjeoi7O9yUplQ1n0j3Y0o1SaATIVNfyq4
         teur2VlRjebXnJrXtmJM5UKcyINF7y9nt7eJ4h2Nj9VKcW4SDr7ASpYqevicADvLjSpZ
         BcdUWRI28kdfl/QTUrSbHWrX4bxcKg5kigsvPFmraKk01TgCjRpIdrWz8rCxHFi/mdal
         s4BKA5FrT8bg+QmBXI5iysCGKPMPo2xeM4LNJb3Mzab1E/x16D7j6SnHvvknf4k5KLD+
         UqDskbF3E4p7if1FPMyCFMP8IPbcI/hh0NmL9fW95RDqIIZlVko2His34l8P33AB9Kyv
         EjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IubIvA+FZc+EgYaLla1wNxM0Nrtj3DHof/IpDLSwAko=;
        b=TQBHOiHzFIkxl5NhxtCzM8qNSnB5sLh4BHghLmmnbAyg+f6Nly9PpqkceG8S6vy7y1
         cvZzP+U71/kc5NKhIULvEGftlIupfsPhTulYHZVhA7AEZfviPfurPgma9tRaY2OLM0Vk
         rbl2YJxfRuN15dYKR+IVl5DsC5IywsvedUankyTA8ciTq/LEeYYDC920jDFVkO2hCCyr
         4QAHqeCV/rxBLtoT5zDsmFJZx9F9pDu+oHv7GTEvRK4bdl9JFy022kFshh919m4JGjus
         OlYtlhrfFKVdTtMLuEpvNGmCP31XhF4L6V36NEKXAaWO5ckQ/dzpYBpvJXW+lOZ/x27e
         k2Eg==
X-Gm-Message-State: AOAM531ab7kn17PFO6KQA+/hRomQEj9BZWbsV9xReRRVZO8zaztvbA8a
        w5pIClat6xdD1s8BsxsHnnky1G7qtStPQqDcC6OeGQG+sdI=
X-Google-Smtp-Source: ABdhPJzGghpoDCwO9kK2QCglkrPkmiAPcjJ3yQECzehAQ/Rh2Lt07/rbOaMl18l4ndllh1JWFu8ageLFbFdjGhXx2wQ=
X-Received: by 2002:a62:ed0f:0:b029:257:7278:e72b with SMTP id
 u15-20020a62ed0f0000b02902577278e72bmr24791289pfh.17.1618932074554; Tue, 20
 Apr 2021 08:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <1618925829-90071-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1618925829-90071-1-git-send-email-guoren@kernel.org>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 20 Apr 2021 23:20:37 +0800
Message-ID: <CAEbi=3fdKep_szy3jNYZrDr847avKYTHOQyNoUm5vy5ijv7Z0w@mail.gmail.com>
Subject: Re: [PATCH 1/3] nds32: Cleanup deprecated function strlen_user
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

<guoren@kernel.org> =E6=96=BC 2021=E5=B9=B44=E6=9C=8820=E6=97=A5 =E9=80=B1=
=E4=BA=8C =E4=B8=8B=E5=8D=889:38=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> $ grep strlen_user * -r
> arch/csky/include/asm/uaccess.h:#define strlen_user(str) strnlen_user(str=
, 32767)
> arch/csky/lib/usercopy.c: * strlen_user: - Get the size of a string in us=
er space.
> arch/ia64/lib/strlen.S: // Please note that in the case of strlen() as op=
posed to strlen_user()
> arch/mips/lib/strnlen_user.S: *  make strlen_user and strnlen_user access=
 the first few KSEG0
> arch/nds32/include/asm/uaccess.h:extern __must_check long strlen_user(con=
st char __user * str);
> arch/nios2/include/asm/uaccess.h:extern __must_check long strlen_user(con=
st char __user *str);
> arch/riscv/include/asm/uaccess.h:extern long __must_check strlen_user(con=
st char __user *str);
> kernel/trace/trace_probe_tmpl.h:static nokprobe_inline int fetch_store_st=
rlen_user(unsigned long addr);
> kernel/trace/trace_probe_tmpl.h:                        ret +=3D fetch_st=
ore_strlen_user(val + code->offset);
> kernel/trace/trace_uprobe.c:fetch_store_strlen_user(unsigned long addr)
> kernel/trace/trace_kprobe.c:fetch_store_strlen_user(unsigned long addr)
> kernel/trace/trace_kprobe.c:            return fetch_store_strlen_user(ad=
dr);
>
> See grep result, nobody uses it.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/nds32/include/asm/uaccess.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/ua=
ccess.h
> index 010ba5f..d4cbf06 100644
> --- a/arch/nds32/include/asm/uaccess.h
> +++ b/arch/nds32/include/asm/uaccess.h
> @@ -260,7 +260,6 @@ do {                                                 =
                       \
>
>  extern unsigned long __arch_clear_user(void __user * addr, unsigned long=
 n);
>  extern long strncpy_from_user(char *dest, const char __user * src, long =
count);
> -extern __must_check long strlen_user(const char __user * str);
>  extern __must_check long strnlen_user(const char __user * str, long n);
>  extern unsigned long __arch_copy_from_user(void *to, const void __user *=
 from,
>                                             unsigned long n);

Thank you, Guo.
Acked-by: Greentime Hu <green.hu@gmail.com>
