Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761B570CDED
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 00:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjEVW2s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 18:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjEVW2r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 18:28:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0F7119;
        Mon, 22 May 2023 15:28:33 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKOJE0021162;
        Mon, 22 May 2023 22:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=t9xZX4pR5VRVmff0VBtwnuqbcXys8lNi8c8PC+aOJ7o=;
 b=3Fz1kGkscKwSpkiwwNS1Pl6nGi9N21Y5lm/Z4VaEevoDr8gK+lCw4AFIT+MalYrZqQRd
 TI0G9n8Njw58+K4WllbwnGzdBX60jOSdr1DzwDc/0UAZnMfvZMb0cYjuzPXH1GXin5aX
 yKvUoS26DLEfqCUs0ZvNQtgVz9NntsxYVBD7Gm0IMXMSJMxDb5+iFounrS5Px5proL7F
 YUCKGU8bWw67ccz8BbIqGI/oNxciQlg3Ib5akC8XfmhDBEBIYe1YAN77t3iy0S9P91Si
 +dATe3J7KWp+YRtBhFTr4LUOajere+6kRBIg74yRU/v7F1Due+zLCThYjbTXsBamIHpp rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bktfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:28:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MMEbl3023798;
        Mon, 22 May 2023 22:28:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8tj97u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:28:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDIU21Z/lDCf1OBc0uJJPbJ0bi5PaiciDz1xKfHoZiAnE/Dyo7uNw0XKwtesKKnzNJdRaA+6OSrdEnSYqE+j8TaMWk/eN2ao6SJWUe0TcsO3WvP/qia49qXy0uwjnECHqCSebrgAtgWgSNRXnBTmvFl2usIqMgcCjq3uTmX12IkND/GJhd1CvI5lZZ++o/2W/2D59uFnPiTgf0+imI0PPrXd1uLPADmKEDdRoN/InZA9uG8diFziNEo0CZ2nNcE5FPL12s3/SmKakMLyqw9Po9r9JNYMpiz52pKO+htyDnnO3EHoeY6mY2K4AiSH+frMDs3VXW9/6ISsx59NAtfpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9xZX4pR5VRVmff0VBtwnuqbcXys8lNi8c8PC+aOJ7o=;
 b=SaSMMLRzgFMRV0ebgO9xf3hQ9LVEKRlUrbb8D1zFjTEjw/tnOHuXinTZOjNnI7hVS7y83MW33Etx0BbTZ7NgqcYxNJnE580wT1yPITGk9cVn2cPifxW6Xy0Pno202ez2KcCrP8rl9pu257ZUxI/D4e6jzXDItubr3AVEpIdtptHIzW46zgIozLny74vl9tFrF+4ua732ZsfuvbdEXkIkh/j02SGIpmp/+J9xovOKJdIDWNcrcVYZX5pyOxW3a+sMfdHXVCUQtQHHdb6h1fn5PiPT34llYGUrODhDKX/aDutRnlDIWumZ7ixJ08WbI37T601rvRkdQm1JlTnNb1600A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9xZX4pR5VRVmff0VBtwnuqbcXys8lNi8c8PC+aOJ7o=;
 b=cN7aKHRgtTMQJwayrxLWC5miuk+LmWZclq8T/iRK2x1pe/f/eCffa1RqAGHGM4eew8MxRQ9Lu5efjk2CKRuxF5M50CSsWuCnqeXUpvGpoIJruANGbWGhxqYw+p5/npLHxwmDxAxKtXbdGBxEapVT8TZi/giUfyrtxngNXG8GXWo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB4915.namprd10.prod.outlook.com (2603:10b6:208:330::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 22:28:05 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 22:28:05 +0000
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
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
Organization: Oracle Corporation
Message-ID: <yq1jzx0m28g.fsf@ca-mkp.ca.oracle.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
        <20230522105049.1467313-32-schnelle@linux.ibm.com>
Date:   Mon, 22 May 2023 18:28:02 -0400
In-Reply-To: <20230522105049.1467313-32-schnelle@linux.ibm.com> (Niklas
        Schnelle's message of "Mon, 22 May 2023 12:50:36 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:805:66::40) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: f57600cc-9e30-4c59-7cc5-08db5b13cf93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HI7Rjdh1lGrf+WBxNJ17d1QTd1gG9oRzKfJYJASQQsJRt8LMtT+0hdeJCcdGzOc5Lbvpwqg2G8A12EFgsuwfDYnXx2n7HBlk33C2C5ZegdRh6RPtPOavdSJrRyf0Q6B07sdMfX2bJJhh8oTvYcmC1vkLLsnPzs5xCNY+m0fP5802cPLdPyUsWZrPiLpu1KHxwu1K+MWdLdN1x+mV0VhCmD3acFcCyvKUu+0/jIIAilMchkCMtCS/p3srQpBo6Wz7Js5h252asCB64vfynYdPTzhv/tfEvdbT6Xws2weJEGK8CJ4mOga/WJKfo0bmVoSyNdCnK2DLWyHwyX819qCunXFuwlWQHOoiliepd+oAM1a7d+ExbYwsaGmbKxebTyhCbaMjejtoI4NzgjyG2tkRGx4BHG9jMuHWnNCgQKExQvwLrlmzdLLT93qUpsFiixpoA9msXoqf174Kzx2IMsbLU7PQHLozZitA7txRgCLQ+FGLW4drCXlnjt1HKBrLZSNylrLj1p8p8FINBiHXdJ/8lOFv7ajwYvpJUqzjpzGXLrm+j4HE9JUiM/QE9hRxlT9I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(8936002)(8676002)(7416002)(5660300002)(186003)(6512007)(6506007)(26005)(86362001)(38100700002)(41300700001)(6666004)(558084003)(6486002)(478600001)(36916002)(6916009)(4326008)(66476007)(66946007)(66556008)(54906003)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wrmL+JMSh0YSbLlWgG1KxLftfc3+TMR8X1Wl7E4EszmnBLul2VvSF6c4Gaqw?=
 =?us-ascii?Q?JSU3917L3PMdJaC6IaKRSuAccbcuUIlMSDe/yVY+zbVf0it0vBwW7lNwgWeC?=
 =?us-ascii?Q?2HMmxfJVxGUBy4GFGUKkELeuJxzyAOVN+6JI+LYNxorUhxOxMpBWhtYudWHY?=
 =?us-ascii?Q?+KK0pyflg7ffbWiWE5mbIoGF87/zr0OdBHuwfPdeDDJUyJTCKDLfdGA88L+c?=
 =?us-ascii?Q?+JiCbWU47pGfaHmUrG5bTZaS3spDMJAb6ggGdTA3xxvirtoNhxlAn2ooHKdU?=
 =?us-ascii?Q?RH0iJJX50K+sVygIM1TaEh6YO6wHHLO0bETE3rjibMC/tE8qm66vVlDIBmZU?=
 =?us-ascii?Q?cX2FaFgzTo9rivOdEzB1SNZOrRO4mr9PP9YFlJbIRi5KdCo4L1gRXARclwl5?=
 =?us-ascii?Q?hByoobHaBuIus1ic/IyqtKWt/zfgxLg8wvotqcpAbcXDoVqQ7c7CgzpOT63g?=
 =?us-ascii?Q?j/HKu9uE3YCxCDK0BicM9RkBs+GNCmTu2WHzOFBrpRzD6ltT/xiJGgsUtzQp?=
 =?us-ascii?Q?vjoVisc5ldwzN6IMqwGPFFq4UzfplLzw0QpqvjnTAXNW0kqCriSz4531VbL5?=
 =?us-ascii?Q?i021BXOWR5XLbaDqNXOoKyc5Dlv7kzVeegnw8ut7+U2mZ+lu5SaWmnK4rsf0?=
 =?us-ascii?Q?jdSoJ8NOD24TYB6/N02LmpR3owBOjzi7St2zd4ykIGasI7WaEkaIE9eoeZCZ?=
 =?us-ascii?Q?y4OniGZdhGFpgFGmS6SRtxj18spvoIxa1EUCcuE6FLzzSH723jM9Z/NdG9d4?=
 =?us-ascii?Q?PuNT2uWNFmM5Nfw0rX1P4siuHO+ZqcapcmERv1ladZWcFCOKnw3lV0xZLaDO?=
 =?us-ascii?Q?+CKGla8LXkKQoIPuRax7WKMMqs+7vK4rDinW0EoIzfcYaboUt9JJsf0bhK1T?=
 =?us-ascii?Q?3CCDHOqBOLKAkxHjiWEWW6QvNYy0sY6iSb+6LTJtTZ+/Soc2zprzbD+oryjb?=
 =?us-ascii?Q?IFAMs9xvR4wENakkxxvd31BM0uxLBB8vT92oOsPURA6FW03cNUE2Uwl5IbFj?=
 =?us-ascii?Q?h4uYS118fxedvjmeydatm2QCVJRouCKyCcDqKQQiStNhEqE1qgR8rFVxpBiW?=
 =?us-ascii?Q?tx4mafRLWauwdGuKMLNRhG9Ogy+pMolZPZ9nX8B2xa4LLEgWHeBX9/9rTjG8?=
 =?us-ascii?Q?ciA518LoLXxnPCfoTGyiKcMmRdYeJAAHbOZyglV0gZz7oYXzyEdAjyJou1ui?=
 =?us-ascii?Q?zpLGB+DEOloI85nLRKK08QEBI14ngE2yjsnB45ecMAFzVBJthsOj8IOwaRFK?=
 =?us-ascii?Q?QcYIrSfcvYgeDObrYmq3Ku1AplDDN7P25/98eWhhGPkIRlaBMqoyZlpSh57k?=
 =?us-ascii?Q?zq7D+Qo2tH5keaofTHb33lLsV2Vu2PXGFIwcepfc9pXtDZp+fihJ4e9lubWz?=
 =?us-ascii?Q?iDKvkYx2JsRGouX/2nPQke32jWHDn+3boQV9nDWRBPSPL24e8i+hVOFqjXda?=
 =?us-ascii?Q?BSOeCq5W+KsxNPNg911bFTRDT63HWfWGjE5Jtmh+KTpx7QiBcLGYsxvmBaOm?=
 =?us-ascii?Q?GOf/J/Omq0Gg0zGgnYzsW8jpullaWcaEP0FAbqxLAzT8KbnhBlqqlFYzuwz0?=
 =?us-ascii?Q?DGWrKgJ1ejmRRvnj6VPlVkA+4olXQywnz56h+F40WMK/038sL7cdj7VvElAP?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tViXEgKiHc8yncaz5psMBQploKriLs6z5Jhf3XxQiCnZb9ldJoDCtZAuxh5X?=
 =?us-ascii?Q?cdlM5KH62MzVNix/8zBa8WBVh/owZh/c+u46YBKd5ACpERbczrhoWN08NtGw?=
 =?us-ascii?Q?aPSYDyZD9hYp/p+Zso8Rony2kOv4cRLcglaEbUGa5SrzIIwZ+ov5wFWx53gR?=
 =?us-ascii?Q?6+AxZMxAFpBl+XOrhRL3USWmGoU5F/0wS59AYv2/puS9kHa37cnIqHOGAhbA?=
 =?us-ascii?Q?KI06sg7yS2KlBeNa7O4wLVU1fKjXIJE02W//Mffpxreg+zqsH209T3Gf9+Lj?=
 =?us-ascii?Q?S5UKX9LRpnm6wrGY8gnNLpmpHHoLaJ4uu3qwY50tZF/x1fCw8UwZpgT8mscJ?=
 =?us-ascii?Q?1eX2Ao6Yd2CDvTOfYdnhWCD656csz2i0xJWN5U6ySTJuXJm39tKdg3i2zXUG?=
 =?us-ascii?Q?H2xyO0/BQhR964xkmKklD1rroRGp8uDdsX5j3tdPwlYESgCWLhFVOjz4NqRa?=
 =?us-ascii?Q?pMAFPA3P8B1fWbZO/SggFaq7TjZdvwRjIZXZvqcqs03oDrYTJPpHKZVD+JOT?=
 =?us-ascii?Q?pkISm+AXTEAPoVWnUCAJkS2UoJ9SZYA+HhCZ0h7t8qRG3OLNZ1LNmX8sa1xr?=
 =?us-ascii?Q?mLDIHpwZnT8mfKNX5MV7HsVtHBX680rSmFdSzdIFICdbU7tJalKLZUoD2908?=
 =?us-ascii?Q?oIV1m8nUIHFL5wBye1f7iuM4obAW4Zy+FeV9vYMZttI6j9FvVlJcsNoi8tMK?=
 =?us-ascii?Q?wUVt6A7nXWVkfHa3QOnBvbMZNvevj3DXvBH/Z0mRFeDOKUX2uqyR8O3lu1ox?=
 =?us-ascii?Q?aHO4Zvw78fTahnWQef8m3nkYlXd1ofHMMQXZv2lIA4+ZUdRgDqzY7NhNcRi1?=
 =?us-ascii?Q?IUfHcM9YXF2+/esUkby7XGG/FqASJcz6Zd/Xon6De37XeUoKjLOYF/Ki9Nej?=
 =?us-ascii?Q?1wLhiJmGLfvad2LgvMQ8R1Tg6uTA0zWPfaAzb5/CJagt2v1004tT3jXAwYDU?=
 =?us-ascii?Q?0QrbIXiDFTN6+J9XOCwkKDgQN9b5Q/yBBOt9PXSKSVXXmnJP5TCI5sgxT0s/?=
 =?us-ascii?Q?YHGaNW6itvXt5N4SS7mVaJiL0RBYsqQeXzTH+U1J2/TOJdPfk29LJ2dMwURl?=
 =?us-ascii?Q?E/0yDG+z8zK9ol1QEF4pcGh4LEkjQOLZGW/BkiqisT4YH+RNJVhquO8/PY55?=
 =?us-ascii?Q?TskGCSXXJgEYpFVR/0xrky7qK4uctFtkSRVflioLF0flHUVzx3Cmq/zB9pcZ?=
 =?us-ascii?Q?DDdCaVSQf5TAzR9SSK+dHgqKAtlYTDY0asUVuNWHFzXdvcR+VygfIxES1mBW?=
 =?us-ascii?Q?gIM4teE5JUswTlJ6tGSl6BMhp05Q9pP8TD8me9/aTw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57600cc-9e30-4c59-7cc5-08db5b13cf93
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:28:05.0457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+ybXLD5D7HdBILLbFpxfdY6O9YNPsv3VzIIHEwOlGueVTCwjTR4SiHaCXuq9/0h5VAfkNAorFrsG4/nHMv7zbwGDLS2u6pSK6pj6Kdj1jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=816 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220190
X-Proofpoint-GUID: mKNYAnqysQOvW40e8wBtpr_gCA2YgNEe
X-Proofpoint-ORIG-GUID: mKNYAnqysQOvW40e8wBtpr_gCA2YgNEe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Niklas,

> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.

Do you intend for me to pick these up?

-- 
Martin K. Petersen	Oracle Linux Engineering
