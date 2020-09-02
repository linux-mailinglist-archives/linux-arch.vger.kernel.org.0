Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F725AC61
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgIBNxe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 09:53:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727776AbgIBNx3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Sep 2020 09:53:29 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082D32D5082651;
        Wed, 2 Sep 2020 09:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=AWgBI/YrhXkEmm+Qf+fcD6e36zb+RyfY/AO6JpSkQRw=;
 b=U4YUbjRSaR+rCFG6DWCiDZuk/wIngA6teRubXBrZBoevSyZ37Id/JCC/4T+/x231ms86
 WBDJ/aeSIJyMMb8xMqjKERxGsqRJGY9BUj5xhqSL1PbAEcTpOR1DVj0MkHj7Y8wTiPgz
 FMj9ge2U8MROOxRqpC3qVNMupp4wulx0D5sEQbOJsiMohAtOj2PBXVWzwMgCQX0pji7I
 psezDLC67scKFixndTBhlh60moFAktujDfbFpkNnpDrGExDpDuaaNpKuR9qkmAWGPBxb
 LdXwpJxaKGw65RET5iW9/3yJWvItzSwGqxteRGuR4rE8LGz4ANiPc1WjMogHo5XURh7R jg== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33ab64j3qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 09:20:19 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 082DDB6F025854;
        Wed, 2 Sep 2020 13:20:19 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 337en9g3df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 13:20:19 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 082DKI7d56099310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 13:20:19 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5777124052;
        Wed,  2 Sep 2020 13:20:17 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2426B124053;
        Wed,  2 Sep 2020 13:20:13 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.61.124])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 13:20:12 +0000 (GMT)
X-Mailer: emacs 27.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3 12/13] mm/debug_vm_pgtable/hugetlb: Disable hugetlb
 test on ppc64
In-Reply-To: <a76a180b-650c-c868-7a52-593afe97eab3@arm.com>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-13-aneesh.kumar@linux.ibm.com>
 <6191e77f-c3b7-21ea-6dbd-eecc09735923@arm.com>
 <68f90b44-b830-58be-3c21-424fee05da37@linux.ibm.com>
 <a76a180b-650c-c868-7a52-593afe97eab3@arm.com>
Date:   Wed, 02 Sep 2020 18:50:09 +0530
Message-ID: <873640e2nq.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_09:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020118
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> On 09/01/2020 12:00 PM, Aneesh Kumar K.V wrote:
>> On 9/1/20 9:33 AM, Anshuman Khandual wrote:
>>>
>>>
>>> On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
>>>> The seems to be missing quite a lot of details w.r.t allocating
>>>> the correct pgtable_t page (huge_pte_alloc()), holding the right
>>>> lock (huge_pte_lock()) etc. The vma used is also not a hugetlb VMA.
>>>>
>>>> ppc64 do have runtime checks within CONFIG_DEBUG_VM for most of these.
>>>> Hence disable the test on ppc64.
>>>
>>> Would really like this to get resolved in an uniform and better way
>>> instead, i.e a modified hugetlb_advanced_tests() which works on all
>>> platforms including ppc64.
>>>
>>> In absence of a modified version, I do realize the situation here,
>>> where DEBUG_VM_PGTABLE test either runs on ppc64 or just completely
>>> remove hugetlb_advanced_tests() from other platforms as well.
>>>
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> ---
>>>> =C2=A0 mm/debug_vm_pgtable.c | 4 ++++
>>>> =C2=A0 1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>>> index a188b6e4e37e..21329c7d672f 100644
>>>> --- a/mm/debug_vm_pgtable.c
>>>> +++ b/mm/debug_vm_pgtable.c
>>>> @@ -813,6 +813,7 @@ static void __init hugetlb_basic_tests(unsigned lo=
ng pfn, pgprot_t prot)
>>>> =C2=A0 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>>>> =C2=A0 }
>>>> =C2=A0 +#ifndef CONFIG_PPC_BOOK3S_64
>>>> =C2=A0 static void __init hugetlb_advanced_tests(struct mm_struct *mm,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t vm_area_struct *vma,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pte_t=
 *ptep, unsigned long pfn,
>>>> @@ -855,6 +856,7 @@ static void __init hugetlb_advanced_tests(struct m=
m_struct *mm,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pte =3D huge_ptep_get(ptep);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(!(huge_pte_write(pte) && huge_p=
te_dirty(pte)));
>>>> =C2=A0 }
>>>> +#endif
>>>
>>> In the worst case if we could not get a new hugetlb_advanced_tests() te=
st
>>> that works on all platforms, this might be the last fallback option. In
>>> which case, it will require a proper comment section with a "FIXME: ",
>>> explaining the current situation (and that #ifdef is temporary in natur=
e)
>>> and a hugetlb_advanced_tests() stub when CONFIG_PPC_BOOK3S_64 is enable=
d.
>>>
>>>> =C2=A0 #else=C2=A0 /* !CONFIG_HUGETLB_PAGE */
>>>> =C2=A0 static void __init hugetlb_basic_tests(unsigned long pfn, pgpro=
t_t prot) { }
>>>> =C2=A0 static void __init hugetlb_advanced_tests(struct mm_struct *mm,
>>>> @@ -1065,7 +1067,9 @@ static int __init debug_vm_pgtable(void)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pud_populate_tests(mm, pudp, saved_pmdp=
);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(ptl);
>>>> =C2=A0 +#ifndef CONFIG_PPC_BOOK3S_64
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hugetlb_advanced_tests(mm, vma, ptep, p=
te_aligned, vaddr, prot);
>>>> +#endif
>>>
>>=20
>> I actually wanted to add #ifdef BROKEN. That test is completely broken. =
Infact I would suggest to remove that test completely.
>>=20
>>=20
>>=20
>>> #ifdef will not be required here as there would be a stub definition
>>> for hugetlb_advanced_tests() when CONFIG_PPC_BOOK3S_64 is enabled.
>>>
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&mm->page_table_lock);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p4d_clear_tests(mm, p4dp);
>>>>
>>>
>>> But again, we should really try and avoid taking this path.
>>>
>>=20
>> To be frank i am kind of frustrated with how this patch series is being =
looked at. We pushed a completely broken test to upstream and right now we =
have a code in upstream that crash when booted on ppc64. My attempt has bee=
n to make progress here and you definitely seems to be not in agreement to =
that.
>>=20
>
> I am afraid, this does not accurately represent the situation.
>
> - The second set patch series got merged in it's V5 after accommodating a=
lmost
>   all reviews and objections during previous discussion cycles. For a com=
plete
>   development log, please refer https://patchwork.kernel.org/cover/116586=
27/.
>
> - The series has been repeatedly tested on arm64 and x86 platforms for mu=
ltiple
>   configurations but build tested on all other enabled platforms. I have =
always
>   been dependent on voluntary help from folks on the list to get this tes=
ted on
>   other enabled platforms as I dont have access to such systems. Always a=
ssumed
>   that is the way to go for anything which runs on multiple platforms. So=
, am I
>   expected to test on platforms that I dont have access to ? But I am rea=
dy to
>   be corrected here, if the community protocol is not what I have always =
assumed
>   it to be.
>
> - Each and every version of the series had appropriately copied all the e=
nabled
>   platform's mailing list. Also, I had explicitly asked for volunteers to=
 test
>   this out on platforms apart from x86 and arm64. We had positive respons=
e from
>   all platforms i.e arc, s390, ppc32 but except for ppc64.
>
>   https://patchwork.kernel.org/cover/11644771/
>   https://patchwork.kernel.org/cover/11603713/
>
> - The development cycle provided sufficient time window for any detailed =
review
>   and test. I have always been willing to address almost all the issues b=
rought
>   forward during these discussions. From past experience on this test, th=
ere is
>   an inherent need to understand platform specific details while trying t=
o come
>   up with something generic enough that works on all platforms. It necess=
itates
>   participation from relevant folks to enable this test on a given platfo=
rm. We
>   were able to enable this on arm64, x86, arc, s390, powerpc following a =
similar
>   model.
>
> - I have to disagree here that the concerned test i.e hugetlb_advanced_te=
sts()
>   is completely broken. As mentioned before, the idea here has always bee=
n to
>   emulate enough MM objects, so that a given page table helper could be t=
ested.
>   hugetlb_advanced_tests() seems to be insufficient on ppc64 platform cau=
sing it
>   to crash, which is not the case on other platforms. But it is not perfe=
ct and
>   can be improved upon. Given the constraints i.e limited emulation of ob=
jects,
>   the test tries to do the right thing. Calling it broken is not an appro=
priate
>   description.
>


None of the fixes done here are specific to ppc64. I am not sure why you
keep suggesting ppc64 specific issues. One should not do page table
updates without holding locks. A hugetlb pte updates expect a vma marked
hugetlb.

As explained in the patch, I see very little value in a bunch of tests
like this and the only reason I started to fix this up is because of
multiple crash reports on ppc64.

Considering the hugetlb tests require much larger change and as it is
currently written is broken, I wanted to remove that test and let you
come up with a proper test. But since you had it "working", I disabled
this only on ppc64.

But you keep suggesting that the hugetlb test need to be fixed as part
of the patch series review. I don't have enough motivation to fix that,
because I don't see much value in a bunch of tests like these. As shown
already these tests already reported success till now without even
following any page table update rules.

-aneesh
