Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D33DF1A62
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 16:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfKFPvW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 10:51:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41914 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfKFPvW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 10:51:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6FmqSn087241;
        Wed, 6 Nov 2019 15:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=PO5xmk8/u2tGcx69lrZ2ukP6AxC0vWVORGFcZZoWIYs=;
 b=h4YefMSV8UO5B8PpOmCvsc6dc7N/uPcBlLU1j372VyQS4pmZda2oXwHzBQzWqIn1MtRw
 ER76GbT6kBLaD/Z48fK82XHsOWYKu4KvRt30Fz1kqVCL0DmCSwd9x5e2YQV2wB2kXHuH
 9GbfqPD8kqtV1noMusHNHPvqRLSaUz5Gq5MV+0kP/nfJV/cIAT40/iEoRdbQZIL/yyAe
 HCK9XNX8FCWK97TWkttwTa8o+NLduFSLguG9+Pm5iDmNWEkKUA1PX2zUXIoNBQzORCWg
 nS6kpR1RlR3sd15SXaiDm/wAoUaFuEsGLDtEQbVNvdhfDrFRt8u0KIH2CjwcPdPy/gO1 Sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w117u7pvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 15:50:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6FnAVt109387;
        Wed, 6 Nov 2019 15:50:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2w3xc2vkww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 15:50:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA6FoivW011280;
        Wed, 6 Nov 2019 15:50:44 GMT
Received: from [10.39.238.145] (/10.39.238.145)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 07:50:44 -0800
Subject: Re: [patch V2 04/17] x86/entry: Make DEBUG_ENTRY_ASSERT_IRQS_OFF
 available for 32bit
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
 <20191023123117.976831752@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <9a1170f8-819b-9d30-9d77-66c60cd4cafb@oracle.com>
Date:   Wed, 6 Nov 2019 16:50:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20191023123117.976831752@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911060152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911060152
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 10/23/19 2:27 PM, Thomas Gleixner wrote:
> Move the interrupt state verification debug macro to common code and fixup
> the irqflags and paravirt components so it can be used in 32bit code later.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/calling.h        |   12 ++++++++++++
>   arch/x86/entry/entry_64.S       |   12 ------------
>   arch/x86/include/asm/irqflags.h |    8 ++++++--
>   arch/x86/include/asm/paravirt.h |    9 +++++----
>   4 files changed, 23 insertions(+), 18 deletions(-)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
