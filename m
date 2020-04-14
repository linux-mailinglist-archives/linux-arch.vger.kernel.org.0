Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DCB1A7AC9
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 14:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgDNM2u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 08:28:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19996 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2501933AbgDNM2p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Apr 2020 08:28:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 491lCB2VyJz9ty2q;
        Tue, 14 Apr 2020 14:28:38 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=IXS45WnH; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OnGikXuRMKJq; Tue, 14 Apr 2020 14:28:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 491lCB1Nqtz9ty2r;
        Tue, 14 Apr 2020 14:28:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586867318; bh=q5tuqv3XX5tdFZ2Nwqglyq4XexfbdM7sUkp/aIyLDRw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IXS45WnHSm1Ayq4SS0uiPxa3vST+WWMTF8g5pm0xicL0YmkmdHBVHM7MqFdvFivSy
         4VKx/15HSGMZn84Khq7Sc+ziISswwhSUCUvDincDkchHmmJIjHMEuycCM/NgnTr/Xv
         cQH5RqaZiSzViAlD2v1Y1/wud6OaF/wj8MGMt9vo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E0138B7EB;
        Tue, 14 Apr 2020 14:28:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 91o1xMRYsudU; Tue, 14 Apr 2020 14:28:39 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F2278B7EA;
        Tue, 14 Apr 2020 14:28:38 +0200 (CEST)
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
To:     Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
 <20200413134106.GN21484@bombadil.infradead.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <36616218-1d3a-b18a-8fb8-4fc9eff22780@c-s.fr>
Date:   Tue, 14 Apr 2020 14:28:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413134106.GN21484@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 13/04/2020 à 15:41, Matthew Wilcox a écrit :
> On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
>> +static int vmap_pages_range_noflush(unsigned long start, unsigned long end,
>> +				    pgprot_t prot, struct page **pages,
>> +				    unsigned int page_shift)
>> +{
>> +	if (page_shift == PAGE_SIZE) {
> 
> ... I think you meant 'page_shift == PAGE_SHIFT'
> 
> Overall I like this series, although it's a bit biased towards CPUs
> which have page sizes which match PMD/PUD sizes.  It doesn't offer the
> possibility of using 64kB page sizes on ARM, for example.  But it's a
> step in the right direction.
> 

I was going to ask more or less the same question, I would have liked to 
use 512kB hugepages on powerpc 8xx.

Even the 8M hugepages (still on the 8xx), can they be used as well, 
taking into account that two PGD entries have to point to the same 8M page ?

I sent out a series which tends to make the management of 512k and 8M 
pages closer to what Linux expects, in order to use them inside kernel, 
for Linear mappings and Kasan mappings for the moment. See 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=164620
It would be nice if we could amplify it a use it for ioremaps and 
vmallocs as well.

Christophe
