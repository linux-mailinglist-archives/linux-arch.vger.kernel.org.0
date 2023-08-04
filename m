Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29499770B3D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 23:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjHDVth (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 17:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjHDVtg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 17:49:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248C519B;
        Fri,  4 Aug 2023 14:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7517620DB;
        Fri,  4 Aug 2023 21:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E00C433C9;
        Fri,  4 Aug 2023 21:49:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LwXKQWRJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691185768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORA3IcVhKb+rBSGklGYykuz+i9fmP5WSYPYjINBjLQQ=;
        b=LwXKQWRJpln7h+V6IAdlyyxcmH4Fo0qCLeZxzU4w6u+SKycSix/bThRRckYJJYs10cZQTn
        2aLUmh90ZLXAh3+awRNqNH+ewEmFRXRGK1OE4GvmlNe1CNGjpKcK+zfThThn7VtOXjHkLS
        XKMsqYOg2jEkcu+DcXx4WqlUAPIhMYo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dfa0274c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 4 Aug 2023 21:49:28 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4475615e245so925007137.2;
        Fri, 04 Aug 2023 14:49:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YzKQ+1N5k2MptG1HrZfV5A7JZiK2Ju2+YyTC+db6aNsD7a+oyLI
        Xnr0h7Gn7BSQL4PkLD79GEGbqVxgIsnw/JTCS9I=
X-Google-Smtp-Source: AGHT+IFzCyVxbaUUBustnrT0flW6JXDyqhc36FfiEbHPc8U+/6KELY7eBmvNw3xOVQKLjosHRbdftnWJevSh2GWotjg=
X-Received: by 2002:a67:f5ce:0:b0:444:230e:e1e0 with SMTP id
 t14-20020a67f5ce000000b00444230ee1e0mr1710875vso.29.1691185767077; Fri, 04
 Aug 2023 14:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230614013018.2168426-1-guoren@kernel.org> <20230614013018.2168426-2-guoren@kernel.org>
 <ZM1tGgcJg0silFaJ@zx2c4.com> <CAHmME9p3VoZco0+io6pZDnzKVdnP4vr4XWNaAPXGew+1RmfVig@mail.gmail.com>
 <20230804-hut-morbidity-126fc9158f38@spud>
In-Reply-To: <20230804-hut-morbidity-126fc9158f38@spud>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 4 Aug 2023 23:48:02 +0200
X-Gmail-Original-Message-ID: <CAHmME9q6YjWWLWu1N5G71TspBQ=WD-2S5Xx1B2ZdzK+Wy8bYag@mail.gmail.com>
Message-ID: <CAHmME9q6YjWWLWu1N5G71TspBQ=WD-2S5Xx1B2ZdzK+Wy8bYag@mail.gmail.com>
Subject: Re: [PATCH -next V13 1/3] riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     Conor Dooley <conor@kernel.org>
Cc:     guoren@kernel.org, arnd@arndb.de, palmer@rivosinc.com,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        bjorn@kernel.org, cleger@rivosinc.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Conor,

On Fri, Aug 4, 2023 at 11:41=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Aug 04, 2023 at 11:28:17PM +0200, Jason A. Donenfeld wrote:
> > On Fri, Aug 4, 2023 at 11:28=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4=
.com> wrote:
> > >
> > > Hi Guo,
> > >
> > > On Tue, Jun 13, 2023 at 09:30:16PM -0400, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Add independent irq stacks for percpu to prevent kernel stack overf=
lows.
> > > > It is also compatible with VMAP_STACK by arch_alloc_vmap_stack.
> > > >
> > > > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > Cc: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> > >
> > > This patch broke the WireGuard test suite. I've attached the .config
> > > file that it uses. I'm able to fix it by setting CONFIG_EXPERT=3Dy an=
d
> > > CONFIG_IRQ_STACKS=3Dn to essentially reverse the effect of this patch=
. But
> > > I'd rather not do that.
> > >
> > > Any idea what's up?
>
> Given your config, I suspect you're hitting the issue that is resolved
> by Guo Ren's series:
> https://lore.kernel.org/linux-riscv/20230716001506.3506041-1-guoren@kerne=
l.org/
>
> Hopefully that's it,
> Conor.

Thanks! That did the trick. I suppose this will be in the next 6.5 rc.

Jason
