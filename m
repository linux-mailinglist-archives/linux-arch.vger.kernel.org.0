Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD50F2188DC
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jul 2020 15:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgGHNVP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jul 2020 09:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgGHNVO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 09:21:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2C4C061A0B;
        Wed,  8 Jul 2020 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+RqR1kYT0E+mIwb2z3JHix29G2Tjj0bnkWavGGFqh3k=; b=kwOuGr/+r/Cs6PkNR64wAQevbo
        9QK6VPYIdyKLt3Fus84356sLfucme8iCE/fu6eVrl2bWzIUyfVI5tfYwV1UanXw8PHSxl47KyGZ78
        QpCwAKRR7gOwGjBHe77cRWfATtKBJ28l+xfNCKRzObd3Qomw0Ci9EdDMFiBbBZw+UrjH8Vs2KBw7I
        vPXygGRTkKQ1D+Xrnm9m4d04i0Y70SVVH3dF+QQQc0l/E/Vucg+psM6bF5gK+r3Ypl61zVFFV5tKU
        QmsLrPVsWRdYqHk2Axf1T2M/+5W68WLrHxsZzi3jZ4XNc2PEzoxH7Y05w1amXllv3xfVNj4sApJnc
        nGPBPHEQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtA0b-0006b0-EQ; Wed, 08 Jul 2020 13:21:09 +0000
Subject: Re: [PATCH -next] Documentation/vm: fix tables in
 arch_pgtable_helpers
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <02ee60d0-e836-2237-4881-5c57ccac5551@infradead.org>
 <20200708064332.GD128651@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7d43f116-51f0-8cab-f8ee-ea9387039d1d@infradead.org>
Date:   Wed, 8 Jul 2020 06:21:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708064332.GD128651@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/7/20 11:43 PM, Mike Rapoport wrote:
> Hi Randy,
> 
> On Tue, Jul 07, 2020 at 06:07:40PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Make the tables be presented as tables in the generated output files
>> (the line drawing did not present well).
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: linux-arch@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>  Documentation/vm/arch_pgtable_helpers.rst |  333 ++++++--------------
>>  1 file changed, 116 insertions(+), 217 deletions(-)
>>
>> --- linux-next-20200707.orig/Documentation/vm/arch_pgtable_helpers.rst
>> +++ linux-next-20200707/Documentation/vm/arch_pgtable_helpers.rst
>> @@ -17,242 +17,141 @@ test need to be in sync.
>>  PTE Page Table Helpers
>>  ======================
>>  
>> ---------------------------------------------------------------------------------
>> -| pte_same                  | Tests whether both PTE entries are the same      |
>> ---------------------------------------------------------------------------------
> 
> According to ReST docs [1] we can use +---+---+ as row delimiter and
> than we can keep | as column delimiter.
> 
> @Andrew, can you please fold the below patch into Anshuman's original
> patch?
> 
> [1] https://docutils.sourceforge.io/docs/user/rst/quickref.html#tables

Works for me. Thanks.

-- 
~Randy

