Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C70768884B
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 21:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjBBUfI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 15:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjBBUfH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 15:35:07 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EDC6D5F5
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 12:35:06 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id n6so3270243edo.9
        for <linux-arch@vger.kernel.org>; Thu, 02 Feb 2023 12:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h+Un5B9HU12CMMbobxB6ypBJ4/8ctn7jjqj34fe39Mg=;
        b=aA69/CVDF6+jXdLxh52nR1XCBIjQNZfHvLRWS5bm9Bv1Bj4Fh66EJ72EHlD2MgIFVp
         ZTamzSeyAPHJnPaIOS1uKJnM8KjGK82kAHMvQtI54FqlWglR03RTFWDMg7N0Z9APN+Es
         hIwm19EyF9DgJI53Q10nix2NttOal21TqByxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+Un5B9HU12CMMbobxB6ypBJ4/8ctn7jjqj34fe39Mg=;
        b=1H21I6tV60BP7MeIcRXPibWFAR54GU1QrAIZmVlQPH2aaAAooAXUiQMtWsnj23YpNY
         FvZw2Dy6XVTLTA+QOgCqlCYMsGpHwGXfy2vr3/RVvjJukRfplNJbMtcPgGj2wnkaSAat
         3c2LxSkFauaLZzJfCYPBL970KtLa3EX1+AHijHb1K+sK+nUyaKQ2Xyj1bgemjsK+CZdQ
         ZsJzmfwDPO/5fK1d6FQFmHG//3tEp2opaHE5DBGCkGP+8H8UlG250/1vHnhdBFOCdzKt
         oV/tCH8cQ8xMlyco6aRBchg9cmJB9ArejTVXp6cne/yI+xz81bJUbzJMhz3HkCN0XM8i
         lDyw==
X-Gm-Message-State: AO0yUKX7F0S2QkeDB4DDTQ28+dNTBaVHR5kpawCpzbkUuV7mKKaV27t9
        dKalFQL+IwhGVjZ2hnrqQYcgKRsCOjFXRJDejPLdxA==
X-Google-Smtp-Source: AK7set96dzAou7VTp5zQG/7A/Qk7OHnK+jZHa5e57wP1g3UtrSamfFv91ab4zu+M78wfoxg6XWk2Gg==
X-Received: by 2002:aa7:d406:0:b0:4a2:5a66:f4a8 with SMTP id z6-20020aa7d406000000b004a25a66f4a8mr7650461edq.19.1675370104461;
        Thu, 02 Feb 2023 12:35:04 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id c20-20020a05640227d400b004610899742asm199602ede.13.2023.02.02.12.35.03
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 12:35:03 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id dr8so9416866ejc.12
        for <linux-arch@vger.kernel.org>; Thu, 02 Feb 2023 12:35:03 -0800 (PST)
X-Received: by 2002:a17:906:f109:b0:882:e1b7:a90b with SMTP id
 gv9-20020a170906f10900b00882e1b7a90bmr2157841ejb.187.1675370103475; Thu, 02
 Feb 2023 12:35:03 -0800 (PST)
MIME-Version: 1.0
References: <Y9lz6yk113LmC9SI@ZenIV> <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV> <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
 <Y9te+4n4ajSF++Ex@ZenIV>
In-Reply-To: <Y9te+4n4ajSF++Ex@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Feb 2023 12:34:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wheJHX0YyE1YakywU0vT0pBxiNxQ7e4PY=z6TEYZwFq1Q@mail.gmail.com>
Message-ID: <CAHk-=wheJHX0YyE1YakywU0vT0pBxiNxQ7e4PY=z6TEYZwFq1Q@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 1, 2023 at 10:58 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, speaking of alpha page faults - maybe I'm misreading the manual,
> but it seems to imply that interrupts are *not* disabled when entering
> page fault handler:

Yeah, I think you are right.

And we *thought* we didn't need to disable interrupts like we do on
x86, because (unlike x86), we get the fault address in an
interrupt-safe way as an argument from palcode, rather than having to
read it from a register.

But now interrupts can race with that vmalloc case.

> is not just missing local_irq_save()/local_irq_restore() around that
> fragment - if it finds pgd already present, it needs to check pte
> before deciding to proceed to no_context.

Well, the logic there is that if the pgd was already present, then
something *else* wasn't present, so no_context makes perfect sense.

But that assumption does not hold for the "we raced with an interrupt"
case, so yes, it's broken.

And as you point out, it's doubly broken because "pgd_present()"
doesn't actually do what it historically did, and what that code
*thinks* it still does.

So yeah, this looks all broken.

            Linus
