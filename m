Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CC86C4100
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 04:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCVD1J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 23:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCVD1G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 23:27:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC343B3F1;
        Tue, 21 Mar 2023 20:27:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PhDRV5fXtz4x80;
        Wed, 22 Mar 2023 14:27:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1679455624;
        bh=pmal6vExytNJugrqg+hjjl7XZZ2H1M1tEdmhwzVXT2o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=F+i3XHr2FDlzGLuAHkXzitYG5YCJ06nTmNdeyhX5zR2a/UlYqNmlVTEirSZ9X+XFy
         +aoJ9TK0mmBIeKlzjDGRkbz3BAXyATVQnfHwWSqqXT9BFcJsdDFgOdgbYts6T8wqBF
         yqqncxLRrpxYjlrXOINfhqtq2sI6DR2IbxseBmErj419zlr0q/OsA9y730BTxgZK91
         OpfeGna5Of4k15L3GWmZXzw30/gI/k0rRRO0bQrah4AcxiDvsb4iP3J6ls3yY26Jna
         kfLBY7dJUZ313gyEELkR8wIN8+aJLleyIm3L2ho1fWg1bbQUzQhCQY4Qog+q8nYmMq
         /mZiNHFlX7INQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
In-Reply-To: <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
Date:   Wed, 22 Mar 2023 14:26:59 +1100
Message-ID: <871qlhv530.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:
> MAX_ORDER currently defined as number of orders page allocator supports:
> user can ask buddy allocator for page order between 0 and MAX_ORDER-1.
>
> This definition is counter-intuitive and lead to number of bugs all over
> the kernel.
>
> Change the definition of MAX_ORDER to be inclusive: the range of orders
> user can ask from buddy allocator is 0..MAX_ORDER now.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
...
>  arch/powerpc/Kconfig                          | 27 ++++++-------
>  arch/powerpc/configs/85xx/ge_imp3a_defconfig  |  2 +-
>  arch/powerpc/configs/fsl-emb-nonhw.config     |  2 +-
>  arch/powerpc/mm/book3s64/iommu_api.c          |  2 +-
>  arch/powerpc/mm/hugetlbpage.c                 |  2 +-
>  arch/powerpc/platforms/powernv/pci-ioda.c     |  2 +-

Reviewed-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
