Return-Path: <linux-arch+bounces-9965-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49FCA255E2
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 10:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6E43A8A69
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7811DD9D1;
	Mon,  3 Feb 2025 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sc7OrPzM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B777E107;
	Mon,  3 Feb 2025 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575061; cv=none; b=t8d++jMs7MmlA+aAKOnPWWpHjsNP87x3rbADNMrd1Smh3oeujH4ANynNcF4KTqAE0hVXhiSci4J0RwccXtnSglJsaLcRMNQiqmhG5jN5gio1dMzrY8A4hzWeYi5jxsxDSYlupGj7aH1ticCFaFa3x5kTn2GIcH23scELgTjM/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575061; c=relaxed/simple;
	bh=EXgeldZ4Kuji/SVlAFtvKiLgZ9sXXhNmORGolm7IKCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8M4SD84G0RhydghopYAodIfRfEHdGs61Bv3r9sGePvpzaNFo0sdGRX3JVMt33DNqGoL46FxGZx4RLm4RUoHBJjuUJKfIy52jB5T5HH8r7AlHl9AquCUZOrIGV6AZKAo7DvWiF8019KrK7paZ7F7bLude52WbmtxrFEOBAKOHzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sc7OrPzM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51320bgd006146;
	Mon, 3 Feb 2025 09:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=HOOVTMKGmYfDs61vIKKu/2n6mo1Uqh
	rzh3Nw0X9R5us=; b=sc7OrPzM94Qro1TPoi9WldL23dl8EhUQA0uUcOii03fm/0
	ZWjWgFI+dUHnyykPX4KurBljs5VF0FTUDOZVPKQ0Nic1W5aixU4tXgMwUo9Ej4Sp
	IhX2kpJQptytYHQ7XzYAy9RoZviZkDVVyjToIShTjmSz3tGfHU97EQ/GMBty3KDe
	U7Y/o3wrR/8Po81HWdFM8acEVLigG7jG/rrAvF0q3j95Qgp65mDoim4AyXlTi4+s
	JSs5sBEVEVSX1pC6uB3pEJ+UczNnVeDbO13pZiffvHI9SIwAVPdnyEwhgbJoiLlY
	rEhklncisvpySSfLHaTqfnQztgOZ+zZlXlJpmmmA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jmmy9m6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 09:29:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5136tpND016288;
	Mon, 3 Feb 2025 09:29:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hwxs5syv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 09:29:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5139Th5c21955204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 09:29:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F9EF200D4;
	Mon,  3 Feb 2025 09:29:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A882200D3;
	Mon,  3 Feb 2025 09:29:39 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.20.74])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  3 Feb 2025 09:29:39 +0000 (GMT)
Date: Mon, 3 Feb 2025 10:29:37 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <legion@kernel.org>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Eugene Syromyatnikov <evgsyr@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>, Renzo Davoli <renzo@cs.unibo.it>,
        Davide Berardi <berardi.dav@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <shuah@kernel.org>, strace-devel@lists.strace.io,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v4 0/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO API
Message-ID: <Z6CMgVm8QKEMRf8L@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250203065849.GA14120@strace.io>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203065849.GA14120@strace.io>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tAr2MtM5PWIBRxaWi6Br0hi8CNE4am_9
X-Proofpoint-ORIG-GUID: tAr2MtM5PWIBRxaWi6Br0hi8CNE4am_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=836 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030071

On Mon, Feb 03, 2025 at 08:58:49AM +0200, Dmitry V. Levin wrote:

Hi Dmitry,

> PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
> PTRACE_GET_SYSCALL_INFO by letting the ptracer modify details of
> system calls the tracee is blocked in.
...

FWIW, I am getting these on s390:

# ./tools/testing/selftests/ptrace/set_syscall_info 
TAP version 13
1..1
# Starting 1 tests from 1 test cases.
#  RUN           global.set_syscall_info ...
# set_syscall_info.c:87:set_syscall_info:Expected exp_entry->nr (-1) == info->entry.nr (65535)
# set_syscall_info.c:88:set_syscall_info:wait #3: PTRACE_GET_SYSCALL_INFO #2: syscall nr mismatch
# set_syscall_info: Test terminated by assertion
#          FAIL  global.set_syscall_info
not ok 1 global.set_syscall_info
# FAILED: 0 / 1 tests passed.
# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

I remember one of the earlier versions (v1 or v2) was working for me.

Thanks!

