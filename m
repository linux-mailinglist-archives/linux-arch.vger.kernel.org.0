Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F09551D9F0
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 16:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381640AbiEFOLo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 10:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiEFOLn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 10:11:43 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD7C5A2DF;
        Fri,  6 May 2022 07:07:56 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id 126so5939014qkm.4;
        Fri, 06 May 2022 07:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLS1owR3CUUM/pxIukdO3Yvx2ZZOeSpZS2VuYEsMpRM=;
        b=Z247zpROugve+xccj1mnDqoSRDmWrS7IWjEOtk9VS9GM5cLRjoubnC0NSdY93eDmX4
         q4KzWOLYKwHChJ/R4FsGLq2i7+zhI5MrUk8JIpNpxHG0z5SWS5BQqFsOitZwr3bVdFe5
         SC3W8p3GtmHHsGSmcJQt+D3GEAwjN2n0L36wH6SKonwNiQ3SMkqUtKCZ6ZjZVL8fYdKY
         AtLPCn8WEtmQjqlDpavK2Wad8InHJassoAvR8eHhF7ciB/2HAdNQusnsbCz6Havq/kg6
         0GXkomAaKuhQHC3cHM4Q7647YloD/eHKgomqdPnIrfvWt4fBw2rOAbHFEAOkiyVjyiD4
         HYlQ==
X-Gm-Message-State: AOAM531zVuJ0S+P7Rtk2XWvoJBMgSXM61gWTdyiyW8wOtPwMEFUhm9q9
        +yfXauaZoOCPQUsqkY/7bdCq2ffMsrR5gg==
X-Google-Smtp-Source: ABdhPJzmpBReCv37qqtfOf8Imzp9MGGDEq/Ufzp603XZWxvx5nIRaOd6RMNBNV8Y0JqOU/4mlOaHBw==
X-Received: by 2002:a37:a743:0:b0:69f:e64c:74c9 with SMTP id q64-20020a37a743000000b0069fe64c74c9mr2455682qke.432.1651846075717;
        Fri, 06 May 2022 07:07:55 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id u12-20020ac8750c000000b002f39b99f69csm2580370qtq.54.2022.05.06.07.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 07:07:55 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id w187so13077449ybe.2;
        Fri, 06 May 2022 07:07:55 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr2392502ybb.202.1651846074895; Fri, 06
 May 2022 07:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <Yib9F5SqKda/nH9c@infradead.org>
In-Reply-To: <Yib9F5SqKda/nH9c@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 May 2022 16:07:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXVS6ROvp4rkZzBOBJBkQYjtdL0-m0ok=8UvTkwp-X4bw@mail.gmail.com>
Message-ID: <CAMuHMdXVS6ROvp4rkZzBOBJBkQYjtdL0-m0ok=8UvTkwp-X4bw@mail.gmail.com>
Subject: Re: [RFC PULL] remove arch/h8300
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>
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

Hi Chrisoph,

On Tue, Mar 8, 2022 at 12:04 PM Christoph Hellwig <hch@infradead.org> wrote:
> h8300 hasn't been maintained for quite a while, with even years old
> pull request lingering in the old repo.  Given that it always was
> rather fringe to start with I'd suggest to go ahead and remove the
> port:
>
> The following changes since commit 5c1ee569660d4a205dced9cb4d0306b907fb7599:
>
>   Merge branch 'for-5.17-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2022-02-22 16:14:35 -0800)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/users/hch/misc.git remove-h8300
>
> for you to fetch changes up to 1c4b5ecb7ea190fa3e9f9d6891e6c90b60e04f24:
>
>   remove the h8300 architecture (2022-02-23 08:52:50 +0100)
>
> ----------------------------------------------------------------
> Christoph Hellwig (1):
>       remove the h8300 architecture
>
>  .../bindings/clock/renesas,h8300-div-clock.txt     |  24 --
>  Documentation/devicetree/bindings/h8300/cpu.txt    |  13 -
>  .../interrupt-controller/renesas,h8300h-intc.txt   |  22 --
>  .../interrupt-controller/renesas,h8s-intc.txt      |  22 --
>  .../memory-controllers/renesas,h8300-bsc.yaml      |  35 --

More DT bindings to garbage-collect:
Documentation/devicetree/bindings/clock/renesas,h8s2678-pll-clock.txt
Documentation/devicetree/bindings/timer/renesas,16bit-timer.txt
Documentation/devicetree/bindings/timer/renesas,8bit-timer.txt

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
