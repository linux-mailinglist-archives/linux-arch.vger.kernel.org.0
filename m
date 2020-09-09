Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B85D262D12
	for <lists+linux-arch@lfdr.de>; Wed,  9 Sep 2020 12:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgIIK2T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 06:28:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729251AbgIIK1z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2020 06:27:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089A2ZCv195896;
        Wed, 9 Sep 2020 06:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=YEpZ1XyTfdUWIVWwW3Ff4Nf6q12vIx7sVHOKBnj6u8g=;
 b=RrZs/nyXQlGRttvQhgHGbvKfOEZGoDCilws/V+4CwBDa44UhPDRAaxyY3jjivUF5MXjG
 /UTt3JbpYT1z3iOXfBkMc33Sr+MyuWVhywIJ5++70gLu30j1DNFnGFTkYTOsBvbHh+ZN
 0wCqUQanHg1LW8vapxWNSBS+1HIuPCcCbB2vPLvrdHu3UbJXE/8r9zioC+W9NHh/C8aU
 +oHiIpos0DStadvKQ2TywX3i+81CE0v2IS3MUWD/JbzFVMdPjqSGiO1y8eUZndBYtDEm
 9PCrsfziZ8+CtnCa06ouY37h/5vB9ImP2vPO2tbvtt/5te/dVS7V2qaIXjfXbyRq2Mp+ Uw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33evv38y7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 06:27:07 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089ADJ3t012978;
        Wed, 9 Sep 2020 10:27:06 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 33cebutt38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 10:27:06 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089AR6iG60686618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 10:27:06 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF3336E050;
        Wed,  9 Sep 2020 10:27:05 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E60D6E04E;
        Wed,  9 Sep 2020 10:27:01 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.93.29])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 10:27:00 +0000 (GMT)
X-Mailer: emacs 27.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>, linux-arch@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        linuxppc-dev@lists.ozlabs.org,
        Russell King <linux@armlinux.org.uk>,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Flushing transparent hugepages
In-Reply-To: <20200818150736.GQ17456@casper.infradead.org>
References: <20200818150736.GQ17456@casper.infradead.org>
Date:   Wed, 09 Sep 2020 15:56:58 +0530
Message-ID: <87tuw74559.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_03:2020-09-08,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=521 adultscore=0
 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090085
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> PowerPC has special handling of hugetlbfs pages.  Well, that's what
> the config option says, but actually it handles THP as well.  If
> the config option is enabled.
>
> #ifdef CONFIG_HUGETLB_PAGE
>         if (PageCompound(page)) {
>                 flush_dcache_icache_hugepage(page);
>                 return;
>         }
> #endif

I do have a change posted sometime back to avoid that confusion.
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200320103256.229365-1-aneesh.kumar@linux.ibm.com/

But IIUC we use the head page flags (PG_arch_1) to track whether we need
the flush or not.

>
> By the way, THPs can be mapped askew -- that is, at an offset which
> means you can't use a PMD to map a PMD sized page.
>
> Anyway, we don't really have consensus between the various architectures
> on how to handle either THPs or hugetlb pages.  It's not contemplated
> in Documentation/core-api/cachetlb.rst so there's no real surprise
> we've diverged.
>
> What would you _like_ to see?  Would you rather flush_dcache_page()
> were called once for each subpage, or would you rather maintain
> the page-needs-flushing state once per compound page?  We could also
> introduce flush_dcache_thp() if some architectures would prefer it one
> way and one the other, although that brings into question what to do
> for hugetlbfs pages.
>
> It might not be a bad idea to centralise the handling of all this stuff
> somewhere.  Sounds like the kind of thing Arnd would like to do ;-) I'll
> settle for getting enough clear feedback about what the various arch
> maintainers want that I can write a documentation update for cachetlb.rst.
