Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB41301E09
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 19:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbhAXSHu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 13:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbhAXSHt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 13:07:49 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E60FC061573;
        Sun, 24 Jan 2021 10:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=HhUOvfM5GjLoCSC9whTRSyY37b8Gp9Xbo3KKD5Qng4w=; b=Nwh9j/1vJ8QEsuvNwtNUS53AZP
        B38LmqvapqV8SptCubayYSP2OuIeQ6MxXiDON/5O+8kXCwiVcpe43dZc9MafsKTosxTt9DBbrnDSM
        k2oHopY0jVBsKwZQ3ueHF6jKmUEbIaZETsuminnNe59InN6H+eEiBI2auMvEIraO54KQTTWw5ILo0
        nhM/B0Bzp0377P4emjTM7b5LkEkIdxWQMVx8T65tE8ZkEe5k6f3aU1q89hxXo29vUTdj0S6/5GYgV
        GgG7i+3dL4Pz1ET9P5wB7pBkc/KF+QI2uf757Nh/mhsWiiyBgu/aAb9UipGTkbARES+uas+If+78v
        kxfsuXhA==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l3jmD-0005We-6p; Sun, 24 Jan 2021 18:06:18 +0000
Subject: Re: [PATCH v10 11/12] mm/vmalloc: Hugepage vmalloc mappings
To:     Christoph Hellwig <hch@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
 <20210124082230.2118861-12-npiggin@gmail.com>
 <20210124150729.GC733865@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a420ccc5-91de-78e3-4276-7bca3e97b88b@infradead.org>
Date:   Sun, 24 Jan 2021 10:06:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210124150729.GC733865@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/24/21 7:07 AM, Christoph Hellwig wrote:
>> +config HAVE_ARCH_HUGE_VMALLOC
>> +	depends on HAVE_ARCH_HUGE_VMAP
>> +	bool
>> +	help
>> +	  Archs that select this would be capable of PMD-sized vmaps (i.e.,
>> +	  arch_vmap_pmd_supported() returns true), and they must make no
>> +	  assumptions that vmalloc memory is mapped with PAGE_SIZE ptes. The
>> +	  VM_NOHUGE flag can be used to prohibit arch-specific allocations from
>> +	  using hugepages to help with this (e.g., modules may require it).
> help texts don't make sense for options that aren't user visible.

It's good that the Kconfig symbol is documented and it's better here
than having to dig thru git commit logs IMO.

It could be done as "# Arhcs that select" style comments instead
of Kconfig help text.


-- 
~Randy

