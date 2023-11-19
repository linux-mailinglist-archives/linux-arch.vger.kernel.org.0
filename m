Return-Path: <linux-arch+bounces-276-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4517F0882
	for <lists+linux-arch@lfdr.de>; Sun, 19 Nov 2023 20:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40E4280C48
	for <lists+linux-arch@lfdr.de>; Sun, 19 Nov 2023 19:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F182579;
	Sun, 19 Nov 2023 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B519EA4;
	Sun, 19 Nov 2023 11:34:30 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5c9169300caso12670567b3.2;
        Sun, 19 Nov 2023 11:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700422470; x=1701027270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adTtj6Nuat+3kPZs0twhHhp0MgcrTsqJHcTyGQnaplM=;
        b=tRSIiG2RMs4wXZEi9Lv4GsIEzPx0E5S9Vow2Ewv3CXBHZDtl9voroXC//387PtDN4c
         Kv7gY9WJpJ0v+TbBDJw/w1X+ZYjdCetv9tHRSZA1YleTO7aq1yJP1+nKGgzMkirKC+X9
         wyrWWPIIUuuww5wtfbkmR9VzyuANeJL7/ec7vDjzTiQFEKQGRmeYpFRxay7s+rFEAD/r
         JQSuGLw4zWrPtWqkWW/HAGqGvvQo0aCSxzoygOlUnuHAOevyZvLMTtaqWiCcTpFiqxLr
         nQqwALAX2K7ELKXDZGlGRV+8XSLop4ZkJchN2pAY2HxK21uleuJXLuTvwWyJjtA1guaX
         pqkA==
X-Gm-Message-State: AOJu0YwT/3UFyRdFXwowGx+eRVS8ibprmmXWcP9CkeNFs5gWuZ1u2j0G
	Gt+BPAIMy4Jx5ZrGreMPf2YpqMWNhGdg6A==
X-Google-Smtp-Source: AGHT+IHRGAmYwxfdBbSD1094cjJKxMqRnAoPvUG0JNV65/DztmKQtHNYcd1s9a1d3zMDoa/+dYCtlQ==
X-Received: by 2002:a81:4742:0:b0:5a7:d937:6f27 with SMTP id u63-20020a814742000000b005a7d9376f27mr5036802ywa.19.1700422469793;
        Sun, 19 Nov 2023 11:34:29 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id c7-20020a81df07000000b005a815346d95sm1863106ywn.71.2023.11.19.11.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 11:34:27 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ca8c606bb7so1057327b3.1;
        Sun, 19 Nov 2023 11:34:27 -0800 (PST)
X-Received: by 2002:a0d:e004:0:b0:5a8:207b:48d with SMTP id
 j4-20020a0de004000000b005a8207b048dmr5075104ywe.11.1700422467692; Sun, 19 Nov
 2023 11:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118100827.1599422-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20231118100827.1599422-1-wangkefeng.wang@huawei.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 19 Nov 2023 20:34:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+MMiogx6TcBwxFL7AODZYhiAZpVHiafEBfnRsDaXTog@mail.gmail.com>
Message-ID: <CAMuHMdU+MMiogx6TcBwxFL7AODZYhiAZpVHiafEBfnRsDaXTog@mail.gmail.com>
Subject: Re: [PATCH] asm/io: remove unnecessary xlate_dev_mem_ptr() and unxlate_dev_mem_ptr()
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Russell King <linux@armlinux.org.uk>, Brian Cain <bcain@quicinc.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, 
	Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 11:09=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawe=
i.com> wrote:
> The asm-generic/io.h already has default definition, remove unnecessary
> arch's defination.
>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Brian Cain <bcain@quicinc.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

>  arch/m68k/include/asm/io_mm.h  | 6 ------

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  arch/sh/include/asm/io.h       | 7 -------

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -548,13 +548,6 @@ extern void (*_dma_cache_inv)(unsigned long start, u=
nsigned long size);
>  #define csr_out32(v, a) (*(volatile u32 *)((unsigned long)(a) + __CSR_32=
_ADJUST) =3D (v))
>  #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) + __CSR_32_=
ADJUST))
>
> -/*
> - * Convert a physical pointer to a virtual kernel pointer for /dev/mem
> - * access
> - */
> -#define xlate_dev_mem_ptr(p)   __va(p)
> -#define unxlate_dev_mem_ptr(p, v) do { } while (0)
> -
>  void __ioread64_copy(void *to, const void __iomem *from, size_t count);

Missing #include <asm-generic/io.h>, according to the build bot report.

>  #endif /* _ASM_IO_H */

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

