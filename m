Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C09382550
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 09:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhEQH32 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 03:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233560AbhEQH30 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 May 2021 03:29:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E9E061007;
        Mon, 17 May 2021 07:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621236490;
        bh=WoQ2Tt9j1s8lZ+rFGz15/N+rcvIN9GuIXZT/n/mvPAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rz4nCnRs3MKPRjz0dKaFcIG7wjHT6KBRybD6Trvo3cwl2LtMEliatXLWXADfjInf4
         ZurKjK+HSZugMQq4T93FIGYUf91CGscakYmybanqXsxFHKKMCODe6xFeOm9T4yqIKc
         1PaYuHpasSko+WxNDMe/gfVOhwl02LQ7a9Q/twcx9iZj61UkRUvXQRv6inWu6oavnW
         obIpBqlhMQ/9yzY5mvgiJYqKx/MlTHMrtTi9MYZWODtd1l34GSGJWS/BxBmTR6Pumm
         mvZXtZTbU+uaHHN0eAih41AV/xVH950QQXPiSEe7NfGz1XKg22SmkmCmsyEzM+o5W0
         8dyhDgzdQ8Egg==
Received: by mail-wr1-f50.google.com with SMTP id p7so1496936wru.10;
        Mon, 17 May 2021 00:28:10 -0700 (PDT)
X-Gm-Message-State: AOAM532IjHGmc41MxoLc1bsvlVLAWGoQGXiijz7M6A7+ny0o5GqYW3dM
        VJkjr3bAZKBVsYtZW+VXUYHVJHjGIBmRznO70FY=
X-Google-Smtp-Source: ABdhPJxk7eLWYGXPzamV742l9EnpMjLM0lyklUBUE5IGJo+cNnB5FKY+yx8/GMxQQ0Oji3ZyvDfH+BybrBLsoLFOZbo=
X-Received: by 2002:a5d:6dc4:: with SMTP id d4mr74796509wrz.105.1621236489115;
 Mon, 17 May 2021 00:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210515101803.924427-1-arnd@kernel.org> <20210515101803.924427-6-arnd@kernel.org>
 <20210517062018.GC23581@lst.de>
In-Reply-To: <20210517062018.GC23581@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 17 May 2021 09:27:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2eDeSgB76SyzcpmQmV3uR1jwtOjZUoG9UYfDnYAWGyog@mail.gmail.com>
Message-ID: <CAK8P3a2eDeSgB76SyzcpmQmV3uR1jwtOjZUoG9UYfDnYAWGyog@mail.gmail.com>
Subject: Re: [PATCH 5/6] [v2] asm-generic: uaccess: remove inline strncpy_from_user/strnlen_user
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

On Mon, May 17, 2021 at 8:20 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, May 15, 2021 at 12:18:02PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Consolidate the asm-generic implementation with the library version
> > that is used everywhere else.
> >
> > These are the three versions for NOMMU kernels,
>
> I don't get the three versions part?

Right, that was confusing. Rewording to

| The inline version is used on three NOMMU architectures and is
| particularly inefficient when it scans the string one byte at a time
| twice. It also lacks a check for user_addr_max(), but this is
| probably ok on NOMMU targets.
|
| Consolidate the asm-generic implementation with the library version
| that is used everywhere else.  This version is generalized enough to
| work efficiently on both MMU and NOMMU targets, and using the
| same code everywhere reduces the potential for subtle bugs.

> > +     select GENERIC_STRNCPY_FROM_USER
> > +     select GENERIC_STRNLEN_USER
>
> Given that most architetures select the generic version I wonder
> if it might be worth to add another patch to invert the logic so
> that architectures with their own implementation need to sekect a symbol.

Done now, using 'CONFIG_ARCH_HAS_{STRNCPY_FROM,STRNLEN}_USER'.

There are still seven or eight architectures that provide their own though.

> > +extern long strncpy_from_user(char *dst, const char __user *src, long count);
> > +extern long strnlen_user(const char __user *src, long n);
>
> No need for the extern here.

Removed.

       Arnd
