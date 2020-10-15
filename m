Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1111228FABD
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 23:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgJOVk3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 17:40:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47218 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbgJOVk3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Oct 2020 17:40:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FLSx7r181800;
        Thu, 15 Oct 2020 21:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=A6pBae+uYiLsONLgce5yhTsLSTyZbn0WHCE5Ci0Sshk=;
 b=DJARA0rLF5hVYpDSE/cxv0FmPX3U7ZsoOPpQjmFk/iLXuuVgXpYvFu6F/DGjfxZ2N+o2
 aTlgzxHPeOxSca5/E5RChG+3nhV8+8n6Hz9SRatNHeFpSQFlByLkQojb2hjmBlJrHAei
 9glfIEcLVp9JI9jp+XXkJpgWj8UpyfNn8nvCkn0udMQGITlNRoo4jdfBGb0Ah1m2OI+o
 F90QMy8Ha+uA1dzU4Na3t1a0BS3ve14wUyWRa2ZAIp+L0r9k4Bt+3OkGWBbvbRQVRHkC
 rYvePQMtrHBzDzSO3CS1Spadh0gh5uyl26GARvH1OryXHRrShLL0cXbglfPVKqYA3veI yQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 346g8gm9nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 21:40:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FLUdcs035389;
        Thu, 15 Oct 2020 21:40:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 343pw0wxya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 21:40:11 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09FLe8li020524;
        Thu, 15 Oct 2020 21:40:08 GMT
Received: from [192.168.0.108] (/70.36.60.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Oct 2020 14:40:08 -0700
Subject: Re: [PATCH 5/8] x86/clear_page: add clear_page_uncached()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
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
 <50286c32-2869-cbd5-b178-0ad0c13584ea@oracle.com>
 <20201015104047.GD11838@zn.tnic>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <06032ba0-057e-3f56-c1bf-59373ae74e88@oracle.com>
Date:   Thu, 15 Oct 2020 14:40:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015104047.GD11838@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150142
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-10-15 3:40 a.m., Borislav Petkov wrote:
> On Wed, Oct 14, 2020 at 08:21:57PM -0700, Ankur Arora wrote:
>> Also, if we did extend clear_page() to take the page-size as parameter
>> we still might not have enough information (ex. a 4K or a 2MB page that
>> clear_page() sees could be part of a GUP of a much larger extent) to
>> decide whether to go uncached or not.
> 
> clear_page* assumes 4K. All of the lowlevel asm variants do. So adding
> the size there won't bring you a whole lot.
> 
> So you'd need to devise this whole thing differently. Perhaps have a
> clear_pages() helper which decides based on size what to do: uncached
> clearing or the clear_page() as is now in a loop.

I think that'll work well for GB pages, where the clear_pages() helper
has enough information to make a decision.

But, unless I'm missing something, I'm not sure how that would work for
say, a 1GB mm_populate() using 4K pages. The clear_page() (or clear_pages())
in that case would only see the 4K size.

But let me think about this more (and look at the callsites as you suggest.)

> 
> Looking at the callsites would give you a better idea I'd say.
Thanks, yeah that's a good idea. Let me go do that.

Ankur

> 
> Thx.
> 
