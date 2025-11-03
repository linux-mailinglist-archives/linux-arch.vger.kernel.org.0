Return-Path: <linux-arch+bounces-14460-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E23C2A94A
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 09:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 627BF4E2D72
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59D02E03EF;
	Mon,  3 Nov 2025 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SIJzn+1B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51773277C81;
	Mon,  3 Nov 2025 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158840; cv=none; b=ir/tMIcCo5eUcWLUN7lCJTODuJq4+3qnppCCF2SXIz1HWs7GPs8eGxLfSfsypupupY/TgPUIblOFw0+jEeyz+i4qyjvrBBQWnRz/PLr96nqvq+QtJ0+gOEgvruCRCuMCYxwcgwNwpr4P7qHnooO6QK4mSkRsE4r9MnzVsf8suGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158840; c=relaxed/simple;
	bh=YWu2XM7OXAN7C4pR9dsSPVi0rznxl/ZiAMYDWxHsIlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZguvQDWaQL4vNquhxVy+43MGM8WxHAaLUbKzNWmpqcJTftUkh/eZ3ncg3Oa2+SXOQ/TjAFcll7gU16XmBPONudKFKVPb3R16ep0X0zwU4x1OOMQR245t4gO0+Wsx9NgADIvqXuiJ26UEw4sc7R4QSAG+qCfAu55qklIKSysJQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SIJzn+1B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2KFI8K004420;
	Mon, 3 Nov 2025 08:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6kvXeg
	tnHGH2dvhngivPl8vSn9VVnbxianx2ml6At6Q=; b=SIJzn+1B6W9oM2eaoy/YHg
	eBBigTFYyvOI9FqFVbAxNQBJk7OsJkIcL71Bfna6VZUkqh40c7GapUFYZ5iF8sRv
	Gr8dTXMymRtZJ8s++yexWv1ij7wo6VYhShrZhVDq41yj75ph0JeGVCKADK/YHtTq
	GX3MIMDZ/N5qqAEIbGF00Q5htF6MOC+XL4hF518BX18l+iJjxcQbmu4bDG1zmjC4
	JaRrWPwAdwUgpIOYFdxBzdZMRCWUzsW/HgM451x3+JWx1KfcwQmlDNOkYt4NhTIW
	gRD9YIaV0/uJm8zB4i1DBFMoHs18pKBmB/HXGu5E8lZ+lxXr3R2rXIwqr6iKj5Pg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xbnkvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 08:32:27 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A38WQmQ029518;
	Mon, 3 Nov 2025 08:32:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xbnkvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 08:32:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A34SfIE012891;
	Mon, 3 Nov 2025 08:32:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5y81mbvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 08:32:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A38WNYw44106174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 08:32:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C27F220040;
	Mon,  3 Nov 2025 08:32:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16F2220043;
	Mon,  3 Nov 2025 08:32:13 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Nov 2025 08:32:12 +0000 (GMT)
Message-ID: <dee4dc13-b187-42df-93ce-f738cfab32ea@linux.ibm.com>
Date: Mon, 3 Nov 2025 14:02:11 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 23/29] context-tracking: Introduce work deferral
 infrastructure
To: Valentin Schneider <vschneid@redhat.com>
Cc: Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Josh Triplett
 <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>, Han Shen <shenhan@google.com>,
        Rik van Riel <riel@surriel.com>, Jann Horn <jannh@google.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, Daniel Wagner <dwagner@suse.de>,
        Petr Tesarik <ptesarik@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rcu@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-24-vschneid@redhat.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251010153839.151763-24-vschneid@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfXyZF7uxWMbR9h
 eLK/nkDGQm3o/vMS6b4dMArF21TNJ6CaqoI+fi7VPIcu7OWjh13TfAaGOyTxh1gnwQIWiBKHjJa
 4uMwIrzLslo+qUygbHd9488ZCjL6vK5iXuiWUNX6ThTOzJBP1PKCUz5zZmvloNgyToR45jE2irN
 a4EYP7E5d99vyLe0EnPUaY+AWXCKsxBO2ENMsQJ0K7+9kC0+hwsMybY4fCkeMcwmUxF0SvKxntf
 G1Y18toiIF/maL5RFi7povbdJ4FJNPvHT8auC2LdGyFW5VpJAL0soYtskChjteGM2wfpc+kcC7y
 KDSiIb0W+R7wCTgyXcXkjXUndM3ScPyUHlasPD5janXDgGwLZxidSrdWYD0Sch6Yd3oNTOJv1+T
 flE5Wy2KQc8LqVOKJgn3Dc1iG4Hf4Q==
X-Proofpoint-GUID: U84lOeDC5Q0AhrPIqcAHknHeCkhsE8rA
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=6908689b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=e3ynTO8eh5RAdg4_BR0A:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=UhEZJTgQB8St2RibIkdl:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: Yw4-ly9gm_lGmLrDsIj0uqTuFktFQQKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021

Hi Valentin.

On 10/10/25 9:08 PM, Valentin Schneider wrote:
> smp_call_function() & friends have the unfortunate habit of sending IPIs to
> isolated, NOHZ_FULL, in-userspace CPUs, as they blindly target all online
> CPUs.
> 
> Some callsites can be bent into doing the right, such as done by commit:
> 
>    cc9e303c91f5 ("x86/cpu: Disable frequency requests via aperfmperf IPI for nohz_full CPUs")
> 
> Unfortunately, not all SMP callbacks can be omitted in this
> fashion. However, some of them only affect execution in kernelspace, which
> means they don't have to be executed *immediately* if the target CPU is in
> userspace: stashing the callback and executing it upon the next kernel entry
> would suffice. x86 kernel instruction patching or kernel TLB invalidation
> are prime examples of it.
> 
> Reduce the RCU dynticks counter width to free up some bits to be used as a
> deferred callback bitmask. Add some build-time checks to validate that
> setup.
> 
> Presence of CT_RCU_WATCHING in the ct_state prevents queuing deferred work.
> 
> Later commits introduce the bit:callback mappings.
> 
> Link: https://lore.kernel.org/all/20210929151723.162004989@infradead.org/
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>   arch/Kconfig                                 |  9 +++
>   arch/x86/Kconfig                             |  1 +
>   arch/x86/include/asm/context_tracking_work.h | 16 +++++
>   include/linux/context_tracking.h             | 21 ++++++
>   include/linux/context_tracking_state.h       | 30 ++++++---
>   include/linux/context_tracking_work.h        | 26 ++++++++
>   kernel/context_tracking.c                    | 69 +++++++++++++++++++-
>   kernel/time/Kconfig                          |  5 ++
>   8 files changed, 165 insertions(+), 12 deletions(-)
>   create mode 100644 arch/x86/include/asm/context_tracking_work.h
>   create mode 100644 include/linux/context_tracking_work.h
> 
> diff --git a/include/linux/context_tracking_work.h b/include/linux/context_tracking_work.h
> new file mode 100644
> index 0000000000000..c68245f8d77c5
> --- /dev/null
> +++ b/include/linux/context_tracking_work.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CONTEXT_TRACKING_WORK_H
> +#define _LINUX_CONTEXT_TRACKING_WORK_H
> +
> +#include <linux/bitops.h>
> +
> +enum {
> +	CT_WORK_n_OFFSET,
> +	CT_WORK_MAX_OFFSET
> +};
> +
> +enum ct_work {
> +	CT_WORK_n        = BIT(CT_WORK_n_OFFSET),
> +	CT_WORK_MAX      = BIT(CT_WORK_MAX_OFFSET)
> +};
> +
> +#include <asm/context_tracking_work.h>
> +

It fails to compile on powerpc (likey any arch other than x86)

In file included from ./include/linux/context_tracking_state.h:8,
                  from ./include/linux/hardirq.h:5,
                  from ./include/linux/interrupt.h:11,
                  from ./include/linux/kernel_stat.h:8,
                  from ./include/linux/cgroup.h:27,
                  from ./include/linux/memcontrol.h:13,
                  from ./include/linux/swap.h:9,
                  from ./include/linux/suspend.h:5,
                  from arch/powerpc/kernel/asm-offsets.c:21:
./include/linux/context_tracking_work.h:17:10: fatal error: 
asm/context_tracking_work.h: No such file or directory
    17 | #include <asm/context_tracking_work.h>
       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Gating works for compile, but no benefit of the series.

+#ifdef HAVE_CONTEXT_TRACKING_WORK
  #include <asm/context_tracking_work.h>
+#endif


I have been trying to debug/understand the issue seen with isolcpus= and
nohz_full=. system is idle, even then it occasionally woken up to do 
some work. So I was interesting if this series can help.

