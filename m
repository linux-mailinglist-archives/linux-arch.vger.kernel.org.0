Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C76212CA
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2019 06:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfEQETY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 May 2019 00:19:24 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:47280 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfEQETY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 May 2019 00:19:24 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x4H4J8rk020004;
        Fri, 17 May 2019 13:19:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x4H4J8rk020004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558066749;
        bh=J7yAUK19cep0kEYDzk4DJ/4J6NgS5gQ7gjFkMhf0nf0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c0LtECK4wG0ntD78HJSVal1PgIaDPnG3TYgZdKUwPQb1na1TUOyc7O8nFlNd6CaCm
         AXsspHBBBxyBH+xc+yKwpj4hyYVIlPFcjcW/vHsJL5fSi5Q2gSwjjErNYCHX7DoDJk
         uzHnaxZfaH6FQsso8f00WBIqbL0o02CmwbkFxF8m6vBwnpe79+CLRENPKmsLOuBRZS
         H1BuxVeZipFZOyAH3A/7goUgdI8wKHrHt3j0pC8tQP/JX2YVrYwXhbMxIntV2ieT5M
         FSH/2b85VtqV4XO16MdlVD3fBZ0eNwSQDAHODI3YrVqSmTCnoT21JK380X6v99doLI
         2TTH2dRT0iNEA==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id 49so2202636uas.0;
        Thu, 16 May 2019 21:19:08 -0700 (PDT)
X-Gm-Message-State: APjAAAWydtx2tRS6jJKO5xqCPv+Vt3FwVdD9ASPinktF8SumIpi9HPS3
        i2bpdlZOxCPwGHcr4Eofl46WJIVzZ/yje7rdJvc=
X-Google-Smtp-Source: APXvYqw2YDleh3v/xnLGvb0ytg007xtjBjm7KsoOOxcHJpN/6dfsgAIRhFvSJ0T46JhQEFnSRL0PruWBvw6llY+KDwI=
X-Received: by 2002:ab0:3058:: with SMTP id x24mr23094567ual.95.1558066747792;
 Thu, 16 May 2019 21:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
 <20190423034959.13525-11-yamada.masahiro@socionext.com> <ca74c830-fe1b-7bff-8dfd-353fca57b647@redhat.com>
In-Reply-To: <ca74c830-fe1b-7bff-8dfd-353fca57b647@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 17 May 2019 13:18:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNASjc8rmJvv5kgk6Mxo3mcB4EgB4XJG_8JY47ZQbrsSSXg@mail.gmail.com>
Message-ID: <CAK7LNASjc8rmJvv5kgk6Mxo3mcB4EgB4XJG_8JY47ZQbrsSSXg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 10/11] powerpc/mm/radix: mark as __tlbie_pid()
 and friends as__always_inline
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mathieu Malaterre <malat@debian.org>, X86 ML <x86@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Laura,


On Fri, May 17, 2019 at 7:55 AM Laura Abbott <labbott@redhat.com> wrote:

> What gcc version was this tested with?

I use kernel.org toolchains
https://mirrors.edge.kernel.org/pub/tools/crosstool/

It is GCC 8.1


> We're still seeing errors on
> Fedora rawhide with gcc 9.1.1 on a version (8c05f3b965da14e7790711026b32cc10a4c06213)
> that should have this fix in it:
>
> BUILDSTDERR: arch/powerpc/mm/book3s64/radix_tlb.c: In function '_tlbiel_pid':
> BUILDSTDERR: arch/powerpc/mm/book3s64/radix_tlb.c:104:2: warning: asm operand 3 probably doesn't match constraints
> BUILDSTDERR:   104 |  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
> BUILDSTDERR:       |  ^~~
> BUILDSTDERR: arch/powerpc/mm/book3s64/radix_tlb.c:104:2: error: impossible constraint in 'asm'
> BUILDSTDERR: make[3]: *** [scripts/Makefile.build:279: arch/powerpc/mm/book3s64/radix_tlb.o] Error 1
> BUILDSTDERR: make[2]: *** [scripts/Makefile.build:489: arch/powerpc/mm/book3s64] Error 2
> BUILDSTDERR: make[1]: *** [scripts/Makefile.build:489: arch/powerpc/mm] Error 2

Thanks for the report.

Does this work for you?


diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c
b/arch/powerpc/mm/book3s64/radix_tlb.c
index 4d841369399f..9a6befdd5e74 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c

@@ -239,7 +239,7 @@ static inline void fixup_tlbie_lpid(unsigned long lpid)
 /*
  * We use 128 set in radix mode and 256 set in hpt mode.
  */
-static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
+static __always_inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 {
        int set;




--
Best Regards
Masahiro Yamada
