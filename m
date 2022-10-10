Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3058A5F966E
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 03:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiJJBFS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Oct 2022 21:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJJBFC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Oct 2022 21:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC0B12AD5
        for <linux-arch@vger.kernel.org>; Sun,  9 Oct 2022 17:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665363252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Wlgr5678H60NOl4njbwYLitT+ttN6vPLcrFmUMxdHw=;
        b=dcwT/zvVOyIZre1SSQMwviUDtCiyfcxH9e6Bho83DX6Qnhot2TZF9RAElmrGnRSOh3Mdtr
        N7ikXfPvQcA9txZvOGuZAqoCpSRjvcx+x+SrUNQr3BcsVXGnYGoqys74BFyhIhg+8xBPin
        RglFExcbkwEUJ5z63wO3leAXjIWyGhA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-yxRvlpj5P7axHHUHhconUQ-1; Sun, 09 Oct 2022 20:25:28 -0400
X-MC-Unique: yxRvlpj5P7axHHUHhconUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B071B29AB406;
        Mon, 10 Oct 2022 00:25:27 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70EE5145D825;
        Mon, 10 Oct 2022 00:25:26 +0000 (UTC)
Date:   Mon, 10 Oct 2022 08:25:22 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, christophe.leroy@csgroup.eu,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 03/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Message-ID: <Y0NmcspddDQICfTi@MiWiFi-R3L-srv>
References: <20221009103114.149036-1-bhe@redhat.com>
 <20221009103114.149036-4-bhe@redhat.com>
 <10ada8f0-0931-b6a6-e240-fc8b500e578d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ada8f0-0931-b6a6-e240-fc8b500e578d@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/09/22 at 07:13pm, Kefeng Wang wrote:
> 
> On 2022/10/9 18:31, Baoquan He wrote:
> > Currently, hooks ioremap_allowed() and iounmap_allowed() are used to
> > check if it's qualified to do ioremap, and now this is done on ARM64.
> > However, in oder to convert more architectures to take GENERIC_IOREMAP
> > method, several more things need be done in those two hooks:
> >   1) The io address mapping need be handled specifically on architectures,
> >      e.g arc, ia64, s390;
> >   2) The original physical address passed into ioremap_prot() need be
> >      fixed up, e.g arc;
> >   3) The 'prot' passed into ioremap_prot() need be adjusted, e.g on arc
> >      and xtensa.
> > 
> > To handle these three issues,
> > 
> >   1) Rename ioremap_allowed() and iounmap_allowed() to arch_ioremap()
> >      and arch_iounmap() since the old name can't reflect their
> >      functionality after change;
> >   2) Change the return value of arch_ioremap() so that arch can add
> >      specifical io address mapping handling inside and return the maped
> >      address. Now their returned value means:
> >      ===
> >      arch_ioremap() return a bool,
> pointer?

Right, I forgot fixing it again. Thanks.

> >        - IS_ERR means return an error
> >        - 0 means continue to remap
> >        - a non-zero, non-IS_ERR pointer is returned directly
> >      arch_iounmap() return a bool,
> >        - true means continue to vunmap
> >        - false means skip vunmap and return directly
> ...
> >   /*
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index a68f8fbf423b..2ae16906f3be 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -1049,25 +1049,26 @@ static inline void iounmap(volatile void __iomem *addr)
> >   /*
> >    * Arch code can implement the following two hooks when using GENERIC_IOREMAP
> > - * ioremap_allowed() return a bool,
> > - *   - true means continue to remap
> > - *   - false means skip remap and return directly
> > - * iounmap_allowed() return a bool,
> > + * arch_ioremap() return a bool,
> ditto...

Will change.

> >   	area = get_vm_area_caller(size, VM_IOREMAP,
> >   			__builtin_return_address(0));
> >   	if (!area)
> > @@ -52,7 +57,7 @@ void iounmap(volatile void __iomem *addr)
> >   {
> >   	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
> > -	if (!iounmap_allowed(vaddr))
> > +	if (!arch_iounmap((void __iomem *)addr))
> vaddr?

No, it's intentional. Alexander suggested this, both of you discussed
this in v1, see below thread.

https://lore.kernel.org/all/Yu4mYxpV0GWRTjQp@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com/T/#u

> >   		return;
> >   	if (is_vmalloc_addr(vaddr))
> 

