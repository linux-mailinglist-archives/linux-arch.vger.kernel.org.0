Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24C54F1077
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 10:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377891AbiDDIGR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 04:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343920AbiDDIGQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 04:06:16 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87FF31DE5;
        Mon,  4 Apr 2022 01:04:20 -0700 (PDT)
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mzhzd-1nxVVy0j8j-00vdgg; Mon, 04 Apr 2022 10:04:19 +0200
Received: by mail-wr1-f45.google.com with SMTP id k23so597882wrd.8;
        Mon, 04 Apr 2022 01:04:19 -0700 (PDT)
X-Gm-Message-State: AOAM530YXNFGrNMOFA4dEuOzsAItLv9RtMPpd0ZyYrtM20Nm0TBAhBQG
        QKSIZpGc1gStJjMZKeUSGwrRj718FSGAchsgeFE=
X-Google-Smtp-Source: ABdhPJwqJxfqlqagcViI+smBcTQCtvDqO5imtzJeW3lPtlQWh/wDdnZ51ocnA4CpI0iS26royJspuxNotXJbtEBu7nc=
X-Received: by 2002:a5d:6505:0:b0:205:9a98:e184 with SMTP id
 x5-20020a5d6505000000b002059a98e184mr15354390wru.317.1649059458839; Mon, 04
 Apr 2022 01:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org> <Ykqh3mEy5uY8spe8@infradead.org>
In-Reply-To: <Ykqh3mEy5uY8spe8@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Apr 2022 10:04:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a07ZdqA0UBC_qkqzMsZWLUK=Rti3AkFe2VVEWLivuZAqA@mail.gmail.com>
Message-ID: <CAK8P3a07ZdqA0UBC_qkqzMsZWLUK=Rti3AkFe2VVEWLivuZAqA@mail.gmail.com>
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xrx78JDc2cIU2KMmuE4laAS0LK4GO0thkkuMWLoJs5LqHA9pfnd
 h4+CwdxRSHUOACc6EbQsSgNU2DoX7sjIgBgciCKjHUZFmkwUOpd+VIz4slIpgol4VDfo4D2
 MqePrLb1dAB/miskZxkpwc3gElTsvndJ7c9oSc1EZEU5azD97bRRTx5dJwAXYJd9XGSn4Uy
 5eppBOqMT7vX1Hk2u9mTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nIaGZmEwUbM=:cs2DasC4bE/H4q277mj8DL
 STC90UmrPCoOucsGcE33kkNS/YzehPiv78UB2fC60YOKCwD1zBLx4uWkXUC+rwHpAxJJegYyD
 o0A4V5K2Lc8o5L0iR442QOx/fVBdKWltRgYrKtcB8osc0lwCyNmFcZ422ySG+MDiLe4kJqhLc
 xj4tFZOYqvQm41dwSasU/pOpPBjD/PkxhNtmhu2h1LQaqNTMDZ3PoDO5PdoMoXV7KKc6atbzj
 trEIPuLHkcIXSIIZG6j/TSJyqIaXcj/VYy3VCDkAlsgbjpW9mhvcGuIBepJLqcGWfWdQVZ5wY
 Vn53+c8ypzUHe9th7HX0tXinRk1iWzMecYyEdfzIEOX8AJZZwtKgn9KhRWpMc3cXk50ROPDtH
 am3Ga1YXKGQ0AjZ+n0T2W5MhLAB40zIX1MzFLEQZPANeN3fCOmy0fszN6ZYMoZzx9fazbh1ur
 08PHANRTI7BFOIduSBElr8khbOMhapkqjL3/8Lxm839rIYHFxvhrFNBpsv1QK7C2GwB3L7GqL
 jBooPHHBmA7GF+v7lfydO4LqbHjXdGPUPoPWC1/K0MfsKSkN/XD8n+mDwRJyOYNHfkHzuhsgb
 iIZSxaIuoUFLsWaNeA65GqzWEyRl+iQ92L2FfDJCVA+wSyF2gTFseAHv0V/niTe6sj1KBOeH7
 pmXp/5h8EW7Qe9T7lKHYp2G3aXauNCdn878VfpGqt+hMA9+xgLlh5Eqbvjf77QdbCLgnU35V3
 hCZPQV2PM9Rs0YjhcvPEKzxv9/KLRU+UrUNaMyRpquEYVRTbk90Wb7vY+v2M3sao5Yq1t/+7D
 nSv/iMMWgarTzRiEyq4AetPakj/QdQClItmxgUwtcQdUlfIhnM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 4, 2022 at 9:44 AM Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Apr 04, 2022 at 03:19:48PM +0900, Masahiro Yamada wrote:
> >       vr->num = num;
> >       vr->desc = p;
> >       vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
> > -     vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> > +     vr->used = (void *)(((__kernel_uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> >               + align-1) & ~(align - 1));
>
> This really does not look like it should be in a uapi header to start
> with.

The header is shared between kernel and other projects using virtio, such as
qemu and any boot loaders booting from virtio devices. It's not technically a
/kernel/ ABI, but it is an ABI and for practical reasons the kernel version is
maintained as the master copy if I understand it correctly.

       Arnd
