Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED41B5684D5
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jul 2022 12:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiGFKKE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jul 2022 06:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiGFKJu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jul 2022 06:09:50 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED099A467;
        Wed,  6 Jul 2022 03:09:46 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id c13so17480565qtq.10;
        Wed, 06 Jul 2022 03:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kx69JRXRHaP9bPHWeCJjLQ/KjVRjWJF5OqT3P9q0cBs=;
        b=lAzdRd1By0sHsBk/HkiVBJYiSBscgl0i1ZLAsUpFAIe8qAFmd4kDffUF8y1jY0FzOQ
         vVQfqo0DLW7HANISepVttWLbihN1jcWLZBXtujKa69KSjCNBQbl+XqnRi2/a+OCql/Tc
         G8X6soaObeyIiRaLHtBaDSvM4cEzvyuPysp+OQZs4wHtBIWH/haIhn4mW1FvFW+t+ti0
         qBHP0Vmz2rWXotho0cLXnoEcZVjtPVWLkVQDIOQaZYE5+Ub0Ua9c2gW8CKiGhkL+io3k
         qVkdq0txxNz1x/GETY20MSUDfZmIuHQf2qN1c1YuF5B4VJ9m9c4sskMn3wC6HuqqW6ET
         4sEA==
X-Gm-Message-State: AJIora+fQVLRC2JPBJguYfUYsik9hV+zeKmHAXEqN5WBunFzox/ZpMxo
        yPE6Majlkyis7OxP4gCWrdsz3ayypng1TNvl
X-Google-Smtp-Source: AGRyM1uRi24Ome6ymG0bopZ8WaKaGL4MX+ul7f2gDeb/y4XMxl60luZgTxp4X64UGyjAH5lS0Ja8GQ==
X-Received: by 2002:a05:622a:4cc:b0:31d:26a1:2538 with SMTP id q12-20020a05622a04cc00b0031d26a12538mr31085549qtx.498.1657102185760;
        Wed, 06 Jul 2022 03:09:45 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id d71-20020a379b4a000000b006a6a1e4aec2sm28819484qke.49.2022.07.06.03.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 03:09:44 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31c86fe1dddso87249647b3.1;
        Wed, 06 Jul 2022 03:09:44 -0700 (PDT)
X-Received: by 2002:a81:5404:0:b0:31c:c24d:94b0 with SMTP id
 i4-20020a815404000000b0031cc24d94b0mr10209449ywb.502.1657102184115; Wed, 06
 Jul 2022 03:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com> <20220624121313.2382500-4-alexandr.lobakin@intel.com>
In-Reply-To: <20220624121313.2382500-4-alexandr.lobakin@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 12:09:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWB8CjbOarttKSaY2=kASbqU2UBCe9bpU17=MdZP_rGUA@mail.gmail.com>
Message-ID: <CAMuHMdWB8CjbOarttKSaY2=kASbqU2UBCe9bpU17=MdZP_rGUA@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] bitops: unify non-atomic bitops prototypes across architectures
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>, llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Jun 24, 2022 at 2:13 PM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
> Currently, there is a mess with the prototypes of the non-atomic
> bitops across the different architectures:
>
> ret     bool, int, unsigned long
> nr      int, long, unsigned int, unsigned long
> addr    volatile unsigned long *, volatile void *
>
> Thankfully, it doesn't provoke any bugs, but can sometimes make
> the compiler angry when it's not handy at all.
> Adjust all the prototypes to the following standard:
>
> ret     bool                            retval can be only 0 or 1
> nr      unsigned long                   native; signed makes no sense
> addr    volatile unsigned long *        bitmaps are arrays of ulongs
>
> Next, some architectures don't define 'arch_' versions as they don't
> support instrumentation, others do. To make sure there is always the
> same set of callables present and to ease any potential future
> changes, make them all follow the rule:
>  * architecture-specific files define only 'arch_' versions;
>  * non-prefixed versions can be defined only in asm-generic files;
> and place the non-prefixed definitions into a new file in
> asm-generic to be included by non-instrumented architectures.
>
> Finally, add some static assertions in order to prevent people from
> making a mess in this room again.
> I also used the %__always_inline attribute consistently, so that
> they always get resolved to the actual operations.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

>  arch/m68k/include/asm/bitops.h                | 49 ++++++++++-----

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
