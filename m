Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA3359B4B7
	for <lists+linux-arch@lfdr.de>; Sun, 21 Aug 2022 16:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiHUO6n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Aug 2022 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHUO6k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Aug 2022 10:58:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6812D2C;
        Sun, 21 Aug 2022 07:58:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5339E60ED9;
        Sun, 21 Aug 2022 14:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A2DC433C1;
        Sun, 21 Aug 2022 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661093917;
        bh=kHtSJJdSb5C1JB9aewBxAMhHPhe3/IM67slgEkhiwWo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DX6c4BvqgiTGxO54bqH+1mdl13t/nrkpKbImk8SK/8tKwMjaMbigo/qyV9utGkUbP
         QZr3ICbvJ61nmM7jkk9P9enwBEVH6Eda+JgmH/k2jYlDPPgaDSF16EAGa7nKfQD9qA
         wbcXnfdULPR/g5MOAW2DUQZbIswio1ZZWYMA/MjscXHmRhDMCc2plvESu3SRV01B1/
         30gKKPAhcxd6PPssC18N2DTeaam/PQ301gkegFNBWeiuttnKEzcfBAml7tiug1OmvH
         oW16jVeTEO/d/ntyUMez0yJfwX/yhaAeZlHDHoomLt7ziZTP8A+m2/M4+WP/6FbsCG
         hNDxWi3NXOQHw==
Received: by mail-vs1-f45.google.com with SMTP id k2so8774398vsk.8;
        Sun, 21 Aug 2022 07:58:37 -0700 (PDT)
X-Gm-Message-State: ACgBeo3O9xX88ZsUR+AweOXKkExGgYxe7KuNdY7nWC+rdncg5hWiHY+s
        xs/wtRcPswudA9Uy2u12uz59moHJH+Vmq2B3OfQ=
X-Google-Smtp-Source: AA6agR52dvUeZPndqE7U5B77AH/eS8kJVI1IhCWM5jBdSF8suGsuqilniBG/DQ4A0T3mOEctflFpAeCjBNzxGDTGoE4=
X-Received: by 2002:a67:d483:0:b0:38f:4981:c4f3 with SMTP id
 g3-20020a67d483000000b0038f4981c4f3mr5328685vsj.59.1661093916769; Sun, 21 Aug
 2022 07:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <YwF8vibZ2/Xz7a/g@ZenIV> <20220821010239.1554132-1-viro@zeniv.linux.org.uk>
 <CAAhV-H4AcEOqeZ45Pb+8FN3G9k1wXKYhdgV8Uk=yqXSPAHrQvA@mail.gmail.com>
In-Reply-To: <CAAhV-H4AcEOqeZ45Pb+8FN3G9k1wXKYhdgV8Uk=yqXSPAHrQvA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 21 Aug 2022 22:58:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5O=sbLqtOWQp-m8f=Cdyyty1bAQwJGth0Jsj6YVmJkQw@mail.gmail.com>
Message-ID: <CAAhV-H5O=sbLqtOWQp-m8f=Cdyyty1bAQwJGth0Jsj6YVmJkQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] loongarch: remove generic-y += termios.h
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Acked-by: Huacai Chen <chenhuacai@kernel.org>

On Sun, Aug 21, 2022 at 10:56 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Acked-by: chenhuacai <chenhuacai@kernel.org>
>
> On Sun, Aug 21, 2022 at 9:02 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > not really needed - UAPI mandatory-y += termios.h is sufficient...
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  arch/loongarch/include/asm/Kbuild | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
> > index 83bc0681e72b..f2bcfcb4e311 100644
> > --- a/arch/loongarch/include/asm/Kbuild
> > +++ b/arch/loongarch/include/asm/Kbuild
> > @@ -21,7 +21,6 @@ generic-y += shmbuf.h
> >  generic-y += statfs.h
> >  generic-y += socket.h
> >  generic-y += sockios.h
> > -generic-y += termios.h
> >  generic-y += termbits.h
> >  generic-y += poll.h
> >  generic-y += param.h
> > --
> > 2.30.2
> >
