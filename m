Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCAB715A16
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjE3J1s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 05:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjE3J1X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 05:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6A1172C
        for <linux-arch@vger.kernel.org>; Tue, 30 May 2023 02:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685438712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5OSazfFhKBuzJDvth1f7Dqd7hERmV/6oE9F1R8Geijg=;
        b=Heo1uoOXbiQxzjoReuQP34/B1kgv0lkpehFFoi9hBsPc31ML4QQccConfzoj9CDKT580rU
        4Yu5KeHuBwdj2aPwAlHuzWfoYWV71mA7uQEjQzDagwOJw6oyaF7eqvh8RREeLFXBq+xUw9
        yYFnkiW5VL0adt4ja6KvB5bTI6prdHQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-S-hb1pRvMniLEpkD_s7AUg-1; Tue, 30 May 2023 05:25:07 -0400
X-MC-Unique: S-hb1pRvMniLEpkD_s7AUg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 372DF811E86;
        Tue, 30 May 2023 09:25:06 +0000 (UTC)
Received: from localhost (ovpn-12-192.pek2.redhat.com [10.72.12.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47035492B0A;
        Tue, 30 May 2023 09:25:04 +0000 (UTC)
Date:   Tue, 30 May 2023 17:25:01 +0800
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
Message-ID: <ZHXA7RP9bv4Cz4VA@MiWiFi-R3L-srv>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-8-bhe@redhat.com>
 <ZGR01vnozJmVIVEi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGR01vnozJmVIVEi@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph,

On 05/16/23 at 11:31pm, Christoph Hellwig wrote:
> > +#define ioremap ioremap
> > +#define ioremap_prot ioremap_prot
> > +#define iounmap iounmap
> 
> Nit:  I think it's cleaner to have these #defines right next to the
> function declaration.

For this one, I didn't add function declaration of ioremap_prot and
iounmap in arch/arc/include/asm/io.h and the same to other arch's
asm/io.h. Because asm-generic/io.h already has those function
declaration, then ARCH's asm/io.h includeasm-generic/io.h. I tried
adding function declarations for ioremap_prot() and iounmap(), building
passed too. Do you think we need add extra function declarations in
ARCH's asm/io.h file?

Thanks
Baoquan

