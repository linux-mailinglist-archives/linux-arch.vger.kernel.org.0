Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAED46E1021
	for <lists+linux-arch@lfdr.de>; Thu, 13 Apr 2023 16:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDMOix (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Apr 2023 10:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMOiw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Apr 2023 10:38:52 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6D44EFD
        for <linux-arch@vger.kernel.org>; Thu, 13 Apr 2023 07:38:51 -0700 (PDT)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F0273F43B
        for <linux-arch@vger.kernel.org>; Thu, 13 Apr 2023 14:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681396729;
        bh=X4kAT0rL5ThCmBYSbgh/zubXsP0GX7YEMqUvRhK1pXI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=op8Z3Gk/1fztbo6lt5Og3YG0BTREUoB7il9QQS3Zh7jdtHhKvyigxZWJfyuHkdAl+
         R2BHmff7y21cRhSgziv2mkHYZ6FJ3DW4641Z403HHW1sZ9m3bz/azz8rkfD/REcK9n
         u78BLi3v5NRU4q7iVbjWvEO9UHF+vwLPazrEJKdtQaBWnWvjVa8c2qMAaWg3kQtq5I
         et7+ZV5H7S61DPGpjJWzrODZJUPena8vhU25owjLjTYsfO/9IonmHiz61KMWv+gaLB
         vywTayFffaW6w1HO7KT8TUjwj9CEw//7mwvjcVkaXbLUwQeEU/d9/YFeu04My5uDNO
         jkwFbMkVJ/Guw==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-54f93850a86so53736567b3.2
        for <linux-arch@vger.kernel.org>; Thu, 13 Apr 2023 07:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681396727; x=1683988727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4kAT0rL5ThCmBYSbgh/zubXsP0GX7YEMqUvRhK1pXI=;
        b=Xnm0E7zjh2zv37GQlsiC4pYFQnXxH6rmETtnuh25K+6iib/osf84Tovm6d0w4lxd6Q
         Qi6mncXdj12KcELSUu/fizXMXf+/pD61AAOBJkd8uwh5Mz6qP6POW5LDSyL9huSB+B/o
         IRq62i+xP1DQwzxmpZ0Rl/PpaPEuaTtwDtffe/t6KmUjxan/zTgosPDFR7Q8JpACodaZ
         O1LUmVKq09CihokmF6OVot7nKf7nonxKqjCiq7EOlqokuELRaFxIXs3Eaivr0TY5ar6R
         VQ+8NcIyC+6D696k8c3rQEq8TAXWB8TDfSGzHTM1B642uXlbfIqJV6TzMKe7bfvxgl2F
         xMZw==
X-Gm-Message-State: AAQBX9fc02fw9X5LcXTPxnnn93Ts6xxA4x8N+Zfx2pm3MtTwsTjCrcwY
        I1Wh/E0V3gvT1y5O7RdwIb88DILa2EQ3fcB8AnT3sPQLgkvJUOKThT1L7CSb0ldzKEEA7za2NTI
        Vel4fTHIzGoQDFjs9oS7s6utGApj0EnGR3T8nRC8tjB5sR4/sdOKTsS4=
X-Received: by 2002:a81:4415:0:b0:54f:9e1b:971c with SMTP id r21-20020a814415000000b0054f9e1b971cmr1543622ywa.1.1681396727128;
        Thu, 13 Apr 2023 07:38:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350bUW5jFJ5LMk7+hETV10BLMcQ5bG69GeMAW8TnltznTEQ5Fc6ojtahmmyRWFbfX1EZ5DEW0r8L6cu9w4KKmRl0=
X-Received: by 2002:a81:4415:0:b0:54f:9e1b:971c with SMTP id
 r21-20020a814415000000b0054f9e1b971cmr1543599ywa.1.1681396726922; Thu, 13 Apr
 2023 07:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230413133355.350571-1-aleksandr.mikhalitsyn@canonical.com>
 <20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com> <CANn89iLuLkUvX-dDC=rJhtFcxjnVmfn_-crOevbQe+EjaEDGbg@mail.gmail.com>
In-Reply-To: <CANn89iLuLkUvX-dDC=rJhtFcxjnVmfn_-crOevbQe+EjaEDGbg@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Thu, 13 Apr 2023 16:38:35 +0200
Message-ID: <CAEivzxcEhfLttf0VK=NmHdQxF7CRYXNm6NwUVx6jx=-u2k-T6w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/4] net: socket: add sockopts blacklist for
 BPF cgroup hook
To:     Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, daniel@iogearbox.net,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        linux-arch@vger.kernel.org, sdf@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 13, 2023 at 4:22=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 13, 2023 at 3:35=E2=80=AFPM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > During work on SO_PEERPIDFD, it was discovered (thanks to Christian),
> > that bpf cgroup hook can cause FD leaks when used with sockopts which
> > install FDs into the process fdtable.
> >
> > After some offlist discussion it was proposed to add a blacklist of
>
> We try to replace this word by either denylist or blocklist, even in chan=
gelogs.

Hi Eric,

Oh, I'm sorry about that. :( Sure.

>
> > socket options those can cause troubles when BPF cgroup hook is enabled=
.
> >
>
> Can we find the appropriate Fixes: tag to help stable teams ?

Sure, I will add next time.

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")

I think it's better to add Stanislav Fomichev to CC.

Kind regards,
Alex

>
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
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: linux-arch@vger.kernel.org
> > Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
>
> Thanks.
