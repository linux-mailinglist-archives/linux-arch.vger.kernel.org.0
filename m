Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AB74C152F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 15:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbiBWONv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 09:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbiBWONu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 09:13:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE6A58E61;
        Wed, 23 Feb 2022 06:13:23 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id gb39so52842764ejc.1;
        Wed, 23 Feb 2022 06:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sk3EKu2n8A3lB1TBZNR6LFIu5Y28hGEYtP8FhYL7krM=;
        b=UjwnJSchAJBzunfzc3V9nwiSju/yw4FX242TSa5LNAfqNf3dN2pjZe0GWA3SklQAMe
         hbxVatHL/TPzONThWuK+mZpZCsRqqRqAk9vuf1UL4Hj7XBSuMh9RPTxQvqbmXvRrY3tA
         QPEfwD3q3lv9KGYt1/gC9OKFb0b4kN1ZusK4BJ2EOE5Ak1rpzZ/H4u8i8b9WT07jgBKa
         osX9OxO5PNt+H6qqbrqgN2KGwsIxWZdEHQRASGSmH+7+GjI3yQFL0fvJ51h7gFVJdYLR
         6jMBK16QS3Nyyzy3ucl+dq3hIvY6FCVDi9GDv34qaDTg42f8VTQfU9J20ZtMTmaWhp6W
         PsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sk3EKu2n8A3lB1TBZNR6LFIu5Y28hGEYtP8FhYL7krM=;
        b=bW4G0Ws2SCU0H1Y1ckDcPFVlreOfOnzez6Ifz2Sdc8q6QFhqETtkQeEZJYyLi5yyPf
         JttTnb3TNwOF8GysOnhAMAErgADkDKSboREtubcBJ7MAe4SbZ2Vcw3Cb4N5bdqMyfrVo
         bSBewpH13MMYxoCLI9bVkq7QysgQyPjKv6/x9eSSUr/JckOu8oviXbCEddYRYXWH7pix
         mAdzj7pTtLMLa5S/YNQopuscfTN6KMHN7AXxlNTkrtehAt6Bvme3EKDjKQ2Tfc80ZWZm
         LDS6mw0QXlbEhnHVuCxiC83oO/9ezMSS6zzNN36tRdF51rj7hj2hFeIrJ5rCb0Gw7ng/
         +Q5w==
X-Gm-Message-State: AOAM533yohPML8vFDpxuyyWjRbc8hMuvl629KcYkoAoNmH57V/Z3RmnT
        d5BFLcjCjUXxXWBo4TmDsH0=
X-Google-Smtp-Source: ABdhPJznanM6NcAAN1Vn4Qug+zFjoQcwAYXMvpqTbOgsPTOtDoQ3KmNGl0mTPrV1mQHZC6hbDWFwkA==
X-Received: by 2002:a17:907:765a:b0:6d1:bc6:df10 with SMTP id kj26-20020a170907765a00b006d10bc6df10mr14891861ejc.254.1645625601536;
        Wed, 23 Feb 2022 06:13:21 -0800 (PST)
Received: from smtpclient.apple (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.gmail.com with ESMTPSA id ej19sm9227076edb.108.2022.02.23.06.13.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Feb 2022 06:13:20 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
From:   Jakob <jakobkoschel@gmail.com>
In-Reply-To: <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
Date:   Wed, 23 Feb 2022 15:13:19 +0100
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com>
 <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On 17. Feb 2022, at 20:28, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Thu, Feb 17, 2022 at 10:50 AM Jakob Koschel =
<jakobkoschel@gmail.com> wrote:
>>=20
>> It is unsafe to assume that &req->req !=3D _req can only evaluate
>> to false if the break within the list iterator is hit.
>=20
> I don't understand what problem you are trying to fix.
>=20
> Since "req" absolutely *has* to be stable for any of this code to be
> valid, then "&req->req" is stable and unambiguous too. The *only* way
> _req can point to it would be if we finished the iteration properly.
>=20
> So I don't see the unsafeness.
>=20
> Note that all this work with "speculative" execution fundamentally CAN
> NOT affect semantics of the code, yet this patch makes statements
> about exactly that.

I'm sorry for having created the confusion. I made this patch to support
the speculative safe list_for_each_entry() version but it is not =
actually
related to that. I do believe that this an actual bug and *could*
*potentially* be misused. I'll follow up with an example to illustrate =
that.

I agree that this has nothing to do with the speculative execution =
iterator
(apart from making it work) and should best be discussed separately.

I'll attach an example on how I think this code *can* become a problem.
Note that this highly depends on the used compiler and how the struct
offsets are laid out.

>=20
> That's not how CPU speculation works.
>=20
> CPU speculation can expose hidden information that is not
> "semantically important" (typically through cache access patterns, but
> that's not the only way). So it might be exposing information it
> shouldn't.
>=20
> But if speculation is actually changing semantics, then it's no longer
> "speculation" - it's just a bug, plain and simple (either a software
> bug due to insufficient serialization, or an actual hardware bug).
>=20
> IOW, I don't want to see these kinds of apparently pointless changes
> to list walking. The patches should explain what that SECONDARY hidden
> value you try to protect actually is for each case.
>=20
> This patch is basically not sensible. It just moves code around in a
> way that the compiler could have done anyway (or the compiler could
> decide to undo). It doesn't explain what the magic protected value is
> that shouldn't be leaked, and it leaves the code just looking odd and
> pointless.
>=20
>                   Linus

