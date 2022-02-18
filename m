Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187044BB4F1
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 10:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiBRJDu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 04:03:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiBRJDp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 04:03:45 -0500
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AE369CFF;
        Fri, 18 Feb 2022 01:03:28 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 27so2073038pgk.10;
        Fri, 18 Feb 2022 01:03:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acpcDWZvSxDwOAzGTb7O2RMIWdslBDMuoEt9Qz/Phu0=;
        b=LTM47bdxH3KvatcTOZ0SyhwJwKWZCBDrhBkA4wakl4Lq/Zc/0vFZtuRdy3m59wbRg6
         GT4vGr+wHZ854SjCHkA0YAYZ/AB9tMRbEhDmDFhVxraZspSMy2P8tfWjo4C+ZDJhXTmc
         CR5Ap3rRL8OiLG1MJVF0juyv/ZiqnlVSbfHgx4G9fX/eWRyz95I+vOcFt/UgF1R0bUGV
         GyxCrxVwX+ueW5S5CTqXDfoRW03sy9xUqphZXyUVVIsx0iqT4cyOLSGh/1DERxafuxpS
         +xiQTqAjA/9Xo4vGwDC+2Hlhuz82RU68XRvhDniweyICkxhbal7vvmxF7wOMfHqibJea
         kt6g==
X-Gm-Message-State: AOAM532m13OMRxaiqcQ/zGy+5b8ez0koiv5rvHHFaBYkVPkvFLVUVm10
        H2NGZb63JME5A768pLi4swnJP2cC+2uqfA==
X-Google-Smtp-Source: ABdhPJzPBL5STQ5SWVtgWhjt6OOwuimkBzdG1JZ8lxPoqw4kSbCf1q9z8LT5qoUE8q7ghKppplSXfQ==
X-Received: by 2002:a05:6a00:16d3:b0:4cb:51e2:1923 with SMTP id l19-20020a056a0016d300b004cb51e21923mr6690786pfc.7.1645175007970;
        Fri, 18 Feb 2022 01:03:27 -0800 (PST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com. [209.85.216.47])
        by smtp.gmail.com with ESMTPSA id f7sm2343490pfj.48.2022.02.18.01.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 01:03:27 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso7911105pjl.4;
        Fri, 18 Feb 2022 01:03:27 -0800 (PST)
X-Received: by 2002:a67:e10e:0:b0:31b:956b:70cf with SMTP id
 d14-20020a67e10e000000b0031b956b70cfmr2916488vsl.77.1645174557092; Fri, 18
 Feb 2022 00:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-9-arnd@kernel.org>
In-Reply-To: <20220216131332.1489939-9-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Feb 2022 09:55:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVtRh5GHutxGf5dzGHBca7G4td3qqDTHM2KgoDr-kJ91Q@mail.gmail.com>
Message-ID: <CAMuHMdVtRh5GHutxGf5dzGHBca7G4td3qqDTHM2KgoDr-kJ91Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] uaccess: add generic __{get,put}_kernel_nofault
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
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
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 16, 2022 at 2:17 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Nine architectures are still missing __{get,put}_kernel_nofault:
> alpha, ia64, microblaze, nds32, nios2, openrisc, sh, sparc32, xtensa.
>
> Add a generic version that lets everything use the normal
> copy_{from,to}_kernel_nofault() code based on these, removing the last
> use of get_fs()/set_fs() from architecture-independent code.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/include/asm/uaccess.h     |   2 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
