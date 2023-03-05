Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1ED6AB169
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 17:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCEQtG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sun, 5 Mar 2023 11:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCEQtF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 11:49:05 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED99B45D;
        Sun,  5 Mar 2023 08:49:05 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id l18so8303760qtp.1;
        Sun, 05 Mar 2023 08:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678034944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laWnaU7+yvIkdIWbPnbMvJLuXve3O1O7/VL48bFhhYw=;
        b=dO3D8+BBiR7wl21z6Hx1g9b2VEUB62GEA/F9/8cxLMFWv7Gm5SzlPzfC8uvagqxpYa
         CdTdur2lU0er5aNyOkK1BA/r9U3yu2zclAnL6w2vA0hS6c7koDl0T2LMRxmo6irW9SFY
         sccjySkjkESseHsD7DaW8i3dGCy0JshzEUR4U9mbWLPSSci/gXHFSf4CX8h5pQVE83Oc
         wtYPFyuC0UL7dlZB0uckHvqkefdIakyXtMDkxOgGSmrrh64KX61LVJ2aNNPOJGS1wlyr
         zKWoAcwKSzRkqya8VOMAeFcVMIFzTaHy91iCqeSo9isMkkzUyRlOs2bmwUo53po5Vspu
         PVqQ==
X-Gm-Message-State: AO0yUKWaNh57HHgNqNqKVUq0FpHoRr0Bz4eKFCfyZssnhWoV84Gi58Wy
        5s/Qoc7/39raGeGW35nHQ/1+WI2tjPN5pg==
X-Google-Smtp-Source: AK7set8yjxPoSgjL0uc2k6Qxm6zxh/BsQbRNWxMcQ4UqtZDaaM3WVx8vkH6Ty8si2Ld6Xb4LyOZsnA==
X-Received: by 2002:a05:622a:24b:b0:3b9:b422:4d69 with SMTP id c11-20020a05622a024b00b003b9b4224d69mr15083859qtx.39.1678034944087;
        Sun, 05 Mar 2023 08:49:04 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id u19-20020a05620a121300b007424376ca4bsm5760060qkj.18.2023.03.05.08.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 08:49:03 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-536bbe5f888so141262797b3.8;
        Sun, 05 Mar 2023 08:49:03 -0800 (PST)
X-Received: by 2002:a81:b61d:0:b0:52e:f66d:b70f with SMTP id
 u29-20020a81b61d000000b0052ef66db70fmr4814861ywh.5.1678034943362; Sun, 05 Mar
 2023 08:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20230228213738.272178-1-willy@infradead.org> <20230228213738.272178-14-willy@infradead.org>
 <CAMuHMdW5TtUeZDmtHvxw+DxqUADC-OCW=tHE2Gptcoie62T+4w@mail.gmail.com> <ZAS1Lq6//oO/0PXe@casper.infradead.org>
In-Reply-To: <ZAS1Lq6//oO/0PXe@casper.infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 5 Mar 2023 17:48:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVb+yFOZFK5_KAUpHfq6i3rbqbFqTA0Q4+xLC4v0ot7UA@mail.gmail.com>
Message-ID: <CAMuHMdVb+yFOZFK5_KAUpHfq6i3rbqbFqTA0Q4+xLC4v0ot7UA@mail.gmail.com>
Subject: Re: [PATCH v3 13/34] m68k: Implement the new page table range API
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Willy,

On Sun, Mar 5, 2023 at 4:28 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Sun, Mar 05, 2023 at 11:16:13AM +0100, Geert Uytterhoeven wrote:
> > > +               while (nr--) {
> > > +                       __asm__ __volatile__("nop\n\t"
> > > +                                            ".chip 68040\n\t"
> > > +                                            "cpushp %%bc,(%0)\n\t"
> > > +                                            ".chip 68k"
> > > +                                            : : "a" (paddr + nr * PAGE_SIZE));
> >
> > As gcc (9.5.0) keeps on calculating "paddr + nr * PAGE_SIZE"
> > inside the loop (albeit using a shift instead of a multiplication),
> > please use "paddr" here, followed by "paddr += PAGE_SIZE;".
>
> Thanks.  So this?
>
> +++ b/arch/m68k/include/asm/cacheflush_mm.h
> @@ -235,13 +235,14 @@ static inline void __flush_pages_to_ram(void *vaddr, unsigned int nr)
>         } else if (CPU_IS_040_OR_060) {
>                 unsigned long paddr = __pa(vaddr);
>
> -               while (nr--) {
> +               do {
>                         __asm__ __volatile__("nop\n\t"
>                                              ".chip 68040\n\t"
>                                              "cpushp %%bc,(%0)\n\t"
>                                              ".chip 68k"
> -                                            : : "a" (paddr + nr * PAGE_SIZE));
> -               }
> +                                            : : "a" (paddr));
> +                       paddr += PAGE_SIZE;
> +               } while (--nr);
>         } else {
>                 unsigned long _tmp;
>                 __asm__ __volatile__("movec %%cacr,%0\n\t"

LGTM. Might be safer to keep the "while (nr--) {", just in case someone
ever passes zero.

> Also, I noticed that I broke sun3.  It puts the PFN in bits 0-n instead
> of 12-n.  New patch coming soon.

Thanks, hadn't noticed (there are no sun3-specific code changes in
this series?)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
