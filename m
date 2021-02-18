Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BD031E944
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 12:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhBRLsB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 06:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhBRLPk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Feb 2021 06:15:40 -0500
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Feb 2021 03:14:59 PST
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88299C061788
        for <linux-arch@vger.kernel.org>; Thu, 18 Feb 2021 03:14:59 -0800 (PST)
Received: (qmail 5856 invoked from network); 18 Feb 2021 11:07:49 -0000
Received: from mail.sf-mail.de ([2a01:4f8:1c17:6fae:616d:6c69:616d:6c69]:42702 HELO webmail.sf-mail.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.37dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <vbabka@suse.cz>; Thu, 18 Feb 2021 12:07:49 +0100
MIME-Version: 1.0
Date:   Thu, 18 Feb 2021 12:07:26 +0100
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
In-Reply-To: <7859a7a0-96e2-72ff-be92-c0af5d642564@suse.cz>
References: <20210217154844.12392-1-david@redhat.com>
 <7859a7a0-96e2-72ff-be92-c0af5d642564@suse.cz>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <50f73055950ff7382f2194134ef0f439@sf-tec.de>
X-Sender: eike-kernel@sf-tec.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>> Let's introduce MADV_POPULATE with the following semantics
>> 1. MADV_POPULATED does not work on PROT_NONE and special VMAs. It 
>> works
>>    on everything else.
>> 2. Errors during MADV_POPULATED (especially OOM) are reported. If we 
>> hit
>>    hardware errors on pages, ignore them - nothing we really can or
>>    should do.
>> 3. On errors during MADV_POPULATED, some memory might have been
>>    populated. Callers have to clean up if they care.
>> 4. Concurrent changes to the virtual memory layour are tolerated - we
                                                     ^t
>>    process each and every PFN only once, though.
>> 5. If MADV_POPULATE succeeds, all memory in the range can be accessed
>>    without SIGBUS. (of course, not if user space changed mappings in 
>> the
>>    meantime or KSM kicked in on anonymous memory).

You are talking both about MADV_POPULATE and MADV_POPULATED here.

Eike
