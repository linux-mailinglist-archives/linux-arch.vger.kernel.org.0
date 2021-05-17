Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2DF38274A
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 10:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbhEQIpY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 04:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235494AbhEQIpT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 May 2021 04:45:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EFB461184;
        Mon, 17 May 2021 08:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621241043;
        bh=pGxJJRkE9qeDtccc/YEcwOP1pJnAulKNh3xYI4CjqcE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VhyR280qktq3Yj7mvUPKACKxoTFcuZgScgzvJHx3l38cArr8+Z1PHUCauN7611dwt
         NPqfUoJoLvybKsWnw5XBfWBnw8Kv/cK+DKuTDCcu6S3genrIH4gyCUDyMru0esHMq3
         IQajegZypqB2swBYx+h3oZex0t4OU4xmY+RiLrkmtgPak2eiVPLgJdWphXaIjg2ZQR
         xazekUTIUzom3w/On/AUGF/4aikSScp4WWIi0uoJhNFKiP0lEpNVnpQ48HG9k3wCGu
         5YN9cseL+gw6iSznh8e4ihyONNGEmrxfyQM2XPKMRSASOUsEWkgPtNFIfn50Tm8Cvs
         7//2tKougJRQA==
Received: by mail-wm1-f51.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so2478967wmk.0;
        Mon, 17 May 2021 01:44:03 -0700 (PDT)
X-Gm-Message-State: AOAM532xA7QFH2+P2DODo0KsRt+DGT3pXCyq8ZIi0NgyHPpf7piGEIYX
        dJrCQe9X2ZzMmeQwNuDMXzA6JKwTdDafiIYGbrI=
X-Google-Smtp-Source: ABdhPJyn3HuFOFAJWNgd1wcrETQpYkMJHnXvEOT0odsuIYz2sA4AdaozgJ+/NI7bT1baIPTv7IRh4lYoa6g98QiwBCo=
X-Received: by 2002:a7b:c446:: with SMTP id l6mr6057480wmi.75.1621241041984;
 Mon, 17 May 2021 01:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210514220942.879805-1-arnd@kernel.org> <20210514220942.879805-2-arnd@kernel.org>
 <CAMuHMdXr6gxbJu+otHV=PhoXvM7aoshs_A-SVpTmYw1iDdiqsg@mail.gmail.com>
In-Reply-To: <CAMuHMdXr6gxbJu+otHV=PhoXvM7aoshs_A-SVpTmYw1iDdiqsg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 17 May 2021 10:42:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a02V8k6aGkqtc0A7PiAwhJDCw6yMW=m4nmTmgVbwy316g@mail.gmail.com>
Message-ID: <CAK8P3a02V8k6aGkqtc0A7PiAwhJDCw6yMW=m4nmTmgVbwy316g@mail.gmail.com>
Subject: Re: [PATCH 1/5] asm-generic/uaccess.h: remove __strncpy_from_user/__strnlen_user
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Sid Manning <sidneym@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 17, 2021 at 9:42 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Sat, May 15, 2021 at 12:10 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > This is a preparation for changing over architectures to the
> > generic implementation one at a time. As there are no callers
> > of either __strncpy_from_user() or __strnlen_user(), fold these
> > into the strncpy_from_user() strnlen_user() functions to make
>
> ... and ...

Fixed, thanks!

      Arnd
