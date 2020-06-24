Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DBC2075E3
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 16:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391108AbgFXOl0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 10:41:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389836AbgFXOlZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 10:41:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05OEXFqX135508;
        Wed, 24 Jun 2020 10:40:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwyym7wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 10:40:26 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05OEXTZ2137306;
        Wed, 24 Jun 2020 10:40:26 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwyym7ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 10:40:25 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05OEbebC005715;
        Wed, 24 Jun 2020 14:40:22 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 31uusjgqb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 14:40:22 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05OEeJGu19136648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 14:40:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6EA85205A;
        Wed, 24 Jun 2020 14:40:19 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.59.63])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 16FBF52051;
        Wed, 24 Jun 2020 14:40:18 +0000 (GMT)
Date:   Wed, 24 Jun 2020 16:40:16 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        christophe.leroy@c-s.fr, ziy@nvidia.com,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH V3 0/4] mm/debug_vm_pgtable: Add some more tests
Message-ID: <20200624144015.GD24934@oc3871087118.ibm.com>
References: <1592192277-8421-1-git-send-email-anshuman.khandual@arm.com>
 <70ddc7dd-b688-b73e-642a-6363178c8cdd@arm.com>
 <20200624110539.GC24934@oc3871087118.ibm.com>
 <20200624134808.0c460862@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624134808.0c460862@thinkpad>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_08:2020-06-24,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 cotscore=-2147483648
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=870
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240106
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 01:48:08PM +0200, Gerald Schaefer wrote:
> On Wed, 24 Jun 2020 13:05:39 +0200
> Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> 
> > On Wed, Jun 24, 2020 at 08:43:10AM +0530, Anshuman Khandual wrote:
> > 
> > [...]
> > 
> > > Hello Gerald/Christophe/Vineet,
> > > 
> > > It would be really great if you could give this series a quick test
> > > on s390/ppc/arc platforms respectively. Thank you.
> > 
> > That worked for me with the default and debug s390 configurations.
> > Would you like to try with some particular options or combinations
> > of the options?
> 
> It will be enabled automatically on all archs that set
> ARCH_HAS_DEBUG_VM_PGTABLE, which we do for s390 unconditionally.
> Also, DEBUG_VM has to be set, which we have only in the debug config.
> So only the s390 debug config will have it enabled, you can check
> dmesg for "debug_vm_pgtable" to see when / where it was run, and if it
> triggered any warnings.

Yes, that is what I did ;)

I should have been more clear. I wonder whether Anshuman has in
mind other options which possibly makes sense to set or unset
and check how it goes with non-standard configurations.

> I also checked with the v3 series, and it works fine for s390.
