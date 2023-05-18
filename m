Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E56707889
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 05:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjERDn7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 23:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjERDn6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 23:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2645D30E8
        for <linux-arch@vger.kernel.org>; Wed, 17 May 2023 20:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684381393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I3ysGB9JuC72T1aDtCFkPNC5a/f2mcf/75CpRKANTR0=;
        b=SJnEZyVMW0mW1gheivAUnYnXo7o3A6qoOiNtUGOT8W37eydTgRxhDZq3lfbI36obmDg7VC
        pc/jlHn8UL3nTMXsmelBsTzRHrclJIcGqCyw/6n9EMZCqJG7XroIl26hdCLa/9AG/0EDLA
        DuU1dG45hNXnKFgWOYBCjmSc61PjD+U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-rQ2DqjWxP1SY7-nQyd_h8w-1; Wed, 17 May 2023 23:43:07 -0400
X-MC-Unique: rQ2DqjWxP1SY7-nQyd_h8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 727DC88CC40;
        Thu, 18 May 2023 03:43:06 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0F1C2166B31;
        Thu, 18 May 2023 03:43:05 +0000 (UTC)
Date:   Thu, 18 May 2023 11:43:02 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        willy@infradead.org, deller@gmx.de
Subject: Re: [PATCH v5 RESEND 06/17] mm/ioremap: add slab availability
 checking in ioremap_prot
Message-ID: <ZGWext9KmmH+Dbtu@MiWiFi-R3L-srv>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-7-bhe@redhat.com>
 <ZGR0mLozn5OQzAEN@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGR0mLozn5OQzAEN@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/16/23 at 11:30pm, Christoph Hellwig wrote:
> On Mon, May 15, 2023 at 05:08:37PM +0800, Baoquan He wrote:
> > Several architectures has done checking if slab if available in
> > ioremap_prot(). In fact it should be done in generic ioremap_prot()
> > since on any architecutre, slab allocator must be available before
> > get_vm_area_caller() and vunmap() are used.
> > 
> > Add the checking into generic_ioremap_prot().
> 
> Should we add a WARN_ON/WARN_ON_ONCE to aid debugging?

Sounds like a great idea, will add WARN_ON_ONCE as below. Thanks.

	if (WARN_ON_ONCE(!slab_is_available()))
		return NULL;

