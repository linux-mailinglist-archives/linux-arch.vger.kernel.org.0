Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446C2492437
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jan 2022 12:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbiARLDS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jan 2022 06:03:18 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:44774
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231758AbiARLDR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Jan 2022 06:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWrWcMSTjRfJ1oPRHqqOz24Wd20hO0V54U0gH/AixS0=;
 b=nXO/Q3gIZwbGKKXtiuOHevjUy1WGWNAzcgicFg9yNWPPtaGezxVFqfVB5d2e6xo0K4QHlvWs0iTanrNOeMTVXqUdtjNOBT305zz8VvNvrVO1f0Zd0DkdZPKanZR/8uZuRmjAfEP9EEDQqpAXJxjYutjPzcQfnIsFzASFzg5z+bg=
Received: from AM7PR03CA0024.eurprd03.prod.outlook.com (2603:10a6:20b:130::34)
 by PA4PR08MB6032.eurprd08.prod.outlook.com (2603:10a6:102:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 11:03:14 +0000
Received: from VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:130:cafe::e7) by AM7PR03CA0024.outlook.office365.com
 (2603:10a6:20b:130::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Tue, 18 Jan 2022 11:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 63.35.35.123) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT030.mail.protection.outlook.com (10.152.18.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 11:03:12 +0000
Received: ("Tessian outbound 9a8c656e7c94:v110"); Tue, 18 Jan 2022 11:03:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9e9dca6437d0867c
X-CR-MTA-TID: 64aa7808
Received: from 1e1c90859097.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A3D5841D-1B9C-44E0-A889-CF4FA81F575C.1;
        Tue, 18 Jan 2022 11:03:00 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1e1c90859097.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 18 Jan 2022 11:03:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZBtc3qnB4ee8pKmGdH4Yokp3VHtlZcPc3rDJFAyAB5H4bK665HzhK+p/wKtcBmQJlg9QGD7u9RWX1+SoLTeLRD/MDdHjW2UCfY8+tcL1kk28q3CgFk9bQhptu+26HJAyOtURs4Xy1osFh/UYGYYeTtB1RRgm0sDEDBtH0be1nFbWgF3kJsjMmPF/fVYPUK1+Cpu9LzpUbQ46xWmfPpl3V6I5pYOfnnaKlZVPhdNeBFTWAK57hRHEDCIZjfaaYnfJSzydDXqvib/X9of0LnO1e+eEkcdYOmHvTG3bOIadN4Rmg/1BmcVGDj6F+1DK+qXcl4wDep2/bj6RTBmG41MhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWrWcMSTjRfJ1oPRHqqOz24Wd20hO0V54U0gH/AixS0=;
 b=ciwIKmRPtWG5v8l1Xkr0FPCEMqpQFdh+kmYR/L3TOExwmHLvS2mgHFk/u/Flc926DYODugVtZnHfygt6naKRf3jHxyuj48/QeeNJIqVeZUm5k+VHx+3oums5MJCyO2clVFoqs6BfR1RmQP/GgUxMxqRlzX/h+bd8SKta0dyN1Si7FpQiXOIT11epoX8rCzbGd5An31nZBzrAVkWz+BCa+342MuoKoRubUjsEH6oJY7nUVFiGbmR9qWDd8di1i+090D5Odc1hISCcRmRqbyZiGHG/OqV1vmRKYdmCupCH8IgpXERLDKXyI3ANTOb8TDtxCpMQxktemyspRPvd0BByUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWrWcMSTjRfJ1oPRHqqOz24Wd20hO0V54U0gH/AixS0=;
 b=nXO/Q3gIZwbGKKXtiuOHevjUy1WGWNAzcgicFg9yNWPPtaGezxVFqfVB5d2e6xo0K4QHlvWs0iTanrNOeMTVXqUdtjNOBT305zz8VvNvrVO1f0Zd0DkdZPKanZR/8uZuRmjAfEP9EEDQqpAXJxjYutjPzcQfnIsFzASFzg5z+bg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DBAPR08MB5815.eurprd08.prod.outlook.com (2603:10a6:10:1ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 11:02:58 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::25f9:a7e6:422a:da43]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::25f9:a7e6:422a:da43%7]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 11:02:58 +0000
Date:   Tue, 18 Jan 2022 11:02:55 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20220118110255.GC3294453@arm.com>
References: <YbD4LKiaxG2R0XxN@arm.com>
 <20211209111048.GM3294453@arm.com>
 <YdSEkt72V1oeVx5E@sirena.org.uk>
 <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com>
 <YdbL5kIzi0xqVTVd@arm.com>
 <8550afd2-268d-a25f-88fd-0dd0b184ca23@arm.com>
 <YdcxUZ06f60UQMKM@arm.com>
 <Ydc+AuagOD9GSooP@sirena.org.uk>
 <YdgrjWVxRGRtnf5b@arm.com>
 <YeWtRk0H30q38eM8@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YeWtRk0H30q38eM8@arm.com>
X-ClientProxiedBy: LO4P123CA0105.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::20) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f0ba4d0c-96b0-43ce-8bb7-08d9da721f02
X-MS-TrafficTypeDiagnostic: DBAPR08MB5815:EE_|VE1EUR03FT030:EE_|PA4PR08MB6032:EE_
X-Microsoft-Antispam-PRVS: <PA4PR08MB60324E7C93A6B46E984A3E5FED589@PA4PR08MB6032.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /ZwXJPGEDHugQfbU/D23+vdyFLom1ePulr0Ng/zlVv2HFaSQ4LwFIOZ5gVMVkmZ3le1t1sdp5wYEHF4GR2jqVPZgEyvj84pJW1bgGzXFnKgmDQfz9uY3KNCEq9wbH/9JjUY/Y/jFUMp3MI6/m/1luoR+GFrtjPy4tw7L3+kPvxVPSiv+4Hm0YP053+dNmOCGdfkJiq/cHV2pU4fziz9h8VNDVjPAQ7TApUEeJoWa+3muPWG4m7mkGFO0+er/l88lkq95/2I6Fh5JeW/7AFrU1q6uZ2xGfHt3RuMnukM4PtgEhaAQccXYWj5E5k3JAzFKWgv4dP1AuMkCb0eJF+YcreUwr0cocxXlvBEGf0Bc0G6v2f+38TMsGMVUL+8Z27ZzB8Dvag9GS9M+xIYN5eyuLqSX2ANUt5TGTUwLQ2PwC0QHVk74CW6q4k7F1e7uwS539soGpq958lGTMcgYXm58FmQlFqmi4HB3LkFWbebHY8SdW4YLmFS0jW3sbrWJG3p/IPsyJ9csecXgB5vs42gfKs69BROihC9pLgv04J4B9BKVXZjuI3HDxPswUdYstZBrqy9BQvChTXwBQ/+296iWGyE+4qOvy6mpW7rA553aBzpLlhI1hjasvx7ZHZaAHsldwwseItM+gmpt0BnoLTxv2YXK57KgbItWms/zYM5aMn4GmejDzeEzG5MRdBnelNq6fseVnFRyEtoNYmhYA6DI1g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(66556008)(66476007)(2906002)(66946007)(6666004)(6862004)(6512007)(8936002)(38100700002)(33656002)(38350700002)(508600001)(6636002)(2616005)(6506007)(4326008)(8676002)(26005)(5660300002)(36756003)(186003)(54906003)(316002)(37006003)(44832011)(83380400001)(86362001)(6486002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5815
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fd1d2023-430b-4111-260c-08d9da7215d7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmkhlv1upjoHsDtKDVI8v8NpzQ8HvGae3EOjAtcXsGnhByC2gPjqC7XNCYcrrycX4vvFXrh6cRyYyFoGVw+pUl3+MRkfDO4FS/AU9NxNVAZnlYikT7gZ/vdcmFPFcD8ASgVF59ah8flweImoVMF/xedwmhJ1gQGKpSFTb8aknJ217QQhQ4YEaDoGd06wqnuDqzyMn4D7162lUie5B3JZ/S13idpECwPElI+EAxDUDJ4BD7Vpl+z4utcC0RJz5E5qGB8WnTDp7pk53aKpVt6SjjzIQ3+ytX9o01xnRpjtY9CeC3J8uqu8pDpU2reOtwJFDvz9grHZ+lgIS4a3eHzAq0zv6FPmw11vqz9by3KyT9vJwJo7UtziZbXOgdtuF17Qnh86qOmv4l7PU3DXkZut3VLT4BImQCWpU5D+j9AfBhfBcrogCzv+9o1sVgldQHNnUxsS1qNskrK9scmoPKCU0Z4j1Ou+ZAg8o7wE/xN7NLITP7MoEhj3qghjm/y4E+3GGVqPrEVyXfHgvHm9S+pt3FBx6l7dyQrRGv2LMVoy22n6I8JudRXlEBPKL/QvGvTVRkVcwC6KZ2NCdCHzGtZ1waqmpuCKDvb52aqpP/TyY4iXwqRFC4XCYodguaLSCXPVeY5rzirGL/pkzWgfmIPE00pbemvGXtS0GdvRdprzXZ+ZqlgUfmkEyBPURfuC4xILE7cw72VRnI79I9YVj0nAwg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(2906002)(81166007)(63370400001)(63350400001)(44832011)(316002)(2616005)(33656002)(83380400001)(6666004)(6486002)(6636002)(8676002)(4326008)(47076005)(8936002)(70586007)(336012)(356005)(37006003)(36756003)(54906003)(6862004)(82310400004)(186003)(508600001)(6506007)(5660300002)(26005)(1076003)(6512007)(70206006)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 11:03:12.9929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ba4d0c-96b0-43ce-8bb7-08d9da721f02
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6032
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 01/17/2022 17:54, Catalin Marinas wrote:
> On Fri, Jan 07, 2022 at 12:01:17PM +0000, Catalin Marinas wrote:
> > I think we can look at this from two angles:
> > 
> > 1. Ignoring MDWE, should whoever does the original mmap() also honour
> >    PROT_BTI? We do this for static binaries but, for consistency, should
> >    we extend it to dynamic executable?
> > 
> > 2. A 'simple' fix to allow MDWE together with BTI.
> 
> Thinking about it, (1) is not that different from the kernel setting
> PROT_EXEC on the main executable when the dynamic loader could've done
> it as well. There is a case for making this more consistent: whoever
> does the mmap() should use the full attributes.
> 

Yeah that was my original idea that it should be consistent.
One caveat is that protection flags are normally specified
in the program header, but the BTI marking is in
PT_GNU_PROPERTY which is harder to get to, so glibc does not
try to get it right for the initial mapping either: it has
to re-mmap or mprotect. (In principle we could use read
syscalls to parse the ELF headers and notes before mmap,
but that's more complicated with additional failure modes.)

i.e. if (2) is fixed then mprotect can be used for library
mapping too which is simpler than re-mmap.

> Question for the toolchain people: would the compiler ever generate
> relocations in the main executable that the linker needs to resolve via
> an mprotect(READ|WRITE) followed by mprotect(READ|EXEC)? If yes, we'd
> better go for a proper MDWE implementation in the kernel.

There is some support for text relocations in glibc, but it's not
expected to be common (e.g. it is a bug if a distro binary has it).

For static PIE we made -z text ldflag the default so text relocs
are rejected (i think glibc cannot self-relocate those, so ld.so
cannot have them either), but otherwise certain text relocs work
(static relocations are not supported).

$ cat a.c
int x = 42;
__attribute__((section(".text")))
int *y = &x;
int main(){ return *y; }
$ gcc a.c
/tmp/ccOrpMPD.s: Assembler messages:
/tmp/ccOrpMPD.s:12: Warning: ignoring changed section attributes for .text
$ readelf -aW ./a.out |grep TEXTREL
 0x0000000000000016 (TEXTREL)            0x0
 0x000000000000001e (FLAGS)              TEXTREL BIND_NOW
$ strace -e mprotect ./a.out
mprotect(0xffff839ee000, 65536, PROT_NONE) = 0
mprotect(0xffff839fe000, 12288, PROT_READ) = 0
mprotect(0xaaaac2096000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
mprotect(0xaaaac2096000, 4096, PROT_READ|PROT_EXEC) = 0
mprotect(0xaaaac20a6000, 4096, PROT_READ) = 0
mprotect(0xffff83a55000, 4096, PROT_READ) = 0
+++ exited with 42 +++
