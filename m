Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F89790382
	for <lists+linux-arch@lfdr.de>; Sat,  2 Sep 2023 00:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjIAWDW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Sep 2023 18:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350842AbjIAVwC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2023 17:52:02 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF4C198D
        for <linux-arch@vger.kernel.org>; Fri,  1 Sep 2023 14:11:22 -0700 (PDT)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7E2E341D35
        for <linux-arch@vger.kernel.org>; Fri,  1 Sep 2023 21:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693602681;
        bh=XwIOmpIe/RrfEoBvhvmbdhClCHMkiyeb31e6bLO57k4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=RbRDFyHFknrfKtv/KobzhPOjs+v3Oj9QX/6zhij3WTbGo1Hui2RDCRRbaJF45Z1Hm
         DFYAdxMdqDoXit+RtRcT7bP+/roeyQtxoyRNSJXIgC7YtiaEmuz/EWh8dpTbYu1gy6
         eiKIXxhzLkrqppn7MjX3yntGkx+4/YMwlhn0U0bBuo7yRHrvWYsHNmpyHgPD5xQBeb
         Tywfm4xWNmhz3iGetMwB2YEuCcBdfnscv9IEVx7dgBvidsaxX1Sx9Yrbwo1bIEF6yb
         2dbkTg3EQFCVdVgrkRvj2911arsJpHN5yn2PwW9jBuYtcmayWhVKEmHPeWzx52iV4K
         EvKSJga3BShEA==
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-573a7a3c405so2517152eaf.1
        for <linux-arch@vger.kernel.org>; Fri, 01 Sep 2023 14:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693602680; x=1694207480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwIOmpIe/RrfEoBvhvmbdhClCHMkiyeb31e6bLO57k4=;
        b=jWTBbGek5ZNp/C9szkx+B9tXW8MZSS4fL887QdM6fMGd/yuO3olzBvlaNzgEvXyaqO
         bsaGvMoWlgM/KDL/O5W8WloBTw3TnZxfuyhoGLP9IGyBwux4VTLyn1fN5OPExtgd9JdO
         OtMKra9JC/s4jK8AugCNgjrCl0gCqAxGj98pSwgRdBh5RVrd+f44VrRLTR//drAFkojg
         zm4C0TDBCyxNJeUpmCfxvjiedGSkFbasDzvngKiIXtAwrtxh44jwO5IUAjF1quEGjKIX
         gbTpjFCHa+02BN1QbRRg/cogQPMFoRbp2FO+9WowRRwj3C0ASBrf4w8JQhakimGQWfm8
         iBSw==
X-Gm-Message-State: AOJu0YyRw3m0Cpl6t8oQB7W13CEC3JmEaN3yltbgQoEBv7u30dEWZhYC
        Y8JB5Q44zL6nq88ysPMkKvVvMcw2nmjr8weLRHJq+AzEZsd7bvare3m4Hewps0EATHfbZiWIM+h
        E6UHtioyotB7urgVS/Ya62BWcfT/ErrRFeSs/gmLwMxlFXcknbGaNX0E=
X-Received: by 2002:a05:6358:5e1c:b0:129:d242:f782 with SMTP id q28-20020a0563585e1c00b00129d242f782mr2635956rwn.0.1693602680325;
        Fri, 01 Sep 2023 14:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl1MahQid8Pf8m4MydU5h0YzxnIX7NzFxvCQdVjKARyFXsvglURYjIg08zlkxTrL8/EbnM+/FQSo0UQik7w3c=
X-Received: by 2002:a05:6358:5e1c:b0:129:d242:f782 with SMTP id
 q28-20020a0563585e1c00b00129d242f782mr2635947rwn.0.1693602680104; Fri, 01 Sep
 2023 14:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230901205145.10640-A-hca@linux.ibm.com> <20230901205613.59455-1-kuniyu@amazon.com>
In-Reply-To: <20230901205613.59455-1-kuniyu@amazon.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Fri, 1 Sep 2023 23:11:09 +0200
Message-ID: <CAEivzxfhLC5zSxPUk8PE6jC9s0KbAzD2YzbomY2-skpF-dKMog@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/4] scm: add SO_PASSPIDFD and SCM_PIDFD
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     hca@linux.ibm.com, arnd@arndb.de, bluca@debian.org,
        brauner@kernel.org, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, keescook@chromium.org, kuba@kernel.org,
        ldv@strace.io, leon@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, mzxreary@0pointer.de,
        netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 1, 2023 at 10:56=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Fri, 1 Sep 2023 22:51:45 +0200
> > On Fri, Sep 01, 2023 at 01:33:22PM -0700, Kuniyuki Iwashima wrote:
> > > From: Heiko Carstens <hca@linux.ibm.com>
> > > Date: Fri, 1 Sep 2023 22:05:17 +0200
> > > > On Thu, Jun 08, 2023 at 10:26:25PM +0200, Alexander Mikhalitsyn wro=
te:
> > > > > +       if ((msg->msg_controllen <=3D sizeof(struct cmsghdr)) ||
> > > > > +           (msg->msg_controllen - sizeof(struct cmsghdr)) < size=
of(int)) {
> > > > > +               msg->msg_flags |=3D MSG_CTRUNC;
> > > > > +               return;
> > > > > +       }
> > > >
> > > > This does not work for compat tasks since the size of struct cmsghd=
r (aka
> > > > struct compat_cmsghdr) is differently. If the check from put_cmsg()=
 is
> > > > open-coded here, then also a different check for compat tasks needs=
 to be
> > > > added.
> > > >
> > > > Discovered this because I was wondering why strace compat tests fai=
l; it
> > > > seems because of this.
> > > >
> > > > See https://github.com/strace/strace/blob/master/tests/scm_pidfd.c
> > > >
> > > > For compat tasks recvmsg() returns with msg_flags=3DMSG_CTRUNC sinc=
e the
> > > > above code expects a larger buffer than is necessary.
> > >
> > > Can you test this ?
> >
> > Works for me.
> >
> > Tested-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Thanks for reporting this, Heiko!
My bad.

Kuniyuki,
Thanks for the quick fix.

Kind regards,
Alex

>
> Thanks!
> I'll post a formal patch.
