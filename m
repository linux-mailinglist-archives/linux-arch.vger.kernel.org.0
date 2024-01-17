Return-Path: <linux-arch+bounces-1394-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00922830C52
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 18:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7976B1F260EB
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D5122630;
	Wed, 17 Jan 2024 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X91j5kJw"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69422EEC;
	Wed, 17 Jan 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514124; cv=fail; b=mVlWob7R/ed9gDk0ugNnlbNnfj2g4oz+u84CbXRmSaiZVJ1j7jJ6N0QNq4M4vf0orFSIkjWce8aHOK2mai0+kYI266hJYKYeFL0sEbAwWed/U9lIpHBdKPb9IugnKj+q5qfM81CXmb1ZKCV5FC/yeSTNIAdTSFLgplT8xS0TsuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514124; c=relaxed/simple;
	bh=KDCYy75GLeoR6t1Fh5Z6S3ct9kmaYoeOmTpugIhWrd8=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=FgUU96YwfzxD5sDfM58zqpk4GAWAg9z6kPYuovkFfP6LUxaG01wVCbd8SCa3yytRwnFz67HyuBZ+Prz5NNGZhAFvU4jjc/JILbqigrmrLG1VM1pGce/6utgxi6Oyty0oqJhcmBIIQiMYHcsS1iklonWGnlEepzIIPXaFNbyZgks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X91j5kJw; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrMAxIhk+lc1cmvwLvJkJQorg6dvl15kOaSmJUPVqb9s8dIKMCSQtFzT8Gi7maG3ICjRROy1bM9iYH4xK5m+3gtxk0U17QrS2R5nMDDgFq/h0c9b6+31Hyvdo/wECB6tsQsdBasomqrEnFa2MZYatKG6umUbEnpA/uAZFBo/V68Y6ffqGXi01t/UHm6ZY+JKG/swYTWdvV5O9R7UDhECyk7849TxfffRiZTXpnDPclQKqNrhPvXw6WACgEmKDN646oc4AfNdn9qBcgnYLw9oUZ4dH6YwMQXaoyvwSBTxDKxHbmTW0Pl4W/LsRt1eGR1TK3ufd8PhIzPCuCddZus8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep96FrnpQijU3apInWyPqO/oJX40+qYR3J0P9RGAlXQ=;
 b=T9e0qFZvsDPGA0y4rKjP4vG+VL/VXQupa2QFwgjqnWO/rB9AZCRoFez6sffqpUalrnzyolu+0PmsxlWqVKKLqntWE5lVgFnwSAsTrlmEaIk9aIDB7udfQUG9YMuwLCsmt96iokecvDUP5xAjBknoDyq9Ln98r3mh8AM+rclKm5nrnVfvxWSNj3pn3VGXIvbqmivzKsjeCOE49lvrvjViBzZ3lQZAfl6NK52OsP6KLil264S3WmIH/VwYmc29RNShQJIwvGlXXPwfqZI/Qj15ZBd+bgwOwoQobwVjUu0BxBXXqih7mP28dQzPWnNZoYd7Cf1QKcBjkQK3FHc/VB8vXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep96FrnpQijU3apInWyPqO/oJX40+qYR3J0P9RGAlXQ=;
 b=X91j5kJwnevxXGHMruhlyksFyAXuhqWd1Z7wQnSss2oYJUD2MJ8DWLVNYq9ZNUqpg07vmAG/uXHYp9vTPEYZT1ADtrECZKWOVmJsM8cPiXqS2RHTSMsmExkKGi35A7XuukF+qrGyNT9pYBtHpxjxSHCzf7IT0v5XFOehQWee1MNgHbFfiBddiTbNObyxE6xG6O5NsyEsT7tQTYnEoIlAJ9Hqpc1Qqy8oGOFV+PcRSzgTSX8T34gsfiTwELwt8QxGbRN3v24MhhLCiK57NaLDAizBaHeICGs3JU93dWaktqrtIikWM9Ow5Vno7++eD3ZIuQVIu0cXfTc3MocI77iyBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 17:55:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Wed, 17 Jan 2024
 17:55:19 +0000
Date: Wed, 17 Jan 2024 13:55:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20240117175518.GJ734935@nvidia.com>
References: <14103e31e0c47c0594e7479126ce7fe34f2de467.camel@linux.ibm.com>
 <20231124145529.GG436702@nvidia.com>
 <b3250b9a9af2f29ee3d06830746fb6e8ac49271d.camel@linux.ibm.com>
 <20231124160627.GH436702@nvidia.com>
 <637dcc4d69c380bd939dfdd1b14a5c82c2ddfaa4.camel@linux.ibm.com>
 <20231127175115.GC1165737@nvidia.com>
 <002043477bba726f7dfb38573bf33990e38e3a51.camel@linux.ibm.com>
 <20240116173330.GA980613@nvidia.com>
 <ddd56db15bd2c87073a2f839e06cdb80d693272c.camel@linux.ibm.com>
 <20240117132613.GH734935@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117132613.GH734935@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:32b::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 041d9ec6-6d71-46bf-5ca2-08dc1785785d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a+X1SJ5xK4l4/b5Rf11JarCokccUi71nlP6zTOzahYVv12AitwuWhCLK70vipyqkLLLGYS2rNT8eGec3OKYevyUVqZGgi8Ri5BR6CqzNXxHrlg67NRCnJ9szNOIb9wyd4JEEh/D7Uw9A3f9+RlESiKUj/awU98ixEP73pGla0YDYnbhQp/yQkRFgWN9qmHL+8ltahPTLfKkwD9htlBiYEOwpzpD+weuwwCqlugmVR2O3C+3sWt5/8f+6NIcef7J+RPmCa0zTzGNm5U1UmMUD7KjuZuMrGfytg+gMibFX/k52KRK1cpL7Z98n0SDQcD1FgUICoIFd8fdXxnWV4DHcQw/9f1WNsIeSc5rQrdARkH+iktc8kjj0oWtec3hBtOVRHj+rcMq32x3d8HqV2CwymFJGYn91Zz+JA6GRE3M4P0iQRiT219/qjuIDAfoSi4M4hx5qCJ9xQkni+yORmR62tm8/iTpj5xZlxdKLzzspdXeuZmwXxQJMf1EaJJR0/mU2wrknsuT0Qy5Xk1xh2fQ1uEDo02DTOILdLUKPDjZLiSUrw+3GGj2PWEEjfxT4VpAAzKxs7I2Sab34l2bdARs0B3QyiSALE3shIjS/i6hDA20=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(4326008)(8676002)(8936002)(7416002)(2616005)(316002)(1076003)(6506007)(33656002)(41300700001)(2906002)(478600001)(26005)(36756003)(6486002)(86362001)(6512007)(6916009)(54906003)(5660300002)(66556008)(66476007)(66946007)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UdbQyvAZXZhxusl1SW7xcbWuNSKr2D/5oIJ9AMN9+w+3RYhJLa6U0MMFK+qA?=
 =?us-ascii?Q?67tcVglUtGLGj8FmAOHeWiAa9wCP9J62QBtDqVH4iuGCbpgW/DONIRSeKkZy?=
 =?us-ascii?Q?XyXqWiBdAvBjuW5R7B2w7UgegRelI8KDFqznQ/3Tn5itqY/uZOttjqAP6Ix8?=
 =?us-ascii?Q?0zVPIGqt14xtrDVgacTbdBbERr1kZ/l6mIlHi0RdtDclXgTZzA7USHjZsy7X?=
 =?us-ascii?Q?6WjsxFoMYA2l0lOmi78IBlrPU0u5ZtpbAHTlOdIglaWL3Lb3B8xO7VwHIZOr?=
 =?us-ascii?Q?1lTf9g7BzhpXfjOpMJ3V9fX/PO9eGUt42g828IPk2bmes/LRPMQVPAJZ/0Mg?=
 =?us-ascii?Q?WQHfnazO/Fu2aMp59rsfHp/xM9O7WYZ7mxu1V+LAKEtXwZSKie74TuJCUTCe?=
 =?us-ascii?Q?9rSsXpCOCleHH4IWWYhgp1qOwoaNOCvyT4lwT9S1f7/hpmNXF0OAXjCL5Upf?=
 =?us-ascii?Q?aM8j24OtM+dwLsiFIwIhT845udAd8Oo9tAkmRw+zuJDVsrEWa+DD5qgFhnya?=
 =?us-ascii?Q?Hu/r9t5sr5gcBEUIwTmznHGvH27NiWXZTg9C4LSJNNhwwTg5LqzbUn8Hp/ec?=
 =?us-ascii?Q?QtFHzy0zneIv1TLqhQ82M51UfC+D0CcHy1VYf0F6VBF8SQ/fWvWCroyDH/yQ?=
 =?us-ascii?Q?VCpx1MWXJBcndsPDT0PYjTElkYcMTFsu6hTxuLYfidL5OZngMcje8FQzA/2J?=
 =?us-ascii?Q?M6oszBTv2XKAeNppZpjyHkf54OSHj94gQ1Bgj9bYziiph0eqsws6eFu3pKbR?=
 =?us-ascii?Q?vDRGDIaNHsCZYFzly1ZgqQLN7Zj7/wgBkHkravBNdSqKBGmBh2YBByZPqs82?=
 =?us-ascii?Q?WwFJBdPLC5d6aJVXb220knYK+YAek3LHBSiXdVt41F83X7sXP8sxNIPwrCmg?=
 =?us-ascii?Q?k07t+Ik3iR4nuOSRMURX+GKXINEi/GLZni0PnwddfZP5J/Jrn5kMBcc7FBFY?=
 =?us-ascii?Q?uC+FMVS2gjKwFkJbqIhkthYteVhM1xv4oHtAxEoeENmyxNoLSh/NC/43fGbE?=
 =?us-ascii?Q?Tt50G4ZIrLoNzNd3EkCXCltyK/JHg+3rO3GjFiaaoTK2RI+cE7YpndsIT/nv?=
 =?us-ascii?Q?AkzZrvGaJYQGxq0ZHyJIZ+vrwWwhUIfKzR0KsnDdpPrbG2mfRlBTZicM2Qfn?=
 =?us-ascii?Q?d3BSiq4hSO3ERhA2CnJyt66NvtNpMUImfcwQzLRKzZnVSu/2hfl17kZK9uDJ?=
 =?us-ascii?Q?eIxAN6AICcV92YzTf1AdAr5ZK/7ZfdKvlucSDdJFjY2VK7vTDDgMKKazRnRe?=
 =?us-ascii?Q?ZOyXRau8K6OYl5n60mtudR0l1GxCtpwTcvBtT01g7rXN7bSr0x1H272GJhJ1?=
 =?us-ascii?Q?OczS1gSootpi5UbjDx4QCKOtj3nglH7yIieoP4iTW2pshmjY7JRsmqbRb+wx?=
 =?us-ascii?Q?8y5mbVt62tfcW/UPuST2C305sN/lJJXNZu5o7fVi0vr7NA5M08hl31PWgeCS?=
 =?us-ascii?Q?ihuiwZM+KCONIuJhrWAoYLZOhDOv1NdBrok9ibWXXR416cyvm7vByF8HKVlj?=
 =?us-ascii?Q?fBzZ6ziZW4Qht9r7hMky2JvJ5WaPgAsN42PRHlsLF1TRDLCFxXiOkJucld3H?=
 =?us-ascii?Q?0mmS52rBtpi2fjo30Ol7Swni9myVS10IiMFuKUQ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041d9ec6-6d71-46bf-5ca2-08dc1785785d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 17:55:19.8741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WrMSlUdZJzx2fU4DsGMZOZ/Nb4X1zkwpo5Y3+zxMe8L97uSp0+UOncFegoekomO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452

On Wed, Jan 17, 2024 at 09:26:13AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 17, 2024 at 02:20:00PM +0100, Niklas Schnelle wrote:
> > Sorry I haven't replied. Yes, I have a fix for zpci_memcpy_toio()
> > titled "s390/pci: fix max size calculation in zpci_memcpy_toio()" that
> > I tested with this series plus the following define added to
> > arch/s390/include/asm/io.h:
> > 
> > #define memcpy_toio_64 zpci_memcpy_toio(dst, src, 64)
> > 
> > It's already in the s390 tree's feature branch and linux-next.
>
> Great!

Is this wrong too?

/* combine single writes by using store-block insn */
void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
{
       zpci_memcpy_toio(to, from, count);
}

 * __iowrite64_copy - copy data to MMIO space, in 64-bit or 32-bit units
 * @to: destination, in MMIO space (must be 64-bit aligned)
 * @from: source (must be 64-bit aligned)
 * @count: number of 64-bit quantities to copy
                ^^^^^^^^^^^^^^^^^^^^^^^^^

Ie it should be

       zpci_memcpy_toio(to, from, count * 8);

Right?

(I'll fix it)

Jason

