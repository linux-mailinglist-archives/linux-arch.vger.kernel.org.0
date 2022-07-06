Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0CF5684EE
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jul 2022 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiGFKOd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jul 2022 06:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiGFKOc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jul 2022 06:14:32 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DBAB1FE;
        Wed,  6 Jul 2022 03:14:31 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id z12so10663298qki.3;
        Wed, 06 Jul 2022 03:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzIRuH6wU929NRt5HMIsmc4z3oC4w64egTYXgfNitrM=;
        b=slJIU7GxNi8g9C0MUWZDViJYqpb7rFn0Ni9ZcDghA3IxWsbR+UdRp2LFeKuD+iYnxT
         MlIMJ+nJx+9uOJkLOLupd5Dy6UqAa5qgWF8h5zXr210uAKnd7Kin4bl5mGB7vClQFwF7
         8Y95p1TERKimGgL2ewgDPru6kEkxz9xe+FIP5+JhkTuw1bpiqoreGMZgTfiBxfHgxvjd
         prvFebGpRlUbMPEubjKtBSec6CvN4JtThvJmrCc76PFmhfuzcUZBb/41Qd7G4ZPyQ09p
         hbAlmu3P7ECJ+Yg4sC57CW+5sMdA27sCl2pI5BkNf72cERMZ1rp1cYx4sLJsZ6UQUw+b
         VtPA==
X-Gm-Message-State: AJIora8zz6OpH6DWg+OLp3SdQeGi8RW7M2U0gA+mnOYyNbbbKud6y8dO
        TCcgszn0JSoD8FE+QAbCpCOu4Y/TQ+hoFtnB
X-Google-Smtp-Source: AGRyM1vFr7+izcQe86fOaaoRtzk4ceLzcOmPr5oJXAZu/hluO7lsDxVDZOMLdWdg0Q/L1BnKm6w2SQ==
X-Received: by 2002:a05:620a:4610:b0:6b1:b83c:a16b with SMTP id br16-20020a05620a461000b006b1b83ca16bmr24542787qkb.487.1657102470871;
        Wed, 06 Jul 2022 03:14:30 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a284400b006a787380a5csm30248003qkp.67.2022.07.06.03.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 03:14:30 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id l11so26471299ybu.13;
        Wed, 06 Jul 2022 03:14:30 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr42474483ybq.543.1657102064364; Wed, 06
 Jul 2022 03:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220617144031.2549432-1-alexandr.lobakin@intel.com> <20220617144031.2549432-4-alexandr.lobakin@intel.com>
In-Reply-To: <20220617144031.2549432-4-alexandr.lobakin@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 12:07:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWqxqg7JubLK=KOX-V8JjoMbEKRPON+WhST=GKcjn8Y+w@mail.gmail.com>
Message-ID: <CAMuHMdWqxqg7JubLK=KOX-V8JjoMbEKRPON+WhST=GKcjn8Y+w@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] bitops: unify non-atomic bitops prototypes across architectures
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
        alpha <linux-alpha@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
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

On Fri, Jun 17, 2022 at 7:09 PM Alexander Lobakin
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

>  arch/m68k/include/asm/bitops.h                | 49 +++++++++++++------

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
