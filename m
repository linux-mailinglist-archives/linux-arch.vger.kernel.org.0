Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72D245F43E
	for <lists+linux-arch@lfdr.de>; Fri, 26 Nov 2021 19:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbhKZS2Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Nov 2021 13:28:16 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:59112 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhKZS0C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Nov 2021 13:26:02 -0500
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mqfrn-0002RG-Qw; Fri, 26 Nov 2021 18:22:40 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mqfri-00637Z-Mx; Fri, 26 Nov 2021 18:22:33 +0000
Subject: Re: [PATCH 4.9] hugetlbfs: flush TLBs correctly after
 huge_pmd_unshare
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <3BD89231-2CB9-4CE5-B0FA-5B58419D7CB8@gmail.com>
 <7a2feed4-7c73-c7ad-881e-c980235c8293@cambridgegreys.com>
 <C1607574-0A6F-4CEC-B488-795750EEF968@gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <5e2db11a-46ac-9b15-7b76-f27b718606c5@cambridgegreys.com>
Date:   Fri, 26 Nov 2021 18:22:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <C1607574-0A6F-4CEC-B488-795750EEF968@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 26/11/2021 17:49, Nadav Amit wrote:
> 
>> On Nov 26, 2021, at 2:21 AM, Anton Ivanov <anton.ivanov@cambridgegreys.com> wrote:
>>
>>
>>
>> On 26/11/2021 06:08, Nadav Amit wrote:
>>> Below is a patch to address CVE-2021-4002 [1] that I created to backport
>>> to 4.9. The stable kernels of 4.14 and prior ones do not have unified
>>> TLB flushing code, and I managed to mess up the arch code a couple of
>>> times.
>>> Now that the CVE is public, I would appreciate your review of this
>>> patch. I send 4.9 for review - the other ones (4.14 and prior) are
>>> pretty similar.
>>> [1] https://www.openwall.com/lists/oss-security/2021/11/25/1
>>> Thanks,
>>> Nadav
>>
>> I do not quite see the rationale for patching um
>>
>> It supports only standard size pages. You should not be able to map a huge page there (and hugetlbfs).
>>
>> I have "non-standard page size" somewhere towards the end of my queue, but it keeps falling through - not enough spare time to work on it.
> 
> Thanks for your review.
> 
> I did not look at the dependencies, so I did not even look if
> hugetlbfs depends on !um.
> 
> Do you prefer that for um, I will just do a BUG()? I prefer
> to have a stub just to avoid potential build issues.
> 
> 

Stub will be fine.

I was just checking in case I missed something.

Brgds,

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
