Return-Path: <linux-arch+bounces-9066-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3CD9C72E1
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 15:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB87282E69
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB78C433CE;
	Wed, 13 Nov 2024 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZS1ud5fa"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55653B676;
	Wed, 13 Nov 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506960; cv=fail; b=dpVnPMzFvil/jJ+nbw/dpmfvFcnHF8rXVBbBHK5TrbZUl/2u3lva5hHq4ZEE3jTy+xwYBjecEZoZHa248KSoe1+b0b9G5q5gVbP4BKD4/Kq/H9e90JxQcwv5GQnUQ3vCO0GfOBYUGcrJnMXGDT9cCcj+kZTmCGW+IMZU5S/bwoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506960; c=relaxed/simple;
	bh=ibuxtkTEivjqOOB7bi8t7yjxRDdq/M7u1KxbKHKg5yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f9r80hnu+ehtd9lZShwql0RHxNIX+JbG/ozTgAI21nL0ZxBM0yX7WIq02c5I/JJdVryrzd8FR9sa2iFRUk3dcuwLSlU8ikTlG25DnKlvZjAVBJwRagQ2WwqMt1/NJKM3smH5O909n+VPJFnOVcNvUVGKkVHjFD5h31PGaetJKIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZS1ud5fa; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtfwbbadvjyHBosETLuuXHKCjj3uENClK6+k/+dPKkEvRx0cA6OG+TH5l5AfNiRqbPDheP35IPkWySJXQAwxd/wsifDPe0St4QxZBczGwAtnwBqcEVfCibn7n6Hrobqrc5HAa+vRx5UAobsMJXS5gs12ZadsheDppWV7JLJxGwKBo12mP5p2ooZfqGAB3raCGWj7St6W5IxaNsv1eg+oJ/I1kIvkocvU4mIrWhh9RWer28i3aHJSO315TYKFhRuGDMaX8xquJULFjF6SttDFjWymT3ZQcQ96b1qs7UCXLJssWvEgaGEzrRFP3o4IqMXA9mQE48nTbOsjB71TONEN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP5uDBxWVKJMjrpAb331o1UipftLxCfh+hQTD7kvl3o=;
 b=gelP835i/jfqWl7V0D8/TR0EnxfFE7p3pG0+4Br2VJfSTWmCivUT/mMTpsVeow2QDNQGcNQfpxgcXv1vw2TjMQPsftQVN3PdFQ+lX7+iMhXO9FiV0h7HqrI2pYf0dAAoXn4DeYJbSgvbOQkgT8aWTZ5FdQHLR96T/HNPOvaa6E2vMOpAC2JulVqJsgMlEUSf0bdV3xSEDcM6nj5Sgfj6Plp+P5ksjYm266nRfCFA9qjywwKMI2yq7flUzAf4baQOxkgtz5iSM7CfHJgVxWUslRFq3OG9RzzaXsVS1Jq6Fg1NR+eqsnqHCtdzeaK1HLC3ca0lKX6aaonTIg9uhWd11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP5uDBxWVKJMjrpAb331o1UipftLxCfh+hQTD7kvl3o=;
 b=ZS1ud5faVzcFZC0YI8BhJb6kxj1E4irbD266CENYqhpVEjjK0FR8azIyLWmBNepgieHdBt3oyAHU5SjUZ0t01ViCSsgBAhc5PSmlLsYiHxT0lIVEqUt56PsvppRuzvHuR10XfeBl9UzYtL+cYbqUb/csZE0r9j4+ZnzQPRgdnF8qka+HeZGEsLyFSFCKykosRB4nRoRiKwMM0hyQmSGskZ5rNjuncJYP0C0PFgEpblra0uckKKNIa/H0OW2tuH2uRIRXCRILRHkBsZeDJBdXLT6wS9K1s3B0WO6B10bogRh/IRlIsxkxk44HbdKtS8nlR8+SXtOXlUHxZsJSCowKEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 14:09:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:09:15 +0000
Date: Wed, 13 Nov 2024 10:09:14 -0400
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
Message-ID: <20241113140914.GI35230@nvidia.com>
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
 <20241113120327.5239-6-suravee.suthikulpanit@amd.com>
 <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
 <20241113132031.GF35230@nvidia.com>
 <CAFULd4a1PHREX6ws9Gyu=TaaZvdgLfh6peoE5Tt010uGyY9Hgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4a1PHREX6ws9Gyu=TaaZvdgLfh6peoE5Tt010uGyY9Hgw@mail.gmail.com>
X-ClientProxiedBy: MN2PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:208:239::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 4160eb96-35e4-40b4-574e-08dd03ecc1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnJrOFJBK01KZCtGMktqVyt0aTN3UEUydUFEeHBOU0hZWW1RTTZMalVINGJk?=
 =?utf-8?B?MGNXTTRWSlk1K1J6bENtNHZDZGl4SUdIRXArMWNsNHN3UC83MGowS2hSSnJK?=
 =?utf-8?B?RkxlalpHdVJyMXZ2c0kxNEJTc2dLM3ROQWM4YWFub212Zlc3c0NMU1F5RmNH?=
 =?utf-8?B?aytkdmxjMVQwemZ4SU1VdGwyZHR2bUNhU1A4SlBwdU4wNUgrdjFsemRmN0t4?=
 =?utf-8?B?M0ZLSUl4cCsrMjBoUS9MM25JQUMzR1pyQ3NsZXlTTXRGNVk5TUVDd0RPZzdw?=
 =?utf-8?B?NW0yNEloelNGd3A3cldsb3B3UDAzaUxvUEthbFgxb3hreUpRaFdORmRjS0pw?=
 =?utf-8?B?ZVJTUUxmeElwRllsbnFKd1cvVVl1WDdHb0ttWmVYTWJ6UzFQMytqZy81WTZ3?=
 =?utf-8?B?Y0xEMVcyUURicUhUUUIzN3MwSEtKdkJSUDNUbjVwQXQwSmFWODRCSG5XZU56?=
 =?utf-8?B?d0VibDdycWdDQmdNWGYyWCtMdVZ2SUw0QVNOcVBZMEhsaDFESkRMb2FiNTlW?=
 =?utf-8?B?encxQXNNZ21vYkhXczZZN2lhYm1BM0Jsak82MUtEL0pSWjhINXBqRWVmMjB1?=
 =?utf-8?B?a0JOL05kQmpSeWJrN1RXOUZXdFRrTGE4RTNia3gvUkI4UUV4Q2N3QkRRcEpE?=
 =?utf-8?B?RlJxN2dlM3hJYUFHRWJQbU5QbkFZRmZEeGhZTndKaTBGNjVlbWMvOTZlVTRq?=
 =?utf-8?B?WUt5bERabXJVWWhlcloyYmVhd0JIU1lPNzlMVnBvNGJyVDlpTm5pWXk0UmE2?=
 =?utf-8?B?TVNaMFdxNUVxdUlTUUhIM0dXU3pvWmJnQ200bE43NzVXZlhBREd0c2pCOUVV?=
 =?utf-8?B?dWdISzJ5VS84M3dVcWpZYmQxdmt4VUFoUmNDbXlPVjRkZWk1ZnRtSE82RXc2?=
 =?utf-8?B?TkhSSlBpTVFVN1RtRUVpalk2cStBM0FVaHhzaGNSdEhjdUtDTnF5TWRGcUZC?=
 =?utf-8?B?NmpYRGJMMDhBdFFXQzZMTjRwbzJDakFFMEhYdGF3b1k0YXh5QWNHMDhpNnAv?=
 =?utf-8?B?SkhVWUVrRU1CdWZReVBUVEZrMjFkQmw2em5Jcnp1MWUzSW40SmRudDIrUkJY?=
 =?utf-8?B?VUpha1pQa0ZTMEZ1MjQ4Ny9GdXdYTDFEbEJDaEh2bTJjbi9YK3VhNkJhNjA5?=
 =?utf-8?B?MjdMMG9QVFdEQVJlVHhiUC82MjFFQTM2OFNnTkY0dWpvOWFMM1JZMnNoN1hm?=
 =?utf-8?B?Z2VERlpwS3ZsbC9NbGk1c0ZsSzFsOEYwSWltenJOOUExV0NoNUFIRWZzRHB5?=
 =?utf-8?B?dnRPd3dlSkMrVStwb2tVcFVsSGlNNmc0VXErempaUEJhOE55NlpKcG9ZM3kx?=
 =?utf-8?B?Zm9US3VkY0dvc20xL0s2cnVRN1RvSkJDa2g4TTdYS2hTb2s2aDRmVDlYL2pr?=
 =?utf-8?B?WWlhUytxMkFzNERNMnViaHVWWlBwRVNISER2RytyNlJ1NW9Od2FZbDgyK3BS?=
 =?utf-8?B?aXN1R21iOUVWMFd5VUVGSUh1SVM5aDhwNURhRjBocVhBZ05Yd2pqU2hxYnpQ?=
 =?utf-8?B?MjhpTUROVm4zQkZwSldQeWxIczlWallWVEt0TXdEUXBKNkN5ZzQzTS9WMzNJ?=
 =?utf-8?B?STJ3Y1h1Z0lvQks2YnlvdlBWT3FhRVlnTmcyd01TSjBDeUlrRGhpQU9reDBo?=
 =?utf-8?B?eEl4RmpHOGRzQ09yTzh4c3FPa2cxWDd1VnJ0Q1o0cXhsS1dqVmM5K0dLTGhU?=
 =?utf-8?B?UmFOVXR1Q1RBV2xscGlEU0VtcUp2bVM1TkdOOGo0TzFWaHBsVHhLYnNiRk11?=
 =?utf-8?Q?irpoJdw54JxBkAHPhBL5CklUB9P3OrJZbCAr90l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QktTaW1JNVFzY25sbEJ4bmNzMDB4OVRhK29tcUo0VzI2MEtqQkI2UmZ0bExz?=
 =?utf-8?B?RlkxaEJPcHlhczk3OHh5WG90QUc5M09Va2plOGZoNnB2RmNoZFlUckd4QVR1?=
 =?utf-8?B?aGNEdUEyRU5vR0VmakdabTBGckVLVkFwSjV4d3VxUTFLS25sTWM3STZxbURN?=
 =?utf-8?B?ZlZ0Y0hnK0t6UjNGRHoyQzY0dmZkWGxpNXJ1MjZ3YUJUWnBjQTNycGFSUG9t?=
 =?utf-8?B?Vis1WU1XSDJxL1VVSy8vQzZEUExkaVE2c2FkcTlVYkpEVlROZXhGMU5pMGVz?=
 =?utf-8?B?MGNsNXBrMm05V0hVSUE1aEN6ZXR3RzA1NlJIaVNYMmwzUFJDR3NrRHFuanJZ?=
 =?utf-8?B?aGxDNjNoRExSejdFMTdFQ21nSnBpMnV6L3F0b0ZaT3dXYTJCTGthejRqOWps?=
 =?utf-8?B?Y2g2bXVuS295U3ZWT1dJbGJoeU1NWjlTMTZrYUlGVFZmd20xTnZYNjJQYXZM?=
 =?utf-8?B?aGdPSFM1elZlYjRvLzZ4SkNXbjgwZTVCMlF6VTBIZEJCaE5QTnpScHBjeEpS?=
 =?utf-8?B?Y1ZURitIbzNRU2ovY1lybVJjcThDUXRWZkZ3RGErejI4dkcxYmZTZFVWaWF3?=
 =?utf-8?B?ZjVNSmw2ZlFhZTlpUS9MQkZFdy9jeW5rcElhNlBOQ01QL3ZuSmp6dVRFQ25t?=
 =?utf-8?B?S3ErQURYTlovb1hEbWRWQmppZk1Ib1Nad1FrdGl2SWtWekw2UFkzV0ZEQkQ0?=
 =?utf-8?B?L1N0NEM5YnBUMEVpRUpLWW9RdHFrVVQxR01GcU13dENVcm5xUDZ5VGgwZ3o0?=
 =?utf-8?B?K3V5dFpzWm1Vam1qckdFenU4TVJhM01NS3M2NDBRVXRUWmQvbEM5OXZYemhF?=
 =?utf-8?B?M3U3T2IySzRqOVI5b1pYQTZGU08yTURuR2lTWmZNTlZIUFpyVVlqU1RqdzVC?=
 =?utf-8?B?Z201TFE3WXd5ZittcGorMUNDQjZjWG1FWFowK1FQZVcvZGhySkhYSkJPN0RO?=
 =?utf-8?B?Z1dYSlMvS1JSMzRhRUl5Z1RQUXcwZDZoWklna080eVBGWHhUZEtNd0RXTDlK?=
 =?utf-8?B?akJMMXE1ekoxNlBtVFluTEJ6R1NlSWhtVXUweGw1R3RaeHFNRU11YXRsYjgr?=
 =?utf-8?B?a1FYTlBrQTArbkRMZS9naXNZR0lNMEpjOWhabGJ2SzVQUk5FV3d3UUd6ZStz?=
 =?utf-8?B?REl2T1Jxd3labDZMYnFFc3FsalEwWmlVelRaam5kaFVGVmNHR3lhNHBDcHZK?=
 =?utf-8?B?MnlPeDVjN1B3MDFkMm9FY0c3LzNaR09kT3lrMC92eFFIUXpMakhtMXpjZEx4?=
 =?utf-8?B?TGc0QTd2d2poVzZ4UFFBVG5FL3duK09BUUVBbm1XQ1VIdVJqaldkd3NEenJs?=
 =?utf-8?B?bFc3d1RiZktqUjQyd044RkRPU1lDM3hDNnlYT1hOMkgxUDFucFhNMHYwL25P?=
 =?utf-8?B?M0ljOStFa0dERmpJNHpqenBUb3IxTFZDL1ZNSDlWeWlnZ0ZrRVU1V2JGV05n?=
 =?utf-8?B?TXdjQUM4ZkFsVjgwR2M0Z2J2M0hNYzZ3NHNSYXVjUzI0Wkl0d0gvYXNpYXYx?=
 =?utf-8?B?dG81SmpTNDlCN2s3RHM5dnBHRk5aSjU1ZkZrVklKNVdhZ2tvK0o5VENjbXpY?=
 =?utf-8?B?TUpxYkdOYm94ZFViL09aMnpIckhpcVcxcEkxc2dld3U2K3dFaE9TVlhoVnNi?=
 =?utf-8?B?QkE3SFdwYUFLM0twZFp1VG11c1RlYXlQaFBTejREbytHWndUQlVGdkZ4WHpN?=
 =?utf-8?B?d1RTMS8wenNabmdjR2IrcTZ1WE44UnNWTGFyaXBSRlllMmFGNVdZcnlVSHdJ?=
 =?utf-8?B?OWd2ZFltRUxLVzRJQkJ4RE5aNGsrUm90cXRkajJVRHV4b2VlNitkMXdJZE5W?=
 =?utf-8?B?amxFaVpVaDNERFNuazJVVlFBZTg1aDgra05mcHhHbDFCTXorK2RXc0JkNXhp?=
 =?utf-8?B?K1dTTk1MQlVLWGZZVkpmdzVMN09zNDBnaVpkOUM5SGpXak9LMEgwTW43U3hr?=
 =?utf-8?B?TXZpNHdDYmpkVXhFWldDTDRXSjIxNytxT1lWa25GN3pSMFZhRzd4b3ZrNkpS?=
 =?utf-8?B?eUxNazVmLy9MWnp2RGZMUVhjRzA4SDkrRm9kbi9GUUo2a2hTTnF5eENXVlF2?=
 =?utf-8?B?Qm0zOG9HQTIyMXdBU2lpbjJsZDRzU2lGYUt5dytINTVqaDc5VW1LMHpqM3M3?=
 =?utf-8?Q?InY0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4160eb96-35e4-40b4-574e-08dd03ecc1a7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:09:15.4080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLKwCq6wAT6rG8zQPN4uVXMk0Zzt+zSxn4GUO2EW2bC47Xh25bwDEPjHCtEY6RxS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884

On Wed, Nov 13, 2024 at 03:06:05PM +0100, Uros Bizjak wrote:
> On Wed, Nov 13, 2024 at 2:20 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Nov 13, 2024 at 01:50:14PM +0100, Arnd Bergmann wrote:
> > > On Wed, Nov 13, 2024, at 13:03, Suravee Suthikulpanit wrote:
> > > >
> > > > +static void write_dte_upper128(struct dev_table_entry *ptr, struct
> > > > dev_table_entry *new)
> > > > +{
> > > > +   struct dev_table_entry old = {};
> > > > +
> > > > +   old.data128[1] = __READ_ONCE(ptr->data128[1]);
> > >
> > > The __READ_ONCE() in place of READ_ONCE() does make this a
> > > lot simpler. After seeing how it is used though, I wonder if
> > > this should just be an open-coded volatile pointer access
> > > to avoid complicating __unqual_scalar_typeof() further.
> >
> > I've been skeptical we even need the READ_ONCE. This is all under a
> > lock, what is READ_ONCE even protecting against? It is safe to double
> > read.
> 
> Even without atomicity guarantee, __READ_ONCE() still prevents the
> compiler from performing unwanted optimizations (please see the first
> comment in include/asm-generic/rwonce.h) and unwanted reordering of
> reads and writes when this function is inlined. This macro does cast
> the read to volatile, but IMO it is much more readable to use
> __READ_ONCE() than volatile qualifier.

Yes it does, but please explain to me what "unwanted reordering" is
allowed here?

Again, this is all under a lock so ptr->data128 is fully stable and
not changing.

Jason

