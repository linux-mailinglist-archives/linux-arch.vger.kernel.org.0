Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DC770788E
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 05:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjERDpd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 23:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjERDpc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 23:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED19430F5
        for <linux-arch@vger.kernel.org>; Wed, 17 May 2023 20:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684381485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mk8aG1TtznZuxqSznasGxarw6oe6FuitdljoVkFwpdQ=;
        b=FrQ8+VK4GZxWgbDIYUJfKN1QAbZ3PDUT8O6HxnpugCTGXGieRKoBB/DEGUHzAqeuDQDFJj
        OQ0/SIGB+rs/7/seK+JwG+gChmZ3SEm3SvQ4cvpS9gQPUPOn7/43c9eGJkgT5+V4jrIMwn
        P4D4QjluuZAbPBOMlNhKI6Mf6iaIpTk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187--pcPYFQaOZeXkiw7BBvOeg-1; Wed, 17 May 2023 23:44:41 -0400
X-MC-Unique: -pcPYFQaOZeXkiw7BBvOeg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E3B9185A78B;
        Thu, 18 May 2023 03:44:41 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50773492B00;
        Thu, 18 May 2023 03:44:39 +0000 (UTC)
Date:   Thu, 18 May 2023 11:44:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        willy@infradead.org, deller@gmx.de, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 08/17] ia64: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGWfIIi2aH8SMTfZ@MiWiFi-R3L-srv>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-9-bhe@redhat.com>
 <ZGR1IlBpIDe6fQms@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGR1IlBpIDe6fQms@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/16/23 at 11:33pm, Christoph Hellwig wrote:
> > +#define ioremap_prot ioremap_prot
> > +#define ioremap_cache ioremap
> >  #define ioremap_uc ioremap_uc
> >  #define iounmap iounmap
> 
> Same comment about the placement here, I'm not going to repeat it if
> it shows up in more patches.

Sure, Will check all of them and change, thanks.

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

