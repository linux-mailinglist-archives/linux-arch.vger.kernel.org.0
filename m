Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1CD70A4EE
	for <lists+linux-arch@lfdr.de>; Sat, 20 May 2023 05:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjETDcB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 23:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjETDcA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 23:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F75FA
        for <linux-arch@vger.kernel.org>; Fri, 19 May 2023 20:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684553472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xVZv6T/wRHC8aZPmUbolnwWkjCu5MdbG+ni9RcvouEs=;
        b=YSodhMvcPhHWXxM9bXf6yNmsjDRFT/YLi/TF5jem7An+5IkY6a5mw7Xk/1Kiq6hfeLVfs7
        CzctmxNEF5u/CgX/Rh4tZx/4+Q9ubfrHpwHCzNYgYQOvQgKwxTi6Myx96cAJn5vm2U470Z
        +SLB4L5kKNxtO8HdAEtduK0dhgSw/W0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-vOufUwP5MSmvd1hYjrJ7nQ-1; Fri, 19 May 2023 23:31:10 -0400
X-MC-Unique: vOufUwP5MSmvd1hYjrJ7nQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1520F8007D9;
        Sat, 20 May 2023 03:31:10 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F537492B0A;
        Sat, 20 May 2023 03:31:08 +0000 (UTC)
Date:   Sat, 20 May 2023 11:31:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        willy@infradead.org, deller@gmx.de
Subject: Re: [PATCH v5 RESEND 14/17] mm/ioremap: Consider IOREMAP space in
 generic ioremap
Message-ID: <ZGg++JKsQh/tOZHI@MiWiFi-R3L-srv>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-15-bhe@redhat.com>
 <ZGR3Ft27kdgXKKfp@infradead.org>
 <ZGR3yWIdjfJTupgY@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGR3yWIdjfJTupgY@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/16/23 at 11:44pm, Christoph Hellwig wrote:
> On Tue, May 16, 2023 at 11:41:26PM -0700, Christoph Hellwig wrote:
> > I think this would be cleaner if we'd just always use
> > __get_vm_area_caller and at the top of the file add a:
> > 
> > #ifndef IOREMAP_START
> > #define IOREMAP_START	VMALLOC_START
> > #define IOREMAP_END	VMALLOC_END
> > #endif
> > 
> > Together with a little comment that ioremap often, but not always
> > uses the generic vmalloc area.
> 
> .. and with that we can also simply is_ioremap_addr by moving it
> to ioremap.c and making it always operate on the IOREMAP constants.

Great idea too, will do. Put this into a separate patch?

