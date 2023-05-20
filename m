Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B7770A4E9
	for <lists+linux-arch@lfdr.de>; Sat, 20 May 2023 05:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjETD3j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 23:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjETD3i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 23:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23A718D
        for <linux-arch@vger.kernel.org>; Fri, 19 May 2023 20:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684553331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9tGnYz1bwiUJEY8iexdjytwpnYdRmD1r1uzK1JlxYiY=;
        b=aoAZGRswH8o26TqSxehpI4P/o+5YomH7KG/aGQjrWaT+knXp07vciceYlibHDL4CEiWY21
        xGGJxieve6qlOw2plNevbCbqaH4a0bYiBCZwh8PBzkMQzyQZTUTpeqZDZ07TocgUo7YCjO
        nInxewOhNv+EAg9SeDNKpysxK8T2AtM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-tegY8KViPSqd9FFeRdOa-Q-1; Fri, 19 May 2023 23:28:49 -0400
X-MC-Unique: tegY8KViPSqd9FFeRdOa-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8524800141;
        Sat, 20 May 2023 03:28:48 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBE33C54184;
        Sat, 20 May 2023 03:28:47 +0000 (UTC)
Date:   Sat, 20 May 2023 11:28:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        willy@infradead.org, deller@gmx.de
Subject: Re: [PATCH v5 RESEND 14/17] mm/ioremap: Consider IOREMAP space in
 generic ioremap
Message-ID: <ZGg+bHE4g4/s6mGI@MiWiFi-R3L-srv>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-15-bhe@redhat.com>
 <ZGR3Ft27kdgXKKfp@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGR3Ft27kdgXKKfp@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/16/23 at 11:41pm, Christoph Hellwig wrote:
> On Mon, May 15, 2023 at 05:08:45PM +0800, Baoquan He wrote:
> > @@ -35,8 +35,13 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
> >  	if (!ioremap_allowed(phys_addr, size, pgprot_val(prot)))
> >  		return NULL;
> >  
> > +#ifdef IOREMAP_START
> > +	area = __get_vm_area_caller(size, VM_IOREMAP, IOREMAP_START,
> > +				    IOREMAP_END, __builtin_return_address(0));
> > +#else
> >  	area = get_vm_area_caller(size, VM_IOREMAP,
> >  			__builtin_return_address(0));
> > +#endif
> 
> I think this would be cleaner if we'd just always use
> __get_vm_area_caller and at the top of the file add a:
> 
> #ifndef IOREMAP_START
> #define IOREMAP_START	VMALLOC_START
> #define IOREMAP_END	VMALLOC_END
> #endif
> 
> Together with a little comment that ioremap often, but not always
> uses the generic vmalloc area.

Great idea, will do as suggested.

