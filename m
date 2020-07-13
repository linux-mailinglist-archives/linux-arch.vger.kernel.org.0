Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1221D365
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgGMKFs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 06:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGMKFs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 06:05:48 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6FEC061755;
        Mon, 13 Jul 2020 03:05:48 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ed14so5511081qvb.2;
        Mon, 13 Jul 2020 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2R5FqpATOsC9anZCjDdbfJmwuMulHp2IY/fh6GixDKM=;
        b=M1RzZEMoz5QxfH8SpG+taA4nXeqDdQhlsmE7KUJcmdBZU1aCZMQAlI5y8ElOf6Fuhp
         4lh52bmfq+PnMcWMrf65ELqM4xBZhvfUb86Sl0MKqeqYSDtBPJn9vlZ3ZLWCHpazAJc/
         9s0PoRAXaDSyezsgU9OP13jwiif1veTIOUAqndwQ8KCfuxgw+AzHtYQa1xRi4GiwbZXM
         Ojjv9jB4SaGfwE1FkUXkomIv10SvKhmWJ1M5/6ApjeymByh7qiegSUUuI88ARLQw1pzh
         XnIcJZCyYJMgKpamqdjDwWqE6coAJynCjscbblgZTn0D/GtOfbpUUb5FNGSSImLkShX/
         eDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2R5FqpATOsC9anZCjDdbfJmwuMulHp2IY/fh6GixDKM=;
        b=L1oDqeoxqUWC0W57CxhQi03TAwYuDu5zS50wJdwQttH9i+Q4kQwehqk/D9UdPVeTdY
         9pFCEGWYey3dgzcVry/GIvvWhIZStW8LxWDbsNMIyvr71DPyZ7qMOb5sS9HBHFnBVYZJ
         lWDJJunv/d02srRtS3yi6/9ZuSMb37152CiuQ+Y4dRCNmYTTAQbjp/e3BeS4VJj9VT6A
         7xRWQzwsqXrC3KFlrd1Z8vzTKwzRqtDwXbY3fefrAklsv2sRLtXw5ZQUP47ehDMlzHG4
         PNY6YnjEdtu00W1Ge/ZXUGL5GbsbeioPmxQtzHoCKIa+uLqBbg/+7rOodGkwYlWFBYbg
         dE+w==
X-Gm-Message-State: AOAM531XaDRcGuT1FDKbMKUDGfY+XrEx3F6odoqjE8NF0CMVHIKKaXSN
        Bby1mkOwB6VbnBGAXrL4Wpu986lvuHKdZb5xzH8=
X-Google-Smtp-Source: ABdhPJzFqEGiReKbwy5jLRxtaDiSvZmM3/d21BHz80ho9j12CosVkGT1LkCaauKrTm3/r4dgwAWY3ecgapZq6+wKTMw=
X-Received: by 2002:a0c:cd84:: with SMTP id v4mr44981386qvm.35.1594634747242;
 Mon, 13 Jul 2020 03:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200710135706.537715-1-hch@lst.de> <20200710135706.537715-5-hch@lst.de>
In-Reply-To: <20200710135706.537715-5-hch@lst.de>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Mon, 13 Jul 2020 18:05:10 +0800
Message-ID: <CAEbi=3dSkAcTey8WeRuxN7oYq_O47QAZffLwruQRbpGpmqT-yA@mail.gmail.com>
Subject: Re: [PATCH 4/6] uaccess: remove segment_eq
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
> segment_eq is only used to implement uaccess_kernel.  Just open code
> uaccess_kernel in the arch uaccess headers and remove one layer of
> indirection.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/alpha/include/asm/uaccess.h      | 2 +-
>  arch/arc/include/asm/segment.h        | 3 +--
>  arch/arm/include/asm/uaccess.h        | 4 ++--
>  arch/arm64/include/asm/uaccess.h      | 2 +-
>  arch/csky/include/asm/segment.h       | 2 +-
>  arch/h8300/include/asm/segment.h      | 2 +-
>  arch/ia64/include/asm/uaccess.h       | 2 +-
>  arch/m68k/include/asm/segment.h       | 2 +-
>  arch/microblaze/include/asm/uaccess.h | 2 +-
>  arch/mips/include/asm/uaccess.h       | 2 +-
>  arch/nds32/include/asm/uaccess.h      | 2 +-
>  arch/nios2/include/asm/uaccess.h      | 2 +-
>  arch/openrisc/include/asm/uaccess.h   | 2 +-
>  arch/parisc/include/asm/uaccess.h     | 2 +-
>  arch/powerpc/include/asm/uaccess.h    | 3 +--
>  arch/riscv/include/asm/uaccess.h      | 4 +---
>  arch/s390/include/asm/uaccess.h       | 2 +-
>  arch/sh/include/asm/segment.h         | 3 +--
>  arch/sparc/include/asm/uaccess_32.h   | 2 +-
>  arch/sparc/include/asm/uaccess_64.h   | 2 +-
>  arch/x86/include/asm/uaccess.h        | 2 +-
>  arch/xtensa/include/asm/uaccess.h     | 2 +-
>  include/asm-generic/uaccess.h         | 4 ++--
>  include/linux/uaccess.h               | 2 --
>  24 files changed, 25 insertions(+), 32 deletions(-)
>
[...]
> diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/ua=
ccess.h
> index 3a9219f53ee0d8..010ba5f1d7dd6b 100644
> --- a/arch/nds32/include/asm/uaccess.h
> +++ b/arch/nds32/include/asm/uaccess.h
> @@ -44,7 +44,7 @@ static inline void set_fs(mm_segment_t fs)
>         current_thread_info()->addr_limit =3D fs;
>  }
>
> -#define segment_eq(a, b)       ((a) =3D=3D (b))
> +#define uaccess_kernel()       (get_fs() =3D=3D KERNEL_DS)
>
>  #define __range_ok(addr, size) (size <=3D get_fs() && addr <=3D (get_fs(=
) -size))
>
Hi Christoph, Thank you.
Acked-by: Greentime Hu <green.hu@gmail.com>
