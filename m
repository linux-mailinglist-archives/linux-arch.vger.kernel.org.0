Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7B1381761
	for <lists+linux-arch@lfdr.de>; Sat, 15 May 2021 11:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhEOJ53 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 May 2021 05:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhEOJ52 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 15 May 2021 05:57:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9A85613EC;
        Sat, 15 May 2021 09:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621072575;
        bh=xTDtBJ9V9VYwOUf/uC9UTFd+NHYG7n2WkwAKLnOotog=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZfV7S2lgmdAvPgP/14Cz0gdHfnetBWdk+Q+d8pV0P00a1HmCgumdcMwm0PNT+Pqjw
         e/MA68F5K9M9Qphu5vpeMC6AffSf74ZmrYjMh2DZMw/qgkXpSi0gdGanccgi7MiBWX
         dQsLBQU1zqe75bZWo2v2x6VW3SFEXUPoJp8HBwG60r2B1UzIuucQ+j9sbcAOlKfX3T
         AeJotkFM/hq26/v31msWgWjR7qBNa0cYdrndqqdPuS1oerK+SHRbB/aLV/+SbPJp7t
         25Qlc1z5N91oBQvdAaoxmTPLyaSt/mDe39Dtn5h//hEXZwh+HQX52Peq/j/HaxA5U7
         AR6vH0QbEmzjA==
Received: by mail-wr1-f42.google.com with SMTP id s8so1493859wrw.10;
        Sat, 15 May 2021 02:56:14 -0700 (PDT)
X-Gm-Message-State: AOAM531yQGyUQGklJAckjuqE0alVkgUhTSMxIxyoMSpNApw0byZi3vSL
        qT+7aj6Cir9HNXxNyPbabyKkTzP+FwbT4XKKIcY=
X-Google-Smtp-Source: ABdhPJyU1TeHsTyhdSvAyF4C1QTcXoaRrpe2s4yt2wtnu6GWm1DoLujaxn1SkUeZ3N6LZcimtNJwCO6vX/IPuQocx+g=
X-Received: by 2002:adf:fe04:: with SMTP id n4mr6852056wrr.361.1621072573589;
 Sat, 15 May 2021 02:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210514220942.879805-1-arnd@kernel.org> <20210515064015.GA26545@lst.de>
In-Reply-To: <20210515064015.GA26545@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 15 May 2021 11:55:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ukLgV3K3sW8gkkz6cvKh+wmP_C0av2hnYcftfXMPTWA@mail.gmail.com>
Message-ID: <CAK8P3a2ukLgV3K3sW8gkkz6cvKh+wmP_C0av2hnYcftfXMPTWA@mail.gmail.com>
Subject: Re: [PATCH 0/5] asm-generic: strncpy_from_user/strnlen_user cleanup
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Sid Manning <sidneym@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
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

On Sat, May 15, 2021 at 8:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I generall like this consolidation, but for the patches that remote
> the arch / asm-generic versions, can you please elaborate a little
> more why the lib version is preferable?  The current commit logs are
> not very informative.

Indeed. I do remember writing the patches last year thinking "this should
really get fixed", but apparently I failed to describe the actual problem at
the time. I have gone through it again and annotated what I found now,
but I have a feeling that there were additional problems with the old
code that I still did not capture.

Sending v2 now: same code, more text.

       Arnd
