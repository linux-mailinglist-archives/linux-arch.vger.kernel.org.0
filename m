Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDD174A1A4
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jul 2023 17:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjGFP4Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 11:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjGFP4Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 11:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D76E19A7
        for <linux-arch@vger.kernel.org>; Thu,  6 Jul 2023 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688658938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ui06ZFcdz1qWSBPR+h//NKg4GSrZKXagBPNy6hALhkE=;
        b=JkdmxKEB19rrZaUtLDGv1tAoHGeTjZffhJ+I+m5UJLtPJ89w+tL3E4wKo+GS8mA0Ps12zM
        dKgKnH7vhZ8ZQvDaioT97LIcfSmWBTFo2gQKvEHy6xzyHZ1MviHv8/iFW81qALddqX0oTY
        31U4iEIWOI0W/hpACcjFpaSm+87pZGM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-umXMLVFUPOSZJu0jyKXHNA-1; Thu, 06 Jul 2023 11:55:35 -0400
X-MC-Unique: umXMLVFUPOSZJu0jyKXHNA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0DBE185A791;
        Thu,  6 Jul 2023 15:55:33 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3345492C13;
        Thu,  6 Jul 2023 15:55:32 +0000 (UTC)
Date:   Thu, 6 Jul 2023 23:55:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v7 10/19] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZKbj8Tr15cQtjEy5@MiWiFi-R3L-srv>
References: <20230620131356.25440-11-bhe@redhat.com>
 <202306211329.ticOJCSv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306211329.ticOJCSv-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 06/21/23 at 01:43pm, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230620-212135
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230620131356.25440-11-bhe%40redhat.com
> patch subject: [PATCH v7 10/19] s390: mm: Convert to GENERIC_IOREMAP
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230621/202306211329.ticOJCSv-lkp@intel.com/config)

I can confirm these reproted errors have nothing to do with my patch. I
got a s390 system and build the latest kernel from linus's master branch
with above config, all these failures have been existing there. I have
made patches to fix them by adding dependency on HAS_IOMEM for drivers.

I would suggest lkp adjusts script to test the base firstly so that a
reliable base is provided to avoid confusion.

Thanks
Baoquan

