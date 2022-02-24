Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DF64C28DA
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 11:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiBXKJL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 05:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiBXKJK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 05:09:10 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAA028A109;
        Thu, 24 Feb 2022 02:08:40 -0800 (PST)
Received: from mail-lj1-f182.google.com ([209.85.208.182]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mo6zD-1o2IUW1RQB-00pbU6; Thu, 24 Feb 2022 11:08:39 +0100
Received: by mail-lj1-f182.google.com with SMTP id bn33so2071645ljb.6;
        Thu, 24 Feb 2022 02:08:39 -0800 (PST)
X-Gm-Message-State: AOAM532G8Nc3Lr+kfTgtRAzsLg/iGKWg5v1Px0de78F49wEhGEADs0E2
        94bcPp89euS1fmF54swAl9txrZlXM7kDSpE9kGY=
X-Google-Smtp-Source: ABdhPJzPVQaW1f3Bbzw+kTDiMg4Tajz+c6SJ2JtQUsJaSw6D1lJ8eGh3OG9MaDTzij1odC2MMgMswcl0VWfIMCexGbY=
X-Received: by 2002:a5d:59aa:0:b0:1ed:9f45:c2ff with SMTP id
 p10-20020a5d59aa000000b001ed9f45c2ffmr1412807wrr.192.1645694019453; Thu, 24
 Feb 2022 01:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20220224085410.399351-1-guoren@kernel.org> <20220224085410.399351-17-guoren@kernel.org>
In-Reply-To: <20220224085410.399351-17-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 24 Feb 2022 10:13:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a13_VBpTidoF_pUdV5g0MFqpSe17rgw=XUv69CCFCN0_g@mail.gmail.com>
Message-ID: <CAK8P3a13_VBpTidoF_pUdV5g0MFqpSe17rgw=XUv69CCFCN0_g@mail.gmail.com>
Subject: Re: [PATCH V6 16/20] riscv: compat: vdso: Add rv32 VDSO base code implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:s5S3jWFc5RkWSW1T8zhfkjyFM+NtY1UTK5PZjDzVdrUIGCAi+dI
 1HMN5WMb+Hx0SFXx6NYytdF/RHKuQjmxKquYmQeOY4IIuD8EZh1pQGcStz2/KiODy/IXQw1
 rR3LEQ6hrUugBHhsHBUc7/pMDiVlDZDiZrQ24lKsFeLjTelCk2E0iok+2h5fPKfXbu12FL8
 6xq9n2NG0QYZrlyCMg3TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NiNxplWOlyE=:cKTvBCD+xcsnkPA7P47Qo3
 7LIAQUjMulhaEHwuIGgZJV+qdzepuabf9FmzSgmBt2fSUfDtN+WdH68SdgbXreVkFdN/u8vsO
 /2IOcRklgJiT4/hHojoNvx3Nr0Nq+4QHrBqwmrHCd8YKftGez64ervPAg4gAHdqFvyqcgH6zJ
 WoJXjZLSyo614T5KXcvUMo6k0s89/QZxmYzPzyhT1d3GjW0oH9QWwNtOVBM50UKNUVofEtSNU
 YEeOGt/Lz6jRukL4DhrJIWdPxtatgbtiuqfl6nxhWbZkQqFBUk+zHMV+bkRiBJd616S0W01GJ
 QWToZ6TQhWK02oemfQZc1mGczFNWPW7Om0UlrrtrsuCQFXbu8TA8SEzY3qYY47AzbStQUHoij
 OwG0oMMRHSBo1hbiZF8JQ5uhnKl3H+xYezmaZxEQrmCDBaMQWhTXy91WK1VwfV4yw2wclXkWp
 4+gnwqaz9En6vLo4ULS06NJGq4Qheonqp2SBEuAW9kyDR0AHau5dD8+lnwvw+/LplMFeyo6Hw
 NJ9xsHWvj83zU9P+ZcsmRIliMnSwTLqwQ80U1M2S3pty23lFkULF1PEy9kDb03K+DiNxS6L+t
 wKeMKma+atCJd3T2XORM6KaPj/RmAcf94t27JBU6mF4jJkPWFZAxNuLbM4IzWbzjJDmMcNc6k
 +sbw7p1zwytolKDdL+LlACrbRds1w/SNWdQ1ZP3h6H5ql1HTjp6/dXUCoA0rPOkeJ5OAfJw6r
 4MRUG/jUm2JV5nqc4YJIaQ5RsYKMNMlDpcxBSslA8vfoeJomInoailMTI4EK95VCutL8BWUQW
 uAj7JlXByDwzU4cLV/bUpiWZ2jFHzWp5GarE5btpKFCczLJ0Pg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 24, 2022 at 9:54 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> There is no vgettimeofday supported in rv32 that makes simple to
> generate rv32 vdso code which only needs riscv64 compiler. Other
> architectures need change compiler or -m (machine parameter) to
> support vdso32 compiling. If rv32 support vgettimeofday (which
> cause C compile) in future, we would add CROSS_COMPILE to support
> that makes more requirement on compiler enviornment.

I think it's just a bug that rv32 doesn't have the vdso version of the
time syscalls. Fixing that is of course independent of the compat support,
but I think you need that anyway, and it would be better to start
out by building the compat vdso with the correct
architecture level.

At least this should be a lot easier than on arch/arm64 because you
can assume that an rv64 compiler is able to also build rv32 output.

        Arnd
