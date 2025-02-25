Return-Path: <linux-arch+bounces-10348-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCB2A4326D
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 02:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500913AE795
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 01:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BB017C98;
	Tue, 25 Feb 2025 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H6vRH+5c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="en5+zkxB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCAD2033A;
	Tue, 25 Feb 2025 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446717; cv=fail; b=hh42xbbtcMnyfxi/ZBnnke7hB4yD9XsL1GFongHk/RQNQmlw70CD10fSHkw6v9vkoIH5HIS/aaHEWVCBB0XwnKtkLjJRxyiBXABIGfQJGz9zLlwHScRw6sq5iEDpnfC7j2aACSIfAGtBovMd8tzO2/2J23WBsuTiQBHDmvRRft4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446717; c=relaxed/simple;
	bh=5XIxPoZjbz5rLfw2LJjN2IPmQTrvXUHv6EIkRQe4aoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=UWmFhH7eVEieiwkuThtN4Y7Cre4EzozO+KbHhEzlsdDEV0wbNWS0kxIvMEhbcIR+VvxGwWmK8y6J6dVKVjGFuTr0AZzL50+dVeZEVfQadIxRGuVz0598n5IN+x2D0LyrA9FBDrrnVIt7v/gkJtSdg4jrAKDUN0I7FLGYrbjNM9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H6vRH+5c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=en5+zkxB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BcK3016831;
	Tue, 25 Feb 2025 01:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5XIxPoZjbz5rLfw2LJjN2IPmQTrvXUHv6EIkRQe4aoE=; b=
	H6vRH+5c96dE+u0U1CH/fWaNQqE3qHtBoL9Jc4bAOzhOSmrQVtyfDtC7sL8YHt8l
	2yMnGNBXLI+MIWFOfNbCnCL2lL3MD0cDzdZs6i2A2E/+fHKN5OOKzDZ1Q4I9P4bW
	an1UUn+e94RyoQ1t2omWOStqY2lR+2QeMvWjN/vm9n22oEOVjuWYCfBD+6fp3EkC
	nQxyoEsPytJRBT1ZXC21PMn+EFAfacgxFepOWjhhO7kYZtK8sdX1oQHE+VFdSZRo
	j8MDSJgrafayFDPAhatwX1VeSs2SC/rCGkY+PI3U+R3WGqGJpIexNtgyglRLdOCy
	cpZWgrm/5qTQxpGoT+FJpg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y66sbxas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 01:24:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51ONi5Z7010264;
	Tue, 25 Feb 2025 01:24:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5188qfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 01:24:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRmnrTS87G+wqObuBpJJgZ099Wz9e4vO5JQNLwVPe2imQ+nsxTulLI6dv2lb5hU0v2bHN4rCSp9Z8P6IbKGK1X9hnnJaMZ8TyXl3rRbHSEzBKGuyw9/U2B67ePxZJ8N3ObPtlDiQOsz7qn0RvQJpT2t05J3dEDq1dfw9+/+4CIuZ/yQkH6p4evYzVeehCX1qpktXJtjZDJ2YYrhPGUk1quCH25ie9lI35951PfsVSJaXW1s4VLaeqr3EVoH7KQYyFGMtFjna0VJcBtcDcYmEksjcY1hLxRc0Lv3fqktuzTHkkluwcuLms65YpIgCpeNqzMxQg1C5exexPoKjMBkKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XIxPoZjbz5rLfw2LJjN2IPmQTrvXUHv6EIkRQe4aoE=;
 b=piro1dfbNyXD0jJJRVBeVykgseSKjAOkejAaBF2m9TTAkam8tsTAb8ayo2YfJT9ViQ+Nokf1r0E9C0v865L3qgUEis53n4M0aAcE6JvLJCkQxJiUe4sptkENbTzJP4Dlpn0dueD2zjE0PhRUd7e0pY7KoykOmT1RPGGSl0UsXTCnj1NgHwMxoiH0Wqq3IXZAr9W+rx07Ac7AnG5iV+8RmCIWyFySSOnaa0SCqJpvvcJTJpVICn6aLLAx5O/ELnFxe5ebMT/vyA+fA8/zNOLna7uTMSueLI93EDXJvHNL7fuMzwcrs8+I3hayt+4JRjE3h08sO2Hyl0eohJdPwIiXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XIxPoZjbz5rLfw2LJjN2IPmQTrvXUHv6EIkRQe4aoE=;
 b=en5+zkxBQm1exuJs7z04mNEl5R+d4AgOxpZ2GsLgqZZoZV/OgjcU7YXuHccJnSrWfmDn7I1TbcUHGaYBikks/1cb0UjCxlLos1bdRAkTT3kHexkJRFfbTXqVgxX8/GbiKAdiWBpZg2cmFnQHPVq1vC6uqXUeIdVXX6amAeKslsA=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Tue, 25 Feb 2025 01:24:41 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 01:24:41 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Masahiro Yamada
 <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrii Nakryiko <andrii@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Kees Cook <kees@kernel.org>,
        KP Singh
 <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Sami
 Tolvanen <samitolvanen@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>, linux-arch@vger.kernel.org,
        Stanislav Fomichev <sdf@fomichev.me>,
        Kent
 Overstreet <kent.overstreet@linux.dev>,
        Pasha Tatashin
 <pasha.tatashin@soleen.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend
 <john.fastabend@gmail.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel
 <ardb@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Hao Luo
 <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kbuild@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Nathan Chancellor <nathan@kernel.org>, linux-debuggers@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] kallsyms: output rodata to ".kallsyms_rodata"
In-Reply-To: <CAEf4Bzb9rYHTVkuxxSuoW=0P84M7UPkBr-4991KiMnFsv10hjA@mail.gmail.com>
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
 <20250207012045.2129841-2-stephen.s.brennan@oracle.com>
 <CAK7LNAQokoST0FnByeWywaghTMP2aG7hQaV1T=TcQ=1v4ZLQrg@mail.gmail.com>
 <CAEf4Bzb9rYHTVkuxxSuoW=0P84M7UPkBr-4991KiMnFsv10hjA@mail.gmail.com>
Date: Mon, 24 Feb 2025 17:24:40 -0800
Message-ID: <87eczm6ckn.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR01CA0064.prod.exchangelabs.com (2603:10b6:a03:94::41)
 To PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7b385f-9c57-47cf-0d71-08dd553b2da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlNCamszK244ak44aG5uMjRxRU1LeUJPd2NHclAzcVI2SEVHaHVYMVAvSmha?=
 =?utf-8?B?RTNwSzhxSTNveU1ac0UvYUV1K2Q1eDhzWmpUKzY2Vkk1WEhNQ2lkUFFBb1JV?=
 =?utf-8?B?T0JZMTlSMHplamlMSUpMTmJycVBHQ3VycFVPYkIrVWMzdDJxTnRwN2JOUUN5?=
 =?utf-8?B?S2hacndBOVpDM3M5M0tkeXAvTnpwZ2xyazdXaE9jam45bWZlWWx0ZzdXT3lZ?=
 =?utf-8?B?eUxLaW9MeXZsRUVGdlR5K09qNXRUY1JnYTNIQkRPWU1WVnRqNjk2aFNDcUhY?=
 =?utf-8?B?REhYN080eVVLdks5dGNzbzJEOFlFUDBabXc0NnFIWGZHOSswME5hbFhaVlhZ?=
 =?utf-8?B?RDFBRXFVeGhWRnNFWWpPTWtwd3JHUklNck9abTk2ckp4R3ExZ3lUb3FnRXR5?=
 =?utf-8?B?TENjQ1AzVTBlNVVKa2RjRFNuZVlXS3Z5Um5WeCtycDBnaW5nd3Vld2RRcVI2?=
 =?utf-8?B?c0ZYZEQzWHl6VUUvMHlIZzVPVE8wNVhxclpwdFFGRitxMFJyV1NKY3ZldXhN?=
 =?utf-8?B?ajBHczl3RXhmTDM1eWhXVjNWQVVkdWZGSGo3ZnhQODY3cFlsaHhiWmdCRHYz?=
 =?utf-8?B?RmNRZVZsNVFGamhJd3o3TzJSVHJvQnF1ZEdBNXFDOWh0NnVwcmxjbzNZaWYv?=
 =?utf-8?B?TUsxcHNraHZkdFFpNzdybU1Fbi9mRHNRTDNQWGRuRzVmTjhDdEloZnZnUjRp?=
 =?utf-8?B?cWJmQk01TVE4eUFWYUNyK2ovRm9MVzQ2eWpyOHdocU9YWGpQR0ZaRFYvazlC?=
 =?utf-8?B?UTBiM1hYb3U0cVVjTmlWa0U2RXNUY3dwR3BralZUR1RrRURVMTFwV0E2TU1j?=
 =?utf-8?B?OFcyWGNzWCtQcHlrMFdBK25jamlwU2NRcEUyQlRFaE8xZWhxQUt0RWk4eDNL?=
 =?utf-8?B?d1VQcDVKN010M0gxckIvTURnZ1U1Yll1NWExZXBZMkxxT01XN2lIM2orWncv?=
 =?utf-8?B?eVpIa1hLMmJIMXk2YmU3VVJOUjBOSHBEaDJrb3ZiR1Voa1hUc1VNZmkyQ0I5?=
 =?utf-8?B?aGFteXdOOU1tZVR3YzRlWHFQM0lXcVV4Y2JpemhhaDYzMmdJL1B3VEZQdlN0?=
 =?utf-8?B?S0J6cllXT1BJZ3ZIL1ZKWTFaTENBL1JrU3NuMEdxNzk5THJLcnJST0tUalRD?=
 =?utf-8?B?MzluTit1RExNUUtBUkJMT1JzUFpkYzNkUTduVTRUK2JTQ2FycUhZcHdoWEwr?=
 =?utf-8?B?ZmpLcUp0QXMvOE1WWXVtWUtkT0JGWjgwTkZvQURhcEM0VnhLVzJzMnpRbERp?=
 =?utf-8?B?RnFyekkvTlh6UTF6U0NwV2lUUkloN01vZUxyZG9WTThSUldvbGNva0lQNWx4?=
 =?utf-8?B?NXRqQkIvOXhqS1JITGk0MnJFVGM3MWZSYVNoQUxaL0NlOVNTaVpHSXFaUTNK?=
 =?utf-8?B?TVNMRWNzeW4rUzZwMWJDTTZIN2JMOGVFMHMraHZUQ3lGeTVrT2pUT2M3c0hy?=
 =?utf-8?B?ajQxYTA0TzZEV1Y5bmJNVDduYUkxQldQVkhaeFJ6TTZBMmZpblJQMjY1ZmZj?=
 =?utf-8?B?WThJZFpSU2RVQ0tIOUY4MnNTM1Y1bVZHdWpsd01sK21PaXdDdXhIdms4SGpB?=
 =?utf-8?B?ZDJkNkxrSDlOQnVIMHlrZE1Sd21HOUZqNzI5bGdOOTJZVlNOODVqa20xVUhG?=
 =?utf-8?B?TklkS2NrZzlUT1FpTUNRdUFLZERKQSttZy92SXpjMytTQXlkRHR6Nm1mS1B5?=
 =?utf-8?B?OWM5WE83MWRCbHU2SlBjMzNvOThrWWd3V1Z0aDlHTU4rcVlwSk1lSzlRR0E2?=
 =?utf-8?B?cTl0ejNyWWZXSmFmS01YaUhxczd6VjI4anQ2Zkczenk3aW0xZGRDcCt4WlV0?=
 =?utf-8?B?Rms5cHhNZWpiMUkrTVdmaG95blVxWGNvenMrL01qREtuTW1OeHd6cnV2OVIx?=
 =?utf-8?Q?BJg28iJjsGlpZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWFBbmpVbm1RU0kxVW1pM2xCT3g1clR4YmhRai80MFVIVWIyYkNCcytrdTJa?=
 =?utf-8?B?UUJEbVR3SEtpYzFROG1rWTJOSzdPcGxqdWd4WHMzOFd4Qm9iVS84TDJ6Qzlr?=
 =?utf-8?B?WGVPamlHV09NVGJaSkFhNk5kZy9wZ1o5Z3czUWFUQU1JMVhuYWQ5VUJwQ0M3?=
 =?utf-8?B?a3AxOW5jc0pRZmpVdkNGVWNWWXBxVGd3dzRBd241VHExbUVwN0pBY2lIdnR3?=
 =?utf-8?B?eTgyaGJPYi9EYWZoN0pBdCtST1hNRUx6alRMV2ZuM29Uc0pDUGcyZUNKUm40?=
 =?utf-8?B?T0F4OEFLUTdkUTQrRk9lSWFjMVJXb1hXRXdBNnFaSEI0NFdRcTVLa3JqZ2xR?=
 =?utf-8?B?ZmdXUW8vR2k0RHZiREtsTWhQNVYyZzVLWml5SGR0QUgwU1lEbG96WmdzR2F4?=
 =?utf-8?B?TytSRFc1eVRvOG9GMEE5ZWRYYmhhVy9LbnZoVTBDalBxMklySjUzU3k1eWZM?=
 =?utf-8?B?NlVjcnhDUmxHbFpqbnZPcnpSYXBTT0wweHBSQlJHMFgxYm5heDY1QTZ2eDhN?=
 =?utf-8?B?WmNXWmN0RGFCWHFMQXphNjFPRWlDM2NvVUs2ZGNaL1NDejViTEl2UmIraXBk?=
 =?utf-8?B?VnI0eEZwdFNhYlE5YzVmU3pmQUJhTW16S1R5UDBjanFTMzczcGRBaG1DQ0ty?=
 =?utf-8?B?NTcvMlFicEI3WHFuWWwyTURBaXFzdThVd2NKTmtDOFdqREdEZk5yd1RCQlFs?=
 =?utf-8?B?RG00MlQvOUVTRnJNdklwOXJmUHU0UUMzZVBJMktMVVRSQnRTYm9FOEVoczNT?=
 =?utf-8?B?cGtscHhwanFQeFlSc05DMnNBKzRBeHR1U3JYdlJNQ1V4dmlTU1dWZXBHcjJn?=
 =?utf-8?B?UGVHOFBEUzlzaVYrY3JobHRTRHVoc0x4eS9WRk9hdG1VVGRmWE9LNjlTNW1M?=
 =?utf-8?B?Q0FMMGJMUFNXQU80UHRxaWNuWG9xaXNDNGtjNkF0WjBZMnhCUXRVYlhMRW1u?=
 =?utf-8?B?VXdDNVdxUlBZN041T0tsc1B0V0V3UW1ZWDJhVGFUUWNQR0tLUlA3OXhFcUlK?=
 =?utf-8?B?RVJsSU1xTWRjak9SOHRKV3NtcDBVUmlOcGRvTUlyaWxWbDRMWlY5bTZUSno0?=
 =?utf-8?B?bGMxelM5TVZ5S2g3dXRDU201UEp6RU8vbEVscnlRUHNYbmlVQWVRTWF6REZW?=
 =?utf-8?B?b3AwZE4zVVRueW1KeVhYS1lGcXZ0WEpzOGFwYnY4Mm5OQkFDMTJVWWlKTkJR?=
 =?utf-8?B?UmNZQnNBUDYvUDJkMngzWkwzM00vTm1XWm8ySTRLbHBsWHAyUFZHSGVtc0RF?=
 =?utf-8?B?cDdIMWh2ZEIvYy9VblNPYkZwc0VkYVdyNlJaZE8ra2pHWlZsNEowQnJEamZq?=
 =?utf-8?B?dkNqT05GT0J6MXBPb01tSlRsTXJhdFBJTHdiNGcxZkRDc3RpMWN3TWQyUUFl?=
 =?utf-8?B?MHBZSEVrRGh0UW9yVTBxWC9hZDhxdm4xbnVzS1hOais2aW1pUE1rUTczRi9S?=
 =?utf-8?B?WU9kWmZsSGNMVFJKMlRkaGNzVy9JWEQ4NzdHdTAyTGFNVm1KWm1UTm5vWFhZ?=
 =?utf-8?B?V1RlQmhOalA2cmhodlBuL1R0M1FQcW1jaUZWOE93OTk4a3BLanVsSzdOY1pH?=
 =?utf-8?B?NjhDTEJhQ2Z4RmU0aEZ1N2g1dFh0Q1hGNkhuOWJnbTc4QytsMFh4MW9TOTVV?=
 =?utf-8?B?bzdFV0xHekd2eWhyemd4UjRvd3hIQU1oTCtzelZBUHViZ1hVWGkrQ3NTbXRT?=
 =?utf-8?B?TE5JVHd4UEdjcnNGcjV6VTRvQ0JQdm9kakZEWDVTeGVkSUUvbTQ3VTBUL1RZ?=
 =?utf-8?B?ZHNsbklCbm9iMm56NFJXYTI1U0NJa2hGT25LVWNzZEdUMTFiakJaOFNuZEdE?=
 =?utf-8?B?VUhTVC9MNVBGcllsejlzcDBmOFY5amFpWmJZKzJrMlNwTG9OQkZoZGtPeHlB?=
 =?utf-8?B?eS9IQTMyMGY4OGZSSXJFQmF4a2E5UThhQTlvNjhyY3FSWjFzSlNKcC8wTnlw?=
 =?utf-8?B?VDNpSTdldDdma3FVSDdOTTlab3djOHp4UXVVMktNY2x0RENta1hsemd2T0g0?=
 =?utf-8?B?THQ2L3J6N0VYOEZiUjZpNTlGaU9RN25TKzlLMzZsUG5MSUJzYmZpQ2VyNzQ0?=
 =?utf-8?B?UFVwN3lQMnJyNDhJc3hIT01pNitiWGd2SlcxbENuWGpiYmNTa0U2ZUE0dFAz?=
 =?utf-8?B?c2E2dnNOOEFMVkpTaFJpT3VEWTJZMllZS1k2YnIwWkZiMGhHeFFKb3c1cmZF?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n8NGqzmU2OLpqQjdIlBEq4AepQOwVRECGKjIkiD4V8qxoyztWyPLFMur0G8nzLVNzDQp2Y2Ij5HwESX+uPPUWuKmYbsxkjpc9MsMVub0pB0mvOid3L9h198MQeIySCk5fhae8AOVIPLS8TMHPVuVicTfiSQGteM3A5INcGPiAM+9bATiYBM7ApFKXRFsKEiVqodjLS0OyKjovF+FY4HTRe9Qw7yPV5rpfLVl4qtKH012Lm5I8RADc4SZBZu0kVlWPMgtcneppzoFkZAxlGKWAyprIPwfP+/RkNFPZIynn1q0GCMnuz9FcwaLReJA9nJgS9HY0JTH/OE/JiKs4hK4nPDiIidPbFHncxsq3VI4nD2PjLawpXNxhzVYgduKNz6jc6ELb6TXFnzNBZU3tXmKFL7SiScO9PJh0q5Xvz4bmRPqdwPEs7WDSA4uo08H1kwJ/oZEhk5ujEaxAwmmuOtuU9kC5W33srjKU+V5cSJ9k4SJe74KRqfLgNlx1TvFPFGlXOaSwEdyQcNrTt0SZOTJ7q25ya1abC6t5WAauXLBhqzMVm9BNEM6zcyoFqIKbalQRzDHE1tSli/1DwXWi9/s4QGbitfbEuQzTrnbOV6ublc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7b385f-9c57-47cf-0d71-08dd553b2da5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 01:24:41.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwLsrc0qs/BJnblgq84RSJ51hzthBC+45pwDMtLFcc0+GwR346aZBnICzPo6BJ4B5rmFXjB8t1GtD2DIhjKOiKnewhEImYRG6pgKiVdJCkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_12,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250007
X-Proofpoint-GUID: 4mr99lddc6oYzuMjx0t4fzONzD2MD1DB
X-Proofpoint-ORIG-GUID: 4mr99lddc6oYzuMjx0t4fzONzD2MD1DB

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> On Sat, Feb 15, 2025 at 6:21=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
>>
>> On Fri, Feb 7, 2025 at 10:21=E2=80=AFAM Stephen Brennan
>> <stephen.s.brennan@oracle.com> wrote:
>> >
>> > When vmlinux is linked, the rodata from kallsyms is placed arbitrarily
>> > within the .rodata section. The linking process is repeated several
>> > times, since the kallsyms data size changes, which shifts symbols,
>> > requiring re-generating the data and re-linking.
>> >
>> > BTF is generated during the first link only. For variables, BTF includ=
es
>> > a BTF_K_DATASEC for each data section that may contain a variable, whi=
ch
>> > includes the variable's name, type, and offset within the data section=
.
>> > Because the size of kallsyms data changes during later links, the
>> > offsets of variables placed after it in .rodata will change. This mean=
s
>> > that BTF_K_DATASEC information for those variables becomes inaccurate.
>> >
>> > This is not currently a problem, because BTF currently only generates
>> > variable data for percpu variables. However, the next commit will add
>> > support for generating BTF for all global variables, including for the
>> > .rodata section.
>> >
>> > We could re-generate BTF each time vmlinux is linked, but this is quit=
e
>> > expensive, and should be avoided at all costs. Further as each chunk o=
f
>> > data (BTF and kallsyms) are re-generated, there's no guarantee that
>> > their sizes will converge anyway.
>> >
>> > Instead, we can take advantage of the fact that BTF only cares to stor=
e
>> > the offset of variables from the start of their section. Therefore, so
>> > long as the kallsyms data is stored last in the .rodata section, no
>> > offsets will be affected. Adjust kallsyms to output to .rodata.kallsym=
s,
>> > and update the linker script to include this at the end of .rodata.
>> >
>> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> > ---
>>
>> I am fine if this is helpful for BTF.
>
> This seems like a useful change all by itself even while the main
> feature of this patch set is still being developed and reviewed.
> Should we land just this .kallsyms_rodata change?

I would be happy to see it merged now.

I don't think it would help anything other than BTF, because most other
things (e.g. kallsyms) refer to symbols via an absolute address. Using
the section offset seems pretty uncommon.

But it still is a nice cleanup anyway.

Thanks,
Stephen

