Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCC0292208
	for <lists+linux-arch@lfdr.de>; Mon, 19 Oct 2020 06:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgJSE4K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Oct 2020 00:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgJSE4K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Oct 2020 00:56:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19B4C061755;
        Sun, 18 Oct 2020 21:56:08 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 188so6854908qkk.12;
        Sun, 18 Oct 2020 21:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DdX9ApBECm+ZbNtZ5Vnyo8TdWHP3VGSlELnREVWBNY=;
        b=XQl3RjUCuFc72C5e68vkhmCKQQgsZkb9Vh0Thw8hzOZzbVkTFD4oW0HJS4kZ6wZnO5
         h7qwyL+8o43sy9jIkDfnRYdrivkw96E6c/JE7XY/e1BYCz2dIVIdYZHQkRQXmsM5lbNr
         GUEcOVIgdW6FRDAW2PwuDztW/r9zSpXdfmjCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DdX9ApBECm+ZbNtZ5Vnyo8TdWHP3VGSlELnREVWBNY=;
        b=D3Ssa+CgQ47ocmANvui/80qBzCbLPgDlSwbw1bYwxl+5xG9Q5HcVE1NREf1gbdSBI0
         lxUkHRmrDL6d98cCObjTtfXy1o4L8GGTaGEeGyzn+ENVxzyA93vwMejCHj9O1aJ94h74
         7sOMD3BoWa8+hFxlXR0MzO/5KZ9eRklxTZOqLAYhP4cwCTdn9qHdPglNvewZIOMYPi1e
         akPa94IA3v/uQ/J6y8Fp745ePspTBZuI6lI0zkLxqjS/By+1bGUEMP15KtEOcUKDmPAz
         u1pmfVJLAhvYlCyr/2nqLBuD54cOHPIGoL8RoqCa8IUq+XXJa8nSBgnLGiLPljJBWiDL
         0HAg==
X-Gm-Message-State: AOAM530rwYKlc3dE0L3zbberXNd54qtG6E9x8r6Mrpzyh1RdNpooBPjK
        EsxfiHVAIPU3sMEeDaUehawswSjfclN/p+K59f4=
X-Google-Smtp-Source: ABdhPJyar9udlZPgCCqFMvDSZwmLzCPi0LxWbnXc6wqf6/x0UQyWB6Sox4JOJ3/KAzY0OBVi6VParLwqDvMXazd9S60=
X-Received: by 2002:a37:48cc:: with SMTP id v195mr15006360qka.66.1603083367899;
 Sun, 18 Oct 2020 21:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <96c6172d619c51acc5c1c4884b80785c59af4102.1602949927.git.christophe.leroy@csgroup.eu>
In-Reply-To: <96c6172d619c51acc5c1c4884b80785c59af4102.1602949927.git.christophe.leroy@csgroup.eu>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 19 Oct 2020 04:55:55 +0000
Message-ID: <CACPK8XfgK0Bj3sLjKCi80jS6vK34FN5BTkU8FvBGcMR=RQn4Xw@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: Force inlining of get_order() to work around
 gcc10 poor decision
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 17 Oct 2020 at 15:55, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> When building mpc885_ads_defconfig with gcc 10.1,
> the function get_order() appears 50 times in vmlinux:
>
> [linux]# ppc-linux-objdump -x vmlinux | grep get_order | wc -l
> 50
>
> [linux]# size vmlinux
>    text    data     bss     dec     hex filename
> 3842620  675624  135160 4653404  47015c vmlinux
>
> In the old days, marking a function 'static inline' was forcing
> GCC to inline, but since commit ac7c3e4ff401 ("compiler: enable
> CONFIG_OPTIMIZE_INLINING forcibly") GCC may decide to not inline
> a function.
>
> It looks like GCC 10 is taking poor decisions on this.
>
> get_order() compiles into the following tiny function,
> occupying 20 bytes of text.
>
> 0000007c <get_order>:
>   7c:   38 63 ff ff     addi    r3,r3,-1
>   80:   54 63 a3 3e     rlwinm  r3,r3,20,12,31
>   84:   7c 63 00 34     cntlzw  r3,r3
>   88:   20 63 00 20     subfic  r3,r3,32
>   8c:   4e 80 00 20     blr
>
> By forcing get_order() to be __always_inline, the size of text is
> reduced by 1940 bytes, that is almost twice the space occupied by
> 50 times get_order()
>
> [linux-powerpc]# size vmlinux
>    text    data     bss     dec     hex filename
> 3840680  675588  135176 4651444  46f9b4 vmlinux

I see similar results with GCC 10.2 building for arm32. There are 143
instances of get_order with aspeed_g5_defconfig.

Before:
 9071838 2630138  186468 11888444         b5673c vmlinux
After:
 9069886 2630126  186468 11886480         b55f90 vmlinux

1952 bytes smaller with your patch applied. Did you raise this with
anyone from GCC?

Reviewed-by: Joel Stanley <joel@jms.id.au>



> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  include/asm-generic/getorder.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/getorder.h b/include/asm-generic/getorder.h
> index e9f20b813a69..f2979e3a96b6 100644
> --- a/include/asm-generic/getorder.h
> +++ b/include/asm-generic/getorder.h
> @@ -26,7 +26,7 @@
>   *
>   * The result is undefined if the size is 0.
>   */
> -static inline __attribute_const__ int get_order(unsigned long size)
> +static __always_inline __attribute_const__ int get_order(unsigned long size)
>  {
>         if (__builtin_constant_p(size)) {
>                 if (!size)
> --
> 2.25.0
>
