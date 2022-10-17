Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7A4600F81
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 14:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiJQMuk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 08:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiJQMuj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 08:50:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C8A11C1A;
        Mon, 17 Oct 2022 05:50:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MrcKL1ps7z4xGj;
        Mon, 17 Oct 2022 23:50:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1666011017;
        bh=25OG/pBetWurP10Vpt2CJUhfNhc9C8lMineW3GxgWGE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DF+emvhag+G40a3GGl4MSqkBeGO9J3EPKUhF/IstEdgLtz0MFMyklFNGgI1rp03u0
         UDEw4mdi0taHxRRCxNFoQ07nlHHWBuxSI1NMhjyJYVnqj1BSaGioPsn1K8LAlzXjLu
         JIMlo3o0d5z8ZzJLau2uqFWhUhfo+d3TQ8m7QjuEhDDQGNw6QIP+bKmf4/+OANJ5L0
         dyz6L7DGKxDdzOTza5bRwbyGPC9yKERQMoP/WCw0ak6frx19U2WGqigRI9dSbanano
         oKYD15JCrU2PdddDsqAkGqCsxz1SLBckX+2ZW2AHsyr7OpGYkMhZ0iTwPE0L1grJFK
         9xoG3BJ2TvNDg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Baoquan He <bhe@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David Laight <David.Laight@aculab.com>,
        Stafford Horne <shorne@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 7/8] mm/ioremap: Consider IOREMAP space in generic
 ioremap
In-Reply-To: <af8ba7b8-5198-42a1-84c7-9b7d7892ceb3@app.fastmail.com>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
 <8c7ac4667c6a3cc48f98110117536f60d51ece4a.1665568707.git.christophe.leroy@csgroup.eu>
 <d0acd053-96d3-4e18-a9de-97987d8be14b@app.fastmail.com>
 <Y0u4tN+mIgNSWwdi@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <af8ba7b8-5198-42a1-84c7-9b7d7892ceb3@app.fastmail.com>
Date:   Mon, 17 Oct 2022 23:50:12 +1100
Message-ID: <87sfjmlim3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:
> On Sun, Oct 16, 2022, at 9:54 AM, Alexander Gordeev wrote:
>> On Wed, Oct 12, 2022 at 12:39:11PM +0200, Arnd Bergmann wrote:
>>> "Some" means exactly powerpc64, right? It looks like microblaze
>>> and powerpc32 still share some of this code, but effectively
>>> just use the vmalloc area once the slab allocator is up.
>>> 
>>> Is the special case still useful for powerpc64 or could this be
>>> changed to do it the same as everything else?
>>
>> Or make it the other way around and set IOREMAP_START/IOREMAP_END
>> to VMALLOC_START/VMALLOC_END by default?
>
> Sure, if there is a reason for actually making them different.
> From the git history, it appears that before commit 3d5134ee8341
> ("[POWERPC] Rewrite IO allocation & mapping on powerpc64"), the
> ioremap() and vmalloc() handling was largely duplicated. Ben
> cleaned it up by making most of the implementation shared but left
> the separate address spaces.
>
> My guess is that there was no technical reason for this, other
> than having no reason to change the behavior at the time.

I think the immediate reason for it is that on some CPUs we have to use
4K pages in the HPT for IO mappings, but PAGE_SIZE == 64K, and we can
only have a single page size per segment (256M or 1T).

cheers
