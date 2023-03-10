Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FF66B33C6
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 02:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjCJBq1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 20:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCJBqZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 20:46:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAF1F4D8F
        for <linux-arch@vger.kernel.org>; Thu,  9 Mar 2023 17:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678412737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RtJkfRI7AXY3SogCgOFRi4FhIfSeTbcT8pIq6VJrULQ=;
        b=XQs0wVhezjUDRgOwE5RpHxXoRUL8CT5G6JzAQXzngU16YVsWkMF9xc8sLFkYDyqNAzWrd0
        I4hUqrFLKaJS8naIzK3HP7WlwrCCBg8o9Thka/EK+wz5yGb9ZNmim0uTqZZySq9jpnxXyo
        ZtkqJHwEUuc+BujuPpYbbPInHeokYDE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-woUwnrrKNFetIWSKVrCPTA-1; Thu, 09 Mar 2023 20:45:34 -0500
X-MC-Unique: woUwnrrKNFetIWSKVrCPTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7D531C0518D;
        Fri, 10 Mar 2023 01:45:33 +0000 (UTC)
Received: from localhost (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDB654010E36;
        Fri, 10 Mar 2023 01:45:32 +0000 (UTC)
Date:   Fri, 10 Mar 2023 09:45:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, mpe@ellerman.id.au,
        geert@linux-m68k.org, mcgrof@kernel.org, hch@infradead.org,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v4 3/4] arch/*/io.h: remove ioremap_uc in some
 architectures
Message-ID: <ZAqLuNrPng9i0rZV@MiWiFi-R3L-srv>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-4-bhe@redhat.com>
 <20230309143621.GA12350@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309143621.GA12350@alpha.franken.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/09/23 at 03:36pm, Thomas Bogendoerfer wrote:
> On Wed, Mar 08, 2023 at 09:07:09PM +0800, Baoquan He wrote:
> > ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> > extension, and on ia64 with its slightly unconventional ioremap()
> > behavior. So remove the ioremap_uc() definition in architecutures
> > other than x86 and ia64. These architectures all have asm-generic/io.h
> > included and will have the default ioremap_uc() definition which
> > returns NULL.
> > 
> > This changes the existing behaviour, while no need to worry about
> > any breakage because in the only callsite of ioremap_uc(), code
> > has been adjusted to eliminate the impact. Please see
> > atyfb_setup_generic() of drivers/video/fbdev/aty/atyfb_base.c.
> > 
> > If any new invocation of ioremap_uc() need be added, please consider
> > using ioremap() intead or adding a ARCH specific version if necessary.
> > 
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: linux-alpha@vger.kernel.org
> > Cc: linux-hexagon@vger.kernel.org
> > Cc: linux-m68k@lists.linux-m68k.org
> > Cc: linux-mips@vger.kernel.org
> > Cc: linux-parisc@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-sh@vger.kernel.org
> > Cc: sparclinux@vger.kernel.org
> > ---
> >  Documentation/driver-api/device-io.rst | 9 +++++----
> >  arch/alpha/include/asm/io.h            | 1 -
> >  arch/hexagon/include/asm/io.h          | 3 ---
> >  arch/m68k/include/asm/kmap.h           | 1 -
> >  arch/mips/include/asm/io.h             | 1 -
> >  arch/parisc/include/asm/io.h           | 2 --
> >  arch/powerpc/include/asm/io.h          | 1 -
> >  arch/sh/include/asm/io.h               | 2 --
> >  arch/sparc/include/asm/io_64.h         | 1 -
> >  9 files changed, 5 insertions(+), 16 deletions(-)
> 
> this doesn't apply to v6.3-rc1... what tree is this based on ?

Sorry, I forgot mentioning this in cover letter. This series is
followup of below patchset, so it's on top of below patchset and based
on v6.3-rc1.

https://lore.kernel.org/all/20230301034247.136007-1-bhe@redhat.com/T/#u
[PATCH v5 00/17] mm: ioremap:  Convert architectures to take GENERIC_IOREMAP way

Thanks
Baoquan

