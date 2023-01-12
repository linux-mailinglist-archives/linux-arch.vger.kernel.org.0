Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD246670CA
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jan 2023 12:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjALLYO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 06:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbjALLXi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 06:23:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D73564C1;
        Thu, 12 Jan 2023 03:14:12 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CB64Ag029275;
        Thu, 12 Jan 2023 11:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2CpYJJvffSxR/qx+Z65ONIz3u9DGwI+Pun3NTqeU50s=;
 b=GM/bPcLAswwBR0dcOm1np18HrXvcmRRsnSIYZINj7Hjr9dGc+amviX7pQzztaVTQkVpn
 WHR6aqbmdpb8csCgYMta/l7eUZ6T2s86uOm6+Tm82ncF6x8cy5MbeFQnf2V4/qxf9Xc6
 O43GKnCeC0dTTIE4rIFOPTRqfeeFkCN0l3vtDu39S0rsJqJHPcNZFKdLi81wBJQ5+1/s
 JOMx3E9CQxnKrWf1nGD1jqfnFhHqd65i9ymBIn30hbez0BTr3GvjttlT8sFICGdJIw0S
 34w9zxub3HL9y5w/0I6cm/Xfwdgq6QFfiFuXQlz9J9767Ahuw2R8M7rooM86Oyi/fLvm 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2h1pr67c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 11:13:01 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30CB6ibV031123;
        Thu, 12 Jan 2023 11:13:00 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2h1pr669-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 11:13:00 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30BHPFmv031030;
        Thu, 12 Jan 2023 11:12:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n1kyx9p83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 11:12:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CBCr7C22937980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 11:12:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A17CB20043;
        Thu, 12 Jan 2023 11:12:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DBF720040;
        Thu, 12 Jan 2023 11:12:50 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.13.23])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 12 Jan 2023 11:12:50 +0000 (GMT)
Date:   Thu, 12 Jan 2023 12:12:48 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 08/12] s390: Replace cmpxchg_double() with
 cmpxchg128()
Message-ID: <Y7/rMJ75lW7z9PAb@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.352918965@infradead.org>
 <Y70SWXHDmOc3RhMd@osiris>
 <Y70it59wuvsnKJK1@hirez.programming.kicks-ass.net>
 <Y71QJBhNTIatvxUT@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y71QJBhNTIatvxUT@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hrmaJ6_faD8RHCW_pvcyE-JA-vnPIVMq
X-Proofpoint-GUID: KLt4Oe9V1h3Xoju5iqVMXGihur9SkCzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_06,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=898 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1011 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 10, 2023 at 12:46:44PM +0100, Heiko Carstens wrote:
> > > +	/* READ_ONCE() 16 byte header */
> > > +	prev.val = __cdsg(&te->header.val, 0, 0);
> > >  	do {
> > > +		old.val = prev.val;
> > > +		new.val = prev.val;
> > > +		*overflow = old.overflow;

I guess, it would also make sense to place write to overflow 
after the while loop. So the output variable left intact in
case the function bailed out. Not sure if it should be part
of this patch though.

> > > +		if (old.f) {
> > >  			/*
> > >  			 * SDB is already set by hardware.
> > >  			 * Abort and try to set somewhere
> > > @@ -1490,10 +1509,10 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
> > >  			 */
> > >  			return false;
> > >  		}
> > > +		new.a = 1;
> > > +		new.overflow = 0;
> > > +		prev.val = __cdsg(&te->header.val, old.val, new.val);
> > > +	} while (prev.val != old.val);
> > 
> > And while this case has an early exit, it only cares about a single bit
> > (although you made it a full word) and so also shouldn't care. If
> > aux_reset_buffer() returns false, @overflow isn't consumed.
> 
> Yes, except that it is anything but obvious that @overflow isn't consumed.
