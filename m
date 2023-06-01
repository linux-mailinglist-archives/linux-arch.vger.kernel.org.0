Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4015E71EEA1
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 18:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjFAQUk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 12:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjFAQUk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 12:20:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B36134;
        Thu,  1 Jun 2023 09:20:35 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351G6bMx031738;
        Thu, 1 Jun 2023 16:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 message-id : date : mime-version : subject : from : to : cc : references :
 in-reply-to; s=pp1; bh=N7QO9gm4wu5Nn/qtA2XQDm3cZffLg2V3+Sbl/oRfzyo=;
 b=KoqrlIn7YAxeeWVrwx13zBkc2gPzNvCea7bz7RyMMPKu08B9fALZ9Qh62blVz3994Ref
 SEGUiKDZd5yDwylT8K+mnw9aFP9wYmC9ArzEMW3GZqMqpegeWrDo0zyeJFBYXg9pWBqp
 GtigiS/a0ZPGAd5Ho9V/Zx+Rx/E7D32VSaJOFOIlc0jy3kecX9ksaU9JchygPNNFMcIE
 aXIA4L9V8EENOC+HaOfXXUbKXr6Tz6ADF6LCPct0zOYqrO/h+VoYPwuJuWq/jeMrLLWh
 l7GrchMnqqGvceZQt2R3IE1+hyUvArR2kG1EJoRhRcTV93ksJEJZ1xfJH0znhPSJJEPD Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxxe5ghwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 16:20:05 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351G8S8t006598;
        Thu, 1 Jun 2023 16:20:05 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxxe5ghv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 16:20:04 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3513PKBI017606;
        Thu, 1 Jun 2023 16:20:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g5ameb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 16:20:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 351GK04O49480178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jun 2023 16:20:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 483F320043;
        Thu,  1 Jun 2023 16:20:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABB8C20040;
        Thu,  1 Jun 2023 16:19:59 +0000 (GMT)
Received: from [9.144.159.119] (unknown [9.144.159.119])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jun 2023 16:19:59 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------dIYNVYK7maoZ44TdG4CHztGP"
Message-ID: <6e86aedb-9349-afd4-0bcb-1949e828f997@linux.ibm.com>
Date:   Thu, 1 Jun 2023 18:19:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 8/9] powerpc: Add HOTPLUG_SMT support
Content-Language: en-US
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
References: <20230524155630.794584-1-mpe@ellerman.id.au>
 <20230524155630.794584-8-mpe@ellerman.id.au>
 <5752a488-be54-61a0-6d18-647456abc4ee@linux.ibm.com>
In-Reply-To: <5752a488-be54-61a0-6d18-647456abc4ee@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rIpV25d11zj49lEd0NBT_fe-WhZCw_GY
X-Proofpoint-ORIG-GUID: u1PM_dkPO6HPHibjMq3U6SyYLaMAsA4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a multi-part message in MIME format.
--------------dIYNVYK7maoZ44TdG4CHztGP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/06/2023 15:27:30, Laurent Dufour wrote:
> On 24/05/2023 17:56:29, Michael Ellerman wrote:
>> Add support for HOTPLUG_SMT, which enables the generic sysfs SMT support
>> files in /sys/devices/system/cpu/smt, as well as the "nosmt" boot
>> parameter.
> 
> Hi Michael,
> 
> It seems that there is now a conflict between with the PPC 'smt-enabled'
> boot option.
> 
> Booting the patched kernel with 'smt-enabled=4', later, change to the SMT
> level (for instance to 6) done through /sys/devices/system/cpu/smt/control
> are not applied. Nothing happens.
> Based on my early debug, I think the reasons is that cpu_smt_num_threads=8
> when entering __store_smt_control(). But I need to dig further.

I dug deeper.

FWIW, I think smt_enabled_at_boot should be passed to
cpu_smt_check_topology() in smp_prepare_cpus(), instead of
threads_per_core. But that's not enough to fix the issue because this value
is also used to set cpu_smt_max_threads.

To achieve that, cpu_smt_check_topology() should receive 2 parameters, the
current SMT level define at boot time, and the maximum SMT level.

The attached patch is fixing the issue on my ppc64 test LPAR.
This patch is not addressing the x86 architecture (I didn't get the time to
do it, but it should be doable) and should be spread among the patches 3
and 8 of your series.

Hope this helps.

Cheers,
Laurent.

> 
> BTW, should the 'smt-enabled' PPC specific option remain?
> 
> Cheers,
> Laurent.
> 
>> Implement the recently added hooks to allow partial SMT states, allow
>> any number of threads per core.
>>
>> Tie the config symbol to HOTPLUG_CPU, which enables it on the major
>> platforms that support SMT. If there are other platforms that want the
>> SMT support that can be tweaked in future.
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/Kconfig                |  1 +
>>  arch/powerpc/include/asm/topology.h | 25 +++++++++++++++++++++++++
>>  arch/powerpc/kernel/smp.c           |  3 +++
>>  3 files changed, 29 insertions(+)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 539d1f03ff42..5cf87ca10a9c 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -273,6 +273,7 @@ config PPC
>>  	select HAVE_SYSCALL_TRACEPOINTS
>>  	select HAVE_VIRT_CPU_ACCOUNTING
>>  	select HAVE_VIRT_CPU_ACCOUNTING_GEN
>> +	select HOTPLUG_SMT			if HOTPLUG_CPU
>>  	select HUGETLB_PAGE_SIZE_VARIABLE	if PPC_BOOK3S_64 && HUGETLB_PAGE
>>  	select IOMMU_HELPER			if PPC64
>>  	select IRQ_DOMAIN
>> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
>> index 8a4d4f4d9749..1e9117a22d14 100644
>> --- a/arch/powerpc/include/asm/topology.h
>> +++ b/arch/powerpc/include/asm/topology.h
>> @@ -143,5 +143,30 @@ static inline int cpu_to_coregroup_id(int cpu)
>>  #endif
>>  #endif
>>  
>> +#ifdef CONFIG_HOTPLUG_SMT
>> +#include <linux/cpu_smt.h>
>> +#include <asm/cputhreads.h>
>> +
>> +static inline bool topology_smt_supported(void)
>> +{
>> +	return threads_per_core > 1;
>> +}
>> +
>> +static inline bool topology_smt_threads_supported(unsigned int num_threads)
>> +{
>> +	return num_threads <= threads_per_core;
>> +}
>> +
>> +static inline bool topology_is_primary_thread(unsigned int cpu)
>> +{
>> +	return cpu == cpu_first_thread_sibling(cpu);
>> +}
>> +
>> +static inline bool topology_smt_thread_allowed(unsigned int cpu)
>> +{
>> +	return cpu_thread_in_core(cpu) < cpu_smt_num_threads;
>> +}
>> +#endif
>> +
>>  #endif /* __KERNEL__ */
>>  #endif	/* _ASM_POWERPC_TOPOLOGY_H */
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index 265801a3e94c..eed20b9253b7 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -1154,6 +1154,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>>  
>>  	if (smp_ops && smp_ops->probe)
>>  		smp_ops->probe();
>> +
>> +	// Initalise the generic SMT topology support
>> +	cpu_smt_check_topology(threads_per_core);
>>  }
>>  
>>  void smp_prepare_boot_cpu(void)
> 

--------------dIYNVYK7maoZ44TdG4CHztGP
Content-Type: text/plain; charset=UTF-8;
 name="0001-Consider-the-SMT-level-specify-at-boot-time.patch"
Content-Disposition: attachment;
 filename="0001-Consider-the-SMT-level-specify-at-boot-time.patch"
Content-Transfer-Encoding: base64

RnJvbSA2ODJlN2Q3OGZiOThkNjI5ODkyNmU4OGU1MDkzZTIxNzI0ODhlYTZmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBMYXVyZW50IER1Zm91ciA8bGR1Zm91ckBsaW51eC5p
Ym0uY29tPgpEYXRlOiBUaHUsIDEgSnVuIDIwMjMgMTg6MDI6NTUgKzAyMDAKU3ViamVjdDog
W1BBVENIXSBDb25zaWRlciB0aGUgU01UIGxldmVsIHNwZWNpZnkgYXQgYm9vdCB0aW1lCgpU
aGlzIGFsbG93cyBQUEMga2VybmVsIHRvIGJvb3Qgd2l0aCBhIFNNVCBsZXZlbCBkaWZmZXJl
bnQgZnJvbSAxIG9yIHRocmVhZHMKcGVyIGNvcmUgdmFsdWUuCgpTaWduZWQtb2ZmLWJ5OiBM
YXVyZW50IER1Zm91ciA8bGR1Zm91ckBsaW51eC5pYm0uY29tPgotLS0KIGFyY2gvcG93ZXJw
Yy9rZXJuZWwvc21wLmMgfCAyICstCiBpbmNsdWRlL2xpbnV4L2NwdV9zbXQuaCAgIHwgNiAr
KysrLS0KIGtlcm5lbC9jcHUuYyAgICAgICAgICAgICAgfCA5ICsrKysrKystLQogMyBmaWxl
cyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvc21wLmMgYi9hcmNoL3Bvd2VycGMva2VybmVsL3Nt
cC5jCmluZGV4IGVlZDIwYjkyNTNiNy4uZWM4Y2NmM2Q2Mjk0IDEwMDY0NAotLS0gYS9hcmNo
L3Bvd2VycGMva2VybmVsL3NtcC5jCisrKyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvc21wLmMK
QEAgLTExNTYsNyArMTE1Niw3IEBAIHZvaWQgX19pbml0IHNtcF9wcmVwYXJlX2NwdXModW5z
aWduZWQgaW50IG1heF9jcHVzKQogCQlzbXBfb3BzLT5wcm9iZSgpOwogCiAJLy8gSW5pdGFs
aXNlIHRoZSBnZW5lcmljIFNNVCB0b3BvbG9neSBzdXBwb3J0Ci0JY3B1X3NtdF9jaGVja190
b3BvbG9neSh0aHJlYWRzX3Blcl9jb3JlKTsKKwljcHVfc210X2NoZWNrX3RvcG9sb2d5KHNt
dF9lbmFibGVkX2F0X2Jvb3QsIHRocmVhZHNfcGVyX2NvcmUpOwogfQogCiB2b2lkIHNtcF9w
cmVwYXJlX2Jvb3RfY3B1KHZvaWQpCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NwdV9z
bXQuaCBiL2luY2x1ZGUvbGludXgvY3B1X3NtdC5oCmluZGV4IDhkNGFlMjYwNDdjOS4uYjVm
MTNhY2IzMjNmIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2NwdV9zbXQuaAorKysgYi9p
bmNsdWRlL2xpbnV4L2NwdV9zbXQuaApAQCAtMTQsNyArMTQsOCBAQCBlbnVtIGNwdWhwX3Nt
dF9jb250cm9sIHsKIGV4dGVybiBlbnVtIGNwdWhwX3NtdF9jb250cm9sIGNwdV9zbXRfY29u
dHJvbDsKIGV4dGVybiB1bnNpZ25lZCBpbnQgY3B1X3NtdF9udW1fdGhyZWFkczsKIGV4dGVy
biB2b2lkIGNwdV9zbXRfZGlzYWJsZShib29sIGZvcmNlKTsKLWV4dGVybiB2b2lkIGNwdV9z
bXRfY2hlY2tfdG9wb2xvZ3kodW5zaWduZWQgaW50IG51bV90aHJlYWRzKTsKK2V4dGVybiB2
b2lkIGNwdV9zbXRfY2hlY2tfdG9wb2xvZ3kodW5zaWduZWQgaW50IG51bV90aHJlYWRzLAor
CQkJCSAgIHVuc2lnbmVkIGludCBtYXhfdGhyZWFkcyk7CiBleHRlcm4gYm9vbCBjcHVfc210
X3Bvc3NpYmxlKHZvaWQpOwogZXh0ZXJuIGludCBjcHVocF9zbXRfZW5hYmxlKHZvaWQpOwog
ZXh0ZXJuIGludCBjcHVocF9zbXRfZGlzYWJsZShlbnVtIGNwdWhwX3NtdF9jb250cm9sIGN0
cmx2YWwpOwpAQCAtMjIsNyArMjMsOCBAQCBleHRlcm4gaW50IGNwdWhwX3NtdF9kaXNhYmxl
KGVudW0gY3B1aHBfc210X2NvbnRyb2wgY3RybHZhbCk7CiAjIGRlZmluZSBjcHVfc210X2Nv
bnRyb2wJCShDUFVfU01UX05PVF9JTVBMRU1FTlRFRCkKICMgZGVmaW5lIGNwdV9zbXRfbnVt
X3RocmVhZHMgMQogc3RhdGljIGlubGluZSB2b2lkIGNwdV9zbXRfZGlzYWJsZShib29sIGZv
cmNlKSB7IH0KLXN0YXRpYyBpbmxpbmUgdm9pZCBjcHVfc210X2NoZWNrX3RvcG9sb2d5KHVu
c2lnbmVkIGludCBudW1fdGhyZWFkcykgeyB9CitzdGF0aWMgaW5saW5lIHZvaWQgY3B1X3Nt
dF9jaGVja190b3BvbG9neSh1bnNpZ25lZCBpbnQgbnVtX3RocmVhZHMsCisJCQkJCSAgdW5z
aWduZWQgaW50IG1heF90aHJlYWRzKSB7IH0KIHN0YXRpYyBpbmxpbmUgYm9vbCBjcHVfc210
X3Bvc3NpYmxlKHZvaWQpIHsgcmV0dXJuIGZhbHNlOyB9CiBzdGF0aWMgaW5saW5lIGludCBj
cHVocF9zbXRfZW5hYmxlKHZvaWQpIHsgcmV0dXJuIDA7IH0KIHN0YXRpYyBpbmxpbmUgaW50
IGNwdWhwX3NtdF9kaXNhYmxlKGVudW0gY3B1aHBfc210X2NvbnRyb2wgY3RybHZhbCkgeyBy
ZXR1cm4gMDsgfQpkaWZmIC0tZ2l0IGEva2VybmVsL2NwdS5jIGIva2VybmVsL2NwdS5jCmlu
ZGV4IGFjYTIzYzdiNDU0Ny4uMjY4ZDM4NmJkNGU3IDEwMDY0NAotLS0gYS9rZXJuZWwvY3B1
LmMKKysrIGIva2VybmVsL2NwdS5jCkBAIC00MzUsMTIgKzQzNSwxNyBAQCB2b2lkIF9faW5p
dCBjcHVfc210X2Rpc2FibGUoYm9vbCBmb3JjZSkKICAqIFRoZSBkZWNpc2lvbiB3aGV0aGVy
IFNNVCBpcyBzdXBwb3J0ZWQgY2FuIG9ubHkgYmUgZG9uZSBhZnRlciB0aGUgZnVsbAogICog
Q1BVIGlkZW50aWZpY2F0aW9uLiBDYWxsZWQgZnJvbSBhcmNoaXRlY3R1cmUgY29kZS4KICAq
Lwotdm9pZCBfX2luaXQgY3B1X3NtdF9jaGVja190b3BvbG9neSh1bnNpZ25lZCBpbnQgbnVt
X3RocmVhZHMpCit2b2lkIF9faW5pdCBjcHVfc210X2NoZWNrX3RvcG9sb2d5KHVuc2lnbmVk
IGludCBudW1fdGhyZWFkcywKKwkJCQkgICB1bnNpZ25lZCBpbnQgbWF4X3RocmVhZHMpCiB7
CiAJaWYgKCF0b3BvbG9neV9zbXRfc3VwcG9ydGVkKCkpCiAJCWNwdV9zbXRfY29udHJvbCA9
IENQVV9TTVRfTk9UX1NVUFBPUlRFRDsKIAotCWNwdV9zbXRfbWF4X3RocmVhZHMgPSBudW1f
dGhyZWFkczsKKwljcHVfc210X21heF90aHJlYWRzID0gbWF4X3RocmVhZHM7CisKKwlXQVJO
X09OKG51bV90aHJlYWRzID4gbWF4X3RocmVhZHMpOworCWlmIChudW1fdGhyZWFkcyA+IG1h
eF90aHJlYWRzKQorCQludW1fdGhyZWFkcyA9IG1heF90aHJlYWRzOwogCiAJLy8gTWF5IGFs
cmVhZHkgYmUgZGlzYWJsZWQgYnkgbm9zbXQgY29tbWFuZCBsaW5lIHBhcmFtZXRlcgogCWlm
IChjcHVfc210X2NvbnRyb2wgIT0gQ1BVX1NNVF9FTkFCTEVEKQotLSAKMi40MC4xCgo=

--------------dIYNVYK7maoZ44TdG4CHztGP--

