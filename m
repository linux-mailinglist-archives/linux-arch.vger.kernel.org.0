Return-Path: <linux-arch+bounces-1389-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C4D830711
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 14:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77241C20F73
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE7C1EB51;
	Wed, 17 Jan 2024 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q5TQz9yx"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A81EB57;
	Wed, 17 Jan 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497978; cv=fail; b=Yh1wcnWMof71Hh/I/Hpwxk8FlDbw58lBIoyxc7MgjwYBzLWEdGTRqIiNIwQiJmQfXTypECUZFkGMqcJ8KojzFe06hqJx5dH2iY69974oCg/PgtyyuHr9z1qDIMnzmcMmW+GoPLQD4WChcsV+P8Ni71LM4BF6mZWkfI9SHAL3DcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497978; c=relaxed/simple;
	bh=AUrGBoBC3Pnp4a2gFw2lOt6N5SDTj1hMARB9tC0FEMU=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=YjC4Iq/QvN4iXbgY3JOuM12jYT2ebGWLdLV4kTTtn64Bf4msWgzmg1E3ZAUw1nDVZ2mdbzuiNdcXdclczf/fPAhVwJigotRXPmDpt1DJihtiXbpciSU6xTC/4zu3x1SufnEhQtKWu0n1ai7zUVBrLWzpgGmmxY6iIhAvvEB4uvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q5TQz9yx; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TevR3MzQM5pRujJIlgb91PvpzDv8M12rfAHxvaNb70ioiXQpaMBg1nk4nK/8vKwJ6Tggz9nZuJY4Rw4YOq4cek5GkXli96R028ZcWd/7fm4SmI9oXo8l4icrk6wL9Ral+aolA7hQQVGQpPUt/mV1tO05cwNtyTl4iKf71D9Gzc7i7VQZbiDE+Be5PHfTVKrtW14gtFhdce0mhS6MYWzCNk8gKlcaPcaByPlnGJOMPMpZ69y6Q1g9cO5rKxIJCZxHcl0bFFVSG438wz7rB8eCZAjt+Na3yI9GDJuulC4mfsNW453X3NPdOdQ630NunjRhUaOQ298GgdiOt3djcGTY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+EASTZXw+9U/jWleXipTqKvBEcgZpHpLRB2hZI9SNs=;
 b=VkwECvQkTGmlawY5XKBrNRdlF2SAzX/83jAHCGS47ELZDbeT7Y5KZcEkxWFTB9bmF6dI7XoCxKOGoMuEqRLQF+jeU53xc6Jvlz+tjH9Sv4CKZ+fa/N0dbbv9oxnWb6JpYiQCYgKI3q7xViqyAnv52lz3tFY0VfrgFu2M1O9OpSv3cCUtSP0QTrcTVI8A3ALRV8YHlxuYGdAxvYsp5OVWi5Vmawyz+Y8dX7A5JAm9JUXu6z2IO53BiC4bW1We+vaDqKBGPBzpEjHcst5fuEQTlpOw4P9ma8V9GcvzAvDla+usWITUWjQq4fcaDxc98C85jRT6FCRiecC32G+XzA15zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+EASTZXw+9U/jWleXipTqKvBEcgZpHpLRB2hZI9SNs=;
 b=Q5TQz9yxuBK+ZA4FhfK/QAFDhKpnv+iOBQ/oV99ClYjpn54q7SapUBGwpvK7rPhryoIfPqSjo8v3vc9ZYpHjTZjEkZiM3mVs8wKtDpXui6Dgx4nmJjgUe0XMzQdDYXs8mH8FFOKyWBeB93R1Srk2qrR7odYYBLohOU5cExCLeQy916poL37drFNdi7OrTzTixMZAl+7HBjZQdGVeU4iwYPP00iNnFMMkFPoZBas8FdEUpnoH0p+Ok8onKcCm0s/31yvDkHrI0uOSpYwkW3bYf+231P7oP7QmlULK+dJFKG2A97jgDSTF5s1QUcZAC9WZC1wZD5Qc60Ays3vJFpUg3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 13:26:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Wed, 17 Jan 2024
 13:26:14 +0000
Date: Wed, 17 Jan 2024 09:26:13 -0400
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
Message-ID: <20240117132613.GH734935@nvidia.com>
References: <20231124142049.GF436702@nvidia.com>
 <14103e31e0c47c0594e7479126ce7fe34f2de467.camel@linux.ibm.com>
 <20231124145529.GG436702@nvidia.com>
 <b3250b9a9af2f29ee3d06830746fb6e8ac49271d.camel@linux.ibm.com>
 <20231124160627.GH436702@nvidia.com>
 <637dcc4d69c380bd939dfdd1b14a5c82c2ddfaa4.camel@linux.ibm.com>
 <20231127175115.GC1165737@nvidia.com>
 <002043477bba726f7dfb38573bf33990e38e3a51.camel@linux.ibm.com>
 <20240116173330.GA980613@nvidia.com>
 <ddd56db15bd2c87073a2f839e06cdb80d693272c.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd56db15bd2c87073a2f839e06cdb80d693272c.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:208:23b::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: b4381d65-aa9d-4afd-2830-08dc175fe0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h3ciJehq6kanstBVuZBYyt6L47zTFSkwKbPvjI5rmh+HsqsRtEwQV3xUuX0cARWO4lhPM78hHb33u4w282uPABdak3HkeU4EH351OcHMoibNB02VASvj8iSZpudup2xTV044umFnzgqfIGzAiTg6v+uik3u7lkg4ujGf900E01dycR8fZsiydj8Xyu6QH1GJuk+fwfRX04x9APnAfv6LuFOzr2j0sZeGKws92ooyWU57XhhZ2fN1s2fDGZAtbJT0IBqv74SOZICyWbs/1+eKHFd5P61AGaw9MAlcHPVtJBrikDs620RIhnbEJ3KjcEDp+wBMSjDVnyVj7jgN+5BVTRUODsmYe43AoM2cknM1TtLuylQBL5QbeSt8Cz13Xx3lKyeLXKKc/JtuMOa08dGQubcQvKDENqDgf4ZwjxH8eGKM+/VKbU834AEL7rTxfOlUK9QswpQbQFEE+N0A1fLFryKTdD+RfE6JV6B8akZUzVKy+s88qPnsTJBTJcoEDeRY96jpeq1PGDBoJS3G8ztc/R1Ay54WaQx2Gf/Emi7SB3zrSMNrGLZcgEqLf7r83doEeVW3jrwHge1k/EZiz3tJ717G4/FIM5ae/egYS0z5+UY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(36756003)(26005)(86362001)(478600001)(6512007)(316002)(2616005)(41300700001)(2906002)(1076003)(33656002)(6506007)(4744005)(66946007)(66476007)(66556008)(5660300002)(54906003)(6916009)(38100700002)(4326008)(8676002)(8936002)(7416002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sL40BLAuEiL5FC1k7u7JDWQ7Q3ztxRYJ0cH/8zOUkn3dPXynBvObuogcZX7f?=
 =?us-ascii?Q?XKUrAOMfWnkQ2C8hYCW2zMQQnN4C4JZ/AZ7ryg2r2nMIf84YwMMZpZFsPuf8?=
 =?us-ascii?Q?iiOx40FLpEN8HpdEWVVD5H5EZFS19gg4p0x+WLh/K6y12rDNXw1ZxI9nP/0M?=
 =?us-ascii?Q?aI9/DMEUbB4BnapxuL7RT5Bn27TN7y2lgk9R9XFPVlntOG1+Wfz5e5wQkPLF?=
 =?us-ascii?Q?9bmJSR/QcIhbmwwY5JsiE6Bao5/l5lxd1vNj+EyOeKk1eAgnL8bicALV7dG4?=
 =?us-ascii?Q?Olijg6+hJ4kUXvzFkSYBkmzyk/xOHrR1cwYLV2M+ksqJe7Xj0KR/dvKDmebX?=
 =?us-ascii?Q?MK7VPg2ajQH1cOhAQHG2Qr1YspoATkOnTeOl8ZhVm4T+KFiAK2UYpO/yTlQD?=
 =?us-ascii?Q?9R9SzzmWIIH8rzcn2LKb0BTpYwGdJqQP7K2gugDVcdXZqf6gfjEBJsMT7+G3?=
 =?us-ascii?Q?c1J3vbDeZqvI9tC2ZCgkibvufaegnR7GPsprCHS54rr4xVpxwLWT9J61YeoF?=
 =?us-ascii?Q?u8NwUX+pAz755DWrB4UM9GFc9ISJoYz9JiEDque3F9yLB3X4aH+5ZulaIunS?=
 =?us-ascii?Q?4ftbCOvOAPGTltboU7cPSwjZRg0qfZk3QkBYaHpwW9WZPVYsqNjo175YuycN?=
 =?us-ascii?Q?d4ArM8Hxuk0+OyvrFk1ectSF06oCa1pWzC72rzytszhdlUWYONBFRM/FHO1M?=
 =?us-ascii?Q?BbPOw/bvyiMHVNaAq73ZGqApY152CkH7QLBQGRqJcmUqIIx2zZpVFrczaDh2?=
 =?us-ascii?Q?4UCjq1HmJsblWp9ZtOveUd3e6wyvoQqO1WcTbLULUsMnFv5C9n9+iSekJd9e?=
 =?us-ascii?Q?gAI/sUP3ADf9Shjm7EkCvNF5tbGJfQj73tSheiBAPq/VHd5Cy5WJrgJJuUXJ?=
 =?us-ascii?Q?peDbC2dNOlSQ5yQIFM1Sj4TcGMdsfLxEwQJ1+Rgjx3W3n75gAhFKPkfENNC6?=
 =?us-ascii?Q?/RGj5p+wP5ucdWRKktteURnBvY8K0/T6ie1Iplo7hFfhRSQP+MSc+opfkebg?=
 =?us-ascii?Q?Es36j1AtACWAfjKobDwcD00fWWI0kyg1uda4fYFu90FEqNlAgQsYKsk391Mz?=
 =?us-ascii?Q?m56UsmR4boSeZvJvVNnPqBHqiVRoOjucpJ2BV1nAQneEvYCDM24BL24JGs1Z?=
 =?us-ascii?Q?0LN5jHCwBo59dgORUSNMInQVaStbijLBL6lUfnRegY/Ni0K2+dFudGzJlcqm?=
 =?us-ascii?Q?9t9L3QbEda9syUf9uF4JBJqYDXfDSjFYQOTUAHwwt2jkJh8k7yIYenMwqGvx?=
 =?us-ascii?Q?Prgs5KUJzl8tDFd2ODLnQ7ghFjxvTO+Jex60UZn4l/tpcBuhO2QdT/z8330x?=
 =?us-ascii?Q?R1J3CeynrTjkdoaitl1t4nKjySgW1tiB3DlOMaFfLx8Nj5qOvssziYDdx0Q5?=
 =?us-ascii?Q?qRZ/Pz13SmHJGvko8e4xluciKmgoo62w+vfRri15dOKbhYC0wiLYfRPdVchN?=
 =?us-ascii?Q?fuZtfwiBjUoC771H9yFQFjqXpk3+/gjTwBp7z/qL5cAT0km9kk4rANkeH31J?=
 =?us-ascii?Q?u4+9JOkaC7NtbWIO8M/T8JpSfXccMLYDOJBvRw5yzH5tE8Qh3/zmqpT9RwDs?=
 =?us-ascii?Q?x1uPR2Wqgr9s4dnmSIGz4rOlUjA0Mf6U9fyFx27a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4381d65-aa9d-4afd-2830-08dc175fe0ba
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 13:26:14.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oj3p01NjaTRQ4m+Sps8ARzMvZD8JPKPJcK09iPnd0TWOYTTdk0GcNbfHhbqPVNK+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738

On Wed, Jan 17, 2024 at 02:20:00PM +0100, Niklas Schnelle wrote:
> Sorry I haven't replied. Yes, I have a fix for zpci_memcpy_toio()
> titled "s390/pci: fix max size calculation in zpci_memcpy_toio()" that
> I tested with this series plus the following define added to
> arch/s390/include/asm/io.h:
> 
> #define memcpy_toio_64 zpci_memcpy_toio(dst, src, 64)
> 
> It's already in the s390 tree's feature branch and linux-next.

Great!

Jason

