Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC0C209E5D
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 14:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404610AbgFYMWp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jun 2020 08:22:45 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:31362
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404343AbgFYMWn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jun 2020 08:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg0Igf9miN5yMOh+byMnZEAc7bGzvrcomvovj1PhW0U=;
 b=P0YcvabVYwRYC6j1zCVpcKI4v7lQdn+s86u6MGxowemsdbk9nzsAY2Ch9PVs/UXgDRm5lHfuyFzMESbEEhNoFHfr5GbTYnCoqkxKbbbfzEY3yPfnVuw/8AN/9tupqlUt5xA7uiWcp1AtG1/+oETEPzriQwDBmTal4G9qwJWkwD4=
Received: from AM6P194CA0024.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::37)
 by VI1PR0801MB2079.eurprd08.prod.outlook.com (2603:10a6:800:8e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Thu, 25 Jun
 2020 12:22:37 +0000
Received: from VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::a1) by AM6P194CA0024.outlook.office365.com
 (2603:10a6:209:90::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 12:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT031.mail.protection.outlook.com (10.152.18.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 12:22:36 +0000
Received: ("Tessian outbound 8fb20e43acb7:v59"); Thu, 25 Jun 2020 12:22:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e2f4b8d4013660b0
X-CR-MTA-TID: 64aa7808
Received: from 56ed09ec6c05.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CCC61898-1956-4B4B-9DE6-4CDB59BDCDD4.1;
        Thu, 25 Jun 2020 12:22:29 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 56ed09ec6c05.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 25 Jun 2020 12:22:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5wV2pk/MJFs92DbzWzG7Fb7IMtw2oaarSLjGSa3aVkb7VzgfXPXzH0ZZpTdSgj5mMlMFJJxmFqht4HtB748OdQNOnn44xdnntPd+fMduRb/aH21ZV7kbukYHpx/+Y9egf4t7kR69ZcutBCy0XGEzxP6SN6DN0R4yr250rl0TvE06P0CFEv188KhQ+4tzgdwfBOMxjErL0hnpzlLzSmRlk938GBsI7BZ/bHsb6jHk1rASWiyA9ZI2pxY7ZN0MGvNTXgxwXVQxEKXg4cEvZe2LKUCNgrpJmAroy24/tfj34vMOwSQLNYCjYNmLLo0tp9lbocMtz5iHDfjkvuYIbCfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg0Igf9miN5yMOh+byMnZEAc7bGzvrcomvovj1PhW0U=;
 b=maMdTZJPWjLTKPvYw6JyBaVNrzcYYiM9jkKtlNgZeogokkelrV9s63EbV2grjnpeGG7TpGKCu5gx7LmAahNVQ9Fwh3YhnAlLZpu4znZQBSfyDinml9FkiPe17qpoCuPDZD9PUgt9x2yD+jvHDOveSNNHm7XqdgvuDmsAw5Azjes9mm1aSYsB/cGvfVGP7yDPbSo9IWaxVCwH3c0J1LDeiKDL4hJRGxMtRWJvISsw9K/KwJ8tS6wFPIWBZ+duzAqLC1PG/Jfc7LGNkFmBPWnVVoCWPBx3jJoxaCum6E1hVKY9lGIwmYDWd4j8ecS0wgJcSmcRZg+RIHeEEPYAzR23+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg0Igf9miN5yMOh+byMnZEAc7bGzvrcomvovj1PhW0U=;
 b=P0YcvabVYwRYC6j1zCVpcKI4v7lQdn+s86u6MGxowemsdbk9nzsAY2Ch9PVs/UXgDRm5lHfuyFzMESbEEhNoFHfr5GbTYnCoqkxKbbbfzEY3yPfnVuw/8AN/9tupqlUt5xA7uiWcp1AtG1/+oETEPzriQwDBmTal4G9qwJWkwD4=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3054.eurprd08.prod.outlook.com (2603:10a6:803:4a::32)
 by VI1PR08MB5326.eurprd08.prod.outlook.com (2603:10a6:803:12d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 12:22:27 +0000
Received: from VI1PR08MB3054.eurprd08.prod.outlook.com
 ([fe80::b999:6330:8770:2bf8]) by VI1PR08MB3054.eurprd08.prod.outlook.com
 ([fe80::b999:6330:8770:2bf8%7]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 12:22:27 +0000
Date:   Thu, 25 Jun 2020 13:22:17 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Earnshaw <rearnsha@arm.com>, libc-alpha@sourceware.org,
        nd@arm.com
Subject: Re: [PATCH v5 25/25] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200625122216.GJ16726@arm.com>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-26-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624175244.25837-26-catalin.marinas@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN4PR0801CA0010.namprd08.prod.outlook.com
 (2603:10b6:803:29::20) To VI1PR08MB3054.eurprd08.prod.outlook.com
 (2603:10a6:803:4a::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.53) by SN4PR0801CA0010.namprd08.prod.outlook.com (2603:10b6:803:29::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Thu, 25 Jun 2020 12:22:22 +0000
X-Originating-IP: [217.140.106.53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87b7ce6a-e183-4b11-4651-08d81902721a
X-MS-TrafficTypeDiagnostic: VI1PR08MB5326:|VI1PR0801MB2079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2079C97E98BA61E2BBEDD027ED920@VI1PR0801MB2079.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8O8He6tf3Y/d+T+7fWHqOsy81VXnD8fFm+WMsHYMNwO04Utm63A6rmhes1qLvF/NuAp9t2SYHG4Pg392bhFNGJDSJcsu331A52sQ5FgwETHOXJpI2or78THXD4umepblds48a4vXegzayB6FR7D5sGlivhFBNeQi4/GDTpIRWJQwj0xGLeF0KXAbW+vpfeDdBVupii6r6bjwkkjQSrYqU4cyM+qQW5Q8pScUKNNvrdQzBLz2wHhwnncu1pHk0Ub/767BGAF9/0FgRt4kZKGUL+1LHNY9UoasJ5kCsQexhEdIJRFHAneSDk3Z7GeLuxIGt6eR7iopkwsiFUAKvfDAvCsv50iop4hMS4Ozb7+6ACAOk8KkniowMwKUwyAhY8OVfOxqLNoU3Ds9BgdxefPB0A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3054.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(316002)(478600001)(55016002)(956004)(26005)(6862004)(5660300002)(966005)(44832011)(83380400001)(16526019)(36756003)(8886007)(4326008)(54906003)(37006003)(186003)(52116002)(6666004)(8676002)(66556008)(8936002)(2616005)(2906002)(33656002)(66476007)(66946007)(86362001)(30864003)(1076003)(7696005)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0HnXYvzkTKEPTsCDZDfivQsC50bJsyK40lf7QKLeTSG65Zir0kpCZEhXR67jtYYIrfuW4cXiuW6bDWZI4tgTSBkJpqqyeMOGNC76anB+75PV2mYH0x56+D/b+l/ei5G5dfbSrS+X0xL5AAHtBMkgnbnS9DusoxZlR8Ya4Q2V72KLsEG6hzUSdiJMGXGOlCubc3PcFiESDqK4XKv7tslfI2n4OMNpDipoxkO6q5pSy6eQZ+uyC+8qTbO8w3VIp3pTM1Lq6EQDH8gQcE2LcJ6d4ix/RKL/16JvsF9+kANTm/sNFmyEiBP0TN8LPXcTwAfF/jrSkbPi94Qa4ZHq5y6Si3YWrmb420G/AW+NVIzzLbBhtlepoO5Ptbdjpy8TQOc9mKxdcgW2fdNk9FeEUoHR2WkH9eS5srxocoA++NIP8GHPc5j02ngSF8VFQMWENlsIvGq8eKDBMy0e0y8xnUKcgX+QaSooK5/GaY39pMEzHm7GbZFUsgqOuXM4U0QDRekH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5326
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966005)(47076004)(82740400003)(26005)(36906005)(356005)(54906003)(81166007)(316002)(478600001)(83380400001)(6862004)(82310400002)(7696005)(16526019)(4326008)(36756003)(186003)(966005)(2906002)(44832011)(30864003)(55016002)(5660300002)(86362001)(6636002)(8886007)(33656002)(6666004)(1076003)(8936002)(8676002)(37006003)(70206006)(336012)(2616005)(956004)(70586007);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9422b87b-3a15-4b72-a263-08d819026c03
X-Forefront-PRVS: 0445A82F82
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMl0tglu6IRhLYnxgjiDERrSPbl46UfLbJyhOHA1kkczKBq+owa/pOV3zJYc+X/IQj2mBh1r0SlIfMXFnsBRPvGQNO6UFQ4dZiSY6pQ2N2ziQmOjZ7HexBJk6Jzad5KCJRXz7OmEPzQr9Gn19qupzkBCKWSVfaWXc5p+RX9CtxinwcBDAlyJLNUjD5FTMKFfCgLcrLIyFcbXeYqkOeg4YfnVwrV0xLdU6ip7pGHRLWskD+Uj2QwM+Os6PFlxbebI87NdRrI0a1adi7ZwU/2vuz84sJMBd2bv+U8GH8hO4GJSo5EbRzZk+um3HTtbInLWSnlIRT9zNGGbMdI+tk+VaX1ac9+08FfhGfkf4UvM2S72WuePvHvgCC4nPN9cJPvUWH09bhnwhbyiSqQej1Z7j9OiR7efdb23LroZ0aoGbLX4s/I8psq8vdfa0X2i7I9GkyqzSOLMq6Zkwgs1iD6WE5QOh897+6kmsXtxkCgiEE0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 12:22:36.6389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b7ce6a-e183-4b11-4651-08d81902721a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2079
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 06/24/2020 18:52, Catalin Marinas wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Memory Tagging Extension (part of the ARMv8.5 Extensions) provides
> a mechanism to detect the sources of memory related errors which
> may be vulnerable to exploitation, including bounds violations,
> use-after-free, use-after-return, use-out-of-scope and use before
> initialization errors.
> 
> Add Memory Tagging Extension documentation for the arm64 linux
> kernel support.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

there are are still libc side discussions, but the
linux abi looks ok to me from user space pov.
i'm adding libc-alpha on cc, the patch set is e.g. at
http://lists.infradead.org/pipermail/linux-arm-kernel/2020-June/579787.html

Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>

with a few comments inline.

> ---
> 
> Notes:
>     v4:
>     - Document behaviour of madvise(MADV_DONTNEED/MADV_FREE).
>     - Document the initial process state on fork/execve.
>     - Clarify when the kernel uaccess checks the tags.
>     - Minor updates to the example code.
>     - A few other minor clean-ups following review.
>     
>     v3:
>     - Modify the uaccess checking conditions: only when the sync mode is
>       selected by the user. In async mode, the kernel uaccesses are not
>       checked.
>     - Clarify that an include mask of 0 (exclude mask 0xffff) results in
>       always generating tag 0.
>     - Document the ptrace() interface.
>     
>     v2:
>     - Documented the uaccess kernel tag checking mode.
>     - Removed the BTI definitions from cpu-feature-registers.rst.
>     - Removed the paragraph stating that MTE depends on the tagged address
>       ABI (while the Kconfig entry does, there is no requirement for the
>       user to enable both).
>     - Changed the GCR_EL1.Exclude handling description following the change
>       in the prctl() interface (include vs exclude mask).
>     - Updated the example code.
> 
>  Documentation/arm64/cpu-feature-registers.rst |   2 +
>  Documentation/arm64/elf_hwcaps.rst            |   4 +
>  Documentation/arm64/index.rst                 |   1 +
>  .../arm64/memory-tagging-extension.rst        | 297 ++++++++++++++++++
>  4 files changed, 304 insertions(+)
>  create mode 100644 Documentation/arm64/memory-tagging-extension.rst
> 
> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> index 314fa5bc2655..27d8559d565b 100644
> --- a/Documentation/arm64/cpu-feature-registers.rst
> +++ b/Documentation/arm64/cpu-feature-registers.rst
> @@ -174,6 +174,8 @@ infrastructure:
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |
>       +------------------------------+---------+---------+
> +     | MTE                          | [11-8]  |    y    |
> +     +------------------------------+---------+---------+
>       | SSBS                         | [7-4]   |    y    |
>       +------------------------------+---------+---------+
>       | BT                           | [3-0]   |    y    |
> diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
> index 84a9fd2d41b4..bbd9cf54db6c 100644
> --- a/Documentation/arm64/elf_hwcaps.rst
> +++ b/Documentation/arm64/elf_hwcaps.rst
> @@ -240,6 +240,10 @@ HWCAP2_BTI
>  
>      Functionality implied by ID_AA64PFR0_EL1.BT == 0b0001.
>  
> +HWCAP2_MTE
> +
> +    Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010, as described
> +    by Documentation/arm64/memory-tagging-extension.rst.

OK.

>  
>  4. Unused AT_HWCAP bits
>  -----------------------
> diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
> index 09cbb4ed2237..4cd0e696f064 100644
> --- a/Documentation/arm64/index.rst
> +++ b/Documentation/arm64/index.rst
> @@ -14,6 +14,7 @@ ARM64 Architecture
>      hugetlbpage
>      legacy_instructions
>      memory
> +    memory-tagging-extension
>      pointer-authentication
>      silicon-errata
>      sve
> diff --git a/Documentation/arm64/memory-tagging-extension.rst b/Documentation/arm64/memory-tagging-extension.rst
> new file mode 100644
> index 000000000000..e7cdcecb656a
> --- /dev/null
> +++ b/Documentation/arm64/memory-tagging-extension.rst
> @@ -0,0 +1,297 @@
> +===============================================
> +Memory Tagging Extension (MTE) in AArch64 Linux
> +===============================================
> +
> +Authors: Vincenzo Frascino <vincenzo.frascino@arm.com>
> +         Catalin Marinas <catalin.marinas@arm.com>
> +
> +Date: 2020-02-25
> +
> +This document describes the provision of the Memory Tagging Extension
> +functionality in AArch64 Linux.
> +
> +Introduction
> +============
> +
> +ARMv8.5 based processors introduce the Memory Tagging Extension (MTE)
> +feature. MTE is built on top of the ARMv8.0 virtual address tagging TBI
> +(Top Byte Ignore) feature and allows software to access a 4-bit
> +allocation tag for each 16-byte granule in the physical address space.
> +Such memory range must be mapped with the Normal-Tagged memory
> +attribute. A logical tag is derived from bits 59-56 of the virtual
> +address used for the memory access. A CPU with MTE enabled will compare
> +the logical tag against the allocation tag and potentially raise an
> +exception on mismatch, subject to system registers configuration.
> +
> +Userspace Support
> +=================
> +
> +When ``CONFIG_ARM64_MTE`` is selected and Memory Tagging Extension is
> +supported by the hardware, the kernel advertises the feature to
> +userspace via ``HWCAP2_MTE``.

OK.

> +
> +PROT_MTE
> +--------
> +
> +To access the allocation tags, a user process must enable the Tagged
> +memory attribute on an address range using a new ``prot`` flag for
> +``mmap()`` and ``mprotect()``:
> +
> +``PROT_MTE`` - Pages allow access to the MTE allocation tags.
> +
> +The allocation tag is set to 0 when such pages are first mapped in the
> +user address space and preserved on copy-on-write. ``MAP_SHARED`` is
> +supported and the allocation tags can be shared between processes.
> +
> +**Note**: ``PROT_MTE`` is only supported on ``MAP_ANONYMOUS`` and
> +RAM-based file mappings (``tmpfs``, ``memfd``). Passing it to other
> +types of mapping will result in ``-EINVAL`` returned by these system
> +calls.
> +
> +**Note**: The ``PROT_MTE`` flag (and corresponding memory type) cannot
> +be cleared by ``mprotect()``.
> +
> +**Note**: ``madvise()`` memory ranges with ``MADV_DONTNEED`` and
> +``MADV_FREE`` may have the allocation tags cleared (set to 0) at any
> +point after the system call.

OK.

I expect in the future to have a way to query the
PROT_MTE status of mappings (e.g. via /proc/self).

The MAP_SHARED behaviour is not entirely clear here
but i guess it's possible to have PROT_MTE in one
process and no PROT_MTE in others on the same mapping.
then allocation tags only affect the process where
PROT_MTE was used, later on another process may set
PROT_MTE and then the shared allocation tags affect
that process too.

The madvise behaviour looks a bit risky from user
space pov since now it's not just the memory content
that can disappear after a MADV_DONTNEED, but pointer
to that memory can become invalid too. but i think
this is OK: in libc we will have to say that madvise
on memory returned by malloc is not valid.

As noted before, this design is not ideal for stack
tagging (mprotecting the initial stack with PROT_MTE
may be problematic if we don't know the bounds), but
the expectation is to introduce some ELF marking and
then linux can just start the process with PROT_MTE
stack if the dynamic linker has the marking. Same for
the brk area (default PROT_MTE based on ELF marking).

> +
> +Tag Check Faults
> +----------------
> +
> +When ``PROT_MTE`` is enabled on an address range and a mismatch between
> +the logical and allocation tags occurs on access, there are three
> +configurable behaviours:
> +
> +- *Ignore* - This is the default mode. The CPU (and kernel) ignores the
> +  tag check fault.
> +
> +- *Synchronous* - The kernel raises a ``SIGSEGV`` synchronously, with
> +  ``.si_code = SEGV_MTESERR`` and ``.si_addr = <fault-address>``. The
> +  memory access is not performed. If ``SIGSEGV`` is ignored or blocked
> +  by the offending thread, the containing process is terminated with a
> +  ``coredump``.
> +
> +- *Asynchronous* - The kernel raises a ``SIGSEGV``, in the offending
> +  thread, asynchronously following one or multiple tag check faults,
> +  with ``.si_code = SEGV_MTEAERR`` and ``.si_addr = 0`` (the faulting
> +  address is unknown).
> +
> +The user can select the above modes, per thread, using the
> +``prctl(PR_SET_TAGGED_ADDR_CTRL, flags, 0, 0, 0)`` system call where
> +``flags`` contain one of the following values in the ``PR_MTE_TCF_MASK``
> +bit-field:
> +
> +- ``PR_MTE_TCF_NONE``  - *Ignore* tag check faults
> +- ``PR_MTE_TCF_SYNC``  - *Synchronous* tag check fault mode
> +- ``PR_MTE_TCF_ASYNC`` - *Asynchronous* tag check fault mode
> +
> +The current tag check fault mode can be read using the
> +``prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0, 0)`` system call.
> +
> +Tag checking can also be disabled for a user thread by setting the
> +``PSTATE.TCO`` bit with ``MSR TCO, #1``.
> +
> +**Note**: Signal handlers are always invoked with ``PSTATE.TCO = 0``,
> +irrespective of the interrupted context. ``PSTATE.TCO`` is restored on
> +``sigreturn()``.
> +
> +**Note**: There are no *match-all* logical tags available for user
> +applications.
> +
> +**Note**: Kernel accesses to the user address space (e.g. ``read()``
> +system call) are not checked if the user thread tag checking mode is
> +``PR_MTE_TCF_NONE`` or ``PR_MTE_TCF_ASYNC``. If the tag checking mode is
> +``PR_MTE_TCF_SYNC``, the kernel makes a best effort to check its user
> +address accesses, however it cannot always guarantee it.

OK.

i know the kernel likes to operate on os-threads,
but in userspace this causes the slight wart that if
somebody wants to use heap tagging with LD_PRELOADed
malloc and the first malloc is called after a thread
is already created then the malloc implementation
cannot set up the prctl right for all threads in the
process. (for userspace i think it is only useful to
allow threads with different MTE settings if there
are some threads in a process that are not managed by
the c runtime and don't call into libc, so as far as
normal c code is concerned a per process setting
would be nicer). for interposers the workaround is
to interpose thread creating libc apis, which is not
perfect (libc internally may create threads in not
interposable ways e.g. for implementing aio and then
use heap memory in such threads), but i think early
threads before an LD_PRELOAD initializer may run is
not a common scenario and this type of MTE usage is
for debugging, i.e. does not have to be perfect.

as noted before (i think by Kevin) it would be nice
to query the tag check status of other threads e.g.
via a /proc/ thing (but i don't see an immediate need
for this other than debugging MTE faults).

> +
> +Excluding Tags in the ``IRG``, ``ADDG`` and ``SUBG`` instructions
> +-----------------------------------------------------------------
> +
> +The architecture allows excluding certain tags to be randomly generated
> +via the ``GCR_EL1.Exclude`` register bit-field. By default, Linux
> +excludes all tags other than 0. A user thread can enable specific tags
> +in the randomly generated set using the ``prctl(PR_SET_TAGGED_ADDR_CTRL,
> +flags, 0, 0, 0)`` system call where ``flags`` contains the tags bitmap
> +in the ``PR_MTE_TAG_MASK`` bit-field.
> +
> +**Note**: The hardware uses an exclude mask but the ``prctl()``
> +interface provides an include mask. An include mask of ``0`` (exclusion
> +mask ``0xffff``) results in the CPU always generating tag ``0``.

OK.

> +
> +Initial process state
> +---------------------
> +
> +On ``execve()``, the new process has the following configuration:
> +
> +- ``PR_TAGGED_ADDR_ENABLE`` set to 0 (disabled)
> +- Tag checking mode set to ``PR_MTE_TCF_NONE``
> +- ``PR_MTE_TAG_MASK`` set to 0 (all tags excluded)
> +- ``PSTATE.TCO`` set to 0
> +- ``PROT_MTE`` not set on any of the initial memory maps
> +
> +On ``fork()``, the new process inherits the parent's configuration and
> +memory map attributes with the exception of the ``madvise()`` ranges
> +with ``MADV_WIPEONFORK`` which will have the data and tags cleared (set
> +to 0).

OK.

> +
> +The ``ptrace()`` interface
> +--------------------------
> +
> +``PTRACE_PEEKMTETAGS`` and ``PTRACE_POKEMTETAGS`` allow a tracer to read
> +the tags from or set the tags to a tracee's address space. The
> +``ptrace()`` system call is invoked as ``ptrace(request, pid, addr,
> +data)`` where:
> +
> +- ``request`` - one of ``PTRACE_PEEKMTETAGS`` or ``PTRACE_PEEKMTETAGS``.
> +- ``pid`` - the tracee's PID.
> +- ``addr`` - address in the tracee's address space.
> +- ``data`` - pointer to a ``struct iovec`` where ``iov_base`` points to
> +  a buffer of ``iov_len`` length in the tracer's address space.
> +
> +The tags in the tracer's ``iov_base`` buffer are represented as one
> +4-bit tag per byte and correspond to a 16-byte MTE tag granule in the
> +tracee's address space.
> +
> +**Note**: If ``addr`` is not aligned to a 16-byte granule, the kernel
> +will use the corresponding aligned address.
> +
> +``ptrace()`` return value:
> +
> +- 0 - tags were copied, the tracer's ``iov_len`` was updated to the
> +  number of tags transferred. This may be smaller than the requested
> +  ``iov_len`` if the requested address range in the tracee's or the
> +  tracer's space cannot be accessed or does not have valid tags.
> +- ``-EPERM`` - the specified process cannot be traced.
> +- ``-EIO`` - the tracee's address range cannot be accessed (e.g. invalid
> +  address) and no tags copied. ``iov_len`` not updated.
> +- ``-EFAULT`` - fault on accessing the tracer's memory (``struct iovec``
> +  or ``iov_base`` buffer) and no tags copied. ``iov_len`` not updated.
> +- ``-EOPNOTSUPP`` - the tracee's address does not have valid tags (never
> +  mapped with the ``PROT_MTE`` flag). ``iov_len`` not updated.
> +
> +**Note**: There are no transient errors for the requests above, so user
> +programs should not retry in case of a non-zero system call return.

looks OK.

> +
> +Example of correct usage
> +========================
> +
> +*MTE Example code*
> +
> +.. code-block:: c
> +
> +    /*
> +     * To be compiled with -march=armv8.5-a+memtag
> +     */
> +    #include <errno.h>
> +    #include <stdio.h>
> +    #include <stdlib.h>
> +    #include <unistd.h>
> +    #include <sys/auxv.h>
> +    #include <sys/mman.h>
> +    #include <sys/prctl.h>
> +
> +    /*
> +     * From arch/arm64/include/uapi/asm/hwcap.h
> +     */
> +    #define HWCAP2_MTE              (1 << 18)
> +
> +    /*
> +     * From arch/arm64/include/uapi/asm/mman.h
> +     */
> +    #define PROT_MTE                 0x20
> +
> +    /*
> +     * From include/uapi/linux/prctl.h
> +     */
> +    #define PR_SET_TAGGED_ADDR_CTRL 55
> +    #define PR_GET_TAGGED_ADDR_CTRL 56
> +    # define PR_TAGGED_ADDR_ENABLE  (1UL << 0)
> +    # define PR_MTE_TCF_SHIFT       1
> +    # define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TCF_SYNC        (1UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TCF_ASYNC       (2UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TCF_MASK        (3UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TAG_SHIFT       3
> +    # define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
> +
> +    /*
> +     * Insert a random logical tag into the given pointer.
> +     */
> +    #define insert_random_tag(ptr) ({                       \
> +            __u64 __val;                                    \

i'd use uint64_t from stdint.h or unsigned long
in the example (i.e. not a kernel type)

> +            asm("irg %0, %1" : "=r" (__val) : "r" (ptr));   \
> +            __val;                                          \
> +    })
> +
> +    /*
> +     * Set the allocation tag on the destination address.
> +     */
> +    #define set_tag(tagged_addr) do {                                      \
> +            asm volatile("stg %0, [%0]" : : "r" (tagged_addr) : "memory"); \
> +    } while (0)
> +
> +    int main()
> +    {
> +            unsigned char *a;
> +            unsigned long page_sz = sysconf(_SC_PAGESIZE);
> +            unsigned long hwcap2 = getauxval(AT_HWCAP2);
> +
> +            /* check if MTE is present */
> +            if (!(hwcap2 & HWCAP2_MTE))
> +                    return EXIT_FAILURE;
> +
> +            /*
> +             * Enable the tagged address ABI, synchronous MTE tag check faults and
> +             * allow all non-zero tags in the randomly generated set.
> +             */
> +            if (prctl(PR_SET_TAGGED_ADDR_CTRL,
> +                      PR_TAGGED_ADDR_ENABLE | PR_MTE_TCF_SYNC | (0xfffe << PR_MTE_TAG_SHIFT),
> +                      0, 0, 0)) {
> +                    perror("prctl() failed");
> +                    return EXIT_FAILURE;
> +            }
> +
> +            a = mmap(0, page_sz, PROT_READ | PROT_WRITE,
> +                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +            if (a == MAP_FAILED) {
> +                    perror("mmap() failed");
> +                    return EXIT_FAILURE;
> +            }
> +
> +            /*
> +             * Enable MTE on the above anonymous mmap. The flag could be passed
> +             * directly to mmap() and skip this step.
> +             */
> +            if (mprotect(a, page_sz, PROT_READ | PROT_WRITE | PROT_MTE)) {
> +                    perror("mprotect() failed");
> +                    return EXIT_FAILURE;
> +            }
> +
> +            /* access with the default tag (0) */
> +            a[0] = 1;
> +            a[1] = 2;
> +
> +            printf("a[0] = %hhu a[1] = %hhu\n", a[0], a[1]);
> +
> +            /* set the logical and allocation tags */
> +            a = (unsigned char *)insert_random_tag(a);
> +            set_tag(a);
> +
> +            printf("%p\n", a);
> +
> +            /* non-zero tag access */
> +            a[0] = 3;
> +            printf("a[0] = %hhu a[1] = %hhu\n", a[0], a[1]);
> +
> +            /*
> +             * If MTE is enabled correctly the next instruction will generate an
> +             * exception.
> +             */
> +            printf("Expecting SIGSEGV...\n");
> +            a[16] = 0xdd;
> +
> +            /* this should not be printed in the PR_MTE_TCF_SYNC mode */
> +            printf("...haven't got one\n");
> +
> +            return EXIT_FAILURE;
> +    }

OK.
