Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E447779DE2
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 09:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjHLHWj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Aug 2023 03:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjHLHWX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Aug 2023 03:22:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9809C;
        Sat, 12 Aug 2023 00:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B090460C19;
        Sat, 12 Aug 2023 07:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DD8C433C8;
        Sat, 12 Aug 2023 07:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691824919;
        bh=T49W5Cfp+PS9dZVZhsi9kebDPSpppYWuyo3c546Y58o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YZjga2wLU4qB/oCeK0ZTZgkXdG/5zDTBrqVYyHADan4o7WudMME/eeEfu8WCGot5W
         Zh63KTo/EvPpEBmS3L80Sc0/6oJbCb8PuLwOgPMfj34XRuBD+w0W5dQ3FhH4jkjeUm
         YX+f8EAEsKcuVi0Sqp7CnEU3AtYSFR3zwqej6eRPesA0+YSSkUWkjw6+fidEf2W4xs
         c/AeNvnM0TnTR4pdP1RqLHGdqN7lu8s4G+qhGe2PHTav+StPLHF6QsoJPfMZQQK0dy
         aQIHOXzC4QHcA3Tojgm7I9kViCLRQ+Bw1p8oX5iUmQ91KA5UUBjvWEl5vtkJrhN3KY
         R37QKs1RQw4TQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-56dd69cbb18so1931114eaf.2;
        Sat, 12 Aug 2023 00:21:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YzOLufORfQTfJPISi1eNUGnUNBlXZqLN33fYXZj9+9n8qhpdhyN
        jMfwBuHNXSPhTjBrsUtnqz6jRsfYyfps0pX4MoE=
X-Google-Smtp-Source: AGHT+IEJ3xl/0ZdCY236smtq3IR2viJqODnRtNXP4xUg/YqRsqekpnbdNqflotZ1uAS8MBw1UFg5K1VJ7QGV0S/ebWc=
X-Received: by 2002:a4a:3818:0:b0:56c:e856:8b2c with SMTP id
 c24-20020a4a3818000000b0056ce8568b2cmr3434150ooa.9.1691824918403; Sat, 12 Aug
 2023 00:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230811140327.3754597-1-arnd@kernel.org> <20230811140327.3754597-3-arnd@kernel.org>
 <20230811141943.GB3948268@dev-arch.thelio-3990X> <6e1c3faf-83f3-4627-bd74-42fea5b88dfb@app.fastmail.com>
In-Reply-To: <6e1c3faf-83f3-4627-bd74-42fea5b88dfb@app.fastmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 12 Aug 2023 16:21:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ+kYEjGm77XjEVNJjXhQDpxPRUQOa-BEm6qF1wLRfFog@mail.gmail.com>
Message-ID: <CAK7LNAQ+kYEjGm77XjEVNJjXhQDpxPRUQOa-BEm6qF1wLRfFog@mail.gmail.com>
Subject: Re: [PATCH 2/9] Kbuild: consolidate warning flags in scripts/Makefile.extrawarn
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 11, 2023 at 11:45=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Fri, Aug 11, 2023, at 16:19, Nathan Chancellor wrote:
> > On Fri, Aug 11, 2023 at 04:03:20PM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Warning options are enabled and disabled in inconsistent ways and
> >> inconsistent locations. Start rearranging those by moving all options
> >> into Makefile.extrawarn.
> >>
> >> This should not change any behavior, but makes sure we can group them
> >> in a way that ensures that each warning that got temporarily disabled
> >> is turned back on at an appropriate W=3D1 level later on.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  Makefile                   | 88 -------------------------------------
> >>  scripts/Makefile.extrawarn | 90 +++++++++++++++++++++++++++++++++++++=
+
> >>  2 files changed, 90 insertions(+), 88 deletions(-)
> >
> > This shuffle seems reasonable to me. Would it make sense to rename the
> > Makefile from Makefile.extrawarn to just Makefile.warn or
> > Makefile.warnings? They are still "extra" warnings but to me, the
> > meaning of the Makefile is changing so it seems reasonable to drop the
> > "extra" part.
>
> Renaming the file seems fine, but I'd much prefer to do that separately
> if we decide to do it, otherwise rebasing my patches is going to
> be even more painful.
>
>      Arnd


Nice cleanups.
I like this, and renaming the file
(as a separate patch).



--=20
Best Regards
Masahiro Yamada
