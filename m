Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD48429DC32
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 01:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390728AbgJ2AWN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Oct 2020 20:22:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1415 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388929AbgJ1WiG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Oct 2020 18:38:06 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f99be410000>; Wed, 28 Oct 2020 11:53:53 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 18:53:44 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 18:53:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcFPQ+Lu8NRGsc0hU3VO841M6CUgCNfePBWPOyr7Mu/ITaRg2qLdcBVDaBoutJ+MJi+YnWPhqsLNdgqM6x3VTBPBmw45KJSnqz8+wchby8vCzGUm+0F/K4IswCk0mqK2Hsg9bQcGF0cxc8Uu2nCpLe6qKBZ0qwsEll/Nci5LiAn62B7M4avwENduf3soVOTritN5icZ7Jvcb+cozk1Uj4oIHOtFRxwij20ALkyvzNw1dc14FHEMqSmYkG4ONHobLPcl+UQOn8VVMvA2oartzz8E+/PLvirZERbw2ExSyNuUsjV8dkrA5Ajg/nIPuGkdKSCocxGssNS1iaOYOEcX3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjnFmVRHDs222kZEwa4GZhPlUPzdcatFGZwVKM3UH1Y=;
 b=aIEJI9uCEee88f8BU0RUGu7nWdd4BSPP0LFdsbBZ9ib94UrfDpsqSzuQea2A/2vQ+KNZf61BLe3m8v3vd7wG453WyzYz/3oSPC89IyluEnDBlHleBqFaiZyQScRUKzWO7YkH565z2vDjDa2mCwtysSVVjarxPk+vwpsOSMf5By/C1UY1SZUw3zH+hthoFvKkaYWh9eo4pCnVBicrf8DVYRTL3pH6rF1h362uuXGWd3D+lJ+mK2GBxD49luzoB28vqU4lCYSYP68BH/IZrQr6w8jokg+RdEwaWcn4EE1S4SURejyK3YOHVtdQkRc9JKvXksfCa6Wr7xHbL3yS/JYsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1659.namprd12.prod.outlook.com (2603:10b6:4:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 28 Oct
 2020 18:53:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 18:53:42 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Tom Lendacky" <thomas.lendacky@amd.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Dave Young" <dyoung@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        <kasan-dev@googlegroups.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <kvm@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Larry Woodman <lwoodman@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        =?utf-8?b?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Toshimitsu Kani <toshi.kani@hpe.com>
Subject: [PATCH rc] mm: always have io_remap_pfn_range() set pgprot_decrypted()
Date:   Wed, 28 Oct 2020 15:53:40 -0300
Message-ID: <0-v1-025d64bdf6c4+e-amd_sme_fix_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:208:23b::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:208:23b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 28 Oct 2020 18:53:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXqZo-00Aqpy-KK; Wed, 28 Oct 2020 15:53:40 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603911233; bh=yzNe+Ngjn17ZkMrMdUy/PH/+E8Zp+x0w7K5TfBboL80=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=GxQ9oqbWOYZZc4FRlIve/II9FoO+eC5e+4xuITgZ3PmGB86vTMQ/Q/wrJ8oFhRMWk
         Tly5ybe6SFyveDQbbQ5RWRjONuTlTmeowg8WlhfqF8gnj50hvcJ+bT/TKT48c5V/0u
         Fp5I1x7yeeK+jo6QjsG3NU/qh5cD6GVom0/mW7bAIDTRehIM9Gh/beB6Q0vknkQRf9
         c2FLFuf30TFvgyBug/9yPLk33pvZFe/E4MwbYg/WBD9z8tkV2eaXByI6MSN3F7bk9O
         N9lKPYUTMBxJF0FjPsI7NlCcaLL1OtPOkLuIqKVM5tHtrBfK9qb3LscKXWuC3oVWJl
         ql2RTwL8QmW/w==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The purpose of io_remap_pfn_range() is to map IO memory, such as a memory
mapped IO exposed through a PCI BAR. IO devices do not understand
encryption, so this memory must always be decrypted. Automatically call
pgprot_decrypted() as part of the generic implementation.

This fixes a bug where enabling AMD SME causes subsystems, such as RDMA,
using io_remap_pfn_range() to expose BAR pages to user space to fail. The
CPU will encrypt access to those BAR pages instead of passing unencrypted
IO directly to the device.

Places not mapping IO should use remap_pfn_range().

Cc: stable@kernel.org
Fixes: aca20d546214 ("x86/mm: Add support to make use of Secure Memory Encr=
yption")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/mm.h      | 9 +++++++++
 include/linux/pgtable.h | 4 ----
 2 files changed, 9 insertions(+), 4 deletions(-)

I have a few other patches after this to remove some now-redundant pgprot_d=
ecrypted()
and to update vfio-pci to call io_remap_pfn_range()

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360fe70aafcf..db6ae4d3fb4edc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2759,6 +2759,15 @@ static inline vm_fault_t vmf_insert_page(struct vm_a=
rea_struct *vma,
 	return VM_FAULT_NOPAGE;
 }
=20
+#ifndef io_remap_pfn_range
+static inline int io_remap_pfn_range(struct vm_area_struct *vma,
+				     unsigned long addr, unsigned long pfn,
+				     unsigned long size, pgprot_t prot)
+{
+	return remap_pfn_range(vma, addr, pfn, size, pgprot_decrypted(prot));
+}
+#endif
+
 static inline vm_fault_t vmf_error(int err)
 {
 	if (err =3D=3D -ENOMEM)
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 38c33eabea8942..71125a4676c4a6 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1427,10 +1427,6 @@ typedef unsigned int pgtbl_mod_mask;
=20
 #endif /* !__ASSEMBLY__ */
=20
-#ifndef io_remap_pfn_range
-#define io_remap_pfn_range remap_pfn_range
-#endif
-
 #ifndef has_transparent_hugepage
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define has_transparent_hugepage() 1
--=20
2.28.0

