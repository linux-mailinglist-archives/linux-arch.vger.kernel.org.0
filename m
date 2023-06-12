Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2A572BC51
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 11:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjFLJ2s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 05:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjFLJ2M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 05:28:12 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442C4C0D
        for <linux-arch@vger.kernel.org>; Mon, 12 Jun 2023 02:22:24 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9a81da5d7so315431cf.0
        for <linux-arch@vger.kernel.org>; Mon, 12 Jun 2023 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686561744; x=1689153744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1dwKlQl3ch+rjWH3WakkZnRUyhMTlzScusDmgGxFrg=;
        b=7wUiTG0MmA7y+2lEinSm8giFjQJ6k0IDdL+is2Qw8cH14kEFKpZyKzAPPtwqLt/xBz
         eR4ss+OnelXP6bltOJo8JCbhScmYimFC53jjp2maM6atl4VhalAajHvqTz+c7vJnSkjL
         ZSvBC5coCX+q2tryUXmvGRMTvCUkcQc1xppJ7C9bof++HL2Hty/nrzozzodMtDO8MYtz
         9MBnl6xyZU4UTYrj+jDfey6Z5LMldODvWpWAlA0ArvaY0A/T1oI8EbSFV9L52cd8BjV2
         cS+pUKjhRNV2OEqhIF3UmmbjHIG1qJB1ZwbuKK0Q47sdcaOY8yiYSTWe/P0EqOoRneah
         eazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561744; x=1689153744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1dwKlQl3ch+rjWH3WakkZnRUyhMTlzScusDmgGxFrg=;
        b=X1XuVAR3J6EcNhQ+ImV0VMDoCRZOmI1slBpH7fw7Sla6wC7V5Gt4heod69M1vyf8rq
         g/DTbXEc4sB83rfXmpHO1p0damNiG19qwBwxtoyr2xCvqmptIJBDXZfX1mbmmOjgPl8t
         jDS7Kv1W4XPJGatKPuHN7Y4X25+J+5KrRKnuJXSUiiVRLWHc78XwzkpB8Avwxf1n91pP
         M5pziy5lcr6xHfZYvfMLHs1fPD7IHh/4Ql7UgK1w0iABFfHoDXrVJb8vBGCNdezalJJp
         SBsU+CDf1W1PJ7wiF0Jk51VvvG38+Jre2jXhrw44qVsGsibEAZA0Oa0s1HUhq5i8dqQO
         zi6w==
X-Gm-Message-State: AC+VfDw0rGcD9tHu3isVRWX5V0y2dwD5trQ2wptHiQRhXyPS6LaTqJ5L
        Iq+oti2ijIwck0xcu9fMKZkcUNrCbyA1LKlk/6OLcA==
X-Google-Smtp-Source: ACHHUZ51q8jd03XKL1NPqfVUpJ4pFcDkHkIvsYbMu+HQ8MbVxEfdIQG/UU8zuNvgxNJ/w6TPxfMn2uZ9T0lxjQ4932M=
X-Received: by 2002:a05:622a:1899:b0:3f9:a770:7279 with SMTP id
 v25-20020a05622a189900b003f9a7707279mr235109qtc.9.1686561743953; Mon, 12 Jun
 2023 02:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230608202628.837772-1-aleksandr.mikhalitsyn@canonical.com> <20230608202628.837772-3-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230608202628.837772-3-aleksandr.mikhalitsyn@canonical.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 12 Jun 2023 11:22:12 +0200
Message-ID: <CANn89iLT0SFf_2BVFhODYFWmr1rPu1o-AOaOhbGeLvAwuq5XbQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/4] net: core: add getsockopt SO_PEERPIDFD
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Luca Boccassi <bluca@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 8, 2023 at 10:26=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Add SO_PEERPIDFD which allows to get pidfd of peer socket holder pidfd.
> This thing is direct analog of SO_PEERCRED which allows to get plain PID.
>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: bpf@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
