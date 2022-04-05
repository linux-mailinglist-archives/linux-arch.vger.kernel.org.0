Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316F84F4009
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 23:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbiDENYk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 09:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381311AbiDEMy3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 08:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 475512980C
        for <linux-arch@vger.kernel.org>; Tue,  5 Apr 2022 04:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649159732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=28KE+M63X+ahVj/a4F3r0KzFPc/lbb3JFcGix4GxqtQ=;
        b=DiVTQm8Btd4fHtf2BSf737oifikdT0EHP/OqaTZ+3FMv3zUlkflchk5XJS3X9caETEwZ5C
        uphgJ7yBjeYpNRoBw6q52YwzzLbDJ+Lz1F2dds+HmN5vH9HMcaa8CYSfAOY9cH2G4bJ3vd
        +ZnUjVORK/9pQuFUUXCwJXAJucNg/GY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107--Sp-JSmsMi6LdNDnH4YV6A-1; Tue, 05 Apr 2022 07:55:29 -0400
X-MC-Unique: -Sp-JSmsMi6LdNDnH4YV6A-1
Received: by mail-wm1-f71.google.com with SMTP id v62-20020a1cac41000000b0038cfe6edf3fso1223683wme.5
        for <linux-arch@vger.kernel.org>; Tue, 05 Apr 2022 04:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=28KE+M63X+ahVj/a4F3r0KzFPc/lbb3JFcGix4GxqtQ=;
        b=E0wEpUvcMNssQgmpZJPcmuPzlM3nI1R0Tvvplr/qgZmEvLycGsf7s40gFyR2kcAc7i
         PAbiZkMyJ3AXPCOi9uXYXZk45ZyM4kDpZB3nulCiwh0AQkJX/8+R4TEm+anEeXENmkCd
         yeZ/NmQOoNCzKUiy+ROJ5/tW6QtjmfgZ4vSbXi6uQdvkN+FqgsaV7CD1CYjlMnhbxLnL
         TXGjU6ac0FdHKGisLK7fMgDO+JOXp4G9/wRUKjiHf4hnFGd5aCVd/BOlas2IDXkwk6vt
         p6RaaKmz+ApMd1QI/3xw9Ca2WU36am1JeYTHrmS7qsEqpWpPR93IyAcRL/ShG1yVewMd
         8kNA==
X-Gm-Message-State: AOAM5329kPA06ucr7yvy3EsQq6jcc4qlsp5nxghdz42NHM+XOoq94kPY
        ZBri2cjzFutbiRBnhmKVC2VneKCic/OVJU/DT1FG4uR9WDu1IqXBbJWfNuqR+wU2nWT98PtCRE3
        vkGckK9AwERNujgPXD7ChLQ==
X-Received: by 2002:a5d:50d2:0:b0:206:b6f:f7db with SMTP id f18-20020a5d50d2000000b002060b6ff7dbmr2452905wrt.248.1649159728269;
        Tue, 05 Apr 2022 04:55:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1Tka5E6L9URIsWeBley60SCe/IUE6j/uwyJ5KZatVAUY55Lp2TF7WwIu2UssrhlRPLr4P1Q==
X-Received: by 2002:a5d:50d2:0:b0:206:b6f:f7db with SMTP id f18-20020a5d50d2000000b002060b6ff7dbmr2452885wrt.248.1649159727975;
        Tue, 05 Apr 2022 04:55:27 -0700 (PDT)
Received: from redhat.com ([2.52.17.211])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c4fd100b0038cd5074c83sm2159309wmq.34.2022.04.05.04.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 04:55:27 -0700 (PDT)
Date:   Tue, 5 Apr 2022 07:55:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        virtualization list <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
Message-ID: <20220405074223-mutt-send-email-mst@kernel.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org>
 <Ykqh3mEy5uY8spe8@infradead.org>
 <CAK8P3a07ZdqA0UBC_qkqzMsZWLUK=Rti3AkFe2VVEWLivuZAqA@mail.gmail.com>
 <YkvVOLj/Rv4yPf5K@infradead.org>
 <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
 <YkvpT3PFcbgcMCWy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkvpT3PFcbgcMCWy@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 05, 2022 at 12:01:35AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 08:29:36AM +0200, Arnd Bergmann wrote:
> > I think the users all have their own copies, at least the ones I could
> > find on codesearch.debian.org. However, there are 27 virtio_*.h
> > files in include/uapi/linux that probably should stay together for
> > the purpose of defining the virtio protocol, and some others might
> > be uapi relevant.
> > 
> > I see that at least include/uapi/linux/vhost.h has ioctl() definitions
> > in it, and includes the virtio_ring.h header indirectly.
> 
> Uhh.  We had a somilar mess (but at a smaller scale) in nvme, where
> the uapi nvme.h contained both the UAPI and the protocol definition.
> We took a hard break to only have a nvme_ioctl.h in the uapi header
> and linux/nvme.h for the protocol.  This did break a bit of userspace
> compilation (but not running obviously) at the time, but really made
> the headers much easier to main.  Some userspace keeps on copying
> nvme.h with the protocol definitions.

So far we are quite happy with the status quo, I don't see any issues
maintaining the headers. And yes, through vhost and vringh they are part
of UAPI.

Yes users have their own copies but they synch with the kernel.

That's generally. Specifically the vring_init thing is a legacy thingy
used by kvmtool and maybe others, and it inits the ring in the way that
vring/virtio expect.  Has been there since day 1 and we are careful not
to add more stuff like that, so I don't see a lot of gain from incurring
this pain for users.

-- 
MST

