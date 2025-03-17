Return-Path: <linux-arch+bounces-10898-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEA1A63BC2
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 03:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7029F16D95A
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F29B13B7B3;
	Mon, 17 Mar 2025 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DcCcWoc6"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B868F5C;
	Mon, 17 Mar 2025 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742178770; cv=fail; b=No8PfGOb50nvYDBi7di5MgN8dY4ff2g4QA1kakpG6OqFazUuNoSRQgumqgkfCIRV5O6ZQc5trpi4BR6gNk8XmtqljpmorLDvyFe0XGhnBtxfiLBlxscwB41t7leopyL6fIe5ZJsKcUkmtEnrDyMscnxk3UoULQNq1IdBjwerKWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742178770; c=relaxed/simple;
	bh=/ENpvmfreqy+pD8Iwbx84I5ElPxglW/z7FTBtS/CVwc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UMKsLtKsc4wWXMyOn2MKn2xKPpZYmYh+ZHmoMfKAMwzrpiqADUAz5h/J8DgDVUZvK5G4tSkFbJrohP4gOr926xBjr+PTmS0AC6MvtbrXPs+JnbkJk+rOws61/9wrDJzaV0Mxfq73mZtQ9R78b5TyVP4NF5+ONGJhwkKYu4e2mfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DcCcWoc6; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kp83hslFDmqWH7/LoWVXN+bU4LkvfJ4e1mjp2UhKTmYD39foWZOpgZHEtPeDyumMcpilGo/pv7LB2icYH6Q0qE8Ha4jPtzVJHP0zFJjbPcD2cmmkl4q86+DiXX1JMtI46XHz2d6+0f2HzOgzNz4TWPpo7y3s1dr2zmkXf/9mkYOErBq7ZPxkIotWP234jpHXkJgvz9BtAgh/DwLm32KfwvM7+y7619q2i2m5hg2A2Gnkk95F4sD+5w0gMnbVx+ad/LeSBlJqiptueRu5fyZTXiuyxnd5Z2VFyFj2qRGw5Ar8+oAUOsHzCMoREp+AdP8mHdCGF6Zzbb86TOufvOAIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJdEpLiEY7nTKsjJE1A9+4+BHy16EYzdsnlTH+4b8cs=;
 b=lMqe4He41JtoCp4ON46rf5NYxlkFuhhoYsDtxeqdwR3JSWn1voKTQozdNRqWaRlRNsi6D9TnnpuUXNt0LppE3jdwnBhrukruQhsJSSv+9OZZ2Z8/Qg3DrNKTF9WcPcXmlIPVNgm4qYtSPTpHm79fVakt4D1x1w+E/UyBceGPqAxrH0cbG0u1hLfGZ4/A/k/SC1WogwXlaYy46yIkbu0rqX2rD49JLSU2jUioVJKX4r+i3WkDRunaCdg+eDz3tCvwf1Oqsf9z2UWD2qXUg22xswUT+uKWq7FSqiqDu0NwuSsXD1GbpY2fllGFye/22JXcHNz2sSl9Y1gPcRcgiM347Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJdEpLiEY7nTKsjJE1A9+4+BHy16EYzdsnlTH+4b8cs=;
 b=DcCcWoc6slDQAX4FmWV/F3ye2CaiL5uC+8yiS0P/o1WwAGMWXHwEl96XaM4JSTXoC3S8QuiaDDsdYBiudV36zrXIv6jJ23+FzETvXIdzVJzLlZlI+k5m+KdYEZ7zfmUnBeoM/wiT2A5C92rmCh/gOeHFx8a2limyZTKyTl1fIg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Mon, 17 Mar
 2025 02:32:45 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 02:32:45 +0000
Message-ID: <926022a3-3985-4971-94bd-05c09e40c404@amd.com>
Date: Mon, 17 Mar 2025 13:32:31 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org, kvm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
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
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <20250226130804.GG5011@ziepe.ca>
 <67d4d3a5622f9_12e3129480@dwillia2-xfh.jf.intel.com.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <67d4d3a5622f9_12e3129480@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME0P300CA0037.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:20b::21) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: 1daf6fd5-43f6-486a-7fed-08dd64fbffae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTdwSWpLWVFGL0hBUU0zMVNnZnIySHZpek1uM2ZNTTBaZEpvdVlBcFI3bktI?=
 =?utf-8?B?R3BEczJmOForRzhIT3dFbUZFOUdnKzI3Q1JDRnhOajdlS2NQUUMzbDJEcjdZ?=
 =?utf-8?B?aVBBQmJiUU5pZjUwWEd1OG1WUTU5Y3I3WEhFT0FScm5rWUIzWUIvMDBQc3RR?=
 =?utf-8?B?YVBSTno0dTgyZG0wY0VMeXA3cUdDSnR5WG80UVJ2NEN6SUxYN01tUnE5R01N?=
 =?utf-8?B?QmR2QmlKMENsbW9RcmhNbWFGNjFsd1NCc3ZqM2NpQnBZQWxrNG1IaDBxaGRG?=
 =?utf-8?B?NkRVYXc5TjRQR3dtazFkVXRUYk1NaFFUc25seU03cktPc2Vzb29lQjBYV3F0?=
 =?utf-8?B?eUdUUVdMUzJZWWh1ZklGd0xwd2VzdkVTaVhIWG1JL1ZDajdLNDllZisvNlJU?=
 =?utf-8?B?TVJ1bTFyeXJPVVJpUmZ5bmZlYmxaeTJDdEMzRGw0YmhGNUVFQzUyOVlZY0tY?=
 =?utf-8?B?bEJQcnVhaUtrQUR5M2ExYjJnREFERnpUaTEvOGpqMWR5UlVKR0MvNnZXam1D?=
 =?utf-8?B?SVFoaXpTVnZrZGxiTDVrSzlnOXJMRStnN1BrT3J0bDdTRkJXYXRDNmtIZnJU?=
 =?utf-8?B?MTY4aCtMSmxMRnk3elpTSm1RQWVUOHdpVDltTE1pMUJlK09aOEVoV3EzS3JK?=
 =?utf-8?B?L1BueGlKb3FiZGpqU3NWbEFFcWVXUVplZnRDcFBCckQxL3BwK0paUzc5UnBa?=
 =?utf-8?B?cUl5NS9SREhOVFIvbGJMbjdBeW1XRlBtSkI4VDdGVnFPZ2kzSE5JUGRYOC9r?=
 =?utf-8?B?Z3RlTGMremYrbHZjeDlrOHFjTnpFNEVyWm9kbHM3UzVVN0RJcW9ML3QwbVZh?=
 =?utf-8?B?YXNGRnpXQ1R1Q0hoaWRWMnk5YTBteCtmNTVVejhFenVoTW41Rlk3YzlFdncv?=
 =?utf-8?B?TU03TFFKSVF5MXJuRDZBWFBqcXNHT3Y3YmYvMGF3Qml0UlRQTG9ndk1OUS9C?=
 =?utf-8?B?MUVRNUg3aVlTM3c4ZXVGdmdJVDB3cnQrZzhWZjMrVDhKN2t5RFQrdUt6bytH?=
 =?utf-8?B?SksvVVRxY0lqVFhkcnprYkFPcDVmZ1hoNnhYMitwd0ZYTlB3VGpZcEN5SCtq?=
 =?utf-8?B?VnpmSXdVUzRyQUpTSkFBOURmZkh4OHBwN1Fnc2FtaThIWHppN1JwTlRXVEN5?=
 =?utf-8?B?Nlg4T3dxTWdySHUxRVZJN2dkOEZrMDRLU2NuT2NnVndtcEp2U0EzWk5wc25U?=
 =?utf-8?B?OWVPVDBjSmpYY3hsMXhzc3QweWozdzMrNVJ4SDJKYk9aY21qUmlKV05URlhP?=
 =?utf-8?B?TmhTc1VyZnZ3RW03a2FmNDk4K2ZGWnkzK095YTJLcEdNUGVHcndCU3NKWWpY?=
 =?utf-8?B?cFg5S3ZQQVROVVBKNTRucGhLRGFndGQ5aGpYZ3p6UkRvTUdRYTBnQ3BXZ3NB?=
 =?utf-8?B?TGkzZVd6azE0eFhQY21qWmpPZlpBWlRURlg5NkROODkvVmQzN0JyckUyMXUz?=
 =?utf-8?B?ZGZTMjg5eXBwSEpvQUhpbmZid3dFbW1LOHJFTWFLbWlkNWFkRyt3RlFGTlZP?=
 =?utf-8?B?NXo4Tnl6c2d0c2wyTzBaWnpQdkQzd0FwS3BYTis3clBTMHRTbXYrVVI3cERu?=
 =?utf-8?B?Q1JybWZyTFBsT2FPT3RJY1N3VFZrTGoyUE1EODJnbk5jTGhITU14aFE1WjBS?=
 =?utf-8?B?dXNudU5XbXlBVXBnaTFpbEYwcURxZGZSRWwyUnpQT2hCenFjYk9OTXF1NXFI?=
 =?utf-8?B?S3Ixb200bkhCU2hRNWQrK0ZjeVBqUnJvZWlCbmg5UWU4endGbm5wbWZ1bFFY?=
 =?utf-8?B?MUNtaXJxdXdQSENnd0MvbENlTE1CVVJEMkIvQldqcDQrR0FJOEVEZ3V5MTIz?=
 =?utf-8?B?QkJZTnI4V283dzlhMEF4d3pZVktKL1lWd0NCZWkwQnMzdmRuanpLUlBEVHpN?=
 =?utf-8?Q?1LwSAZf3C9RyA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUpsRVhkY0xoeW5GS3pNUmRtRU1VR3kvdzIwb29RVXZLejlHVWRWaks2YVpP?=
 =?utf-8?B?UnFYTmJxREtUU01QOWhvN2piVm5kNjE1R3ZVeUpGZkQwWmlFOHpZOEd4bVBj?=
 =?utf-8?B?WklLZTJmbU5ZdHd1eEk4R3ZhdEd6R05WQnB0anN6MUtsbXB3RjAzY0ZtZ3dC?=
 =?utf-8?B?SFFnOVl4ODIrcHVYdVR5QzgxVnRNdk9DclBENFZFZkJxemJpZFJrL1RUUnhJ?=
 =?utf-8?B?OVd6QVNxTEdJQ1RUcDcwaTZscFNPTXVUMHlhQkR6L0NaZzN0U01WTytJOEdp?=
 =?utf-8?B?T2lqVUZ1ei9TenQ2L2NYYlhZaFdVZUFmalJRUHFPN0ZOelMwaDVzZUJOcFYr?=
 =?utf-8?B?UE5jYUltOE0xVG5ITHZPSWdXamV0QXgrRzk5K2ZiTC9hZmpDR2M3SDk4Q2N0?=
 =?utf-8?B?cU1DT0t3V2psdzEra3Y4Sk84ZzlkU2hEb0tnalJ5YWhMZ1dIVWoxR3pLWktG?=
 =?utf-8?B?NEdyQVlzam40MExhT1A2djIzL0FNWUZmTU96Vm40MUZIZUx0K0ljNjQvQzFE?=
 =?utf-8?B?djlEUGpFcWx5Z0F6cUlBV0E3RmR3ZU1vam9oZ1pWaHVzUmYxSCtxYklqQ3BI?=
 =?utf-8?B?QzJ0TlpBR0xRcW9FTXRDaGJUSTVrL3hUclJiQnJLL0JDV285QUpvK011Mm14?=
 =?utf-8?B?ZnFTd0VCN2hVNXNHRXIrZVZJMzR5WXBkVURDZHJRTjZBbkxOWXVmdG9RNkZa?=
 =?utf-8?B?Rmg3WWF0amloY2RtMEcyaTdtM0I3bFUxT0E1QmF4clczUHFnQ0xsbisvR3lL?=
 =?utf-8?B?YkRmRlUvc2JQU0ZyN2xuc0tVVHpSRVprWXRNSmwyTjN2VXZTRUJNcVIvL3FU?=
 =?utf-8?B?UEs4Y2tmMkhhNFhtTi8vS2RjbldKU1N3SllVM25MeE1OVC9rK2lkTjBlK0dB?=
 =?utf-8?B?aEdDMlA1T1kxRnpVSWQvK0Iyb3k4Y21ieWRCUlRhVTIxRlVYUVBQU0ZhR3Ru?=
 =?utf-8?B?L0hvWmUzNTVDbENONk9IV2taZ1RyY2dvSzh1T0krclVGdDBXVDBxQlk4YzhD?=
 =?utf-8?B?dXc0TC9YaW1QWTdjRENKNFZRTFBaMVJ4QklSdU1RZVowMzF5ZHB2c1dOeWNo?=
 =?utf-8?B?KzhzQnJRQkFBL0MydDN3WTdhTUk0aEhDTGkzR3o0U3YvUEVvVFFZN0JlbW9k?=
 =?utf-8?B?QXFjdEFkWVFUM2VGN2RjdkdjQzQ1c25DR09MenJ3UnVEbmJMbEs4M2Q3czhH?=
 =?utf-8?B?OUNVcVRnOVFROXpoaElEdlN2N3I4R2NXUmRLSXpJMDhnSFEyb0tHSndjanFu?=
 =?utf-8?B?c0ZwSXE2M1VrR011NWhWRmcwY1diSVhYZG5tY3RUb1QrUG5wSFEreVhTUGdP?=
 =?utf-8?B?Q0htZ3Q4bTNJNlcySXkrMXBqSk82dmZ0QUFFL3hkOE9TR3lWZE9XUGZxcTJr?=
 =?utf-8?B?alE5WDVUZ2NvTDdXQWROdFRqdkdxaVRhTmJ1N2x5OGlFODNON2U2bUthSFJn?=
 =?utf-8?B?bjlIWG5BaTdPc25EdFd3KzRyb1puTWpITHRqZGoxWXV3cit6dEhITTM4b0hk?=
 =?utf-8?B?K2lRVW0wN0hoczZPc1ZVOVJka0pFVnZMNkN3bTZmbERhV1VNMzRkb2ZWYVdv?=
 =?utf-8?B?YjRKbk93NStDYk5uSW9oS3BjU2dmUDcwS2gvVGpoR2tyQTlPbzZOaDVQSTRU?=
 =?utf-8?B?MWxwU1prVER6WXJKeWRuWktGeHUrdlRhNW9selN6SHNkNXBnUU1vOW5rNWpG?=
 =?utf-8?B?dUhOSEl0dTgyQTFnb0xlZkF3b01JRDRtWHo0SWoyUUU1cHIwbVlRYW1EL0FU?=
 =?utf-8?B?RFRSbzJSaGFyTkZnWXZvc1AvWUllVFpHcE9hclh6Y3l0VkJpN1M1Q1lZM2xa?=
 =?utf-8?B?VThHVDNZd2RiTFR6N0NZeDZKcWdKUE1EMzA0czN0bDZQbmhZcEJDZXBqcm5h?=
 =?utf-8?B?MmZGTkk2WVBmVVNXdDdMS1dhZ212dzF6RzBqT3BRQmFCd3RadGhzVWh1Qlk3?=
 =?utf-8?B?aHR6SlJ3NlhlRFg0bXNRbDh1blJoKzdkZU5OcDBsek9TL1ZYanRrbTk4ZWJL?=
 =?utf-8?B?dXpvZE9vbWx0bWtVREEyRXZoeEU2QUtrWmRwTk8zU0hMMGZtR0d0eHM5Tkhp?=
 =?utf-8?B?V2Z1S3ppVXQxK21YL0tIdnpISFliWEtJVzY0RS9oRnJNV01ucFdidVFFcTJT?=
 =?utf-8?Q?1+2dhBsHtk3tLzLsH/kNjhN/Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daf6fd5-43f6-486a-7fed-08dd64fbffae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 02:32:44.9273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YM4HfNxUGWenIqEaPQlQpvA3s6pzdkzWLPcSPl4vRsA2icC7oS/oGi4LX4QMVDHBCOYFSL/pIVKfDkkDm0/yvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886



On 15/3/25 12:11, Dan Williams wrote:
> Jason Gunthorpe wrote:
>> On Wed, Feb 26, 2025 at 11:12:32AM +1100, Alexey Kardashevskiy wrote:
>>>> I still have concern about the vdevice interface for bind. Bind put the
>>>> device to LOCKED state, so is more of a device configuration rather
>>>> than an iommu configuration. So seems more reasonable put the API in VFIO?
>>>
>>> IOMMUFD means pretty much VFIO (in the same way "VFIO means KVM" as 95+% of
>>> VFIO users use it from KVM, although VFIO works fine without KVM) so not
>>> much difference where to put this API and can be done either way. VFIO is
>>> reasonable, the immediate problem is that IOMMUFD's vIOMMU knows the guest
>>> BDFn (well, for AMD) and VFIO PCI does not.
>>
>> I would re-enforce what I said before, VFIO & iommufd alone should be
>> able to operate a TDISP device and get device encrpytion without
>> requiring KVM.
> 
> Without requiring KVM, but still requiring a TVM context per TDISP
> expectations?
> 
> I.e. I am still trying to figure out if you are talking about
> device-authentication and encryption without KVM, TDISP without a
> TVM (not sure what that is), 

It is about accessing MMIO with Cbit set, and running DMA to/from 
private memory, in DPDK. On AMD, if we want the PCI's Tbit in MMIO, the 
Cbit needs to be set in some page table. "TVM" in this case is a few 
private pages (+ bunch of PSP calls to bring to the right state) 
pretending to be a CVM which does not need to run. Thanks,


> or TDISP state management relative to a
> shared concept of a "TVM context" that KVM also references.

>> It makes sense that if the secure firmware object handles (like the
>> viommu, vdevice, vBDF) are accessed through iommufd then iommufd will
>> relay operations against those handles.
> 
> Yes, that tracks.

-- 
Alexey


