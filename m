Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F70F1A04
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 16:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbfKFPaC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 10:30:02 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47094 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbfKFPaB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 10:30:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6FJ1QX030993;
        Wed, 6 Nov 2019 15:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Zb1yrefGglmrVT3RvzlHlIcenzI+rDNlCHQZIYpKA84=;
 b=mDDG05DmE+F5r4p8i0cps6frf1I5+4HgD/64M/zd5XBFvXzjxYDb/aVJoxhCtpRSuHg0
 1jAgegZ4Rw+BhIJ3rRK7W9A8Re8VRDKyrz/QrUiCYhFXBDn6VIwighr0We4RBB4nEPMF
 hyh6nCY90EDs6P6tve27UGBUB7TOgtI8gRJPLhMPutipMbnLOTZCG4bS16rcK+oCXQKH
 UmJIssU+HWNE1stWWq9AIDEqiHA5nCiAJv2pSNWisXM94Fk4ZA51/rqp6K+zeZdt/KXe
 yhPT9sAYpbk7l5Wb3aHLXDPs6GX80W6iaZaiXRFPqbtZcc6FZFExNdG/kOKSuwicUk/z /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w12erf8x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 15:29:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6FONpt019693;
        Wed, 6 Nov 2019 15:29:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2w3xc2u4rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 15:29:30 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA6FTTOC013679;
        Wed, 6 Nov 2019 15:29:29 GMT
Received: from [10.39.238.145] (/10.39.238.145)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 07:29:29 -0800
Subject: Re: [patch V2 02/17] x86/entry/64: Remove pointless jump in
 paranoid_exit
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
 <20191023123117.779277679@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <10e378e2-d9dc-e8dd-fe62-7427b061decf@oracle.com>
Date:   Wed, 6 Nov 2019 16:29:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20191023123117.779277679@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
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
> Jump directly to restore_regs_and_return_to_kernel instead of making
> a pointless extra jump through .Lparanoid_exit_restore
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/entry_64.S |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
