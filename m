Return-Path: <linux-arch+bounces-10371-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ACAA45141
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 01:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF888189E01A
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 00:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EED2EBE;
	Wed, 26 Feb 2025 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AQJoskzQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4176A23C9;
	Wed, 26 Feb 2025 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528772; cv=fail; b=Uw1iH4PgMWd+TGhOFRsiQGWFruGJQXhhow4dIZIOJAeUTktkn8Tc0b5qFJ5svqjN3hTTMT34hy2O3/TMEUXcdR4f7iOt2NJNUIeKP0Bo0UbD0X1LnBCvuOJEUiMHVuqaG3xPpTgk044m/qOR0lon9F4TdlZxSvaeb3WUeNBGhaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528772; c=relaxed/simple;
	bh=qYMfh90x5xV8DdfK2/ixsgsyeMaMKlDQA6Ev+H0Trjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A/d77kEQbWSSt97As9gMMpxZvSrmUy++FAQCw59pADbbce9YsvnYEwOaFyVkMt8meE+OFzTi0I2wogXsHAg654ERGhlAZNojazrGiKgSldusLj++N4N0hKlyxMovOXy+pkUZCBDv7rIaOVUWrTJpJY/ajqKcf5gbjxk1KYYOXc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AQJoskzQ; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vl9yTLWCMx3ywdPRuK/ABAKGHWRA508n/jK3X3+2wWgwRP0thFD8nae8QVvUnci5jKJXnWmb3MYYzuVaWf4QY/WvOLtlGJUaV2vze8v2H/3/TNZrRpzKOjvWC8YqrpbcpZbOSP0MlR7DdLC/7YiAeRiSxK4RRr4iiOP52QEdcCWKlp3FPoDjzQ5jF5KegOzUpmZE+H+t85R5fbQWznHtvZjkTQ77YA9mwsM2zYLrUjx50hlmP+nHwdYHO5ebJIz9TsgicOskCJshRDnPWJBg0hxeFVeUESMU/dyMIdrNjfHoq0Us7wMja7MP3BuArs6dBw6F3giBNY7bqOcNcLYTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKNvpc6QTlrSNBcHgSy+9CV1GtLEpgtaGB0G3dLwzII=;
 b=elTpJWdGGP6v+xu6/Py3xIQt2wuFduWvepGK3RFV0fJL2zD/lEbCKAa5Vr/lHzEsnbegycI9XcTyEQyobrFr2e7ys0njJfBxgG8+/oASZYIG+ljOTPNFLiHslb/r3G/fpjTdyIBuGqgVBC4G7rcQuoak0D2WHujQoeieM2BAJKp3BZjiN5FFl+f+viihPomzCDb4cnfigaKeqUKGLQgBzKgcfqeswCBE+RwQITfMOOx3Dfp+vcoK/1G8JaubFBba4jNF6telxw6wmfsvAHzgub5yq8IFsJkEhYgK2DcukNHCe07MEJWuN2NHZ421wFmec9sT8xPlnz+7rWoCMNj62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKNvpc6QTlrSNBcHgSy+9CV1GtLEpgtaGB0G3dLwzII=;
 b=AQJoskzQKJYmqXN0GPuiF+V9ze/wcbI6ZrGHWnrnsRJG7ZkTJyyhzOoB1PXlLeSQucoegCKYjWEUNxxXJvp7W44tUa4EyyttqfwEWiQXCP4DKtQG/r/DDD1z1p7+qVki2VhyzZgbnB1yv/SMGp9Vay2rMfGBgL19xib8KYIDySA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 00:12:47 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 00:12:47 +0000
Message-ID: <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
Date: Wed, 26 Feb 2025 11:12:32 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>,
 Nikunj A Dadhania <nikunj@amd.com>, Michael Roth <michael.roth@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Joao Martins
 <joao.m.martins@oracle.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Steve Sistare <steven.sistare@oracle.com>, Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, linux-coco@lists.linux.dev, Zhi Wang
 <zhiw@nvidia.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME3PR01CA0026.ausprd01.prod.outlook.com
 (2603:10c6:220:19f::20) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: c6204de1-57a0-49e6-154e-08dd55fa4c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFdxdDlMbHFlUUNWVGhhekFWNm5KWWlaZmFBcGMrOUF4UUJ5Y3BURTIzS3J1?=
 =?utf-8?B?NzNyWUtjVncydjZqejZhVG41MW44b0N5V3NJdERybkQrTEJNUkF6M3lZeC9N?=
 =?utf-8?B?S2VOSkV1Rnc3Nm1oVWRjZVR1SU1UQy9rKzYzclFWamQzL0JVRzF1UFZkU1BK?=
 =?utf-8?B?QWZTOVUyTHVFcEVQQVVRdURaSXdoOSs3NjlLMlFldlFJdU1PRTYwbWNycGN2?=
 =?utf-8?B?SnluaU4xQkhBeXlzcEdZWTlVeThhV2w1ZGRaK3Irc0V2NFR5NXdMUUhqaThH?=
 =?utf-8?B?bzZrbzFpOU5MVy81WENYM21HQk0yVUx2Q1ZpY3pOd2M4QzhSSEdYZlJCeDIr?=
 =?utf-8?B?Q3ptWFc4Q3QzcittV3VTaDBPUEZybzQzQ1o1YkxhalVUdWs5MTR2ZlRBUVpN?=
 =?utf-8?B?M1l6b0MvSEpzQWZWeGlIUEhWZ0ZzbDdlSzlRV05tMW9pMVl2WVhnWDlpTjV5?=
 =?utf-8?B?bXJlWlZtdjlkMFpkZ3hvNzNPMi9KODFONWNlMjg0djJRb1JSTmE1eWlGMDA4?=
 =?utf-8?B?RGswZHpNcnBLUEQwMEJCR1pNcE0xWGpSNThjdndlajV4SWlwOVkzRFc0OHVj?=
 =?utf-8?B?dnRkOWJKN1ZjUWU2b1NWc0pIazFEWnZFVmNNNW1lYi9DOElnZ2lKajVvSXF2?=
 =?utf-8?B?dWQ0QzIzK0xrd2F0TkphczU1OG5QdURSSmhDQkQ2di9qSDZhMEMzTjFjRUlB?=
 =?utf-8?B?WnBlMlFTamlIcEtLbkRBRGNpUUhCQUFGc3UrUjdQSW9wYnRrK2NWYlhEWVZw?=
 =?utf-8?B?QWRlbkgyTGRFZjY0bGJ0TTFFUkdCVFczb1luT1VUY3lyRkRBTVI5WjNOQTg4?=
 =?utf-8?B?MFdFNkx5QVloZGZDdURqaEhIT1pZYTFlT202NnVaa0ZmK2JFWGN4dlQ2L2sw?=
 =?utf-8?B?WTA2Vi9FdmJnWFI5QmpFSmJDMUpxTFRRTDJ5UVRsOWFNT1BxRUpMUGhqNkUy?=
 =?utf-8?B?dGE4cjNESTRwZktKazhFQzRjY005SjlNZFlJckhnNWI3U3hrZS9yNXQxdCti?=
 =?utf-8?B?N0tNOHRya3ZPekIwYk1KQnVvcEgwVkUwcW9ZWVV0Y3laaVJvWjdqK3k5Z0V6?=
 =?utf-8?B?aU5IMUUwNlpHMUhLbmxFejgrQ2ExRmxreFYzQTF3dThSenlFZU9IVEs0amRV?=
 =?utf-8?B?SzF0MDNFR2h1dHUzWW1PU3dKWElyT0J4U0F5YTBjb28zeTEvOWlxcWIyZzA4?=
 =?utf-8?B?T2NsOE5acldHZHJGcStJL0JWRVA2d3NLWUZielB5M3ZHTEpXSnRCTHNVVFla?=
 =?utf-8?B?OVdlZ2xYazhYenY4amc2NHhBVHFNT09oOWV5N3dWMVkwYWVBMjR1VnhaNXVr?=
 =?utf-8?B?UnQvdHExVTljZ3FqRkJzbzVOQVRhV2pORzk1aTJ0ODIrVGkreHp5WFZER0kr?=
 =?utf-8?B?TkNqd2ZHbFlOZzZTM2NJWVN3c2hMaUk0c2RweFROa09uaW5sL0FOVlhYNEhq?=
 =?utf-8?B?Nk5talZ4a2xrUmFxUlJkUUpGTDF6Y0lNR0N5ZE8zMEFRdlJjZlRTVzBXaGNp?=
 =?utf-8?B?N2djNUI1YURURE1UU1lLSHA1TXdib1FTOU1wbzJuSGhFUlhOMWhBY3FDWDJy?=
 =?utf-8?B?TDVjTER3VHQ1Tm5zc3BhUUlVblAzN1BTTlFhNWkyVjdZNjUzcStkQkNIZk84?=
 =?utf-8?B?azJ4TnlHUTNBczhlS1MwVEl5K2dXbWRSekpJZ0RCY05UcllXK0ZXcnkwTmFn?=
 =?utf-8?B?YVZ5ZEM1KzdVOS85cHR5NnFDZW9xYUc1YmJSN0ZFZjVyZE5qRzNmTk14U1h4?=
 =?utf-8?B?Z1ZrRzh4Wi9DR05IVTZxWi8wRVY2U1dzSytlQnhCTlBCbDNkNExxS21mQWYw?=
 =?utf-8?B?c0V6NWtZRmxCdHF3OTZLVGg1TENxVmhqdG5pMmczRTBXREFwVzRwV1JrcEM2?=
 =?utf-8?Q?P4fqvM5GkG4CI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emNTeStkUzh3TDNZVkxyck5lWlpza0lEc2M0TjQzcmEwTlVZYlg4Qy9VdFVU?=
 =?utf-8?B?Z09vVU5UYWJITnVLMTBvWWR6bWgwVEVRVGVqV0FlTkQ3MVRrUXhuZjI2Z2Fu?=
 =?utf-8?B?S0NmR2dOMEVWOGorTWdnZVlqRDFOZmd3alVuSzdQNDRyS09nTDVCc3pYNDd6?=
 =?utf-8?B?NXlvWGJSRXZiSlgwaHpVaHVxSWZENkhuS1RscndGUC9USjNCN1hCZEJtdDd4?=
 =?utf-8?B?V05VNG1TbkZOSk5oVnBmajRKRndFeURyM1JYV2hzWkJKTndXNjFIMitXdk9V?=
 =?utf-8?B?aEpEeFZxZUwrVlozL1Jlek50emkxZEJwWnB5RXBWcHhCSFluc2NYSDZEVWY3?=
 =?utf-8?B?M29ieFpCYXRYeTdSNi9BaGxMQUlUTFhYcjlnbUVQcXZrVUJxaFp0K0dUSFBV?=
 =?utf-8?B?byt2aS9pNTM1M1hMUndINXQxVVRlNUZxWSs4bDY0U0dIdkZqbmsrbDFZNG5G?=
 =?utf-8?B?MU5SSm9mb1gwaGprem50dGN2RUFWbEhkZzFOTHFNSTltMGtRYlFNRytHRUJR?=
 =?utf-8?B?eVBnQUxKOERYMTIvN2I3OC9aTy9hNE9PaGpPNDk5Wk10TWtFaFlUbVU1WFo2?=
 =?utf-8?B?a0R0NUVST3gva09wV2VPV2lla1E3ZjJEaC9IdmVXSVVET2FHMHVpYjdqNDlS?=
 =?utf-8?B?VHUrb1EveThTakh0dktYQ2xMZjBRd1AzM25YWkZaSGV3eVNvK1NYbDVlV1FC?=
 =?utf-8?B?R3VNRkg2ck5JemVoVVMyR0dhbnpuYTJld0lsdTQrNmtHUVk5YWxhQTNVaFpV?=
 =?utf-8?B?dEpSSGNqN3BEdWVyNHNCTyt0eFhYazV1VlU2TTZvekIrVzdHd0VQcXZ1UlBC?=
 =?utf-8?B?WVhRekkwR1pCa3l5OWFaTDg3eWZSM09VUXZIeFFXbnZoS2d1WEVDQ3VJdEJE?=
 =?utf-8?B?aTliVGNvQmlNZmtHdU1BaS82bElsNU4yR3dpM2ZpNFZmZFBmTkRXTDg0UHh2?=
 =?utf-8?B?dWtWRnorNVZZd1lmUWpSTmVHVjJXdmdKdFZYN29zUjJQeUFuWHQ3akRoUXZ6?=
 =?utf-8?B?M1FmUGkzekVVU1d4aDVkZEJaUWdvU2l6N3NVT2VucCtlTzFZSWFTalVNQktF?=
 =?utf-8?B?djgvRDNhTkwycWV4b0Z0Y09ONEJlc3gxc0ROaURheEdRMnJNb3l4K3BzVFhV?=
 =?utf-8?B?NkExNjE4MkVzcHZ5TkI2NHdYaWt3SDY1MjAxckM0WnJSNXl4dWxKZXJHMXJU?=
 =?utf-8?B?VFVrVzJVZ0JrVXhXajdlMzNHK3RZWnhWSHpGeCt1SEw2MU5XZTcyUjRaUWtY?=
 =?utf-8?B?V0xmaDUrNSswUmdodUkwOTErbVBTUzVFTGh1Tk1uRk5EWWVxY0tDYkVsNkc2?=
 =?utf-8?B?TDZTRm1kanpCYjBCYVV5NmJaa1dOR3BlaXlqdXk1YkVaRVFJZStRQU1jWHhJ?=
 =?utf-8?B?Qmk2aVByNndyeExvQ1JzQ1ZDSzdrejJiTDFIcmczcnk0UnlxYnN5RmFkSURy?=
 =?utf-8?B?d1hNOFYzUlJpdmZPOFd4ZUpmQnV2WEZWNFJvcWlqalR3SmhpUnRmcFFQcGVC?=
 =?utf-8?B?bEhjZlZFSnB3dXlJcWlFOGoxVVd0bkp2SHRjbm5pNDNSbXVmM3hNa0ZLYmJn?=
 =?utf-8?B?Vmt4VFFDcy9ESFR1N1RzaW04cHI3Wmxtck9LY0pBVXVmUTVKVDFlTXB6UnBx?=
 =?utf-8?B?M0N5bW9ZRU5zNkYzM0d5MitmelF5RTVZNTdGWFdzMGdaanNqczhTL2krZTdC?=
 =?utf-8?B?YTk1cHVCekRBQ0toQVZsQmtMZTJaRS9SVzRPWHFTMU1SWk53aXFsaFpIMkRB?=
 =?utf-8?B?eXU5VEhsejIwWTI3cHpJSXFTakdsbE9vSmcvYlhGdXpNMWE4VU93RE92NVpJ?=
 =?utf-8?B?c0dOT1pTVHFQQmhvL0RvZC9ydlRxS2pzZE5uaUwreW11andDY1V2bEpEVmlz?=
 =?utf-8?B?Wnd1OW5qQk0zM2s0am5kS3pNUkQ1cDBycDZFRlN0TWZ2NU5aTm44ZFNzVmVx?=
 =?utf-8?B?eDRSQnRkYVdRZFpIMFZNSGpFQWdkWXVEQTRiZ0RnMWlpL01VZW9xRThicUlW?=
 =?utf-8?B?bE1DRzBYNHVxVmp2NkJCVmhZLzJZbGJ6Q3U4TW5JZlVaMXU4RmVoMWplbTFh?=
 =?utf-8?B?d1Z5elprd3FIeXBWOFluRy81WGROK0Z4RDNiNHovQWluRXdDMjY1aGFaODFO?=
 =?utf-8?Q?IihUNCeHOR0L2zBsqQl0UduEj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6204de1-57a0-49e6-154e-08dd55fa4c7c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 00:12:47.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iv9nzcqui3z1RYj15dmT6awlHox96/OYqmD05N0dlgQ2rgJKlY+IaL/AAnpBrLiaY4vwPa+sKpKzABuTVq1xTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057



On 25/2/25 20:00, Xu Yilun wrote:
> On Tue, Feb 18, 2025 at 10:10:01PM +1100, Alexey Kardashevskiy wrote:
>> When a TDISP-capable device is passed through, it is configured as
>> a shared device to begin with. Later on when a VM probes the device,
>> detects its TDISP capability (reported via the PCIe ExtCap bit
>> called "TEE-IO"), performs the device attestation and transitions it
>> to a secure state when the device can run encrypted DMA and respond
>> to encrypted MMIO accesses.
>>
>> Since KVM is out of the TCB, secure enablement is done in the secure
>> firmware. The API requires PCI host/guest BDFns, a KVM id hence such
>> calls are routed via IOMMUFD, primarily because allowing secure DMA
>> is the major performance bottleneck and it is a function of IOMMU.
> 
> I still have concern about the vdevice interface for bind. Bind put the
> device to LOCKED state, so is more of a device configuration rather
> than an iommu configuration. So seems more reasonable put the API in VFIO?

IOMMUFD means pretty much VFIO (in the same way "VFIO means KVM" as 95+% 
of VFIO users use it from KVM, although VFIO works fine without KVM) so 
not much difference where to put this API and can be done either way. 
VFIO is reasonable, the immediate problem is that IOMMUFD's vIOMMU knows 
the guest BDFn (well, for AMD) and VFIO PCI does not.


>> Add TDI bind to do the initial binding of a passed through PCI
>> function to a VM. Add a forwarder for TIO GUEST REQUEST. These two
>> call into the TSM which forwards the calls to the PSP.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> ---
>>
>> Both enabling secure DMA (== "SDTE Write") and secure MMIO (== "MMIO
>> validate") are TIO GUEST REQUEST messages. These are encrypted and
>> the HV (==IOMMUFD or KVM or VFIO) cannot see them unless the guest
>> shares some via kvm_run::kvm_user_vmgexit (and then QEMU passes those
>> via ioctls).
>>
>> This RFC routes all TIO GUEST REQUESTs via IOMMUFD which arguably should
>> only do so only for "SDTE Write" and leave "MMIO validate" for VFIO.
> 
> The fact is HV cannot see the guest requests, even I think HV never have
> to care about the guest requests. HV cares until bind, then no HV side
> MMIO & DMA access is possible, any operation/state after bind won't
> affect HV more. And HV could always unbind to rollback guest side thing.
> 
> That said guest requests are nothing to do with any host side component,
> iommu or vfio. It is just the message posting between VM & firmware. I
> suppose KVM could directly do it by calling TSM driver API.

No, it could not as the HV needs to add the host BDFn to the guest's 
request before calling the firmware and KVM does not have that knowledge.

These guest requests are only partly encrypted as the guest needs 
cooperation from the HV. The guest BDFn comes unencrypted from the VM to 
let the HV find the host BDFn and do the bind.

Also, say, in order to enable MMIO range, the host needs to "rmpupdate" 
MMIOs first (and then the firmware does "pvalidate") so it needs to know 
the range which is in unencrypted part of guest request.

Here is a rough idea: https://github.com/aik/qemu/commit/f804b65aff5b

A TIO Guest request is made of:
- guest page with unencrypted header (msg type is essential) and 
encrypted body for consumption by the firmware;
- a couple of 64bit bit fields and RAX/RBX/... in shared GHCB page.

Thanks,

> Thanks,
> Yilun

-- 
Alexey


