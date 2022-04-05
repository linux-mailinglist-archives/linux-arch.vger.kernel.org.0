Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3601C4F2321
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 08:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiDEGcC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 02:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiDEGbx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 02:31:53 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C16652E40;
        Mon,  4 Apr 2022 23:29:54 -0700 (PDT)
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MyK5K-1nwLS02Y5k-00yixP; Tue, 05 Apr 2022 08:29:52 +0200
Received: by mail-wm1-f50.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so885267wmb.4;
        Mon, 04 Apr 2022 23:29:52 -0700 (PDT)
X-Gm-Message-State: AOAM533c1kU5UG6Dgl6fglDxiVSp1JJjXvxLcczK4SI/xToN5JmuqTQh
        83Pa6gYmQXpqI1hFhegKEkNUrvjiH402fcfij5s=
X-Google-Smtp-Source: ABdhPJwsEWf6Kh9ZmIXYYN/M9onvtdd1lx+p5bH1oV2EAH9/3o2ZPWJZ3zKpIpvz66ZNFBOP57JnZalCuJjU3V4Z5Fo=
X-Received: by 2002:a05:600c:4e11:b0:38c:bd19:e72c with SMTP id
 b17-20020a05600c4e1100b0038cbd19e72cmr1618846wmq.174.1649140192243; Mon, 04
 Apr 2022 23:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org> <Ykqh3mEy5uY8spe8@infradead.org>
 <CAK8P3a07ZdqA0UBC_qkqzMsZWLUK=Rti3AkFe2VVEWLivuZAqA@mail.gmail.com> <YkvVOLj/Rv4yPf5K@infradead.org>
In-Reply-To: <YkvVOLj/Rv4yPf5K@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Apr 2022 08:29:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
Message-ID: <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization list <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:97ZUr0yfSVQstYUK4F5LrqXuvIwLfKa2qugu5/vkLljAk+jZE3Z
 h9QkhZuVeQyXBlfEi4q9m8OVXmLRYqaxQCFw5HHBlvfab6AWEGHjT0HM63Gnqz7WXk4LkJF
 MSGz5EvcUPfbD6RtI9I6stN00PRHvGRhHsQ84odKVMpXiC10UwHc//DgYEbqYJ/AWG1yJAq
 I+e8n0XFZzdVmRhw7BA4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uoldei0PfR8=:J0+2DU1VyzsYAC1pEJIh0C
 ExQcvuPLetSen3D/9Uptd41/9OP0paBB/B48ZUfbQqnuV5cvZ9UckFInzwl0FMFxo0G6arrs4
 jvC/9zngMkzG6zQeTirlGZx4SwqnYfm2aJAfzjUU+U76MxcH92vXhLlXTepzRO0u9D2ZdmMkO
 ivPEv10nwwkbmlOM0BLc/27vdiQ2ild8IVz5CaNUcaIe2HH7uDbqjpJR82wlC3YziHG2n/i7n
 UzXDiqi7xTTw6Dw4rlkNRitScDienSUDbtoQ7iZhmpKEVSfI7l41C+USDdpydU32IjPXevcyJ
 jLZHBAEbvnmEg86aUt8u6JHyK9CLsITT2SbJc00AEAGbdxWep/Kqc/D2Bl8bwtrZU3y2YlN8z
 ARrCs3YF8brwxZqNEX2caVzMmGPLUsoqm9Ms7CP3UYUdzOkQxjLC8AiW6hGijg1ttPER3aP6C
 nZt055ehRAo+cZP+jZbsjY2HkkOI/UGaEkkAGAM29NuboAng/tIrzSkZKK9enagRBJjDdvTlS
 NwbJzpvxA5OupNjhy6OX6u2wySUTnHvaAF2dZPHLyY7vyZT31qtaprBjXEzglUuLufCyqnsS1
 q8z5EHN942LPNo9FNODjXbuM8a6QZzdyShu8TvaXTojaQONpJ8Rw92Bn+ziI5EZ0DjOUG8AgW
 fnvgIlLUYfIzrkpaAT4bCP/D47tdFxNaJbwjHWPoeeV3F0ILP4NC7vChVqK/NpUFbAco=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 5, 2022 at 7:35 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Apr 04, 2022 at 10:04:02AM +0200, Arnd Bergmann wrote:
> > The header is shared between kernel and other projects using virtio, such as
> > qemu and any boot loaders booting from virtio devices. It's not technically a
> > /kernel/ ABI, but it is an ABI and for practical reasons the kernel version is
> > maintained as the master copy if I understand it correctly.
>
> Besides that fact that as you correctly states these are not a UAPI at
> all, qemu and bootloades are not specific to Linux and can't require a
> specific kernel version.  So the same thing we do for file system
> formats or network protocols applies here:  just copy the damn header.
> And as stated above any reasonably portable userspace needs to have a
> copy anyway.

I think the users all have their own copies, at least the ones I could
find on codesearch.debian.org. However, there are 27 virtio_*.h
files in include/uapi/linux that probably should stay together for
the purpose of defining the virtio protocol, and some others might
be uapi relevant.

I see that at least include/uapi/linux/vhost.h has ioctl() definitions
in it, and includes the virtio_ring.h header indirectly.

Adding the virtio maintainers to Cc to see if they can provide
more background on this.

> If it is just as a "master copy" it can live in drivers/virtio/, just
> like we do for other formats.

It has to be in include/linux/ at least because it's used by a number
of drivers outside of drivers/virtio/.

        Arnd
