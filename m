Return-Path: <linux-arch+bounces-13650-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E86B58DEA
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 07:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFD6320D0C
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 05:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5332D190C;
	Tue, 16 Sep 2025 05:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c8/icX4E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="arNzYMzy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114102D0616;
	Tue, 16 Sep 2025 05:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758000624; cv=fail; b=sxYtev9YQQccxlf/un18aciG4oq/NKnW8/fisT7HpokHCPMUXc+ECYzuTt5Yc361yAzbWwop3bHVDvqux3Y/oxD2aU2PiHoSn6aGoORZ/tcT0N7MK3m1q/yC56mXTQEY1SVGLU9aK5G+AGxHtX+7YkDYt3HXzKLj1dZneYp8ucY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758000624; c=relaxed/simple;
	bh=PGbQKRuF+cfvdrL9Dfxj0D9kWQqk+21T06HEgzEKqQw=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=VzovWvhJ61ji05URw1dj0TPnOQ0SILkEmAv39tjxUzBirBxdI6xqPWqO7YQXR3C2BybHKUqaypyQjQNcjyEFm+xQLISmlAUAxwRWSEtNdRx73P929sPqdk8g1Yvt7YlQPCaH9NDgmxqnN7rRkBaaAJ84GtkeLMwdz9jqZRiwB4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c8/icX4E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=arNzYMzy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G1g3VG029214;
	Tue, 16 Sep 2025 05:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xqzjCP6uHeWwylGQck
	Rl+wdhwClLG4e/xbvRbOEPad8=; b=c8/icX4EYpEbntU0QQRHDIKLXujAXFQ4WQ
	UTF+qpveknU4UIF6Wdfbq60L13ZE3Kqf673lOOrLUO0XtedA3ujQ2tBJKNMYDFa4
	M2hgMC1Duf2SN3Bc+5xfucDfiYjsVSZiU7Lbs5t+vxUnNiFqoydPaq0xIRIHqvFA
	T78rvRrnkX62/sO4mjwJAkjLCusJN6y4w1O2jg1qQoMLfdExPlJoDEgcqoihGjm7
	LCrR4UlbZbqiil2d/6SwN5AMtmC8JqENBDxbRILfIUHsF4dE9TIoInHxdWbREK7J
	wbBWM5F6ZVj/6LrP27oXeacZQ6g5iGBs0tN5vUJVCECHa8czjeWw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49507w3tt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 05:29:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58G4gI9s001635;
	Tue, 16 Sep 2025 05:29:39 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2c58r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 05:29:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njJ30wopqYmXYwIWC+ru/PQdFjGiW77iB0Iz5NSJQXHorRPVAFLsgDyolfXSSEPv5AbW2soRR3LZk/CpIeAHwMukuskdb9Vj/quzsBqCXWsq4j/tpiZ8TVEzsmIyPLiw0jcjdpLtIR6/yKEud4+BLRRs16VhrNA8LRYvFHLfgO2huBdRWAqLDEWES+nI5EgUdet9j3WPdkhbBDLe+nKX5L3yIXe+uRrNcRIM6qy0Bm+uL2uajmajUozRf5T7MTqvVUx5WmIABsMzcbn0eyL/UhP2D898Sip1+EbqOIhpm42IFXe5sutQ2N1nClLbTUMwWp4lTNLRBBiWGthAFLhXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqzjCP6uHeWwylGQckRl+wdhwClLG4e/xbvRbOEPad8=;
 b=wWytiDuT7TP0jTZ/Xy/xLE+n85/+DZ+Sa+H1jnxihLV7yX6NI0AUYctMdUR+SibbcdmQh+Omg/a3CZcx4qJfxWYGdVim+Z2HQrTzywdeIKFcfEqg1c2K+yqDpretnrMyTAu5zvreslnqyJZgasRoVKAM+QrQ3Si19SBchwhvt2ye66LCw1ccsSMKuT8/rJpWnUM7yQoTpkdQKMDCFfXWQnYpWUr9yloaaI71ZVPqQCjgFhosl39xWP0FBNeVMDoH+vq3/PzKg2Qvb+krNm0LWTPWMVxBLPjUsCLDcYZm0KXuG9FMfhNXBFUMngqWEP2hgeXRstB/693pS1jjwuogLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqzjCP6uHeWwylGQckRl+wdhwClLG4e/xbvRbOEPad8=;
 b=arNzYMzynvVreOd8qsjoUr2Vlqa4mG2Hqx+jLriVbjiVxB94rekaazoiOa1zfvZ95MBs9aqTMD5WiUqYKjCCmOQ+erp55Iasab876L1Puc1yxcD3rB7Tj/99QRAc7ucqz0LyJ6UjYKU5znXK8ihas0CVXucWLdyQydDlZTbyP5M=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6175.namprd10.prod.outlook.com (2603:10b6:8:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 05:29:36 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 05:29:36 +0000
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <aMLd2QOFrZnaKcWf@arm.com> <87tt18k5y7.fsf@oracle.com>
 <aMf0sjveqxZXulEi@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v5 0/5] barrier: Add smp_cond_load_*_timeout()
In-reply-to: <aMf0sjveqxZXulEi@arm.com>
Date: Mon, 15 Sep 2025 22:29:34 -0700
Message-ID: <87ikhjhsn5.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:303:8e::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a2d738-6de0-4077-aa44-08ddf4e205d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2TScHKx3JsULQePDTecRSKNeOgz8ZLjimFFwKjEYp8E1RBe+xCsjlKtMvHew?=
 =?us-ascii?Q?ltpsQohHfTS3oFbPhlMa+30Alz2/MvFmaJDpwCK4IupZfpkRQMasAl7yCW1P?=
 =?us-ascii?Q?tSvVzgYE9dGR0XIGlJaoOveFjy/n5UUmJMUOIPbtS6FVWGXYqKiQkybNWiCp?=
 =?us-ascii?Q?ZKuDRA5qbTQdoI/AkkVI6oK7yvIB2TX4vca4NB65WMUlpPg9GjR1pcl5gD3O?=
 =?us-ascii?Q?E0AHSqQgW9/7NVAVgaFuJ+h47PkXpqTCuFVy7c4NLolTc/ON4jQyl5w1w5j1?=
 =?us-ascii?Q?wAuUpQ09lWJ7ccNfpYLzA73DyVaf9uGKvpJSeY+CeqpPfxIqmFK6FSp6GaKz?=
 =?us-ascii?Q?gIemvSoDnYz+KCTq2jReo2G3p/GJwAfgd8WpCoQ/1QXer7K+U752+43ZOx9t?=
 =?us-ascii?Q?n62dlKa8HTcJYkc1pAf3XExCsSk5znoHItmq3EtmFR9CCJ7U78TeDAVdCj03?=
 =?us-ascii?Q?P+oYSI2pbs8yGB1arLhiOIlsx9vDKOFoUvPxnb6C8XvvItIiKRIwDm7+nD13?=
 =?us-ascii?Q?H973Cyj/5eWPglZMx/Ap/oGDCwIHTXBSwrUwa/3/qVcYP4UktmycgSXckX9H?=
 =?us-ascii?Q?ZyV3eIIjJKRQ61fDlT5+B8HxBEJkIE95EuX7ApFveUpwWM8LitJrZHnlwau5?=
 =?us-ascii?Q?x0j351C/iU7DPNcdd6oOhEMnbqmcjVsM0Viaucj2k2nl9/RVftxQvQWpLdBy?=
 =?us-ascii?Q?RuomYFMcdh0agnt5omZ8oVBksVsg5FxuUa1l8pfidNj5U/fQI2na+Z9aLu27?=
 =?us-ascii?Q?htD1xqs8Y0MNqoQU5OvKx1+5WUbx+k0oQjvcPxRYtUZzE+xNHBGv/r/j1eiA?=
 =?us-ascii?Q?gbHMQ7spCHto2NeTDeZxUDFaWHl+A6yOFm7fYTFHFPz9QM0Q0Mzi7LMYV1mF?=
 =?us-ascii?Q?sd5qnSpYTSi8ApzBEzvIMa66IMbVeLsCR9YDqbwgN1YkMOWmWqW8FcTVEuWU?=
 =?us-ascii?Q?pbN75vgSAehn0rwU0BXIGLvkMfpaX9FjtMkE2SdsDa1Lts8vUP2KplRWjyL/?=
 =?us-ascii?Q?6H+tVl//I3mlufHGzTBPmnCpzga/sYyH2g9he9GThbX/Lduc5T0JtvGGbtv7?=
 =?us-ascii?Q?Mpqz3GDf9K5r11Tum/+dKqE1SRWfUj+S660AYxgIOG+T6UFT7CheqSlFgOet?=
 =?us-ascii?Q?D+M6KE/Tf6jjSUE+07nj7XVC6A9ODDApR8j8gmqfwHSTckLK4DFh1G2oX0Lj?=
 =?us-ascii?Q?Zb74n/dZqLMvJP9g9FBbtK5KrZHGRLzWk99yncddnE/BXuFSNpmQuBacZqM/?=
 =?us-ascii?Q?uGzzWRXUzqmvJid40r7BjDo5ZRYg5p2BuirFuUO/T/j4NouzcL4kCa7M+eYl?=
 =?us-ascii?Q?TDhFGG1AhBlW5/vovYswgvx9gidSyICFcgZUXFL98H04Dtb+qMnyR7Bv5o5t?=
 =?us-ascii?Q?o5WwNr9hdPNB2zK5ukcy89IvT8BA1XtrKiMZf9tWTtApAq5HVk8S0QI82cnd?=
 =?us-ascii?Q?WsN6oA7xDDc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6xF8pf0NO+mVeNsH799k0U1cUjdj1iGvIS97zICY6RMCGfM0RgadGNiHuqD8?=
 =?us-ascii?Q?aW/9Iwi+9bG/VF0UhxMMwx5zWU+8H8ANVFdcTlU08t3Kj2WEwuwPrOyq0iYU?=
 =?us-ascii?Q?wRf9K1sVTWXuUb8Xu+rgyg3N0zi0IA37lRTDTDzoUO87z9DpHxi4w/kqip29?=
 =?us-ascii?Q?Wx9GuCTgW7uLIDYUdOYMpRZKzKrEPgllrDVSW7lfYXOpC4mOcwmz7wAbweOj?=
 =?us-ascii?Q?xR3VXc2V3Xy++KBGtDwSDUNsYmm10gss2CsEvAO8LBSMkXcjori6v2e2AmLj?=
 =?us-ascii?Q?DkPMpmaAkd6r/bwi/Rhff43WBspC/Y7sIRxVqwDnj+OIVKHj4xCzViqwh2OB?=
 =?us-ascii?Q?l4pBpb6AouxhGeED0S6uo6dwX0TfWO8UJjoOe9uhySwv3kfNbmaCO8loNOQU?=
 =?us-ascii?Q?Dd0+abyI6H13HoSZnNcQfx+3JCmr69X2yKBioDDni+tAHSFaJfxowUx8KR/I?=
 =?us-ascii?Q?qZ02yz2HYjysRezc8XPF3/VlfIpODDa9i7TfVDwG6ad+PPkqj56tLKaTTTWp?=
 =?us-ascii?Q?4DZWX9tjWEpv9SP4qkzlwYIDEcN7+dmqQZzXkImbR/SSf6xjKMJdJXc9W7wa?=
 =?us-ascii?Q?eAZBDq8PazFaaXeUZvpt5awW+HLid4Lrtxkna2UQ2WBUzz8R9weiwMgrs1eJ?=
 =?us-ascii?Q?URk56kvSUzqKlULkx24iEYHQwN+XJpOPrHGC9EvomNGR20O5UJzfD8EPE/qV?=
 =?us-ascii?Q?V8OaydVoNvH+sNsmN3wBFyivqb8PLUpEfQFYxCMFabNemuIBFPDEwwnHWXiq?=
 =?us-ascii?Q?VnfAlLHaqog2Fyx7E/X6awQls4tUG+V9/ZBdLWIBdSK/ztC4NPl6SW1kcJQc?=
 =?us-ascii?Q?oqZ4YRXgaOAw1inxnueV+ezEfsbCzT0Q/EMGJFPI6x8FtPdun0wssZT0KcLy?=
 =?us-ascii?Q?g4/BKAZ+ZuDl/Saou+7+7Cq5vGVhh+ZrFLEAbV77+UNG1rvvHCGkeToSKIAg?=
 =?us-ascii?Q?T+r/0UbURUA0tnONCy2UGx/QxqpROwRi2IRlJDtFsiDewAJ/wy0/2w50d4b3?=
 =?us-ascii?Q?X+jOfiqfsQLrs8yXAO5fWPK+lk7cwVtp3nqF6LylvWL2QQvW/pXyZWgD4KsM?=
 =?us-ascii?Q?0e1DsEtOY6px9NLnZ29U5XzqwcF2+1QFKnAVkmiQqC0XtoRHK9zSbw+k3u4Y?=
 =?us-ascii?Q?zuUvxLplkVxZdCbFq7yZOhSmFrTyYZMQnIJjSzGB5Nj0jw//3jlE/oqOD4iw?=
 =?us-ascii?Q?1THmS4xniJ0pgYT0tabMmpnf+VXCg3Uf7eDt/xpUM3mMCYdQiBSvG4oG+1f8?=
 =?us-ascii?Q?8n6fGUqWF7pjrkem7/iH9TWca+XM72Y2s9w75wxeExt/3g8sYEb11iNanCju?=
 =?us-ascii?Q?k5HVu3dbQoY0e3N5M3BOH259hutyzolnwJIDx1ZyVzFJbg9tv0f+j/CZ48jg?=
 =?us-ascii?Q?msA28TZ/YWbvPQRTF6ZOga5bc6xVy6V52nuJUxUHqZSvEX8InrrkxEWlVNve?=
 =?us-ascii?Q?5ZS2sZx0iOkWcBlVVSGQ5uLgDesqvcxEQr0RPPivx67Jyo7b2HdwhH+f4hZe?=
 =?us-ascii?Q?tX9c2U9swUFu2yH5WyqU4HczztsNF/Ktso3C4RlDg3hE8W/k+22J7+Ev1sIN?=
 =?us-ascii?Q?EPDK0Fh3LCUWKO7vRwbwFnQQuJiQIj2aTs5Unsyeuv07CdGTetdFXxtSmCmt?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J2SNs/0srUjlnSXqp2tMgOP9xQgVJU0q0U57ZHJpwrS+MOT9pFMlVKMXEB608XhYQYEQiFKDwffndv5/LrQSpUHDfeTSHjaf9D1NzR5RVHJY3X70CwxCIGeTEVnU3Pb449E6vW1KyJ9fY9H7+Cv2TLuBPFYCY7e6r+ch/31qvv+6azregdrJ6M7lFPRFe4tikqtESh5xaanQwnJK2w8wkOY97p3cxDbERXKtW3264zArVnIoNAhLH4KRHN187hrHdEYc23ZrtUxtVY8Q33iuZjzEmFd3hDNj6Let8GCFfs55b91yipP8xNIqjYCNGyXYrpsYwE6AEomEb6fdoHdh5SUe4K4mK91Sia100ujhFUiJBKF9HNlMNI2KP2Z3+M4MqdXlvQx+Ucfy+lQDIPRa6YQUt5HsgbMPapRTPrENKXj7axW3UhupUGsd1N9TLIX1uK6Nc48X87So/732VglFkku5PhQ1vplxdJfnxNaPRAZAJoAbREGeFTuALuNj2c/71pEh6r2Cha59auIDmQGClBvfSCcY72iT6JwdVqijYCXSWiv3UoL8CBhYMvAA/Z3Gl6xQZ40gSSE0DcnIQITgoYgLUbBVuSmL9pfl7FHeE7A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a2d738-6de0-4077-aa44-08ddf4e205d5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 05:29:36.2765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KljSQ7EN0pdV9u9EIUHlV/5cUPz0m2vffBTxG1b+RiV9zUJB9+q+lkFBsxGmBUQc43vnMS8jO4XKrKyp1a51poOTku1pN+ezgyqDNlV++kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509160051
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX/01dxPUpdCyY
 wNLvxsZZVncghPkPVHB27ShmZCD9MngYow8CmoGMh9ozTsZypw79szZl5Gymx+SxY6kX1FyE6H9
 Aw6TRpEPDMInWxfWpaRM7DZeIUncKQlrbrCHZDzLeIPhyRXPKBJT6bi4oPvykf1CvvV4QT6c1ah
 Sr7aIdnEiaEzHWmF9kJsWrEUciiN9dvDdnAMYDcHcrOdJpQfVoYD7AVQMUU6yJntUTL5cfl1HT9
 t7w3/j2PBOlzEg6OXedQYX60UnOZWEnHPDeYex1RfkcnYBYkBgFzbgz101+p64XovlaCGwgiRmz
 deIrFmk5nk22oDeUN8ESt+DvKpb+LsKCv+0C2HIJNbBkFAGSzLgcM6rv6ik2QVD1+27efOY+4tM
 W+ZF6iJY
X-Proofpoint-ORIG-GUID: PKcL-lnJKZ7WVy0FB-65tY8PK2KLK9wh
X-Authority-Analysis: v=2.4 cv=RtPFLDmK c=1 sm=1 tr=0 ts=68c8f5c4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=ZryDrkjRnZR2dJgEcl8A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: PKcL-lnJKZ7WVy0FB-65tY8PK2KLK9wh


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Sep 11, 2025 at 02:57:52PM -0700, Ankur Arora wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>> > On Wed, Sep 10, 2025 at 08:46:50PM -0700, Ankur Arora wrote:
>> >> This series adds waited variants of the smp_cond_load() primitives:
>> >> smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().
>> >>
>> >> As the name suggests, the new interfaces are meant for contexts where
>> >> you want to wait on a condition variable for a finite duration. This
>> >> is easy enough to do with a loop around cpu_relax() and a periodic
>> >> timeout check (pretty much what we do in poll_idle(). However, some
>> >> architectures (ex. arm64) also allow waiting on a cacheline. So,
>> >>
>> >>   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)
>> >>   smp_cond_load_acquire_timeout(ptr, cond_expr, time_check_expr)
>> >>
>> >> do a mixture of spin/wait with a smp_cond_load() thrown in.
>> >>
>> >> The added parameter, time_check_expr, determines the bail out condition.
>> >>
>> >> There are two current users for these interfaces. poll_idle() with
>> >> the change:
>> >>
>> >>   poll_idle() {
>> >>       ...
>> >>       time_end = local_clock_noinstr() + cpuidle_poll_time(drv, dev);
>> >>
>> >>       raw_local_irq_enable();
>> >>       if (!current_set_polling_and_test())
>> >>       	 flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
>> >>       					(VAL & _TIF_NEED_RESCHED),
>> >>       					((local_clock_noinstr() >= time_end)));
>> >>       dev->poll_time_limit = !(flags & _TIF_NEED_RESCHED);
>> >>       raw_local_irq_disable();
>> >>       ...
>> >>   }
>> >
>> > You should have added this as a patch in the series than include the
>> > implementation in the cover letter.
>>
>> This was probably an overkill but I wanted to not add another subsystem
>> to this series.
>
> If you include it, it's easier to poke the cpuidle maintainers and ask
> if they are ok with the proposed API as I want to avoid changing it
> afterwards. It doesn't mean they'll have to be merged together, they can
> go upstream via separate routes.

That makes a lot of sense. Will include this patch as well.

>> Will take care of the cpuidle changes in the arm64 polling in idle series.
>
> Thanks. We also need Will, Peter Z and Arnd to ack the API and the
> generic changes (probably once you added the linux/atomic.h changes).

Makes sense.


Thanks

--
ankur

