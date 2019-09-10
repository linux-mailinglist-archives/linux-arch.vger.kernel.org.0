Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 966B0AECB5
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2019 16:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbfIJOOd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Sep 2019 10:14:33 -0400
Received: from ozlabs.org ([203.11.71.1]:39241 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387967AbfIJOOd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Sep 2019 10:14:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46SRqT1WHWz9s4Y;
        Wed, 11 Sep 2019 00:14:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1568124870;
        bh=Z28bLkGfDaS+JxlS5GFHDxMenzpB0cTLOOpN4+6VFVA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FUvOlT3PN6zmxCXxduF0n4OzydT25dHG9THLXee70RJmueBgsijIzPRx8lu/aeoaI
         XTU0fvPLs5A3Zo+0sO/ACkaanvLARHFcdspvVJiT6s7yOkY60VNhoG4BxVig/zuNRh
         iubQyAgr4Cu/SR6hnTgMdFPjw6l3wdTnFXGwox5uX9w3yrMXjJMRZqxExncPRz5INj
         xweIsTTU4+dr5OnU3LUazACzNJxOG8efYCCVId9R+dIN+L+KVqxtqJRuWlXivpAnWO
         XogsRCvVft1OLy77dOvoRDICCry+KyRDOrlW/yGN+4NLcwqabd6zYnM5O/3/H4Odvo
         /Vgxs/42K33Jw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Qian Cai <cai@lca.pw>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mingo@kernel.org,
        peterz@infradead.org, bvanassche@acm.org, arnd@arndb.de,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3] powerpc/lockdep: fix a false positive warning
In-Reply-To: <1568039433-10176-1-git-send-email-cai@lca.pw>
References: <1568039433-10176-1-git-send-email-cai@lca.pw>
Date:   Wed, 11 Sep 2019 00:14:34 +1000
Message-ID: <87pnk8z19x.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Qian,

Sorry I haven't replied sooner, I've been travelling.

Qian Cai <cai@lca.pw> writes:
> The commit 108c14858b9e ("locking/lockdep: Add support for dynamic
> keys") introduced a boot warning on powerpc below, because since the
> commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
> kvm_tmp[] into the .bss section and then free the rest of unused spaces
> back to the page allocator.

Thanks for debugging this, but I'd like to fix it differently.

kvm_tmp has caused trouble before, with kmemleak, and it can also cause
trouble with STRICT_KERNEL_RWX, so I'd like to change how it's done,
rather than doing more hacks for it.

It should just be a page in text that we use if needed, and don't free,
which should avoid all these problems.

I'll try and get that done and posted soon.

cheers
