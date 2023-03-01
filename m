Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBD46A6D21
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 14:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCANiN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 08:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCANiM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 08:38:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6659D3C796
        for <linux-arch@vger.kernel.org>; Wed,  1 Mar 2023 05:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677677847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWUfeTIK2JG/z0HaQdTVjbSobFn6johmFqmk8NE5TPA=;
        b=ikKnurAkHecdxlp+3ii8NVJsLt8oiAuAYBDbuSflkUlk6YNpGl9JWg/mo4wcv/XcuUQ7mp
        OI9303kYrChtJ501O79nqUllaCDHv0aWe/4BfHO5LjlzSkrrijFBGqWrcofSKLnFRqckR7
        rGZHHhxkMPp3DGF9mvIGJhNSjtLmVcE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-BaLlk-2uPTKbvDKFCJXn9g-1; Wed, 01 Mar 2023 08:37:21 -0500
X-MC-Unique: BaLlk-2uPTKbvDKFCJXn9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3D923C0E442;
        Wed,  1 Mar 2023 13:37:20 +0000 (UTC)
Received: from localhost (ovpn-13-180.pek2.redhat.com [10.72.13.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 679C51121315;
        Wed,  1 Mar 2023 13:37:19 +0000 (UTC)
Date:   Wed, 1 Mar 2023 21:37:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        geert@linux-m68k.org, hch@infradead.org, mcgrof@kernel.org
Subject: Re: [PATCH v2 0/2] arch/*/io.h: remove ioremap_uc in some
 architectures
Message-ID: <Y/9VDFrWsqimW+Ce@MiWiFi-R3L-srv>
References: <20230301102208.148490-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301102208.148490-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/01/23 at 06:22pm, Baoquan He wrote:
> This patchset tries to remove ioremap_uc() in the current architectures
> except of x86 and ia64. They will use the default ioremap_uc definition
> in <asm-generic/io.h> which returns NULL.
> 
> If any arch sees a breakage caused by the default ioremap_uc(), it can
> provide a sepcific one for its own usage.

Forgot mentioning this patchset is based on below patchset.

[PATCH v5 00/17] mm: ioremap:  Convert architectures to take GENERIC_IOREMAP way
https://lore.kernel.org/all/20230301034247.136007-1-bhe@redhat.com/T/#u

> 
> v1->v2:
>   - Update log of patch 2, and document related to ioremap_uc()
>     according to Geert's comment.
>   - Add Geert's Acked-by.
> 
> Baoquan He (2):
>   mips: add <asm-generic/io.h> including
>   arch/*/io.h: remove ioremap_uc in some architectures
> 
>  Documentation/driver-api/device-io.rst | 11 ++++--
>  arch/alpha/include/asm/io.h            |  1 -
>  arch/hexagon/include/asm/io.h          |  3 --
>  arch/m68k/include/asm/kmap.h           |  1 -
>  arch/mips/include/asm/io.h             | 47 +++++++++++++++++++++++++-
>  arch/mips/include/asm/mmiowb.h         |  2 --
>  arch/parisc/include/asm/io.h           |  2 --
>  arch/powerpc/include/asm/io.h          |  1 -
>  arch/sh/include/asm/io.h               |  2 --
>  arch/sparc/include/asm/io_64.h         |  1 -
>  10 files changed, 55 insertions(+), 16 deletions(-)
> 
> -- 
> 2.34.1
> 

