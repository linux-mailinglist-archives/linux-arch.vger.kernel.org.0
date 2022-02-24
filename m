Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266D24C2400
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 07:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiBXGVv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 01:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiBXGVu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 01:21:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E30269ABB;
        Wed, 23 Feb 2022 22:21:20 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21O6CReR019977;
        Thu, 24 Feb 2022 06:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=cBa3fX/3kqtFDlW1Ma4G8aMmpFPLROTasCGjla2YgMk=;
 b=mbJZV13lwVKidQDo+wmy4LJ6acgGcXW1WpIJl8AMeXb/gEcAZVYJ4vrKzfKXFBKM8T5b
 Gr/7vRlXM+RONbIuskzavZ7ZMYzDRwJPqhU8t5Og3SzmJPi5Mkq3yHKODmEpMJYXzqYm
 1A2bbcRnE+pcR9LBxXzWOhW7ARERmfGBxIZct0AdtybH3mtYwjV4FjuRan3OpJ+VwACQ
 r8kkjfaBieZm3y32G9QnfawZ0xEd+bSgljQn9rfQYrL337r7/Rxz3RGogRnUFcilWNfZ
 hQKfN0PyPAE9YzBgJjVSvSDNhwVbgRil0umF+paf3LEBOELUb8QkTljA8WP1jJ+ibwYn aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect7apdm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 06:20:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21O6GspE011366;
        Thu, 24 Feb 2022 06:20:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3020.oracle.com with ESMTP id 3eat0qcs7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 06:20:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogMlkLa6nIAowCR3q9Au2nEyuSEotGrVyiVuM31dXzT+WM52ljMnF023TyP3eUMGOr9tqv8nlSjvxYjKekbufhGpCd0JZEycDkyJ2+VjWC+zME07W+WRucf6ga6wdrIjA9ljXKG2V140PHUI7n3KmPsic5tF7rKsL7q6voDCjZ7q0qPJi85XGA7zmH6cAlotkPInWjo+Mr0qqZ4wDwaGJCoFXoQ4ilqTRrv9DFRgeguxF6BnU2TAzwG2S696Bp0q45rtbjGskAPjeMHI1K0tTb3Ts2uncgB7k95mBAMcX20FD7lElpwi6MDixo3oapyCaTH7+RnQb0qloxaMza77oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PW1uceMj5blULPu73slwJYMfhWFFCrlFdBnEBmU7IuQ=;
 b=OIwtApcyboKOlUsgK9C2352GmjrZvhg0DcW1aaEGsm6t4DXB+zqH3h1cTM6D1/mAmzCf2q6KvpgoBpdUKJWvv7MpjUGyJKnAgGJ7DMqWtEL9RsZe47yzuSFx0aBlMgNbzisU11eWjMYFdC1p5bNZAtijv5Fd4O8qgIMhTXfYwL0mLxXbQlpVpqnb1I+6FJ61RkxZuGxyfFAR/rtVfye46GVHl9V3XaVxtb2U7LrBG4n5u0dmfqUewRHleZlUXMhEwRdKfuHpMQ+COrg5f6OVghjPNiR5PzrSjWcxJylpBvB7//XTMSJdkICns/gCaNgVyUqWh611fN1O98gz6QpNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PW1uceMj5blULPu73slwJYMfhWFFCrlFdBnEBmU7IuQ=;
 b=TVXNh8DxNa+zsBhrTueXF1AqS7dSqMKRfyRYBw6UMgcIvQCukZIEjvTDKGbsaSbmvAoKfNOBGD2bUPa8BIZojsS9VSqyPuBqOSpdfghj9p08svLaTfgZlWWfRDIRCv3+rRakSik68YUml1ACIRPF/Zks3kkmpfJ37tiR5hADzoM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2173.namprd10.prod.outlook.com
 (2603:10b6:301:2e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.25; Thu, 24 Feb
 2022 06:20:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 06:20:44 +0000
Date:   Thu, 24 Feb 2022 09:20:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [RFC PATCH 07/13] udp_tunnel: remove the usage of the list
 iterator after the loop
Message-ID: <20220224062022.GH3943@kadam>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-8-jakobkoschel@gmail.com>
 <7ce2df48-b876-0c30-d003-32275c5a9f65@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ce2df48-b876-0c30-d003-32275c5a9f65@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::25)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca2a655a-8a60-464c-1a08-08d9f75dc98e
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2173:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2173C3C247B820798AFEF9688E3D9@MWHPR1001MB2173.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6BRFqIiT5M5/sRMBU8K1rQaRbd1SCtbr9bHA2GuzkoJJPJll2qdl9rOielJMVbv0GF4hq13EkMpj3VzvDYqVEJxzZQyOWbAZSBEwThTjAKlgcDaWAWYhPKE5HkCls025um88QCGR8f2V/dpydsaJIWv0T/9+PLALRbYWsA+r8tS7U3ZkuUvduYgFXfEbIyQJw5ro+PJ3QlP+kr3RYvhWzeinzJwvikzyIAabmVxDfEi/lUnXM1zvj78Erpxt1U+ufUa/vY5QemZsAYJht8FrmT7xKpcixxjmjrYS0H1spfJI6Kywso+zeLd+MXGlBt0opFPl5lzeQTpYfnrn0UakY5e3p452S9Sic5n46N81YqN7dam9gspN4s3D882OI5QsZnE08w8Au035agQSM/EJhqW/X9VtujOIDb8HAyfMJ/20JadASBaON8Ft8+lBNMVisvsTrZ84IWxhfdHYE2/bNG/W/7s5E8xGXD/kT+rtVHIm+hLnFxGSEu1hd03nhIKKdoLkMLgiR+Uh8O2H9ennxgUQQjc1524cc3FbxRqhWc67SLdNgZhmbHTMqFEp6cmUxIdUZeGJg2cTNMQ4qtcNQj17AXpUDJ6Z2Zk4OQB+r9dsnjqeNGT13ite/jpIWphjZ9YWBxlkg0N2BasdSZ73wQl236fd3ATJQg2NeepNlhVms5iOWQTaDuGEMRdrrS3xVF2SkOEO+vuSU5X58Zh3D8vlJc/1PCFGe8nO0PCb/7ZdqSyIvtSq/rXFpQKaS1LZQ7KdpWP5i++yKvQ7HPmYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(8936002)(6916009)(52116002)(33716001)(508600001)(6506007)(6486002)(86362001)(7416002)(5660300002)(2906002)(54906003)(966005)(83380400001)(66946007)(1076003)(66476007)(66556008)(8676002)(33656002)(38350700002)(186003)(316002)(26005)(9686003)(4326008)(6666004)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?x9m4VrDoKXiTd2AhkjXN5AQ4agfS5AXcvhhx+scSvbYhGEoyTRy/YnchcA?=
 =?iso-8859-1?Q?nkHxH4gneV4pldMZoyGZbM5/vjtJ8JT0HbfEpdcBBN6zIfJYkSV1u+UaNt?=
 =?iso-8859-1?Q?5UdvYFMM+O+Q55Q8T1B+qbC6Zw3tRfbIHQmP3EL8QwEg7IvdaNF1NBrcTy?=
 =?iso-8859-1?Q?pbmIsp88JGM0c0sAGD1DJ8Dyar4e3Z2GobeUMv2YNWbeHVKHHPB1Y4s8UU?=
 =?iso-8859-1?Q?XJ68CgBgG1zBciDUOoyn3AuBwffZUV0t6AXcd0jmtnajJ0JjnQ/8GTzEXm?=
 =?iso-8859-1?Q?2qJe+s0uSKylxVxDF8K2qdwe7NKGBjFttmyVxDATFrSLtSvqn6SoOnVKCO?=
 =?iso-8859-1?Q?WewZzcghCjEtRIoKrLyGSRdI5XOaaKeHhdWw+uabrb5yBzZUFMGY6zApCE?=
 =?iso-8859-1?Q?Z6uQaqvWJU5BiSr7Ief81GfEdsEBAJzyex1SMXN4lQcqzeXIE6KFDhUjuQ?=
 =?iso-8859-1?Q?WLksBP9aeMOnflBCSmXFpSDcLLcVsqZoxKgWLw2ACauyvkGOd5W7asWs2L?=
 =?iso-8859-1?Q?vWc5hVcLCCaqiZY6lCGGIxeH59PEfcT+75ZJxzubrMbJWWCBMKdSWSBCeT?=
 =?iso-8859-1?Q?Yv13F4m3zrga6GPfPxu8O1RodkaXkPuX9aMggeDdTAHP40580gPGBZJ82k?=
 =?iso-8859-1?Q?TK6/Xp2gLFfSyydOvMffspj5mHQFKq6ETDGTPGKLwAlJGuLI8LtFmM4Wnl?=
 =?iso-8859-1?Q?KrZcphIJSrnyEDoZUopp7h2Qnuwo/7Ra9lzQ20g3sUi4+s9fjCMtrRXSaf?=
 =?iso-8859-1?Q?wB3QPWdWnBr4AiebuZpe7cBL3D+i3ksGmXvjoe8lYYRD7Pqo6yht0C76X6?=
 =?iso-8859-1?Q?XKHIRrhLCO+Q0T2lyJBzQcUHyTt5bQ+PIbBLTs8W8xfvm4KCegoBQIeAkA?=
 =?iso-8859-1?Q?oKqg4nYXh9vMHI37w5hOpx/gM5f2PrlXSjLozVP5FOElSEPPQUNjBB0n+B?=
 =?iso-8859-1?Q?saaHRDnVVewrIpan8yepnfUAriNH/AGqstIET1/5JJ5qvCBiOIFT06ngCz?=
 =?iso-8859-1?Q?kmV4NwcCGh4lWoRTmdFyhfDQ8znd9MRNmrhIHtn2UaDkvRQAEYfjVSaMXm?=
 =?iso-8859-1?Q?LN8KT+C1Go3jJxPOmB0FEc7OJjVq9qDdXBHQF8HOZwBGDZWNaLwrx6D2vH?=
 =?iso-8859-1?Q?NW00LaLLcM53UJWNBUG8mBW1vB1g1APawd+R4PRzkbabAL5BKd+9VRd9E5?=
 =?iso-8859-1?Q?2S5VwdcyQYgYow3tjMT5oGHr1DnvoN7SsiSGPg1b9H8PA3eVw3Pn0WIX0P?=
 =?iso-8859-1?Q?0yElvmxLZhGD+KmW5eF34lCK63De3U10Dhgd7u3CtXv1NSVV68nHp0WzvR?=
 =?iso-8859-1?Q?qpgGu0rFnoqE5jgqlajO/nvhjZwOqsq1umLWvZIQiM4wYVJk5L6klfaG4+?=
 =?iso-8859-1?Q?KHFT3KTpxSqQSF2oxix2o6Ht5mIxIhX+l3q6Te5SWcnuJzYQ2JtSPNVXKj?=
 =?iso-8859-1?Q?XESeQtP6SMVy6awC9WeiUUw95NQ8OMBQEaTVrH62jN9z+O3Ma+7MdJRhWu?=
 =?iso-8859-1?Q?wnig9i+XJu0jAZUTmMjGGnyTC+Wn4IlaNz8LMC+3Ss+qyuK9kcbVVx9TcJ?=
 =?iso-8859-1?Q?wBVgwqdohdQLdXN7jSzA2QTbZjvLkJzJo89EqRCHsEuAURkruIoAgm+DNc?=
 =?iso-8859-1?Q?uPcO7XLuiaA9+VFGPBu5fN637JpmMkKHncpInPwSIPnW8K9YzoIf1pLAeM?=
 =?iso-8859-1?Q?nFM9Sbc56cuKPKMWHc4mEixLM3JZX302eO/oDlgVM4ghqS++nM2ALjc3+v?=
 =?iso-8859-1?Q?uyow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2a655a-8a60-464c-1a08-08d9f75dc98e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 06:20:44.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsfopY0IvI8BPRba8TF7v//AGElJEGlR/Y5nWfkah1+vkTEUKTfd1hm4gYiM4Ye4iKyUwTwuSQSuqAIlN0qFAAMlMuD1b0u+igF9+VRfyXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2173
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240036
X-Proofpoint-GUID: yyY8nMsa40mdkhm6YUFrA1fnH3bnkZ1M
X-Proofpoint-ORIG-GUID: yyY8nMsa40mdkhm6YUFrA1fnH3bnkZ1M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 09:00:36PM +0100, Christophe JAILLET wrote:
> Le 17/02/2022 à 19:48, Jakob Koschel a écrit :
> > The usage of node->dev after the loop body is a legitimate type
> > confusion if the break was not hit. It will compare an undefined
> > memory location with dev that could potentially be equal. The value
> > of node->dev in this case could either be a random struct member of the
> > head element or an out-of-bounds value.
> > 
> > Therefore it is more safe to use the found variable. With the
> > introduction of speculative safe list iterator this check could be
> > replaced with if (!node).
> > 
> > Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> > ---
> >   net/ipv4/udp_tunnel_nic.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
> > index b91003538d87..c47f9fb36d29 100644
> > --- a/net/ipv4/udp_tunnel_nic.c
> > +++ b/net/ipv4/udp_tunnel_nic.c
> > @@ -842,11 +842,14 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
> >   	 */
> >   	if (info->shared) {
> >   		struct udp_tunnel_nic_shared_node *node, *first;
> > +		bool found = false;
> >   		list_for_each_entry(node, &info->shared->devices, list)
> > -			if (node->dev == dev)
> > +			if (node->dev == dev) {
> > +				found = true;
> >   				break;
> > -		if (node->dev != dev)
> > +			}
> > +		if (!found)
> >   			return;
> >   		list_del(&node->list);
> 
> Hi,
> 
> just in case, see Dan Carpeter's patch for the same issue with another fix
> at:
> https://lore.kernel.org/kernel-janitors/20220222134251.GA2271@kili/

Yeah.  My patch was already applied.

I've had an unpublished Smatch check for this for a while but I've been
re-writing it recently to make it more generic so that it worked for
all the different list_for_each type macros.  I'm going to publish it
soon.

Of course, all the real bugs are fixed so the remaining warnings are
false positives.

regards,
dan carpenter
