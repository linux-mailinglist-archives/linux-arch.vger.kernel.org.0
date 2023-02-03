Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A690688E14
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 04:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjBCDi6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 22:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBCDi5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 22:38:57 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8E1EF94;
        Thu,  2 Feb 2023 19:38:54 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pNmt8-0070dc-T8; Fri, 03 Feb 2023 11:37:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Feb 2023 11:37:22 +0800
Date:   Fri, 3 Feb 2023 11:37:22 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        davem@davemloft.net, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, Andrew Morton <akpm@linux-foundation.org>,
        vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 02/10] types: Introduce [us]128
Message-ID: <Y9yBcu6ThKC7tVdt@gondor.apana.org.au>
References: <20230202145030.223740842@infradead.org>
 <20230202152655.313053173@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202152655.313053173@infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 02, 2023 at 03:50:32PM +0100, Peter Zijlstra wrote:
> Introduce [us]128 (when available). Unlike [us]64, ensure they are
> always naturally aligned.
> 
> This also enables 128bit wide atomics (which require natural
> alignment) such as cmpxchg128().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/types.h      |    5 +++++
>  include/uapi/linux/types.h |    4 ++++
>  2 files changed, 9 insertions(+)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
