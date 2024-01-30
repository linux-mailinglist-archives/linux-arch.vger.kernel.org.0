Return-Path: <linux-arch+bounces-1840-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C9A8420ED
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 11:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6A41C276DA
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F87E6089A;
	Tue, 30 Jan 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aTLvInhO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF80C6089B;
	Tue, 30 Jan 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609683; cv=none; b=FlKVzI8T3yY45ONBHEbPslHkaYPsxes+orGWnLXT6GoQ2ViDy6zC+fihfluSIrZytZpooI0mIzmU8nj3jUJ1yBz3RujKrnAZriMyyiL9PEB80x+0f1EqOLx+IOxCm76MI4OvUBypOd3Y5f9NtirKFdvS3aUNvq6SyBNzFlim1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609683; c=relaxed/simple;
	bh=4OenpZVY4dbk5nXvN+goEJzBtcGnmrWCa+AaSJWh1NA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZfHUdpJKY+Qvhnl0QemOZyRxl5af3NpxlMg5FD9Y5wPuKDhtUp6TVK63M1M11MAumdyYgI5bcIrIvzZ9XSvu0sKkY0g/lFrJH6Wuu8TLtnLTFwIRobnc2Ye90yM9gp7XMe1UxbHoBnrF9zmBO1xG49QKFNC98a0brVkzgwPeSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aTLvInhO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UA9WOL004459;
	Tue, 30 Jan 2024 10:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=upER89UEQid8jme3NrL4nYMZx1b2Ukd4Ox1S4tv0K6E=;
 b=aTLvInhOgDFtWo+hahWtXRW09lRICEdOe3b6Q91S9mNs/doIfakYKAP0nELHZTabo3Xg
 emX1+QOw8fLbkvWGYH1yxzvaV8W6LTEfZPvgpYGm9wDsoakTbsfI5RY7ar2PCYMBSOPq
 m3eyJCkFL1IA8GOsm9jgpa3/xVeFB3E20CbVwqmKV9WZkAds106b3Cof77cRTc2banBx
 1+isQ3N2tZrLrNX7J20FGlaR0GskVO5Q734Ry6t2XXfx3PjB0jAHNhiIxbqGRkxohIa6
 KhvS9S/a9P+JocfuHX+35v9aXyKGeuTW0ba+qYmYiHaKe8alZWRIUFWeXpOFlSPTMg9y SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxy40g1q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 10:12:07 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40UAAtYa007474;
	Tue, 30 Jan 2024 10:12:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxy40g1pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 10:12:06 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40U7Z93l007979;
	Tue, 30 Jan 2024 10:12:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnkwxkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 10:12:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40UAC20W12386846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 10:12:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33E5D20065;
	Tue, 30 Jan 2024 10:12:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 652AC2005A;
	Tue, 30 Jan 2024 10:12:01 +0000 (GMT)
Received: from [9.179.18.183] (unknown [9.179.18.183])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jan 2024 10:12:01 +0000 (GMT)
Message-ID: <eacbf3b3-b004-4086-8db1-82e75407bbaa@linux.ibm.com>
Date: Tue, 30 Jan 2024 11:12:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Several tst-robust* tests time out with recent Linux kernel
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Cc: "xry111@xry111.site" <xry111@xry111.site>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "andrealmeid@igalia.com" <andrealmeid@igalia.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <4bda9f2e06512e375e045f9e72edb205104af19c.camel@xry111.site>
 <d69d50445284a5e0d98a64862877c1e6ec22a9a8.camel@xry111.site>
 <20231114153100.GY8262@noisy.programming.kicks-ass.net>
 <20231114154017.GI4779@noisy.programming.kicks-ass.net>
 <87ttpowajb.fsf@oldenburg.str.redhat.com>
 <20231114201402.GA25315@noisy.programming.kicks-ass.net>
 <822f3a867e5661ce61cea075a00ce04a4e4733f3.camel@intel.com>
 <20231115085102.GY3818@noisy.programming.kicks-ass.net>
 <564119521b61b5a38f9bdfe6c7a41fcbb07049c9.camel@intel.com>
 <158f6a47727a40c163e3fa6041a24388549c68f2.camel@intel.com>
 <fc3fd07a-218d-406c-918b-e7f701968eb0@linux.ibm.com>
 <eeb6d178dff61dfebf5a3ce9675486a3271b748c.camel@intel.com>
From: Stefan Liebler <stli@linux.ibm.com>
In-Reply-To: <eeb6d178dff61dfebf5a3ce9675486a3271b748c.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zAaT6FhW-QCX8Kl-edW71T0vd8GHnCfD
X-Proofpoint-GUID: QnaFMkxqxQUKrl7I6Cwi0p6BjCr660eX
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300074

On 29.01.24 23:23, Edgecombe, Rick P wrote:
> On Fri, 2024-01-19 at 14:56 +0100, Stefan Liebler wrote:
>> I've reduced the test (see attachement) and now have only one process
>> with three threads.
> 
> This tests fails on my setup as well:
> main: start 3 threads.
> #0: started: fct=1
> #1: started: fct=1
> #2: started: fct=1
> #2: mutex_timedlock failed with 22 (round=28772)
> 
> But, after this patch:
> https://lore.kernel.org/all/20240116130810.ji1YCxpg@linutronix.de/
> 
> ...the attached test hangs.
> 
> However, the glibc test that was failing for me "nptl/tst-robustpi8"
> passes with the linked patch applied. So I think that patch fixes the
> issue I hit.
> 
> What is passing supposed to look like on the attached test?

kernel commit "futex: Prevent the reuse of stale pi_state"
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/patch/?id=e626cb02ee8399fd42c415e542d031d185783903

fixes the issue on s390x.

With this commit, the test runs to the end:
main: start 3 threads.
#0: started: fct=1
#1: started: fct=1
#2: started: fct=1
#2: REACHED round 100000000. => exit
#0: REACHED round 100000000. => exit
#1: REACHED round 100000000. => exit
main: end.

If you want you can reduce the number of rounds by compiling with
-DROUNDS=XYZ or manually adjusting the ROUNDS macro define.

