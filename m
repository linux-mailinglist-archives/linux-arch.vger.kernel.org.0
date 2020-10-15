Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4749628FA94
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 23:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgJOVVM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 17:21:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37264 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbgJOVVL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Oct 2020 17:21:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FL9sgf108414;
        Thu, 15 Oct 2020 21:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FV6I0fsZyPX8snT2xhDk1zWcNw8UiciM8erCRzN6Udo=;
 b=UdL45CHPPOXDZ4zEFtc3Q/95eR77q0866gQGri1DzwdjlNd24SbdmOlguedwVWaTTCN0
 MFQLMyYBoEpoE32Drz7s/kHLIoSt1DAy53Sn7DnIkdoPt6ZEafnvjo7uGev5InylXvu+
 3fkUWycsHofjpjERriR4m1C01w7P3fjrPyQ2bax2nLFmFXXcBWHJDxH46R/E0FWWIEg0
 a4DIWx9TkQ2mFI7zZAdLHqnVbUIrhViQRFaMyGrxo9btO2b5wWI5PN/0GKOeJ7HdAVRG
 VgB562Dhgvt5zkRkwh78wE9mkvCxQ36uaSIfDy2T6FKagxGTQbx7zNWUbaWVfroDV8N5 WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 343vaencsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 21:20:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FLBMm9119076;
        Thu, 15 Oct 2020 21:20:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 343pv2bq13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 21:20:51 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09FLKdb5010307;
        Thu, 15 Oct 2020 21:20:39 GMT
Received: from [192.168.0.108] (/70.36.60.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Oct 2020 14:20:38 -0700
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
 <20201014211214.GD18196@zn.tnic>
 <3de58840-1f4c-566b-3a66-46d57475820c@oracle.com>
 <20201015103535.GC11838@zn.tnic>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <593f3b75-678c-1cd4-a7f0-55257dc84caf@oracle.com>
Date:   Thu, 15 Oct 2020 14:20:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015103535.GC11838@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150141
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-10-15 3:35 a.m., Borislav Petkov wrote:
> On Wed, Oct 14, 2020 at 08:37:44PM -0700, Ankur Arora wrote:
>> I don't disagree but I think the selection of cached/uncached route should
>> be made where we have enough context available to be able to choose to do
>> this.
>>
>> This could be for example, done in mm_populate() or gup where if say the
>> extent is larger than LLC-size, it takes the uncached path.
> 
> Are there examples where we don't know the size?

The case I was thinking of was that clear_huge_page() or faultin_page() would
know the size to a page unit, while the higher level function would know the
whole extent and could optimize differently based on that.

Thanks
Ankur

> 
