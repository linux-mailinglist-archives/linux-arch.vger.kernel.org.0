Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFE639D26C
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 02:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhFGAzA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 20:55:00 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:34401 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhFGAzA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 20:55:00 -0400
Received: by mail-il1-f173.google.com with SMTP id w14so4940232ilv.1;
        Sun, 06 Jun 2021 17:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y9BSY1kSpvp45nIhQmb2rFERrAQbQ//AOUBQnCkiljQ=;
        b=bzqz57uoZk0svF4xpSnO8WinJCsc6o5Ynfa3Wut1LGRNe+hqVYf5Ytwoj1n2oR7uTI
         QgdM99dO7Hryq1BFVzrRwMrlAYR/lCwhc6biDKHTdJsqkWW+RZWbTyJaK97k9uoVJV+T
         Op0JQ61fWj3rGd1gDDh9vMYenNmUS2bIxaqudCOQ6L2LAoBVuJMSAhRUiV52ncCtP+Nl
         Vv6T5dmwuLgTseaXBA3HMcorWxV9zUvXx6mXOxwpZVzrRPFbfGQw5EhjnPaK+UXL9TzJ
         h/a8Q0OBgytcC1Ubx4nEGRv41mDK6PAUhmKZ7BwcGZC+ffRzJ525/py2n8joTNABcfbq
         Qs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y9BSY1kSpvp45nIhQmb2rFERrAQbQ//AOUBQnCkiljQ=;
        b=spp5xXssQbAH9qdzlHJumDsP249yZ47P3GXIOeF6QtR1+NgkHx0F4tTMwXAYp18H1F
         LBeU/NjD2c16/CwMgJD3LoDV1LGxCi+D+Q0qfaVyVFl9pFfbZ72Q51+44+hnAcLSI1tP
         C89EDN0FYkOCLFZ2DvNE/8zshIP19nlV83WRrnDYrbxtxdUF4ZqbzQYfS+j5GR+drXW9
         32tM5nR4Q2oUe0QZrQlk18IR4x9rxv7Dt2w2OitGfh1QHedhnG80SOIGQ8SELEoPT3Gr
         lfd0jPMsOb5Bu9eKo7cEbLk4KRWGd3SsRgd0QWXjvS6/Ht1ycfdgqYqETDl9HbWRRRAt
         fXqQ==
X-Gm-Message-State: AOAM533Zt2x9ImkH2BZ3YoS37FQ3B818lkaVZfa+MN6f4Tp3u6j7oQt/
        zwJ0stoT5xPvTzXfQxjhhB1UMfjxGSyU4OObu7E=
X-Google-Smtp-Source: ABdhPJzI1KCYqysRurYIZL21JonrxRELtvXTwC4nnqjgU4EC7pDi/uAnAp76lXUHnDzMuxWYlKkI2kEnbE4VdXkt2zU=
X-Received: by 2002:a92:d941:: with SMTP id l1mr12591008ilq.143.1623027119606;
 Sun, 06 Jun 2021 17:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210605211529.GA2326325@bjorn-Precision-5520> <2a51e6b8-37e5-43cb-b0b4-d6fdd1848fe3@www.fastmail.com>
In-Reply-To: <2a51e6b8-37e5-43cb-b0b4-d6fdd1848fe3@www.fastmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 7 Jun 2021 08:51:48 +0800
Message-ID: <CAAhV-H5fQbJaLrYpmiK9nKWAvFEcvvso==7DpXQzJp=e7faWdg@mail.gmail.com>
Subject: Re: LoongArch (was: Re: [PATCH V2 2/4] PCI: Move loongson pci quirks
 to quirks.c)
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>, arnd@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, all,

On Sun, Jun 6, 2021 at 4:14 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82021=E5=B9=B46=E6=9C=886=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=885:15=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A
>
> +linux-arch and Arnd for arch related discussions
>
> >
> > If you're moving these from device-specific file to a generic file,
> > these #defines now need to have device-specific names.
> >
> > But these appear to be for built-in hardware that can only be present
> > in Loongson (I assume mips?) systems.  If that's the case, maybe they
> > should go to a mips-specific file like arch/mips/pci/quirks.c?
> >
> > But I see you see you mention LoongArch above, so I don't know if
> > that's part of arch/mips, or if there's an arch/loongson coming, or
> > what.
>
> As far as I read LoongArch should be a brand new RISC architecture.
> I saw Loongson release some documents[1] and code[2] regarding this
> new architecture.
>
> Huacai, as you are submitting these code, does it mean Loongson intends
> to mainline LoongArch kernel?
> If so, I'm certain that there is a lot of drivers and other code can be
> reused between MIPS part and LoongArch part for Loongson chips.
> Could you please make an announcement about your plans?
>
> Thanks.
>
> [1]: https://github.com/loongson/LoongArch-Documentation
> [2]: https://github.com/loongarch64
Yes, LoongArch is a new RISC ISA, it is not compatible with MIPS.
Loongson processors before 3A4000 is compatible with MIPS, and 3A5000
is based on LoongArch. Part of LoongArch documentations are available
in English (as listed above by Jiaxun), others are being translated.
There will be a new directoy arch/loongarch, and I hope it can be
coming soon.

Huacai
> --
> - Jiaxun
