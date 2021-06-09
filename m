Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774BE3A12C7
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 13:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbhFILea (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 07:34:30 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56329 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbhFILea (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jun 2021 07:34:30 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MeTHG-1lIhYi06xY-00aXJb; Wed, 09 Jun 2021 13:32:32 +0200
Received: by mail-wm1-f47.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso4037255wmh.4;
        Wed, 09 Jun 2021 04:32:31 -0700 (PDT)
X-Gm-Message-State: AOAM531MtLqkz6c784MFtQZns9lthn21/JNIrLLelOQnk1FoPQu8fEM0
        GWOQGmM2juT/VRjRxeEztY/WzXmANm1nRMzNoGU=
X-Google-Smtp-Source: ABdhPJzoAPnjJWGlDyxsxVrxhheEMZ1P753dKM++est77A1JSiUJC5TRRvOf+sTRALv47GHRkLWv+YzLbHb9Ukp7IwY=
X-Received: by 2002:a1c:7d15:: with SMTP id y21mr9135927wmc.120.1623238351528;
 Wed, 09 Jun 2021 04:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210604064916.26580-1-rppt@kernel.org>
In-Reply-To: <20210604064916.26580-1-rppt@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 9 Jun 2021 13:30:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2tZDJDqgr9-1vJrnbDhd_36eKq8LMEznDkU7rvuAnAag@mail.gmail.com>
Message-ID: <CAK8P3a2tZDJDqgr9-1vJrnbDhd_36eKq8LMEznDkU7rvuAnAag@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Remove DISCINTIGMEM memory model
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:H5v968KC2M79DkfYJyPJxj8yupcPqCQCJ1N4Z1HmTCSClKb4RJo
 ba0OO00j+bQ0/ZfbbpxKSiQVStQhbD856cKnMY+4A0fxTdaC6uxId9Y1ipxTmxRBkJuctyA
 Y1reZ/b/kYT1BSOx482r5mSswn4b7jlFqgsC78pIMEkGVNc1cjI0RWjJZWCt4GG6WoMXbNZ
 Ljxrl+h40xce8+eZXhgpw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5bmpDHZqtKc=:Snj2gFdCvD9hMNFA7myfNf
 S7TJYfwc92EMXo9TCc/9co0khSPe0xtvvBaf8aiHVsurZ3oP2AmcRX6BVUP7Xkj9BDw9JrZ8r
 Z2wILA9mD/T8ZjTMdp8kP7qRSEOVHhc7Au1DQbVYZorVj7P2leDN1uEjVAhYCl9pkDkOhflPK
 vR3qGESRcP/fRxk0ek/C5PAEwYFJjR5/IGZq2vJEr7WZdjAI+bQjrRwd+D7thELunwixQ+PpT
 WI8xpyv1ks8xUxKZI9AWGNw6UhNUsBufMWKZ85ybM1bhKHgP4NQsoHnWhobO8rOzd7mmp+jxB
 EQh62WMcePgVMwuNW5SPP4rcyv9jVb4grdp2JrCbcR8rqJzreIfWKIdLr156lCln5HUoPhyOz
 ntXk9hTPzQ2q7S3c/MqI0in2kpmJVNcVYFmVrGCmGA8tZ7xuH9IOakNeAFkCRFqBUgKX/IXpl
 UEQflHiNkQiWJe4xHAM7PtCA+SqMph+XVbJl6LVS/uvozw/5S4vyBWrztTOXrWo7TaJflWn5P
 kgirFMtxuf9q5XsoobMr8Ol4RQnTDMy8uXmfTDS58mC/9bsqrpXrOnVt7H9AxIUxbuWsocMKR
 GATG5+nWJuFn2SSP0/UPYKl4jJ1LD+cCBubY6cirUnIUoYxqSzBOh21rRTqGQSReM2zHPuCDc
 5yks=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 4, 2021 at 8:49 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Hi,
>
> SPARSEMEM memory model was supposed to entirely replace DISCONTIGMEM a
> (long) while ago. The last architectures that used DISCONTIGMEM were
> updated to use other memory models in v5.11 and it is about the time to
> entirely remove DISCONTIGMEM from the kernel.
>
> This set removes DISCONTIGMEM from alpha, arc and m68k, simplifies memory
> model selection in mm/Kconfig and replaces usage of redundant
> CONFIG_NEED_MULTIPLE_NODES and CONFIG_FLAT_NODE_MEM_MAP with CONFIG_NUMA
> and CONFIG_FLATMEM respectively.
>
> I've also removed NUMA support on alpha that was BROKEN for more than 15
> years.
>
> There were also minor updates all over arch/ to remove mentions of
> DISCONTIGMEM in comments and #ifdefs.

Hi Mike and Andrew,

It looks like everyone is happy with this version so far. How should we merge it
for linux-next? I'm happy to take it through the asm-generic tree, but linux-mm
would fit at least as well. In case we go for linux-mm, feel free to add

Acked-by: Arnd Bergmann <arnd@arndb.de>

for the whole series.
