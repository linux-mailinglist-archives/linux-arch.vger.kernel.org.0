Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635856DE058
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 18:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDKQDB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 12:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDKQCw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 12:02:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB005B85
        for <linux-arch@vger.kernel.org>; Tue, 11 Apr 2023 09:02:47 -0700 (PDT)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 87C733F232
        for <linux-arch@vger.kernel.org>; Tue, 11 Apr 2023 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681228965;
        bh=tST28qf9fVm0KVVc5h3Ft+/jB9NLl6vxNB0dblfyAO8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=vEBf1gg6OtFrt4/smTiJlEDYtAPESzNB6NNFHm51rACYX2r8qg2+jQnKuADInWa0U
         UgXFG81QmDmbcnttjUya1lEc+r4REwyqaQ28ebXTVKyprrybqIucqIrc7UAfDiEcto
         2RbdZcPAsMWhlxiDzXc/RVe3croWJMFqZhRAau53rRpPLIvG3BNtDzm2xaV1+2xNQn
         /wlEoYqkxs+FmLMVGKCdjA7cgWPwobWb8K6pn4DMueF0FyS9KUaNcc4k2tK16aarcg
         xNfL8eL/6t4EPQgaerk4Hqi+FrrD/qZWGQuGrLfSi/zVXfBbrhL2H5ABg+Sj15JcVj
         L1aFcL+8yITUw==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-54c1e4b7e63so140242537b3.20
        for <linux-arch@vger.kernel.org>; Tue, 11 Apr 2023 09:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681228963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tST28qf9fVm0KVVc5h3Ft+/jB9NLl6vxNB0dblfyAO8=;
        b=y1mGGEbBs2XU3lgQPDKVbz2dAYTp4i/8fwF82mjYMbbUvXapegfrzSYPccsTrV+/mz
         Yw0gsGqpEUhGn1Wu7LQJnGrEunWL2ryMJ9kbYk55knWhEajkGOTHXRVagAQkkS6zWz2B
         zTrEVpiV+ZYJlXgsTXg6pkpDulKrLFq3FG5Gatn5OZtzGrfue3E90ijITapuq+vZaO5R
         aS2RDh8MBi7rBi3bzyFdss12EaDspn9Ek94HD4CEJOzVcDTNGG6M1Ddaj2YZDPKVZxwA
         F0qPoJu+yLcJaDCoAMRtAWv6sGnCMkILG+Hx/YR/HRXrIbBMXw+7VZiPveJGa5r8qezk
         Ow0A==
X-Gm-Message-State: AAQBX9crPMt+RKrwkmc040QoUXkx1vRpsTqG1hIL8JSoUBL2X4FvyUU3
        l49haWB4PtRPENIZSHZXeqAAmAF8oNTop4eWVJG+n5Wy3qah7k9zzHM6Sgr7vMTtlVjQfL3IyVL
        nJTXemYBoo73xlVTRU5cLo4ibdGLr8j95ygDklA7emEVvSV0pmmehgLo=
X-Received: by 2002:a81:af26:0:b0:54f:8170:2977 with SMTP id n38-20020a81af26000000b0054f81702977mr413681ywh.1.1681228963198;
        Tue, 11 Apr 2023 09:02:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350aXhhuHzp96TVZTyPA9Nyg8o4Na/+MVd4CEuFbkZGV7WrVzHmQxwT5hXXmn1gopSs5Bm7flly68tooAjB2h02M=
X-Received: by 2002:a81:af26:0:b0:54f:8170:2977 with SMTP id
 n38-20020a81af26000000b0054f81702977mr413671ywh.1.1681228962975; Tue, 11 Apr
 2023 09:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230411104231.160837-1-aleksandr.mikhalitsyn@canonical.com>
 <20230411104231.160837-4-aleksandr.mikhalitsyn@canonical.com> <20230411-pantoffeln-voreilig-208e37ba62bb@brauner>
In-Reply-To: <20230411-pantoffeln-voreilig-208e37ba62bb@brauner>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Tue, 11 Apr 2023 18:02:31 +0200
Message-ID: <CAEivzxe5KL3+D3zPqBBXzNXcyrNfYDZeEb+1z4aUW559rusVBg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/4] net: core: add getsockopt SO_PEERPIDFD
To:     Christian Brauner <brauner@kernel.org>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Luca Boccassi <bluca@debian.org>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 11, 2023 at 5:57=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Apr 11, 2023 at 12:42:30PM +0200, Alexander Mikhalitsyn wrote:
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
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: linux-arch@vger.kernel.org
> > Tested-by: Luca Boccassi <bluca@debian.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> > v3:
> >       - fixed possible fd leak (thanks to Christian Brauner)
> > v2:
> >       According to review comments from Kuniyuki Iwashima and Christian=
 Brauner:
> >       - use pidfd_create(..) retval as a result
> >       - whitespace change
> > ---
> >  arch/alpha/include/uapi/asm/socket.h    |  1 +
> >  arch/mips/include/uapi/asm/socket.h     |  1 +
> >  arch/parisc/include/uapi/asm/socket.h   |  1 +
> >  arch/sparc/include/uapi/asm/socket.h    |  1 +
> >  include/uapi/asm-generic/socket.h       |  1 +
> >  net/core/sock.c                         | 33 +++++++++++++++++++++++++
> >  net/socket.c                            |  7 ++++++
> >  tools/include/uapi/asm-generic/socket.h |  1 +
> >  8 files changed, 46 insertions(+)
> >
> > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/=
uapi/asm/socket.h
> > index ff310613ae64..e94f621903fe 100644
> > --- a/arch/alpha/include/uapi/asm/socket.h
> > +++ b/arch/alpha/include/uapi/asm/socket.h
> > @@ -138,6 +138,7 @@
> >  #define SO_RCVMARK           75
> >
> >  #define SO_PASSPIDFD         76
> > +#define SO_PEERPIDFD         77
> >
> >  #if !defined(__KERNEL__)
> >
> > diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/ua=
pi/asm/socket.h
> > index 762dcb80e4ec..60ebaed28a4c 100644
> > --- a/arch/mips/include/uapi/asm/socket.h
> > +++ b/arch/mips/include/uapi/asm/socket.h
> > @@ -149,6 +149,7 @@
> >  #define SO_RCVMARK           75
> >
> >  #define SO_PASSPIDFD         76
> > +#define SO_PEERPIDFD         77
> >
> >  #if !defined(__KERNEL__)
> >
> > diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/includ=
e/uapi/asm/socket.h
> > index df16a3e16d64..be264c2b1a11 100644
> > --- a/arch/parisc/include/uapi/asm/socket.h
> > +++ b/arch/parisc/include/uapi/asm/socket.h
> > @@ -130,6 +130,7 @@
> >  #define SO_RCVMARK           0x4049
> >
> >  #define SO_PASSPIDFD         0x404A
> > +#define SO_PEERPIDFD         0x404B
> >
> >  #if !defined(__KERNEL__)
> >
> > diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/=
uapi/asm/socket.h
> > index 6e2847804fea..682da3714686 100644
> > --- a/arch/sparc/include/uapi/asm/socket.h
> > +++ b/arch/sparc/include/uapi/asm/socket.h
> > @@ -131,6 +131,7 @@
> >  #define SO_RCVMARK               0x0054
> >
> >  #define SO_PASSPIDFD             0x0055
> > +#define SO_PEERPIDFD             0x0056
> >
> >  #if !defined(__KERNEL__)
> >
> > diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-gener=
ic/socket.h
> > index b76169fdb80b..8ce8a39a1e5f 100644
> > --- a/include/uapi/asm-generic/socket.h
> > +++ b/include/uapi/asm-generic/socket.h
> > @@ -133,6 +133,7 @@
> >  #define SO_RCVMARK           75
> >
> >  #define SO_PASSPIDFD         76
> > +#define SO_PEERPIDFD         77
> >
> >  #if !defined(__KERNEL__)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 3f974246ba3e..2b040a69e355 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1763,6 +1763,39 @@ int sk_getsockopt(struct sock *sk, int level, in=
t optname,
> >               goto lenout;
> >       }
> >
> > +     case SO_PEERPIDFD:
> > +     {
> > +             struct pid *peer_pid;
> > +             struct file *pidfd_file =3D NULL;
> > +             int pidfd;
> > +
> > +             if (len > sizeof(pidfd))
> > +                     len =3D sizeof(pidfd);
> > +
> > +             spin_lock(&sk->sk_peer_lock);
> > +             peer_pid =3D get_pid(sk->sk_peer_pid);
> > +             spin_unlock(&sk->sk_peer_lock);
> > +
> > +             pidfd =3D pidfd_prepare(peer_pid, 0, &pidfd_file);
> > +
> > +             put_pid(peer_pid);
>
> Would be a bit nicer if this would be:
>
>         pidfd =3D pidfd_prepare(peer_pid, 0, &pidfd_file);
>         put_pid(peer_pid);
>         if (pidfd < 0)
>                 return pidfd;
>         if (copy_to_sockptr(optval, &pidfd, len) ||
>             copy_to_sockptr(optlen, &len, sizeof(int)))
{
                            put_unused_fd(pidfd);
                            fput(pidfd_file);

are still needed there, right?

>                 return -EFAULT;
}

>
>         fd_install(pidfd, pidfd_file);
>         return 0;
>
> Otherwise seems good enough to me.

Will do.

>
> > +
> > +             if (copy_to_sockptr(optval, &pidfd, len) ||
> > +                 copy_to_sockptr(optlen, &len, sizeof(int))) {
> > +                     if (pidfd >=3D 0) {
> > +                             put_unused_fd(pidfd);
> > +                             fput(pidfd_file);
> > +                     }
> > +
> > +                     return -EFAULT;
> > +             }
> > +
> > +             if (pidfd_file)
> > +                     fd_install(pidfd, pidfd_file);
> > +
> > +             return 0;
> > +     }
> > +
> >       case SO_PEERGROUPS:
> >       {
> >               const struct cred *cred;
> > diff --git a/net/socket.c b/net/socket.c
> > index 9c1ef11de23f..505b85489354 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -2248,6 +2248,13 @@ static bool sockopt_installs_fd(int level, int o=
ptname)
> >               default:
> >                       return false;
> >               }
> > +     } else if (level =3D=3D SOL_SOCKET) {
> > +             switch (optname) {
> > +             case SO_PEERPIDFD:
> > +                     return true;
> > +             default:
> > +                     return false;
> > +             }
> >       }
> >
> >       return false;
> > diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/ua=
pi/asm-generic/socket.h
> > index fbbc4bf53ee3..54d9c8bf7c55 100644
> > --- a/tools/include/uapi/asm-generic/socket.h
> > +++ b/tools/include/uapi/asm-generic/socket.h
> > @@ -122,6 +122,7 @@
> >  #define SO_RCVMARK           75
> >
> >  #define SO_PASSPIDFD         76
> > +#define SO_PEERPIDFD         77
> >
> >  #if !defined(__KERNEL__)
> >
> > --
> > 2.34.1
> >
