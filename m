Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEACF44CC
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 11:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfKHKma (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 05:42:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56482 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfKHKma (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 05:42:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8ATKrU049892;
        Fri, 8 Nov 2019 10:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=fp3pnErYbvbxA+Mx+2qhY6ge/lXDQYRira7mNwHpzmY=;
 b=TOihndvvZRuOmCdD9v4KxQOWEt2Z8DYzIjPRDOqkEtapR9zij/fHVdHSg95EfVQK0igQ
 NMqYRU2ZlfYXGuADVsrpPZZILSoibA+sFJF6XXo8jS1NL/P5CxWOp6jFtm+9o4DWapx0
 /1EY3X5OiLmVBCd+xQ5a3tvM5ikXNC+aDqOQrfFuZd2rLTQ+wVrIo0KuKGx5yynRZ75M
 dei9poudgYeaJYFCB+ujpi3eaEoKUBN51IbIos2JADFV9DqRMR54sXT3ygcZHo0vsZl/
 FBuH/Sg6O59q0KEsTanbTQ65h+ES73B1AHyrtNIeAfX1MfVaMKb3LY6UEjbsOlUBZb8L Nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2w41w1cjaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 10:41:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8ARxuB078391;
        Fri, 8 Nov 2019 10:41:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2w41whf22f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 10:41:53 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA8AfngC006265;
        Fri, 8 Nov 2019 10:41:52 GMT
Received: from [192.168.8.47] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 02:41:48 -0800
Subject: Re: [patch V2 06/17] x86/entry/32: Remove redundant interrupt disable
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
 <20191023123118.191230255@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <f8ba6ab8-c42d-f90f-f296-de270d1a7e21@oracle.com>
Date:   Fri, 8 Nov 2019 11:41:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20191023123118.191230255@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080103
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 10/23/19 2:27 PM, Thomas Gleixner wrote:
> Now that the trap handlers return with interrupts disabled, the
> unconditional disabling of interrupts in the low level entry code can be
> removed along with the trace calls and the misnomed preempt_stop macro.
> As a consequence ret_from_exception and ret_from_intr collapse.
> 
> Add a debug check to verify that interrupts are disabled depending on
> CONFIG_DEBUG_ENTRY.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/entry_32.S |   21 ++++++---------------
>   1 file changed, 6 insertions(+), 15 deletions(-)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
