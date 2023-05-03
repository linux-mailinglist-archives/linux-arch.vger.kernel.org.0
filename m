Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE03B6F52C4
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 10:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjECIKI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 3 May 2023 04:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjECIKH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 04:10:07 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA11716;
        Wed,  3 May 2023 01:09:53 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-55a6efe95c9so38615197b3.1;
        Wed, 03 May 2023 01:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683101392; x=1685693392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SVmNF978sXXspcYjjZLpiBDqyot8IfsoBtpE1ZoRNc=;
        b=W7CHGSXOvP426ID/JQgMh2SojaH7qharrHVxPh9IYKVwCXRBUi1TzDY4iX73qZniz1
         NEvRueNIBBOdPb0+lO+D1lat5fcW6aBLpmE9DC1HCs2UZVDsD/9JGDBSwt0EMuP0ugCU
         gvfS7KzARnWxFgd2k9HXRC/8d0HUSDw1DQA4598ed+KT8DQBY0OlHlOq+jEYKOTqTKJK
         U4OougSW1OjZt78kPCJ0C+uFglLtOr9imlJQChTlG35FzQVL1CjkdCf27hrlMRB295wn
         6aGDEaGEOgB0GRm4r/zX86T6brTSzQBfryMJnCfDT0TclfeUeoyhR5frTojKtfCu4I5Q
         XO5g==
X-Gm-Message-State: AC+VfDz9w1SIvm7FBW/kFMU0sItSyYyExQewIKN6uq+S4l28mTmsUV9h
        lK2Kzi90YDlqgUA/R4g8WrZMA9bCLKdW2g==
X-Google-Smtp-Source: ACHHUZ5yFIqBAyWPU6jgBPJP96XJUTLdIAkfaJtV4XlOmse1rTDnHHtFTC6jME+Lr68ItrgraGXS8Q==
X-Received: by 2002:a81:4f82:0:b0:55a:2ce1:2353 with SMTP id d124-20020a814f82000000b0055a2ce12353mr9928596ywb.2.1683101392047;
        Wed, 03 May 2023 01:09:52 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id s2-20020a817702000000b00545a08184b5sm8387125ywc.69.2023.05.03.01.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 01:09:51 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-559e317eef1so59866857b3.0;
        Wed, 03 May 2023 01:09:50 -0700 (PDT)
X-Received: by 2002:a0d:c347:0:b0:556:dd1b:3bb7 with SMTP id
 f68-20020a0dc347000000b00556dd1b3bb7mr19301020ywd.43.1683101390642; Wed, 03
 May 2023 01:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230502130223.14719-1-tzimmermann@suse.de> <20230502130223.14719-5-tzimmermann@suse.de>
 <20230502195429.GA319489@ravnborg.org> <563673c0-799d-e353-974c-91b1ab881a22@suse.de>
 <87354dyj9i.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87354dyj9i.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 May 2023 10:09:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW8Sm7sBu47XQ1xygn6fzq2FzQeiuK0ncMVGHan-_k4Ow@mail.gmail.com>
Message-ID: <CAMuHMdW8Sm7sBu47XQ1xygn6fzq2FzQeiuK0ncMVGHan-_k4Ow@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] fbdev: Include <linux/io.h> via <asm/fb.h>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-arch@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, arnd@arndb.de, deller@gmx.de,
        chenhuacai@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        James.Bottomley@hansenpartnership.com,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        vgupta@kernel.org, sparclinux@vger.kernel.org, kernel@xen0n.name,
        linux-snps-arc@lists.infradead.org, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 3, 2023 at 9:19 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
> > Am 02.05.23 um 21:54 schrieb Sam Ravnborg:
> >> On Tue, May 02, 2023 at 03:02:21PM +0200, Thomas Zimmermann wrote:
>
> [...]
>
> >>>   #include <linux/console.h> /* Why should fb driver call console functions? because console_lock() */
> >>>   #include <video/vga.h>
> >>>
> >>> +#include <asm/fb.h>
> >>
> >> When we have a header like linux/fb.h - it is my understanding that it is
> >> preferred to include that file, and not the asm/fb.h variant.
> >>
> >> This is assuming the linux/fb.h contains the generic stuff, and includes
> >> asm/fb.h for the architecture specific parts.
> >>
> >> So drivers will include linux/fb.h and then they automatically get the
> >> architecture specific parts from asm/fb.h.
> >>
> >> In other words, drivers are not supposed to include asm/fb.h, if
> >> linux.fb.h exists - and linux/fb.h shall include the asm/fb.h.
> >>
> >> If the above holds true, then it is wrong and not needed to add asm/fb.h
> >> as seen above.
> >>
> >>
> >> There are countless examples where the above are not followed,
> >> but to my best understanding the above it the preferred way to do it.
> >
> > Where did youher this? I only know about this in the case of asm/io.h
> > vs. linux/io.h.
> >
>
> I understand that's the case too. I believe even checkpatch.pl complains
> about it? (not that the script always get right, but just as an example).

One more to chime in: in general, drivers should only include <linux/foo.h>.
Including <asm/foo.h> directly is the exception.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
