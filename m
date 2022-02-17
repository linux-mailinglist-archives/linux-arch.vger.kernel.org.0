Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AAF4B9AB8
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 09:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiBQIOR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 03:14:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiBQIOQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 03:14:16 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CEC11E3E9
        for <linux-arch@vger.kernel.org>; Thu, 17 Feb 2022 00:14:01 -0800 (PST)
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MQMi7-1ngy8M3ALh-00MOq1 for <linux-arch@vger.kernel.org>; Thu, 17 Feb
 2022 09:13:59 +0100
Received: by mail-wm1-f51.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so5557244wml.0;
        Thu, 17 Feb 2022 00:13:59 -0800 (PST)
X-Gm-Message-State: AOAM53381HHA5vp4snixU6NiE9mfa+5Cwss20iiReJm2nrDFJaXjjH3w
        k6Ex5N3wURAjUIlFlVXaK5lBh3hUT1J1gb0gBBA=
X-Google-Smtp-Source: ABdhPJwu2NVHGHLxx29UDj0eC2QtTDz9ABoGgqvKd5FtPXFo3D/c1j3IHxwDsslquGRbQQhg+y3kZFZQ6qJy+rJ75Go=
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id
 l39-20020a05600c1d2700b0037c74bb2b4dmr4990966wms.82.1645085639420; Thu, 17
 Feb 2022 00:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org>
In-Reply-To: <20220216131332.1489939-1-arnd@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Feb 2022 09:13:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3QBWDYjr6VpPdjTBGFg88DdH3SHVgxEowgScgJOkNguQ@mail.gmail.com>
Message-ID: <CAK8P3a3QBWDYjr6VpPdjTBGFg88DdH3SHVgxEowgScgJOkNguQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] clean up asm/uaccess.h, kill set_fs for good
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>, linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ClW7nLWsEqWMRne8UTUUi6/tWireewy2APY9O3Q2q4MboXl66If
 7hE/8cE3n4ZLizgaf37bMFwUY+rmGqRqtCRjNoAidXGOOoD7CTGwvrVvkWnhbbfs63PkqVH
 B9cgu/mjhWtBMOwl5RmFUVJDzxjXSdeVBQmD7lHKVeP2tEeD8Jq6re/vmQyNFmcFSYrxeqd
 q2Ws1mCyasxsY+znRGlew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z0bV0XIogP8=:5oSsTlWzebEgzH+gdKr9zI
 DnqyMcAvjJaqlqftY2Mq80b//dnoZfbPU4vP1xIfKCogUZ1HZZGgPL7AfBXOCDwulq6LF85Xo
 2YklIRuHaW4avTX5q8B71DGcsoKvrQROaRn+7NvVbUo1z43cadyBWoTRtCUu7NQjwWwbbHm3A
 lWj7cGY16KzELGjGlSSLfRI/d7Gwh+Up1KIPX0MMH1EQgZZ//bMraM0TGc3Rzjf4zw7MGx8P5
 +AjcnNDUGKNWmA2Cgav+V1RaEDd5ZnaoHPclJRK3Sk9nKcGyCr7fVuzcGQF7+EorJYPf9d0G0
 EOYLmup2EnPZ1DZitcuVBGnjq9TrgDB6Xv7jGlOQbRZcn2t0nf9QfJxEvId0bPwDzV5Wu5N82
 TaLk1YKEmwKsuQWtMy2QYxJUCXpqFgJZ7saTmWrdfdynVLWNzXtAW7wlmNUXL62x5ltdoNmzI
 B4/TkpYfFePfJ9/G7/6zn1GSGFKWiYOm4izXd51RW1cTMV6vO/XCxOTPKzUULuNtnbIchEYEI
 DESKKR8H1OYbxe6NFIIMRJP8kXjIthRdCrJrZ9/3MplWJdsAXOriVq9k1lV2y2nwRiNidW5/p
 Lh5jTqWNIY918l7Od78AREz7cnm44TAG7JR7r46heah6pPGj4VModbweEd1qHtz9TJOvTUXfk
 rPmVzeLbbtT5soS0BdXo4KCH1SC1whaWBiwMPXoGtPNi45mtNWo0DPIUvGz6RFefN+7BUpwQq
 FDIptHVVZeOSO5bcRk3BFcY+tYU0lR4lOG7ouME6tvqnCQ9SXGHSKr15VRaHpJ1a+9XJdw6he
 CydnGHm121XVFSpxElh+df3CJmjMAd1DH9Ctk0Wzlt+ZgtTuqg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 16, 2022 at 2:13 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Christoph Hellwig and a few others spent a huge effort on removing
> set_fs() from most of the important architectures, but about half the
> other architectures were never completed even though most of them don't
> actually use set_fs() at all.
>
> I did a patch for microblaze at some point, which turned out to be fairly
> generic, and now ported it to most other architectures, using new generic
> implementations of access_ok() and __{get,put}_kernel_nocheck().
>
> Three architectures (sparc64, ia64, and sh) needed some extra work,
> which I also completed.
>
> The final series contains extra cleanup changes that touch all
> architectures. Please review and test these, so we can merge them
> for v5.18.
>
> The series is available at
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=set_fs-2
> for testing.

I've added the updated contents to my asm-generic tree now to put them
into linux-next.

         Arnd
