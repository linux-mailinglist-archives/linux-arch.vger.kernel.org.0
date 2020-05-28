Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BB51E5DD4
	for <lists+linux-arch@lfdr.de>; Thu, 28 May 2020 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbgE1LFZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 May 2020 07:05:25 -0400
Received: from mail-eopbgr60086.outbound.protection.outlook.com ([40.107.6.86]:20149
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388154AbgE1LFX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 May 2020 07:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnnPXsxg81xUSjE+cVRm710Dfg5/195iUyC51AJWrBk=;
 b=LRCrHurw9Z39qJz/RhV7/ka6mrySrirXl9sCHG/nRAImoghi7TyEH1LZd2kQlMIG3zfzTe4K7fFAUGMXSJfzvg0l3d93P9LPaW2snT3V3JzPwTNctKKXg+dTq4TmfBaRr+hEwO865U7e2iKycxMk3CEzROKm2go9XR4cR6/+qZU=
Received: from AM6P192CA0085.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::26)
 by DBBPR08MB4728.eurprd08.prod.outlook.com (2603:10a6:10:d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Thu, 28 May
 2020 11:05:18 +0000
Received: from AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8d:cafe::fe) by AM6P192CA0085.outlook.office365.com
 (2603:10a6:209:8d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend
 Transport; Thu, 28 May 2020 11:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT014.mail.protection.outlook.com (10.152.16.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Thu, 28 May 2020 11:05:18 +0000
Received: ("Tessian outbound 14e212f6ce41:v57"); Thu, 28 May 2020 11:05:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f78b6c2ed7019c67
X-CR-MTA-TID: 64aa7808
Received: from 9ccd9bcaebc4.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 334EC635-2265-47A4-8876-DF8AD9BF4FF8.1;
        Thu, 28 May 2020 11:05:13 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9ccd9bcaebc4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 28 May 2020 11:05:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m48Kzil3/bwwC9859Edy68qoQyAT9Lk+VYFQdN9jdMSpsYTSdxof8N/l5ZMgE3ND/rbjQk9zNatwhgPZTYN/PNH8SXqPAH7tZekcTIumI6LAuG+iZlgIMf21lkEqr7CwhdkKLv46z4MQKX0N9Dte3J2j5wSaknSRyBNrbQZOBwDUq4RgMIOpRbwy/gFjad+xzVC3jIP9gaJBLDy2Rcl8VXHSRU5TLKG+mFSp5jeiI+TEYxERgnbJ5ynnlwunvI+6kxLnIj/O6mOfCRCEJwjmDwtG/A0TGaQKt1mXPCafU3Nzz2P77cl4djZtDgL8l1OmKUJ8MML5FfSAftDBFj2RbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnnPXsxg81xUSjE+cVRm710Dfg5/195iUyC51AJWrBk=;
 b=aORp7EqkA0tn0VAkKL2fMPPCVImCmbofZEi7iSPSl+XYKXdysrBBBq5CxJg/QppZy7tWAQlnJpUxiSdZp79JliYWO+VHsT6x8RJVvGldl1PPIYgopyTw2wC3UmHf/kcDY9wbZgxvXhvKqISOnT/do6BgmxPXlA8YM47rzLD11y1hVFlk0sUD+ke9Xb0Ohe7C5VtnZsCRUPVvvTq5b0I8cwv1FNcqrx6McuPEvrWXCQE5cRrmPiowNcHy2DbMMmWcjGcRb08WRbSf5nMV2bh94fDbXY+LdR7RMtQbruSO588eKqNVIeUlFZP780R7gLsBO1Zd4gVdJpCUnm6dPoBFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnnPXsxg81xUSjE+cVRm710Dfg5/195iUyC51AJWrBk=;
 b=LRCrHurw9Z39qJz/RhV7/ka6mrySrirXl9sCHG/nRAImoghi7TyEH1LZd2kQlMIG3zfzTe4K7fFAUGMXSJfzvg0l3d93P9LPaW2snT3V3JzPwTNctKKXg+dTq4TmfBaRr+hEwO865U7e2iKycxMk3CEzROKm2go9XR4cR6/+qZU=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB4134.eurprd08.prod.outlook.com (2603:10a6:20b:a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 11:05:11 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 11:05:11 +0000
Date:   Thu, 28 May 2020 12:05:09 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Evgenii Stepanov <eugenis@google.com>, nd@arm.com
Subject: Re: [PATCH v4 11/26] arm64: mte: Add PROT_MTE support to mmap() and
 mprotect()
Message-ID: <20200528110509.GA18623@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-12-catalin.marinas@arm.com>
 <CAMn1gO5ApcHOgQ_oLjiGDdCx9znz7N50w-BbzGPYpAzPQC3OQQ@mail.gmail.com>
 <20200528091445.GA2961@gaia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528091445.GA2961@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::20) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by LO2P265CA0296.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 11:05:11 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e52fb60c-c312-468a-be41-08d802f7020a
X-MS-TrafficTypeDiagnostic: AM6PR08MB4134:|DBBPR08MB4728:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB47287B5CC753A2C17B8E38BDED8E0@DBBPR08MB4728.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QV0lzCFrhrOR+8bpvO4YpqPm5YCPLzy9D+7md3xQrI8sO3M7MLVGiCsnbrkVJvq2fb5KJQhx0vUKsA44gEFuk41tYUE5p/wsSO7mOI3tTk3A6XFxDu4QwryDHmB93HUY3+GUGyXFofdsiKVjh3kDh3kSujJFITcCVe8oQPk+d/BYGhjo79b7MFVPhW7ArDy5ii1kCsjHQCH5QLjb0/KIaURrJalbww2MigNc2JxrOk2Vdw1NerMjp1UDZ2FFNmWH01JtrY2WEvtHaXcrIEk/N0fQGPXl06VkQHCc0qmIUGqdpLMzyPir5dIOBWXUyPsHEs04mlkzdn98vyIWR/nq0g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(66946007)(66556008)(316002)(33656002)(6636002)(66476007)(8936002)(8886007)(4326008)(54906003)(2616005)(83380400001)(956004)(37006003)(2906002)(44832011)(1076003)(8676002)(55016002)(5660300002)(36756003)(26005)(16526019)(186003)(86362001)(478600001)(6862004)(7696005)(53546011)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pPRZZVIzLr61yw9Ur6UGMdnhypKnBGGKgnc+zAW7LkRKV5sXQqTXw0QEaq+bgBsC1kwKan6j4t52Dld1ZajZfIACwrtdV+n4+wnyHL/7LrZ6ZBSPX5nDnX5769wru3G4PVb5MoTXTWxPipZiLfx0CEUkVEApSyIli5PuSmu6dbKgLw76Qo8h6+I4CnkUm/oGo1NyrR+Bbl1mA1TSk0oWT5zWsKcZFVMwtuogFgBw00xDFx7/SZCpmXiMq63JM5vAJbxUU8Xx2D1iypcNmPWh2RNG48STA84/0FwqvE9XMsN8NqEPdmqWWtKj4lzj1r/QC5KEGKglly4Mo9BIqcQTy4qmZpscHPCBkp4Go32U9icxe8J22uT901xsnExDIvpR0X5TVrpHlCji5C/7RFarPxI/p3fQrqMGWmsJwVgNkzHA8SzcLNt1QNKBpTTbtMXYHwAAbZNAfYpVmRAlLKLHwO57TO/TzNjg2jRqvaXIcgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4134
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966005)(5660300002)(36906005)(316002)(2906002)(70206006)(70586007)(55016002)(53546011)(44832011)(82310400002)(8936002)(956004)(8676002)(356005)(6636002)(81166007)(336012)(16526019)(33656002)(26005)(6862004)(54906003)(83380400001)(186003)(478600001)(4326008)(37006003)(1076003)(8886007)(47076004)(7696005)(86362001)(36756003)(2616005)(82740400003);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 34943ff8-717e-4d8d-9ba6-08d802f6fdc8
X-Forefront-PRVS: 0417A3FFD2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33+MR0ZKSFv9SE4wQL7gRnXXwVaIPltXz9CJQJuW3qraHtrNbznjjz/SX3+rXwGqtPKrvpk111zl33QgiXiwaWIXFhlhR/WvB6ifaQPk4OIrTHamFMglnvelj0SvBJbtS1UD9yhWAV5BNgRd6ajvUNZHkUE7cYQMn9E0+xXbUT69fYqwkRf8dyFbHe00dH0LmZFZxWvh0GJqiQ9XNk+WXGheuYh8PO4D7mWuWEoqrUKMC/kOtExzr0+bneertIjoVkWvyK/IjIAVWPbbG3QnG2QkgFbAyEbZJot9bklt0c8kNMuTHZX92PAq3KzvWnpZP68GWsLgs14qC8ZDsI8ulF0eN7OiI/3rnRSp+cYQ3XxItp/EoBx6hNaVEOV9stiZT5YMyyZhwHdpTFEN8DzmHg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 11:05:18.6772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e52fb60c-c312-468a-be41-08d802f7020a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4728
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 05/28/2020 10:14, Catalin Marinas wrote:
> On Wed, May 27, 2020 at 11:57:39AM -0700, Peter Collingbourne wrote:
> > On Fri, May 15, 2020 at 10:16 AM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > To enable tagging on a memory range, the user must explicitly opt in via
> > > a new PROT_MTE flag passed to mmap() or mprotect(). Since this is a new
> > > memory type in the AttrIndx field of a pte, simplify the or'ing of these
> > > bits over the protection_map[] attributes by making MT_NORMAL index 0.
> > 
> > Should the userspace stack always be mapped as if with PROT_MTE if the
> > hardware supports it? Such a change would be invisible to non-MTE
> > aware userspace since it would already need to opt in to tag checking
> > via prctl. This would let userspace avoid a complex stack
> > initialization sequence when running with stack tagging enabled on the
> > main thread.
> 
> I don't think the stack initialisation is that difficult. On program
> startup (can be the dynamic loader). Something like (untested):
> 
> 	register unsigned long stack asm ("sp");
> 	unsigned long page_sz = sysconf(_SC_PAGESIZE);
> 
> 	mprotect((void *)(stack & ~(page_sz - 1)), page_sz,
> 		 PROT_READ | PROT_WRITE | PROT_MTE | PROT_GROWSDOWN);
> 
> (the essential part it PROT_GROWSDOWN so that you don't have to specify
> a stack lower limit)

does this work even if the currently mapped stack is more than page_sz?
determining the mapped main stack area is i think non-trivial to do in
userspace (requires parsing /proc/self/maps or similar).

...
> I'm fine, however, with enabling PROT_MTE on the main stack based on
> some ELF note.

note that would likely mean an elf note on the dynamic linker
(because a dynamic linked executable may not be loaded by the
kernel and ctors in loaded libs run before the executable entry
code anyway, so the executable alone cannot be in charge of this
decision) i.e. one global switch for all dynamic linked binaries.

i think a dynamic linker can map a new stack and switch to it
if it needs to control the properties of the stack at runtime
(it's wasteful though).

and i think there should be a runtime mechanism for the brk area:
it should be possible to request that future brk expansions are
mapped as PROT_MTE so an mte aware malloc implementation can use
brk. i think this is not important in the initial design, but if
a prctl flag can do it that may be useful to add (may be at a
later time).

(and eventually there should be a way to use PROT_MTE on
writable global data and appropriate code generation that
takes colors into account when globals are accessed, but
that requires significant ELF, ld.so and compiler changes,
that need not be part of the initial mte design).
