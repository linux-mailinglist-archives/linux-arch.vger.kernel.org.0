Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C29528E823
	for <lists+linux-arch@lfdr.de>; Wed, 14 Oct 2020 22:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbgJNU43 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 16:56:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60652 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387573AbgJNU43 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 16:56:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EKsKUh005403;
        Wed, 14 Oct 2020 20:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=2dHm09Cd/t0EY1pFGezYnD8/lE5PJwJ2i8unZaqVKkw=;
 b=MuanJBZWoZVWBkFAYPnavkgtao047Y/tIwxSOlrITqcuNtNrilkva0w4zlao5qpjJxNO
 wxhqPOE1jzBdzhShh9zLyGBBtqTHbnCT6j8JEFApLFDXncxLcJr/JF9lwarXdDgi4WT4
 CrA8m4JNPMQnfZd/llCDS/Wm7IP4E2UtiFsvk7yiy3zEVC0GVoZ2CZYhoHMCZ8zTbNNc
 zIabnreO8UggVCicu2PntN4YAr8y1LANyZSJdbGSzXq4/8MKWCoxn83upAPz7UmoKeT7
 wTszyg2WFygjXZa1/Gh4LK6cm6cygPABXQmvDly0lFM2gQRDRnaCecc7ZUtsq6t9nn4h ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3434wksru3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 20:56:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EKnZiO079912;
        Wed, 14 Oct 2020 20:54:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 344by46q0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 20:54:10 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09EKs2fJ006933;
        Wed, 14 Oct 2020 20:54:02 GMT
Received: from [10.159.149.68] (/10.159.149.68)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 13:54:02 -0700
Subject: Re: [PATCH 5/8] x86/clear_page: add clear_page_uncached()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
 <20201014083300.19077-6-ankur.a.arora@oracle.com>
 <CALCETrVKLv5DPByFcj7E5SBbv4mFt7mGQ9j-HU7G5u_aPGCYsQ@mail.gmail.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <047e8a34-65cb-ce46-bfe2-014a43b61560@oracle.com>
Date:   Wed, 14 Oct 2020 13:54:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVKLv5DPByFcj7E5SBbv4mFt7mGQ9j-HU7G5u_aPGCYsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=928 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=949
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140147
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-10-14 8:45 a.m., Andy Lutomirski wrote:
> On Wed, Oct 14, 2020 at 1:33 AM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>> Define clear_page_uncached() as an alternative_call() to clear_page_nt()
>> if the CPU sets X86_FEATURE_NT_GOOD and fallback to clear_page() if it
>> doesn't.
>>
>> Similarly define clear_page_uncached_flush() which provides an SFENCE
>> if the CPU sets X86_FEATURE_NT_GOOD.
> 
> As long as you keep "NT" or "MOVNTI" in the names and keep functions
> in arch/x86, I think it's reasonable to expect that callers understand
> that MOVNTI has bizarre memory ordering rules.  But once you give
> something a generic name like "clear_page_uncached" and stick it in
> generic code, I think the semantics should be more obvious.
> 
> How about:
> 
> clear_page_uncached_unordered() or clear_page_uncached_incoherent()
> 
> and
> 
> flush_after_clear_page_uncached()
> 
> After all, a naive reader might expect "uncached" to imply "caches are
> off and this is coherent with everything".  And the results of getting
> this wrong will be subtle and possibly hard-to-reproduce corruption.
Yeah, these are a lot more obvious. Thanks. Will fix.

Ankur

>
> --Andy
> 
