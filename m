Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B8122F57F
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jul 2020 18:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbgG0Qgv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 12:36:51 -0400
Received: from mail-eopbgr40056.outbound.protection.outlook.com ([40.107.4.56]:9910
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730660AbgG0Qgv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jul 2020 12:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgnFfnA+1TmV0zl09L2edhvFoSNWhvVbwK03a85jv2I=;
 b=YmzXfXYDRU9HIdh9ifkemQW7m8h2tJI5sWcJeMsE/OsNo1YPX2CZ2GlxLF8M9ht3tkD+UFnvuwafjFS+cY4gKZlbfTSY9ZRqU3Y8Uc7HDa1h2BHo0OR0JvuNADaMsL67UFaE2PxVihTlDfDcFHVXVrQfIqOC4VrAqxEIvffutiY=
Received: from DB6PR0501CA0001.eurprd05.prod.outlook.com (2603:10a6:4:8f::11)
 by VI1PR0801MB1680.eurprd08.prod.outlook.com (2603:10a6:800:5a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 16:36:46 +0000
Received: from DB5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:8f:cafe::27) by DB6PR0501CA0001.outlook.office365.com
 (2603:10a6:4:8f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Mon, 27 Jul 2020 16:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT014.mail.protection.outlook.com (10.152.20.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.10 via Frontend Transport; Mon, 27 Jul 2020 16:36:46 +0000
Received: ("Tessian outbound 7de93d801f24:v62"); Mon, 27 Jul 2020 16:36:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 667bb6b8b4726df9
X-CR-MTA-TID: 64aa7808
Received: from c0aae7831929.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B19EEC0F-F0D0-4B4E-A3A6-07F089E78E49.1;
        Mon, 27 Jul 2020 16:36:40 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c0aae7831929.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 27 Jul 2020 16:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4IbkhkM6a3+xxZ5ovIzZn70KR2qxT3z+uj+Y0dKSu12MJiyDN/VfJFFTHyVHWYINZ4kQSJ81Wb70Fc8ZocDGSBXMAiPYylXMGsPflJPOZ5s4a2lBuXDhQ1K6C6i8LqTThbAYE0+LF9vt8S1cOYe40TQJRucXCXUCcOWm5eCnLrnDugwbLj/ohLCjGv+ViCedA1LsdY93BiJZndAEMp4/6is4BHcVQNWdQd3GA5rsyNBv05Ir2eoV/Am8j3Ss+DWUB7iwbh1bMaoUCf3SOvfo3zLorsi8YwDPMkFRc+7DhC1ANZ55tGTnZstabWjzhmKaY6w8wuxYjI2SubpV7SUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgnFfnA+1TmV0zl09L2edhvFoSNWhvVbwK03a85jv2I=;
 b=e6Our2Tdpo9QDO1Gl0cC/nuhGGJ2Zf6s6EaUSQc4IjrOSnGaRxq8AdYPpeFOrgAgOrx6Yufw09rozIlshYHa4i1KI9BRPxRhunc9rh6zG/O+x1HUH77BpxlI73cLVQOj0MTZtBxGbEZnT6AT8xYoClzlHQBjP2D52gzHHHDZL0n0v8i0a5qzdSxgkWtULtV2VosFx+g3+qlPM+XDie+op23sHByOrwAwo2peY7CTeymC/2SEoZbFoDIDzttoCmuIWJsBcbHKricn3CXcXrZH8p5qramRqwLgQ1Pi6lIBswq+ZNJI3c6EDZP9TiB/+JQ//P+OGwkY8tPzwEQsvz3Ciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgnFfnA+1TmV0zl09L2edhvFoSNWhvVbwK03a85jv2I=;
 b=YmzXfXYDRU9HIdh9ifkemQW7m8h2tJI5sWcJeMsE/OsNo1YPX2CZ2GlxLF8M9ht3tkD+UFnvuwafjFS+cY4gKZlbfTSY9ZRqU3Y8Uc7HDa1h2BHo0OR0JvuNADaMsL67UFaE2PxVihTlDfDcFHVXVrQfIqOC4VrAqxEIvffutiY=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB5141.eurprd08.prod.outlook.com (2603:10a6:20b:e6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 16:36:37 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c%6]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 16:36:37 +0000
Date:   Mon, 27 Jul 2020 17:36:35 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200727163634.GO7127@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-30-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715170844.30064-30-catalin.marinas@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0419.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::23) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.52) by LO2P265CA0419.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Mon, 27 Jul 2020 16:36:37 +0000
X-Originating-IP: [217.140.106.52]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e204671c-1974-4bbc-65cf-08d8324b40a0
X-MS-TrafficTypeDiagnostic: AM6PR08MB5141:|VI1PR0801MB1680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB168060EF4DAFC101A65516E7ED720@VI1PR0801MB1680.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CluXbCOnf638KLEKcnngMcThFOjxg1EGTytgs/a8WnqdUWXkUC0G7sMG8spdDkYttymz7pK900j4YmbmI9EMNlHp6NX2wVl8C+ScRA02vgxtVWF0QGR6oKY0oViuhi43NU+pkEOEkxrwVE43uiKEMRPOgMCfyVGohU7xasCYl7Eet3WUDbgQv3bi6gEeHBTiNNF/Ahj8RNww3gGICyoJMO52kNmXL4ySV4WOmIX1jyVYBcMAop41qeS1y9Wu72429P+SGlrtHoolAsmoke+iuZhTZ7N4ryASajvLDuHiVjWU2ruHzUFgNYvqjCQG1RbWLnS/hz1u8jul5yqlJVQQCA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(7696005)(52116002)(2906002)(316002)(55016002)(86362001)(1076003)(478600001)(83380400001)(36756003)(8936002)(66476007)(44832011)(956004)(54906003)(2616005)(66946007)(66556008)(6862004)(33656002)(8886007)(186003)(8676002)(16526019)(5660300002)(6636002)(4326008)(37006003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6a8ID4o3A/rDCDU8DyJfRQvKkXyxfcgs5ggoaGt2jX42HbbrNrgJ0RqZCnuKf4krZv2Ki/5ffubfdJTxA20toFzg65XryFj+TGxld/8Q7O/JpjLGDtltU/lcq+ZsJYmiMK3ZfQjaDTkKcS9DFyu0sVGN4/Zif7eEUSGWULvpgO3U3Up8ILma6/PsX54x+QOJmRVRrD4NM8zw6MDn+nQn/LiMiCg6IcSbr61ix4AD/h/s++tbla43xM/25z26epkNQN1THdnMyxEFwlXQFsBkWAv7DDHTpHftmtk1nnXsNYbboLKSKqJUY2IhJlcABjJEgoQTmU7Vth+uNngUftjj71lxnB8CrnqmPq7OoWRIYaucwU16cxF+HWdyfRYIs8UycP/TdwvxM3ZO7S4V0xEdYIElFi15wglM2hkg7aSQ1FEf1YC0lQd5upMQAehXHh3ZuAlMzR8a1jOMJ7wPonyDrIO17PMBEWaYZbpKpvyPsJ6vDJPdxQH8OmbPSx8mM93f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5141
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: bcf3a7e9-670e-471d-3681-08d8324b3b57
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbgHvrUpYy8dhG23c0GUSB+QRVgnm4Jj5c7zYgs9V3xkaCm1Gxa+bFlHOWwaEP7t7/dtoEI91HTj8QRkSsa6YdIgj1nY2vrTWcSMI4td6L2QXo/54mhI5mO7Fzlv11dIs6o1K+mH+ekMsWt7bAM0HYSA7qmaOZJnlCRE9bOFRnLRyBqpR/GzYD3l4WU2T3XzEHasLMGX5vE600t1uD6/GYbP5b4fDQTS/AaNJr0K5GnA3WEyZCFL0S58pc3fCaGt5feF4+7ze1uBnKLjim5L5PmF6bmU1v1rd69E1iaRvQAhJP+KwrD5EmqA09GR2RKQimMyEYwU7XUbJXVWveSPDGIRWY/3F0YQX6XyIJSDDIYp//qY2ibZYm4gWf+AxnUXcebyFCsjsj3T49vXt1CwMQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966005)(2616005)(81166007)(82740400003)(86362001)(2906002)(316002)(7696005)(356005)(956004)(33656002)(8676002)(47076004)(82310400002)(44832011)(6636002)(336012)(478600001)(54906003)(8936002)(37006003)(36756003)(8886007)(83380400001)(55016002)(70206006)(26005)(1076003)(186003)(16526019)(5660300002)(4326008)(6862004)(107886003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 16:36:46.1054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e204671c-1974-4bbc-65cf-08d8324b40a0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1680
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/15/2020 18:08, Catalin Marinas wrote:
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
> Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
> 
> Notes:
>     v7:
>     - Add information on ptrace() regset access (NT_ARM_TAGGED_ADDR_CTRL).
>     
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
>  .../arm64/memory-tagging-extension.rst        | 305 ++++++++++++++++++
>  4 files changed, 312 insertions(+)
>  create mode 100644 Documentation/arm64/memory-tagging-extension.rst
> 
> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
...
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

we discussed the need for per process prctl off list, i will
try to summarize the requirement here:

- it cannot be guaranteed in general that a library initializer
or first call into a library happens when the process is still
single threaded.

- user code currently has no way to call prctl in all threads of
a process and even within the c runtime doing so is problematic
(it has to signal all threads, which requires a reserved signal
and dealing with exiting threads and signal masks, such mechanism
can break qemu user and various other userspace tooling).

- we don't yet have defined contract in userspace about how user
code may enable mte (i.e. use the prctl call), but it seems that
there will be use cases for it: LD_PRELOADing malloc for heap
tagging is one such case, but any library or custom allocator
that wants to use mte will have this issue: when it enables mte
it wants to enable it for all threads in the process. (or at
least all threads managed by the c runtime).

- even if user code is not allowed to call the prctl directly,
i.e. the prctl settings are owned by the libc, there will be
cases when the settings have to be changed in a multithreaded
process (e.g. dlopening a library that requires a particular
mte state).

a solution is to introduce a flag like SECCOMP_FILTER_FLAG_TSYNC
that means the prctl is for all threads in the process not just
for the current one. however the exact semantics is not obvious
if there are inconsistent settings in different threads or user
code tries to use the prctl concurrently: first checking then
setting the mte state via separate prctl calls is racy. but if
the userspace contract for enabling mte limits who and when can
call the prctl then i think the simple sync flag approach works.

(the sync flag should apply to all prctl settings: tagged addr
syscall abi, mte check fault mode, irg tag excludes. ideally it
would work for getting the process wide state and it would fail
in case of inconsistent settings.)

we may need to document some memory ordering details when
memory accesses in other threads are affected, but i think
that can be something simple that leaves it unspecified
what happens with memory accesses that are not synchrnized
with the prctl call.
