Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAD93B5BF2
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 12:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhF1KFF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 06:05:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232664AbhF1KFE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Jun 2021 06:05:04 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S9Ws1F114753;
        Mon, 28 Jun 2021 06:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=kyL2mVIJzs+HDFn1txhBWQuxASTtAL4NK+sQHR9/M6w=;
 b=nlhmKcLJUCCyLIB4qbT56v44PyBoB93JSwEOFbliY1ABdDDC2qQiEBobAN7uVXxWVpG5
 fAN+9TL1iFKJ8OcMRrCgsisK9a2F9eUT6cHPoH61tR0IY62g8uQe4VrhkNlfK2W6vMEC
 rWgCkWNt6CgrAjmAjQaShlrvFizPefYxUtARNDx3sfZWy1JYIknD7gMqnvnisEYAOaDl
 NzjUV7hFWg0CfClwn2aeVwqO3IFcrcYQZZwlSg7i7RQ5AMzP4jBNLdyUtM8Zx8UwnjDa
 NFpBKv1Wp4mtyIbeRkVhYVtSw7aiHu2gzXuQNL9TLaKwineHuHP7XrwuOKQWNMHt1idD 4g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39f9m34saf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 06:02:32 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SA2TwB008458;
        Mon, 28 Jun 2021 10:02:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 39duv8gq80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 10:02:29 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SA2QUG22020388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 10:02:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BE9411CC68;
        Mon, 28 Jun 2021 10:02:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5550E11CC4A;
        Mon, 28 Jun 2021 10:02:24 +0000 (GMT)
Received: from osiris (unknown [9.145.26.242])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 28 Jun 2021 10:02:24 +0000 (GMT)
Date:   Mon, 28 Jun 2021 12:02:22 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 7/9] s390: kprobes: Use is_kernel() helper
Message-ID: <YNmeLhfWf3Rs6yRA@osiris>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
 <20210626073439.150586-8-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626073439.150586-8-wangkefeng.wang@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8I-ro_vE4lHJmKJVPRaA2OAWE_TQiwbE
X-Proofpoint-GUID: 8I-ro_vE4lHJmKJVPRaA2OAWE_TQiwbE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_07:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 mlxlogscore=770 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106280066
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 26, 2021 at 03:34:37PM +0800, Kefeng Wang wrote:
> Use is_kernel() helper instead of is_kernel_addr().
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/s390/kernel/kprobes.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
...
> -static inline int is_kernel_addr(void *addr)
> -{
> -	return addr < (void *)_end;
> -}
> -
>  static int s390_get_insn_slot(struct kprobe *p)
>  {
>  	/*
> @@ -105,7 +100,7 @@ static int s390_get_insn_slot(struct kprobe *p)
>  	 * field can be patched and executed within the insn slot.
>  	 */
>  	p->ainsn.insn = NULL;
> -	if (is_kernel_addr(p->addr))
> +	if (is_kernel(p->addr))
>  		p->ainsn.insn = get_s390_insn_slot();
>  	else if (is_module_addr(p->addr))
>  		p->ainsn.insn = get_insn_slot();
> @@ -117,7 +112,7 @@ static void s390_free_insn_slot(struct kprobe *p)
>  {
>  	if (!p->ainsn.insn)
>  		return;
> -	if (is_kernel_addr(p->addr))
> +	if (is_kernel(p->addr))
>  		free_s390_insn_slot(p->ainsn.insn, 0);
>  	else
>  		free_insn_slot(p->ainsn.insn, 0);

Given that this makes sense its own, and I can't follow the discussion
of the patch series due to missing cc, I applied this to the s390 tree
- and also fixed up the missing unsigned long casts.

Thanks!
