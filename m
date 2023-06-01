Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A859718F54
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 02:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjFAAB1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 20:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFAABZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 20:01:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB78139;
        Wed, 31 May 2023 17:01:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VK8wu0027627;
        Thu, 1 Jun 2023 00:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=J7G5jOKo8IEhHYPGbG39g4HC2+rpeYjF35OzzOHlFAI=;
 b=HEkTMsh5HWeS1a1BrEaXJH5pQEbWGD54O6cNSHjiCe8mSHEdcJNedz5HEBs4IHvJPhPI
 J3DxxXZQqyH65UfubNnBqb9swIII5cZlP28/wKsOBSRpiZ4iQbea3qWL7oq8MgsIIqCv
 tWLE57bbJadISWaO3oK6GK7QNDkkl5RfZFmpFKdWLX8CaOCiVTSZDWMlfMkjGPnshGMk
 tCGeUdaF7ctR+LKp6r3MqUD3QrafZHQImU/PYotNjuY9PWVhNeKPds1KaqsLUFbEo5lJ
 gV2x2GveyjIbUF/NJ6laPNmxVPs0uJmdLrEvuA2JZt4y6c/zHDnp95YtYkdLxbMcatNd qQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwwf81t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:00:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VMjO23004446;
        Thu, 1 Jun 2023 00:00:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ye0xx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:00:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VukdCptIrNifg4ikqWwpytfupdWzP4i9mHK8WOs70+zw1lsFJiMxuudm/fxkMSV+8R+RZEkk5TktUS6KEbaogc0yb6PAQ3/jDaOgVToxmpa+KTQfFNxoSrQPqEpNaUWj7URHh+XbI0jtdHCmqp3USiUT4kVPDqs6w8Bo9lMvV3c3LV/+bBONzHXoHT1qjxg/eWYyBzCKwD81waZ53V+GxvYdJlfu5VLtGIfav+fsJnXY0szCzVhCF7OA3r73b8PYLg6KcLPjHCgnv/o8DeGgBsu30u7tSkjJU5affwSW4ls+/S1lUv4W2ObblPfzrtHFajE9uvQ0+SO6/s92PRjH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7G5jOKo8IEhHYPGbG39g4HC2+rpeYjF35OzzOHlFAI=;
 b=W5pX3O7TBD292myxnTTF5f62gO8oQT4ZluEVqZNqTp3S5RUGIpUwAahP59x4VfE1s8C/2Yi3RGAiQmjfdytQZZxcNYVRFUNSpeF7wEhlpxqeWMAQGo33lCz3gi2tvXRvot+LrQ4FJsNYXBWx5SdcHqQM/Sz6YiRpAG4eM/xgyQsIPC1INUL1L6YUZ6Hs0pwZ0/Vt0j8ewe0c37zjWB9n/RpKWAZftREw6Ph7tyo5Z8ZLov5BOV1H6c3ogu4K4iHTpcO+4pYZQUm77SFre8rG0MX/A15dQea62sp9cjYV379UuryPAtDxqQ02L6hevBut5h9ZVRt5CkaxDXS8O2TVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7G5jOKo8IEhHYPGbG39g4HC2+rpeYjF35OzzOHlFAI=;
 b=KZ+J6ZG9FntXNhKywxUMWUHLygodmOouYbw7lE56Wi1gHzyFUpgkwx2/+qDbkYClIe5h/ytMQQWKKHLchmb0qgrRtNsvH0vM4CZh4FQ0tHVDmFR5OEx6ouz8phPkJeW068IVJWEFrNhb/D2IdksQbh4VLuxdDiHJ44+ZLOUpjUE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Thu, 1 Jun
 2023 00:00:38 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 00:00:38 +0000
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Hannes Reinecke <hare@suse.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com
Subject: Re: [PATCH v5 31/44] scsi: add HAS_IOPORT dependencies
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
Message-ID: <yq1o7m0aw6z.fsf@ca-mkp.ca.oracle.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
        <20230522105049.1467313-32-schnelle@linux.ibm.com>
        <yq1jzx0m28g.fsf@ca-mkp.ca.oracle.com>
        <6aed4e775150097e974076934bb70517664c9cc9.camel@linux.ibm.com>
Date:   Wed, 31 May 2023 20:00:36 -0400
In-Reply-To: <6aed4e775150097e974076934bb70517664c9cc9.camel@linux.ibm.com>
        (Niklas Schnelle's message of "Tue, 23 May 2023 09:26:08 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0092.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d0e140-c681-4b8a-d67d-08db62333b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lxmqhmK8DIYmzGPP7dMHmZ5owb7IpP9/4CeF+2BiF4E6Kdhd1sP8r8psRCorCwtwO0Y0nXUrOq672egnCUrnlBy/nx/pjJCYVv1SCydicdebBQMi5cXtGaL21lzlcmH2OVPEFiSdRxY2swP1ZjnknSUrVtxFAXCJ8tvIsqHgqTRYXntpQ/Twcak7Xwaj9Y+Ewr8GBAeScXgHOoze+XWrourVR87CpC6M+LIS2TOVz3ORvPyHt4UZNt4y8l4tQOLve9Q5Gp9hLFK1ZzGxn1F3ExbHkEhfopxrUQi3iywn7Tu770vRMRLvo9VpHYPkTq1uB4gif1X9JazOKxjWTRbAjGMHWMJuL2nJ6/QuMfD9Ycu8pdWTekTuu9GqCiH0nhf5rncFuRNWOJ2eYRiFlQTX7ZMKq0APRnErf1/6J4s5mvS8p87hqGIrLg4/US5IgU2cLc1jp1WidVAPoNdU5AmXGcUwEJG7HOtmVNFy27udEOKrf7uPzVCVSKocgL9vInU8b+Jq3Pi5sVKRtC3WeOH2NHW8SzACtO1o6jKADuv8B5qQbiFwXHohN1u3XRFnJLDc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(6486002)(41300700001)(86362001)(36916002)(4326008)(6916009)(316002)(66946007)(66556008)(66476007)(7416002)(5660300002)(186003)(2906002)(4744005)(6506007)(6512007)(26005)(66899021)(54906003)(8936002)(38100700002)(8676002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JHchRAgGDV4lx0058rE0AqQ3jWYP5P1WdhQEG4ul70gchS++u6YDFwMoMdGk?=
 =?us-ascii?Q?B2sRBA0p1/rleOoHQ9QSNzTAwldFI556Rv4VeC8NjU0tcpMohHu7dslPqsIi?=
 =?us-ascii?Q?qFDUS1M28n9Q1OZzdQ/2au1Exz5wil0/s7LEzt/enju3RDcxW+0KhUMkgw2Q?=
 =?us-ascii?Q?hkIcWvQsbdkbrI2vRO8rKy+KQJAA33PuGIhT3zuJld97ju9huepQlWtcanyl?=
 =?us-ascii?Q?n+UFZ4UGHhXAJIxOsv1Sc9BzFLEfntz7VWE8algW/LOuVR3EW8noA+DSOVgF?=
 =?us-ascii?Q?s5dRLQZZ/R5C12tleCzXi3m0+zdzsvknMcQteYgnWjzbo+TS2ff0jmxrCl3f?=
 =?us-ascii?Q?oN3UW8lHkGDKVFOpVg5vBr1w6gmT5wJJjCr8z5qbcemkW9Rqaz2dlzuphExU?=
 =?us-ascii?Q?MsEehCb2WzQ8DIgYFhBwaPP1mHcZu5kFjaCcl14iqe63GFEccjTzViCUwfBW?=
 =?us-ascii?Q?BUKzmS5ML5kbMCA0DwvRPavr40WfBkCBUI6AHEMVcqz5+80xqFmAtSVS40ya?=
 =?us-ascii?Q?mqcdj479t2YmEon56y9RZCJcKuYTbd7/AGlLE8DfApXE+94fTeAaIBId3Wuc?=
 =?us-ascii?Q?84Q/h+OKeQV43QJVw9/jh8bkGT5vpd3MK/rHVT+jG1m9aColUAaOSInikcHo?=
 =?us-ascii?Q?qY1x3suybAi6BiF6G+cKSDXiODYfQXhAOoIexI2BAe8SVLBQq1Jl+x74/+Al?=
 =?us-ascii?Q?Qzce8QYKr1xIFm/IlxJYeCjmQvoKlD9pNWOWievcupuXLKY8QPQYdClK0ecv?=
 =?us-ascii?Q?ZVxV0Avv6AA4ODiKbdAZbyEX20fdtUEIM/+F0er3kZva/ChQpMnDuqoON0cv?=
 =?us-ascii?Q?0aqLWnuUQzDxSdXJVG2pGcKk3gwvvneBuc3ufJ9JYRanIYUO4BkhABU5W67u?=
 =?us-ascii?Q?hlzlNO/PbQc/K3BHlPCr6wdCBPR9m02TMf5HyKFUO1yoMn+7Th3mu3hTO9Vu?=
 =?us-ascii?Q?AASS+9HqBJWsgYew/yeVVpxzK8CPd7ihkd1vR7y3dtSbiAr7kTUnsMQA2Tvh?=
 =?us-ascii?Q?pdnqGCwQRSCLBP/+5BAit1KG4h1Yho2OnknmHkqgYJmOpvB8uxuD3fTMPDYu?=
 =?us-ascii?Q?QYONi+eBp3x1EVYwCXAno6u9BiTLd2+Nr7R8kWGfO/m4H/pAzIpWQ+l/EYt7?=
 =?us-ascii?Q?USahH+kPabV3ZOe4SY1ZxgX7LmDqNvlYjVDWiGBQMoL52g39YTIZLp6Uukcl?=
 =?us-ascii?Q?WkxPrsevfRKLIl7jeecz9T9td+JANVN+CZJXFxSBtUSUuyejzusODj4R+9aC?=
 =?us-ascii?Q?1wiTfOLKenoRCBC0+Ea8WKbiv3MOlnhp0ktdBifFZKswGp6JOc1GuTzsHGnc?=
 =?us-ascii?Q?nqVneDy36NFOs2nhnoxLFz/1qd1iqNgpJ/PQBeHF52Cf97IxboOGHfYVuTEm?=
 =?us-ascii?Q?H1JwrriYCBmti4Znz5Rdq/lFLbqRCU3BQJQf19mv+9MigpKrUvggaEQ6qOfi?=
 =?us-ascii?Q?ZLRF+Su4CNbrLTObIkkpPoLSDkYRzfqyT6Rl01Co+jC3YIpNdMlCd9goLd9l?=
 =?us-ascii?Q?1KlhcBYEpRKvdHKzy4ICXZnQiI3QHubYdbAoJdQTEGRQIeiBnfY6UtpYkDA/?=
 =?us-ascii?Q?kRSxA2ko8Ic0/PTR8nMCKA9DX9dRwyDJ0wUL1x7ryy3FzY4cKBU7qAXeiiMb?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LKazVDYjrD8avupEOTn8KoWpPzl/hLkzBQlv/jW8lUG1rr+SQRjsbaxP32A+?=
 =?us-ascii?Q?JNYS/6Z4RMTn8dm7PQmIztFGYnRx7VPf5/G5wiYAFlxH76Rton4xES95lHZd?=
 =?us-ascii?Q?M0w3iTQS9j2JgXUvmU3Qa57PCB8nITadC3bMA4zLFLCLN1Rg0mTro6v86cJj?=
 =?us-ascii?Q?4ksmUDaPkVO6Sp3Wmz6G3k+J6aTewDoCfkKtL1vCRXrJvNC4PY5mztzgwLp6?=
 =?us-ascii?Q?DTOLnTYkTti6/HqCUsm2ERL+BlS5fPRgyzPjo0npWM2jzkfFbDgTtbtrB8AV?=
 =?us-ascii?Q?qc0sVJ4dI68b718W4/tjn8E9G/MAxh0Krw3MxS7CXWdGtSuGyENMeGaX1w7V?=
 =?us-ascii?Q?Iiv4F/WAc5P36soIHs7UqncfVGFc3je/Y1ljxHg+Q2z1l2bJe3dCtZOLmXYy?=
 =?us-ascii?Q?lYHOb7JLbVsCqUQe1hQbcBMFrBDret462EiSj2sJECXjsujqnVxb6yPD8HSL?=
 =?us-ascii?Q?giTqfJ58Mf9MFhuX+onBAxLdvFW98+5aSISF2TFKhODHMn2TAK+t62qMhbrU?=
 =?us-ascii?Q?cT+l8Lyd95ElS0+M4gzcBZuC5DAp87yHKJ+szyki03xy7M80rv4wIGPDb9q1?=
 =?us-ascii?Q?wMvwNhL1gTdPY0PqoFTuQ64kMPURwuE064epj9ojEMUWHm72E905h9ygDbXp?=
 =?us-ascii?Q?KhCC/XKzKvopB+r2pQMCioAMkvHj6sdD1QrpDmOsEaqfTz1wC0NW7OfG7zp9?=
 =?us-ascii?Q?RfgbsmSX4ZgrBG7k6pPtElHo6N2c5w/XnlWZDjres9fstiwAK5znJn2kP0uf?=
 =?us-ascii?Q?3nWGvEFja+RZPc/PPRxsg6Q8Bv3PeoojWhfc89eZWIGnqrvgf2jBbjD1lmv/?=
 =?us-ascii?Q?YAZdfeOX873kOTPyutPU6KMDthu4tAChQcnTP5n7X5o7sEos6R0bnKiacadl?=
 =?us-ascii?Q?cKS+SPEfV3N2Gj34oLuTXGU1803ndr5fHzdg5MQ1LT6pDEsnm6GL2dYeZEpF?=
 =?us-ascii?Q?iUy5OHZmPV+ItgCPIRLlwpNzxuDEHejUrpeuKQu21ylTVJzOBiYDlvRFviM6?=
 =?us-ascii?Q?sOomDJDvGdSYw93fctAOG8H+upuPak0RyO+jn+ENL5ejrEHp8h1NwXwj1yUf?=
 =?us-ascii?Q?YZeUZu38ciu2MjIV/+rxXmnBVwuxH4s3eng8GD/waFXmEa9T24E+bWLXXz0f?=
 =?us-ascii?Q?sZ26+V1QqGHg7BdXDTyl9iwGM6Pki50IdEmIz41z/Uw8d2H9hu9JeUwpgO6f?=
 =?us-ascii?Q?js0BU7S1WIfk0BB9nLiQ/Ojsd4Kzqtau/kiZnuH/vF+w3SpVvtiui2YeRWw4?=
 =?us-ascii?Q?E/psDITdgsJW5XWeiT4K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d0e140-c681-4b8a-d67d-08db62333b63
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 00:00:38.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2ka5W1k7yxkJmz64O8d3CuFoU5Zq9nrgsce+pBzV9rCXQSrZgZXv7aXx6yutB3rSiNlhEfL9nAisckwKJBT1tpyHkM1JWu9l4yGmaFcoDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=761
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310203
X-Proofpoint-ORIG-GUID: OTxxSgEVIzBtR269mg2G3UY4rHIFvrpB
X-Proofpoint-GUID: OTxxSgEVIzBtR269mg2G3UY4rHIFvrpB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Niklas,

> Yes if you're okay with the changes go ahead and pick them up for the
> subsystems you maintain. Our plan is to get as many of these picked up
> for v6.5 as possible, then deal with the stragglers and finally merge
> the last patch in this series that disables inb()/outb() for
> HAS_IOPORT=n.

Applied patches 21 and 31 to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
