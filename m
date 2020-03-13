Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DCE183DE2
	for <lists+linux-arch@lfdr.de>; Fri, 13 Mar 2020 01:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCMAit (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Mar 2020 20:38:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49724 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgCMAit (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Mar 2020 20:38:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02D0Mwck168386;
        Fri, 13 Mar 2020 00:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=hP9mFZ8Sxu3J/EE4JbNN5uOrXQmbEtdEQRl+6NEGKTQ=;
 b=TECcM3pWqwkOo2PhaIJkxOT9Nt32xhMZdc5+LNPDjbjTlaemjskiGlzOz+C/UTPGiP59
 9AQtBEeRJS5DT+yvsSXahiWMhQxQvlRJs8TO3yOeTE2GGVCDFnT/wWVW8NroteMU8oyc
 pvWxCoXhHwBX0TRkUKB7w3o1PZyPqZYnHgUl0Fmlhyw7NsijzDcgQLTmU5mVEF7MPeLv
 n6FhxVG1Egatr43obuziFyMZ3rzc8kvZf1izZAtRCu1/V1ze5Lo6xrFvAGvcxy+Ir8H8
 no4vMo9nYigHYAtS8qCmDtSC6tg7vPHfQftLMzuNVFpDTkjgg0XGWKulCPFXgCLRNY+W Lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2yqtag98fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 00:38:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02D0OJUY144781;
        Fri, 13 Mar 2020 00:38:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yqta9uuut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 00:38:21 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02D0cET2003083;
        Fri, 13 Mar 2020 00:38:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 17:38:13 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        "linux-nvme \@ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] asm-generic: Provide generic {get, put}_unaligned_{l, b}e24()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
        <efe5daa3-8e37-101a-9203-676be33eb934@acm.org>
        <20200312162507.GF1922688@smile.fi.intel.com>
        <6d932620-3255-fbd8-7fc8-22e4b3068043@acm.org>
        <CAO+b5-rXUU9r-SrCWq2cYbBr5xFqyx4CUMb8xHZv2xYzEP6CyA@mail.gmail.com>
Date:   Thu, 12 Mar 2020 20:38:10 -0400
In-Reply-To: <CAO+b5-rXUU9r-SrCWq2cYbBr5xFqyx4CUMb8xHZv2xYzEP6CyA@mail.gmail.com>
        (Bart Van Assche's message of "Thu, 12 Mar 2020 17:29:37 -0700")
Message-ID: <yq1v9n9nl71.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=623 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=687 phishscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130000
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Bart,

> Martin, can I send the second version of my patch series to you or do
> you perhaps prefer that I send it to another kernel maintainer? I'm
> considering to include the following patches:

Happy to take it.

-- 
Martin K. Petersen	Oracle Linux Engineering
