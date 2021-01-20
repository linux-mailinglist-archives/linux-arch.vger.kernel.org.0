Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8609D2FD67F
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 18:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733213AbhATRGr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 12:06:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18512 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391721AbhATRF7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Jan 2021 12:05:59 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10KH3chO166879;
        Wed, 20 Jan 2021 12:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Y3eJ+LbSttmlYz4ZO1ee7ygVAqStsaWU4Vmqu3XmfNg=;
 b=AhmkSBXjM3YRWEGnGRUaD5RDO6Vouw8SqbD7xaXFONjqmxfjFwlAMpPjj961BJ1QVy99
 PRWi/wxm08PH4lzN4bwxwETm+y2830IuRaPqPvJNc3+xrw4u8tO8973upN+clClAM1CI
 HeExxB+aasd/Swrr1d+ICpmHyT04RucypFaNd1Jw2dLWmTuAx/arHodzcXfsGkkj+7xj
 g7KeRyG9WmFZMPeZ/uSlHgRGgacRmiA452KDXJnfP1AAWEL6bFUsf2XkiCLZGhGs5Jgt
 2Q3RMtWI/W3EOa3i7A1cvhWIg25JHo5g1NYV0ADSiHkygY0GYtQ/FsbRt2F3QGHzfnhA bw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 366qewt418-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 12:04:48 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10KGwLQn028348;
        Wed, 20 Jan 2021 17:04:28 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3668p4geja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 17:04:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10KH4QJe42467682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 17:04:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECC51AE051;
        Wed, 20 Jan 2021 17:04:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EB4EAE04D;
        Wed, 20 Jan 2021 17:04:25 +0000 (GMT)
Received: from [9.145.21.215] (unknown [9.145.21.215])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jan 2021 17:04:25 +0000 (GMT)
Subject: Re: [PATCH v2] init/gcov: allow CONFIG_CONSTRUCTORS on UML to fix
 module gcov
To:     Johannes Berg <johannes@sipsolutions.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-um@lists.infradead.org
References: <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>
 <20210120172041.c246a2cac2fb.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <ee3bc3bf-9582-d278-5b7a-d9fa27b17800@linux.ibm.com>
Date:   Wed, 20 Jan 2021 18:04:25 +0100
MIME-Version: 1.0
In-Reply-To: <20210120172041.c246a2cac2fb.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_10:2021-01-20,2021-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200098
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 20.01.2021 17:20, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> On ARCH=um, loading a module doesn't result in its constructors
> getting called, which breaks module gcov since the debugfs files
> are never registered. On the other hand, in-kernel constructors
> have already been called by the dynamic linker, so we can't call
> them again.
> 
> Get out of this conundrum by allowing CONFIG_CONSTRUCTORS to be
> selected, but avoiding the in-kernel constructor calls.
> 
> Also remove the "if !UML" from GCOV selecting CONSTRUCTORS now,
> since we really do want CONSTRUCTORS, just not kernel binary
> ones.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Looks good+nicer than v1 to me!

I also tested this patch on s390 and can confirm that it doesn't break
gcov-kernel there.

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Andrew, do we need additional reviews/sign-offs? Could this go in via
your tree?

> ---
> Tested with a kernel configured with CONFIG_GCOV_KERNEL, without
> the patch nothing ever appears in /sys/kernel/debug/gcov/ (apart
> from the reset file), and with it we get the files and they work.

Just to be sure: could you confirm that this test statement for UML also
applies to v2, i.e. that it fixes the original problem you were seeing?

> 
> v2:
>  * special-case UML instead of splitting the CONSTRUCTORS config
> ---
>  init/Kconfig        | 1 -
>  init/main.c         | 8 +++++++-
>  kernel/gcov/Kconfig | 2 +-
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index b77c60f8b963..29ad68325028 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -76,7 +76,6 @@ config CC_HAS_ASM_INLINE
>  
>  config CONSTRUCTORS
>  	bool
> -	depends on !UML
>  
>  config IRQ_WORK
>  	bool
> diff --git a/init/main.c b/init/main.c
> index c68d784376ca..a626e78dbf06 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1066,7 +1066,13 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  /* Call all constructor functions linked into the kernel. */
>  static void __init do_ctors(void)
>  {
> -#ifdef CONFIG_CONSTRUCTORS
> +/*
> + * For UML, the constructors have already been called by the
> + * normal setup code as it's just a normal ELF binary, so we
> + * cannot do it again - but we do need CONFIG_CONSTRUCTORS
> + * even on UML for modules.
> + */
> +#if defined(CONFIG_CONSTRUCTORS) && !defined(CONFIG_UML)
>  	ctor_fn_t *fn = (ctor_fn_t *) __ctors_start;
>  
>  	for (; fn < (ctor_fn_t *) __ctors_end; fn++)
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index 3110c77230c7..f62de2dea8a3 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -4,7 +4,7 @@ menu "GCOV-based kernel profiling"
>  config GCOV_KERNEL
>  	bool "Enable gcov-based kernel profiling"
>  	depends on DEBUG_FS
> -	select CONSTRUCTORS if !UML
> +	select CONSTRUCTORS
>  	default n
>  	help
>  	This option enables gcov-based code profiling (e.g. for code coverage
> 


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
