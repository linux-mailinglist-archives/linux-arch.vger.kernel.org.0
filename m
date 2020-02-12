Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F74815A9A0
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 14:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgBLNDE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 08:03:04 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58959 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLNDE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 08:03:04 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MgRYd-1jhmbB30Rj-00hwqJ; Wed, 12 Feb 2020 14:03:02 +0100
Received: by mail-qt1-f171.google.com with SMTP id c5so1465166qtj.6;
        Wed, 12 Feb 2020 05:03:02 -0800 (PST)
X-Gm-Message-State: APjAAAWRWtdXZfUQUTC8wFCdhHAnjmvxzzn00eJYoFtelnYyjnmzaduT
        ZLOf6hkCtvd/0EvTZGmWkJTBWKck5aI4ueOj6ic=
X-Google-Smtp-Source: APXvYqy06iM4mphE8iImJ5H3xGHM0E61H0W3gl72SDsnuQ8ERp4zy8pETyfnDlE0AXLBVDG71JEvVqBMlcGftON602Q=
X-Received: by 2002:ac8:1977:: with SMTP id g52mr18800788qtk.18.1581512581526;
 Wed, 12 Feb 2020 05:03:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581497860.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Feb 2020 14:02:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1NymovoUxYBF8Ok8Rfke7ECW49bmc+K-=vtH_Bz8_7jQ@mail.gmail.com>
Message-ID: <CAK8P3a1NymovoUxYBF8Ok8Rfke7ECW49bmc+K-=vtH_Bz8_7jQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Hi,
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Cornelia Huck <cohuck@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mubin Sayyed <mubinusm@xilinx.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dYBbjfk8Z7SogIlHkWnFJ6gFDKjQUD1ts7iX5TjNDEwv+GB/QB2
 xjMGy7pc5+Dzq0zrrM6MYBYXjJSCkIEQpiKomeNMc8LsD2PjcHNWJfhH0iPTdTsWtdeeFJI
 kVig434j7RwFrzXVuQ+y1s8yuO/NV4MNy7MtE8D+NlkaN2bxdsF08GaNkgjcMZmQ9Q+IlJJ
 d0qWW2kRHSujsPIuW41Uw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:efXOSkONAIg=:aEwYcKVo+l66r/Gv02BnMG
 yYo0mAAEwCxHIdeu6JbZ+rmeydcpnORwtksxJN/t7ROs8TegQp8KSUvlrgb2x4lx5zjT5wRVP
 6ylDZTPegC+1u+ULugfAzLXVJCrqe6dWn6+10X2V0Wt1HkgwLMW7EUto+/w7IqcMhiOJV5QRR
 u9OR3/bta09DyOhqQfCMrjebk3VliSGad0ZgAYVmgZgUc4V+O7bAvlqZH5vSYtk8wD+4W94kp
 QXj/eFXNP9pVYGNwJFTwmvwgDD0yYZG8GMxx4DsMS54h1edK8K1AZgC5qmruFY4RG4Dtec+TE
 OJICgMmlmja/T6UUOiNB4RjGrfHcjW8bwHEzfDMdCYRFPQVZTklQzcp6Bej14TMDN0dHvwD7T
 Vtn5sebb2uVb3og/6V1KeLBcHbGbZcnAhsNgmlvovDgpDHwkAkni8QG3hOYQl9euQxYykZ3Vs
 AyutUPdqBLny335336I/cruO+eYYjWeL8Yk1AnhKuaNTAMKodRV1aPysAum4EhQupgMTUiKrD
 h6l9zxgNdT0sSpSJj7ocG+cRlnrcN8K84ewcYLQ07T4kk2rBI476W3RjA1p4hlhdyVPIBRXfq
 Iiy7A/QJu9dYJR5HpmFJoBGNJf/88Bs1/gWzgzMkDo6nEw+9xOPe2bWgXUQnguvZIi9fJtkdP
 qfVgoJm8XF2gNvaOFpeBcWbJnS7r43pgjGK+A5BY9UAHQhUQJqxTozXsUicQFDLFEAPvxuHF9
 +YVVHG6mm5qFLdfUH3SiYkw7HQQFntMgcABQGcw/yqHhPzc0LpUkEJ+R8FjhT/iMNt2FdNrwq
 cBHQdb9uHX12sxg+7OMqlhUtYaMuurNUUp2NPB8wizou3gQr4A=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 9:58 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
>
> I am sending this series as before SMP support.
> Most of these patches are clean ups and should be easy to review them. I
> expect there will be more discussions about SMP support.

Agreed.

I had one question about a detail, other than that:

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
