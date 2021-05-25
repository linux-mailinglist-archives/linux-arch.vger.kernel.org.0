Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBAF38FDCC
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 11:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhEYJaE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 05:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232341AbhEYJaD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 05:30:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A4F66141B;
        Tue, 25 May 2021 09:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621934914;
        bh=NW/6KeimjMY0HcsoXBOHeEH9IbSnm0X7Mg03MgNiLQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k+XkKzp8W7RYdepnY+CdUapRNWYS46HCEdTPQBAHtzakaTPmtWxRr88Gxjg5q1XN+
         KWAOlgbOehz4JrvYaKkB8ZBUun5SXeMB7eLlFnRyV7zqzJVElsEMMu5WjjOXLe0SGH
         8/a9OKFlxdbBXV2BH1Ljb+M5fqNdYprDBrJbSCNH1wUt3c14FaVYYLm3PlP1j4fRjM
         CEYWr4F52AVqBvgHhEVxrElNarmB7EZTegX8Eyn8H2YC3ai9S/Ib3XE74bPkFEakKW
         9xkU2xGRhgdMtR5gHWpji6aPKkf5NxD/X7jCSaEPF4qf8Yyun3qtP+c6l4q0FWM6QV
         Q3MC7G/MHQG0g==
Received: by mail-lj1-f174.google.com with SMTP id p20so37228587ljj.8;
        Tue, 25 May 2021 02:28:34 -0700 (PDT)
X-Gm-Message-State: AOAM532UWZMemXomli4VDYjwfJ/MTj2RXmqwr1JjSzY9IvddyH+Zp2bt
        ljfZuP4qhP+NL0bha70O8B1fTc0nvPCmjrKiu6k=
X-Google-Smtp-Source: ABdhPJxYhRsXM1341LnsAQgXpZGbR4SUkmSohnNp5yRbddS+2fueSoTk8EvBgt/nUUs/mFId0Z2IEFYNOCLwZ8CIeik=
X-Received: by 2002:a2e:501b:: with SMTP id e27mr19934531ljb.508.1621934912683;
 Tue, 25 May 2021 02:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <1621839068-31738-1-git-send-email-guoren@kernel.org>
 <1621839068-31738-2-git-send-email-guoren@kernel.org> <YKyae+8O25A8vxMS@infradead.org>
In-Reply-To: <YKyae+8O25A8vxMS@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 25 May 2021 17:28:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRA=tUid7akgVXfk6MHOd0KmJpDQEZ2m9wRfhigBDzQTw@mail.gmail.com>
Message-ID: <CAJF2gTRA=tUid7akgVXfk6MHOd0KmJpDQEZ2m9wRfhigBDzQTw@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: Fixup PAGE_UP in asm/page.h
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 2:34 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, May 24, 2021 at 06:51:07AM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Current PAGE_UP implementation is wrong. PAGE_UP(0) should be
> > 0x1000, but current implementation will give out 0.
> >
> > Although the current PAGE_UP isn't used, it will soon be used in
> > tlb_flush optimization.
>
> Nak.  Please just remove the PAGE_UP/PAGE_DOWN macros just like they
> have been removed from other architectures long ago and use the
> generic DIV_ROUND_UP macro for your new code like everyone else.

This patch has been dropped because it's wrong, ref Anup's reply.

Remove PAGE_UP/DOWN is okay for me. How about:
 static inline void local_flush_tlb_range_asid(unsigned long start,
unsigned long size,
                                              unsigned long asid)
 {
-       unsigned long page_add = PAGE_DOWN(start);
-       unsigned long page_end = PAGE_UP(start + size);
+       unsigned long page_add = _ALIGN_DOWN(start, PAGE_SIZE);
+       unsigned long page_end = _ALIGN_UP(start + size, PAGE_SIZE);

_ALIGN_XXX are also defined in arch/riscv/include/asm/page.h.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
