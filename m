Return-Path: <linux-arch+bounces-12347-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF37AD9CCA
	for <lists+linux-arch@lfdr.de>; Sat, 14 Jun 2025 15:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5D1177D0F
	for <lists+linux-arch@lfdr.de>; Sat, 14 Jun 2025 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DAA2D12E4;
	Sat, 14 Jun 2025 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HfOEjmIA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038317588;
	Sat, 14 Jun 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749906000; cv=none; b=L3F6ltViV3ZYe1N16E8AdIrwH2/juGpEU0TtLIJDbNDnIDvhJrMcWHc5XwTwXDHgl3EjMIR4M3gyj5g+8daZpRZxIH9+G9V0nyZsYcPce+9oG02ug6U/idcS1Or/IN8ThC7UXRsG2MaMGxqqO7SM49OMRCmkEBsN+WLdmP5yEiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749906000; c=relaxed/simple;
	bh=bU0MedFB52BY7L1hpPvsdnUO6hl4CaChlDG2T/zlm2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ6mbTbYwaxBffnft8jQn3Bmhv/J9Y7KED3wLmUeaJUKJYp0AnC4kXbP0Q09gCvPi1moHV7btASGCQaY64VZENcNI1qpkY2Nm6cIVklWC1nUXZimIrbavOqTJPLDp2dEPjYQhEWnnuWAm+6s4fz8QxJks44avyCCzlIluyy12Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HfOEjmIA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55EASOqZ013764;
	Sat, 14 Jun 2025 12:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GWf9Q8fhQIaK2IkjdJfjOiEYmA7IMx
	s/QoLebp9mL84=; b=HfOEjmIABRPfZRM5N68UxC93NaUpOnZuFMdKHk7oL3/8/v
	MEYbngBORYsLrxpKAV1Xd66apdLIWuxMX7P02e9oDJ/7He8jki3MILn40BAHpmcm
	QBvpiDoDfl2iQCNeVn7fWH9oS5a+65FaYln0d8oQAZTgNKkoPr+PTSaeBwxGIlGX
	X+5FI3i6a4Pa1sNg+9tYytF987xboS+24DHeCchFh4LhznrWke+haxhbA68lRoYV
	p+OolePLs4vLc2654GR1VL33+c0hCEtqLrVenzSG4aq3kJhP2jFqSFJQPgCdEc5S
	1gyBRDHqkZsZjN9feEXyKYe6H2VQoKf7+5Q34czg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygmssfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Jun 2025 12:59:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55E7j8dQ015006;
	Sat, 14 Jun 2025 12:59:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rpprqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Jun 2025 12:59:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55ECxd9q17367540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Jun 2025 12:59:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DC2A20043;
	Sat, 14 Jun 2025 12:59:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AAA420040;
	Sat, 14 Jun 2025 12:59:38 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.143.160])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 14 Jun 2025 12:59:38 +0000 (GMT)
Date: Sat, 14 Jun 2025 14:59:36 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] lib/crc: improve how arch-optimized code is
 integrated
Message-ID: <aE1yOG2JhS86XsrK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250607200454.73587-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607200454.73587-1-ebiggers@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE0MDEwNyBTYWx0ZWRfX/gPO7RlVoHIq H3zfnrZ9eeNrf1eNS+pQ7Q+72lGui2nOL/FAAW3VH367zdi2lxWx2zCUw4/9+LPZ5ySP5B8gVBB BTxtRduhv73wv65mkAIr/Cd0zpNyfEXVO/UKXhUZIlsw1JOSkK3klGpVP70ojFxXrlmXy8Pm8Ci
 fLa/ScaQZWnpdG8VK+ILf4YcLOPNr9Q2oMIGqCxM0D1RXBeOAvP1UgOeMal0Gm9FATsENBOTOnQ zA8EssuGDPn/O87HU7ArmLEIL4EK0eYH9XNiW/Ifv1aGzDgFh5Tdh+cYcoVd2O2JrS7SXTtQ4Zs N0pj3VnbilN/6ECoCV/zklRcgrjwh85j5Tl2OrwWpNeTegUWbK8Ck2da7OADC7W6OZO23vWv5JV
 EvdxAyj+GdEOusaEWkZvk/HhuHFYj6TZ698WtgsSTAlLaJPRavGiQUR9nMbxADwS7TJ9VjaS
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=684d723e cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=CxYdweyBhWEn_dVdmv8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: MOyPwlTHSYAIS_-mVBTJ8AD1_k4DNQqq
X-Proofpoint-GUID: MOyPwlTHSYAIS_-mVBTJ8AD1_k4DNQqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-14_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=422 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506140107

On Sat, Jun 07, 2025 at 01:04:42PM -0700, Eric Biggers wrote:

Hi Eric,

> This series is also available at:
> 
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git lib-crc-arch-v2
...

I tried git://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crc-next

With s390 debug_defconfig It causes this:

alg: hash: skipping comparison tests for crc32c-s390 because crc32c-generic is unavailable

No other alg complains. Is it expected?

Thanks!


