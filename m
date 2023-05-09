Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E6C6FBF55
	for <lists+linux-arch@lfdr.de>; Tue,  9 May 2023 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjEIGjH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 9 May 2023 02:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbjEIGjF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 May 2023 02:39:05 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453E2AD19;
        Mon,  8 May 2023 23:39:00 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so28813169276.1;
        Mon, 08 May 2023 23:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683614339; x=1686206339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOcwavl5tEhjFo+qvl4oybTvYsklKUcQFW6RYMWOTw0=;
        b=XN/nxjv8ybmedDeeokUrHmWGX7ALZ14UXYy3ffHqQ9lGkzlb68u0cgJBfRfxvXL9qG
         G7Xu/UgvtaMic3ZIW0O1sKEPRtryQqXpLBbEG9AxxFrigccVYa3aiuA8dbl85T6oNBHw
         QpqFs1GE/725xsP2lb0JhFm0XXL048WjAR4nfkiaIu8aIa7vvvAjdDBqQVGfI3Tv9S8i
         LLb3nl/D/CjBZEGS1ocHdlIxrb+Q3iZcH4KnvkaWcJgAK8W1bCuEjTQSfdXCp2jUaQLz
         AU92c0for24Fvt8nxW1zxLCM/F4gSkNVA7C1yr3Bj6SeLWLToU00XPVTEGHjzWGr5KTN
         KTTw==
X-Gm-Message-State: AC+VfDxZ4t/2KTMzOfAGgRbYpCKH5pCxWJZq16GacyahIiZYm3MtV0tT
        rY5qjdc3u6eH6y3NbXiAlaFMRZkqSSmsNA==
X-Google-Smtp-Source: ACHHUZ6ap/xwk1m7OJLMrlWWCTWBpmPjMB96v6F5WcrE2/NNfSac50vN9pt4HxQ/9dPhb28nzoQ4AQ==
X-Received: by 2002:a81:a4c:0:b0:55d:9c2d:20d with SMTP id 73-20020a810a4c000000b0055d9c2d020dmr13442966ywk.6.1683614339091;
        Mon, 08 May 2023 23:38:59 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id q66-20020a0dce45000000b0054f03d75882sm3087071ywd.71.2023.05.08.23.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 23:38:57 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so28900065276.0;
        Mon, 08 May 2023 23:38:56 -0700 (PDT)
X-Received: by 2002:a25:51c7:0:b0:b9a:867b:462a with SMTP id
 f190-20020a2551c7000000b00b9a867b462amr15472830ybb.7.1683614336436; Mon, 08
 May 2023 23:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-29-schnelle@linux.ibm.com> <202303141252027ef5511a@mail.local>
 <aa68b4afdca34bf3bfd2439b03e6f9bcfad94903.camel@linux.ibm.com> <b7017996-b079-4534-a24a-080003772a66@app.fastmail.com>
In-Reply-To: <b7017996-b079-4534-a24a-080003772a66@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 9 May 2023 08:38:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJ=hsB=A_umQnPMVSU+BGqeHt3O-2ygr3p_f7pHHvf=Q@mail.gmail.com>
Message-ID: <CAMuHMdXJ=hsB=A_umQnPMVSU+BGqeHt3O-2ygr3p_f7pHHvf=Q@mail.gmail.com>
Subject: Re: [PATCH v3 28/38] rtc: add HAS_IOPORT dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-rtc@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Mon, May 8, 2023 at 10:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, May 8, 2023, at 17:36, Niklas Schnelle wrote:
> > On Tue, 2023-03-14 at 13:52 +0100, Alexandre Belloni wrote:
> >> On 14/03/2023 13:12:06+0100, Niklas Schnelle wrote:
> >> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> >> > not being declared. We thus need to add HAS_IOPORT as dependency for
> >> > those drivers using them.
> >> >
> >> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> >> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> >> > ---
> >> >  drivers/rtc/Kconfig | 4 +++-
> >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> >> > index 5a71579af0a1..20aa77bf0a9f 100644
> >> > --- a/drivers/rtc/Kconfig
> >> > +++ b/drivers/rtc/Kconfig
> >> > @@ -956,6 +956,7 @@ comment "Platform RTC drivers"
> >> >  config RTC_DRV_CMOS
> >> >    tristate "PC-style 'CMOS'"
> >> >    depends on X86 || ARM || PPC || MIPS || SPARC64
> >> > +  depends on HAS_IOPORT
> >>
> >> Did you check that this will not break platforms that doesn't have RTC_PORT defined?
> >> >
> >
> > From what I can tell the CMOS_READ() macro this driver relies on uses
> > some form of inb() style I/O port access in all its definitions. So my
> > understanding is that this device is always accessed via I/O ports even
> > if the variants differ slightly and would make no sense on a platform
> > without any way of accessing I/O ports which is what lack of HAS_IOPORT
> > means. From what I can see even without RTC_PORT being defined the
> > CMOS_READ is still used. Hope that answers your question?
>
> I think the m68k/atari and mips/dec variants don't necessarily
> qualify as PIO, those are really just pointer dereferences, and
> they don't use the actual inb/outb functions.
>
> On atari, it looks like HAS_IOPORT may be set if ATARI_ROM_ISA
> is, but on dec it's never enabled.

Atari does not use RTC_DRV_CMOS, but still relies on generic RTC
instead.

Last time (in 2013?) I tried converting to RTC_DRV_CMOS by registering
an "rtc_cmos" platform device, I couldn't get it to work.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
