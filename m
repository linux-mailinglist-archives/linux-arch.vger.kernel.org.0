Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4855A11E148
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2019 10:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfLMJ5M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Dec 2019 04:57:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50606 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMJ5M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2019 04:57:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBD9ubog152811;
        Fri, 13 Dec 2019 09:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=S7FcfMv5EYcYTkRgDKj3WiJgIcLQuGB+dA630iy3KgE=;
 b=EwUctdIKdzeMK4U9V0eZodEkn7Bb+OG5JVroMMBxdp9bMxk5wASTgKNja1oZFcUIxOn9
 tEwtlEoYUj7T1nmTMIWJefNN9uBNqLmZcBaveIJj9AF+apGkAaTRefE83UrOWgK6WPOw
 HjC5MbEvqLZJWUT6/gWleJGhXHZfpG1tTUI2cWrApFo4/wvsq5VXZ2zz2o5Iv7BYFNXe
 f3cZeXdDri4EXBl9H/UJUNMx6HDy21MOtARZHgTzH8lWiV5rKpcU1uDLNL2mRVZvoF1q
 IOVwvYMv3u5y4WxG/pj0mkbmoeR4jkYl6KHCxMj0rJntCtjOOHDDgC9weq3RAMWCMtKO Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wr41qr6u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 09:56:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBD9mlnf001336;
        Fri, 13 Dec 2019 09:56:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wumu62phb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 09:56:43 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBD9ugiY016371;
        Fri, 13 Dec 2019 09:56:42 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 01:56:42 -0800
Date:   Fri, 13 Dec 2019 12:56:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Andrew Morton <akpm@linux-foundation.org>, will@kernel.org,
        ebiederm@xmission.com, linux-arch@vger.kernel.org,
        security@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] execve: warn if process starts with executable stack
Message-ID: <20191213095634.GB2407@kadam>
References: <20191208171918.GC19716@avx2>
 <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
 <20191211072225.GB3700@avx2>
 <20191211095937.GB31670@1wt.eu>
 <20191211181933.GA3919@avx2>
 <20191211182401.GF31670@1wt.eu>
 <20191212212520.GA9682@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212212520.GA9682@avx2>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130078
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 13, 2019 at 12:25:20AM +0300, Alexey Dobriyan wrote:
> On Wed, Dec 11, 2019 at 07:24:01PM +0100, Willy Tarreau wrote:
> > On Wed, Dec 11, 2019 at 09:19:33PM +0300, Alexey Dobriyan wrote:
> > > Reports are better be done by people who know what they are doing, as in
> > > understand what executable stack is and what does it mean in reality.
> > > 
> > > > Otherwise it will just go to /dev/null with all warning about bad blocks
> > > > on USB sticks and CPU core throttling under high temperature.
> > > 
> > > That's fine. You don't want bugreports from people who don't know what
> > > is executable stack. Every security bug bounty program is flooded by
> > > such people. This is why message is worded in a neutral way.
> > 
> > Well we definitely don't have the same experience with user reports. I
> > was just suggesting, but since you apparently already have all the
> > responses you needed, I'm even wondering why the warning remains.
> 
> Willy, whatever instructions for users you have in mind must be
> different for different people. Developer should be told to add
> "-Wl,-z,noexecstack" and more. Regular user (define "regular") should be
> told to send bugreport if the program really needs executable stack
> which again splits into two situations: exec stack was added knowingly
> because it is some old program with lost source code or it was readded
> by mistake.
> 
> "Complain to linux-kernel" is meaningless, kernel is not responsible.
> 
> What the message is even supposed to say?
> 

You could direct people to a website and then update the instructions
as needed.

regards,
dan carpenter

