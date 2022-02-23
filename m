Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14524C1D49
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 21:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbiBWUn7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 15:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiBWUn6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 15:43:58 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7059B4D9E1
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 12:43:30 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g39so314624lfv.10
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 12:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ToP7+u5TAIA1n+un4iO9944/Fjm/9qjoDI5PHB1SdbA=;
        b=K1sL+JK8G+5oEKb2E8fAwrSR5os84QIowAVzA3JAWOyiezYS97zbR3Od2bvOKCG/Ya
         kHJfrEiaMRcfMYUW2C/o5y0GvbP0W+EtqpZMZu8JEGyXGRnTf4DiKlI5Ivwjvx0CXlKh
         ANHqMVyaiR6CAY08j4pgEDEV47Qvbzqi34tlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ToP7+u5TAIA1n+un4iO9944/Fjm/9qjoDI5PHB1SdbA=;
        b=fYfa5kH9M4w4pAbtDATKu220gv6LCLymC+1L6f6Av/8FL4XMQpn1K60uQU5KGM/8KA
         D+JKomYMt6Ne3TJLKShRk6OKtRK6yQ/ICjbZQAU+75p5PXzThHodbOfuJB/kpnXn4HPB
         8dPBPUytTIlYkHsheC+9A2Vv4djgqAZ+JVbjSPharI1YfZO2qVUuAmJDV5clh7B3n7JK
         VaZawqrIdRxzYuHNWk3Ws2ktv5Tr3PbmZT9ANxrmHZLPNJuR7xnCMz1Yc5/AG2Ngeh4e
         Isl1Py6LRFe7krhrCCOHHVCG6Vg3Tt4h/DLDFaAN8VnjE7THvyio25OJz5BW1ktcBhi4
         YDCw==
X-Gm-Message-State: AOAM5337EUrorJ/r+vSAFNuQ4B8SekZtvtbTFLKIJRw3Z7Az40cQIkNn
        Iv3QbPYYZp01Xqoq4gjJixLdf3sG4lXQ9rwwX4I=
X-Google-Smtp-Source: ABdhPJwH1IWzlXbcYeMBTAmPDGGNyf8NxP+NDXJJagQeA90eZxsjOQRE1WxACpCbvXZzc0XjV0MROg==
X-Received: by 2002:ac2:52a1:0:b0:443:b482:fd2b with SMTP id r1-20020ac252a1000000b00443b482fd2bmr893485lfm.197.1645649008418;
        Wed, 23 Feb 2022 12:43:28 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id r1sm90207ljj.9.2022.02.23.12.43.27
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:43:27 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id bn33so26424379ljb.6
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 12:43:27 -0800 (PST)
X-Received: by 2002:a2e:bc17:0:b0:246:32b7:464 with SMTP id
 b23-20020a2ebc17000000b0024632b70464mr792954ljf.506.1645649006967; Wed, 23
 Feb 2022 12:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com> <CAK8P3a0DOC3s7x380XR_kN8UYQvkRqvE5LkHQfK2-KzwhcYqQQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0DOC3s7x380XR_kN8UYQvkRqvE5LkHQfK2-KzwhcYqQQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 12:43:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wicJ0VxEmnpb8=TJfkSDytFuf+dvQJj8kFWj0OF2FBZ9w@mail.gmail.com>
Message-ID: <CAHk-=wicJ0VxEmnpb8=TJfkSDytFuf+dvQJj8kFWj0OF2FBZ9w@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 12:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I looked at the gcc documentation for this flag, and it tells me that
> it's default-enabled for std=c99 or higher. Turning it on for --std=gnu89
> shows the same warning, so at least it doesn't sound like the actual
> behavior changed, only the warning output. clang does not warn
> for this code at all, regardless of the --std= flag.

Ok, so we should be able to basically convert '--std=gnu89' into
'--std=gnu11 -Wno-shift-negative-value' with no expected change of
behavior.

Of course, maybe we need to make -Wno-shift-negative-value be
conditional on the compiler supporting it in the first place?

I really would love to finally move forward on this, considering that
it's been brewing for many many years.

I think the loop iterators are the biggest user-visible thing, but
there might be others.

And some googling seems to show that the reason for
-Wshift-negative-value is that with C99 the semantics changed for
targets that weren't two's complement. We *really* don't care.

Of course, the C standard being the bunch of incompetents they are,
they in the process apparently made left-shifts undefined (rather than
implementation-defined). Christ, they keep on making the same mistakes
over and over. What was the definition of insanity again?

                  Linus
