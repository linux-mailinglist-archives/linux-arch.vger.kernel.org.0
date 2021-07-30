Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116243DB668
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 11:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbhG3Jvw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 05:51:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238223AbhG3Jvv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jul 2021 05:51:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16U9Wma0032673;
        Fri, 30 Jul 2021 05:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RYVrVB0Cv2/R3lfmKnDGtLWGBHS277MIQR61B43z3uM=;
 b=dGwRHMW+dV44draTp+TTntVOVZQoJjo0X1i/5LdgoAcqjM8JLU7lkDxlZoaKCMUKaNvy
 M+ZjKdhpw34/vrKYLtUjIcBj6RIwv6+gThIzOeXw63W5RhwZ8jEpeJ8lUJRSg2zz7PKT
 zOASTY1gTLrCWIjcz6bYSEGewtcDHLwf8Fzcaot81sFOXT7yz2HvFqBZo3EV+0ejZ807
 GKQxJOKRmMFhInRW8OmWGMh92ydIzQl4xBQTCE6PhqZ4pcTf9HFmQHnHKz/7RK4PlcBW
 De6pJGr9HrSc0qCw+yczs0r3u8j6/ghV1t4+xXF8c6L5aVgh19eC+7GvSO/OXLM2ZsPF Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a4e9j1cme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 05:49:24 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16U9WmsP032691;
        Fri, 30 Jul 2021 05:49:23 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a4e9j1ckr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 05:49:23 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16U9lRKT013772;
        Fri, 30 Jul 2021 09:49:21 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3a235kjwrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 09:49:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16U9kYNh23789872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 09:46:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABB9742052;
        Fri, 30 Jul 2021 09:49:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77B664203F;
        Fri, 30 Jul 2021 09:49:16 +0000 (GMT)
Received: from osiris (unknown [9.145.161.212])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 30 Jul 2021 09:49:16 +0000 (GMT)
Date:   Fri, 30 Jul 2021 11:49:15 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@infradead.org>,
        Feng Tang <feng.tang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 0/6] compat: remove compat_alloc_user_space
Message-ID: <YQPLG20V3dmOfq3a@osiris>
References: <20210727144859.4150043-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727144859.4150043-1-arnd@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zR7p1uPVJVzE85QHjW8aYnuNusoUj_ko
X-Proofpoint-GUID: cr8jFOyeRsqaNkR-GlUmXQX1PdWeweCa
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_05:2021-07-29,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=697 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300057
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 04:48:53PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Going through compat_alloc_user_space() to convert indirect system call
> arguments tends to add complexity compared to handling the native and
> compat logic in the same code.
> 
> Out of the other remaining callers, the linux-media series went into
> v5.14, and the network ioctl handling is now fixed in net-next, so
> these are the last remaining users, and I now include the final
> patch to remove the definitions as well.
> 
> Since these patches are now all that remains, it would be nice to
> merge it all through Andrew's Linux-mm tree, which is already based
> on top of linux-next.
...
> 
> Arnd Bergmann (6):
>   kexec: move locking into do_kexec_load
>   kexec: avoid compat_alloc_user_space
>   mm: simplify compat_sys_move_pages
>   mm: simplify compat numa syscalls
>   compat: remove some compat entry points
>   arch: remove compat_alloc_user_space

Our CI reports this with linux-next and running strace selftest in
compat mode:

Unable to handle kernel pointer dereference in virtual kernel address space
Failing address: 0000038003e7c000 TEID: 0000038003e7c803
Fault in home space mode while using kernel ASCE.
AS:00000001fb388007 R3:000000008021c007 S:0000000082142000 P:0000000000000400 
Oops: 0011 ilc:3 [#1] SMP 
CPU: 0 PID: 1017495 Comm: get_mempolicy Tainted: G           OE     5.14.0-20210730.rc3.git0.4ccc9e2db7ac.300.fc34.s390x+next #1
Hardware name: IBM 2827 H66 708 (LPAR)
Krnl PSW : 0704e00180000000 00000001f9f11000 (compat_put_bitmap+0x48/0xd0)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
Krnl GPRS: 0000000000810000 0000000000000000 000000007d9df1c0 0000038003e7c008
           0000000000000004 000000007d9df1c4 0000038003e7be40 0000000000010000
           0000000000008000 0000000000000000 0000000000000390 00000000000001c8
           000000020d6ea000 000002aa00401a48 00000001fa0a85fa 0000038003e7bd50
Krnl Code: 00000001f9f10ff4: a7bb0001            aghi    %r11,1
           00000001f9f10ff8: 41303008            la      %r3,8(%r3)
          #00000001f9f10ffc: 41502004            la      %r5,4(%r2)
          >00000001f9f11000: e3103ff8ff04        lg      %r1,-8(%r3)
           00000001f9f11006: 5010f0a4            st      %r1,164(%r15)
           00000001f9f1100a: a50e0081            llilh   %r0,129
           00000001f9f1100e: c8402000f0a4        mvcos   0(%r2),164(%r15),%r4
           00000001f9f11014: 1799                xr      %r9,%r9
Call Trace:
 [<00000001f9f11000>] compat_put_bitmap+0x48/0xd0 
 [<00000001fa0a85fa>] kernel_get_mempolicy+0x102/0x178 
 [<00000001fa0a86b0>] __s390_sys_get_mempolicy+0x40/0x50 
 [<00000001fa92be30>] __do_syscall+0x1c0/0x1e8 
 [<00000001fa939148>] system_call+0x78/0xa0 
Last Breaking-Event-Address:
 [<0000038003e7bc00>] 0x38003e7bc00
Kernel panic - not syncing: Fatal exception: panic_on_oops

Note: I did not try to bisect this, since it looks to me like this
patch series causes the problem. Also, please don't get confused with
the kernel version name. The date encoded is the build date, not the
linux-next version.
linux-next commit 4ccc9e2db7ac ("Add linux-next specific files for
20210729") was used to build the kernel (s390 defconfig).
