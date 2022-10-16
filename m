Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188325FFE07
	for <lists+linux-arch@lfdr.de>; Sun, 16 Oct 2022 09:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiJPHzJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Oct 2022 03:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJPHzI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Oct 2022 03:55:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B0E20375;
        Sun, 16 Oct 2022 00:55:01 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G4R2xw021478;
        Sun, 16 Oct 2022 07:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NF4UuQ5CrDTxg24etw9exYVYuuVDsdA+aJqkZQohHnw=;
 b=n+KK15VpsFwv7V0+qqAxissjaaTBatmABRlDY+7et3tnkh2n+QAPVhseAo3KjmkjgnB2
 ZssU9aXO521HIgZp4PZvEsjS9U1fNzZ7Dusj0ENxAVx/rB10J84eSHtI0vwvA8GmniLg
 WNeiP3uSfIjdQrgByTsVRM+THIYCK+FEH+W2HSiBHXM3puR+ULIA217Fu6sVveCt4xo1
 5OzYxsnM+UnM6cv8ewnkrOYeGe4PeWeteu11/EgYTjdd83zRJKX9v9Va8y4iiDAa7nAq
 6J/VVvaqvmQNo4nKvuYIbl4wIhBar/t8HRGwJHxYemIxehSajjtPRufRYWzWxYdYGjPe YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86g5027u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Oct 2022 07:54:35 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29G7sZHi032611;
        Sun, 16 Oct 2022 07:54:35 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86g5027g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Oct 2022 07:54:34 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29G7rPLG032245;
        Sun, 16 Oct 2022 07:54:33 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3k7mg8s1y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Oct 2022 07:54:32 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29G7sUgx29426014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Oct 2022 07:54:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 541575204F;
        Sun, 16 Oct 2022 07:54:30 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.58.10])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id BB7E65204E;
        Sun, 16 Oct 2022 07:54:29 +0000 (GMT)
Date:   Sun, 16 Oct 2022 09:54:28 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Baoquan He <bhe@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com
Subject: Re: [RFC PATCH 7/8] mm/ioremap: Consider IOREMAP space in generic
 ioremap
Message-ID: <Y0u4tN+mIgNSWwdi@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
 <8c7ac4667c6a3cc48f98110117536f60d51ece4a.1665568707.git.christophe.leroy@csgroup.eu>
 <d0acd053-96d3-4e18-a9de-97987d8be14b@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0acd053-96d3-4e18-a9de-97987d8be14b@app.fastmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: COOqvuBhFrT0aQ5oJghjQs6K0kvtlIrc
X-Proofpoint-ORIG-GUID: I_E-pbeUcJZaXjF5GaDE4bOivIzTg8KG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_03,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=576 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 12, 2022 at 12:39:11PM +0200, Arnd Bergmann wrote:
> "Some" means exactly powerpc64, right? It looks like microblaze
> and powerpc32 still share some of this code, but effectively
> just use the vmalloc area once the slab allocator is up.
> 
> Is the special case still useful for powerpc64 or could this be
> changed to do it the same as everything else?

Or make it the other way around and set IOREMAP_START/IOREMAP_END
to VMALLOC_START/VMALLOC_END by default?

> 
>     Arnd
