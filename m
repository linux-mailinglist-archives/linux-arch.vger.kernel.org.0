Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1E248087F
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 11:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhL1KkS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 05:40:18 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:35735 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhL1KkS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 05:40:18 -0500
Received: by mail-ua1-f47.google.com with SMTP id v14so13690748uau.2;
        Tue, 28 Dec 2021 02:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGprts+IMCcw2LRbyJoC20xYqdPz6LzpMb8Wjv374xM=;
        b=zfiJiXCGYSln8yAHVf3/5z9KThppDtc8CvzV0oIg6DwkWWdmvUJFH0jrRzd08RC5cE
         D0AHwvFXXupf/zQNOCbcjNm65Xc1ULotawmWB/ZEP78R+uHyMb60psQymqS+mJKgdkEh
         X3BlILhWZ79JvFZTxDcLAhB/1Ior3HvZfSUvr0oZS7bsN3tkKKLeaW0+A1M9VVidsv01
         NVh3wxw3Qlea06MxHN/tjkeCDhTxBXTf/MyUcAkJR5k3ITPUBGFYPlfPPOJA1z3TsHNK
         n/JSJ69YTIatEGnuT1hBewT6srp9O31w+pTM2PUmnrsg5ffGfHAHy8xIW59KOuH+1nPr
         3AbA==
X-Gm-Message-State: AOAM532Xg3ANejAdu32eZBq3UqWQSK+co93fp1i6ZqnGqmtY5v2adGGy
        SsXcWKu9LXIgErY4jZd9vC7PCrFoO2PEiA==
X-Google-Smtp-Source: ABdhPJzCaJ+N+2NLqZlv1RaH6z8hTjwhcOW3CvFnYvmv4MES0eqg5X7TLsBs565cgLrVdJgfzF+bTw==
X-Received: by 2002:a05:6130:323:: with SMTP id ay35mr2572658uab.1.1640688016744;
        Tue, 28 Dec 2021 02:40:16 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id x21sm3980474ual.11.2021.12.28.02.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 02:40:16 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id t18so23784817uaj.1;
        Tue, 28 Dec 2021 02:40:16 -0800 (PST)
X-Received: by 2002:a67:2e09:: with SMTP id u9mr5382186vsu.77.1640688015917;
 Tue, 28 Dec 2021 02:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com> <20211227164317.4146918-25-schnelle@linux.ibm.com>
In-Reply-To: <20211227164317.4146918-25-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Dec 2021 11:40:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVQuOO7WzzO1mB-buEj1h8h0e6Cn7CAbFbaH9Uyvcc=wQ@mail.gmail.com>
Message-ID: <CAMuHMdVQuOO7WzzO1mB-buEj1h8h0e6Cn7CAbFbaH9Uyvcc=wQ@mail.gmail.com>
Subject: Re: [RFC 24/32] scsi: Kconfig: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Niklas,

On Mon, Dec 27, 2021 at 5:53 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks for your patch!

> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -793,6 +793,7 @@ config SCSI_INIA100
>  config SCSI_PPA
>         tristate "IOMEGA parallel port (ppa - older drives)"
>         depends on SCSI && PARPORT_PC
> +       depends on HAS_IOPORT

This is not needed, [04/32] already added that dependency to
PARPORT_PC.

>         help
>           This driver supports older versions of IOMEGA's parallel port ZIP
>           drive (a 100 MB removable media device).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
