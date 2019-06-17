Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2498E48CE5
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2019 20:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfFQStI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jun 2019 14:49:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35025 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfFQStI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jun 2019 14:49:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so776772ljh.2
        for <linux-arch@vger.kernel.org>; Mon, 17 Jun 2019 11:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nOSaXiJzVDj5IM4aW+0gcUHxkkLPWAqm3lSgcsh3l8M=;
        b=MvA2SRX/VcHcJ/x8ZeKMF1KFFgxP8vUPLAhIurER9lCvX2VZXMWPDioh1w1srq6rzn
         Zwoo9Xfyqg0l9Ax5Wz+NR2tDOku7ZmEn5fLqn1riZVzXmnUdqe43mDIsx1k087Au98Il
         q7u7RVM4b0VfVPtmQV1Q1W6OJiHBfodkWBImc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nOSaXiJzVDj5IM4aW+0gcUHxkkLPWAqm3lSgcsh3l8M=;
        b=B1ivpLY7BcGtpeqLRQL0COxTAdqlyn08IGTjIIlkxXrDXQAOySkCJ4fRXjm5eK0xJA
         GRZG8yDJiIErvneag4Sr5sh2yoIGABXpjShoJbdY8QlZYnmWwdt/iP7z2Vuqy9Z1dam8
         PoHEycQmY7pHIZIRqbsRZM1Wr2JaLo0NBg5xm/vRJP9IATXX34WzuIHqEDgrz7795+fo
         lFnR/S9HxcDxylVUxoTmizUMdxnTLjUU+Lt/ALz2jO2k6+JHuhsrzkX2G1UWql/N8K+1
         /+k03LvnZ1JnZTRb2OfLgItlj382RBo4/es0NvE1i37kH0Y0lhQ/+v0YvjEwQRX7yn2z
         2uXg==
X-Gm-Message-State: APjAAAVIqPdwvRjd2seAqTDs8QqTjjPsvPqVSn7TcfFlwY+ODYuj/hmJ
        OgKhNCFQgmvfHjtBnq/Q7AaW0p3gu9g=
X-Google-Smtp-Source: APXvYqwGuTojQ9uSbycaBPt6GIS3CYnFoyPY7F2FwElO5K7CiATLCle2m+fyvwG+P1nKZ23qPGXXyw==
X-Received: by 2002:a2e:8681:: with SMTP id l1mr2855517lji.166.1560797346083;
        Mon, 17 Jun 2019 11:49:06 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y15sm2225716lje.11.2019.06.17.11.49.03
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:49:04 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id q26so7342801lfc.3
        for <linux-arch@vger.kernel.org>; Mon, 17 Jun 2019 11:49:03 -0700 (PDT)
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr6889528lfm.134.1560797343688;
 Mon, 17 Jun 2019 11:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com> <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
 <871s05fd8o.fsf@oldenburg2.str.redhat.com> <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
 <87sgs8igfj.fsf@oldenburg2.str.redhat.com> <CAHk-=wjCwnk0nfgCcMYqqX6o9bBrutDtut_fzZ-2VwiZR1y4kw@mail.gmail.com>
 <87k1dkdr9c.fsf@oldenburg2.str.redhat.com> <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
 <87a7egdqgr.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87a7egdqgr.fsf@oldenburg2.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 11:48:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjF6ek4v04w2O3CuOaauDERfdyduW+h=u9uN5ja1ObLzQ@mail.gmail.com>
Message-ID: <CAHk-=wjF6ek4v04w2O3CuOaauDERfdyduW+h=u9uN5ja1ObLzQ@mail.gmail.com>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Paul Burton <pburton@wavecomp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 17, 2019 at 11:19 AM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > Unlike the "val[]" thing, I don't think anybody is supposed to access
> > those fields directly.
>
> Well, glibc already calls it __val =E2=80=A6

Hmm. If user space already doesn't see the "val[]" array anyway, I
guess we could just do that in the kernel too.

Looking at the glibc headers I have for fds_bits, glibc seems to do
*both* fds_bits[] and __fds_bits[] depending on __USE_XOPEN or not.

Anyway, that all implies to me that we might as well just go the truly
mindless way, and just do the double underscores and not bother with
renaming any files.

I thought people actually might care about the "val[]" name because I
find that in documentation, but since apparently it's already not
visible to user space anyway, that can't be true.

I guess that makes the original patch acceptable, and we should just
do the same thing to fds_bits..

                     Linus
