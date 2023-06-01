Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C691B719D31
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjFANTn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 09:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjFANTn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 09:19:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F002B97;
        Thu,  1 Jun 2023 06:19:41 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351DDSRk018568;
        Thu, 1 Jun 2023 13:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tTBWxMHAGeJlpPAzqjw4yCDaupaYk6+WOuZ0r7RHXlQ=;
 b=S/K5bR2wzWD8jF0s2LtK3vF/J1ec5Pw9lqbPdCL6ZXZARzxk77m6XthOAVrzcENBYS/e
 ov9SEtmnnKsZTXa99Jk5hlMimhCPtmwo+YCJttdvMRkZI8Kj3tec3MJCAkANML7vJgEN
 mm82HHoVVpteTT1109f2h3OEi5Dtya1+qWK/izBLKcrhp4adRtqmgRrMH7o6BtITpGsV
 XQajjlwcskrHiNYJ0m2IzKlfajqLyEOsVlAvnpMojNTW61NI6Y/l6FXM9CcrwKrRoiRU
 5yYyiViugHG/GJk6Dj84G7GFPGbzxZudOaESQkF8/B03VEx03rqx3lIPkJn/GXcV7VmA dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxv1b0a39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 13:19:09 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351DFUru001084;
        Thu, 1 Jun 2023 13:19:09 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxv1b0a25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 13:19:08 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 351Ac6ca009714;
        Thu, 1 Jun 2023 13:19:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3qu9g5a49c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 13:19:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 351DJ3fS23134818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jun 2023 13:19:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 330772004F;
        Thu,  1 Jun 2023 13:19:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D8E420040;
        Thu,  1 Jun 2023 13:19:02 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.152.212.238])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jun 2023 13:19:02 +0000 (GMT)
Date:   Thu, 1 Jun 2023 15:19:00 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v3 03/34] s390: Use pt_frag_refcount for pagetables
Message-ID: <20230601151900.6f184e8c@thinkpad-T15>
In-Reply-To: <20230531213032.25338-4-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
        <20230531213032.25338-4-vishal.moola@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NZnx_8FojkhNAEEWitWpik8jaNZSNqYi
X-Proofpoint-GUID: URInLnYnsG8BZV2VGVY1OnfgESTv3EvD
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=692
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

 On Wed, 31 May 2023 14:30:01 -0700
"Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:

> s390 currently uses _refcount to identify fragmented page tables.
> The page table struct already has a member pt_frag_refcount used by
> powerpc, so have s390 use that instead of the _refcount field as well.
> This improves the safety for _refcount and the page table tracking.
> 
> This also allows us to simplify the tracking since we can once again use
> the lower byte of pt_frag_refcount instead of the upper byte of _refcount.

This would conflict with s390 impact of pte_free_defer() work from Hugh Dickins
https://lore.kernel.org/lkml/35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com/
https://lore.kernel.org/lkml/6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com/

There he uses pt_frag_refcount, or rather pt_mm in the same union, to save
the mm_struct for deferred pte_free().

I still need to look closer into both of your patch series, but so far it
seems that you have no hard functional requirement to switch from _refcount
to pt_frag_refcount here, for s390.

If this is correct, and you do not e.g. need this to make some other use
of _refcount, I would suggest to drop this patch.
