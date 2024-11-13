Return-Path: <linux-arch+bounces-9073-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2190C9C78F4
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 17:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6192282DF7
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 16:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B7161326;
	Wed, 13 Nov 2024 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oRe/64DA"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90383146588;
	Wed, 13 Nov 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515699; cv=fail; b=IvM6kXmxryvDI2uaxl0eFiikqbM3cMz5Wyy5Zd2trWr1ehEvzhuJeNRpJH6+mgE3dZLi9trTeNgi6GfrKSiRiE7h+bRXBU3ge1G3D0pFhg2TumraVwOzdJEoI217qpiiftsMpzvDzDViEUTXiN0LiM0P6+ILSEkDePDuKTw/Xgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515699; c=relaxed/simple;
	bh=LbHoWVPRfeq+ULsy4RZW4ZhGLAip2fEENZEjlNDd0rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NoV356KIDXkonw3pbG8IhCq+H8w2j3Wf3zyFfl4gwmAhjrThdNE0c46EXg7fOE1xv7CXET28OKuizsPasd8O3ul2rm+YxYFBLweatsDpGxTqeD1enSSsqJ0F89fi1kXS0zRAUL7zWaqhtcb1z3saEEIilm0BaTTCQpPbUMiuvkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oRe/64DA; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEOcRcYdOvaD2bi7OuacOBf76GMItfcG+saDV5BzG/MQinqxN26dHrScR5klNifpO/zyP58c4H+oKMSz9SOXqTOe00vUWqzneZzxMQdtcSPgaVIY8Np0FvGwNr5l2b2FJTTFJS7+t1EgM2d9ueXs2lHQNX6dGlvBU1Xx4+jMZ6vC1lv6u9pWI91hoGYASV6QBNSwHl8UUiygA6yPuIP4L+WqaxBKSBDQg8Ej1TohBmBfj6D5vq5Y9XeojnVM2jNcZr65Y2aZ1KrCISQNs0dePtLnTECOdBm6dLBtotC5c/DVC8WBcR1UnyKy/y1LL2M92YQJm2fIK6u/fM6MejV88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5coVBG458QCANz/XZT5kmVZgLteXupTwzkXUB/LiFss=;
 b=GMNAwl1tB3gmle7w+aG20yeQrK7Sz+p+9c3lRiiMu5CPPp4ZaNAfKSkfnswppTIs/na9cK7HxKnla6q4OKBQBTjWLygKEp9F8mwcFBCwl5EFlwmHLW2aXEIS2Dnzjx2Zi3e3MDToJANgdnQ0iZ39oBo8ZiU867QNFKg2tvEnNOdq3vQ6NbEG+vDB3bonFdrfzC/VPbBnH0hZ+WqjapZxs6IovgAGmr40WdmSjqo4ZimH0OO3wugA1GiFo7VTbURfUWsYuJud44tOxP5FLzOPehGxPeKnxUyJWoPgmge5WlZRG5KXe/ENuaYqahlQD13YdYJ0v3UzFj3PKv5J7NMLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5coVBG458QCANz/XZT5kmVZgLteXupTwzkXUB/LiFss=;
 b=oRe/64DAzqQkOPI2VG4grRc6E93JLOydUv2QH7wP+jDa2CiMlFUU4Xh5/Uw7VJ/ypTY3CatRVxYIGqLRkPLPrSlD7oD76BcDRf8mLi3jzOBE7EkB0X4sfomY+25IvEoVKwH4PkLLUToF64BsqNYV0+T9YCA7Lv5OnTI3E1j/2+/AYhl2oEUMMjCYdhdbgy1ocZr/No4F9B1F8ye2b3Cyyygn5fUe7HsoyntpOsHuP1/is+y+hwwl/HSsGYANs1YgAeqDPwvENKiXNujoeg3Ld+nAnVzpNTs/quclFi2b49ugls6294ab3ivAyeBy12PezsP8Vj1ZzLS2ChPNxlE+7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.29; Wed, 13 Nov 2024 16:34:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 16:34:52 +0000
Date: Wed, 13 Nov 2024 12:34:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	vasant.hegde@amd.com, Linux-Arch <linux-arch@vger.kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com,
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
Subject: Re: [PATCH v10 05/10] iommu/amd: Introduce helper function to update
 256-bit DTE
Message-ID: <20241113163451.GK35230@nvidia.com>
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
 <20241113120327.5239-6-suravee.suthikulpanit@amd.com>
 <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
 <20241113132031.GF35230@nvidia.com>
 <CAFULd4a1PHREX6ws9Gyu=TaaZvdgLfh6peoE5Tt010uGyY9Hgw@mail.gmail.com>
 <20241113140914.GI35230@nvidia.com>
 <CAFULd4aGDM5ySO-PeOH0+_U89mnqYqQ7v+U0ZsMode3bxs_X7w@mail.gmail.com>
 <20241113142807.GJ35230@nvidia.com>
 <CAFULd4aFvGj=kz5Si9WpAr33KFtJDO5+sdNO=NBB+boS=E-E_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4aFvGj=kz5Si9WpAr33KFtJDO5+sdNO=NBB+boS=E-E_Q@mail.gmail.com>
X-ClientProxiedBy: BN8PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:408:d4::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0ea9c6-2599-435b-fefd-08dd04011946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmRhZElUSkFkMzRZT1N5VG1ieDY2K2tWaHExNmMyR3FQZW41emV3K0Z6bVhK?=
 =?utf-8?B?Z0JxeGdOdjNzblFPaVlZVGRkM2xkSEhQR29DOXhmdFpSMmgvTXJCUFoxNWFV?=
 =?utf-8?B?ZGlwVWlVZFNpTkloRFBPdjhyejV1N3JRL3VzMStBcEFhUDNFMk5nUnpieGNB?=
 =?utf-8?B?dGN5dEVmL0FWRFByUHl2SnB6NEdHY3FBdkpRMXVpTXZFK0FKZ0NNQ29sZXRi?=
 =?utf-8?B?cWEra1RWS0lhbGRxNVNPSEorMUlKOUd5VWpxcEVCUjB2TlNWVlBMZEtwdUZY?=
 =?utf-8?B?YTFNb2Vja2dtTEppRkJSdFlSdEFpQTl3SE5icm5RSnpUeWtjV3YwRXpyY2pW?=
 =?utf-8?B?eUdaN1NmUy95TitXclBuVktCa3g1QXJ6RlJoT09MUDRuSXlPYy84TUE5TWlX?=
 =?utf-8?B?czNueXlkM2FqVUhOYmx3WEhqWmIzTmtLT2FWbDhLb2NIOHVSRVhXcGZhOU5y?=
 =?utf-8?B?RGxpRkVJUkh0YnExMFJwTzVnanN4eWlCL3B5VE93dmxMekRFM3kzYVN6bHpm?=
 =?utf-8?B?a2F5UFJTSzdOQVJTdUtYQVRhcVJMQlY2TDNEQUhCcHlOTFE1YkJnRXlrTnNm?=
 =?utf-8?B?K0J0bTN4eVVRQkh4VEgza0lac285dWVKc1NrWGMwWkZiWk9zSVJJMUlCNGJN?=
 =?utf-8?B?K1llbHI0L3JKNzRITE9WbDhyZ3BENjYvdHdrL0lzTmt6dDZUNXM5VWVjV3I4?=
 =?utf-8?B?eUE4dlMwb0hrYXFDZDdxc1pzUlYwQ05nUzBmaUtzd01CSmJRUnljcWtGTzFH?=
 =?utf-8?B?blNJT2JmbkM0aEFxUHpCVjV3L3g0Y3B2ZCtqdTdLRDZCcG5rSXVaNTBvYzdT?=
 =?utf-8?B?d0lERXBXbWU3V1A1WHBocWtZTE92SzdFWU5yWWlKNitQU0pXZzd1YWFhRjEr?=
 =?utf-8?B?ZGlUaWFTY0wrdmFaRDNHSnROTm5OWFRNWERaZXVheC9hQ1lyTUxuMzk4Ulcz?=
 =?utf-8?B?VkNiUEQwR2VxMlIvcVRyYjROc2ZsbnRGbGZNdk5IMUlHcWNmOExnMHVJOXpM?=
 =?utf-8?B?NHBLUGxNLzNKL2Rpd2s5ZVZQRzU3YXZNOVU0ekpjdGdwWTVJZVBEMjF3ZjBE?=
 =?utf-8?B?bll2ZUVpUm05cEtKdklRQjduNlhlVTNYRWI0TkM1L0tCUDNoaTVXczFYK0tt?=
 =?utf-8?B?VEVLYk5xRzV2Nk84RnVLRzJyU1JacGhVWkFZYURwd0NLWm9CK01KMjlCV2dl?=
 =?utf-8?B?d0haQWYwelRTZWlTUmdqRXdqdi9FbHpueTcxZVpySXYwdDJ1YzQ5T2o5Zm5D?=
 =?utf-8?B?aUVvdGFOaVNrQlV2dmMzUEttb3hoclZaNy9jN1Q0azZIOVdUV2V5TDhHZHdH?=
 =?utf-8?B?UnFXZ1QwOFpKbCtVUXJBeWJoVXZ5QXBWdHFxb2lpWlJzME5QSGUwRHpzUzdm?=
 =?utf-8?B?cTNubVNtanhKRFNKbFV6TGZjQTRKV2ZJeXY1R2g0MVRJTWJrdktnWjhDQVdu?=
 =?utf-8?B?SzlOM1RBTk5JMEZrTHloOGZKU05wRHNXdUYzaFNlOU0rZDJya05CVTNyeGNL?=
 =?utf-8?B?cHoyWS8wUERjd3BzRDNSMmZ0SmgyY0tLTmZya0xDQmliSldyRVNqeFcwcnJz?=
 =?utf-8?B?NUVmM3BwSHFsYUl5NDhab3lJc2xXTi91MEx0cFQwdGJNakpORzM0M3AvUEkr?=
 =?utf-8?B?dTVGRHJReXBqRjd0em5Mak83OEEweGE2QkMzclZHQVFYOFkyMFhJRk1zWkJQ?=
 =?utf-8?B?ZVVvakJLL3diWjl1K3BGZ2hPT24xQTNDck9jUUN2MnRGQ2ZTamJKL1NJR0k1?=
 =?utf-8?Q?DS04HceM9iTEJPi464Ran0XHU84WzQLhgy4pfI2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUExcnhTd29ERTFaaEpTOWg5TjM0UVdrK3hoWDBuMkp3OERTb1N0UUZGcDht?=
 =?utf-8?B?MDIrbUQ0SE1JdHNYUTQ4Zk5TWXM4bktaL0hjcWZGeGM5L3NwQVJHZS9OSFlr?=
 =?utf-8?B?SmQvai9weSs0czdTeithaVZXR3VxemhNaEhVODBJYnY1OEgya0JVUmNoTWtE?=
 =?utf-8?B?QkUxQUNTY3RQN0JIUXVGa3lGWG1raE5YYzdaSFI5V25STllJNHFQbGEwOVVQ?=
 =?utf-8?B?dVpEOEJIbjBsVTJjTUJ4Nmk0b1Ezdzd3am1TV3ZhOHMxOU5XWVBIaGNXdUxx?=
 =?utf-8?B?OEc5Rkl4Q0IwYWUzR0NZcXE2cXV6L0pHeDhHR1UrWW9lVG43MXI3VDVacEtm?=
 =?utf-8?B?OS9PcDlWcitHeWhXNHF1UnZ5dFNxRUZTeUttbncxYWtVM0RtUmRjUy8rTjJq?=
 =?utf-8?B?UkJGZ0xzbXc3QzA3MlZQNU9ObkZHekZSdU1NNGRHTG95YVVnY3IzTlp6U0Jl?=
 =?utf-8?B?bGxYYk1tekVCTXErYTN4Wm1ERWRYTGM2MzQwb052V0RoL28wS0ZXV01YcFB1?=
 =?utf-8?B?VWZZUXhid1VYNm1iaGplSE1ZbkpZUitlMXc5WE5Ka3hYYVZ1MVpPZDJUSUFP?=
 =?utf-8?B?VUZMazIwN2ZsQUd5OTcza3VURzRnY1ZCWlpSMWIrYi96amRiY2FZUmUydits?=
 =?utf-8?B?RkNGbVBtaE0vOVErRFdXME1oOWUwNktReThCSFY0TDNTVysveG53N0pkTzNo?=
 =?utf-8?B?MGc0bk1VTXNRdHFlZzhERnE2WGpzb1RyNjkrcUlnMmdmcmM5TWFTRGlZZ2lU?=
 =?utf-8?B?MWZ4WSt0dlEwMXhOWGVQcGpvdEVVdE9DbVlCdGU5YmZsZmsxSFZaQSs1eWpR?=
 =?utf-8?B?eWhOenhpa1BDbVdvUXBtYVdtY3JSWnF5R3EvOElFcXZIa0hEMnowSE1oZ2Zv?=
 =?utf-8?B?UFJIbTI4cmhndktjbktQc1pnT0RpZG9Wc2VRVVcwdDE5TmlQWGZRekk2c0oz?=
 =?utf-8?B?aXk0Sm9zRWhtTCtLRFdHb0ZrbVlnWXZJOWJwQVV3dnZreEdXNVZ6VXl3VDRY?=
 =?utf-8?B?RlBGQnljak15TStsMXQrNnJLRjZGNHptZlZ2Q01tVnEyelhTZmpHdGhEUjBS?=
 =?utf-8?B?QTRVQXdtaXN6NUxtSEtDVUdWcWthdW9lNWd5N0xkY1ZvWjV3eUE2SmR5MlE3?=
 =?utf-8?B?dmZzTi85N2ZVZHFPQ29BNUM1aEd3bElFWFZrQzlrRmVoT1R4Ri9iSUNkMVB0?=
 =?utf-8?B?d2hyNXMwbEl4RWZrY3czK01UQm9iUkQwb0xKR2pDZ3EwalE3cUs4YXF6VlNZ?=
 =?utf-8?B?aDNUN0RRc2ZTM1VGNGoxQk5DK0xkUlRGeVk3U1JvSlZVK3dlbzlEU1BmWnd3?=
 =?utf-8?B?Q1ZtOXFGQmV2aVJSMmprRGVBcHhBSlhlM1pmWHlFMVM3MHRtbmhqWkpLMFpR?=
 =?utf-8?B?VW9pbTB1VFVyMnYwS0Rva1A1b0lER0lyWHFlV0t0MWpoazVrTmN6YTR2T2pm?=
 =?utf-8?B?NjZ1VDBlbi91eXdFRm1nUUFFUTVQYlhuMlhjOXhFek5KM1Bsa29vZGdWVjBz?=
 =?utf-8?B?MStZMGNMdjlpQzgyWVpRMm44VERuVEdBS1l4VVlFU0JrNXg3WWw2TEVFL3hl?=
 =?utf-8?B?dUhYNUV0VmhTYkRkZXdYRUoyTWNJWmdrZllTU2VITlNFUG5mV0VGdkM3U0hq?=
 =?utf-8?B?SlFDbkErTUo2U0kxbXlyVW1qUDZQWlFKSm9sNHRrTVlSYVFpOTZwZXZSNjVh?=
 =?utf-8?B?SlRUYkNIa0M4K0NVM29MbXkvenA1aWVSZ3hwZHc5UGcxUyt5czNGdXVzcmVZ?=
 =?utf-8?B?NU9Wb3NMbGVZTnhDVW9PWlBHaDdGajBjNk1TZC9XeGNwSnNaS2RIYjJGZWly?=
 =?utf-8?B?N21IZExZUDc3ZHBNRUxWU2liL1lqYVJhRzViRENTbmhmTlQyb3JvbFdNRDZ0?=
 =?utf-8?B?bG55WGNPRWcveFdTZWYwQ3psdnlWdG9VS0NtNE1RMW5GODZrbmZFOFhKdER1?=
 =?utf-8?B?ckgzNmFoYVNmTVJxenI3VnlJVDJiMkpyU0MrUFBJWFNad0ttU1VnSlpudHdt?=
 =?utf-8?B?OVV4a04zVEVkUXJPNk5FU3JMK2hSdkdZbjJ0RFZUTnBrYmZEeCtUTkFNenZE?=
 =?utf-8?B?YWdwNkpaUzZjcmNoak4yemFlMjRscFlENVVrTVdIVzE4aXJhYktXMmlEVFhK?=
 =?utf-8?Q?cego=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0ea9c6-2599-435b-fefd-08dd04011946
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 16:34:52.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMnltDzWzuBjB8PVENdBPGt8i8zEqsBUIFDDwRE9ZCdpfKtfgh8l1NdPqwa1eAzo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795

On Wed, Nov 13, 2024 at 03:36:14PM +0100, Uros Bizjak wrote:
> On Wed, Nov 13, 2024 at 3:28 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Nov 13, 2024 at 03:14:09PM +0100, Uros Bizjak wrote:
> > > > > Even without atomicity guarantee, __READ_ONCE() still prevents the
> > > > > compiler from performing unwanted optimizations (please see the first
> > > > > comment in include/asm-generic/rwonce.h) and unwanted reordering of
> > > > > reads and writes when this function is inlined. This macro does cast
> > > > > the read to volatile, but IMO it is much more readable to use
> > > > > __READ_ONCE() than volatile qualifier.
> > > >
> > > > Yes it does, but please explain to me what "unwanted reordering" is
> > > > allowed here?
> > >
> > > It is a static function that will be inlined by the compiler
> > > somewhere, so "unwanted reordering" depends on where it will be
> > > inlined. *IF* it will be called from safe code, then this limitation
> > > for the compiler can be lifted.
> >
> > As long as the values are read within the spinlock the order does not
> > matter. READ_ONCE() is not required to contain reads within spinlocks.
> 
> Indeed. But then why complicate things with cmpxchg, when we have
> exclusive access to the shared memory? No other thread can access the
> data, protected by spinlock; it won't change between invocations of
> cmpxchg in the loop, and atomic access via cmpxchg is not needed.

This is writing to memory shared by HW and HW is doing a 256 bit
atomic load.

It is important that the CPU do a 128 bit atomic write.

cmpxchg is not required, but a 128 bit store is. cmpxchg128 is the
only primitive Linux offers.

Jason

