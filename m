Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81212755963
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jul 2023 04:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGQCHG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Jul 2023 22:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGQCHE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Jul 2023 22:07:04 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2C7E71
        for <linux-arch@vger.kernel.org>; Sun, 16 Jul 2023 19:06:56 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-79702eee5a8so1151748241.1
        for <linux-arch@vger.kernel.org>; Sun, 16 Jul 2023 19:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689559616; x=1692151616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJjcGeSu1yBzoQ4uVSesM2ecyKuvRbwcrty4LUDKxlU=;
        b=zxGaglwS9CAZ4msTb2quYvVyDdhCIfdP2OL8sIgGnG5ZrFeTCE1QL4ZnSKCEdj6i8U
         HDPe3D4zfgWy9P9W+agC7wGRI3sQRiTRoBug2lQICmfMxP2K0I/k5G4Fbctruv0fvLoo
         5Es07Z8HBY+N6cD6d9Vx5Wax3v/pyCywcDRYs4p0aDfCtiM98L23hfe3kCQ52wtF8ixf
         lsDh/biJ5vpGPQegdVr4JAoKaJXir25xPHbt3SuzrctZ+GQVDLm3gD31jjnfOmiY4Kpl
         GhjsXDLHLeYMFzbUcdJzXCnFuuolCnWqPKidoYZOZ6hGqJXcOcBbsDS+OGRUPsdYt+f9
         Cd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689559616; x=1692151616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJjcGeSu1yBzoQ4uVSesM2ecyKuvRbwcrty4LUDKxlU=;
        b=dzU79TkLKtakL9nvLT5gKyAqlVSqekSKSq+sCB6CuLCtypGXD2MzUhSMbOkKqwcC+I
         w6ilqNB7chb/w+FYXbirKa//TVFrPw28gQAedyk0l9Dg3cOzM/g77Klv+H8xaXeCxdVx
         WaND1ONojAPtbLN9AMBouQbZwP45NxzyuVy1bDlxcEt8ukbRtR1pBKtUd07N4Z5xA40+
         CuQsjY4kMN6A/B6aMkSs9RAX3cdm688lhBW3tgVjHFDiYfskodl2eFCiptV+Mie6qeti
         B2gihAgdkQPpCdq5hQPptEc6wCKHGVBjgkxJtO6hjPr3yhlV0kdYMyoCUQs9CWL3Rejs
         Zpzg==
X-Gm-Message-State: ABy/qLZ1oaQR6Mj7rqtKWNJlCFZschl+2g9E5nY1j1UoTeFAI6ucMvK4
        lHIUm9dBizyClaIAOEVfLGUiD3vrtfcjj5f8BKnpJA==
X-Google-Smtp-Source: APBJJlHX7G2n3fcw5u4/GzstdODdaVAWzRgj1dnNd8IYjjUYPzYGUi9QZj015F6z+NhwE8S8c+kxZ7VupF4wWL7vlS0=
X-Received: by 2002:a1f:5ed4:0:b0:471:1785:e838 with SMTP id
 s203-20020a1f5ed4000000b004711785e838mr5240616vkb.2.1689559615726; Sun, 16
 Jul 2023 19:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230710223304.1174642-1-almasrymina@google.com>
 <20230710223304.1174642-7-almasrymina@google.com> <73971895-6fa7-a5e1-542d-3faccbc4a830@kernel.org>
In-Reply-To: <73971895-6fa7-a5e1-542d-3faccbc4a830@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sun, 16 Jul 2023 19:06:44 -0700
Message-ID: <CAHS8izNrbrU2EHxJvBXm4QMyO25-OqHcCm3HiJ590HCNt=N5LQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/10] net: add SO_DEVMEM_DONTNEED setsockopt to
 release RX pages
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 16, 2023 at 4:57=E2=80=AFPM Andy Lutomirski <luto@kernel.org> w=
rote:
>
> On 7/10/23 15:32, Mina Almasry wrote:
> > Add an interface for the user to notify the kernel that it is done read=
ing
> > the NET_RX dmabuf pages returned as cmsg. The kernel will drop the
> > reference on the NET_RX pages to make them available for re-use.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > ---
>
> > +             for (i =3D 0; i < num_tokens; i++) {
> > +                     for (j =3D 0; j < tokens[i].token_count; j++) {
> > +                             struct page *pg =3D xa_erase(&sk->sk_page=
pool,
> > +                                                        tokens[i].toke=
n_start + j);
> > +
> > +                             if (pg)
> > +                                     put_page(pg);
> > +                             else
> > +                                     /* -EINTR here notifies the users=
pace
> > +                                      * that not all tokens passed to =
it have
> > +                                      * been freed.
> > +                                      */
> > +                                     ret =3D -EINTR;
>
> Unless I'm missing something, this type of error reporting is
> unrecoverable -- userspace doesn't know how many tokens have been freed.
>
> I think you should either make it explicitly unrecoverable (somehow shut
> down dmabuf handling entirely) or tell userspace how many tokens were
> successfully freed.
>

Thank you, the latter suggestion sounds perfect actually. The user
can't do much if the kernel fails to free all the tokens, but at least
it can know that something wrong is happening and can log an error for
further debugging. Great suggestion! Thanks!


--=20
Thanks,
Mina
