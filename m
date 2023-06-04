Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C549F721921
	for <lists+linux-arch@lfdr.de>; Sun,  4 Jun 2023 20:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjFDSH2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Jun 2023 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjFDSH1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Jun 2023 14:07:27 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493F8CD
        for <linux-arch@vger.kernel.org>; Sun,  4 Jun 2023 11:07:26 -0700 (PDT)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4F4E63F59F
        for <linux-arch@vger.kernel.org>; Sun,  4 Jun 2023 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685902044;
        bh=eXPLCKZ8Jj450duZJrO5FmwhWWg+s1j3KuC7Lhd1iI4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=SUSsViYRpII2cknGPbcjJxzJH7c6Uff+R2RQVbk8EO+tfNiLUcNOdDnRVryy3YSCM
         07XOsRbwfXInNB2e9UD6/jnPZaXcwPEcP/cQksG4wBtKXYr+VH/k846ZQHaLRSoBfS
         1wQuoW0VnyYvMEr05HnKoHmsI00ZJKbBzssPmcDtyhxSJcoP2NIkQOIAuVYQy785jo
         c7JymZNXpwsKYYHq/RIYIdLSm3Ejx/GC1O4ZxdWabBQucoL6NGylI30JenPRx7fWlN
         tNJbr6IJzzM54CMQbaiZW2cuVLlzWWwxy2C7bxdsm2ZHBJ5H23/aKugBpxCiOw+QBJ
         rQMf8bRgUaFrQ==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-568960f4596so69772107b3.1
        for <linux-arch@vger.kernel.org>; Sun, 04 Jun 2023 11:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685902041; x=1688494041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXPLCKZ8Jj450duZJrO5FmwhWWg+s1j3KuC7Lhd1iI4=;
        b=EmBnhItPcQtny5yCNOjNpKPq/TXaLQRM6EOHxrPu3fYUAVZrl/3h/oh9yB7ZdA2LhJ
         bjBOX4JVJ/kmFCYPWvEEYxWKQiaX7BBtGEhqZQ1E0r56eStsINgebgViqkud/7kNkYij
         QcfHSQO3C6uv/zzfksAtzEcwJdb/gJIFtaqZGMp5ekrxy+XqkEMT65eb1qgdI0rHx+LI
         07OzGw+cU8nYTK6KOLD40UNGCc940OoMgjeXxV8pDuUvfUOVIoVolDPJhkRV09d9Yf4c
         krnYoV9q91+WcR0GTTtU/OgyUKRdBXm2boCoXvfpUk5DGyc4nU/yiYCGyuPxPFvn1rHB
         IMow==
X-Gm-Message-State: AC+VfDzPML918gEN6RLc1Kk5YDNDOkXLbJdE5UQA8t/mWcw40uKT4qtQ
        7KYvr7fBD42QV0dV7DKTUqYOjHM5dNnXlIqH6VcyVIGZ/aZ3pNrNjT44hafesMisYveL1YjS+Tl
        lImsccsP9N/1DZOU+8sRgN3xQG23N4x5qV8qXIdG3Liz8jNWw63/fk61qLSzkBWE=
X-Received: by 2002:a25:210b:0:b0:b9d:7887:4423 with SMTP id h11-20020a25210b000000b00b9d78874423mr6768244ybh.16.1685902040981;
        Sun, 04 Jun 2023 11:07:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ41k0JQ0Rgb4oamIPtOl2YDqXm2k+gWqhdlPbfMaObYYGP+EpFNoMd2Xr14SJFNxI1Y9SMEiabdS0cOpOTA3WE=
X-Received: by 2002:a25:210b:0:b0:b9d:7887:4423 with SMTP id
 h11-20020a25210b000000b00b9d78874423mr6768237ybh.16.1685902040769; Sun, 04
 Jun 2023 11:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230522132439.634031-1-aleksandr.mikhalitsyn@canonical.com>
 <20230522132439.634031-2-aleksandr.mikhalitsyn@canonical.com>
 <20230522133409.5c6e839a@kernel.org> <20230523-flechten-ortsschild-e5724ecc4ed0@brauner>
 <CAMw=ZnS8GBTDV0rw+Dh6hPv3uLXJVwapRFQHLMYEYGZHNoLNOw@mail.gmail.com>
 <20230523140844.5895d645@kernel.org> <CAEivzxeS2J5i0RJDvFHq-U_RAU5bbKVF5ZbphYDGoPcMZTsE3Q@mail.gmail.com>
 <CAMw=ZnRmNaoRb2uceatrV8EAufJSKZzD2AsfT5PJE8NBBOrHCg@mail.gmail.com>
 <20230524081933.44dc8bea@kernel.org> <CAEivzxcTEghPqk=9hQMReSGzE=ruWnJyiuPhW5rGd7eUOEg12A@mail.gmail.com>
 <20230604110211.3f6401c6@kernel.org>
In-Reply-To: <20230604110211.3f6401c6@kernel.org>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Sun, 4 Jun 2023 20:07:09 +0200
Message-ID: <CAEivzxeVeuFW+ADJFO-kCBtyn345nTX=T3aKTdwWY01JgsLPQg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/3] scm: add SO_PASSPIDFD and SCM_PIDFD
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Luca Boccassi <bluca@debian.org>,
        Christian Brauner <brauner@kernel.org>, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 4, 2023 at 8:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 24 May 2023 17:45:25 +0200 Aleksandr Mikhalitsyn wrote:
> > > How about you put the UNIX -> bool patch at the end of the series,
> > > (making it a 4 patch series) and if there's a discussion about it
> > > I'll just skip it and apply the first 3 patches?
> >
> > Sure, I will do that!
>
> Hi Aleksandr! Did you disappear? Have I missed v7?

Dear Jakub,

of course I'm not, I've just got distracted with other things last
week. Will send -v7 this week!
Thanks for paying attention to the series ;-)

Kind regards,
Alex
