Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481CD482E66
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 07:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiACGLn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 01:11:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbiACGLm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 01:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641190302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eZWdqglEJRBMyWOswue91QGGug+foo23E07h4yycLxk=;
        b=HRL5YnHa1yulGnOA1JzB549mXs0VZGS41FPJu/odPYeDh13i5tKe7lVZVXRCSXAAEcpO16
        OGQAyDzIk3KHK71nS6xhHEVIlvfzZ/l0ceAi/wgS/MSiCWNBCE7qYMkvpmdtEbdxZI8GFR
        mCvbtmJ9JoC0rEXOU7GhWHzAeFLBWO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-jznnFRq4Ox2x6SNXuNadWw-1; Mon, 03 Jan 2022 01:11:36 -0500
X-MC-Unique: jznnFRq4Ox2x6SNXuNadWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB1321006AA9;
        Mon,  3 Jan 2022 06:11:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76F497B9DB;
        Mon,  3 Jan 2022 06:11:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C52A6180039F; Mon,  3 Jan 2022 07:11:27 +0100 (CET)
Date:   Mon, 3 Jan 2022 07:11:27 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC 26/32] drm: handle HAS_IOPORT dependencies
Message-ID: <20220103061127.jrnsfuxbxk2ywmtg@sirius.home.kraxel.org>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-27-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164317.4146918-27-schnelle@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 27, 2021 at 05:43:11PM +0100, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them. There is also a direct and hard coded use in
> cirrus.c which according to the comment is only necessary during resume.
> Let's just skip this as for example s390 which doesn't have I/O port
> support also doesen't support suspend/resume.

>  config DRM_BOCHS
>  	tristate "DRM Support for bochs dispi vga interface (qemu stdvga)"
>  	depends on DRM && PCI && MMU
> +	depends on HAS_IOPORT
>  	select DRM_KMS_HELPER
>  	select DRM_VRAM_HELPER
>  	select DRM_TTM

On devices with an mmio bar the driver works just fine without inb/outb,
see bochs->mmio checks in bochs.c

take care,
  Gerd

