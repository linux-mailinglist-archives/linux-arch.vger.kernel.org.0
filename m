Return-Path: <linux-arch+bounces-11389-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 946BDA876C3
	for <lists+linux-arch@lfdr.de>; Mon, 14 Apr 2025 06:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D91188F025
	for <lists+linux-arch@lfdr.de>; Mon, 14 Apr 2025 04:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937753BBF0;
	Mon, 14 Apr 2025 04:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QuAL7Xox"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEC263CF;
	Mon, 14 Apr 2025 04:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744604247; cv=fail; b=obQsFv5RWhMc4CILPwBsZ67t/iznHpdZPQ8cH4ZjFZDvOav8O8N1oibCPzFhguvO4ms6cHjg+31md64twgYOn1J70PuC2cZnn12m0CIg2agtYHj9uJLOBADCWSeZXThwseaRCE/+frk/Q6XsWP3CwPh8ieA13dBQLJKRjWEamH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744604247; c=relaxed/simple;
	bh=NIgoHHpv9kxswDYzRGQDyt2/L2OZBiVLKoZZdieRVLM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QZ58hpTt9w9Ge1nJl5Axqtd1oRGCn4vC34RhWn5MORYJ4S0uIo9CTe90HrsSG7S3xPtB257sDHMusHOKacyLduxBffbclNClVRXV5U2LeKxbP3yfbm1xdnX6URzwbiRQkZI4qu/aUKA2eYIp3UIkHtGOx6oF5Y50CdzF4sYir6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QuAL7Xox; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFW6sTFXa5mfAjNArqCA20H3Wwo3U7N8mLsGs2DdmYxnsPw6O0AzhyJ70nAjmox+uVqhh3/UyUl1o8W8l3tlAh2+FywfUIeRCIkz2TlVheOH374yPQn+DF01OL6buMLFRtU2UAPdAJRcmXIFNDhCAKAuWfrYZUDA4mZXakn4WG20nmI0Jj5BUxZmgRpapbrGxM5BiWXDrF0RyME06SbcGs34qDIaGBWVSv2uVAOaLGroo5eOct0Eoz7w7+z/1DWciis93/JF0m5sDN3zND6RveXJc9ShhNcqOy5kJKU7VVrzjfzHqOdFT/m3OFnk8NtiE9mp4UX1x0wHG8jnsfoaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kvjObGfk7kjqJSU4Ha4oTbShA4VowFdmY12XDZ41+A=;
 b=AYBXTOLnRSAle67rLUHq7cwIdr985FDgIVQNEkdMj64k8/C/UF0BP7UpIPQRQNCabCGP96lyr3H1BP2eJZtJ7/EKnTbh3PIt4PN7zVzUgqV/ELLStXWCm/KKRXYEcJ19Mc3YmmpSMnymikbnmVmq5GS8H2ueSb0i9fAImKtnWhIzZhgXaQSAOUnAEPsc40HhGgnNKsFQc/yb4kKwRWH8SYpufi2rFhjjR9QQ2p68tmz9FZpIfjBrG3/TdLTgF+U/YlugcGkUOiihVlUJ2v7EbF0RHn5nxWSk5Jfnz/2BiGVAyH+exKu+t1ZPiY8j+hS8iO9XbgxRe6gjcnjku3D2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kvjObGfk7kjqJSU4Ha4oTbShA4VowFdmY12XDZ41+A=;
 b=QuAL7XoxX/ABstNQyxRaXDZpgRrGGP2C6ZbuAYPqnC/KL5uLKcLYaUpxWFsm89eMPy0npKkItnqbXGxGsz2Hf8MjxbepZ7E6BTyUVxkV1j2i8cwD90fDUCBubn4BOIYbP7vwF/r4/kby4L5CTub/AIrhRcphCknJFifX/yuH870=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 04:17:22 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 04:17:22 +0000
Message-ID: <918ce301-123c-4c2c-bc59-c0c4bd6195cb@amd.com>
Date: Mon, 14 Apr 2025 14:17:09 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 13/22] iommufd: amd-iommu: Add vdevice support
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>,
 Nikunj A Dadhania <nikunj@amd.com>, Michael Roth <michael.roth@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Joao Martins
 <joao.m.martins@oracle.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Steve Sistare <steven.sistare@oracle.com>, Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, linux-coco@lists.linux.dev, Zhi Wang
 <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-14-aik@amd.com> <20250401161138.GL186258@ziepe.ca>
 <b051dcc8-58a5-4f24-8b06-e817e9762952@amd.com>
 <20250410130529.GE1727154@ziepe.ca>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250410130529.GE1727154@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME4P282CA0004.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:90::14) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 37fbcaf7-58a0-40f8-8087-08dd7b0b40ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFpaZ3RUak1yblV4VUkrODhlb25yV2JIZWNmTGxaVThoTEZwWDdpWVM2VnFW?=
 =?utf-8?B?R1liUUtKQkdPNjVqTjAxd0lOcjdJdVRXbjBSemJWOWQ3SVFPWVB5QTJJTGN1?=
 =?utf-8?B?UGFqSkZMdFNaYUJYbjJKK3hqRmluby93bDI5RUN0OWNKM1RweFRiZERYVElY?=
 =?utf-8?B?eEtQbVovUGRscnNqNTNkOVJCdGVaY2RDbitkWjlDZTVxWnN0aHMvYXppTCt4?=
 =?utf-8?B?L3NLUVZIZHpEK2FjV1djVWVVOU05c2Y0bWFsWkp2Z2VxMTFPOUxzZFg5TVFn?=
 =?utf-8?B?NWFlWjJTM2NEUEpYcXRzWFZPYlM3NXYvUDJwT0NMM2dCbkJCTGowTVdVSWJ4?=
 =?utf-8?B?UVpuZk94eS9HbU1JK2YyMTBGV3h5OXdRTjR3WVZBNmxrOUQwVUtBRWtSVHJz?=
 =?utf-8?B?UGdQdVpIa3FueUpLVGtiOVh5MEhCVllEMzlkbWpyTXBmcDBjVjQ1OGlndHBn?=
 =?utf-8?B?eDIvUzJlcmE2SWFzMW5BRklscXVEeWJQUnFIVXdLalAwcEpxMVptYUNkNndS?=
 =?utf-8?B?SWd2RHZjMlMxajZBQ2pERkRGU0o2NDJhMTMzMG1CQ0ZBZkU1dnBWM0xxcnR4?=
 =?utf-8?B?bHl3SW5wdEs5bG51R200cGxKMTVqOHlQU1diL0kzcjVOVkhLMWdhZjZHZEE2?=
 =?utf-8?B?ZmJjQkpJSnIyekZ2MWI4b0hIdUFwWGFUK1RhRFVhZEdkTGtaLzZzQmo2ajE4?=
 =?utf-8?B?ZWF6a0RPcGxnQTFtQmVYdSthVEJNRTNmblo1cmxXQXhzSk93c01QZnZFaGpK?=
 =?utf-8?B?ZFJFbXhHMjJCaWVOUmN5Wkl4aHJFeDhESEpNTCsrTEpwOGw5K2x0Qzd3K0VV?=
 =?utf-8?B?Z1d0V1NVTkZvSlYzSndtZ0d2NzBNTzk2QWpzSGxYdnVUNFpGc1VHQnU4N3ZG?=
 =?utf-8?B?Y2V5RWZaQktVZU1XRmtGNGdqM1lScEtaN0JpbXFWYmF2TlVOSGxLendOWUI4?=
 =?utf-8?B?Z3JtajAvY25hYWpIME4zZEtJam1mTVZ0WmFab0I1NnJTcUtxc2lzYXhDekV5?=
 =?utf-8?B?YllWcm9zaDhLK050TDdaVTg1SVlkYlc4SUVPRXN0SlBoelJtZURyYWhoYklY?=
 =?utf-8?B?emNEd0R4b3ZRRkorVFFnMUZseHUxb3R5NFg2d0IzUFpMZDlMV1daNlI2Mktw?=
 =?utf-8?B?SmZteFh2MHplYk1HYktrV0x4ZlBheDdZVlFPVXhxM2FQYk80VTFvYzlDZEhR?=
 =?utf-8?B?eU0xY1FJb2VOQVZxVVJ0WkUrMlAwdGdpWFZkOUZiY3QwVFl3RnFXSkdKY3lH?=
 =?utf-8?B?NjFJdEMvUzBES2xMZTBxS0RLM0N1ckNtS0lxRk12eGNRM3pZTzhnRWVNQUdP?=
 =?utf-8?B?bzNIMmdwODZwNElZUlU0M0E0ejNPZXE4cjdiT0FGQWJPY1c1ZWYxVE5SamYv?=
 =?utf-8?B?dkZuLzE4YlZKYi9kVGtjRXprUnB3TXRaQktZQ1dFSGNyUUM4YTB2RHl1bGJZ?=
 =?utf-8?B?Q242d01BTFQ3QnB0S3NFTjlMZUtadlBkSDR4Z3VDZ0lWRHpsWmptYklua2VU?=
 =?utf-8?B?TEtWd1B6Wk03K1p0SmxaNDNrSy9sRi9RY0s3M1NkMFZBdjJ6KzY5Z01oSkNG?=
 =?utf-8?B?eFJRcEFtUXFRM05NSEZmNUpuL2thNjFCQkNTZnIyYTA0eFo2S2xaNWNxZXlE?=
 =?utf-8?B?SWoyOFpoRndQNzJwSnlSKzRGb3J1YWROdjYrWW5VNEZsRUR3bHRqQnhCeUs3?=
 =?utf-8?B?UWJQM3dNVzNSZE44YWVOY0dteUI3K0tIWWVMVExYUjN0Q2JvbWxWZkdhaWU5?=
 =?utf-8?B?UkxuVjNsb3RJS1RiYzFCQmFiZWRML2p4QS9iUmZBdC9FZ0VkcEhtTkt6TEdy?=
 =?utf-8?B?bXpESTk3djMxci8zMzA5dEtaOHFzK3B5Wjd2WmprNm9wQmtySWN6czRPK05W?=
 =?utf-8?B?SWc1VTIyejhXL3FFVkNuR1ppVUdKQ1I2SHZNeFBEdDZoV3NPS0NsUGNlVGN3?=
 =?utf-8?Q?gKo0ut2INkI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFc2bUFlbEZrZGFQMUFLOGxkZGhiSXVOV0Z6MmdaR1FYdEVWcklMLzl4Q3VB?=
 =?utf-8?B?YU14U0djMWUrMUZGWHhGRlVCeHFsdDhIMUVrSkZYamdZWFgwNjFNa3BKRG5Q?=
 =?utf-8?B?UE9HSkJXdDUxV25obkxnN1JKNmtxanJaR1pWcDgxbzZkbUNwd0hYZ2g2WlZN?=
 =?utf-8?B?clQwZmZPdk5mVHdyVWlZNWoxRS93TWxwVXBpWXRLOTV0TnlPOVJuYXloSWFV?=
 =?utf-8?B?TDBCenZNY0U1Y2V6N01oOXE5NzAwY3pYSU41TW5uV0tCU1N4S3EyekEvWWhm?=
 =?utf-8?B?QVFMNk53anR4ZzFPbmN4QlVmQTBiVzdSU25IdEhEbTM5WmRMb21uby81UEN5?=
 =?utf-8?B?S3ZZSmVFajdSaUs0MHhDSnBqSEdVcTNYWXdJb3A4NUtXeVBmbmErWG4yN0Vq?=
 =?utf-8?B?b3Q4YlNBTDdjdmM4MjNtdE5aMUZVNXM0VWVsZ21sOG5ya042WkVzY3o1YTdv?=
 =?utf-8?B?YXF4SW5EdDVUSlc0aVdXUjlzTkNDSllIVjBSLzV3QW0xNmpmRjBFdSszM0dK?=
 =?utf-8?B?ZnNFWmxKOFVLOUh5OUpRNXJQZFRVc3kwMzJlMHpiT2hMeHhQSzJ4MXZCZEpW?=
 =?utf-8?B?aCs4SE1yZ0FmT0JCaVBsRGh1NDN2MEp2UUJNNzJrdXozTUl2YUhXYUhuZlQw?=
 =?utf-8?B?bS9LTktNRDVCSWxESk9GTE5RMXRaNlRPaGdmdW81ZW9jdytJVmxjZkJObUh6?=
 =?utf-8?B?RTk0TFRWZ3hKWjQ1d0lqTGZqYURpVGJpbjVBVS9xZHRibC9UNHB4OCtTT0Mv?=
 =?utf-8?B?T1J1ZWU4SE4vdzRnS1NsVDBLTHRpbUhBVkJOMFVTUXVxRitlVkNVSHEveHVE?=
 =?utf-8?B?VFpPdEIrS0pDeXVxd3BCdjExQ0pBQ0JmVEVScFlMUjRsTnRWRVl6eVFOaDAy?=
 =?utf-8?B?SVhZdkRiYmIvekE5WDFqWU56MVFoWVh6T3VZbExpRmtVVTh5Y0s0VUpNTk1x?=
 =?utf-8?B?YzdVVm9DbkdONFk5ZEJudUQrT1QrZnJiMEd3OTBZRW9lMDRSSm8vR2EyQ3lD?=
 =?utf-8?B?Tm5JNzRWZUV2Q0hLOTNVK2xubnlac0d5QnVseGhLTk51QWx0RTFVRFg1dlF6?=
 =?utf-8?B?allUa0szb1dUSTc0K1ZmR1R0NTlKRDhlKzhSbE53YkE5MlB4VGNhY0h2MjZU?=
 =?utf-8?B?STdwTll5QVFxWFYzWlhaYWlma2VWeFdBRW91Y0tEZm9TSVBtUGJaV3ZZTml5?=
 =?utf-8?B?VUJnUWdNQ2l2U1F1blkyQmt0YStWc2EwWExYSElxdDduYmtFSVVWNGtXNFRo?=
 =?utf-8?B?ZnNCdGN0QkIwVlJrV2pIeXMrQ0dpSUdYa0J6d1NMeUxlK3pWZm9jZG1tVlpy?=
 =?utf-8?B?MWdscTZlS1BZT2U2ZzRPSUpVSDlQRGNKVDcwT3RDZFRHc2txeC9SNjZDWWd6?=
 =?utf-8?B?ZEhmWndoWXczdll3alk3Z21FODRGZGplK0dpWWpXVmk2aGdYanY2OUdLd3po?=
 =?utf-8?B?QjFTeWZhRXM2OU1NSzVNRzRWVHRtcTE5dXAydE5CZVAwcTJMSFgxb2ZKZHNL?=
 =?utf-8?B?ZzdmSnN6a0FkQmNMTkM2TnZJd2Jzc2ZZYzBheUJ1YXRBK3FESExaMGZwbEdD?=
 =?utf-8?B?elZkbkgzb0hCbmg5cFFxN25GWU16M3Q1dFdzWFAxSEl1RW5MWVhGUkZvbVFx?=
 =?utf-8?B?S25rUEVQSForYjZpemw2cW9xamdPK3hTTzRtNm95c2E5WUt1Q2hTQ2UwQXNQ?=
 =?utf-8?B?N241Ly9hNlV1Y2srU2F3MWJsQWdOSUkzSU5EOWJwanVGOE1YWXpMV204dFNo?=
 =?utf-8?B?bmZud2tiKzVzT3NFbXhkazBkbnRVRzRzL3A4T3p1VXQrWUFxZHNFejY4ZzFO?=
 =?utf-8?B?T1dQbi9lVlJJc2ticDJQaUpTeklSb3M0YXZRa2gvUVZyVlRaaTk1WlVsWThl?=
 =?utf-8?B?VnFabS8wOU1oK1NCOVk4UGQ3cEdLc09zWEZwanJWUXRJWWc1eTVVQ2hEd2w0?=
 =?utf-8?B?c0htUUttays0N1V3QTRPb3VkaVd5K0xPYTVaaXI5UW81L09mU0lTQnhsOVNs?=
 =?utf-8?B?QlFMUEFIMzJSb01nc25aUHhQVC9aOEpDYTdjTGZtQ3J5QmRBVXJJZk9Ralhl?=
 =?utf-8?B?bzMrRXcyNUlhbEpTRTVnV3hXLzNDdlBvNUttUlltR3pDN2xIM04rVVBFZkdT?=
 =?utf-8?Q?wilMM5hq5GSGacp4x6e4BSeGf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fbcaf7-58a0-40f8-8087-08dd7b0b40ed
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 04:17:22.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrxVe/vHuw5fK+69n/NWZYk4O39JhvY33yajrZX57CORjCaTLGcu66FTaTIfGYjseJ65tkZjmFIuxeGkWcjcow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715



On 10/4/25 23:05, Jason Gunthorpe wrote:
> On Thu, Apr 10, 2025 at 04:39:39PM +1000, Alexey Kardashevskiy wrote:
>>>> @@ -2549,12 +2561,15 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>>>>    {
>>>>    	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>>>>    	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
>>>> +						IOMMU_HWPT_ALLOC_PASID |
>>>> +						IOMMU_HWPT_ALLOC_NEST_PARENT;
>>>> +	const u32 supported_flags2 = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
>>>>    						IOMMU_HWPT_ALLOC_PASID;
>>>
>>> Just ignore NEST_PARENT? That seems wrong, it should force a V1 page
>>> table??
>>
>>
>> Ahhh... This is because I still have troubles with what IOMMU_DOMAIN_NESTED
>> means (and iommufd.rst does not help me). There is one device, one IOMMU
>> table buuut 2 domains? Uh.
> 
> It means whatever you want it to mean, so long as it holds a reference
> to a NEST_PARENT :)

ahhhh ;)

>>> You can get 1:1 domain objects linked to the viommu by creating the
>>> 'S1' type domains, maybe that is what you want here. A special domain
>>> type that is TSM that has a special DTE.
>>
>> Should not IOMMU_DOMAIN_NESTED be that "S1" domain?
> 
> Yes that is how ARM is doing it.
> 
> Minimally IOMMU_DOMAIN_NESTED on AMD should refere to a partial DTE
> fragment that sets the GCR3 information and other guest controlled
> bits from the vDTE. It should hold a reference to the viommu and the
> S2 NEST_PARENT.
> 
>  From that basis then you'd try to fit in the CC stuff.
> 
>>> Though I'd really rather see the domain attach logic and DTE formation
>>> in the AMD driver be fixed up before we made it more complex :\
>>>
>>> It would be nice to see normal nesting and viommu support first too :\
>>
>> It is in the works too. Thanks,
> 
> I think your work will be easier to understand when viewed on top of
> working basic nesting support as it is just a special case of that

Really not sure about that "easier" thing :)

GCR3 is orthogonal to what I am doing here right now - this exercise does not use any additional guest table, instead it tells the host IOMMU (yeah, via the PSP) how to treat all IOVAs - private or shared (a bar called "vTOM" == virtual top of memory, below that bar everything is private, above - shared, I set it to the maximum). So even when we get vIOMMU in SNP VMs, unenlightened VM will be still using vTOM (SVSM == privileged VM FW which will talk to the PSP about vTOM).

This vTOM is very limited vIOMMU really (communicated just an address limit), not what people usually think when read "vIOMMU" with guest tables and 2 level translation.


-- 
Alexey


