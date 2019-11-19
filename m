Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1810C101460
	for <lists+linux-arch@lfdr.de>; Tue, 19 Nov 2019 06:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfKSFdM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Nov 2019 00:33:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43106 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbfKSFdM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Nov 2019 00:33:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ5TF0E134981;
        Tue, 19 Nov 2019 05:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=X+d/DvKGRe+3ht5uGLcFVUVOi2MtdYAju2LrusN0PB8=;
 b=Eg57Xk7Dlr+oDb9WxKzCghU3rGfM/tKiWrrIlOnoMFTkUEIMtm2GGkDhwqr7QmVhvDmn
 I7xE5Ge7ycQseksjeyn1gKpChkowEZK6oI+Gx9G0L7SmSNoNWsTeAYg7EBwH/pTOtPpu
 lFmk56hCZGESru2ZgZWw05LkwxyF/dEiyQ1y9CJepKXRJycnt2iYW76Eqzj5C5J9b3gF
 DxSWY0Ui5q694tSUhsZwX0Sr7NOuWM0h5bRgAMPnp2ZlaP+RyW0FucXNGedoojmzEcAx
 nBVnBv7Is9MTP68ucX8p5W75u2uJ49PLjVXt7qjuNl4KaJHn95UB4/Wra2iYi4H+RvXU EA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wa8htmkds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 05:32:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ5SNWL016943;
        Tue, 19 Nov 2019 05:32:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wbxm3nx20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 05:32:51 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJ5Wo7G012724;
        Tue, 19 Nov 2019 05:32:50 GMT
Received: from kadam (/41.210.141.188)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 21:32:47 -0800
Date:   Tue, 19 Nov 2019 08:32:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        security@kernel.org, ben.dooks@codethink.co.uk
Subject: Re: [PATCH] exec: warn if process starts with executable stack
Message-ID: <20191119053230.GC5626@kadam>
References: <20191118145114.GA9228@avx2>
 <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
 <20191118215227.GA24536@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118215227.GA24536@avx2>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=587
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=714 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190050
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 19, 2019 at 12:52:27AM +0300, Alexey Dobriyan wrote:
> There were few episodes of silent downgrade to an executable stack:
> 
> 1) linking innocent looking assembly file
> 
> 	$ cat f.S
> 	.intel_syntax noprefix
> 	.text
> 	.globl f
> 	f:
> 	        ret
> 
> 	$ cat main.c
> 	void f(void);
> 	int main(void)
> 	{
> 	        f();
> 	        return 0;
> 	}
> 
> 	$ gcc main.c f.S
> 	$ readelf -l ./a.out
> 	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>                          0x0000000000000000 0x0000000000000000  RWE    0x10
> 
> 2) converting C99 nested function into a closure
> https://nullprogram.com/blog/2019/11/15/
> 
> 	void intsort2(int *base, size_t nmemb, _Bool invert)
> 	{
> 	    int cmp(const void *a, const void *b)
> 	    {
> 	        int r = *(int *)a - *(int *)b;
> 	        return invert ? -r : r;
> 	    }
> 	    qsort(base, nmemb, sizeof(*base), cmp);
> 	}
> 
> will silently require stack trampolines while non-closure version will not.
> 
> While without a double this behaviour is documented somewhere, add a warning
                  ^^^^^^
doubt

> so that developers and users can at least notice. After so many years of x86_64
> having proper executable stack support it should not cause too much problems.
> 
> If the system is old or CPU is old, then there will be an early warning
> against init and/or support personnel will write that "uh-oh, our Enterprise
> Software absolutely requires executable stack" and close tickets and customers
> will nod heads and life moves on.
> 

regards,
dan carpenter
