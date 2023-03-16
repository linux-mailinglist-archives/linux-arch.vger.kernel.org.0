Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7466BDC81
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 00:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCPXAv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 19:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCPXAu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 19:00:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1977B048A;
        Thu, 16 Mar 2023 16:00:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GJmQje015284;
        Thu, 16 Mar 2023 23:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=75iGU/rYdMXYlOE/5x/bZkl0FWIY/7CxKAlBVudQhKU=;
 b=lfw+5jjz+HO34fO3F1u+CjQQz0uSUp5MF89pHxcHOwc4WoxgxLl6aV6Ntyux7omzJplx
 ISQZVXyNCzX1ZJLMdKnV8fD6+zGLdaZPZ2obuk1Yu+PteOPtZaDQy1AaQFf6ymx1N8aF
 s+zvaxViST9zCMJ2eXLsk0iSFxr8Fp69oYabCZulxZ4FhgByWFFeJd60DgBVMxjuQvMi
 AqMVS4inBNAXi+plqEy7vv784tI025sNW/yCCUvqHyW7KtH8NEl/uBaf7IKgNOLxVnhr
 vHDFnMbajYuVJphe6EhODx39pY5YVpwQCDCTlBp5xoKQT8bE8Cfs1ngAXaEUno2m2WbM bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29jgry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 23:00:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32GLsDqi002987;
        Thu, 16 Mar 2023 23:00:08 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq45gj19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 23:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgNN+JdVynDCnDcnAjxD/ghAlQ4Hszy0ZlJjt7i0E3ekeWSWF2jfqsqI3faL3aaSqFQZlW6nKVePm9jaDcLAsEFtlTvWx67FMswCXYeJ2uFM4RcBRMbcfftTws/aFpRPwJtVFs7lsgP+QNlTJscvgSSRrUSjqOIxY5StlDn6Wk5zHiAW5Jq5PHMoyInPGFLubDaxZOr1OV00hql+6y91jcwfGpV66K29zgfmOsiB+rbYpuSjUGsOyWouKaCknIb7DfD5+49WaWt57nK5cEcIIZ67XhhxxonBxMNA2GzohsrMqUmVaYEmadTFUFI045PL/bFifM7K80+SvH/JpV8ebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75iGU/rYdMXYlOE/5x/bZkl0FWIY/7CxKAlBVudQhKU=;
 b=N2jZNLD0zg8avXIS6m6+PB3NKcfKvjYSHchVQf7RRA9wj4dGqJkt1cKCxftpzYVMwlaoM0cue4wY6HQCu/uBmx17ibZUkxkfoHD8sbUjMsHv726mvsDYxCk+eHjg5MDeUQaBZTs/9D7lDpF5DWQtdSMgSwFHj8dn0NVBSAw9vVJbLO1dMlm5EMTsCwk5JWAgnXAowTwT14lr8YKt4v7TFBD+WbdL6cPf3bBkpVIEtaZI9IOClniD3qptmwALTGsKIpYamf8klXcp74pU8IEk9PnncAxORbNtNIXu7rUOqDNNQ3Dz6+b4IKbj1Ro/4qxj3ue2Tlir4r2EaaiJDdX56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75iGU/rYdMXYlOE/5x/bZkl0FWIY/7CxKAlBVudQhKU=;
 b=u4lPbW3RwupOV+KR5eXrmGvUm4mj/fd3KIkwxQTjeATEr76w3nMspQD5ILGNtHrO9Nst89kWaFjrNSm5pFcFtEe1zRCSyowmFdJooqZ52wSEAFjGd5af3MsUI9qwPs/dYTVJzUDi73DxQsgG8ukEx1ie2S2uX6aPe+SObxBFDYI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5567.namprd10.prod.outlook.com (2603:10b6:a03:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 23:00:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 23:00:06 +0000
Date:   Thu, 16 Mar 2023 16:00:03 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
Message-ID: <20230316230003.GB6211@monkey>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
 <20230316181547.GA6211@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316181547.GA6211@monkey>
X-ClientProxiedBy: MW4PR04CA0280.namprd04.prod.outlook.com
 (2603:10b6:303:89::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b619786-0a76-4879-4a2d-08db26722f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hE+iAbwJY0U+wpnWNaNjDP8402IrwqeAM8HLxINpK4dqxwJnJQ8Fj9pkij3kSz8OWx4xQQ2K26zOhsIDA/9+9vEk7QBajwYiW14XkIsI76RKavaMSLcrnuDtZ7pmfu7p/c9yvvPusFvXTmA/HodJ72j1wNPtYH/XwpQx0t/kMHliUaP91Ja5sHq3CXJ7GF9eKY2BTAhoSu9omABKEsWvArnPL95it+USYis1YBJ6a9dQWPj3hm3zdILkPzON40/uX9gl+PTmZSsLeFmv6XMntEdK01uaOJKUJrSdIPupPz8LT7zDDoHEIh6rC/Ppa7pJBmbGJE+2oiHL7Ftiij3nxcIxWfZD6QjQQwSVivCG4hxOvOfwlLW1KfGPUB8+9zv1JlvXzjbFPp72x8wo/LCC8iwhxyqmEAXr1f5D5upA/OAFiyilcKInqfl65/vmhq4PDxC04+mi7eA43TaC8PrMG34kpjcIH19Y9gWyBy74QdUuCHeuOhttDI4YHGVtHsHgEj0p5XUjmf/F+wpjZw9XFeqJq2xT8SdTDPYAUCaXl4zpeadUfoNeWyoScWq3ddNf4W6BPaGg61lecDVpYW2WI7cCh9LvHOaBUhgY+4kVjVJEEE7p/PjBboHug7elOkaGdNBbBF7XOdEHG7w3i5Op4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199018)(54906003)(316002)(6506007)(86362001)(33656002)(478600001)(9686003)(33716001)(26005)(53546011)(83380400001)(38100700002)(186003)(6512007)(1076003)(8676002)(5660300002)(6486002)(6666004)(4326008)(8936002)(66476007)(66946007)(41300700001)(6916009)(2906002)(66556008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xNQXuZL4mT4NrQKxPGfUWZeCkZpbmdVQtgAcXs70ji+3h15rY7utxrRAYEjM?=
 =?us-ascii?Q?rBaCXsrLljsiScFij1HOfoXpsOqtAhaNYqdCGBdE5IbT4LbD3MExEZ+tnMQj?=
 =?us-ascii?Q?z7nJozFQddAcG7Y0OWAWETOAngYB9KSpyeLZry4cJMHePo7SXwRmQJUMghGX?=
 =?us-ascii?Q?FRK6BA9yBZPTjYgq7J8SVKVEAdWOXlS2KbkKREmBnUgfxTci4UR1wOESanVe?=
 =?us-ascii?Q?JMy9Af6CilwlTpnbDz+FwTvOojFoxir8YPTRL44NBSMQl01B4GYxJTo+WJn5?=
 =?us-ascii?Q?8b9YfHvmsKiWmBrk4ErAL8hn7YPbU2WJjPxOxmZBgHHo9MBRJe/IfYKTFXEP?=
 =?us-ascii?Q?uikh2AERGU9/upG5ilK/tv7SRuy+6EuEIWyFH7rMNcJNK2RYqN4zm8+sLDoJ?=
 =?us-ascii?Q?Jt/DeXynHFZZQGhC3Hw8sOaqF8H9U4mq+64AWJoOaEBalkjVzIYXUNpqDllp?=
 =?us-ascii?Q?jJ9WUfD/D8ZEfauAzyCyQ9tJwvie+7W64e/o2rkn9l4hHysqADF2r0uf18SR?=
 =?us-ascii?Q?ykEfChyId439Ol1JhtOoaYDUFR5V40wjFEOHul0omRjtpAh3tgZTi7Embhns?=
 =?us-ascii?Q?wKghoRMS5B8Nfc+iNKtusfty8INRL0ETNOB3eFr+7lUYeF+G+metoh4s87pZ?=
 =?us-ascii?Q?ADzVnWsaWS3Nghei83PlhNQulG5vFGwCuuF5QHuJy5mkJQK9XZD3cOSp2L7J?=
 =?us-ascii?Q?E6PuH9Wi2VmnyiK6i8MjPAhApwV0yCGah17lLm+JBbb/dwVk7uvxFLo/ueg4?=
 =?us-ascii?Q?+WhG6qAjpP4bYe0rQ7pTs/nZRFGcsF6DPZrke4UKrnto03qgct+g2w9OpcO9?=
 =?us-ascii?Q?6HpAA0YphMBOc5j/XhR3dh4IYcRyYLTESdXWW7KmXjok/bTywmQ9hPdqt1BA?=
 =?us-ascii?Q?KG9iq/l5RG0tliYggXd3JB+WuCViRr2gK7MA+olotJmB4X3E0C6V2dn8r/AK?=
 =?us-ascii?Q?R3eQPbWXCuMbW85MdbaFl4gUEMn09RZcp2QIsxzAAw4cG3OMG73hqaatyD0o?=
 =?us-ascii?Q?e6YWl2NAKMQb3zf8BE+s4NdxCB/81CdY4jvUjboVUdD+BO7mG42s08FO8bVc?=
 =?us-ascii?Q?hV6bum17/Ao2hnCaKNSOcS6xpc2XgxNVlbSGuKgrOSPQ2mdf9mJ2YX3srP+K?=
 =?us-ascii?Q?+rVQYQjpo2aUJi6o481QoyQ2B06m1zJhf3CP7NARmOd8A8cElGVnPkBKpDrn?=
 =?us-ascii?Q?8ojQw22A5BOzaCzbJqvBt6+AaWd3HlWsSsf03qpzU/eCpDI82qwQsYCRS1xO?=
 =?us-ascii?Q?2DZgE0AZy7sE9hXH6MTcMrJHjVoJnKoSxliZQE1K12opoiW2CNUA3d4IckNw?=
 =?us-ascii?Q?rKZc/yz1WtV+izVsf+cckLx+HOAy6qvN82UPTs6mxPkg2xlIxtKWKmjrZt2u?=
 =?us-ascii?Q?5t7f2mqzncvNX/mPcq9BYbrOk1HKD6Az9O/ixYrzv+8LCCP3ED6xDXShPH6/?=
 =?us-ascii?Q?C64lfeACIB0Ulgn0+qpZerKc6N+rxHlbhEoJLB3zwrZPNZZ+N9stqp13lByq?=
 =?us-ascii?Q?I/CL+/96bM0QbYwQzI+bXxDuGKrl65BAZeav5vtlHwUlPtYyKubphtK9pA5D?=
 =?us-ascii?Q?HFaP675KnoA9BD4ubvJaxEv8Q4Yzv0cnKZWy1mprDCQ42EgugbEZ8cQ1mZzm?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GpgFGT1JpUpz/ivWhvODol0Mdh7zMRxrP/LouKlYfHm4pynfIn8BS6lG7YpK?=
 =?us-ascii?Q?1ihKAPoSPLH1sbd+ry09E9ZjOfMnvkl0rd/KZ1dNxzlyBexv1dAK9WV82m6f?=
 =?us-ascii?Q?m/s2IIw+S0Am3bnxVowvjX1nW2YiUEOWZPrYhl1oPrjNGqF6qkXxb7TutwVY?=
 =?us-ascii?Q?KH9UvOruEBHxbKZc1Drev6qXmLnc5R1ORgSS5+Sv0vLQd7V1oIFs9i70Vt+R?=
 =?us-ascii?Q?8MtQ8vB4zW4rVIc1D8DeYBZf30KVUE+ulhiI47Wfv949Na+AepXESBwvEJPi?=
 =?us-ascii?Q?0dA0PF6kMI8ksoRsOIZ5UFXVhnRlcZ0Xz7FBb+YYrp0d4uUcsvJOIoIzteQn?=
 =?us-ascii?Q?EQvdTXVlBhvr0aGjU3CErnp7UPo8fzBz1386HwlGPaqQ5XiwNtjW8ZBrXr90?=
 =?us-ascii?Q?V41IK/75/b5ZNevVs+T4ujxKQ5D+991GJ7dBfWExW4rZXJlVDpyRqEHVzU/y?=
 =?us-ascii?Q?7iMv2oghHthO9mMayyaP1X4+/Mw4ZInvaQiA5v2d4LeXlyR8nrM3c1PaYK3G?=
 =?us-ascii?Q?XC5L+DsdPsQRMXgR26asTZsl/QpZLE/0dEYhlU2kuLEmDFP1yfd0Cj8x9ddf?=
 =?us-ascii?Q?K/vTh96lmygtTmHNVqk0TGTFQUx8MALlaptpyunt9fUHDvTpmozY8E10PGD5?=
 =?us-ascii?Q?7eLq8KgFb+mXwExDK0Pjxrb8zRCY+dC/YiHBRf/vfPeY9Ieh28xKUabejIZz?=
 =?us-ascii?Q?KXupwxgz2L+5EgJvaP9utZUh0atCThT+rBhRaL2J1BRFxiuQZwBCc03LEMJF?=
 =?us-ascii?Q?KqySuX2/N9bxn2Xca2qmhmVnIrrCLfzjaLZbWaJblBupDdNfqHeiBpT+pVwv?=
 =?us-ascii?Q?UYGbdf3S9vziW4mwFN7AZoiBjpY+fKIzdeETy/FWkT4GUI0c7Z7kLN5R4fQK?=
 =?us-ascii?Q?f9Vw0DBeqintcg5l2QiOBNDpebGedCiAYpNNYRtyW0F/TjA80N+yk7ialZEA?=
 =?us-ascii?Q?16bsrHesdSlambV8M9E3Vw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b619786-0a76-4879-4a2d-08db26722f02
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 23:00:06.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIcf5nqDj0HTVQoVrVgu0VmEtPC6l633mOYzZQrHa0OaApfy5vPD/WTqCto2O5KSeHGv/zh9BATTLrBkxI4G9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=887 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303160173
X-Proofpoint-ORIG-GUID: bN7OBVDJfRpF_OK1Yz1TdeIeC5e3rjQF
X-Proofpoint-GUID: bN7OBVDJfRpF_OK1Yz1TdeIeC5e3rjQF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/16/23 11:15, Mike Kravetz wrote:
> On 03/15/23 14:31, Kirill A. Shutemov wrote:
> > MAX_ORDER currently defined as number of orders page allocator supports:
> > user can ask buddy allocator for page order between 0 and MAX_ORDER-1.
> > 
> > This definition is counter-intuitive and lead to number of bugs all over
> > the kernel.
> > 
> > Change the definition of MAX_ORDER to be inclusive: the range of orders
> > user can ask from buddy allocator is 0..MAX_ORDER now.
> > 
> > --- a/arch/arc/Kconfig
> > +++ b/arch/arc/Kconfig
> > @@ -556,7 +556,7 @@ endmenu	 # "ARC Architecture Configuration"
> >  
> >  config ARCH_FORCE_MAX_ORDER
> >  	int "Maximum zone order"
> > -	default "12" if ARC_HUGEPAGE_16M
> > -	default "11"
> > +	default "11" if ARC_HUGEPAGE_16M
> > +	default "10"
> 
> Is this Kconfig file wrong (off by 1) today?  It seems like it wants MAX_ORDER
> to be sufficiently large to allocate 16M if ARC_HUGEPAGE_16M.  So, seems like
> it should be 13 today?

Nevermind, PAGE_SIZE seems to be 8K by default although it appears to be
configurable.  Not exactly sure how the hard coded values above work if
PAGE_SIZE is configurable.  Too confusing for me to make an intelligent
comment.  Sorry for the noise.
-- 
Mike Kravetz
