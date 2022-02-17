Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2524B9A4F
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 08:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbiBQH6K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 02:58:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiBQH6I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 02:58:08 -0500
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 23:57:53 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA5EE015;
        Wed, 16 Feb 2022 23:57:52 -0800 (PST)
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTRhS-1nhaUr1zAK-00TmQM; Thu, 17 Feb 2022 08:52:45 +0100
Received: by mail-wr1-f54.google.com with SMTP id x5so2599562wrg.13;
        Wed, 16 Feb 2022 23:52:45 -0800 (PST)
X-Gm-Message-State: AOAM531TqIZdxzgjKe4IT23BQjAj1r63uuynd0Qg8QWg7OVn4Y2HxdBL
        jgNv3OGPn/PBpOvnautqsDKZ5B1nfPHZOSMxt4U=
X-Google-Smtp-Source: ABdhPJwQLFNR2EKsG8wmZOAHPh9E9pyoICR3LxZT862dIjr2W4W3Sw6yF+ayzR5i5e/QGR8IN4+3KhdYVHoGFF4fNyc=
X-Received: by 2002:adf:ea01:0:b0:1e4:b3e6:1f52 with SMTP id
 q1-20020adfea01000000b001e4b3e61f52mr1268592wrm.317.1645084364936; Wed, 16
 Feb 2022 23:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-14-arnd@kernel.org>
In-Reply-To: <20220216131332.1489939-14-arnd@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Feb 2022 08:52:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2T1Xr80GeM-3p1riyq=gKDJGeKVz_c5=r5=s14tXimLw@mail.gmail.com>
Message-ID: <CAK8P3a2T1Xr80GeM-3p1riyq=gKDJGeKVz_c5=r5=s14tXimLw@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] uaccess: generalize access_ok()
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
X-Provags-ID: V03:K1:6qcGhdTsQQvMIjB+11ipNF1DrG+OLInVcjYi4AXjSR4T+7w4a4G
 tvj/SU8V3XwoOWQPVG9LxfZPKnFfLZip/Q4k4pg7UiCm4QGSGIJG0sIDDl9GKfICP6+qAIY
 2+TUcn5VnZN+i0sxBK5Yt242p2TWzmOaCg69Dt9OeqZlWdjtizeah9g/3PjyvE9B+9lCD1L
 cKNv6Z/s/LgftziOoQUwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3CQ1JAQGrF0=:m+j1qyGbULyUrnu+pAp/L7
 aw2zyOJvMBLpw9qPx/a/bOtMxNuxcAk4Jy9S5iNS3gwExa9IDRJeCo9FzAcs5CkTmB8as+kq2
 pw5HGfQzw8FU3GUy3sY6zV0y6wbve29dF/0lUxWFW9AX73dPVIcVOLHIJReSQ6uRCx9XL6HEz
 QYbG3u6zOALJFWaHRDLwwN36S51Yf82lrMKvYa2X/WzbS27K1K7Oo1Mxpwwl5NEBDT65a0Q43
 OjUKlX4MhriB2rc4v2vm0fRspANdluMzAzzaW4nuy4UrcwYPDM+hyz9ml5dyDcc3rynlbBdSO
 XkAjx5LNO5eUkjbT+WkGwIWQZ5M+eFbVvZINJV1j9hfgXbS4vuU0lUjecWPH+e38xlkQj1QB0
 bbZ+73nYCnC4RWT6Tq1g3Ogu/velbg4oNCi5rcTpkkzoOD/jkBCylL4lG7VcbVV+XYKeknUZH
 hgpO2NaBKeXLaUjHHQKcTUmEoCEikK6Au956S8X1Wh0TQ4TTv8ERW0C0OF4BTSCCJmgrSv1TX
 IEGgutddy0JqQM9rEBMu1srM45PA/+NAose2E/g7I0GcEZXhdCudb+qW7KR/q60qDbrxbIQFb
 yyrEqvFWqMKjAU058gdzCyKQPyNg2dqGSlDQ25u81S5XpvSaQlxlFyo3c79bak+h9fAukbbkS
 oZ0bFwa97SwaIdtR17B6CX9hjxNTXJzgOJRPcHEUddroS2hHh4wZjyeYH/ZHn9DnVXm1jxcT8
 KrRtnkWhcRc6GiHQtcdftL3xV9SeeCOB0j6P03kbC5JMDBruIYMMR51bo20MnVDNE4yXDkRLb
 q8X7G+we4HTJA8p7nK4nn4s6ubx3+CJAbJUDq0nN/UzZpW5HSs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 16, 2022 at 2:13 PM Arnd Bergmann <arnd@kernel.org> wrote:

> + * limit and catch all possible overflows.
> + * On architectures with separate user address space (m68k, s390, parisc,
> + * sparc64) or those without an MMU, this should always return true.
...
> +static inline int __access_ok(const void __user *ptr, unsigned long size)
> +{
> +       unsigned long limit = user_addr_max();
> +       unsigned long addr = (unsigned long)ptr;
> +
> +       if (IS_ENABLED(CONFIG_ALTERNATE_USER_ADDRESS_SPACE))
> +               return true;

I noticed that I'm missing the check for !CONFIG_MMU here, despite
mentioning that in the comment above it. I've added it now.

        Arnd
