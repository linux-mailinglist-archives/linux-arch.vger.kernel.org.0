Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6CA21D35B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 12:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgGMKDW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 06:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbgGMKDW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 06:03:22 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378B8C061755;
        Mon, 13 Jul 2020 03:03:22 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id u8so5489390qvj.12;
        Mon, 13 Jul 2020 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1Bp6ooBnl29LgQwgRasRlGwvso/97p63GtfZ5PiBQTw=;
        b=fR22FJr528HTbVr5yiXlhTnjGckWEGpRvUrfyASmhnDxv6mvCczdyorbQCxUHO6G3T
         4q9ZBdkP1yjgEj59VZVCDj3VFcZoXzLjOoDn1Sg23HMGi7cxs1/9ml3IHiBW9nmjM1zc
         pNrmqAneD7xhJynGDsNTRlI1VUgbs41JNz+qsasrr9rHx87rYwUsMWmfGGfXHcfVomWh
         bwB6J+Za2xh4yLI4L8YNvnNJ7IMLIIcK1+qjgA6EW5lnnUWakEqyRj5uAbPQt2XyOULt
         Jb3sjcmmLgcspQ1IAkGNLXyykglmsY4ZKOAPw56zJmk3NggmDBfeFJFjIa5vGF4KA7hL
         cOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Bp6ooBnl29LgQwgRasRlGwvso/97p63GtfZ5PiBQTw=;
        b=aULHB2++DmBR5+W4m1UAM/vXZl2+bnf7qm2y9mGNcpnkOlhhHtddOgqQxPuhMrMAII
         JjcdKdPPsPXDl6SR30p9D6IQnGEPskthUL28STEhUEwr6Wi7KOTSCPS0lZh3AqYJZq7m
         QeaeetN/uYaCLohVOEbZ3ddZkjFz82tpYC/0/aYaD2RW7RblQr4tLmYB2O5tYcz/DEOQ
         jDXedpImcTMIcZTVjsBFysmMb2JGvFoo5o1XzC0gUwNhNn4ubfG8KBuko3nis9SD6o/C
         Yxn/uvRVcV0hbQeWzWggs4N+5es6VVpN4V9x4/M8XZTxIlC7OfqMIBw1/gHLhMu6j9iY
         LA3g==
X-Gm-Message-State: AOAM533vttyxJFXb2mU8LkAreWNx7zKonKU6bXSPbLvBuJoJ1sgbS+Rq
        q/yDp2AsnThYfr47q2oEVwgWSIl3bFzBSBeFaDw=
X-Google-Smtp-Source: ABdhPJyG9JgXRd06w9jCyfF/WDMYIp+vUYSvmAwfGAEme8KlkS+YHZBhN5qetyJzGOkuVRlY4lr0HRKihqYP5EOwdVo=
X-Received: by 2002:a0c:fe01:: with SMTP id x1mr77159663qvr.246.1594634601328;
 Mon, 13 Jul 2020 03:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200710135706.537715-1-hch@lst.de> <20200710135706.537715-3-hch@lst.de>
In-Reply-To: <20200710135706.537715-3-hch@lst.de>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Mon, 13 Jul 2020 18:02:44 +0800
Message-ID: <CAEbi=3dKwDQ5-wdxQagX2n5Z3tYeYwTcmDNqxPH=83Dy-VKA1w@mail.gmail.com>
Subject: Re: [PATCH 2/6] nds32: use uaccess_kernel in show_regs
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christoph Hellwig <hch@lst.de> =E6=96=BC 2020=E5=B9=B47=E6=9C=8810=E6=97=A5=
 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Use the uaccess_kernel helper instead of duplicating it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/nds32/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
> index 9712fd474f2ca3..f06265949ec28b 100644
> --- a/arch/nds32/kernel/process.c
> +++ b/arch/nds32/kernel/process.c
> @@ -121,7 +121,7 @@ void show_regs(struct pt_regs *regs)
>                 regs->uregs[3], regs->uregs[2], regs->uregs[1], regs->ure=
gs[0]);
>         pr_info("  IRQs o%s  Segment %s\n",
>                 interrupts_enabled(regs) ? "n" : "ff",
> -               segment_eq(get_fs(), KERNEL_DS)? "kernel" : "user");
> +               uaccess_kernel() ? "kernel" : "user");
>  }
>
>  EXPORT_SYMBOL(show_regs);

Hi Christoph, Thank you.
Acked-by: Greentime Hu <green.hu@gmail.com>
