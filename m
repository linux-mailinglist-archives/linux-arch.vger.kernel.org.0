Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA15C60048E
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 02:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJQAiS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Oct 2022 20:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJQAht (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Oct 2022 20:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA3734707
        for <linux-arch@vger.kernel.org>; Sun, 16 Oct 2022 17:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665967067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrPx+xR3T4mzJ2SXos5UT8R6YqjTT59drwhZY5KZJGw=;
        b=Y+j2nvdho5+1Ws8s2SqvyuQaA04cMi0tQX4rVdA+Bz0a9Ahb8POPHjOk+7wNPS4mjI9QzS
        MWLbMw6LVCB0D3nHWa7iP+zTtCDL2Moa++eT84nn1Woud7t0Wps5k4L+mtscy8gNrQdSY2
        98tu5HX4Kzu9BkoDyv53QCsL8TrVZxs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-5RkVEvMLNkyI49PujRu1vA-1; Sun, 16 Oct 2022 20:37:43 -0400
X-MC-Unique: 5RkVEvMLNkyI49PujRu1vA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08AC73C0F225;
        Mon, 17 Oct 2022 00:37:43 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B29856D21A;
        Mon, 17 Oct 2022 00:37:40 +0000 (UTC)
Date:   Mon, 17 Oct 2022 08:37:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, akpm@linux-foundation.org,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com
Subject: Re: [RFC PATCH 0/8] mm: ioremap: Convert architectures to take
 GENERIC_IOREMAP way (Alternative)
Message-ID: <Y0yj0IDBVOFwCFuv@MiWiFi-R3L-srv>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1665568707.git.christophe.leroy@csgroup.eu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christophe,

On 10/12/22 at 12:09pm, Christophe Leroy wrote:
> From: 
> 
> As proposed in the discussion related to your series, here comes an
> exemple of how it could be.
> 
> I have taken it into ARC and IA64 architectures as an exemple. This is
> untested, even not compiled, it is just to illustrated my meaning in the
> discussion.
> 
> I also added a patch for powerpc architecture, that one in tested with
> both pmac32_defconfig and ppc64_le_defconfig.
> 
> From my point of view, this different approach provide less churn and
> less intellectual disturbance than the way you do it.

Yes, I agree, and admire your insistence on the thing you think right or
better. Learn from you.

When you suggested this in my v2 post, I made a draft patch at below link
according to your suggestion to request people to review. What worried
me is that I am not sure it's ignored or disliked after one week of
waiting.

https://lore.kernel.org/all/YwtND%2FL8xD+ViN3r@MiWiFi-R3L-srv/#related

Up to now, seems people don't oppose this generic_ioremap_prot() way, we
can take it. So what's your plan? You want me to continue with your
patches wrapped in, or I can leave it to you if you want to take over?

Thanks
Baoquan

> 
> Baoquan He (5):
>   hexagon: mm: Convert to GENERIC_IOREMAP
>   openrisc: mm: remove unneeded early ioremap code
>   mm: ioremap: allow ARCH to have its own ioremap definition
>   arc: mm: Convert to GENERIC_IOREMAP
>   ia64: mm: Convert to GENERIC_IOREMAP
> 
> Christophe Leroy (3):
>   mm/ioremap: Define generic_ioremap_prot() and generic_iounmap()
>   mm/ioremap: Consider IOREMAP space in generic ioremap
>   powerpc: mm: Convert to GENERIC_IOREMAP
> 
>  arch/arc/Kconfig              |  1 +
>  arch/arc/include/asm/io.h     |  7 +++---
>  arch/arc/mm/ioremap.c         | 46 +++--------------------------------
>  arch/hexagon/Kconfig          |  1 +
>  arch/hexagon/include/asm/io.h |  9 +++++--
>  arch/hexagon/mm/ioremap.c     | 44 ---------------------------------
>  arch/ia64/Kconfig             |  1 +
>  arch/ia64/include/asm/io.h    | 11 ++++++---
>  arch/ia64/mm/ioremap.c        | 45 ++++++----------------------------
>  arch/openrisc/mm/ioremap.c    | 22 ++++-------------
>  arch/powerpc/Kconfig          |  1 +
>  arch/powerpc/include/asm/io.h | 11 ++++++---
>  arch/powerpc/mm/ioremap.c     | 26 +-------------------
>  arch/powerpc/mm/ioremap_32.c  | 25 ++++++++-----------
>  arch/powerpc/mm/ioremap_64.c  | 22 +++++++----------
>  include/asm-generic/io.h      |  7 ++++++
>  mm/ioremap.c                  | 33 +++++++++++++++++++------
>  17 files changed, 98 insertions(+), 214 deletions(-)
>  delete mode 100644 arch/hexagon/mm/ioremap.c
> 
> -- 
> 2.37.1
> 

