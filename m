Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A3C4B5C6F
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 22:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiBNVQJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 16:16:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiBNVQH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 16:16:07 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A1011B32B
        for <linux-arch@vger.kernel.org>; Mon, 14 Feb 2022 13:15:54 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o2so33175402lfd.1
        for <linux-arch@vger.kernel.org>; Mon, 14 Feb 2022 13:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgwPr3jWEXZiHeYJRBUfKrH3C5wLRAnP7Z6R5s1EJ5U=;
        b=ZcumWtnhggjMFDUHhywZOsPSWocj5WFiFD4wxX4meGi3Jv+FEek8bAx8wm544tPFuD
         FZMy/4sQc4BwvneObDdXEv1mNtlI8GPACMt1JW8whp1hkRcRU1/uCicaO7g7UXSaSO+q
         JQ0jz81cHBjFl3QlKdIkLJ7hR07DlS4kmaNNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgwPr3jWEXZiHeYJRBUfKrH3C5wLRAnP7Z6R5s1EJ5U=;
        b=4IgwWOlRhH8v/zPfccDwmY7Ygu2R5rZwvstltU+/AmokNlunGLWpY+DQ4RAjj330Y7
         xzmwktqqhuJ0M7zG+JLbb3qn40Ebe/idJsoRtoQjYnYAPp1qyf9b5Y8u3EA7+e3xVNOu
         NS1RPF2tJAYccM2K/B5pzSNLdi7216WWZkVrU0DztZKEh3sMTAOCIjDXZKsh0LdEA2je
         il9uYVpV6zJtnZre93jvqITElvOjRRi49oFJhSVeeU6kY72xpglMp4lNYXQZzF79THZZ
         on6hH9E3KiY5BzbSbpSSYgnVg+9IhzvTJc/YUkUZzaXDhcHm52KxV92dJVgSRJuvjwc6
         1olg==
X-Gm-Message-State: AOAM532HgyADgRpDb2LI9/LNmeH2DF0Ei6Y+BRCw04ZH4H1yED6HTKhi
        EspnfmCwAuQ+FwU38Rp4NbsNtX3Qqsd1EuQo8h8=
X-Google-Smtp-Source: ABdhPJykLEs8kiEVl7VjtDyC05wU6netIcqmoAwoYr7XaWUoASuA2WUG1ntMqa4zD00FUng7aoGCDQ==
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr220795ljp.451.1644869224133;
        Mon, 14 Feb 2022 12:07:04 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r13sm398148ljn.34.2022.02.14.12.07.03
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 12:07:03 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id n24so21124499ljj.10
        for <linux-arch@vger.kernel.org>; Mon, 14 Feb 2022 12:07:03 -0800 (PST)
X-Received: by 2002:a2e:a231:: with SMTP id i17mr205093ljm.443.1644868881602;
 Mon, 14 Feb 2022 12:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-5-arnd@kernel.org>
 <YgqLFYqIqkIsNC92@infradead.org> <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
In-Reply-To: <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Feb 2022 12:01:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
Message-ID: <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
Subject: Re: [PATCH 04/14] x86: use more conventional access_ok() definition
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Helge Deller <deller@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Greentime Hu <green.hu@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 14, 2022 at 11:46 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> As Al pointed out, they turned out to be necessary on sparc64, but the only
> definitions are on sparc64 and x86, so it's possible that they serve a similar
> purpose here, in which case changing the limit from TASK_SIZE to
> TASK_SIZE_MAX is probably wrong as well.

x86-64 has always(*) used TASK_SIZE_MAX for access_ok(), and the
get_user() assembler implementation does the same.

I think any __range_not_ok() users that use TASK_SIZE are entirely
historical, and should be just fixed.

                 Linus

(*) And by "always" I mean "as far back as I bothered to go". In the
2.6.12 git import, we had

    #define USER_DS          MAKE_MM_SEG(PAGE_OFFSET)

so the user access limit was actually not really TASK_SIZE_MAX at all,
but the beginning of the kernel mapping, which on x86-64 is much much
higher.
