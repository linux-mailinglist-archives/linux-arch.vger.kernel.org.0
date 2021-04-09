Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1644C35A079
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 16:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhDIOAR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 10:00:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233009AbhDIOAM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2021 10:00:12 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139DXFvl006445;
        Fri, 9 Apr 2021 09:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XFFEfKJkqI0cblOf5FwUUYuSIdgH8aHKQzvMyAmhhbs=;
 b=YOm89OMV9N+/shncIstSmpxga+5iljrX8Ix2EYSSMjdh/N79U6FE/uO9Unvp9ljpK2Lj
 6p+dRmZKuML5QY1mCNajg6Fd02zXQKHGrW56l3DFTSQtBAhq8Cot1EPdhSit9D4YajJ7
 k8q/MxgpYkEd1nje2Ga0BC+aQuz+8blD9zo+TpiNIlu6+FmrwSCLPoD4CbWzO8PFQ6HF
 tUrTx/JCvWlyweo984LTgIrQJTAbXlIUcgM31ZGOvP1zBZMMLnnDh7ZJZcoWFbVqbnRz
 GWCGFdjRH5e09hZL9ydno+clvDNW9QHfqmsh5kOU5pwzKBkcUPNq8ZlTvpsD63BssfWM WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37tqpj17yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 09:59:48 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 139DXH0V006635;
        Fri, 9 Apr 2021 09:59:47 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37tqpj17y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 09:59:47 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 139DrgsL011946;
        Fri, 9 Apr 2021 13:59:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 37t3h8gu2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 13:59:45 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 139DxMwF32506338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 13:59:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 961E45204E;
        Fri,  9 Apr 2021 13:59:43 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.82.136])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 76E0852051;
        Fri,  9 Apr 2021 13:59:42 +0000 (GMT)
Date:   Fri, 9 Apr 2021 16:59:40 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alex Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: Re: [PATCH v7] RISC-V: enable XIP
Message-ID: <YHBdzPsHantT9r8t@linux.ibm.com>
References: <20210409065115.11054-1-alex@ghiti.fr>
 <3500f3cb-b660-5bbc-ae8d-0c9770e4a573@ghiti.fr>
 <be575094-badf-bac7-1629-36808ca530cc@redhat.com>
 <c4e78916-7e4c-76db-47f6-4dda3f09c871@ghiti.fr>
 <YHBEsDuEvPAnL8Vb@linux.ibm.com>
 <e7e87306-bb04-2d4f-7e7f-aabd40dccb3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e87306-bb04-2d4f-7e7f-aabd40dccb3b@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p0Y_zNbmBtgimotIB8cP0gNNYdSw6IOG
X-Proofpoint-ORIG-GUID: tyMgkQAFlemVP5BNFX_swMNENNfT-rn8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_05:2021-04-09,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090101
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 09, 2021 at 02:46:17PM +0200, David Hildenbrand wrote:
> > > > Also, will that memory properly be exposed in the resource tree as
> > > > System RAM (e.g., /proc/iomem) ? Otherwise some things (/proc/kcore)
> > > > won't work as expected - the kernel won't be included in a dump.
> > Do we really need a XIP kernel to included in kdump?
> > And does not it sound weird to expose flash as System RAM in /proc/iomem? ;-)
> 
> See my other mail, maybe we actually want something different.
> 
> > 
> > > I have just checked and it does not appear in /proc/iomem.
> > > 
> > > Ok your conclusion would be to have struct page, I'm going to implement this
> > > version then using memblock as you described.
> > 
> > I'm not sure this is required. With XIP kernel text never gets into RAM, so
> > it does not seem to require struct page.
> > 
> > XIP by definition has some limitations relatively to "normal" operation,
> > so lack of kdump could be one of them.
> 
> I agree.
> 
> > 
> > I might be wrong, but IMHO, artificially creating a memory map for part of
> > flash would cause more problems in the long run.
> 
> Can you elaborate?

Nothing particular, just a gut feeling. Usually, when you force something
it comes out the wrong way later.
 
> > 
> > BTW, how does XIP account the kernel text on other architectures that
> > implement it?
> 
> Interesting point, I thought XIP would be something new on RISC-V (well, at
> least to me :) ). If that concept exists already, we better mimic what
> existing implementations do.

I had quick glance at ARM, it seems that kernel text does not have memory
map and does not show up in System RAM.

-- 
Sincerely yours,
Mike.
