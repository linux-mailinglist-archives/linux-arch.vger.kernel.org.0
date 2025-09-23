Return-Path: <linux-arch+bounces-13733-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E778CB97396
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 20:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E143619C3D59
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 18:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5A43019B9;
	Tue, 23 Sep 2025 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f8yn9ZUQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592282FB081;
	Tue, 23 Sep 2025 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653053; cv=fail; b=PqmQZ6Ae93F8GRuny3cvNjxP2bM+0UDoKlw/M1Geoj7pchZszzRUfhh3XzYRMOzGpleg10p0kNRiPnT7bI0tBFz2I72K5JyNkSwykywLsDP9pxozKnE1OeCTn4Lck24fZ6K6X8MMkStjbLHC6927kPe0akH/hz6de+TkbaL5Pxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653053; c=relaxed/simple;
	bh=v42NJWLr3ASqTJO0vk6gqWFOjVdIZ2rOHy04w3d0C08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HNry0HrLLWxQJAdg3TL912/l78mgEh2O64SReuhqtgGd6NN9UBa0awCbrRKwoL/GC5Z1YwDLfTDJKHZ8kyNfIEk1hKLNqbHLYY73ilWVymOZ8QGL6AdE9O87+4AzkhVOqu2l1EVd/aEcx1nyV5LaKYC5FklSH+MZ5xkqldp5kIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f8yn9ZUQ; arc=fail smtp.client-ip=40.107.162.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr70iqNSFoTqkyc5CSf+7lu/XdKzUSQtEne9zAr/gJiG1nFaNvPPrw7N2tdiqIlhrH2CngZCyG4QGnBOV9AL/XgT8IxeFpZL3PEExWw35CvuSmo24sTy+E06Th6zuv1bY1qHe6ihyyYfFKoHOF8IJWXlZP6GWzRCo/Xnmi4KDLo5LweR6XWuU1uWdON3N6QybbJ75/VBOuymIlsm2GfrdhYf8HTdCrCX2Eq+V6P/Kg08dKFbihKbih2O0lYwaHejgpFkSfTM1EjOiNwodDMvHeMmnAZSo8xVuqJYot4P34JsD40QRPdD4k/Ezcm51FrEJiVNor7JJ1yYc2F2pc/qFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQuH6xgNKFl64dJ8ap/O8xRTPBKQvjsAjgHG/MRoRxM=;
 b=VDe6MMD9y8BPyrgqZQ/25xW1C3ORhZxfByfaxvPCw8BzAcwHiDiris2W8lipYZQtEV2R1/cqiwy9jTV+ux0bkeU1PauG8+RIH/X/et0kynY8s94TgdMN2OIwjn9O+yE3/DacGBS5z2pbzthus9hEfo8M8/xoPSyqHwrRtfu16HvBmr0ZurFvF2fbIuc4bDIMEIKD8R0kLZtEX+0uwrijquqvZK+AMWC/GSLU3NYi9deVhaouub4fY0/Ve6okskb392o0t76h5TKOf+HBU3NGRiuixocYdgrA3MpiBioOHYQsvIaWZRNoB/UTjwyPN0+BDs6skWfHjQ45ilr1u5q5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQuH6xgNKFl64dJ8ap/O8xRTPBKQvjsAjgHG/MRoRxM=;
 b=f8yn9ZUQJpAESILnSMcze1ykI+/nlPpiJqj4L7aZFDkBLz0L2E4Fg38u2NODLMIzyO9OMYGH8YZnVRqdjEdAI5kNw76l5AH3shOGFUlHTA4AjGWCckbAl3yy1dC1bTczDMfgIcOwXX8JSfB+/3l5hc4LSkarv3XIMy+IYX9GkdMToQNpunE9Rniotjx0YqNglqQrU3XQkaKQ9O714+IKtVFYGsg7+hYqQTCmIDoEQSzPHDcMkKMDiP/tuAPqDelysy4lv9FZhXISpheOPChm3H5f7v63RZ1Exk3ow0WY+qbarJe1UCjQP7n+E+oX1qeUI629AZa0ARplftD8ZsDNUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by GVXPR04MB10473.eurprd04.prod.outlook.com (2603:10a6:150:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 18:44:05 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 18:44:05 +0000
Date: Tue, 23 Sep 2025 14:43:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	pgaj@cadence.com, wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com, arnd@arndb.de,
	quic_msavaliy@quicinc.com, Shyam-sundar.S-k@amd.com,
	sakari.ailus@linux.intel.com, billy_tsai@aspeedtech.com,
	kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, jorge.marques@analog.com,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	manion05gk@gmail.com
Subject: Re: [PATCH V7 2/4] asm-generic/io.h: Add big-endian MMIO accessors
Message-ID: <aNLqa4poPkkvASbq@lizhi-Precision-Tower-5810>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-3-manikanta.guntupalli@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923154551.2112388-3-manikanta.guntupalli@amd.com>
X-ClientProxiedBy: PH8PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::9) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|GVXPR04MB10473:EE_
X-MS-Office365-Filtering-Correlation-Id: 96641ce8-35ce-4294-3f61-08ddfad12c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekRLMnhQRWI4T01hN2FXSTA5aHFHdHAyR1Y1M0MzT1BUTFh1RE11OVdUazdZ?=
 =?utf-8?B?NnRRZDlGWFc0Ui85OVg1NHpsT3A5UERYUTJiSDg3alB6U1NlbXgvN0R6Rjl0?=
 =?utf-8?B?U3JpcXVnUC9vWVhPeS9TVUdDaUliOVFUaHNtUFUxdm9Fb0J0K2dDYWR3a1dO?=
 =?utf-8?B?cm45eVhSRjZRaGNZbkV4VnBuRWlxWFZJUk5VaUZRWDJvUUdLNmJGUDROOEZC?=
 =?utf-8?B?WHpzSE9ibHVmRXdHYTZoeU96Y3AwanN6cHdQQTVyN3YxR0ZEMEMvVzhuL3VV?=
 =?utf-8?B?UG1RZHhxOHpka21LbjNxUW0rbmlVL2REMDVIRkVKcU83VTFXOUtoN2FSa3lG?=
 =?utf-8?B?ZnI3ajloTDlMbzFHQW4wUkV0Zy9YRkRWVXFBeXlSVUorQ24yMXgzbVlCemFY?=
 =?utf-8?B?cUVhY2Z3TVhTZC9hY2tqKy96V0xPRTZ3WWRuYnE0bGRPcnFIczhoUjRBdWdD?=
 =?utf-8?B?aFpMNUpCQ1ZmZFBqQ2VxZ1lxMURWakI0UWRBbTRvT3JwTzdqVFRySzBvaXZs?=
 =?utf-8?B?ZmtvVWE5VVhZMS8wcVNaWWdmbEtPNUp1TU15akFPYmt1dHcxLzJqcjU1Rk10?=
 =?utf-8?B?MHY4eHVGN0daZVNMSHlnNDZPa2pxM3dxaGJ4NkEvUlZiOE9UT3Fady9sOGc5?=
 =?utf-8?B?MmhZTDdEOUl5WFV3a1VhaUVmOUVsRGlRUnNOamROb3FVb3pNYkt2N0dGNGRG?=
 =?utf-8?B?RkM5amFoNnRyd0FWR2J5Q2N3ZUJpMm1WRzBJUDZjcmhBcHlabUpVdDRlZmk0?=
 =?utf-8?B?NFlFS3RNSjQ5dU9yQ2lYTmZkSDE0bmdGM213Wk9UanZlSWV4TDJZVHFOMjJo?=
 =?utf-8?B?QXZXMFB3SEs1ZnZVd2paSDcxbEkxemwreWZYTXExRjdMS2kzK0pVS1JEdnRw?=
 =?utf-8?B?eEVQejZJTjRXL0o1OVpKY3ppOXVqSDdQOHA4eE1MMjR2blhhVk1VZkx1R3k2?=
 =?utf-8?B?K1prVTdaQ2VKSFB4M0ZBR05HSnZxTjIxUGRjSWVnYVMvMTVFN2o0eHBQNUt4?=
 =?utf-8?B?L2lGMHRIRDN5bGVKUEYyc245aWFLOHNualJjYkgzZ2FLWmwzUi81MTAzQzhW?=
 =?utf-8?B?b0ZDKzZQYlBob3Vna0p1TTFLYUM5MWtOR2Jsc1dhNVFJTDR6a1VjVmE5YWNn?=
 =?utf-8?B?UjlaMTVmVWxRRlNXbVFDOFhpVmV0TWEvaWJJUzhMcHhDbTV4V0o0anVmYWc3?=
 =?utf-8?B?U0UxU0JBUmowRk5MSXhrY2NQMlVCblpseFljRVQrVWdyVW9qV014RnJLaDZP?=
 =?utf-8?B?V1FSWWRCV3B2KzhsVGUxcTh5STJGWlBsbG5nQWw4UjkzRmNOcHVtSlJCNW01?=
 =?utf-8?B?OElJN3V2UFo1SHhQOEtXcU1oQ0M2T0NDMXBxR0dncDFvYzhzSEdCNUVnc0NR?=
 =?utf-8?B?bXNFQ20vYmM3RTlXTnFHKzlZUHkxOUgwcXVUZHBmWVhWVlpQa3Bta3dCdWZj?=
 =?utf-8?B?T0hCajBiaXhvQjFtd0NUSWRubHp4ZFpicTBQbjJJdWJtQTNXK21OVHNETEJk?=
 =?utf-8?B?Q1hRL3ZlKzB5cWVpMVlJSlc3MHhseW1keGh5RllhTU9VRjhpTDBwSURmL3Rz?=
 =?utf-8?B?OVlacWp0MVViUFBQdG80VXJJSTZYcGlrUW5LRTBjNVlOUWN6RG9TdkVucUE3?=
 =?utf-8?B?VUQ2M0tiVEdZbUp0S2hBYWRHcTlnZVRza3lvaytqTWwzK1ArMjExbXlHd2M5?=
 =?utf-8?B?Yy9wMkJKMnlqcllBNTQ0Q2UrTGNtNUxOYWtTVUlBalFvYVBGTHg5aENhenlz?=
 =?utf-8?B?QXZhYUkzbDFNRFNzOTlCSFpvRFI4d2tNcUVSMTFvckJEc213c2hzbWZjWlBV?=
 =?utf-8?B?L1RIZmhCTThSU1RRbnNwWmR3TEVhaHFEWkhRcFl1MzVuNDUzWjRVaVpzY25q?=
 =?utf-8?B?aEZvMlA2LzlrRUF1WEVTQlFoQUxHS0ZUeWtmYUVSKzZTNjlpNEk4RUdYbkZh?=
 =?utf-8?B?R1h3K0tKUXRCNFJGVyt0RjlXTkpjaGVsWDhCZ0E5a0hucnVuYWxMdHdkdXIz?=
 =?utf-8?B?YTI2Y1F6WXF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFdlRlA5NDI4VUpTU2RGOHZnZlpUL1ozOCsxK01oTkkyRFJ3YU9VZDkzZG4r?=
 =?utf-8?B?MEF1ZUpuMVpsTVNDN0h2UFBmV1BSdjBnQzNRbnpHaHg0QlZIU0s0TkdMcENO?=
 =?utf-8?B?M0FWNURzMm9jMGRjWis3ZUtIcGZZRHdXZHY5VkY5UjJrNGJZdk5hejA0SXNp?=
 =?utf-8?B?VnBnNmYzTUVRTWRSTmhJRDBaWUx0S0NyOXZ1RkFBcllwc0hubDRXL3RlRjBn?=
 =?utf-8?B?VlhDTHBpcEtpQmZJcjhmOG04MkJwOXVXSDkva1JBWVNqUnJBaVhoeWc2S3FU?=
 =?utf-8?B?UG85R1V5SXphWGJjV2RuNGRQaGw1N1VhNmd2M2FHRjJIdEoydFpYc3N0VXUx?=
 =?utf-8?B?TGhPa3lXbGw5cEFPTGNjYzN2ejc3WUMvS0pwYXFKcDJsdGp4OXJZeU9yQ25H?=
 =?utf-8?B?MTJTWjN5M1pMbFR6S0VFbXFtWkJKMVo0TGdkS0ZJc096THhQWVVQV2llalQ0?=
 =?utf-8?B?MytLNjJtUDBvYVl1U0JQWnIzcDUyNllpdk1JRGJGTk5DUzh2eC9xY25KNXpU?=
 =?utf-8?B?Y0xjWHVhWEZKbGRBb2pHc0cwYjRsODB1blRESjdKV2RxN3ZjVDJrMWJ0dVNC?=
 =?utf-8?B?UGtDa203TEx5VkpBcTN6ZUgyTWZRTVhFRTlUdTJmcGRUajJkRFAxM21pZmsr?=
 =?utf-8?B?ai9sZ1ZsTWd3YUJnZEhZd0NMSDcraStibFlwMEdacFJzVHVnTWt3Y2RxQ3lj?=
 =?utf-8?B?TktEb1UyWXg2U3h2NEE1UWZocnkwNndSQWNJV05yM1A1c1I3YlE5VmxsRUlG?=
 =?utf-8?B?dHJibzVpWnc5WUtGdDdYdlFhZ243Y1Y3clI0eWNrL2Z5S3p2Slp4b2lZZjFD?=
 =?utf-8?B?NmVaZ25IUWtEaVFTb3lHZkQzdnQwSWpPMHhDbzZmWGoySTlFakpqRjE2bTJk?=
 =?utf-8?B?VVkvNzN4d01lbnpzWW9Nby81WjZzcllFRzBQQ1B1SHhSdVdpWDBLRDJOVFVk?=
 =?utf-8?B?VDhqWmkwUGVrVnhkVjFPZjM1WWxaMVEyV0NZYnVtdmhheVdmeFc1c2x3QVU1?=
 =?utf-8?B?V0ROMXRnMWZhcXpzODN6Y0ZQV2U4dDJkWGxxaDdLSTFmZE9CTUdUdHQxMGxk?=
 =?utf-8?B?bnUwVFFCME9nYnhuY092UzJtWFZWVTZ6L0hadVBPT2JlVjkxcXd0S2tneUF0?=
 =?utf-8?B?blZScmxVZ2RRTU5EaU5udWJsQzhyUjB6aGs4cUVPWmI5V2UrNThRRENIQmVx?=
 =?utf-8?B?YlloMytJdzh2RXdoRkc4WWJGUXByOUJuS0tqRGNWNGRUalpVMkJCUTIzV1ds?=
 =?utf-8?B?djhUbFFYc0drV1k0L0hzcFZMS0xoNjJhbTZoWjh4QzRRUnhzU1poY3pKWGlP?=
 =?utf-8?B?STdnS3g3Y1dpU0wyQ2J6V3ZZM3lqVEFYUzhLSmhhRDZiY3o0U0VScHlhc0ti?=
 =?utf-8?B?SVZ2a1BDbHBDK1RPZWVIZzBWYUI3ei9MMm5ZbDNNUlVmWmlrSFprQW1yVUdY?=
 =?utf-8?B?Sytxc0l5bjVpdk5ic0VUcldtVlN6WDZVOWtaLzlYVHVvRnJwL284TjY1VmFz?=
 =?utf-8?B?RzYrM0w3SENXVHcwN0NsMVZWTE16RjVCYVNUdUF0ZDJQUGx1U1NQeVV3L3BE?=
 =?utf-8?B?Z1RnRnh1UEYweGdFUXVYWXJtZHZwZ0VlelVkU1IyaDhvVlNGaHZCbzh5ZVpP?=
 =?utf-8?B?cG1zaXZ4SFJnM0lENG55OWVCMGhGdm9tL0thZUpkRjdsdnZIYkdmZW13c0N0?=
 =?utf-8?B?bGdsTE9OQklFcUw2YjlYT0FRV2pBZjBTdmY0ZjE4c1o3bVhZSmd1eURqNEQ3?=
 =?utf-8?B?cXNGWlh4YjdYYmdhb1lUV1EvMlVoWEgxWHRZTjBudFliY2J0ZGxwQUJWOUZ2?=
 =?utf-8?B?T0YwVmIyRG8yNG9xYmxmR1BBZTJ2c1dEMkhSY2RZRWhib3RIOWUvMnBySjFH?=
 =?utf-8?B?MThCdENsZmZFRDZlYkMvV2d5VmpIZEdOWkx3T0JMRUNQVUlJQWlRUTgxcFc3?=
 =?utf-8?B?ajIrS3RZMFd2VlRyekZ3ZnNmc21OYU9DMGwwL1BjNnFmVlNzSmVCdGQzSzBk?=
 =?utf-8?B?VDk0NE9GRExwMTFnOXRYNzlqZEYvQVVCQWdUMlE4ZHo1Y1FjbTVqVm5CNWQy?=
 =?utf-8?B?dG56U2NRcER2SldJbUhiS1dtMmJzc3plTVdkMm4xamxVbE1DbDF0MDZyd2dp?=
 =?utf-8?Q?Yd+M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96641ce8-35ce-4294-3f61-08ddfad12c27
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 18:44:05.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sa2s60U2WSTb5S6cpIYNRO9TTuk/ukVBGY9QqQ4itbJOeCkEoviEGa+J2xmamqNNgFX06Ct8XpdNgHc7LCZUSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10473

On Tue, Sep 23, 2025 at 09:15:49PM +0530, Manikanta Guntupalli wrote:
> Add MMIO accessors to support big-endian memory operations. These helpers
> include {read, write}{w, l, q}_be() and {read, write}s{w, l, q}_be(),
> which allows to access big-endian memory regions while returning
> the results in the CPU’s native endianness.
>
> This provides a consistent interface to interact with hardware using
> big-endian register layouts.
>
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since V7:
> This patch introduced in V7.
> ---
>  include/asm-generic/io.h | 202 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 202 insertions(+)
>
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 11abad6c87e1..d18a8ca6c06c 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -295,6 +295,96 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
>  #endif
>  #endif /* CONFIG_64BIT */
>
> +/*
> + * {read,write}{w,l,q}_be() access big endian memory and return result
> + * in native endianness.
> + */
> +
> +#ifndef readw_be
> +#define readw_be readw_be
> +static inline u16 readw_be(const volatile void __iomem *addr)
> +{
> +	u16 val;
> +
> +	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> +	__io_br();
> +	val = __be16_to_cpu((__be16 __force)__raw_readw(addr));
> +	__io_ar(val);
> +	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
> +	return val;
> +}
> +#endif
> +
> +#ifndef readl_be
> +#define readl_be readl_be
> +static inline u32 readl_be(const volatile void __iomem *addr)
> +{
> +	u32 val;
> +
> +	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> +	__io_br();
> +	val = __be32_to_cpu((__be32 __force)__raw_readl(addr));
> +	__io_ar(val);
> +	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
> +	return val;
> +}
> +#endif
> +
> +#ifdef CONFIG_64BIT
> +#ifndef readq_be
> +#define readq_be readq_be
> +static inline u64 readq_be(const volatile void __iomem *addr)
> +{
> +	u64 val;
> +
> +	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> +	__io_br();
> +	val = __be64_to_cpu((__be64 __force)__raw_readq(addr));
> +	__io_ar(val);
> +	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
> +	return val;
> +}
> +#endif
> +#endif /* CONFIG_64BIT */
> +
> +#ifndef writew_be
> +#define writew_be writew_be
> +static inline void writew_be(u16 value, volatile void __iomem *addr)
> +{
> +	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> +	__io_bw();
> +	__raw_writew((u16 __force)__cpu_to_be16(value), addr);
> +	__io_aw();
> +	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> +}
> +#endif
> +
> +#ifndef writel_be
> +#define writel_be writel_be
> +static inline void writel_be(u32 value, volatile void __iomem *addr)
> +{
> +	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> +	__io_bw();
> +	__raw_writel((u32 __force)__cpu_to_be32(value), addr);
> +	__io_aw();
> +	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> +}
> +#endif
> +
> +#ifdef CONFIG_64BIT
> +#ifndef writeq_be
> +#define writeq_be writeq_be
> +static inline void writeq_be(u64 value, volatile void __iomem *addr)
> +{
> +	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> +	__io_bw();
> +	__raw_writeq((u64 __force)__cpu_to_be64(value), addr);
> +	__io_aw();
> +	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> +}
> +#endif
> +#endif /* CONFIG_64BIT */
> +
>  /*
>   * {read,write}{b,w,l,q}_relaxed() are like the regular version, but
>   * are not guaranteed to provide ordering against spinlocks or memory
> @@ -524,6 +614,118 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
>  #endif
>  #endif /* CONFIG_64BIT */
>
> +/*
> + * {read,write}s{w,l,q}_be() repeatedly access the same memory address
> + * in big endianness in 16-, 32- or 64-bit chunks (@count times) and
> + * return result in native endianness.
> + */
> +
> +#ifndef readsw_be
> +#define readsw_be readsw_be
> +static inline void readsw_be(const volatile void __iomem *addr,
> +			     void *buffer,
> +			     unsigned int count)
> +{
> +	if (count) {
> +		u16 *buf = buffer;
> +
> +		do {
> +			u16 x = __be16_to_cpu((__be16 __force)__raw_readw(addr));
> +			*buf++ = x;
> +		} while (--count);
> +	}
> +}
> +#endif
> +
> +#ifndef readsl_be
> +#define readsl_be readsl_be
> +static inline void readsl_be(const volatile void __iomem *addr,
> +			     void *buffer,
> +			     unsigned int count)
> +{
> +	if (count) {
> +		u32 *buf = buffer;
> +
> +		do {
> +			u32 x = __be32_to_cpu((__be32 __force)__raw_readl(addr));
> +			*buf++ = x;
> +		} while (--count);
> +	}
> +}
> +#endif
> +
> +#ifdef CONFIG_64BIT
> +#ifndef readsq_be
> +#define readsq_be readsq_be
> +static inline void readsq_be(const volatile void __iomem *addr,
> +			     void *buffer,
> +			     unsigned int count)
> +{
> +	if (count) {
> +		u64 *buf = buffer;
> +
> +		do {
> +			u64 x = __be64_to_cpu((__be64 __force)__raw_readq(addr));
> +			*buf++ = x;
> +		} while (--count);
> +	}
> +}
> +#endif
> +#endif /* CONFIG_64BIT */
> +
> +#ifndef writesw_be
> +#define writesw_be writesw_be
> +static inline void writesw_be(volatile void __iomem *addr,
> +			      const void *buffer,
> +			      unsigned int count)
> +{
> +	if (count) {
> +		const u16 *buf = buffer;
> +
> +		do {
> +			__raw_writew((u16 __force)__cpu_to_be16(*buf), addr);
> +			buf++;
> +		} while (--count);
> +	}
> +}
> +#endif
> +
> +#ifndef writesl_be
> +#define writesl_be writesl_be
> +static inline void writesl_be(volatile void __iomem *addr,
> +			      const void *buffer,
> +			      unsigned int count)
> +{
> +	if (count) {
> +		const u32 *buf = buffer;
> +
> +		do {
> +			__raw_writel((u32 __force)__cpu_to_be32(*buf), addr);
> +			buf++;
> +		} while (--count);
> +	}
> +}
> +#endif
> +
> +#ifdef CONFIG_64BIT
> +#ifndef writesq_be
> +#define writesq_be writesq_be
> +static inline void writesq_be(volatile void __iomem *addr,
> +			      const void *buffer,
> +			      unsigned int count)
> +{
> +	if (count) {
> +		const u64 *buf = buffer;
> +
> +		do {
> +			__raw_writeq((u64 __force)__cpu_to_be64(*buf), addr);
> +			buf++;
> +		} while (--count);
> +	}
> +}
> +#endif
> +#endif /* CONFIG_64BIT */
> +
>  #ifndef PCI_IOBASE
>  #define PCI_IOBASE ((void __iomem *)0)
>  #endif
> --
> 2.34.1
>

