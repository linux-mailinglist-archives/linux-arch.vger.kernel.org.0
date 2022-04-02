Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141284F02BF
	for <lists+linux-arch@lfdr.de>; Sat,  2 Apr 2022 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiDBNmE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Apr 2022 09:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355792AbiDBNl4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Apr 2022 09:41:56 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49023DE6;
        Sat,  2 Apr 2022 06:39:45 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 232DdMRx025764;
        Sat, 2 Apr 2022 22:39:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 232DdMRx025764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648906763;
        bh=DjlDOU+QMjAfHhVG3DyTJmpT3lFDSgL63YIdZlYs+Z8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lr+c/mzaLMgaRJRgNPfFw5IiHPTBdIkqnS6od8GjSnmMg1eb/tfOUlRtIZa9avst4
         6a+vN7acgrXk05PbtA2+68CSpCxEu2b8pDvOMtsa3kVBzY1VUx3xV2SsaO0tRog6iI
         vUz82EkYskvsy//IHP6ygaaH49PcaYrv6j4QGXCTfV6P93gftoO0mu/1XhpJkdGqeM
         zYvxnsjLo/Boqe/Llud5fzagJmZP/bZtw+2oopK+QVF8OTarhrLxZwRAwrBmF1uzXO
         L7vf71ky9ZM2ue421+N5i979hPn8k3UncyfwS6+Er752H6xLzsAtPwZpsRoZfz6ZxT
         lxDAEBNfS8juw==
X-Nifty-SrcIP: [209.85.214.174]
Received: by mail-pl1-f174.google.com with SMTP id a16so4644581plh.13;
        Sat, 02 Apr 2022 06:39:22 -0700 (PDT)
X-Gm-Message-State: AOAM532eHPbvHmxUeXtZsRMD6HwJg5CK/98dNMtLkRzYAAySW8Fg7XHg
        2uc1ePDBu08VphvqK1ZZE0qLSFjaosG0hcbhndM=
X-Google-Smtp-Source: ABdhPJw2exoLpxI5c+cAeuK679q0cyMySJSrkv8rzRvz/yceSC8H6FLOcidZ+Bg1m2/S7aiMae+xzlzCK43rihaAn5w=
X-Received: by 2002:a17:90b:4d01:b0:1c9:ec79:1b35 with SMTP id
 mw1-20020a17090b4d0100b001c9ec791b35mr16659993pjb.77.1648906761882; Sat, 02
 Apr 2022 06:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220402133544.2690231-1-guoren@kernel.org> <20220402133544.2690231-5-guoren@kernel.org>
In-Reply-To: <20220402133544.2690231-5-guoren@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 2 Apr 2022 22:38:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8i2xe2zFQo7mcJeujymhWB7hyp36UWS4Rp9T9dMUu2g@mail.gmail.com>
Message-ID: <CAK7LNAS8i2xe2zFQo7mcJeujymhWB7hyp36UWS4Rp9T9dMUu2g@mail.gmail.com>
Subject: Re: [PATCH V10 04/20] kconfig: Add SYSVIPC_COMPAT for all architectures
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 2, 2022 at 10:36 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The existing per-arch definitions are pretty much historic cruft.
> Move SYSVIPC_COMPAT into init/Kconfig.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> ---

Please use "arch:" or something for the commit subject.

I want to see "kconfig:" for
changes under scripts/kconfig/.



-- 
Best Regards
Masahiro Yamada
