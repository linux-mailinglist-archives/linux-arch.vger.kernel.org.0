Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F2E651A61
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 06:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiLTFpx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 00:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiLTFpj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 00:45:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCBE95BC;
        Mon, 19 Dec 2022 21:45:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 691BF6125E;
        Tue, 20 Dec 2022 05:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817CEC433D2;
        Tue, 20 Dec 2022 05:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671515136;
        bh=QcK/x+eqx8iacc7s1AbUsKNKBvDGfjfcoe194ABwpQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8xxaZB9wVAaw8858zsn8j1mrqTrJVesFUAdVe1W83ufJ9sHcvCYkV2q2anEmukUN
         m1NdhGXzBH6dnyOgVPP1qWonQ5KDZOv4oGgd66a1HDiUHo8tyaR6C3rklA4HaPex8T
         6El86mTLGFyzwTBHvO1T6TKqSr1Gluavng5x1qicELSXHhUHzLp5Yt6NrtuNXWla+z
         OwhmF2NtdbiZ6g7uwEgtX/hs9JZptcnA9ToGBHbwN5w+6ddS8cho+unrKLXqMcqQHL
         /99nwU6CNZMNgTkrx9zgJkD/Ng5bgFcZ4+HjTqlpCIoQQLeK2jct+t2dfB0xpzdzD4
         51h2h+3/WkC/g==
Date:   Mon, 19 Dec 2022 21:45:33 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 02/12] crypto/ghash-clmulni: Use (struct) be128
Message-ID: <Y6FL/WRO1cleCI2w@sol.localdomain>
References: <20221219153525.632521981@infradead.org>
 <20221219154118.955831880@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219154118.955831880@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022 at 04:35:27PM +0100, Peter Zijlstra wrote:
> Even though x86 is firmly little endian, use be128 because le128 is in
> fact the wrong way around :/ The actual code is already using be128 in
> ghash_setkey() so this shouldn't be more confusing.
> 
> This frees up the u128 name for a real u128 type.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This patch doesn't make sense.  The x86 ghash code is definitely storing the key
as a little endian value, not big endian.  The reason be128 shows up in
ghash_setkey() is because the code is doing a byteswap from the original key
bytes.  Also, this patch causes 'sparse' warnings.

Can you consider
https://lore.kernel.org/linux-crypto/20221220054042.188537-1-ebiggers@kernel.org/T/#u
instead?

- Eric
