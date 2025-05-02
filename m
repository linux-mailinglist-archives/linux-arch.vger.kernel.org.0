Return-Path: <linux-arch+bounces-11785-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F29AA6D1A
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 10:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397DE4C066E
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 08:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05C824168D;
	Fri,  2 May 2025 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eeea5SKh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qTBSmDmH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFD7231847;
	Fri,  2 May 2025 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175985; cv=fail; b=BFtOS9mm3+tqB0qvbNHTm7cVwD/PT6lgggHfNJ6/vAfZrhCSNXYfeXMbgNZWpEaGAUDx2D1WrbnQStc+ogP9mwx/cDToy3yltZHCI0rwNtxk6iKrtGyDhXuZlbJ3RV7cRkc3S3VFuRejZdA1h48amaGjjwuyDNqkqZp0Wum+cGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175985; c=relaxed/simple;
	bh=P0Q2Co/KNwIR69xO0bLnZ51CursThvmxBIno7qLKxCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pnH2NYCbNgYefWJq9YtKATu+dcdxuwlEqhv6ayhjlwljlrph87PqVMhIv7BYw3cjPb8AfjPJMjw1yRFYDBd6EkQZ2YXua3GDgWATDk9sos7qZPp/NLzTh4fT1/teYvbi5UGoDkvcek4/EwU13wKjRVeIF95x2LLsdQe/w5hQRmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eeea5SKh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qTBSmDmH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425WwMj013912;
	Fri, 2 May 2025 08:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Da64/pvyw8SJTaSF77VNKCSJ2o6Nfdnw/U0B0TRA7fg=; b=
	Eeea5SKhqsKYOwk5zg48nxdpKQX6/SoeIy3u7F8wTGnBvW0D3UPMH69/CchI+YhR
	hI0TKzezWv2NG9vm0VdUlaJpN9Rn7gvywPbKg2Y089k8nK3KlUqEFGpikiv38YXa
	7dKLuCF8/44ocpf9AKA1CtNOBbSyoXH3WSAAwHqS+v4PLItSC+V15lUziZLje1ud
	w7khrW0ypurvgjm9DPl+CxP0/JalFi3uS6duFZh0DcM3OF93LsOc/DlWxKN6UO4c
	OcqLnLaepYE3BiihQ8TPnWR1Z3+PzxXBD6vF3dBkK8q4BNnpO7M4/Hzq03uTlfzE
	LmmuWnN4ksMEq4zhqlcx4w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6utcu9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5427Cp9X013794;
	Fri, 2 May 2025 08:52:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxdjncc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DX3iMlGNIEjGsHLTV0jZl3XP1gbw+zx1GBd1tpxHWov0ba47SlZbOi9yb/Itld25I8abgKvOuRpF2zFWJIU7qpMYEr1njrsIVd61BJrb8h91b6HMr6TLDcxDUtF6JLnRcgMp8d+wEZM02I3Bp1YBXFOE7zkj6Y0u9X4yKolVOQTDHn17RRCSXoUvFY3f4x322ascHJvTXVTGnP4p3sIwYKqUuEjYmwAZmhdasZZ2Ocyeu/Rdu4uoo9UDL5W5BcehLMwetdTxR2gqzEO/QjfS+H/9d1mGDF7yWST14HvlxU2hvW4QkcNaQffw46XiK5JOVfBgBOaO+7DY2uZ3KKgRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da64/pvyw8SJTaSF77VNKCSJ2o6Nfdnw/U0B0TRA7fg=;
 b=bnnYTJxTYokfYX0lYwReHB+NhlfpBwuqn7gJgooDXKFwgOU41PUmzgW/rxCSMFQzSx4s/R7QFBY1aBidSZmYMGIEXu7goRDq5flNItuvtqwZpEtIcqWubDAFIvM4NUqc8dK9lGfN6wVZYR2dPBAhzFSciEB9y2GlZVuHjf7Ek4yFLOlN5K96eL+tzIE4qWQB1fqIW1BXbNcxX/6b7uIRYlUV/SCOXJEce4zY55nmu83WPULf3Gs8P7PLPfY2oy9MiDy2UdMH3r+0nxF7QyTXFRwL895gbVVdDiW/Zw3OWsec8Eb0ZbNSP1Dqgucd5mJ23F6FCtf5PHefaxkBwCc1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da64/pvyw8SJTaSF77VNKCSJ2o6Nfdnw/U0B0TRA7fg=;
 b=qTBSmDmH46mltaubhoWmZVlTQzjEQQafkOaBdLOUcmdIfXOH1sE0kx63mTs/L4FH+n5SNvattxQN9tWF6TYf8ooCVCA/gdGMjlZrfbommH8rmaoyXdXvR1LYqgK1QXEiMF2qlvj56vJ3taNTwoAx0qvrQfbV+ftLC9xycPODQiQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV8PR10MB7726.namprd10.prod.outlook.com (2603:10b6:408:1e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 08:52:32 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 08:52:31 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v2 3/7] arm64: barrier: enable waiting in smp_cond_load_relaxed_timewait()
Date: Fri,  2 May 2025 01:52:19 -0700
Message-Id: <20250502085223.1316925-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:303:8f::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV8PR10MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a3d522-604f-478f-45df-08dd8956ac73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MkALKR2kER8jx2WWHFKdygFXBUP63lrqTlpMaFy8ZVEnX8KZP+b2A/tDUxhD?=
 =?us-ascii?Q?UG4X4nv5lqhRrUIy0c4cEFAI6DneOQd5EBnp7q360irr+e5XqL7Mk0St3wlr?=
 =?us-ascii?Q?ZR0lE8OOwEZdKzCq/960QLeC67s28TYL13RHo3SUKPH0NQeMDG2sWSTCqCuv?=
 =?us-ascii?Q?YNudFhjtcCy8Y/NLJjNZhBM0xBwkpUgNC396hx8GluvawuaF58QD24e+amO6?=
 =?us-ascii?Q?m3ChNcB+ZFM8J6lz8jhfANDGwRZIjgKaOE4HCfzSw9GjboLBtNr/+eYMXgwT?=
 =?us-ascii?Q?m8zpWKz12btmc99pN/TKpimaE1luNs7rDfLTGNlQA82dEBBiOxklVX7jLJXw?=
 =?us-ascii?Q?NzvawZUrzj00uIw4tD1XREWUKCAfzD96UEL74ow9Cia++YMJgbkRRuT5FlQ3?=
 =?us-ascii?Q?cD4byHcU2L3Pltke2xfMAG+N9X+AHBMiecB2X1Ooyw5rj0Sp+Q+glAoULYEs?=
 =?us-ascii?Q?VDBbfjXg0HmlbHnGUbTyZmZuWGTOIi5GlC5CStpiWopS3bZUW1jq5U7w329C?=
 =?us-ascii?Q?VlRp/ol52TJvE7Mmzz5wXDCl7miruRS3XpW/hv06/wWPsNs6D7flaWmSClIN?=
 =?us-ascii?Q?+jEA2n+m9gfRfgjkC+JdtNPAmgSBupHUlMJomIEJOTcmrbJZGDcIt8p15LAO?=
 =?us-ascii?Q?gkja68tmnkjUKYxz4kYJdABXE/f83UjVmi+ufC91q/8T15lMY15tgq1+hPMs?=
 =?us-ascii?Q?kfXiiMHhYnMyEjAZORJO3a5oOmRwLvlN37YMAn7W0ugIzehpgsZ+pkIkI1hA?=
 =?us-ascii?Q?QFCvV+Hg9Nz2JgdY+bq/OvE1sLFhu+ZEEw9F5IVXlG5hFuO2kgKlvbcAgzR2?=
 =?us-ascii?Q?1JFMgJuDnXrJWVPjU7B7uwmuwq3eShwCEbQm6kx01JR8wzpEKY5xIzELzkQl?=
 =?us-ascii?Q?OFhkett7g60YPuzIfmIY1Rk8s8QIPjRRpXbyguxqU8Zr3tt7p/LvEA14zt6k?=
 =?us-ascii?Q?OacCTh3pvhpGvKoJ6HSv6vgaO01U6KqdNjE/DYfWillhwtIXu+0h/3123hCg?=
 =?us-ascii?Q?ECB6CskOVk60vi5AM6mgbhJITY7ILRB9FodvhQqEs1yfY7h6E1ADAlyftZ1C?=
 =?us-ascii?Q?Oi7JcyoOTF+WktqRDRl1xYiHIUNC18ynDJAymMT0KVq+KsKDX7vhLmZBSapE?=
 =?us-ascii?Q?yM8Pk4yiLT8g/B7rPxa8mAwQHeAtMcjlUGdkRuHEr11ytMDE8//l3EjesqEK?=
 =?us-ascii?Q?/L+IQFjSSbAW3xDBxyXUjDJ4uw+/9N/34pDipHQZeo6A3Yl7K+uwqBM5zcTa?=
 =?us-ascii?Q?bafLGlCdPC904+qLOTGsmTxv/ijD6YuI0mg8UoopRrgnoDK3qKLZ6W43nsn8?=
 =?us-ascii?Q?YAk81amFmw9f3T8/6yHWrB+huiA4TZAFPQaKlQD5oqZaEgR/KGGSYSMp8xHY?=
 =?us-ascii?Q?RigGpof11EPZS0kI2Jc9QBeYgzpWP1Zqm7LEYEGDu03xm6sWDhpLMM6Bb2fb?=
 =?us-ascii?Q?PfNPF3LeJzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T5iXHVd9Uto0JOpQQB3Dlnm2+Ob/za8qW5e4Ey1SHMrbGqhxF+XwmSkM00g4?=
 =?us-ascii?Q?WSlFfMFsX0BxGl/61Q5oqb/WTjwlSo9i5UQTr93Qera1Y9N1VcOBJbPW+8Vf?=
 =?us-ascii?Q?HcaLdn96JTVVavudTpMORY7+T5PU+qLqtBLB5yPjJPT7654OoKKPJ1Q0yxqr?=
 =?us-ascii?Q?dkFb2i7kuOA20T6DXOCRSLUWmO2udUoO73l+DAIQEAeHjsdpzbDA/zHbflDc?=
 =?us-ascii?Q?pjeyvGV8dqDe2y9AltYF5BLTi7/O2+RWrrJqCnVvhzVqGjX0jrSdBpVdKGiX?=
 =?us-ascii?Q?dDxx36vSKipzZjDWgE3ROulo11ITxKWfVELGkiWZESxwfwZ+S9Qpdo8mrFmZ?=
 =?us-ascii?Q?rw/ALLa+cL5EH4PdD5EvHuhSCkQiZA5sOQfzia/V/G4rxRezW/Yqgby6P0Be?=
 =?us-ascii?Q?gt63/DOFmJV51mwu9XiNYbihT5GvJRmwA3P8l7cUI6HC6sG/fruLHkJZxaQ8?=
 =?us-ascii?Q?XH1OvVUi2VUXkI9+IDtyGWViuW0qNYj/PQ27GtECc7MrfJgkSPJBPVb5hV0K?=
 =?us-ascii?Q?WoO3uWDGP3hJnwamCuiYoZxE67jOKk1iFC/uxCY43KD5fYLCSj2ACZ6QdCeQ?=
 =?us-ascii?Q?CO1BpQd9UvqodIW/Rs9oxzSUiK7mOAdl+ZfTBEvRuKoSEKxUOk7209ljYCVG?=
 =?us-ascii?Q?m3PaGuA6ooW7dPJIjknOqDSAlXp3oTBacsUzGl7118cf157TIgVWgEk/qzso?=
 =?us-ascii?Q?nKu0zc3a3DCMgIGlX5+u8Anib5+FHjCnaUisHrlklFMLpkoav4Rx6hJf8ubb?=
 =?us-ascii?Q?NMeiQYnElDKZJYHqsRmVYcyHnpRqvUFcaczhcka+p8s+13h9F1cgJQ/psxq+?=
 =?us-ascii?Q?p/tq+HGtI3azuU0tBFi59wyAeFNz9WfGVMd9MmpYIyBCQWBc4iFB7FdkaLQu?=
 =?us-ascii?Q?1emeHQYYD1izeGZFGCLLFrxvgUXGcM3p2dZ5m1XMBnZ83gmL21tmOW2pEhEa?=
 =?us-ascii?Q?NEiyapC59n2pOT+h/yyGVGkV84q/4TJyZ3FGzSAh0wC4IMZCoLmXugMGLM7z?=
 =?us-ascii?Q?HLL//wpvvAdeA0q5M0MfoqotI+nIdlBiatneruUp8vNhu67iQd6x0kRIbq3S?=
 =?us-ascii?Q?+tExUmLhdlZi5VYtphjIli3o+6z4SC5xBA/a1sybFfRYIDX9XxYwRRlHSzKD?=
 =?us-ascii?Q?edusdyiuBg8mHISZmWg/ybXjLeruAtgCVbVLGGn1HQrIFoEOXwCl2MB94lj+?=
 =?us-ascii?Q?IqVRUmFQA/1LbFmkq9/MVA3+KVtMx8Wge0YgeJzn126Nca2mgq0FwusbClal?=
 =?us-ascii?Q?jj28pvgLhGl1z9HlkIfkYbsmezcLNc750VE+8iHpCJOLO70QGmmpBxcVgP/+?=
 =?us-ascii?Q?2NaZP9wmPljW8YiAUfPrCFBguGCeTbn2LTkLqdMJYd826XTmh696iUpxcmI7?=
 =?us-ascii?Q?TREjrRyuzTtCs024XzjKURMwua0SmGZi47rhB1q0ylzedFsCZHOo+K5uInRP?=
 =?us-ascii?Q?7TDv+ULPY58cfeo0hmaC//Y0QizOlKujsVljoyK++9VMJOC90odbytWj0KVm?=
 =?us-ascii?Q?HS9n2foUIAo/8wczK/ffx6GazHEsedLqf5XPUe2kuVipB6Qzb4k+aHmOCSFz?=
 =?us-ascii?Q?5qn2p8DY+Ywk2U1X6Xl8NlpmAnLEr/hsZ2F4yJ0eCdiguq+zYt1Lb17Ulhhd?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6GHpGTRLURppfX5rE+/cFDhIJbS1KSMEyvtUacXXgJcSAaIbtMMzClI46g/lF/ShlQQ7qk+TYapBGAzNnBRstmXwCrFwi9xcSq4OzI1e8DECyfkPhEZXadl8AQ3EQJYQIWwROs5wnPudZ5m6TKogtT5A/MDIlKHT4tRCYbQgteXZd337FIF3k5u+g+qlsSK6biCBRiwgTQiaktmio++lKVKPLa4dI8IopiPa4qILl9qOWlO1LzEJyK5vLExUD0MDCWVmAOm4pRpiNhkws/mk11EUYH1jbkksrIKiQmtmSAnL8d0qMcyMAvrXEdxbTYA64lzUBOL/rv2CG5rjgTL5jIr+wuGOtUjkA7D7RBcTVpTPNG+GlpvU3UteMB+xRIrHFuTRaOrD5GdAVI15wJKfjthqnPH7DtUwkWEIM6+i2ODRorKN4UJ/PNvQlzUwHoCIiDhecRuS6gdC0NvVA5bqc7fLjiCahSd2sOJ5LN4sg+ipF0/j5YfRwNiy/VCAHrA4W22xSIZjBZXrb4LkBPIt8KNLHln6EFNKg3gccKJRyTd/gxO8i8FxLtXeGPPNgInS7G5I1lQvKzTZKclRlEVexH/IkOysib/AFr8T8v28arE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a3d522-604f-478f-45df-08dd8956ac73
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:52:31.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgs1NUGPSxZl3qZhsyMTKDq+r4QMsPX9fJZjEheZlJc8DuzUhZVPXbjMgejNtxROZueUbrfj3+ZXH55hvkQI3f1ghGn9/n3Gxvuh0uH4hek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505020068
X-Proofpoint-GUID: v6isgWx0WooJG_evGhAec67fN5XMMtXY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX+SUGZ8bdQ1ZZ /hNGJLncarNvA9Wbqj4QoIkx0/vpnISIRfvq0xkFLKiufFwCJTWv8OY2y3QjoV8L7WlvdrqEqmQ cmEy6A6IpM7Cv+IA+yWS8ve9KF8eSUSZ4s013y7lBRjvRbBz2cN6PZX5wMA/Zo+DtI29E/s7AWy
 L7oxI8aSScVhVWCKeCcE4lFX+o53uFUxSHeIu371XGqE4+pb0Xvjg0Lj/iTAvH8A//VLNkGQAzC V8NPloKGSBwmUUeKR9iRufG0RnrslGuBJQVu6N3ieSMP5jNavwZaJIHXpLYPGpqoTJ6BKvtU6mP t7ZAlLd93R1ofmFjd/xSX/LRsgmvWJSNzzWRwtr1II6T2+DkRnqADGekiflb73wl2CqVRSjijX0
 qOiuX9pp4uQ0w1zOk/Rz44TGrhOYrSte7Z+uVr0AELkxNyzGraUVjW6kXYohBYdMMfsNqVfl
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=681487d3 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=HJ_Fa5qwEEjzTwSpTccA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: v6isgWx0WooJG_evGhAec67fN5XMMtXY

Define __smp_timewait_store() to support waiting in
smp_cond_load_relaxed_timewait(). This uses __cmpwait_relaxed() to
wait in WFE for stores to the target address, with the event-stream
periodically ensuring that we don't wait forever in the failure
case.

In the unlikely case the event-stream is unavailable, the wait_policy
is expected to just fallback to the generic spin-wait implementation.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 1ca947d5c939..eaeb78dd48c0 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -216,6 +216,9 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+#define __smp_timewait_store(ptr, val)		\
+		__cmpwait_relaxed(ptr, val)
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLY__ */
-- 
2.43.5


