Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD03BBCB3
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jul 2021 14:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhGEMM4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jul 2021 08:12:56 -0400
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:16354
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231183AbhGEMM4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Jul 2021 08:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1fZD1hbncURXBcqnoJm8q8xz75CySPE8SuxpRq457o=;
 b=ztUbgzHMV2Cob6TgOb7q9+egLj459EfAFu2iqksLZcmGJPtCEtKNy91adUNZ1M7DJLMEsO0Vm0gq4Om7ij423hqb0/nKJc8LU3UvOu73qb1R7ZV6XVuPzxTyujlZzgWHGEjQm/C+eVdeFCaIKf/4dRTHAQb5EboXT7VXku5VgQ0=
Received: from DB6PR0201CA0022.eurprd02.prod.outlook.com (2603:10a6:4:3f::32)
 by AS8PR08MB6869.eurprd08.prod.outlook.com (2603:10a6:20b:399::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Mon, 5 Jul
 2021 12:10:16 +0000
Received: from DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3f:cafe::8f) by DB6PR0201CA0022.outlook.office365.com
 (2603:10a6:4:3f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Mon, 5 Jul 2021 12:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT023.mail.protection.outlook.com (10.152.20.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 12:10:16 +0000
Received: ("Tessian outbound c836dc7aad98:v97"); Mon, 05 Jul 2021 12:10:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 72e70ede4ad502a9
X-CR-MTA-TID: 64aa7808
Received: from a393e40d3c3f.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3D098805-4CB6-47A0-A0AA-0075F9E4D17E.1;
        Mon, 05 Jul 2021 12:10:05 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a393e40d3c3f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 05 Jul 2021 12:10:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFVJwG2t4ooxy1gke+vHNW6BNd3sF/Vhp2kU+RdvkjOnfkRfInjsP1QPSlPZV725WdDsiJZoIWwcmiLuaSL6eSJNvK0CXSOaGlBVL1UAHnzxWZBn3CFQLqZSdPr1SOOM6npWKcYwGIRfPcF1QnfiYij1b5sVreZ89n7UUYrojo6Ie2XRg6mFkt7CRnGqIwDgtGOIkrHZQ2gqFXlhAyU3En0NaucdnrJqAdBDGN96aFBNH/LwZYtdsC9D6p9DL/7CFQ79/c/r2+3hruHAi0V8GRhFjRvYBbYswRk6JgjdrBxis4j6KsV6PDzj0FghKHRmllVy6MYwuU3gyiiVhTOCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1fZD1hbncURXBcqnoJm8q8xz75CySPE8SuxpRq457o=;
 b=ZL/1kIxl8cWKDegoLHe/fEz/7DkOB56e/q1X1euMZFv98ztJZZMTnia1v+l4VPjIxGbkDqfiPbUwEtGWqvm2xCFUUb5jsXii6fJTHobOK+mMuKNIoykovmdW0cb1zXcCr13W1/GUggJNMTMfDTSQdlWoeIBAYSeHNw1EewMXPAUVk//HXegW0xUMmNrOYCI8zbU2VXVMB6lIfw5KcYgrp4XmI0KRGtuU2PNepwPgVCGV4TfZABA1g+S8UkVNtxoEWuE323kG0HFHNy7H7oju4l759TBbflMliI26WpKjbCoBqAmajAQjWGk863IS8maNQDK76ppPJeoUHn+o0p9itA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1fZD1hbncURXBcqnoJm8q8xz75CySPE8SuxpRq457o=;
 b=ztUbgzHMV2Cob6TgOb7q9+egLj459EfAFu2iqksLZcmGJPtCEtKNy91adUNZ1M7DJLMEsO0Vm0gq4Om7ij423hqb0/nKJc8LU3UvOu73qb1R7ZV6XVuPzxTyujlZzgWHGEjQm/C+eVdeFCaIKf/4dRTHAQb5EboXT7VXku5VgQ0=
Authentication-Results-Original: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=arm.com;
Received: from PA4PR08MB6320.eurprd08.prod.outlook.com (2603:10a6:102:e5::9)
 by PA4PR08MB5902.eurprd08.prod.outlook.com (2603:10a6:102:e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 12:09:54 +0000
Received: from PA4PR08MB6320.eurprd08.prod.outlook.com
 ([fe80::ac83:9f8b:1a5:2c33]) by PA4PR08MB6320.eurprd08.prod.outlook.com
 ([fe80::ac83:9f8b:1a5:2c33%5]) with mapi id 15.20.4287.027; Mon, 5 Jul 2021
 12:09:53 +0000
Date:   Mon, 5 Jul 2021 13:09:51 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-audit/audit-kernel 
        <reply+ADSN7RXLQ62LNLD2MK5HFHF65GIU3EVBNHHDPMBXHU@reply.github.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>
Subject: Re: [linux-audit/audit-kernel] BUG: audit_classify_syscall() fails
 to properly handle 64-bit syscalls when executing as 32-bit application on
 ARM (#131)
Message-ID: <20210705120950.GK14854@arm.com>
References: <linux-audit/audit-kernel/issues/131@github.com>
 <linux-audit/audit-kernel/issues/131/872191450@github.com>
 <YN9V/qM0mxIYXt3h@yury-ThinkPad>
 <87zgv4y3wd.fsf@oldenburg.str.redhat.com>
 <20210705093656.GJ14854@arm.com>
 <CAK8P3a1D-NvZ2Z8r3RnxKVoT7yPnnqN-ZLrMa9UM13y8==OK6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1D-NvZ2Z8r3RnxKVoT7yPnnqN-ZLrMa9UM13y8==OK6A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.55]
X-ClientProxiedBy: LO4P123CA0100.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::15) To PA4PR08MB6320.eurprd08.prod.outlook.com
 (2603:10a6:102:e5::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by LO4P123CA0100.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:191::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Mon, 5 Jul 2021 12:09:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f97b92b7-ce4b-4c81-c84f-08d93fadd9ac
X-MS-TrafficTypeDiagnostic: PA4PR08MB5902:|AS8PR08MB6869:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB686997A7D88EF193C8E99CD2ED1C9@AS8PR08MB6869.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Op1Bkkq6AqXxeW7wyaOPSZE8FYoSxBjc+5We7Jo7av/z7Nc1WMlSJYJYy1r7umGolZ6m0SfFFQppaltyPQ9xkYkihel4YzXi0F6NT1++EWNbF7hbLLjhqLgOayYPl2aIzrlyqR6JpbeDEsrz+9ffH5zOgyGWOzrK2V9WWDMSLKgSnyGcXZNkZCGmacOgmgmvVzsk7s/pq3kp3Q1Qd30HwKn+NsBTPYFL+VS29tOqekYLLPCyouiKybfrG3l0j/t+JeZsCJxIP6bUvNitx1zhXdDU5QrrtneF7Jdh2PmH/2GbgiGea0s37j60CH75tlejVMHBZa59FlO4NX2fSiA9HH8oLvLISjXLPCZb3M5L9wC15kstokxVUu6bBH4mn9EW4gSRQqnXv5uCrccfxyFIdxOJV7JuokcQfhsDDq/JOsw9UUFkyKJhGxtcVwEhXp6Kg1dB8v1Hte0+Uh0B5pko+Zvh3+6MRywPPCyr+v2ndoxNO8bREgSToT1cS0Yj/Ib8k+1hW/GXFURxRJH+WR+RcO0/lIr8vZqIrliBzWFvI327ZbN8ZiB8HAHmAWCOajFPLhnHiMZgyxPfaXvkXmSh+6Ee9ZUIw9C8C02pCAhwSPgtxS+hIzFE8I199jBAdXjDFZtoYuPwuxm+z2CljiOOGfc4oQeVlCB0Dk4wo5aOz3lBQD+yy4pmELiBR6l1upO4yqsQFDbvDTLYNER+pBxsyA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB6320.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(478600001)(26005)(6916009)(1076003)(8936002)(86362001)(33656002)(55016002)(8886007)(38100700002)(38350700002)(16526019)(5660300002)(186003)(2906002)(83380400001)(8676002)(4326008)(53546011)(7406005)(66556008)(52116002)(956004)(7416002)(7696005)(54906003)(44832011)(316002)(2616005)(66946007)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUhCbFJ6eS9TQ0tHM3BLRjJ3a0RWbzJxWE53UVMrL3J4enJndXNyaVZZbVQ4?=
 =?utf-8?B?U1IyT0M4NjUzNkJPU2JnNzdYWXBZc2R4MExINytiWmk2QWpuTUo1d2RjalpI?=
 =?utf-8?B?cnAvaEp1dVBnUTJVNDRJMlluS214bGFQWk1Ta0JpN1BHT0ZuVnp0dENZOW5O?=
 =?utf-8?B?NGx0T2R4T1p5Y1oxNm5EY0xHemhzdm05MUY4aVN3RkdPbW04VGFCa3BOdUtX?=
 =?utf-8?B?S2VTbElINDh2L1ZobjFYQ3JOS0w1aExyQ1FTZnJOTDRaMkxwSGMxV2Exc2dh?=
 =?utf-8?B?WnhVOWJQOTg0a0duZnUvMk5pUEpFbUNPekxoY3piTDlEOUlGU2hEQjcwekJ4?=
 =?utf-8?B?Y0xHVWw0Q0p5WEMwN2tFSUNicnZ1R2dWRGpueU1JRm5seVp0b3FpcllYRnZx?=
 =?utf-8?B?aDZNbVVhdmF5VitCUjVHY2JvTDJRV0VyeHhObXVuUURDeUFqTDFzNmt4NmNR?=
 =?utf-8?B?Z0pieHZpUlYzUGE0R0MwQWpwV0M0S1huK0h4NkdLN2pHODFNZko1WkpmUUdL?=
 =?utf-8?B?ejlFUmRoYTA0YnRyT0hHK1pZNUhsNjFuRnJCc3FCS2tHQm1xSjVaV1FDOFlQ?=
 =?utf-8?B?QXY2Qm4wRXNZcDY5TzEyM1IyWUhBckFubXROc1VPMVRLQ0poYVNRUGVFQjNU?=
 =?utf-8?B?MnJXMXRianFZa2JrZERlS1N6VlhBcXhJdGdLKzJJSjY4ZVg1cm9iVEd3LzBy?=
 =?utf-8?B?K2QrNlE1TFVEYmI3SnplQ3djZDNBVFZGSlhvUWtCcEg2VG9OeldobUt6R0dt?=
 =?utf-8?B?ZkxuYUp2UzRYK29QV0xRQWlPTE9QeFViWjNTTTFHeHVtMjEzQjMyZnNhWGl3?=
 =?utf-8?B?bjlVNWJwTDBHRmZkYlg3WnJGOEZCMmtINEVzNzlKdTllWW9Fa0hROVZGQVJj?=
 =?utf-8?B?cU5zc1hpNGg3UUxxZ2hrQ0dNTGd0VXdDRzRvQitrQWx5OXRWcllSa0lhMldM?=
 =?utf-8?B?d0wvdFppQzBUVE82Wlg2bnJyWWp5emNkRjhTU21VUUNxSkpJL0Y0anZXYXF1?=
 =?utf-8?B?OWdUTFFVUjh5MkJsd0hsWmM3KzREemdNd2tCMlhOcExOV0R5dlcwdm9jZUFQ?=
 =?utf-8?B?UWl0YmJPZjI3dFc4SnpJaDlRMWhaK3BxMXd1d1kvWGdaNlQ1SlpMNVRFS1lE?=
 =?utf-8?B?Y0IzeXVKcjhBamp3cnZ0NXhJamJNb0V0NXRRU2xDM3k5NXFqNnU2VmZ2dXln?=
 =?utf-8?B?UlYzeXhVMXZaT2RudUJtQWhjWWJGNWdzYjhNeExhcE5naUYwako0UU41QnVX?=
 =?utf-8?B?MzltekREaHpuY3hkZFA2ckhMeHNWUk1UaHFQdGM3cEZRaFg2UXBnbmRUdGhx?=
 =?utf-8?B?SFNDOWM4WGgycG1ESGkraXp4Z0dXbWE1UHlTckp2SlQ4bmtBY0R4S3d1S0U3?=
 =?utf-8?B?WWlFYW15bGt4UFBYN3dVem9Ob213REZVdllCcVpGQ0dia3B5bkNwS1RYV0pI?=
 =?utf-8?B?WUtDRXJpQmY5WnIvQ2xITGxoMTZlU2lFbGFXakxnblI4elpyTFBpOVNwcUFF?=
 =?utf-8?B?Mzc1NlZoTEkxeUdtT0JPUGxuc3NsV0ZSM0hoeno5MkZNazdVZVNOQWVBYnR6?=
 =?utf-8?B?bDlRM01rWDJJNm1uZldrNkkyY2JjMWNNcHpFMVhKc1pOK1BzcUVQbStKN3JN?=
 =?utf-8?B?Ly9MY2FpU0dacVoyeXF2WU1FL3d2dWJUbHFRUkhhcm9tcjJRVTZQdGxwQk1R?=
 =?utf-8?B?KzlyNzVWY1hGV0djU05DTGhhWEZLSkprb0RSTThhdzh4RitOSlVzN09SWWtx?=
 =?utf-8?Q?M16unURnTuQzUhRsk8iumgLwRPrWSCs/WrvTJoY?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5902
Original-Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7fe4b470-435d-4d3e-2d72-08d93fadcbf9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: moq6hBKHWTlylqq3hhAHGJSv+UCabmQnMLt8r9zp1hu+1pohhTpWfGFUJc8IlM3f7Gu8H39Tnme6RWTg1WVBQEVW1RfjtaSZCyZCN+WnpnT/ESEKhOrqswfFnnDdO1mL2Qk5wTptZfqgNE0ExcfQaeHamHZdNsDJ2fiaBpRrFw36+AJOotog8HO6Zby9iYo/YV6JmYaqzdpv9wo5tA54+7v96mFRLruzoCNtxiE6Y4lGoXrfh8zpXG/Eo1d5jRR91Rue9qd9Xq2HANLL2ceywI8yDqvod8/zenXDDnHq42IBrt++l6nbe6WhaFbM3AOusjXqcCr62wHNsz3pI91SYLT9Un0eIGAm16Fh4XOzZRus5cXpGbHHVj9jG0x8snhLReCq0Fi+jwkAW1BBXlCkuKfcBmTKwD4TFu1kPoDxRs25ZS2mIDpWB4JPMZny4OuJLGsYvIxQC+Ju/d06906hTYqe3XpFTWfqf435KAHykwunD9zwdb95TQhYddAFjQnp8FwqdZKmYymxzVnbK4jwUZjvoBF+6CvyaHPtTYcAFrOIjDYOWbea5ttTMx28fevS+eKLlusSeWHCUzYkH/N39SkMTMumU1W0qibfjeyLJa5QQEqBD5qwRB3ZTYwSzf/i/Jvlv6smHlmCrDF+Iw84bDHoVHFnCqdQoUKc82cwW0tQH00p1runIxHmZ2nFh6kD/eAwB9mdr/2evyBTI7mdfA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(36840700001)(54906003)(44832011)(356005)(2906002)(478600001)(186003)(83380400001)(316002)(55016002)(8886007)(1076003)(16526019)(36756003)(8936002)(2616005)(956004)(7696005)(33656002)(336012)(81166007)(8676002)(70206006)(5660300002)(82310400003)(36860700001)(70586007)(450100002)(107886003)(26005)(47076005)(86362001)(6862004)(4326008)(82740400003)(53546011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 12:10:16.3367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f97b92b7-ce4b-4c81-c84f-08d93fadd9ac
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6869
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/05/2021 13:55, Arnd Bergmann wrote:
> On Mon, Jul 5, 2021 at 11:36 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
> > The 07/02/2021 20:19, Florian Weimer wrote:
> > > * Yury Norov:
> > > > At least Marvell, Samsung, Huawei, Cisco and Weiyuchen's employer
> > > > actively use and develop arm64/ilp32. I receive feedback / bugrepotrs
> > > > on ilp32 every 4-6 month. Is that enough for you to reconsider
> > > > including the project into the mainline?
> > >
> > > I believe that glibc has the infrastructure now to integrate an ILP32
> > > port fairly cleanly, although given that it would be first
> > > post-libpthread work, it would have to absorb some of the cleanup work
> > > for such a configuration.
> >
> > time64 would require syscall abi design changes.
> > (that's likely an abi break compared to what the
> > listed users do)
> 
> The kernel port uses the generic syscall ABI, and has done so from the start,
> so both time32 and time64 syscalls are supported in principle, as they are
> on any other 32-bit architecture these days (except rv32, which dropped
> the time32 variant, and x32, which uses the time64 calling conventions but
> the time32 syscall names).

i haven't seen the updated ilp32 patches on top of
the time64 work: the glibc side only uses time32 on
ilp32 currently, but adding a new 32bit port now to
glibc requires 64bit time_t which means some things
would have to be done differently.

the glibc changes would likely not be compatible
with whatever the current ilp32 users do and on
the kernel side it would be better to only expose
time64 like on rv32, which is a syscall abi change.


