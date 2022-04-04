Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29CF4F1071
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 10:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbiDDIED (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 04:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377882AbiDDIED (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 04:04:03 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462963B2BB;
        Mon,  4 Apr 2022 01:02:07 -0700 (PDT)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MIxJq-1nH0x52y5q-00KLsF; Mon, 04 Apr 2022 10:02:05 +0200
Received: by mail-wr1-f43.google.com with SMTP id c7so13268308wrd.0;
        Mon, 04 Apr 2022 01:02:05 -0700 (PDT)
X-Gm-Message-State: AOAM532517R/lSVGLXAwA+N5AKi/nm029RBFReXMZngAg6CGv5ne444x
        T8XwKcxBHDYQhah1che4FV8J/iwRIPC/IeBYapk=
X-Google-Smtp-Source: ABdhPJxfJvKKixoejzphmCX0GQJtCAcdZjnwkNDn/9M06aiYqWjmBipXxJ1GIcogwlUWxIq3sw2sGEnVe8T8dDL1brk=
X-Received: by 2002:a5d:6505:0:b0:205:9a98:e184 with SMTP id
 x5-20020a5d6505000000b002059a98e184mr15347532wru.317.1649059325250; Mon, 04
 Apr 2022 01:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-3-masahiroy@kernel.org> <YkqhQhJIQEL2qh8C@infradead.org>
In-Reply-To: <YkqhQhJIQEL2qh8C@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Apr 2022 10:01:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0+fxiQGTu_XAOtNMkO91fZ7fQg3MZZahUjdNJCFaUxfw@mail.gmail.com>
Message-ID: <CAK8P3a0+fxiQGTu_XAOtNMkO91fZ7fQg3MZZahUjdNJCFaUxfw@mail.gmail.com>
Subject: Re: [PATCH 2/8] kbuild: prevent exported headers from including
 <stdlib.h>, <stdbool.h>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3CUoZQ9i738Pk1BDtFcQ17q6rJoOWZGhlf4AebmA6cuYFvtjqBY
 hWIGBvUybTD30MNo/igW2cL/K2IJWxgooaSR0MaxllcDW6BYCYoTrxem4uxL2+FQwEc8YhX
 ER1VPY7PouqNcWbtdXXbAXaf5bhddZbiGmfbryls7ezODnm7Fl5VrJ631sNPOBRUFyeTuLX
 9qFnAB9IaO7SrYhhSW8fQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r/J0NwWuQF8=:oSO9ZQsNRoYQwcgkMf5vQB
 3cQdSgt4HRCdc0EYK2Po/M1kMIDRxlRecyLaq/jdKrKjCF8xcWCnhPSwoq/Virt8AH1YhpCEM
 1urqSSOAH3vFaOpY97gPg6sTXDK9yL5uJ2Gw8iBTE1vzY3384dm6Ce3/F0VubMjVppok5pOsx
 5xtMzj1Gy2Ec76onRuA3eucjqNv3nLjXMqfyDHh9nhzfDeq44FmMP4tPG8z7xe8TtK95SYGQw
 fCD70LEqnQEJVuE4XacWc1+GLbn4YWtCmOiQ1ggSpWUkyAWeUPyH2r4oCqW2iakhcfnLKjUN8
 ZdTOVlVWp0leXJ+Eu9xo4ZtGZXJyLZtjWTyi5scy3xP9AKWl4kAPhOQma4UxdG8d2yCmjnPBg
 cyGaw8vkgW3ZskAAJS2Dn1i277HvS7qYMrTAxqd4hD1ab2dBsUf/9fWb1apZmWbie504wHKNQ
 cJ57zSpgCQz8DpFSJvzwG49zizD9+/8nWM9s0KzB72XWHvTlWRLs3dtPddWoSuhKTipheW8JA
 2g5DtsmQxUKrWPtOCpoYiT1h0xQATo8I57lihjvRQgNC8Lk92O2FO4w2IX+U7M74B0w5Vs2yN
 RGwsNyDkVOihEkWDbgvgrZsUaI7u7Ru67HUXNPd/l8RG2+zcSkAlexTnDTGIxtAlLCbsMvITM
 D/yYnU2cFzc/SUlO8rcHft6jI0tELUCfZXI0DMvXSum9SXLZBp4+1PUjAux5buoyVGiw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 4, 2022 at 9:41 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Apr 04, 2022 at 03:19:42PM +0900, Masahiro Yamada wrote:
> > If we can make kernel headers self-contained (that is, none of exported
> > kernel headers includes system headers), we will be able to add the
> > -nostdinc flag, but that is much far from where we stand now.
>
> What is still missing for that?

One case that I don't know how to solve is

include/uapi/sound/asound.h:typedef struct { unsigned char
pad[sizeof(time_t) - sizeof(int)]; } __time_pad;

Here we define a structure layout based on a libc-provided type. There are two
possible variants (32-bit and 64-bit time_t), and the kernel interface
can handle
both versions because they get different ioctl command numbers, but user space
must see the one that matches its normal time_t.

There are a couple of similar cases like this, but I think the other ones don't
need to define architecture specific padding like this.

       Arnd
