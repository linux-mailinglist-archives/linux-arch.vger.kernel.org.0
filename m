Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15EFEF1A19
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 16:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbfKFPeA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 10:34:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46884 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfKFPeA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 10:34:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6FJ19h045138;
        Wed, 6 Nov 2019 15:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=8HvIMo9o0gvTpDtbNdGhYkbxoKeXS6Wz6uiSRqv8w/8=;
 b=H0ruiOOtM87NM5XDsFkMQsLGrAIthdbFrzCox9zQCkDkMBExl0a8rRvdQXYdnccRXe8+
 5f7UQHmxlTF32JazZw/IWDrjJnE/oc3lrSeXLvYiQ3A1DbeqsAphRrKTd8pAAvwtOZ80
 SvUTLA2SdwRJ4lUChDgQs8LogKaWjAsJ5OsQBPiGDCE2O3SFQzkj1SZ3XE6e7xs1oPZw
 K9q7J2Yd5bUDnhsCKUDT5ZP3PeM/tm0IPmhUrysErGqP93smKFn+0maZgL0BSLRaIpCP
 IZ9cgreOtSq7Yvqg3uoftcaXGc3nbc3mj82OFtTPAoDzhbr3H9ccAmXQsvAglOf/9aPS WQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2w11rq7ex9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 15:33:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6FOM68019576;
        Wed, 6 Nov 2019 15:33:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2w3xc2udjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 15:33:20 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA6FXJEo023716;
        Wed, 6 Nov 2019 15:33:19 GMT
Received: from [10.39.238.145] (/10.39.238.145)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 07:33:19 -0800
Subject: Re: [patch V2 03/17] x86/traps: Remove pointless irq enable from
 do_spurious_interrupt_bug()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
References: <20191023122705.198339581@linutronix.de>
 <20191023123117.871608831@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <52673a2a-6e6e-c0f1-9586-70849429e7a0@oracle.com>
Date:   Wed, 6 Nov 2019 16:33:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20191023123117.871608831@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=961
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911060150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911060150
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 10/23/19 2:27 PM, Thomas Gleixner wrote:
> That function returns immediately after conditionally reenabling interrupts which
> is more than pointless and requires the ASM code to disable interrupts again.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/kernel/traps.c |    1 -
>   1 file changed, 1 deletion(-)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
