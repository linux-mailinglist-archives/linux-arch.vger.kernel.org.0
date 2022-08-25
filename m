Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C805A1011
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 14:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbiHYMMi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 08:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241452AbiHYMMb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 08:12:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1D4AB184;
        Thu, 25 Aug 2022 05:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 254B8B828F2;
        Thu, 25 Aug 2022 12:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38A6C433D7;
        Thu, 25 Aug 2022 12:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661429547;
        bh=+4STZHMQ1jce4f2+SMZsLIGUYrwOhWD8GQZ/yZsRpmI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PN87TXhi9UN4nkB3tCt9JDnFNXmmOMqkAeoMHhyyzZRiRkVJY0+y5L5sTaPrf1BoC
         AjCqU04CgErJg7uOIzh9RS6i9+8zJbMsRZX6q7KqKFDeQ4qKX3Xzr96LLomKNiJGMG
         Psn98FzTuAUY0rnqBGK/eWQtDetcmQ304Yrum1PA+Wr0tMTcQIvGjFfZHLdrtEYbfG
         NEVwrlVQAGNQBA7sIY3YqDXzm3E/9u2Mx7+01l15jE1KQXTvWaCVmbwztaSCSDbNe8
         A2GFhgu+YyHXcDarzz+4x7QrDNIKQxuVC8DqLNCl+/qR0Pqfci0wm4k++37iIytyCJ
         V8xBLSOrqZYwQ==
Received: by mail-wr1-f47.google.com with SMTP id u5so16546514wrt.11;
        Thu, 25 Aug 2022 05:12:27 -0700 (PDT)
X-Gm-Message-State: ACgBeo3J03FlsSe6Mq1Q2hpJVL4E7QXIx2F4CF9LPOwqo3lYc9pOcGEr
        B022mgj7X3hqqA9eADNTuysYnIIe8dfKmozY3Ic=
X-Google-Smtp-Source: AA6agR6+9OBR3lJdZfGaxG3qbagjqwUFsas7q/AjtRjSsFeh3cI1IflxaamEPGka8TM91pJyWR1tr11QqDG+uSl7ogo=
X-Received: by 2002:a05:6000:782:b0:225:3e46:3dd5 with SMTP id
 bu2-20020a056000078200b002253e463dd5mr2003856wrb.103.1661429546102; Thu, 25
 Aug 2022 05:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220817161438.32039-2-ysionneau@kalray.eu> <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
In-Reply-To: <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 25 Aug 2022 14:12:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com>
Message-ID: <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 25 Aug 2022 at 14:10, Yann Sionneau <ysionneau@kalray.eu> wrote:
>
> Forwarding also the actual patch to linux-kbuild and linux-arch
>
> -------- Forwarded Message --------
> Subject:        [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
> Date:   Wed, 17 Aug 2022 18:14:38 +0200
> From:   Yann Sionneau <ysionneau@kalray.eu>
> To:     linux-kernel@vger.kernel.org
> CC:     Nicolas Schier <nicolas@fjasle.eu>, Masahiro Yamada
> <masahiroy@kernel.org>, Jules Maselbas <jmaselbas@kalray.eu>, Julian
> Vetter <jvetter@kalray.eu>, Yann Sionneau <ysionneau@kalray.eu>
>
>
>

What happened to the commit log?

> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
> include/linux/export-internal.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/export-internal.h
> b/include/linux/export-internal.h
> index c2b1d4fd5987..d86bfbd7fa6d 100644
> --- a/include/linux/export-internal.h
> +++ b/include/linux/export-internal.h
> @@ -12,6 +12,6 @@
> /* __used is needed to keep __crc_* for LTO */
> #define SYMBOL_CRC(sym, crc, sec) \
> - u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
> + u32 __section("___kcrctab" sec "+" #sym) __used __aligned(4)

__aligned(4) is the default for u32 so this should not be needed.


> __crc_##sym = crc
> #endif /* __LINUX_EXPORT_INTERNAL_H__ */
>
> --
> 2.37.2
>
>
>
>
>
