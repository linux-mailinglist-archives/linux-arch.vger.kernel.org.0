Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D688D663F72
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 12:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjAJLrx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Jan 2023 06:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjAJLrp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2023 06:47:45 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ED4544FD;
        Tue, 10 Jan 2023 03:47:42 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A9pBo5007510;
        Tue, 10 Jan 2023 11:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=qn2LabxLnZEZFumVZ5Olz/OuzFaySPNNAkYo8mYfUpw=;
 b=PnKNZxhj6QPF0ilZTvhqmWw+my6urQsEbvko3vN5eyn/jt3mkpMhmz8CydyvT6vf59ZV
 TKtOtCGXEmsMWgqOpGs4ZXt4Y3SxGiv+kPS094QW+PK6E+u+qeIOe4Vphnb5vUPoLlsQ
 WPokeXfqXwZ3HTPDNTXqn0atT+4Rf+efA63+fA+0mcGJF+LSxw0opdTXcnpRMGD9+0cb
 k9wMZLaw4lHCxrJge1FY1dHkkKXu/xBUgNWhFKec1kOmPReKhPqcpns8F+AoTL5oRTM3
 LJvvfxeG2xwiMpDIz8Dmjk6Jn6tw/wsNbiVVIr67VyGVz0l2LuBcK4gj7jkd8SA3UpMW 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n15rk2gya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 11:46:56 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30AB8oju011043;
        Tue, 10 Jan 2023 11:46:55 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n15rk2gxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 11:46:54 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30A87hem024723;
        Tue, 10 Jan 2023 11:46:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3my0c6mrqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 11:46:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30ABkmUh17891888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 11:46:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CBAB20043;
        Tue, 10 Jan 2023 11:46:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E1C220040;
        Tue, 10 Jan 2023 11:46:46 +0000 (GMT)
Received: from osiris (unknown [9.152.212.250])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 10 Jan 2023 11:46:46 +0000 (GMT)
Date:   Tue, 10 Jan 2023 12:46:44 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        joro@8bytes.org, suravee.suthikulpanit@amd.com,
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
Message-ID: <Y71QJBhNTIatvxUT@osiris>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.352918965@infradead.org>
 <Y70SWXHDmOc3RhMd@osiris>
 <Y70it59wuvsnKJK1@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y70it59wuvsnKJK1@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pKIWmY9vx2HMOPSHFVupmbYl3bdIjBZF
X-Proofpoint-GUID: UQEdaMsBDjpJCHJbGYQKtf47xWETq6SH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_03,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxlogscore=942 priorityscore=1501 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 10, 2023 at 09:32:55AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 10, 2023 at 08:23:05AM +0100, Heiko Carstens wrote:
> > So, Alexander Gordeev reported that this code was already prior to your
> > changes potentially broken with respect to missing READ_ONCE() within the
> > cmpxchg_double() loops.
> 
> Unless there's an early exit, that shouldn't matter. If you managed to
> read garbage the cmpxchg itself will simply fail and the loop retries.
> 
> > @@ -1294,12 +1306,16 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
> >  		num_sdb++;
> >  
> >  		/* Reset trailer (using compare-double-and-swap) */
> > +		/* READ_ONCE() 16 byte header */
> > +		prev.val = __cdsg(&te->header.val, 0, 0);
> >  		do {
> > +			old.val = prev.val;
> > +			new.val = prev.val;
> > +			new.f = 0;
> > +			new.a = 1;
> > +			new.overflow = 0;
> > +			prev.val = __cdsg(&te->header.val, old.val, new.val);
> > +		} while (prev.val != old.val);
> 
> So this, and
...
> this case are just silly and expensive. If that initial read is split
> and manages to read gibberish the cmpxchg will fail and we retry anyway.

While I do agree that there is no need to necessarily read the whole 16
bytes atomically in advance here, there is still the problem about the
missing initial READ_ONCE() in the original code.
As I tried to outline here:

    For example:
    
            /* Reset trailer (using compare-double-and-swap) */
            do {
                    te_flags = te->flags & ~SDB_TE_BUFFER_FULL_MASK;
                    te_flags |= SDB_TE_ALERT_REQ_MASK;
            } while (!cmpxchg_double(&te->flags, &te->overflow,
                     te->flags, te->overflow,
                     te_flags, 0ULL));
    
    The compiler could generate code where te->flags used within the
    cmpxchg_double() call may be refetched from memory and which is not
    necessarily identical to the previous read version which was used to
    generate te_flags. Which in turn means that an incorrect update could
    happen.

Is there anything that prevents te->flags from being read several times?

> > +	/* READ_ONCE() 16 byte header */
> > +	prev.val = __cdsg(&te->header.val, 0, 0);
> >  	do {
> > +		old.val = prev.val;
> > +		new.val = prev.val;
> > +		*overflow = old.overflow;
> > +		if (old.f) {
> >  			/*
> >  			 * SDB is already set by hardware.
> >  			 * Abort and try to set somewhere
> > @@ -1490,10 +1509,10 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
> >  			 */
> >  			return false;
> >  		}
> > +		new.a = 1;
> > +		new.overflow = 0;
> > +		prev.val = __cdsg(&te->header.val, old.val, new.val);
> > +	} while (prev.val != old.val);
> 
> And while this case has an early exit, it only cares about a single bit
> (although you made it a full word) and so also shouldn't care. If
> aux_reset_buffer() returns false, @overflow isn't consumed.

Yes, except that it is anything but obvious that @overflow isn't consumed.

> So I really don't see the point of this patch.

As stated above: READ_ONCE() is missing. And while at it I wanted to have a
consistent complete previous value - also considering that cdsg is not very
expensive.
And while it also reuse the returned values from cdsg, instead of throwing
them away and reading from memory again in a splitted and potentially
inconsistent way.
