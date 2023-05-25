Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ADD711A61
	for <lists+linux-arch@lfdr.de>; Fri, 26 May 2023 00:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjEYW70 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 18:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjEYW7Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 18:59:25 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAB910F;
        Thu, 25 May 2023 15:59:20 -0700 (PDT)
Received: from meshulam (unknown [185.176.138.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 7DC8E14BB92;
        Fri, 26 May 2023 00:59:16 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1685055556; bh=kog4dbXqqG9kBj5lHS7A5wxZKGwA1hEOps5hdfkNd4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=voT0v/B4F4JCfSsevmi6sqEuIDTsZ9KB77LA6dNgKfvOZhHuIDxAEh4n2LC4Uc7k4
         VVo8BcsMS9B9BNRHjrenOpJhF9TBR2ZIcxRFOa1nvlHHRxo78PV4dhwXs5B7UAVGUm
         pAVAcE0ORVA6ze+B6vZaKlAXxD0epe8rA2KbPC0sPz0QzyZj+5HqUGzGHuereD+RsG
         PSx+LZFy7rW+0h0BKVh3BJTJViIUBS20Ei7GgN3yBG00V4KqhDAk0RLhUvp+doe3l7
         Zoo1fZjVbwNa/vt3qdeBQxLpo+e4eOll1OWad+iKvnwCt1Ax6q5HU3wpOdd05BP/hl
         R8A6qlWxHd/IA==
Date:   Fri, 26 May 2023 00:59:15 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
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
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 05/11] percpu: Wire up cmpxchg128
Message-ID: <20230526005915.01a35500@meshulam>
In-Reply-To: <20230525124955.GS83892@hirez.programming.kicks-ass.net>
References: <20230515075659.118447996@infradead.org>
        <20230515080554.248739380@infradead.org>
        <20230525124955.GS83892@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 25 May 2023 14:49:55 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

>[...]
> Build tested i386-defconfig.
> 
> (the things we do for museum pieces :/)

I have always thought it's not done for museum pieces but rather for
dumb emulators. I can vaguely recall a reverse-engineered MIPS firmware
which was able to run i386 binaries, but not i586...

Petr T
