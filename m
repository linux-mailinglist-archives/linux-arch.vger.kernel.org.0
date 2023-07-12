Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59637501C6
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jul 2023 10:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGLIi0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jul 2023 04:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjGLIhr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jul 2023 04:37:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33E01FCB;
        Wed, 12 Jul 2023 01:36:02 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C8H6W5005418;
        Wed, 12 Jul 2023 08:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=4wWvmE6riY6W/gEOwFAliD2QEWEyS8lb/MuEGAJ1j5o=;
 b=W8wCk4xvkQn1//6F4lTivAknvJaZrparsug2om/MrAq7Cig1Q22gMS8yTPhnlhyk54bx
 rgO2PKLcJqRTO3ieRQzqcYyrZ15pQ+Pga9oA4OwuLJY+gTla14D3F0sFhj9bxPr5rFR1
 +ikqwVe9ESkWm+4UrIZA9FXPZgm9wCEpDtEICqOUPrAErFZDoLxxFSZEc29iyV0c6c14
 iIVWmi1vHOeqCayZIcm/4gMDqHccOGB1Ey5Ao4/h80/FLo102QRKrlFCb7+5+nJnQHcI
 FA9eHzbdDKpOaXH902yyT8qtYqF0YUkJJe15gJW2MxiGt98trsu4xg0rlIvHCKNX2BDz Vw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsrh80fb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:35:51 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36C6akB3008911;
        Wed, 12 Jul 2023 08:35:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rpye59u22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:35:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36C8ZkP727067074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 08:35:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB8222004D;
        Wed, 12 Jul 2023 08:35:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A122E2004B;
        Wed, 12 Jul 2023 08:35:45 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jul 2023 08:35:45 +0000 (GMT)
Date:   Wed, 12 Jul 2023 10:35:43 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v5 00/38] New page table range API
Message-ID: <20230712103543.4304235c@p-imbrenda>
In-Reply-To: <ZK46Mb0jAtCxFma2@casper.infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
        <8cfc3eef-e387-88e1-1006-2d7d97a09213@linux.ibm.com>
        <ZK1My5hQYC2Kb6G1@casper.infradead.org>
        <20230711172440.77504856@p-imbrenda>
        <ZK46Mb0jAtCxFma2@casper.infradead.org>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BaW4a-jtxRC0PTUlpLFwd8HG0wdDW65g
X-Proofpoint-ORIG-GUID: BaW4a-jtxRC0PTUlpLFwd8HG0wdDW65g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=937
 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 12 Jul 2023 06:29:21 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Jul 11, 2023 at 05:24:40PM +0200, Claudio Imbrenda wrote:
> > On Tue, 11 Jul 2023 13:36:27 +0100
> > Matthew Wilcox <willy@infradead.org> wrote:  
> > > > I think we do use PG_arch_1 on s390 for our secure page handling and
> > > > making this perf folio instead of physical page really seems wrong
> > > > and it probably breaks this code.    
> > > 
> > > Per-page flags are going away in the next few years, so you're going to  
> > 
> > For each 4k physical page frame, we need to keep track whether it is
> > secure or not.  
> 
> Do you?  Wouldn't it make more sense to track that per allocation instead

no

> of per page?  ie if we allocate a 16kB anon folio for a VMA, don't you
> want the entire folio to be marked as secure vs insecure?

if we allocate a 16k folio, it would actually be initially marked as
non-secure until the guest touches any of it, then only those 4k pages
that are needed get marked as secure.

the guest can also share the pages with the host, in which case the
individual 4k pages get marked as non-secure once I/O is attempted on
them (e.g. direct I/O)

userspace (i.e. QEMU) can also try to look into the guest, causing
individual pages to be exported (securely encrypted and then marked as
non-secure) if they were secure and not shared.

I/O cannot trigger exports, it will just fail, and that should not
happen because in some cases it can bring down the whole system. Which
is one of the main reasons why we need to keep track of the state.

> 
> I don't really know what secure means in this context.  I think it has
> something to do with which of the VM or the hypervisor can access it, but
> it feels like something new that I've never had properly explained to me.

Secure means it belongs to a secure guest (confidential VM,
protected virtualisation, Secure Execution, there are many names...).

Hardware will prevent the host (or any other entity except for the
secure guest itself) from accessing those 4k physical page frames,
regardless of how the host might try. An exception will be presented
for any attempts.

I/O will not trigger any exception, and will instead just fail.

I hope this explains why we need to track the property for each 4k
physical page frame.

> 
> > A bit in struct page seems the most logical choice. If that's not
> > possible anymore, how would you propose we should do?  
> 
> The plan is to shrink struct page down to a single pointer (which

interesting

> includes a few tag bits to say what type that pointer is -- a page
> table, anon mem, file mem, slab, etc).  So there won't be any bits
> available for something like "secure or not".  You could use a side
> structure if you really need to keep track on a per page basis.

I guess that's something we will need to work on
