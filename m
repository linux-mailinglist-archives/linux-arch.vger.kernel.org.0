Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96AAB6AC25
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 17:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbfGPPok (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 11:44:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39404 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfGPPok (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 11:44:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GFhSpo070864;
        Tue, 16 Jul 2019 15:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=a4gDFTsB/LQFXl2IENlqSTWt+0C4weUdEbBefLOr+/Y=;
 b=j4PQFsgGnRUarcjO4tIaRTYuSUWlXTvZg7j7e0jwp9FjvRFXf5Q4oUvWYiQJ90TUhMp9
 vNPmQUTDmh3eVWcatV7w6brcmL5h2/1I7qh8WWjhmO0xYi5E7nBxucnZ4a/8aUDUClm8
 wd+ULqhiyu7rVpCkYIHSIJj/6Hq0BuGG8Cz25fByQUAeTLUobdxZvgaOgb9sFaaGtuWl
 p+3ikYSnls7A5U26sB+oUI1UdLcqLWuE0GEWSxknNHDoAzU+IoqPIakp/AQdUSy8TZDX
 SUiqCTryb5Zwb+VV0P6VgC4s8QaVYxk5MrbRIDrPJSFDEl8fxQnWgjINjESljB0vUkxG bA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tq78pnbfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 15:44:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GFh537152637;
        Tue, 16 Jul 2019 15:44:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tq6mmybsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 15:44:17 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GFiE2J001767;
        Tue, 16 Jul 2019 15:44:14 GMT
Received: from [192.168.1.218] (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 15:44:13 +0000
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190716125309.GA10672@andrea>
 <20190716150142.rebjmpjjiesaiwyt@gondor.apana.org.au>
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
Message-ID: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
Date:   Tue, 16 Jul 2019 11:44:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190716150142.rebjmpjjiesaiwyt@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=617
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160193
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=653 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160193
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/16/19 11:01 AM, Herbert Xu wrote:
> On Tue, Jul 16, 2019 at 02:53:09PM +0200, Andrea Parri wrote:
>>
>> P1(atomic_t *reorder_objects, spinlock_t *pd_lock, spinlock_t *reorder_lock)
>> {
>> 	int r1;
>>
>> 	spin_lock(reorder_lock);
>> 	atomic_inc(reorder_objects);
>> 	spin_unlock(reorder_lock);
>> 	//smp_mb();
>> 	r1 = spin_trylock(pd_lock);
>> }
> 
> Yes we need a matching mb on the other side.  However, we can
> get away with using smp_mb__after_atomic thanks to the atomic_inc
> above.
> 
> Daniel, can you please respin the patch with the matching smp_mb?

Sure, Herbert, will do.

Thanks,
Daniel
