Return-Path: <linux-arch+bounces-15637-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D1ACEF359
	for <lists+linux-arch@lfdr.de>; Fri, 02 Jan 2026 19:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05A213016981
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jan 2026 18:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B192BEFFB;
	Fri,  2 Jan 2026 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K32N86G0"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8DD2BDC19;
	Fri,  2 Jan 2026 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767380327; cv=fail; b=H/9lmp+cCwlOJK3Qo9U+zGIBCTk3APcO3VLFugPzTI1qYKIBb/VDYFx99hiRYp7CW75/IXj+btiuOO82K1OerZJrmtyVX9xHAAQwDUV9iLiKt8TplZvqDjOY09nsvwOq536Ne3gJuBueuyNo/jkO8EbQMDONpEa+Nva9yfA0no4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767380327; c=relaxed/simple;
	bh=BlLozlqY07HnyayObgmP5T0+x3TxCBBpPNF19X4ZRas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P/OLXjk20MnioZBGBn2+oi6Ml7gDbQreQyjqrBtFbY0XJETbkWwyn4tQAxqAz61VJmUdUkdNW3tPyF/jkli5D0qc7OiJuF0jjdOjfpSh7Bvsl6YlodXKifR4X0Id3UgrwZIWaXia2qLC12WmZ1tCvL4Qlma4YQ6HB8EHcA17nsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K32N86G0; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gli7L9jxepcRZQMhedEH1PVVoYQIrGbkDJrf7eVd3NN0QsHVBONs8DfBguOTroxHR1Yg2dpiX0DL5p8eCS84/rMf1Cm5eKCUT47Kd/JAp0c32ykZUzpkM72FemMIAgc98Jd/dQBCUbduDCUE4ctd4JQ/SJmrf2UNDfB5KzcFaTDrYAxCBUxZf7DRh1lBjULpzPkJCtWNXtY+99JS1Ew2kFEt+VQErV32CcXqf7Tld/36ok1UdkWWOQlXY5Xvg9mP+tslDqsKzjObwY2vsHpmH7XBNv8R1aXFwHIxiC3tTGa2WVAdyGSj66agtye1UNz5kA92K6n4fIDcMqU4a9V7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3s4rmC6euQE/0DADKFwWvfzb9ZpCyeKjuzQePEDApiA=;
 b=aZaqi8/F6n8zqQovsonQC5ssErWGSQutp8aFfw5UlgyYAY4P7DZtDiNaS7xPkeyu/Njxr+hzUYzFSAlTiWrvAl65OqQcjBP8TED2cJVOQwr1Mj3jCBvRBek0r21PGH8NWjGRSOpdLkszkLyWLBXoBtLVF6O9nbL0eLYWmCu0W4WruYRZ2C382IplyC/izwPVhju1ob8t7l6HCiLIfZC0vafDvr5Uqrwpx+ibaJjTA8nWmOfExWt/gf1+argzreP66SxoFJ8l7rCLIoRdTKFUY+Gzhpc/GjbJqd20kNpDt1IE1fXny9g9Ac17QXhnYvtwCjyvkXM+YufaRuoE0vDbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3s4rmC6euQE/0DADKFwWvfzb9ZpCyeKjuzQePEDApiA=;
 b=K32N86G0BuAnOhJwZuZPCfcxHIQQ7vlzK116wx+An6tEbvdlRj6ZwpfXFaMcmAuHTsbUnShRzRlAm/lu161K1sDYcVDflqvFMBZDlibli6n5TgueWFwg4opKG2yO3NiILDuyrdKT/3AqjLE7Korkzcbh3W0krar2BHmGxmbIilobCsCRbWLzsy7nxKC3k2DmMOc4Ds+KPaHipb0oQUgnqWuvJTuJdOewy/Eei0mmb1DpFkJ9m+xWEm5JUoTduMdciTSHlmfHwyjBGdD7bCVVUtzhWeTS+VzsB+eWNaedYkLADJ0Bqjx7yc1Ms6x52qdjY7R5L34E9GITV4LoqC5Mbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 18:58:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 18:58:43 +0000
Date: Fri, 2 Jan 2026 14:58:42 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Arnd Bergmann <arnd@arndb.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Miu <jasonmiu@google.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kexec@lists.infradead.org
Subject: Re: [RFC PATCH] liveupdate: list all file handler versions in
 vmlinux section
Message-ID: <20260102185842.GE125162@nvidia.com>
References: <20251211042624.175517-1-pratyush@kernel.org>
 <e4d1c333-7e22-47ee-81a0-2efc4ca6b17c@amazon.com>
 <86ecod7zb3.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ecod7zb3.fsf@kernel.org>
X-ClientProxiedBy: BL6PEPF00013E0B.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: f9657ce3-a3d4-4697-fcb5-08de4a30f317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A3YoHCMhg2O4S+fKBhomI+1vOvCqSMFfH2THk5nEdmuuqIXidp6zWkollBWA?=
 =?us-ascii?Q?FOjztEbqqWV8kkwchEEGxnZM1htDVmngVRGQxtq9F9rzC2QQEXYUQm/f27K1?=
 =?us-ascii?Q?tPlht9czsO2YVmEPi657h1+jNjy6yc2xMCLgEusXgZZkmmYbwe/1C1yrAO8E?=
 =?us-ascii?Q?RVnzbkx8XSelfolWmgeYkFm+/Cte4NeWZ5guSQhSG2nSCAkbGu9Zpx2iczj/?=
 =?us-ascii?Q?YJvEm2eVc9JZY08fP6GltqgCRV4pwWdmELtzhazhw9FZG3Ym/T/J5VBupBOp?=
 =?us-ascii?Q?PwrskOuYnEpAVioz7dqm6H7kV4VveESaooSUl75S+rdI2CdwCaxvgz8MeIhk?=
 =?us-ascii?Q?ZyE+VBZqDQ+UK5zUQlJNo1e8zPRn0PX+2lCmejI58Jz8Jp+SUv745BxCZP5Y?=
 =?us-ascii?Q?YPhGYQxWuCQvOlltobOrNsv+I8f4YA7iYwZHq2osg2sxE4wHnNhRotBiKwgk?=
 =?us-ascii?Q?5K7Kf4eTgaTa3ACHnC+AkUrW6dtZLwQiYBFPiHnGVDIfdMoYEysyNfhRfwlK?=
 =?us-ascii?Q?tg91RcminipzGfoGW0Bjzrn8T0+dnvoSmIGofxHshmsqPLjGgr2N3P4To7/D?=
 =?us-ascii?Q?B0wOU9UfziZpFQ1zcIO8LCx+5znIg2fBkGshjFYGuJxUpfLtiVNrn44onX3G?=
 =?us-ascii?Q?OgPgIkm0BkZN64M+F/PG8qoNvM6bTLqsPG0iBpsy6pyOr9Y1WqPnsgZmMhf7?=
 =?us-ascii?Q?H8Ab/d1Cy4R3MLsDz6ITeVFbHHumn63rMViIAton536AIMCJGclxB+T6riNX?=
 =?us-ascii?Q?EQCHB8x3pEjKqKZikuzUik/X1rbDb+TwsKv557k2o7wx5fAklPhMdk8Z/FPw?=
 =?us-ascii?Q?4Un6dK/WU5IBXfEIKFd0OVRH1URcG2m5HtzQHblASHP7PQU9ho2ibamZ0KPt?=
 =?us-ascii?Q?E6xkkn+LGK+lTvTY90sG/dD8UFgibrgIvWYM3UvG4gqCEMsbZp6slLFMlhme?=
 =?us-ascii?Q?BxK9ZBGHJu0Hx/fS7fDF2CoGaty7DliM0h6FV2VGBc4brFX3rBJq6C4KaE+o?=
 =?us-ascii?Q?daBSojV/KXL6uB0GPPawQmbvffIEbM5aUTRBoL44p20FkahITPWeMA+YO8d/?=
 =?us-ascii?Q?8iiMhVzWcd0U27NlijBScfmCA9Ng/TeWpsj2Izp0WQUtNj9zk8X8mBwvIlEf?=
 =?us-ascii?Q?o6psIwrPXnJu/I8yJP0Dm1rwsJ2DHLzCturTuBA5bESrxXPyUHxaPzaW97fF?=
 =?us-ascii?Q?6hkLQXoapiJ0iptdt7ZC2KPe4ID10wuAR7KNdaNxz3xJ/Ah6+tP2UrEQuRlb?=
 =?us-ascii?Q?ifWYSDuZNDOxCyQ5qhcGlevr5NKrMQIcOloLFfqFQO5V6jEK97mSTPbGdVa/?=
 =?us-ascii?Q?YCvEHZ4DpBdVo8airdge2Q9/unz4/VW2DViJjyPDE44+3bTe+b54Z+XXvkaR?=
 =?us-ascii?Q?UcMTsZPX0MkEzFGdGcOQ452vgOcj+NFzu1NDtNjrptzoVpoOmFD3vSCxrCts?=
 =?us-ascii?Q?3ey300q+FwwqC58TUesHDKzpYORElEU7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rGc3alB3KuvObve26vNbdB4GxzebVtfN0BA8n5vAwQd12I/zDx2K//zqvoIp?=
 =?us-ascii?Q?iFcBozY7196QXRHWar1fAOOQvrmQL7jNn+E9RUqBlxbqFGdlOvNOqjop+hlU?=
 =?us-ascii?Q?9hVmIli/UqY+dp0+cV5Oogqe9Lk1IT9oMUkLeUNwCEaXkB03EN80LUN/vGj4?=
 =?us-ascii?Q?pbfMO2Ov6J3UCFktdwtjso9HwY7LAVCADT+8k4/GiQZOX8OlJ6SGIfyNJbjE?=
 =?us-ascii?Q?yInHbs+T04SWF8ZH6W1tTrMPdK/uaTAZ54WLc5YLPYURT7gJLC9co0dTL40r?=
 =?us-ascii?Q?WW6bCvTl7J3jUurfvwtxdnQXj0QRdAPuQH+eJroZXnoaKD4MrQIknOfp2UtN?=
 =?us-ascii?Q?25KzD4InTOjvDzrGW9/sntcLyG5YClkSepYEbjs/evDwC9AWYKcswsYCRs7f?=
 =?us-ascii?Q?R7Uf4Nxpn7RGkZrDAB2gVBw74mdcmkfdl4R/+wQyUUa3/E9Uffu4Ei0RLqKj?=
 =?us-ascii?Q?uo7XBdQuJFgVodMVTsEu1jfSd8jp4aVv09O5+x1nhZkv4v65TFGO/lGt3+fz?=
 =?us-ascii?Q?SgvV6GNFnqS6p39YUMG0Rkg7MX/ZyQEzoGACaHg5EMCax+7A7+pimdTdbJu4?=
 =?us-ascii?Q?qjiZBWZ32v0SKhIRQiM5WaGL2LM/vP0d77eNLqprfeARF4ZTXG/kKZYleQIB?=
 =?us-ascii?Q?7hRUg6y0+Farf9AsdV1SsANMrXYl2vAjTCbgk+yySAnSV5jtK6fXC/aRaAJc?=
 =?us-ascii?Q?8p90c50zwXIjJevS36A/YA4luBDcE/hkzL7GWlq8Yl2qPOdhy2vhO2+iZCUU?=
 =?us-ascii?Q?ZE/y24e0QHQ9bGaWDUy/XppGBKOvnkqBb49RM6FdXBOwFaK55Lbqvf/p69R5?=
 =?us-ascii?Q?oLr6A7UcX2kg7RKrLl494XXBWHUlVicDPmdSuW84qzK4SD2ptT2FbJe0t7It?=
 =?us-ascii?Q?6o7hXXlRGHFx3QYkMF6TVv+77AZj2P8AEzxeLHK3QMPy0rGuAUGN37VRtHv+?=
 =?us-ascii?Q?0spnkG0voa/iE/0OIIayhuLzRUhRQxQr/9f4BWF+MeXq0N09KFZ9gdK/iakx?=
 =?us-ascii?Q?U6CKtycC7OgKVljM8krhi8L3w/AhYEr7nBbSeVPonsQIrrJSPrJcqZ0Hru+z?=
 =?us-ascii?Q?nw8pEmQVzWrY+7AMsRrLRthkAfnBptt2UJRv1sLkZtFriLmwcqdf+D4Bk6zG?=
 =?us-ascii?Q?FMQWNiGRjf/zo+RBuYBAcCgnVgrFHr1s0xITqIgA1hLkn5PnDtcJmiRIvc9u?=
 =?us-ascii?Q?/gbS7GU2/w7gm7ZBxmHO4JFpzt1V1mSd+lSW7Aqb3sV3HQaRC9ab2c3rZ75b?=
 =?us-ascii?Q?tVetFQHIwY66T0F26ECaOyqSPLFKSxd1jc8QT39Ok+hGEa4xJZWU8awVyPg8?=
 =?us-ascii?Q?iujFO66WTm0ISwo5HjuFJZpF+Fn8OEuN/G6Q9VfBFsf3ZMyVFxPYD1RGU9Vi?=
 =?us-ascii?Q?YxcIv2MR4Thw6fpHB5kxAqCb/WRBxXgEB31ifMBQ/9SOdUYyATBFxWStnMS/?=
 =?us-ascii?Q?bNvr2+ijCCnYBVTIGwBid3CclFlXOvRAdc0tJWxodDUicAcEkvlIaP8YMlUI?=
 =?us-ascii?Q?LqENCSEaOxiPW/tCP/VR5+dLEqBqrVhr/RvfvCi6UtmxkApRqho7vhpTnvlo?=
 =?us-ascii?Q?Eudfpg+ozFh5Q4ZkHpMDQjFOyr/lMzoHMbAQ7Ertz//tjp1qyCIF12YOqofP?=
 =?us-ascii?Q?pU4zvshCYxQ9EBLAJpAsAYY/VaK6VZTTdCttmJjJcP/yPsfta3U1+F/rUYEj?=
 =?us-ascii?Q?DomW0VZMVJPVuOk2IjCdno0Vx6vrFseXngQ+EIjfy3aTgeXQ62hD4yTmLH45?=
 =?us-ascii?Q?JE5RhNBqHA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9657ce3-a3d4-4697-fcb5-08de4a30f317
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 18:58:43.2599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFJaNsHHJymirIh7jCFWvVeOdLjmtRC6WvIi1aikyG6rJsXg0rzBDIeQYj16LgVg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055

On Mon, Dec 29, 2025 at 10:28:32PM +0100, Pratyush Yadav wrote:
> On Sat, Dec 13 2025, Alexander Graf wrote:
> 
> > Hi Pratyush,
> >
> > On 10.12.25 20:26, Pratyush Yadav wrote:
> >> As live update evolves, there will be a need to update the serialization
> >> formats for the different file types. This could be for adding new
> >> features, for supporting a change in behaviour, or to fix bugs.
> >>
> >> If the current kernel does not understand the same set of versions as
> >> the next kernel, live update will inevitably fail. The next kernel will
> >> be unable to understand the handed over data and will be unable to
> >> restore memory, devices, IOMMU page tables, etc.
> >>
> >> List the set of versions the kernel understands in a section in vmlinux.
> >> This can then be used by userspace tooling to make sure the set of file
> >> descriptors it uses have the same version between both kernels. If there
> >> is a mismatch, the tooling can catch this early and abort live update
> >> before it is too late.
> >>
> >> The versions are listed in a section called ".liveupdate_versions". The
> >> section has a header that contains a magic number and the version of the
> >> data format. The list of version strings directly follow this header.
> >> Only the version strings are listed, and it is up to userspace to map
> >> them to file descriptor types.
> >>
> >> The format of the section has the same ABI rules as the rest of LUO ABI.
> >>
> >> Introduce a LIVEUPDATE_FILE_HANDLER macro that makes it easy to define a
> >> file handler while also adding its version string to the right section.
> >>
> >> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> >
> > To support multi-version preservation and resume, how about you add a "profile"
> > hint to the handlers? Then you can tag the handlers with "current" and a
> > "previous". You then expose one section table with supported versions per
> > profile. And that means you can from user space select the local profile to
> > serialize and match that against the target profile of the target system.
> >
> > It also allows you to support more "profiles", such as elaborate downstream
> > version combinations, that upstream will not have to care about.
> 
> So in essence you want to tie the versions into a "version set"? If you
> want to use a new version even for one component, you would create a new
> version set.
> 
> Interesting idea, but I am curious. Do you see a reason for grouping
> versions together in this fashion? Why not let each version be changed
> independently?

I don't quite get the point either..

I think the ELF annotations are intended to give information to the
userspace, but ultimately I think we should just rely on the userspace
to implement anything complicated about compatibility policy.

We also have the issue that not all versions *at runtime* are going to
be supportable. Older versions may be information loosing and cannot
be emitted based on the current system configuration.

So to really make this work you have to dynamically query the current
kernel, and cross that with the elf data from the next and try to
cobble together a working set.

IMHO most likely real users are going to want to latch onto fixed
"profiles" and globally bump the profile cluster wide along with
activating VMMs to consume new features enabled by the newer versions.

There may be an early churn when we bump versions because we are
messing things up, but the long term steady state will probably be new
version = required if new features were used by the VMM

Thus the version used for serializing and the features active in the
VMMs should be linked together by the operator.

Jason

