Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782B370C40B
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjEVRMV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 13:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjEVRMU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 13:12:20 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A442B7
        for <linux-arch@vger.kernel.org>; Mon, 22 May 2023 10:12:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-255401f977dso1431770a91.2
        for <linux-arch@vger.kernel.org>; Mon, 22 May 2023 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684775538; x=1687367538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kzg7DZdO+Fx5NTiphKDonLYUjRG7pPKdcN8BEiK0Q5Q=;
        b=liZNMPYz6Ln/UbX2RbKFz0oKNJCytFelVboUK2d9pq1Y84i8RFQpYQjlP1tpDjbwtG
         h+PuxWrI8JmIt9bLqHcjaXSoC01beyn56d7PYV6kfkcZXX+dNaDxc5MqhKqplkaFc3Ky
         Mm7GY4hQNOIhEo5YH9cviKJyc1FPDurYBFeVDxop1BiOGzacOpknf3S16eYWA5fiXBxB
         ee84pIPucMWp1WvXAXGE6I11PVbjAytgbV8Sq7gmLB7KQSWatcM/fJutZwgkaEEdZmPg
         0H8v5syw/rOVZOfK3XL5/jVXjEaM/2GcW5olGc3dDHiw6lU0FhKyNpQfTACCPr5K1yDn
         12aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684775538; x=1687367538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kzg7DZdO+Fx5NTiphKDonLYUjRG7pPKdcN8BEiK0Q5Q=;
        b=ZTLgvAeebw3tgDSsuWiQjXZwUb1uJ0dthwyt91QuT8BxFfbXjj/160++1wTRBjjHlD
         c87jayLp6wBqF40pKNwasIh6nzY0Ds25EVA59w65emJkvgLKQuTXneXZKdPP1PZM/szC
         3vI6pqfYGjW+cvOSwyzlJulRGW/WUHnB2wMq2Tmz0Jd3dqsge8Wsa6XAXeMcW/QvbMzp
         jx1SpGW6Drn/+8xzPndHgzNGmvY0vSs/AgW6beLjN715FRWIPDohsBk8NhOlAbV1+ao5
         Ne3l9kVyY8QJL9QAS0r6uiocH234TnSHnExRoefXI016Loic6MN2C0f5uVhzZitPCdhz
         JTtA==
X-Gm-Message-State: AC+VfDw51xrHH85MWmmzQAX43sgUL2hs2JPNHnJWIHZW8NlfHV8coVys
        5ppyhgFe2W5or0RVSXKM7cfQPgFwCa8nltiwiAzYCA==
X-Google-Smtp-Source: ACHHUZ42u+20u8Yh+qsy7h0iK2LWRoxiLcZjWSqhvAWKesEjBSGBFLI5AiStgbrXNeg38Rsxmoklpxsg6/IlOq1/Yxg=
X-Received: by 2002:a17:90a:70cf:b0:253:266a:3b00 with SMTP id
 a15-20020a17090a70cf00b00253266a3b00mr10614041pjm.37.1684775538452; Mon, 22
 May 2023 10:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230517113351.308771-1-aleksandr.mikhalitsyn@canonical.com>
 <20230517113351.308771-3-aleksandr.mikhalitsyn@canonical.com> <20230519-zielbereich-inkompatibel-79e1a910e3f9@brauner>
In-Reply-To: <20230519-zielbereich-inkompatibel-79e1a910e3f9@brauner>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 22 May 2023 10:12:07 -0700
Message-ID: <CAKH8qBsYWzh0ZYOdYcYYpMeB-2hhOjLzh7EBXbQpGpC3O=R3OQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/3] net: core: add getsockopt SO_PEERPIDFD
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Luca Boccassi <bluca@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-arch@vger.kernel.org
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

On Fri, May 19, 2023 at 4:03=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, May 17, 2023 at 01:33:50PM +0200, Alexander Mikhalitsyn wrote:
> > Add SO_PEERPIDFD which allows to get pidfd of peer socket holder pidfd.
> > This thing is direct analog of SO_PEERCRED which allows to get plain PI=
D.
> >
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Cc: Lennart Poettering <mzxreary@0pointer.de>
> > Cc: Luca Boccassi <bluca@debian.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: bpf@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: linux-arch@vger.kernel.org
> > Tested-by: Luca Boccassi <bluca@debian.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> > v5:
> >       - started using (struct proto)->bpf_bypass_getsockopt hook
>
> Looks good to me,
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>
