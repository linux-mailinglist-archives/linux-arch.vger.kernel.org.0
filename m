Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFF64B09C8
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 10:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbiBJJnl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 10 Feb 2022 04:43:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiBJJnl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 04:43:41 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0184E1BB;
        Thu, 10 Feb 2022 01:43:41 -0800 (PST)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MgeXk-1nwcs41RTo-00h7yy; Thu, 10 Feb 2022 10:43:40 +0100
Received: by mail-wm1-f43.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so3468824wml.5;
        Thu, 10 Feb 2022 01:43:40 -0800 (PST)
X-Gm-Message-State: AOAM532JwDf3POmCopHYLh2DzZ3lh24A41yljzMQ+cmwxfysF34oCq5Y
        g1ijoSvTAprst/U+KGpc95i0LGlAlcq5AUmps2U=
X-Google-Smtp-Source: ABdhPJxz/eqKEs4fnMzd31N8Ek7mZHkSuLYxkDDIzQxCzRaNTAqKKXmf2vdNRBBlVDBOLVMV8IT5WJLIe3bvutSK8sk=
X-Received: by 2002:a05:600c:1f06:: with SMTP id bd6mr1432657wmb.98.1644486219958;
 Thu, 10 Feb 2022 01:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20220210021129.3386083-1-masahiroy@kernel.org> <20220210021129.3386083-2-masahiroy@kernel.org>
In-Reply-To: <20220210021129.3386083-2-masahiroy@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Feb 2022 10:43:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a10x85nurc-zHvK5FaDk=fAAxbM+A22Dr4pBetkh_sEDg@mail.gmail.com>
Message-ID: <CAK8P3a10x85nurc-zHvK5FaDk=fAAxbM+A22Dr4pBetkh_sEDg@mail.gmail.com>
Subject: Re: [PATCH 1/6] signal.h: add linux/signal.h and asm/signal.h to UAPI
 compile-test coverage
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:FeNgd+SHwhPK/EyAldHBHuVOIno/16RBlKIdol+1uVTWeiqkSXE
 dak0WYIV//Z0rQ0E6mSuCL9tl0N+5vDortok9O5q7uUEYgv0/hoADsYEQXfRVyIPPunZTXW
 fB3eNsk7TTkS7eQvR66he0n0omNryUmPKKLmDvb3xz1icwzQoAALS87MsDhegtt0z/R3mNQ
 ObUiFOPycsOXTL4nv2BZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8DNFTukHtjU=:zXNY/wymKHCT8wmEBS3pUr
 FkL5tLC3uWP6Mh9FQ1WjGGkxIxQB61lMGKqKEDhM82FGuL90geUz19lOSMoxArnaX4m/Kp1sA
 rJmNCaAZXUDLQLWwatugOIdhDL3Zo7Y9k5UYGGBPIlL8pcKHBLV4Yt5zpniskes8JMJ0Spgl/
 G0FGF2thkfCVhVDX5OEVFtVaVizv4hpmxrJnmIPkFbgN4jAcs3sX16PMIAU2hERca1ZP4Csk1
 hna1oZqyQEzd0c2RrZzoUtMrJ0Ol+00P8Nng5/a0kX7aMh1DB12HGsdkAeH7rcGdt5h73wm2M
 sCIXn93FD5Zii6CenDOdit18W7Frv29tPkecD/uuq422KtOH0ml64XPxeFsbLJjylxVLjL/5r
 svRgqcMnJRTqGMmirZHOIMjQs8EE89zeJyFdcBiKuDPbv7RR5vwEM2r1WkfDru1A8FAqvXUyW
 7zP7wERwtwyoacwxPDgWMmG3hVs3lnKOOkCBjK68QlS0vAd5TZSZa0TwZhoXSc99P2vguYOZg
 3c/yCHI4so6GeMfmYv+qZVjwegD54UxTLEHu9m8W8ft4Tw/5JDoXyaT/9YuA20iCOcWK4AINp
 JtF9OyjALGgRh8sQJlaFC/SZkSdJRtlxP+MPFB5xGPu/wttNMjANQs0wtwfhr+yRtGgxN7aO9
 ft8jBWD3drZ9zXG2SeSpbGSrxbBoXh3cfxQWVcyx1dIYaoPknBO6FkrQui+4UzzpHZPIW58qQ
 zNTqA2BbmofFl6ISzh4G1yqdZwoVmZiMdKQUF224Y3wp7Vj8DeClql7jbg/rVBFaOalUvv5AA
 MxvhyjmBPJpoQyzpm6v0vfSAwNd+49CwP2JrHi2oMm9C7XlJsM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 3:11 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> linux/signal.h and asm/signal.h are currently excluded from the UAPI
> compile-test because of the errors like follows:
>
>     HDRTEST usr/include/asm/signal.h
>   In file included from <command-line>:
>   ./usr/include/asm/signal.h:103:9: error: unknown type name ‘size_t’
>     103 |         size_t ss_size;
>         |         ^~~~~~
>
> The errors can be fixed by replacing size_t with __kernel_size_t.
>
> Then, remove the no-header-test entries from user/include/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
