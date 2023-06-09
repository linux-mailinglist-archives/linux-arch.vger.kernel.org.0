Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC99729347
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 10:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbjFIIfn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 04:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241229AbjFIIfR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 04:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79160E50
        for <linux-arch@vger.kernel.org>; Fri,  9 Jun 2023 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686299668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EknIZyUh7PQqINbfxxOFxOQjWFkQnRhHPN2hFuriDog=;
        b=AllZJe4g7iBO6lBq/CQJGONZzsvcb8SDNADMiHctMm41E/w11P8Q2dNNgxWFLCqf2dooaW
        k9DKknPpwLsApB12flR+pEiO0qj0wYicnS6dWItjhgzJi8Ima8X9rwD6FF39yXstoJDfKH
        fZjVHOnU3KKeSkc6LWbW3LtTeka+KEQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-KaJfyS03M-WHx2lyCun43w-1; Fri, 09 Jun 2023 04:34:22 -0400
X-MC-Unique: KaJfyS03M-WHx2lyCun43w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAC91384CC69;
        Fri,  9 Jun 2023 08:34:21 +0000 (UTC)
Received: from localhost (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48F8C515540;
        Fri,  9 Jun 2023 08:34:18 +0000 (UTC)
Date:   Fri, 9 Jun 2023 16:34:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@lst.de, rppt@kernel.org, willy@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        deller@gmx.de, Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v6 11/19] sh: add <asm-generic/io.h> including
Message-ID: <ZILkBqUu4msCAb+g@MiWiFi-R3L-srv>
References: <20230609075528.9390-1-bhe@redhat.com>
 <20230609075528.9390-12-bhe@redhat.com>
 <025fe4853ff0a258dafdf71075419a2b740cabbd.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <025fe4853ff0a258dafdf71075419a2b740cabbd.camel@physik.fu-berlin.de>
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

On 06/09/23 at 10:10am, John Paul Adrian Glaubitz wrote:
> Hello Baoquan!
> 
> On Fri, 2023-06-09 at 15:55 +0800, Baoquan He wrote:
> > Also add macro definitions for port|mm io functions since SuperH
> > has its own implementation in arch/sh/kernel/iomap.c and
> > arch/sh/include/asm/io_noioport.h. These will conflict with the port|mm io
> > function definitions in include/asm-generic/io.h to cause compiling
> > errors like below:
> 
> What change does the "Also" refer to?

It refers to these kind of macro definitions, this place and those in
other several places. Please correct me if I misused the expression to
cause confusion.

+#define ioread8 ioread8
+#define ioread16 ioread16
+#define ioread16be ioread16be
+#define ioread32 ioread32
+#define ioread32be ioread32be
+
+#define iowrite8 iowrite8
+#define iowrite16 iowrite16
+#define iowrite16be iowrite16be
+#define iowrite32 iowrite32
+#define iowrite32be iowrite32be
+
+#define ioread8_rep ioread8_rep
+#define ioread16_rep ioread16_rep
+#define ioread32_rep ioread32_rep
+
+#define iowrite8_rep iowrite8_rep
+#define iowrite16_rep iowrite16_rep
+#define iowrite32_rep iowrite32_rep

