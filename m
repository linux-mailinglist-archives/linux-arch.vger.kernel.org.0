Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3785F72BC36
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 11:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbjFLJ0T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 05:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjFLJZW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 05:25:22 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40873C19
        for <linux-arch@vger.kernel.org>; Mon, 12 Jun 2023 02:19:39 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f9d619103dso268781cf.1
        for <linux-arch@vger.kernel.org>; Mon, 12 Jun 2023 02:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686561579; x=1689153579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+9DO9QvRcGmz6N/mHMV0b4yXmnNikrhC006i06Umx0=;
        b=cqk//FV3ozIay6AgBNV5ob1IDy2+IOpYTfQi6FcibkQDiT/uOOWw5DYoOxBe5QSMDk
         BMk3XiRl+yus4FWheCEWRwNUsEPhfCjmqUvZVJF6Nm820rpz0mQQvvAbWi0+3j4kzTme
         p5MwCU3ZIrIvExqTao/NqZ+v+X0VWL4WXY3Zey77F0JOE3os2m3q5NUe/u5/kedBM7pN
         Ukz79VjzETQ3uce0SO4JmCYXK4ICfW1MuWGdzHNftYaGOQH+ZB7ICyIi64LOyTq+Bza7
         jSVvBo0w/U935/0Q2u5m11awIybDHitnEjlHWwCWcES82RFO0ZwSFBlHxsVdECTWxLdl
         +GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561579; x=1689153579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+9DO9QvRcGmz6N/mHMV0b4yXmnNikrhC006i06Umx0=;
        b=fu99eJJOgEfnFU2NDt/7lrMnm+rtVBkB27wOOEyqp9PABZnFFmef+KWZY8lbKbiPX9
         /ALXVWu0VQjS10i5UaEl5rwT0VFKe+2CZHS5mvnXBj8fsSu866FPax/WC/82AXf8sel1
         IaWDJAEJmYtJ7Y5hRKp/Zs9Shp+1o4V6vlwfGxyedq1h1e9nFoHR2yrKCQB8g/yIgo9L
         dIqhe3V0At3BQB8+5lVwnNkuZohXTnJCdC6uQxBW52pws7ub73+jj8aUGA+uB6j9Bosg
         sah5G3tP4qqQkPocbHxZ+lU4WKtAm1kJpfvg0fb4D41Y5qvGk1igY6e9sp5HAr0Qd7e1
         1Ivw==
X-Gm-Message-State: AC+VfDyhYHp7oPIVxnXWafvk/cXh0wwLhcQG0sMDrswQL7boEugvmFrh
        kgbK3kAEC8WnVdBuVljzuj4v0ynS5uOROOIdiY35dg==
X-Google-Smtp-Source: ACHHUZ6LI9YR9875qLIDvFSYBsHw1lc1NTBArmTCYMoCsG/VIQfxhlpZWokElhVbYmiE7Ww2KbVzZ7HLqQig6PHW0h0=
X-Received: by 2002:a05:622a:14c7:b0:3f6:97b4:1a4d with SMTP id
 u7-20020a05622a14c700b003f697b41a4dmr219703qtx.23.1686561578849; Mon, 12 Jun
 2023 02:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230608202628.837772-1-aleksandr.mikhalitsyn@canonical.com> <20230608202628.837772-2-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230608202628.837772-2-aleksandr.mikhalitsyn@canonical.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 12 Jun 2023 11:19:27 +0200
Message-ID: <CANn89iLhQYHLxGYefhzVOxWx7BA_qk4uxuPjvZOGGnaJNESYXQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/4] scm: add SO_PASSPIDFD and SCM_PIDFD
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

On Thu, Jun 8, 2023 at 10:26=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Implement SCM_PIDFD, a new type of CMSG type analogical to SCM_CREDENTIAL=
S,
> but it contains pidfd instead of plain pid, which allows programmers not
> to care about PID reuse problem.
>
> We mask SO_PASSPIDFD feature if CONFIG_UNIX is not builtin because
> it depends on a pidfd_prepare() API which is not exported to the kernel
> modules.
>
> Idea comes from UAPI kernel group:
> https://uapi-group.org/kernel-features/
>
> Big thanks to Christian Brauner and Lennart Poettering for productive
> discussions about this.
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
> Tested-by: Luca Boccassi <bluca@debian.org>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
