Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68B528EB74
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 05:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgJODW3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 23:22:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58832 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgJODW3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 23:22:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F3EnEJ087623;
        Thu, 15 Oct 2020 03:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=5jq4EdyxsgnsfxJk2c/wmbun8kFNHfpd+axuEGHJq9I=;
 b=sjySP3ga5v8ftnocYB2D+xwQ/joDb/mZcEZsbMpmRTEH3oHBkTmvEAhgOpAAQGXOZfSK
 5+Dwnf3uymC/LfXnAFIHnnqMKulPh6iiTL9HwxPe/iibv5JrsajHiD3eMwTPKepPwDxz
 xOQyRWypFLWszDPSzOr9axbEjsq8Tu5MjDBYI+joS6K0Ya92KmS9C7fSaUf3yPy1izjT
 7ZdLKsbck222qdK4WvKdQqtQ1MthtKtFgnAawVJXYSOfVJd9XlnTi9mIqjyFeLtJbwtH
 jsnv0E8EiAVH/gVPMudbBm+IlAdyyjgFWGZ7wr6j7K08myffQUjwJLePIuR+SET8nu1F jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3434wktkcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 03:22:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F3AbpF075099;
        Thu, 15 Oct 2020 03:22:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 343pvyqw3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 03:22:12 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09F3LxCC011235;
        Thu, 15 Oct 2020 03:22:00 GMT
Received: from [192.168.0.108] (/70.36.60.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 20:21:59 -0700
Subject: Re: [PATCH 5/8] x86/clear_page: add clear_page_uncached()
To:     Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20201014195823.GC18196@zn.tnic>
 <22E29783-F1F5-43DA-B35F-D75FB247475D@amacapital.net>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <50286c32-2869-cbd5-b178-0ad0c13584ea@oracle.com>
Date:   Wed, 14 Oct 2020 20:21:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <22E29783-F1F5-43DA-B35F-D75FB247475D@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150024
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-10-14 2:07 p.m., Andy Lutomirski wrote:
> 
> 
> 
>> On Oct 14, 2020, at 12:58 PM, Borislav Petkov <bp@alien8.de> wrote:
>>
>> ﻿On Wed, Oct 14, 2020 at 08:45:37AM -0700, Andy Lutomirski wrote:
>>>> On Wed, Oct 14, 2020 at 1:33 AM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>>>
>>>> Define clear_page_uncached() as an alternative_call() to clear_page_nt()
>>>> if the CPU sets X86_FEATURE_NT_GOOD and fallback to clear_page() if it
>>>> doesn't.
>>>>
>>>> Similarly define clear_page_uncached_flush() which provides an SFENCE
>>>> if the CPU sets X86_FEATURE_NT_GOOD.
>>>
>>> As long as you keep "NT" or "MOVNTI" in the names and keep functions
>>> in arch/x86, I think it's reasonable to expect that callers understand
>>> that MOVNTI has bizarre memory ordering rules.  But once you give
>>> something a generic name like "clear_page_uncached" and stick it in
>>> generic code, I think the semantics should be more obvious.
>>
>> Why does it have to be a separate call? Why isn't it behind the
>> clear_page() alternative machinery so that the proper function is
>> selected at boot? IOW, why does a user of clear_page functionality need
>> to know at all about an "uncached" variant?
>
> I assume it’s for a little optimization of clearing more than one page
> per SFENCE.
>
> In any event, based on the benchmark data upthread, we only want to do
> NT clears when they’re rather large, so this shouldn’t be just an
> alternative. I assume this is because a page or two will fit in cache
> and, for most uses that allocate zeroed pages, we prefer cache-hot
> pages. When clearing 1G, on the other hand, cache-hot is impossible
> and we prefer the improved bandwidth and less cache trashing of NT
> clears.

Also, if we did extend clear_page() to take the page-size as parameter
we still might not have enough information (ex. a 4K or a 2MB page that
clear_page() sees could be part of a GUP of a much larger extent) to
decide whether to go uncached or not.

> Perhaps SFENCE is so fast that this is a silly optimization, though,
> and we don’t lose anything measurable by SFENCEing once per page.
Alas, no. I tried that and dropped about 15% performance on Rome.

Thanks
Ankur
