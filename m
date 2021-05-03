Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230C23718DB
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhECQJV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 12:09:21 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47955 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhECQJV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2021 12:09:21 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N4h7p-1lWxI52Z1j-011nEf; Mon, 03 May 2021 18:08:26 +0200
Received: by mail-wm1-f46.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so3824109wmi.5;
        Mon, 03 May 2021 09:08:26 -0700 (PDT)
X-Gm-Message-State: AOAM531V/p+Kd8tUJwf5HIvQg1LXfkIK7Uns8T2Yi46cXrrlcPNWIQ/5
        /0zto/t2nLrSYTS+Y3xgPMxpt5rJcNmG/TXsZjo=
X-Google-Smtp-Source: ABdhPJxYMTQJVWw4WAAd9FKPLJo6XWwuPeyfNnK3keAI5ERAvz63WNcWg2FiOjsFOVj9CWG/OQW083WJQcY7aApQpDg=
X-Received: by 2002:a7b:c846:: with SMTP id c6mr32166374wml.75.1620058106200;
 Mon, 03 May 2021 09:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210430111641.1911207-1-schnelle@linux.ibm.com>
In-Reply-To: <20210430111641.1911207-1-schnelle@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 May 2021 18:07:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3mCujxC0=_cL6Z88Xh2cb=OY_Ct7DVpJNvRn1v9=FhkQ@mail.gmail.com>
Message-ID: <CAK8P3a3mCujxC0=_cL6Z88Xh2cb=OY_Ct7DVpJNvRn1v9=FhkQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ttSkI0gIoMXApQ/NBgONSZBhlv+vaN7DOdJfzbslazuqcGkP+6H
 zYKG9HAdkR7tAYwUPZNv8X6mYjOFVpYg1Lhxzah2tOWyriam/QFjvSLRZcobJN6S8vbwTFc
 bepQ0B7o9Bs0sIEiZV5RHF9TzhIeVoroYF3/D7pUVCaWiXBSpeXIdCtCLdLr3otNnFjhJy7
 /5x8cJck19z7A3E0ws28A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MuVa7V+jiQg=:RIpZ9QCoWYxQBrCcu2dzUS
 PIZ6R/5v5sSAxKQ+nuH/yVsu3Uox4mrrxgxRvsnKo1BNY2xYQgYoFyEwbNvBCZNjdtpjQQ5Op
 bTvJ3JO29LSMldV9WF1DeTDKZMkPawd5ZI+H2stUxS6nKDZF2UjKrY61DF5gXWWGdGVkivAhS
 Uckf0Ah3BCjv5b0quFY0QAEFz3f1PbqhcmlzEErbQFj1Yjt+8mvzSlepaXgVD+l67uWuanItU
 dhQCA9AoKBTSkKOLbwrmMa8ItR3LYcAvH7I8XJ2MwJl+ouTgJ51T3akf9zkIatNqrJ/n7qNgP
 K/LDindeju1wJ0m1nltOaJ2AoKPCGSzm4tAPS911fIRpr1SOTGz+/MP4Yhk7H3dzQ0BRWhSO/
 AR+TXu5lqZQjrbYhDVsQfuijMU7zxjtz0mTKuk3CPnNM34h66JzXBfL7piWGN6tJoJFie8Drm
 yCGKpko2IeFw5JzPpQHT0xsNoeqP4U0QixWWzJQ7GjMip38EN1taKYgtY4YFA6OnzuKfcv7ks
 V9kecgcNEhQDk0FPfAlLpG/adqAIPMPmYM5t+2GBHQE1nQtAArN0pX8p27IKEpahwKaTZn77M
 CsFxrcSUu9665NQiWW6EcGGzznpWwM2tT1AamvpJXlGs/7XQwHTNkf8wx63InB6eSJq7Gw1YC
 hS5Y=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 30, 2021 at 1:16 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> From: Niklas Schnelle <niklas@komani.de>
>
> This is version 4 of my attempt to get rid of a clang
> -Wnull-pointer-arithmetic warning for the use of PCI_IOBASE in
> asm-generic/io.h. This was originally found on s390 but should apply to
> all platforms leaving PCI_IOBASE undefined while making use of the inb()
> and friends helpers from asm-generic/io.h.
>
> This applies cleanly and was compile tested on top of v5.12 for the
> previously broken ARC, nds32, h8300 and risc-v architecture
>
> I did boot test this only on x86_64 and s390x the former implements
> inb() itself while the latter would emit a WARN_ONCE() but no drivers
> use inb().

This looks all fine to me, but with the merge window open right now, I
can't add it into linux-next yet, and it wouldn't qualify as a bugfix for 5.13.

Please resend them to me after -rc1 is out so I can merge it for
5.14 through the asm-generic tree.

Please add two small changes to the changelog texts:

- for patch 3, please include a 'Link: tag' to the lore archive of the
  previous discussion, that should cover any questions that people
  may have

- for the risc-v patch, I would suggest explaining that this fixes
  an existing runtime bug, not just a compiler error:
  | This is already broken, as accessing a fixed I/O port number of
  | an ISA device on NOMMU RISC-V would turn into a NULL pointer
  | dereference.
  Feel free to either copy this, or use your own explanation.

       Arnd
