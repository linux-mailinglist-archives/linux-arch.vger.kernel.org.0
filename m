Return-Path: <linux-arch+bounces-11494-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B45A9662C
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 12:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C7F177487
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179461F30CC;
	Tue, 22 Apr 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KCWe+JyP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F61F1524;
	Tue, 22 Apr 2025 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318508; cv=none; b=T6KyMFhgt/2IHXmsgoxXTTmeOAQo0gD6jganz/QlESPsFkp6uBj2OmPjAQ6MrG4tDSwm9wkgDOsY05fX+tV7sROJKMGcayiz+TL7LtzTE39uBx5f58AcytT27yYdHaPe6YLvtNXoHvcO9Y3FRZbHxu+IutQoCpCGunb8pK4Z2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318508; c=relaxed/simple;
	bh=Tb7CAAVaZb99w9X2yjvkO7xrdg4wj9xMhOXa2cnmjQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBL8ExOLB+jlS0BgRBJLExO+vBRU7DUaJbonP9hIFiYiIn7r7aAgbHsB8GqjHTgMcrES0relnEfnDQHYyoeyOSv4wfpu17YdAYnKfCcSycp4F4TH3RMtT1dQqcnW3Tn/GvS3jmAmCS0BeffQW6P4s5abeH+VMWi9zY5W+netk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KCWe+JyP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M87Pmb014494;
	Tue, 22 Apr 2025 10:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2vBVjmEn5NTa769mIj8GmdhBQLhe0x
	76SUXx/x1ydTU=; b=KCWe+JyPXZxPGEeoK+BOdCrNbtsxJb4V9z9BQcp5BUBqYV
	37VU8eW6wcULQQ+47XX+foEl2LJOpLzDYicKyXGMbmxSsxY/RjYRpPLwU4gd3xgo
	ogftcFUpG4M5EExmKa9VSwegOZZCOthSnTL5tZzw/QsNni+y3b8rifq7WaNGiCQj
	j+1TNRLnCGFaeE7g7IFvUokadm9sHdkM1DTa5ZNw8G70CZ6275/qaUa7U1Maq/WW
	0YeViG35vFRhe3g8H8uT8aYQmfUlyhrkgc3/p524PO1EQhqkXTZkl6383xOstWCu
	KymJAGFH+gNa/NTzBcefpqMr3IQs8YYjNit6pTwg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4667ap0qvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 10:41:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M7afmQ015373;
	Tue, 22 Apr 2025 10:41:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464qnkjbg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 10:41:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53MAfbYl59376010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 10:41:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39AF620043;
	Tue, 22 Apr 2025 10:41:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8204220040;
	Tue, 22 Apr 2025 10:41:36 +0000 (GMT)
Received: from osiris (unknown [9.87.146.239])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Apr 2025 10:41:36 +0000 (GMT)
Date: Tue, 22 Apr 2025 12:41:35 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        x86@kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 10/13] crypto: s390 - move library functions to
 arch/s390/lib/crypto/
Message-ID: <20250422104135.24507Bb1-hca@linux.ibm.com>
References: <20250420192609.295075-1-ebiggers@kernel.org>
 <20250420192609.295075-11-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420192609.295075-11-ebiggers@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5pNKzws c=1 sm=1 tr=0 ts=68077264 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=EBXGqsIhDzg0S2J9wWsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: FKpmuf9m7FggGnatUI-UByB2a5PrqXcD
X-Proofpoint-GUID: FKpmuf9m7FggGnatUI-UByB2a5PrqXcD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxlogscore=709
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220079

On Sun, Apr 20, 2025 at 12:26:06PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Continue disentangling the crypto library functions from the generic
> crypto infrastructure by moving the s390 ChaCha library functions into a
> new directory arch/s390/lib/crypto/ that does not depend on CRYPTO.
> This mirrors the distinction between crypto/ and lib/crypto/.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/s390/crypto/Kconfig                 | 6 ------
>  arch/s390/crypto/Makefile                | 3 ---
>  arch/s390/lib/Makefile                   | 1 +
>  arch/s390/lib/crypto/Kconfig             | 7 +++++++
>  arch/s390/lib/crypto/Makefile            | 4 ++++
>  arch/s390/{ => lib}/crypto/chacha-glue.c | 0
>  arch/s390/{ => lib}/crypto/chacha-s390.S | 0
>  arch/s390/{ => lib}/crypto/chacha-s390.h | 0
>  lib/crypto/Kconfig                       | 3 +++
>  9 files changed, 15 insertions(+), 9 deletions(-)
>  create mode 100644 arch/s390/lib/crypto/Kconfig
>  create mode 100644 arch/s390/lib/crypto/Makefile
>  rename arch/s390/{ => lib}/crypto/chacha-glue.c (100%)
>  rename arch/s390/{ => lib}/crypto/chacha-s390.S (100%)
>  rename arch/s390/{ => lib}/crypto/chacha-s390.h (100%)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

