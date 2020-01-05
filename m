Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0781306DD
	for <lists+linux-arch@lfdr.de>; Sun,  5 Jan 2020 10:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgAEJBq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Jan 2020 04:01:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAEJBq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 5 Jan 2020 04:01:46 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F4AB24670;
        Sun,  5 Jan 2020 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578214905;
        bh=4NAiR6aU9fppWcMMo72u1LKgrx1TYaLfDaJ9c3BYY0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=df8gyJcLYHrsYsIWtkf/t1epjifkYjoAndK3OkJeqWXjpHoNmEZuQAofWmOJ4JMHg
         gIS12JPw9LXJVBWPNWG4e8t2gxWvXMLtFzkB6s8vsawDE4JTxRy5LAc/sOYgegsvUR
         f+HSCPeXSjDUui0Q+YwC46SSi4xn2tSq6JVrxaUQ=
Received: by mail-lj1-f175.google.com with SMTP id w1so25942626ljh.5;
        Sun, 05 Jan 2020 01:01:44 -0800 (PST)
X-Gm-Message-State: APjAAAWNF79PanjH6C6ivwG/c/th4sfhlGCe/aDY0KIRaJEZ1aOSZHFF
        /TbDTvnv6OlyJDUWp7qEoWE+Q+UWDqpimkJgN00=
X-Google-Smtp-Source: APXvYqyR7QraAgKUypqOelCu6BJ14MzHMVlNf4HmCJrq1/e3Pgnip4Mvypqtx4TOls127CrbnpwZwZS+hWPYO2lFYIY=
X-Received: by 2002:a2e:2e12:: with SMTP id u18mr30759716lju.36.1578214903123;
 Sun, 05 Jan 2020 01:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20200105025215.2522-1-guoren@kernel.org> <20200105025215.2522-2-guoren@kernel.org>
 <87o8viwb44.fsf@hase.home>
In-Reply-To: <87o8viwb44.fsf@hase.home>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 5 Jan 2020 17:01:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTREKZ7FwQtyG+3YJ-Ne2BiyyWNhy4dgjVt0Y_qyy79p-Q@mail.gmail.com>
Message-ID: <CAJF2gTREKZ7FwQtyG+3YJ-Ne2BiyyWNhy4dgjVt0Y_qyy79p-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        vincent.chen@sifive.com, zong.li@sifive.com,
        greentime.hu@sifive.com, Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Oops, thx. :)

On Sun, Jan 5, 2020 at 4:39 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jan 05 2020, guoren@kernel.org wrote:
>
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d8efbaa78d67..3d336f869ffe 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -286,6 +286,15 @@ config FPU
> >
> >         If you don't know what to do here, say Y.
> >
> > +config VECTOR
> > +     bool "VECTOR support"
> > +     default n
>
> default n is the default.  Did you mean default y?
>
> > +     help
> > +       Say N here if you want to disable all vecotr related procedure
>
> s/vecotr/vector/
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
