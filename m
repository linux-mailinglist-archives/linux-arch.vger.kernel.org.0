Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13115219CEA
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 12:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgGIKDL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 06:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgGIKDL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 06:03:11 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816AC061A0B;
        Thu,  9 Jul 2020 03:03:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B2WvZ3zGxz9sTH;
        Thu,  9 Jul 2020 20:03:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1594288986;
        bh=gzevlDZNhGR3zBt4oGJSiaOWmNIXxDnq4AJkVnA7ct8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FGveEg8q/y3tCFCeSW1FsRbhFSvX8FhcucbFCIXftYTCKPONKTv/40QFtquvhS7Yo
         PzXwGYKN7bovdbCuMD9lgGZakoYc2SOVrOpgitHHV+kYC3njs0+MPZ+BhyTGB9o+6t
         jNfCMr6brEGBnannqnY2pUkSB5UZp/XUOHF3PqH++pCffJ9+JixW+/tHMqnaHPCA2p
         x9T56tPe0+HFuPp06W4+IOZ9S0ZRYFuezORe9sSIH+715fqj7tkhTxHACSUtShzB/r
         +zGySTRD9bXU5UDoL0fTvXIBwPFr8LToCxfYHvUOi/Uuzt7xvwIge32QyPjtpPZpyI
         pdmw83qWCiusQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 1/6] powerpc/powernv: must include hvcall.h to get PAPR defines
In-Reply-To: <20200706043540.1563616-2-npiggin@gmail.com>
References: <20200706043540.1563616-1-npiggin@gmail.com> <20200706043540.1563616-2-npiggin@gmail.com>
Date:   Thu, 09 Jul 2020 20:05:18 +1000
Message-ID: <87fta1vw9t.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> An include goes away in future patches which breaks compilation
> without this.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> index f923359d8afc..8eba6ece7808 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> @@ -15,6 +15,7 @@
>  
>  #include <asm/iommu.h>
>  #include <asm/tce.h>
> +#include <asm/hvcall.h> /* share error returns with PAPR */
>  #include "pci.h"
>  
>  unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb)
> -- 
> 2.23.0

This isn't needed anymore AFAICS, since:

5f202c1a1d42 ("powerpc/powernv/ioda: Return correct error if TCE level allocation failed")

cheers
