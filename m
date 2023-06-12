Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9386472BCC6
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjFLJds (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjFLJc5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 05:32:57 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810185242
        for <linux-arch@vger.kernel.org>; Mon, 12 Jun 2023 02:25:45 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f9a81da5d7so316141cf.0
        for <linux-arch@vger.kernel.org>; Mon, 12 Jun 2023 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686561944; x=1689153944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSSAFm6+La0WYoIdzdJ2avWuWJ5iicl8dG6XgVp+olQ=;
        b=zZps9/nxLxCtnv5ZhZR8AYZPyMufWje3CcLJRlAg/i/29S9gt4HxXzx6YUU07CJ0Xw
         TaFaE1h5HNNtq7ESaOcRJp6oq2rV2nuDuAI9ywPVcajyYRBqACVV0meILNibQBXrIRaq
         SxtekwESF9/Btl7FT5CyiEkx7/t0JnKAwWT9uuAuITp2jENeIB2aIgeo+04rH7o11bM9
         x1HPjg3dnQSz+nVaKF9gFva1wXrW7YawgaVx9Uuq/WXurTMvDwaQlzksC5k8KmlTS9lc
         VeC5YWjBR36ci0QcEuAJCGnyvJHYMAskCeROdpC4/aLkgd9Lwn7S6OwgiIjAdNx/RYA3
         GCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561944; x=1689153944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSSAFm6+La0WYoIdzdJ2avWuWJ5iicl8dG6XgVp+olQ=;
        b=O4DHjViVliz4JIVpLcwjlhnF2ROt+mKAnVxy5728wNdF96NEj0JRdu1SVbAk4uPnZ8
         Tku2CIyEdDLJ5Jv8H4LxwKNZQYUQkvi29tPgDzlQ5qkjLDHdR3R2bFmLqWAwj7tZGXKA
         5LI/IR8dQY5XF+rKMfL9sF1Ww/IOaqbuq7O/veITuN1EawSxkcI9FJOv49I6JOPKCxKr
         spBYkfT62Yab7KusHsdRJPauYAWaTx+kZyolqpEw92mYe1oFHWyxDDVdIAD6gwGDgkpf
         d4dhNOM3NuMfAIZp4LuWQ5s1cBrs2OMAWNSItH3zoSlKdH63SXf+V5WVUYeZm9bCgyDE
         teWw==
X-Gm-Message-State: AC+VfDxOX3TGs9gDRs1mKm6Jgzs/nuDAmM8SDznY4tvE6ZKYX4jemc8C
        J7CQAc+ztFKsZhuKoL6tGCVKaSUwPFlnxbxsaFYCdQ==
X-Google-Smtp-Source: ACHHUZ51aDjv0JS+PAW08rSBNZ0RJJgZL+Bg/FxemASKSUJ4kWa+tvdS4Bq5PZqqsY+jjxVBUm5vyTI/8xdZMyYInwU=
X-Received: by 2002:ac8:7f15:0:b0:3f7:ff4a:eae5 with SMTP id
 f21-20020ac87f15000000b003f7ff4aeae5mr311442qtk.12.1686561944340; Mon, 12 Jun
 2023 02:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230608202628.837772-1-aleksandr.mikhalitsyn@canonical.com> <20230608202628.837772-5-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230608202628.837772-5-aleksandr.mikhalitsyn@canonical.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 12 Jun 2023 11:25:33 +0200
Message-ID: <CANn89iKHxT_yFRE9StCF0QzzYENxAn9E-QxvgB0cA13tEGFXig@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/4] af_unix: Kconfig: make CONFIG_UNIX bool
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
        Luca Boccassi <bluca@debian.org>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 8, 2023 at 10:27=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Let's make CONFIG_UNIX a bool instead of a tristate.
> We've decided to do that during discussion about SCM_PIDFD patchset [1].
>
> [1] https://lore.kernel.org/lkml/20230524081933.44dc8bea@kernel.org/
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
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
