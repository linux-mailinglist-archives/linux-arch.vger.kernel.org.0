Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A231A6E0FDA
	for <lists+linux-arch@lfdr.de>; Thu, 13 Apr 2023 16:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjDMOWC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Apr 2023 10:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjDMOWB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Apr 2023 10:22:01 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3DD9019
        for <linux-arch@vger.kernel.org>; Thu, 13 Apr 2023 07:21:59 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54f21cdfadbso233917817b3.7
        for <linux-arch@vger.kernel.org>; Thu, 13 Apr 2023 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681395719; x=1683987719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VkXx3MwA5LRGwzJIwL5RFqYfkVgM3VjyEag+q2YqrU=;
        b=p/rPO5OT9jf0z5yXRSmrTLDoSIUepPZb11UDvDwuXp0EPGmz+QZuALKz8izmoVHVYS
         /rMDYmIJLs4IQHTnFkUSyK0v6X7bIr5NPle7P8+EDsN/RNdVSRNzVDDaVUkJ9S3lf6YD
         kTqa9QCLHGwTI9/fiDcuUmY99CapyntFhF4wgEOid05HBPSs6KmXYyYrOsA6x7fxXQND
         adyVYw/VeCPd8L8P29K+AEk9c82liGqfoLWi7l3fRH/yQtCNVduKPYRb6fgqig1bRLbc
         hNLGBr3hJUQbrR6cHpeqyuBlzBXXK+cVNxpFEIlcj+wY1NJbxum3s0lTm+Q3HxbBZRQo
         fyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681395719; x=1683987719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VkXx3MwA5LRGwzJIwL5RFqYfkVgM3VjyEag+q2YqrU=;
        b=NKf5esj07O1wJBEzWbOgZO9fJ207oR9awWzJILUOdSNbPFoKhDnvhvsp0G/vuKsVux
         KBJwxos7mZWXq1WnmTIc1ScQkovWzJRlGUIDr3eG8KglSclRuUaB3s06TBs5TwXiN6qK
         02BdzSyjy6onPH9dVbgHSWNwD+LRPoMo+oFSfBhIosnny33tvKooLba8hYDGxL5Kcuzi
         sDQlrJkkJGywCcUsogY4EtL/ldywouKZFcYx0HzyghOicv7uaNyjMuoVAk3IcaRqanFM
         EA4AgyM3kVsODtbwHkw5p1A+7bUe57zqS6p4cNjl7zDdwxS+hC/gcen3C9VL1Wx9O53Y
         5EwQ==
X-Gm-Message-State: AAQBX9dTPI3AHAPVjnzTh10Y8496jjf82zKQ4o1oh1GHvP4ZUhRlfFkr
        Lp0Nfgh7t6eFOVSm4X+YnG/4ICJz0lFXUuB7BOI5ng==
X-Google-Smtp-Source: AKy350aWLdSfLFnbU2dOD+LgGjl5FiO8H6fvc5f3Kk0Ef5grktsOqGaj+SF5L1Q0CPDWiWqjjTDuDi6S0gJr9BpqgO4=
X-Received: by 2002:a81:4323:0:b0:549:1e80:41f9 with SMTP id
 q35-20020a814323000000b005491e8041f9mr1492277ywa.10.1681395718858; Thu, 13
 Apr 2023 07:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230413133355.350571-1-aleksandr.mikhalitsyn@canonical.com> <20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 13 Apr 2023 16:21:47 +0200
Message-ID: <CANn89iLuLkUvX-dDC=rJhtFcxjnVmfn_-crOevbQe+EjaEDGbg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/4] net: socket: add sockopts blacklist for
 BPF cgroup hook
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
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
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 13, 2023 at 3:35=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> During work on SO_PEERPIDFD, it was discovered (thanks to Christian),
> that bpf cgroup hook can cause FD leaks when used with sockopts which
> install FDs into the process fdtable.
>
> After some offlist discussion it was proposed to add a blacklist of

We try to replace this word by either denylist or blocklist, even in change=
logs.

> socket options those can cause troubles when BPF cgroup hook is enabled.
>

Can we find the appropriate Fixes: tag to help stable teams ?

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
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>

Thanks.
