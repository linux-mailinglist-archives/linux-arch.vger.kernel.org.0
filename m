Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28180707883
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 05:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjERDjZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 23:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjERDjX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 23:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C1330E8
        for <linux-arch@vger.kernel.org>; Wed, 17 May 2023 20:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684381118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RMQr1Z/SNdz396grr248udQlctmR65Q9JOFTWlK+K04=;
        b=gIKKmJ9yEwiZryIgqn0DVBO6sRag5PoQYaxPg3ClKreAblRcJr/a22PrNqhKCvGMqkQMHV
        7i4Y8tjlOE+hfhIZNjSgwf1sqJxeAcv4n4cKylUAfhWl4tQB7wp8ZcXwBm//+BBTD9FHKj
        NoDe9uLjV9p0N3tdxQlANltRRiINyjw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-WDmYr80jMCKJl0ULvIoExg-1; Wed, 17 May 2023 23:38:34 -0400
X-MC-Unique: WDmYr80jMCKJl0ULvIoExg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D0623C01E0B;
        Thu, 18 May 2023 03:38:34 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30F6040C6EC4;
        Thu, 18 May 2023 03:38:31 +0000 (UTC)
Date:   Thu, 18 May 2023 11:38:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        willy@infradead.org, deller@gmx.de
Subject: Re: [PATCH v5 RESEND 04/17] mm/ioremap: Define
 generic_ioremap_prot() and generic_iounmap()
Message-ID: <ZGWdtGdbBtRyxTor@MiWiFi-R3L-srv>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-5-bhe@redhat.com>
 <ZGR0YP/ky8IXf0oF@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGR0YP/ky8IXf0oF@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/16/23 at 11:29pm, Christoph Hellwig wrote:
> On Mon, May 15, 2023 at 05:08:35PM +0800, Baoquan He wrote:
> > From: Christophe Leroy <christophe.leroy@csgroup.eu>
> > 
> > Define a generic version of ioremap_prot() and iounmap() that
> > architectures can call after they have performed the necessary
> > alteration to parameters and/or necessary verifications.
> > 
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/asm-generic/io.h |  4 ++++
> >  mm/ioremap.c             | 22 ++++++++++++++++------
> >  2 files changed, 20 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index 587e7e9b9a37..a7ca2099ba19 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -1073,9 +1073,13 @@ static inline bool iounmap_allowed(void *addr)
> >  }
> >  #endif
> >  
> > +void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
> > +				   pgprot_t prot);
> > +
> 
> Formatting looks a bit weird here.  The normal styles are either to
> indent with two tabs (my preference) or after the opening brace.

Thanks a lot for careful reviewing on this series.

I check this place again, strange it looks good in code with identing
after the opening brace, while in patch it looks messy. Will try again
to see if I can fix it in patch too.

