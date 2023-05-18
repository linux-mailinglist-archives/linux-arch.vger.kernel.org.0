Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C76C70788B
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 05:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjERDoe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 23:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjERDod (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 23:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE7530F8
        for <linux-arch@vger.kernel.org>; Wed, 17 May 2023 20:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684381429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0pWi321j2dJQo9PWbhq50nZ1UrZDSkUZuy7jm8koH04=;
        b=ilGKSTO5oUtUSkv/Mo3+neAtEQiwKAtG5Uc1JC+gkDuFDK7/lT/dUV1Bc/RhEXWbrhVosa
        KGgdQPW6Ylx1x4pS3pvqZCfu5qD9mwTBqWSDiYeDyvCLJTMLJGzsNK7OeEYUUv3VXaE4iC
        qGjfmDnbWfa3IduJ/dEfw6mVzfm4X8o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-Oce8fByhNdGoyCfh1R4fzQ-1; Wed, 17 May 2023 23:43:43 -0400
X-MC-Unique: Oce8fByhNdGoyCfh1R4fzQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD38D296A602;
        Thu, 18 May 2023 03:43:42 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12FA9492B00;
        Thu, 18 May 2023 03:43:41 +0000 (UTC)
Date:   Thu, 18 May 2023 11:43:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        willy@infradead.org, deller@gmx.de,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH v5 RESEND 07/17] arc: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGWe6VAHewU0TsOn@MiWiFi-R3L-srv>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-8-bhe@redhat.com>
 <ZGR01vnozJmVIVEi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGR01vnozJmVIVEi@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/16/23 at 11:31pm, Christoph Hellwig wrote:
> > +#define ioremap ioremap
> > +#define ioremap_prot ioremap_prot
> > +#define iounmap iounmap
> 
> Nit:  I think it's cleaner to have these #defines right next to the
> function declaration.

Makes sense, will do.

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

