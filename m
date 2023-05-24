Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0480170F472
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 12:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEXKnz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 06:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjEXKny (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 06:43:54 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8CDC5
        for <linux-arch@vger.kernel.org>; Wed, 24 May 2023 03:43:53 -0700 (PDT)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 607344429D
        for <linux-arch@vger.kernel.org>; Wed, 24 May 2023 10:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684925028;
        bh=VcR2dM9dZkrtIAYuc+uEYt6q6RFFCfHdSpmFwxj+wQM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ICYhzP3alsOukQOEQWvvrws87UFBIOwILO305wzr8xWUwsG1L4ZC9c0oKite3wrPL
         EseAWN1gLDwCqoX3G1/6Z8nMAfkDgMAPmA4HdaANqOUc7IlhRJsf+ZlnL3qXx8dKOT
         9IuEpcRvvkymZJigK9A5WSkegXUrLgYF0YGQhSvn+RVQEMhmipANGe1WOoLhiOo6qK
         HFnthkYPVbRSjYMocf5lqIbMy1ST66igp5lJXNyT2z7xUfmFcdb1jQOOI2VqKbahpi
         rKzNsvbY31qL/+0z+2KTWUfYO+UFEU45GTtC6mykSut3tXiSaJ/0Rqcwj/bh/+nW0d
         4mYdjt8HJCEYA==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-561bad0999aso18630147b3.0
        for <linux-arch@vger.kernel.org>; Wed, 24 May 2023 03:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684925027; x=1687517027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcR2dM9dZkrtIAYuc+uEYt6q6RFFCfHdSpmFwxj+wQM=;
        b=AiS5i4v14cYgfylVp23X2184D4HY+4bA+jEWp6V8zyDUHP/Gk7EdVE0GCl4O95xcm+
         JGxD/JLV2tGhjNWn3KSqNWszgH9GittSgJIMN9gYQnuSbSdiwcuin0DqNcRIsuaqTYNR
         W6zy7t3NjQaQyi/UpZ+wxsmlSRU10jZCUpvJlvl+Rs9aFVEqIE3YTYe83z7nNk5HqAy9
         ixaQj9xq45PonUhD5yN0BRs13w4opnD4BbwV/o141sY8RAxN/vZgcrLlP7t4LOAre4xY
         feRYMoAkW+MDNUayUBjkt6m3tTDeD/ZCTnqzGSs3suhxQs2UN6dFUPWwKUEqXE+Dd6oT
         C1/w==
X-Gm-Message-State: AC+VfDyUftHUG8+GfqDzP73xZUNSm+KziKSlYD3hVat40CbxrNIHRoja
        DlqyxP4glCdGNl7vMVhFYL1nqcgznyeyL0PAToh1QLMJUiBjr9TLmzXUBsxstk4ah5i6ed2fiT3
        EGycCftXzerAye9L/fNQPEudzHd2ad0bOka2fgutJ+kBsxqGdpgzmd0Q=
X-Received: by 2002:a81:ab50:0:b0:561:179b:1276 with SMTP id d16-20020a81ab50000000b00561179b1276mr16277645ywk.26.1684925027356;
        Wed, 24 May 2023 03:43:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4iOk/L3sMlt+J6yeXjbzBVkYzcNAS9i5TiiFe4XzBVBtPC3NhYAtD5clOw6pJbtiOOIbVSK/C8SNjWhkpcZOY=
X-Received: by 2002:a81:ab50:0:b0:561:179b:1276 with SMTP id
 d16-20020a81ab50000000b00561179b1276mr16277633ywk.26.1684925027137; Wed, 24
 May 2023 03:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230522132439.634031-1-aleksandr.mikhalitsyn@canonical.com>
 <20230522132439.634031-2-aleksandr.mikhalitsyn@canonical.com>
 <20230522133409.5c6e839a@kernel.org> <20230523-flechten-ortsschild-e5724ecc4ed0@brauner>
 <CAMw=ZnS8GBTDV0rw+Dh6hPv3uLXJVwapRFQHLMYEYGZHNoLNOw@mail.gmail.com> <20230523140844.5895d645@kernel.org>
In-Reply-To: <20230523140844.5895d645@kernel.org>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 24 May 2023 12:43:36 +0200
Message-ID: <CAEivzxeS2J5i0RJDvFHq-U_RAU5bbKVF5ZbphYDGoPcMZTsE3Q@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 23, 2023 at 11:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 23 May 2023 11:44:01 +0100 Luca Boccassi wrote:
> > > I really would like to avoid that because it will just mean that some=
one
> > > else will abuse that function and then make an argument why we should
> > > export the other function.
> > >
> > > I think it would be ok if we required that unix support is built in
> > > because it's not unprecedented either and we're not breaking anything=
.
> > > Bpf has the same requirement:
> > >
> > >   #if IS_BUILTIN(CONFIG_UNIX) && defined(CONFIG_BPF_SYSCALL)
> > >   struct bpf_unix_iter_state {
> > >           struct seq_net_private p;
> > >           unsigned int cur_sk;
> > >           unsigned int end_sk;
> > >           unsigned int max_sk;
> > >           struct sock **batch;
> > >           bool st_bucket_done;
> > >   };
> > >
> > > and
> > >
> > >   #if IS_BUILTIN(CONFIG_UNIX) && defined(CONFIG_BPF_SYSCALL) && defin=
ed(CONFIG_PROC_FS)
> > >   DEFINE_BPF_ITER_FUNC(unix, struct bpf_iter_meta *meta,
> > >                        struct unix_sock *unix_sk, uid_t uid)
>
> Don't think we should bring BPF into arguments about uAPI consistency :S
>
> > Some data points: Debian, Ubuntu, Fedora, RHEL, CentOS, Archlinux all
> > ship with CONFIG_UNIX=3Dy, so a missing SCM_PIDFD in unlikely to have a
> > widespread impact, and if it does, it might encourage someone to
> > review their kconfig.
>
> IDK how you can argue that everyone sets UNIX to =3Dy so hiding SCM_PIDFD
> is fine and at the same time not be okay with making UNIX a bool :S
>
> > As mentioned on the v5 thread, we are waiting for this API to get the
> > userspace side sorted (systemd/dbus/dbus-broker/polkit), so I'd be
> > really grateful if we could start with the simplest and most
> > conservative approach (which seems to be the current one in v6 to me),
> > and then eventually later decide whether to export more functions, or
> > to deprecate CONFIG_UNIX=3Dm, or something else entirely, as that
> > doesn't really affect the shape of the UAPI, just the details of its
> > availability. Thank you.
>
> Just throw in a patch to make UNIX a bool and stop arguing then.

Dear Jakub,

Thanks for your attention to these patch series!

I'm ready to prepare/send a patch to make CONFIG_UNIX bool.

I will send SO_PEERPIDFD as an independent patch too, because it
doesn't require this change with CONFIG_UNIX
and we can avoid waiting until CONFIG_UNIX change will be merged.
I've a feeling that the discussion around making CONFIG_UNIX  to be a
boolean won't be easy and fast ;-)

Kind regards,
Alex
