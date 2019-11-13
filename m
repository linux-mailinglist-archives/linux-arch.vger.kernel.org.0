Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50537FAB60
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2019 08:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfKMHyl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Nov 2019 02:54:41 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:41877 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfKMHyl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Nov 2019 02:54:41 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id xAD7sHL7006673;
        Wed, 13 Nov 2019 16:54:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com xAD7sHL7006673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573631658;
        bh=9fiH9bvw8H7RO9dv79xl9+Q9OlMLcBXx3Oz2oKfIJao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ymv9OKzCzMUrDRF+Wn3SD01MChzuysHvmsFOitoQP/Ea00IP+KyyEFyG/Ib+++mCl
         rdn4LWAQ74t6TcAEw1ArAI9wa0pnigjZsZatN+Eh6EL3FGPi/dPgWTkkRXQKDdJe0y
         f9Wljfvy3OXpKVRUd+csoVCYI6xta8QRAlG7BGyPu8nkw4yyUjyUqotvd64UMfz7I0
         u4MhxjdCL8bQ/UmVLo3fk+avxxPkPCE2Eiqie33xjDhxaHaTIRCrYokB5cfZAodXql
         61vdZle7KtJUIJftuy5B3LcaflXBdyDdUHHzO+zw/lJ4S6qgt4qlDIulOnJlsB9fz3
         Xq02vy0SXLIhg==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id q21so760538vsg.3;
        Tue, 12 Nov 2019 23:54:17 -0800 (PST)
X-Gm-Message-State: APjAAAU3eTOiUYQhevJ/UUw9A3ecVoiqjt2nqk1rguE74Gm48jSIhg4V
        voX2XqQvUNY+srTVucvReM3OwgNbhlAmCjr97ec=
X-Google-Smtp-Source: APXvYqzFDCIx64eXzgZHHZvzce/JT7538765oDtHhVnN1MGrBKUVL68GK8zhGP8UXayxYTIkhDViw9m8btElx6qhKyc=
X-Received: by 2002:a67:d31b:: with SMTP id a27mr1083694vsj.215.1573631656052;
 Tue, 12 Nov 2019 23:54:16 -0800 (PST)
MIME-Version: 1.0
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com> <20191112123125.GD17835@willie-the-truck>
 <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
 <32a3b660-f4d2-268e-2206-d50073298c0c@iogearbox.net> <CAK7LNASR=R=gyuaMO=VzdXrY3gaQ_FVE4es60bzXf=9ASR2qUw@mail.gmail.com>
 <021e7b46-047e-d381-9dca-bd61db08e4f8@163.com> <CAK7LNARKh3-cAqsYgcxFwq9CGk-CgBfkiQgfNSULkxwO0xa2vw@mail.gmail.com>
 <ac4577d4-c0f2-9596-df6f-3fcc563bde3e@163.com>
In-Reply-To: <ac4577d4-c0f2-9596-df6f-3fcc563bde3e@163.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 13 Nov 2019 16:53:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATfK2pFnO2YV5zMLMxJGYyaj+f8w-k4K8xaoGbJ2Bd5eQ@mail.gmail.com>
Message-ID: <CAK7LNATfK2pFnO2YV5zMLMxJGYyaj+f8w-k4K8xaoGbJ2Bd5eQ@mail.gmail.com>
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 13, 2019 at 4:17 PM Xiao Yang <ice_yangxiao@163.com> wrote:
>
> On 11/13/19 2:57 PM, Masahiro Yamada wrote:
> > Sorry, I really do not understand what you are doing.
> >
> > include/linux/compiler.h is only for kernel-space.
> > Shrug if a user-land program includes it.
>
> Hi Masahiro,
>
> For building tools/bpf, it is good to fix the compiler error by Daniel's
> patch(i.e. use linux/filter from linux header).
>
> linux/compiler.h may be used by other code in kernel.  Is it possible to
> trigger the same error when the other code
>
> including linux/compiler.h is built? Is this kind of code able to find
> the location of <asm/rwonce.h>?


<asm/rwonce.h> is also kernel-only header.

The kernel code can find <asm/rwonce.h>, but user-land code cannot.




> Best Regards,
>
> Xiao Yang
>
>


-- 
Best Regards
Masahiro Yamada
