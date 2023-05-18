Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73840707893
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 05:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjERDqx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 23:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjERDqw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 23:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3426930EE
        for <linux-arch@vger.kernel.org>; Wed, 17 May 2023 20:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684381569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rb5WmlFpGhegcLzMxPINZKl6stSgxTh3qbMWfHpqSrc=;
        b=DI89+NvpknWcqTB6jtci0DTwahoU2aWisFTCTqh6ThY9lxDJLUb5jqEy3ohzIrlmCnJIfx
        kU0q+78gNikMD3bXlpA81ZwG6/RM5oQE4jDharjy761U5goH3NvTgbWz0VHSAtquaY0qfl
        jqqSetJYvgT3sy9ga4eULJ2Akya9ME8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-1CtSCAzqMoCBrsca4AJsrw-1; Wed, 17 May 2023 23:46:05 -0400
X-MC-Unique: 1CtSCAzqMoCBrsca4AJsrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1F5A296A603;
        Thu, 18 May 2023 03:46:04 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D6D24078908;
        Thu, 18 May 2023 03:46:01 +0000 (UTC)
Date:   Thu, 18 May 2023 11:45:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        willy@infradead.org, deller@gmx.de,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 11/17] sh: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGWfczugaXHvdpJ3@MiWiFi-R3L-srv>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-12-bhe@redhat.com>
 <ZGR2Ql7zmwor/qR7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGR2Ql7zmwor/qR7@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/16/23 at 11:37pm, Christoph Hellwig wrote:
> On Mon, May 15, 2023 at 05:08:42PM +0800, Baoquan He wrote:
> > Meanwhile, add macro definitions for port|mm io functions since SuperH
> > has its own implementation in arch/sh/kernel/iomap.c and
> > arch/sh/include/asm/io_noioport.h. These will conflict with the port|mm io
> > function definitions in include/asm-generic/io.h to cause compiling
> > errors like below:
> 
> Please split that inclusion of include/asm-generic/io.h and redefining
> of the helpers into a separate prep patch.

Will do.

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

