Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B383E4F4194
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 23:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbiDENZG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 09:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381332AbiDEMy3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 08:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50DC229C98
        for <linux-arch@vger.kernel.org>; Tue,  5 Apr 2022 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649159848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yZyeehLgo43vPEC1Sp1n3r3jpBNtdCjtLwgkplLP3v4=;
        b=Gh1urVgDOeB9+9TxPEQeRkhcqCncaFa8w1U9aVXPwWd9+BzvwtLgauDuT5npxZ7ZsYGpEy
        +2cLGfjg87/sbCwjZPmJfPObdYuRuPoNUmNfjDY/szAPb3aPdw9c1mV+t+FVj9LCzmEPm1
        ma0vA+nyG5qidYPD19KL428n3aY96z4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-Hg3ljTzZPE-UfYCTwOnANw-1; Tue, 05 Apr 2022 07:57:27 -0400
X-MC-Unique: Hg3ljTzZPE-UfYCTwOnANw-1
Received: by mail-wr1-f70.google.com with SMTP id z16-20020adff1d0000000b001ef7dc78b23so2405215wro.12
        for <linux-arch@vger.kernel.org>; Tue, 05 Apr 2022 04:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZyeehLgo43vPEC1Sp1n3r3jpBNtdCjtLwgkplLP3v4=;
        b=Osh0YBa5dYqzrwTztL0R5LR9YCes79ZPf0lrcAgQxkbRvgcvJgJHa+zJPHa82UKf6i
         hk/3OjVabEDZHjY7T5JEPELEj6OfCGNVuptGrtBIGcOwXCxACIjp5i6s9RHIltVKtk9I
         P87lJlNaUMIZMl5/EVYDXlyljZXMaePVaZizo+0uDSDPKsVMkloGGwfro+8M5Y/Nv+Rr
         yjNrsdw6LVmdq8C1Jrqeh4jtkLwMYPY+FA9YtI6kOLhbZpKDSRaM+Vu1NxGnhnLEx/X9
         GCeAOI6+uqyp8Yg0PbtHsJjIrST0u2G3O1hIJ3Nqsi/7jGGvKl6XRUG3zOEQPvbVw97f
         KkVw==
X-Gm-Message-State: AOAM530U7s8h6tE724z+sK/vnd/8NyHOXdoUDF5QhjsgwYEUYkJom1l4
        DPmUOLpRvyNOl2HXI+aU406+yws1UZaoxcRpo0S/7eMZOGspzAQhSFFX5ykHxdr5l7zyKxZwn2G
        sicFkNrORAn0gu5sWkdHc7g==
X-Received: by 2002:a05:6000:184a:b0:203:f8f0:3407 with SMTP id c10-20020a056000184a00b00203f8f03407mr2604220wri.190.1649159846181;
        Tue, 05 Apr 2022 04:57:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypIKxQBes9FfmGLsTQSI+o8ZS7lLWmQJBmsfPcPeNLWB/aoHg6W8W0oB4kBqUTKA7V4gN8eQ==
X-Received: by 2002:a05:6000:184a:b0:203:f8f0:3407 with SMTP id c10-20020a056000184a00b00203f8f03407mr2604202wri.190.1649159845981;
        Tue, 05 Apr 2022 04:57:25 -0700 (PDT)
Received: from redhat.com ([2.52.17.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a7bcb84000000b00389efb7a5b4sm1883255wmi.17.2022.04.05.04.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 04:57:25 -0700 (PDT)
Date:   Tue, 5 Apr 2022 07:57:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization list <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
Message-ID: <20220405075627-mutt-send-email-mst@kernel.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org>
 <Ykqh3mEy5uY8spe8@infradead.org>
 <CAK8P3a07ZdqA0UBC_qkqzMsZWLUK=Rti3AkFe2VVEWLivuZAqA@mail.gmail.com>
 <YkvVOLj/Rv4yPf5K@infradead.org>
 <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 05, 2022 at 08:29:36AM +0200, Arnd Bergmann wrote:
> On Tue, Apr 5, 2022 at 7:35 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Apr 04, 2022 at 10:04:02AM +0200, Arnd Bergmann wrote:
> > > The header is shared between kernel and other projects using virtio, such as
> > > qemu and any boot loaders booting from virtio devices. It's not technically a
> > > /kernel/ ABI, but it is an ABI and for practical reasons the kernel version is
> > > maintained as the master copy if I understand it correctly.
> >
> > Besides that fact that as you correctly states these are not a UAPI at
> > all, qemu and bootloades are not specific to Linux and can't require a
> > specific kernel version.  So the same thing we do for file system
> > formats or network protocols applies here:  just copy the damn header.
> > And as stated above any reasonably portable userspace needs to have a
> > copy anyway.
> 
> I think the users all have their own copies, at least the ones I could
> find on codesearch.debian.org.

kvmtool does not seem to have its own copy, just grep vring_init.

> However, there are 27 virtio_*.h
> files in include/uapi/linux that probably should stay together for
> the purpose of defining the virtio protocol, and some others might
> be uapi relevant.
> 
> I see that at least include/uapi/linux/vhost.h has ioctl() definitions
> in it, and includes the virtio_ring.h header indirectly.
> 
> Adding the virtio maintainers to Cc to see if they can provide
> more background on this.
> 
> > If it is just as a "master copy" it can live in drivers/virtio/, just
> > like we do for other formats.
> 
> It has to be in include/linux/ at least because it's used by a number
> of drivers outside of drivers/virtio/.
> 
>         Arnd
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 

