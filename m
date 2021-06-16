Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7E03AA0C5
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhFPQGW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 12:06:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18040 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230318AbhFPQGW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Jun 2021 12:06:22 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GFvW5i016469;
        Wed, 16 Jun 2021 16:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=I6llXk1+2G5Smd6EsvMRPJbdlc8J+PwKF4CjMes5MaU=;
 b=GWtRLNSbnB3yjBuBOgehJCA9ySC6nyFlSSjWXyPxiLhKOo3Q59ZMCIFc9eJyKOgjpEji
 QS3/sMrt1its0kgjuqwN4hiteRPsqYtyqxcnUUT+sxQH7KZ27JPO1v7VVPZxmyn0zDW+
 xvVQPyIbvFbrHabePRQWREw10JRLIUc2Dx108xBEafk9bi39BxdeUlLzA9wKlCI8JBj7
 7rgRxcGYKQ98g+hRGiC3h5apBz1HhTiDtM+93K7FSKnKkSYingvxnrGoz37czbOKnt/5
 Zw0QApwiGOuwIS+XwLxrWS48Rt4dp1cLejVXwBAIuA4ni0zZX0gr5cXpnYaG92GdLgkG NA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 396tjdtn5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 16:03:35 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15GG3YT3019839;
        Wed, 16 Jun 2021 16:03:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3030.oracle.com with ESMTP id 396waukedy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 16:03:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoX+Ik3wNI5EyD3O+87ZKZhMFlC8ZRP5jLbWVIJ5anGOP+QnxSkGOAQHpUK303bqOEiaIEUd0fUwB4G4Ioz+PIE1BLw6x863coDoSYuVEUfUPCTsot6sVSW4SnTlLKNHiny6eAQh4rPYuUcmfF4tNz/GlHq3z+NEEqwsxJLpVjDdajqCnOjrHycWEtJ7O3I4ioqGXhl7CThkeJQgsZrqxd5Hpz0kb7bJw8zdMWRd+AzYpkVHgaq/3qjuosUiE4rmtBqnFtlDTC3LZN1x9uteAYnLG7pFh83ta0aMWc96AVaVhGyzMtGhN59/5Tn6H/4W1NRCDMERvNRbp68CPuo8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6llXk1+2G5Smd6EsvMRPJbdlc8J+PwKF4CjMes5MaU=;
 b=At5jzXjxxAAI8FbgvtOdYd9rWkaUGuVRSrf3bR1M8K6NVIO4LTBKs69ARh20gpxKUpzU4rHfGMbKc7MpFo2qg0VARxyTtfxHz7Pnh79qUcqK7xdP9bSOpdlqTbxl+lkFoXmmxao/xC4h88qVUtu9fnJo0/G1whXqPl3NpYU273j66gYtsM/KVSCpMqqkkixvi4lwwagf8W/PZSKf4GWito/iNlzTa1j2hRnFqqqcRUjwr6MjM1QuE7R75PLQa/bYLWQ8trT+tGwvT0HW0++19omriAolprmQ0EKyWdLmc9c8fqT8pw4tbA34LGafiILcxJUPwXL8bEbRKxKpu5zV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6llXk1+2G5Smd6EsvMRPJbdlc8J+PwKF4CjMes5MaU=;
 b=ouyHuRMzxPuIS9HvpAX85DumNgjNvTh+XE/7Ne+n9ks2QvaQ1fpjoc2aq0EcQC6hJx4zIPiW73bvqRzMi3/RFLRCCAm0IIk5Y2MlCc6U8SqozlQp5xC4YfORzBMkfdvdtXvojUmYP5a4R01/cxtYylzNg+WOTpCyKB9DQ7LRCZA=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4792.namprd10.prod.outlook.com (2603:10b6:510:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 16:03:32 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::4c61:9532:4af0:8796]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::4c61:9532:4af0:8796%7]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 16:03:32 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: switch the block layer to use kmap_local_page v2
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wnqt4x1q.fsf@ca-mkp.ca.oracle.com>
References: <20210615132456.753241-1-hch@lst.de>
Date:   Wed, 16 Jun 2021 12:03:27 -0400
In-Reply-To: <20210615132456.753241-1-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 15 Jun 2021 15:24:38 +0200")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: BY3PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by BY3PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:39b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 16 Jun 2021 16:03:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21c9dfe5-5cbf-4b3f-6912-08d930e049db
X-MS-TrafficTypeDiagnostic: PH0PR10MB4792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4792E6746C4F34A54D13330C8E0F9@PH0PR10MB4792.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmUD+JEPTsSnCCiZ2ZdhwlfPbiDpM/oYyA9XIn1pnIled7TOnu0tXcktl8cSP2v44KKAlm92+tbYoL7d4o6i1spd8sgzWWAuTYJqG2MXZ+Ib2eLdZe71bk6fbJRGxZx3OHuTEFIm/zgZDsLlrNk9fsEvG1M/gUhP8I/YDA4LyS65bi5rj7wC10fpa7v2/r8IBIXMeYW5ezx/1L7QZlVmJ4hzZw6WYZH5Ne8iq8ilwrbpI3lwSpjgzNKXDRfcy3SAMx8StM0aWo0thKZErsycKbISBHtBeOeUnT26E3tNFM2Twie+E7VVuRj9szvxe9FxH4KXyfXk/TCqKvKTZYr0Put3K6wt4l6pIWKsTB15SAi4jPqZhHS9Qh17XZxK0kYIax8/+/QSCx11rnY8XdiG9RHQn0OpuCP3EnK8Iko0zD2RP5lioUIFZzSjW7CqvaeANaR2MFeLqRtke4UdGSCMZIv9nC+d1E2iW/tr8D6nrdd91tsUmNq/KCdTDnr9tP0sT/Yx5O+yAUK1JUzlYxTA5Vxn65T6usLQVEHi56DHOqdEwUghJc3dFa1TzRdfp4rUBsa00FmKjuU4Z14RNqcfupq60YNCpxe3L56qvKG5FnhO+e5X7zG7i50M0431hlXKHJrkoCgFt5LLEgouvvunqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(6916009)(66556008)(36916002)(52116002)(55016002)(4326008)(66476007)(4744005)(7696005)(5660300002)(7416002)(66946007)(956004)(498600001)(2906002)(8936002)(8676002)(186003)(26005)(38100700002)(83380400001)(86362001)(54906003)(38350700002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zHmGVe+ALXTJCFUdUHTNkxVmzHeCbrPdieRoU/7tnu8IePI2dRLXAWWWYCnH?=
 =?us-ascii?Q?WmHPxt89EkrbYoYDKZkQ1hLVF+QzyOiTqZ9NqeLKg32AnReYyOwgSO/h0WAn?=
 =?us-ascii?Q?bgltbTFldtlUcDoTl3bmoXhMRyg2MsjLDPaX3LuCJEJ0OA4iHdqbx0+sk1bN?=
 =?us-ascii?Q?bDf2WQNV2eiPaiEwMkmk3mptXrO496x4jufZY+d5UP1DAFOBK7qbL79poPXI?=
 =?us-ascii?Q?CCK6NHCI4d5xxXeSvHuAy9cPAagT1afOjQ9RuV5u+z1MOVbLo9Hjoi5oHpu3?=
 =?us-ascii?Q?KQVfVOlA6xomXG6xvN8QsisyWnheVb8WC9wzBI8DGNB82xe8nLU/0SdwGNdz?=
 =?us-ascii?Q?o8d9P5SIyWHoy5STAPVtG1iBQwHDetSPKlHpuVVIRdoCLqIjSAldWq6BYJ15?=
 =?us-ascii?Q?0IWwDvF3e5ZhLe6Ss85ivT1sECZ+pJUiM3xPBD/copE/EnG2zKIkMaI6k7yP?=
 =?us-ascii?Q?I2je3QoHY7L7aj0REPIu0bpSvVcCzR7UpwtuAziBlpzZWGTaXfdrJIp5O+kT?=
 =?us-ascii?Q?poQT0KTjYPegCeDVACmSYNiC1pttl9gtKS5cxYZmVcTFt9z1MVC0/CsaE+Is?=
 =?us-ascii?Q?yDDwyueYC63NxymdXMbubi/arKuSXXUa+7eBxDLhVM7q0Uscc2f8mAWYG4Yn?=
 =?us-ascii?Q?ZUUi2fZ1kTqx3Ji08rERThOhk59iXPRs5+M1ejz2yC+HxpppZEE3/8xXI+fY?=
 =?us-ascii?Q?Cfr+ZxWZVUi1AHyMfGjiWowurinj3FWYvl/j486bOjKiZccmcUBpxQND9E/6?=
 =?us-ascii?Q?R7pOYuHye2vGQEZOk+6TQrVTdgBhMvfQUK/x0TDpF3+4K8NDzZRzHJSoc5fy?=
 =?us-ascii?Q?xpsGKNe9b6lSnhHKkgek+IAUu7u3xTCWdpFuplqrredg/AF1zGaUCimI0kp7?=
 =?us-ascii?Q?Su8OIAM4UCgyfUfgO5qWct517wkAmbkgCcaKCCV6SxHrHBvQkkyL8fcCjW4c?=
 =?us-ascii?Q?aa8a3CLoaWd8z4uXlhEJ00sCYhokwepJF+uO7c0J+/xhVAj8DebJoXrRlSxJ?=
 =?us-ascii?Q?c4WGo0gkMP2MxVEpWU1+TMYb8xBNdGmtEtMZI9o1rAUELNYtBu/Ibhr0Dx89?=
 =?us-ascii?Q?GAaJ6rDjcTzdyqdPNyo/Qmo+3naKV1JbkEU5RLSSj0joIv4kHlhNNkz9y8df?=
 =?us-ascii?Q?wb5v+Ui4Xat477qCsd9m3LC5MOU7Say/Vwkujt8kv3o+yfzrMmQfi9Xpf624?=
 =?us-ascii?Q?JQbQLyc65+9bDgAKNUzaolmoDGpyDBCMHIcwDaO1LYPRRh+CWb6YaQAv9V6p?=
 =?us-ascii?Q?NKXTJpkXYHhLpAUWP5e7Z41W9tX71NQx9PFxaxyphxnFrSIM+M1VIpmg6ZYm?=
 =?us-ascii?Q?5bwEFau3mTsQhrv9Zk3RGjAL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c9dfe5-5cbf-4b3f-6912-08d930e049db
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 16:03:32.0614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/7FCid3FO6EEMrDlCLiNW8dwVO0QoyaXBqibk+OAZwll9U4QbE2j7w8UitSVaadOAuqLIWRaSIYs4t+tWqCY4OZAmGxYUmWuRe3e+cb6wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4792
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160092
X-Proofpoint-ORIG-GUID: 287C8opapJSjkChRqFXQvASCFz49YKWV
X-Proofpoint-GUID: 287C8opapJSjkChRqFXQvASCFz49YKWV
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Christoph,

> this series switches the core block layer code and all users of the
> existing bvec kmap helpers to use kmap_local_page.  Drivers that
> currently use open coded kmap_atomic calls will converted in a follow
> on series.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
