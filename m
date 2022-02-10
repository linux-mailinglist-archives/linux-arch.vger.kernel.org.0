Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1E44B09BD
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 10:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbiBJJkc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 10 Feb 2022 04:40:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiBJJkb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 04:40:31 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A95410C3;
        Thu, 10 Feb 2022 01:40:32 -0800 (PST)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MxUfh-1oFX5L24aX-00xt21; Thu, 10 Feb 2022 10:40:30 +0100
Received: by mail-wr1-f42.google.com with SMTP id d27so8451187wrc.6;
        Thu, 10 Feb 2022 01:40:30 -0800 (PST)
X-Gm-Message-State: AOAM5330XjSYe/7nqSXVruoINMfqRxMc40GNJ5JbNMna/RyGeHX7m0Eb
        a5XYNc9XwQmLynFn4HsNXWHo4e+bNDiGAskl9Lo=
X-Google-Smtp-Source: ABdhPJxOhGkktvjEs/wpvFPsXEosQr6yPQWLtEscjbMpLHy9iLtcw4CraVI5M4aBdc/Azk2mkol1DndLfivhVLqUl98=
X-Received: by 2002:adf:f6ce:: with SMTP id y14mr1747654wrp.219.1644486030095;
 Thu, 10 Feb 2022 01:40:30 -0800 (PST)
MIME-Version: 1.0
References: <20220210021129.3386083-1-masahiroy@kernel.org> <20220210021129.3386083-7-masahiroy@kernel.org>
In-Reply-To: <20220210021129.3386083-7-masahiroy@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Feb 2022 10:40:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1t7QOB2tyb0tkLWXfDw0WHD_NZP+Eabz8KR2xfw9aTQA@mail.gmail.com>
Message-ID: <CAK8P3a1t7QOB2tyb0tkLWXfDw0WHD_NZP+Eabz8KR2xfw9aTQA@mail.gmail.com>
Subject: Re: [PATCH 6/6] reiserfs_xattr.h: add linux/reiserfs_xattr.h to UAPI
 compile-test coverage
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:OYK0cEPrf/9LUfrrC+eIDgFS8fFIiT8xBLg58iuxoDzPm3Svapp
 yBDoQJ98LBqlrQ/ex5Ajh23Y21A27BG84PhZu2+D0SQ71pLM7Po4wJHTDDMVXW+acrG57NZ
 2Q00QERs1qaM5KaOS7BxDw2R02dOWJKQXSmPHqtkLyyoN6/5zk1jQxUTWbReOeSBB7+XlpE
 sJ72U1rqjyWLJSQKyOJSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3A4B7uUcwjI=:eC0VIB4gIHZLZjvFM1zj7g
 GxNuyG1S7vWowke3ZYb4l7ADreoM+2ilT6NHYsoerGTE7TahaNB4K4K6ItiW8eZa+m4pHwsqJ
 py9bipnEQywqvYdNBn65DrokDVIIEGN/wQ96qPVKO2B25OBTehN8X0Eb4wwVnRZANplrOc7JR
 P9HRg+1R9M9b5JrDWCMAhr9FCMW2uzzO2lcRlrKL2VhrynjrBIG9gC4HEnh03Fafg35t9wPqW
 N8HyfPXbr1u3vdVAgRiKLzY3kuGgjWHMns3KYf6S7nBk8GwYMT7B4xnpHwtjJoK2se9jnZ7B5
 c+ienIJRwcgWEE9Nk1HBLuPmXkcO0c+zgXga/N3FbqANUvfkJlcnapl0kj6spBOQb+8pBZkVn
 8wqZ47blq8NpChCZHJrHNbBTkgi7W4MLoDhUiKK3QgfwnHjO93AfhMSqyIK1mvf9Y6+WNG6/K
 021pWUE6Kf0fG0WFnPm5NEIh+XEJrJmzYHHwGE9wq5uvknTiU+iL7Z4ghXzODXW+qcGwJ/Vho
 qLlBiMrllJN2TrzFp0Ky5rDA7X4ThT0HB3hWI8N5n+j6uCtB6xhcYbwIlSBDSf69a+bffI6Bk
 EbzMqkZmPmss3KlVLiiGRbCDhQuh5lc+O+Sb0wDaZeKCpziupVXl+GSBc9HSreMy+4I85dlhW
 A75lIOQj4b/w7QJ2St7Xam+BgT5dEFvDk4QMCCbZ+TzSxjmI0hjp+0EKiodjdPqz9ZleJlt20
 L8jmrrkhNnXZSWwapnqDvk1OSS05d2slN4VhABPEos7vQfTWMgachj5xaFh2OJEHCSvDhavGd
 r3wiEPG2oOZQ/Hc/mI2xcArx21zXGRnjARuJKEmzuTv7ugavqs=
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
> linux/reiserfs_xattr.h is currently excluded from the UAPI compile-test
> because of the error like follows:
>
>     HDRTEST usr/include/linux/reiserfs_xattr.h
>   In file included from <command-line>:
>   ./usr/include/linux/reiserfs_xattr.h:22:9: error: unknown type name ‘size_t’
>      22 |         size_t length;
>         |         ^~~~~~
>
> The error can be fixed by replacing size_t with __kernel_size_t.
>
> Then, remove the no-header-test entry from user/include/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
