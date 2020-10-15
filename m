Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AA628EBA8
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 05:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbgJODiL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 23:38:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57902 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387414AbgJODiL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 23:38:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F3V1VA164274;
        Thu, 15 Oct 2020 03:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TdkRaI1K2emwA4ULWa95up2TNJiDjREeVjcHKnTnlc8=;
 b=Pao98oSADgnAZP4FqoZcmL520aM6F8URtxqADMzzibOeJu+0eMdV3tlmakSkxiSUJW8a
 gVgTQyf5XgUqxCnE3afABhc8rdXc/wdAb4efSpga6qsrIMi/iQacxA18I3nUhJJVs54l
 vJosugKlU/sgJpC3flxW7Z9CWUBfesGrbKztvMsret6XYq/Z1vRz2me1yxdDFogWVKak
 W9DzHtSElGx6ZbwjwBtFlr0kDV3HZsv6d++0eLCX2psVaUxd3Sltrmud7+3G1eKy2LnD
 tsLRzTBtPO/hMjSBL9oPStfCpo2EeFgGjU8/RNlS5mkfDOLLyCG0Rhb3H9sfloufUgWo 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 343vaegxm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 03:37:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F3TwkV122677;
        Thu, 15 Oct 2020 03:37:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 343phqfj42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 03:37:51 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09F3bmcK019734;
        Thu, 15 Oct 2020 03:37:48 GMT
Received: from [192.168.0.108] (/70.36.60.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 20:37:48 -0700
Subject: Re: [PATCH 5/8] x86/clear_page: add clear_page_uncached()
To:     Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>
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
 <20201014211214.GD18196@zn.tnic>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <3de58840-1f4c-566b-3a66-46d57475820c@oracle.com>
Date:   Wed, 14 Oct 2020 20:37:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201014211214.GD18196@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150025
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-10-14 2:12 p.m., Borislav Petkov wrote:
> On Wed, Oct 14, 2020 at 02:07:30PM -0700, Andy Lutomirski wrote:
>> I assume it’s for a little optimization of clearing more than one
>> page per SFENCE.
>>
>> In any event, based on the benchmark data upthread, we only want to do
>> NT clears when they’re rather large, so this shouldn’t be just an
>> alternative. I assume this is because a page or two will fit in cache
>> and, for most uses that allocate zeroed pages, we prefer cache-hot
>> pages. When clearing 1G, on the other hand, cache-hot is impossible
>> and we prefer the improved bandwidth and less cache trashing of NT
>> clears.
> 
> Yeah, use case makes sense but people won't know what to use. At the
> time I was experimenting with this crap, I remember Linus saying that
> that selection should be made based on the size of the area cleared, so
> users should not have to know the difference.
I don't disagree but I think the selection of cached/uncached route should
be made where we have enough context available to be able to choose to do
this.

This could be for example, done in mm_populate() or gup where if say the
extent is larger than LLC-size, it takes the uncached path.

> 
> Which perhaps is the only sane use case I see for this.
> 
>> Perhaps SFENCE is so fast that this is a silly optimization, though,
>> and we don’t lose anything measurable by SFENCEing once per page.
> 
> Yes, I'd like to see real use cases showing improvement from this, not
> just microbenchmarks.
Sure will add.

Thanks
Ankur

> 
