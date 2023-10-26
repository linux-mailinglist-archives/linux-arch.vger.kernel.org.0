Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31997D8C20
	for <lists+linux-arch@lfdr.de>; Fri, 27 Oct 2023 01:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJZXTP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Oct 2023 19:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjJZXTO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Oct 2023 19:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51998D4B
        for <linux-arch@vger.kernel.org>; Thu, 26 Oct 2023 16:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698362305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0k7pol6Ox9Lg+5J8guMydD0qxLzYw54p+yc1TXTXwYg=;
        b=SOmr3SGpXkQx5IzkfKZDKp7z0H8wKFyM4Lo+7RRwGi2x+vk2a/Y/5t7dqqwREjpBkArTnR
        I/W2cG+B6y9T5Xo3PyADOv4+/2U45o3Nf9oQhF2DCjv4kTBZS7/bMqPMwUoAMWLZtQt1un
        NJiX9bw+WbtXXL20Kbh9RQiltiqwBNY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-PWo8HKZGOeOYXY8-GQq6lw-1; Thu, 26 Oct 2023 19:18:20 -0400
X-MC-Unique: PWo8HKZGOeOYXY8-GQq6lw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A35C784AEE2;
        Thu, 26 Oct 2023 23:18:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 692E92026D4C;
        Thu, 26 Oct 2023 23:18:18 +0000 (UTC)
Date:   Fri, 27 Oct 2023 07:18:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mpe@ellerman.id.au,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>, deller@gmx.de
Subject: Re: [PATCH v5 0/4] arch/*/io.h: remove ioremap_uc in some
 architectures
Message-ID: <ZTrztxpJu31EKrls@MiWiFi-R3L-srv>
References: <20230921110424.215592-1-bhe@redhat.com>
 <a7e3fdcd-d5e6-4261-85be-3ec1221edf24@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7e3fdcd-d5e6-4261-85be-3ec1221edf24@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/26/23 at 01:36pm, Jiaxun Yang wrote:
> 
> 
> 在2023年9月21日九月 下午12:04，Baoquan He写道：
> > This patchset tries to remove ioremap_uc() in the current architectures
> > except of x86 and ia64. They will use the default ioremap_uc version
> > in <asm-generic/io.h> which returns NULL. Anyone who wants to add new
> > invocation of ioremap_uc(), please consider using ioremap() instead or
> > adding a new ARCH specific ioremap_uc(), or refer to the callsite
> > in drivers/video/fbdev/aty/atyfb_base.c.
> >
> > This change won't cuase breakage to the current kernel because in the
> > only ioremap_uc callsite, an adjustment is made to eliminate impact in
> > patch 1 of this series.
> >
> > To get rid of all of them other than x86 and ia64, add asm-generic/io.h
> > to asm/io.h of mips ARCH. With this adding, we can get rid of the
> > ioremap_uc() in mips too. This is done in patch 2. And a followup patch
> > 4 is added to remove duplicated code according to Arnd's suggestion.
> >
> > Test:
> > =====
> > Except of Jiaxun's efficient testing on patch 2/4, I also did cross compiling
> > of this series on mips64, building passed.
> >
> 
> For whole series:
> 
> Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks for testing, Jiaxun.

> 
> Hi Arnd and Thomas,
> 
> I've got some work pending based on this series, however I'm unclear about
> which tree this series will go since both of you give acked-by.
> 
> Given that there are some tree-wide modifications, I guess it should go into
> Arnd's asm-generic tree?

Previously Andrew merged my below patchset. This patchset is solving the
left issue during reviewing below patchset and discussing. Maybe Andrew
can help pick this patches?

[PATCH v8 00/19] mm: ioremap: Convert architectures to take GENERIC_IOREMAP way
https://lore.kernel.org/all/20230706154520.11257-1-bhe@redhat.com/T/#u

Thanks
Baoquan

