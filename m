Return-Path: <linux-arch+bounces-13404-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0435B49857
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 20:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C5617D1EA
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5922617A31C;
	Mon,  8 Sep 2025 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dnxxi0IQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZPOSUZy1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029531B13E;
	Mon,  8 Sep 2025 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356314; cv=fail; b=ljWwzQYGbfwcgGhcDV/aIUHy3xtvCuMjVFsFgv+y+XRgKjBw339+OLX+IWENMkES3NE7ldm8UOb8CSk5pbVP0x4Av13jR5lPceFvFGCQ63gNfXtjLD6QvaRCL0hOEnjFVd9QJ3rZZOsIAgU5Lxz1865b9nSU9a6LY3COYmZ2mx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356314; c=relaxed/simple;
	bh=G8JI+RSwXAQOPKNgfAQ5pHSObrMS3GUNX6Fz1nAoN0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PNAbaSxceUOybhW266weQXj/Ot8Gz6z3SY5CeXnQRubB7CP3slXyF0GVBierGN1Q/DUbxMDmsrduWQDvCAOxFWO4er+UUwHJq2f0uDvt3+BXxnqdA2oOyU08BraAa5pthoAXOTuGi1Hqu6P46LHsNPoHEI9kTikBgBkokVXmurU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dnxxi0IQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZPOSUZy1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588Hg0xc017344;
	Mon, 8 Sep 2025 18:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=W7mIiEyfLs6uWNY1pE
	pytYJ4iloFBtkRi4jpWwb0s64=; b=Dnxxi0IQUTAG1pcWwP2IFviLVM1F5b4slh
	uGTIcSk+Z1g9mC88FtsV5UBqC5xM8mMc4fyyz+17V0QyauF/uz/xPDeH/R9rCgte
	ayrkRjvlGB/C3ioeunVSMWMpz3k7+q+FUcRIjU7Kv2y0tRPYieVO02z24XG8gTk7
	6G7RnFgnR3Io+geySA2VtPIaMBXUkxAjHo0GA8JoZZt4zAln2BesUR4v8tz3Wkyg
	Jru2rNbcXpN8L5HMJpYQ9NtdTAn+9SzZACYR/WpVldPgplbIZP+jc/ucXSg9Kc/T
	04V2OICLpOn7JCWQv4c9zS2PDEqF1TGJ2urGxojZ29rNqfLGKvmg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pe8cq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 18:30:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588HR2E8038759;
	Mon, 8 Sep 2025 18:30:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8jxn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 18:30:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyjZu4GfxcY7Bg56HxB4Npd7MtHI9yGPZkrPjHrBkd+3qc2y6lrB6/IEkOh6Qdx2KErysbm8U4HP50AkXkk87Gk265Jf2r9nKlb5LyEsHDO38i5yQ/CIJa0z60ADVs89aU5/E13dDc6URA/BLtHQOJWz0EIZYeAkD1l66v2thSV4x7FAs+fOACMkOxFYw63DREweYGMyPNCudOLUyPE8CueEM3XZaotwQ5LtHx95tj9P57VAZ2HZc+ivcgB9n23lBLXy4hjUpew1ygHpWLf6GY0JZKD7Sa1KcRmzfKQBIt4x6YIwbEuBHu4Rn0pzdsdwwDjvdXk4R8cg1Nd05nhKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7mIiEyfLs6uWNY1pEpytYJ4iloFBtkRi4jpWwb0s64=;
 b=Nw6wVdieIvb6A0PT2kTfO8vzTzNiZXvqfKoCrsVO9uWVe2pPPw8CtGwIOsaotuPz1dpbZ97Q7g0dYJLTrUIXlEPWtZJxfLVu0EJ2Hd9yAuekSE44OWytmTFknXOBhRyeDQ2UKBkKXrEnufTqV+2UcLt5rLGjWJlruiitmabYfmvXAYn1rZ4vKEoh2v30TV9ldm91pM0OO5sjFwh7iwCQ1EzBFf0mSbqzlltgXqECd+k2f8Rklv4hiPI4H67re3RpbRHF9GOT/ekb5wy8QgvJg+LA0ulk+OlW3FC4eePg4DX0JfG5+DsJsyJ2QOuGopuaJqJH/Z3iAcuwl/JXUG/CTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7mIiEyfLs6uWNY1pEpytYJ4iloFBtkRi4jpWwb0s64=;
 b=ZPOSUZy1WQ31Uh+ZHGY6rbj2eutNmfXI5NZyial9t4HyXWeL5alzZP/jPqTVhYgOqpBaB7IIaV+mRsJqSPKMB1cCfBO3wUVoqBadGf3or3Nb91tp0fmfxWk0cYg3pPw8BUFW3zLUjOdJbsOxZFxWRo92oC1xbKoflTZf5XdYV+Q=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM3PR10MB7945.namprd10.prod.outlook.com (2603:10b6:0:47::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 18:30:02 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 18:30:02 +0000
Date: Mon, 8 Sep 2025 14:29:55 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, andreyknvl@gmail.com,
        arnd@arndb.de, bp@alien8.de, brauner@kernel.org, bsegall@google.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        dietmar.eggemann@arm.com, ebiederm@xmission.com, hpa@zytor.com,
        jakub.wartak@mailbox.org, jannh@google.com, juri.lelli@redhat.com,
        khalid@kernel.org, linyongting@bytedance.com,
        lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
        maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
        mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de,
        osalvador@suse.de, pcc@google.com, peterz@infradead.org,
        pfalcato@suse.de, rostedt@goodmis.org, rppt@kernel.org,
        shakeel.butt@linux.dev, surenb@google.com, tglx@linutronix.de,
        vasily.averin@linux.dev, vbabka@suse.cz, vincent.guittot@linaro.org,
        viro@zeniv.linux.org.uk, vschneid@redhat.com, willy@infradead.org,
        x86@kernel.org, xhao@linux.alibaba.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 01/22] mm: Add msharefs filesystem
Message-ID: <lgwf5d2y2ok2f52l7xi6klln4hbncnoyn2s2jdi3k4wi5ngfz4@kbtqjwirdnqj>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	andreyknvl@gmail.com, arnd@arndb.de, bp@alien8.de, brauner@kernel.org, 
	bsegall@google.com, corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com, 
	dietmar.eggemann@arm.com, ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org, 
	jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org, 
	linyongting@bytedance.com, lorenzo.stoakes@oracle.com, luto@kernel.org, 
	markhemm@googlemail.com, maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, 
	mhocko@suse.com, mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de, 
	osalvador@suse.de, pcc@google.com, peterz@infradead.org, pfalcato@suse.de, 
	rostedt@goodmis.org, rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com, 
	tglx@linutronix.de, vasily.averin@linux.dev, vbabka@suse.cz, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com, 
	willy@infradead.org, x86@kernel.org, xhao@linux.alibaba.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <20250820010415.699353-2-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820010415.699353-2-anthony.yznaga@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT3PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::30) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM3PR10MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: c5de092c-c702-4533-fc56-08ddef05b945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qHH+KhC4vQ0dj+w1uBRYnCOipcF/KLesnZNgnZanRP/uZhyms6cSGFBXcKCN?=
 =?us-ascii?Q?Roq24iCcStWRMK0eCHTglubNXbp1M7NSuWXMZ/0oKix8mQDyEEJPR77XDekd?=
 =?us-ascii?Q?hJvimoe8zVTcKOIqI6UHMvH8zgcEBPUUyzWxsDi6S4AuGoTLdKkyQGbq5FG7?=
 =?us-ascii?Q?NroLgbqytEygcP8oxCvhbO3xx5LidFD4fuCw/RBK44Kkq1idp9/ioPsyYGFN?=
 =?us-ascii?Q?AiFvlKDrAfBohzVFbxa9/7fzZSUjWeTsBtkre/Jes14ahnHAnbBVv9q5WFVX?=
 =?us-ascii?Q?chIOOkqymXzLZ3+qx/I89Yp1iOyrGtc8Ba2zYcGBRdZgTjOAbw69l+6ZfChN?=
 =?us-ascii?Q?gIzNU6O1OGp0sIp4zafJbK0r0BmAlQuPUtCLt18MWyX51R8RPBPWAYsagcE5?=
 =?us-ascii?Q?/XS9dsL4B9WKDoyd6F/QPn8b4ROcMziR01uHiZp2oir+YBL2wl/CI0TgG8Ey?=
 =?us-ascii?Q?ShftfnatBK7d0J3rfk+bs67/5F6kKcQSUuoeSeQIFk+U4aoaFEFDNzs08U+b?=
 =?us-ascii?Q?AcA5U6mSgxd9NQ4rGGH6xq/0gH2g0OUMtpwLqRJZ7JQqY3OjA2qJHFMZ6Gqt?=
 =?us-ascii?Q?CoWatxbaB4IZ8yYGOAO/59nOFDRNDzdOxXvGxCoHLWva69F8Ysb43JIvPflD?=
 =?us-ascii?Q?Vx/Ic3T3LGngSC8eMOvjVQxwQvk0VrjEUznZAL1Z8awxRyATuGUV17ICdo8+?=
 =?us-ascii?Q?XKuweoGT+eBm0Wku49ifSvt+Qzo9/sqeuU/OW5hC7volTbeEI+bG6VTxFu7p?=
 =?us-ascii?Q?pz3kFohQrNgvCW1YEI7Jcq6aypepU4AGJGs0PTdWKG8kvBLyvphLFPFjd6jJ?=
 =?us-ascii?Q?sUZ5jhMzHt9Vjz77DU6fHRSHGwpGuzZg0r+Af0lf3or1v+f1FQIjiMdxDi0z?=
 =?us-ascii?Q?mcyepUuX/DCtIV2QLDSKT5w5yXF1MZNCs2Jl9W1DVVpYh2CqpzKXlPc4EKow?=
 =?us-ascii?Q?HhgFXXt5yvlN0KgNaBWRJ/Fd1yA3TUbVt/zzMvNfnd9Dm7qrqo9vYNlj77c/?=
 =?us-ascii?Q?zaiITzhEkAxE0ON4em8Q2iYvTa330Fh/v+NwmsNGLoR16lRATIWlmD9BBsID?=
 =?us-ascii?Q?p9V76vCzUrS6KYNVzAwhfgYdeARmHjcyAw7xRMcn1gQ8Gvbyp8yQMI0zJ0HE?=
 =?us-ascii?Q?3121eQV3KTw0y2UB8OhJPDN1ihVOW+Ml/3BtXzKGd9UiwlHjBavV+ssmuLXS?=
 =?us-ascii?Q?6pLqNJrXkTxKQ3a7v5d7eskkuJmcs/AVxyQ0mAaOD7izzSLRFunRLPdX6cUY?=
 =?us-ascii?Q?FUY7sQoUnjF9JJKE/wAtQULC/pXJtKmiWCvoS+h19ATzGdg7rCMbgT3rBwW8?=
 =?us-ascii?Q?5ZxuuMhHRkFDdz7U6T/JvECFM1yrL3dhUOEyylRfrN+LepqcX/UroVswvnD7?=
 =?us-ascii?Q?aaMvBwR5D4n7geBrOME8Lmi+s8jnH1Ep0Oa9t8pRN2pPK4BlLatJqDi7s2r1?=
 =?us-ascii?Q?9CpqqImHmN8NYxetsNAMu/lQRKGb1JCv4kbQZieQQb0VJUnHeqCdtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?24iBUB+iVySYAUUHskj2lRfziyTx55jf9xn9zM61LV+1No9wVdd9gaAX0Uzw?=
 =?us-ascii?Q?A5dqMxdNj61/+PKSGXEqSXfPI8c9t4rmmCTMAftfKZSTKPIgSW3CPeyoW/fq?=
 =?us-ascii?Q?a66X9Aac2nDUesDHHr2yff7tBEXwuVdD6+oYw6O8sSw3IH5koSvD8PvbrL0k?=
 =?us-ascii?Q?6gwontthc14BnLGIOEkG7JRT0CXSojvS4L1rQiEeqllzRtj7XnZECt7kYp6+?=
 =?us-ascii?Q?aarYkBv+aYiJwFrrm7g2clPQkzEdM9RP5xJi5zuT2PNttZcucg+eCmVdgQp5?=
 =?us-ascii?Q?h8TigN7yyiuismGWp/SoZVtRa7VMiBRroYAUyLWCH2qqRcIjSUqWJICR5Xsi?=
 =?us-ascii?Q?IYXvu411wP2JBoXHhUbn22Cz/lbSmoWcZaNJrwUdhZS4ZTKBpQfNzPnuUQ+u?=
 =?us-ascii?Q?o0U0owxmw5oGc7IMcXYRvF+ERxsDJM1BUsMBgruu5eIrPBRqvvz4PicPejNm?=
 =?us-ascii?Q?Tf3RKS+SX6QHAPuZly6mCPzcmGAEkEGy2bBitVnM5l2ivqA8Qbs398PB2la1?=
 =?us-ascii?Q?CzKXMIKqq97nqgxmWIZRXo/mttrRs4FWFHndgsKtMqGg3CNeHz1xdqeiw+kk?=
 =?us-ascii?Q?rzKAG0Sl81EQDhoLBkIsJI75PmzJ54gfa5c8tREG/gVDnzssPPewrpHITAzj?=
 =?us-ascii?Q?fHpjymG/gU4u/OpyWHoc5m7S+c06T/VH2OLc9DszaGud2K46KoaqNhV3XCG0?=
 =?us-ascii?Q?J6AybOvZvuEJVtaLsHEgPMhPDvnXJiF0acgQAQtFKWhL8lIZEUu9TLt/UT4O?=
 =?us-ascii?Q?gBHD8ZrfRk85aXkDzuac1/kk2tl+8CXTQGqzUOSsI26aoqBlF9K6HV7EBHn2?=
 =?us-ascii?Q?6fqhL7rLHxojredzBU5qknYHeST8TDXigP/bR0lRiJ0/mXPmT8VqNhv22DP5?=
 =?us-ascii?Q?YlY7hGGufXlHp1CzGLSX1zklow1p0Dl9NwsRlw+RIO51i+sPqUfOe4goKkoe?=
 =?us-ascii?Q?NZbUW5KFAOoNXb7YtYGuOOgm/B1WZKI6+2BK4trqDSxMW0IUOwhDTd12mokh?=
 =?us-ascii?Q?wBMeg6tC+fHm7MQdUkFHuxdmTSt+tz5y4PuzotqVWTuXaxaXfw+R6ZnzrvRW?=
 =?us-ascii?Q?eSCjwZae1tBdqFaBxgcJ3lWRcJ025XStNccFKHgyvKUH2NGv4QM76rA7+Yba?=
 =?us-ascii?Q?S93ZCzsUuLKK4yARAMzjxyg6ZwP+EMM0Q/jVNrOTLxRauTYJCsViY3Ueby6a?=
 =?us-ascii?Q?A2Rz1f07LIZQgJw3gUb9+147GH9eB6mDwov2xd25KU0MYbOnPK8A4SMckhAb?=
 =?us-ascii?Q?2lyewPZrP68efvib4uW5QfMHRgosE+jqubKIBNfZ3909ujp6XmP7WUv2YijW?=
 =?us-ascii?Q?HOAVr+ng2rJhBf2xSyHmqow6SGBErAcBLEE+IpW3g6+YWqlf5hmivMhrIThM?=
 =?us-ascii?Q?wXpmcmJgN7cIZfROHQhpR1F40QQ2XtztFlen1CgX2fVTRNsUAuuJsXzlW6Fl?=
 =?us-ascii?Q?KiEyiJFS+bvhRpdJvVA6tBAgjiiO8dNSOWXyWJ7aTbsXYHZ6ZEEKi3sivGmu?=
 =?us-ascii?Q?bQZr7b6YIni82ArNUxjlpiov76Af4Z4NFn5Mrsaq/l+NmWUhPr/T0kbypajf?=
 =?us-ascii?Q?aDaydCj/zQ749DV2gPvow5PSb+uTEPNiw+lItzbh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j+1TpvSTah82Zibh4bI7XcfVwGVJT73hIz86v37YXugAIagiMKFH6CfG41XwfhcihmG8mCd6qTInbC9tbMGCLJwby1JlI9DfN0BTXtTTWrwOTvIp3VtbXBlUwzD1sGg2SMLny8Orvg6k/EG2xYb2K7e8D5RRUUxAqR25sblPY0V/R3CZeG4xtHJ5qy7aUZi5VE+t4MPHeFMNgYJQZmevnF7p0VQgIUcS+LQepkJFnFA4/4ZyM3Cxdk7eYKJaMvuB8KPdjXxSt92zEZXQwDoesQuPSStN+VimZ2uWetuDezF93XM69oUSJJ/Itma3RJEZYvXydexPtVrkiokmv3hzhIBxOiNa/q67zFNZGGeadwffGc1WNty9TA7LVETY0ssOJwSNtDlebA/fkHLBNqJaV/ioOKN8rVtcB2RGs4NXi3vm8t/E9VN8YRGU67z0mmuPbyfNFfZcs+NcNTD+QsBMA9SjdYkwvxVwdkqJ2/yP7ab4r27T1uGhyX2nGsDI/VyeiaihbjbZSyXml+gJOTaVfKmgm1pjm8BvXR9ySQ3+LzBUWdASzwjzDxuRszY/erClw3cT4WUkZuIiyFSPX5JjGzLZJeQejIzSzmGQIiw944c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5de092c-c702-4533-fc56-08ddef05b945
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 18:30:02.4186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmUv/JSFUOsG+6PVY7GIhpe65wI1CdSA+n2/OYh6fd2iffEG/lbbrHn9cg2wZ+onY6sEAHJBBqGbfRD6Kmat6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080182
X-Proofpoint-GUID: s9br84IzvNFhOnwA3HRCbYbpO4uaWKWv
X-Proofpoint-ORIG-GUID: s9br84IzvNFhOnwA3HRCbYbpO4uaWKWv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX3amOBH3PTuZN
 YMmOBq1s008d7b30/nGBlMcgExbK80zT/WHs2lv8C3BIMwo5E0O2w3ezFwnJJQTDNxwnrVAreS4
 951MPVdcKCcC+DFKQLTBaKqMycozxetf/sdntwzbVrV2LIrr1ZCSdboYgXBgPflAOfh/GNk9b3K
 a/vZi1smOjl0FvQ2Pj6psvLRaCX9NNfgDOk1rRBXoa7Miul3JjscXwIlzEe+/Sa8QV/k70Y9K8G
 tr8jKWR1D+TDRFaJPn51SyD/MuJptKpC6PrF0SeuzSipgnYqPvFAcTi/2waCPJhBkgf55OjVCMa
 Uofwq+b4fqfer3ixKJ1ox6PC8VnWxLidXq9+0uL21wlexntWBynXI/ewbeEP786LszYdHAssWaC
 RrHbumDel4LhDMn0J84wiuWh18Rb5Q==
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68bf20b2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=VlCqjFug5eSbi98TGyUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12068

* Anthony Yznaga <anthony.yznaga@oracle.com> [250819 21:04]:
> From: Khalid Aziz <khalid@kernel.org>
> 
> Add a pseudo filesystem that contains files and page table sharing
> information that enables processes to share page table entries.
> This patch adds the basic filesystem that can be mounted, a
> CONFIG_MSHARE option to enable the feature, and documentation.
> 
> Signed-off-by: Khalid Aziz <khalid@kernel.org>
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  Documentation/filesystems/index.rst    |  1 +
>  Documentation/filesystems/msharefs.rst | 96 +++++++++++++++++++++++++
>  include/uapi/linux/magic.h             |  1 +
>  mm/Kconfig                             | 11 +++
>  mm/Makefile                            |  4 ++
>  mm/mshare.c                            | 97 ++++++++++++++++++++++++++
>  6 files changed, 210 insertions(+)
>  create mode 100644 Documentation/filesystems/msharefs.rst
>  create mode 100644 mm/mshare.c
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 11a599387266..dcd6605eb228 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -102,6 +102,7 @@ Documentation for filesystem implementations.
>     fuse-passthrough
>     inotify
>     isofs
> +   msharefs
>     nilfs2
>     nfs/index
>     ntfs3
> diff --git a/Documentation/filesystems/msharefs.rst b/Documentation/filesystems/msharefs.rst
> new file mode 100644
> index 000000000000..3e5b7d531821
> --- /dev/null
> +++ b/Documentation/filesystems/msharefs.rst
> @@ -0,0 +1,96 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================================
> +Msharefs - A filesystem to support shared page tables
> +=====================================================
> +
> +What is msharefs?
> +-----------------
> +
> +msharefs is a pseudo filesystem that allows multiple processes to
> +share page table entries for shared pages. To enable support for
> +msharefs the kernel must be compiled with CONFIG_MSHARE set.
> +
> +msharefs is typically mounted like this::
> +
> +	mount -t msharefs none /sys/fs/mshare
> +
> +A file created on msharefs creates a new shared region where all
> +processes mapping that region will map it using shared page table
> +entries. Once the size of the region has been established via
> +ftruncate() or fallocate(), the region can be mapped into processes
> +and ioctls used to map and unmap objects within it. Note that an
> +msharefs file is a control file and accessing mapped objects within
> +a shared region through read or write of the file is not permitted.
> +
> +How to use mshare
> +-----------------
> +
> +Here are the basic steps for using mshare:
> +
> +  1. Mount msharefs on /sys/fs/mshare::
> +
> +	mount -t msharefs msharefs /sys/fs/mshare
> +
> +  2. mshare regions have alignment and size requirements. Start
> +     address for the region must be aligned to an address boundary and
> +     be a multiple of fixed size. This alignment and size requirement
> +     can be obtained by reading the file ``/sys/fs/mshare/mshare_info``
> +     which returns a number in text format. mshare regions must be
> +     aligned to this boundary and be a multiple of this size.
> +
> +  3. For the process creating an mshare region:
> +
> +    a. Create a file on /sys/fs/mshare, for example::
> +
> +        fd = open("/sys/fs/mshare/shareme",
> +                        O_RDWR|O_CREAT|O_EXCL, 0600);
> +
> +    b. Establish the size of the region::
> +
> +        fallocate(fd, 0, 0, BUF_SIZE);
> +
> +      or::
> +
> +        ftruncate(fd, BUF_SIZE);
> +
> +    c. Map some memory in the region::
> +
> +	struct mshare_create mcreate;
> +
> +	mcreate.region_offset = 0;
> +	mcreate.size = BUF_SIZE;
> +	mcreate.offset = 0;
> +	mcreate.prot = PROT_READ | PROT_WRITE;
> +	mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
> +	mcreate.fd = -1;
> +
> +	ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
> +
> +    d. Map the mshare region into the process::
> +
> +	mmap(NULL, BUF_SIZE,
> +		PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +    e. Write and read to mshared region normally.
> +
> +
> +  4. For processes attaching an mshare region:
> +
> +    a. Open the msharefs file, for example::
> +
> +	fd = open("/sys/fs/mshare/shareme", O_RDWR);
> +
> +    b. Get the size of the mshare region from the file::
> +
> +        fstat(fd, &sb);
> +        mshare_size = sb.st_size;
> +
> +    c. Map the mshare region into the process::
> +
> +	mmap(NULL, mshare_size,
> +		PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +  5. To delete the mshare region::
> +
> +		unlink("/sys/fs/mshare/shareme");
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index bb575f3ab45e..e53dd6063cba 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -103,5 +103,6 @@
>  #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
>  #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
>  #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
> +#define MSHARE_MAGIC		0x4d534852	/* "MSHR" */
>  
>  #endif /* __LINUX_MAGIC_H__ */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 4108bcd96784..8b50e9785729 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1400,6 +1400,17 @@ config PT_RECLAIM
>  config FIND_NORMAL_PAGE
>  	def_bool n
>  
> +config MSHARE
> +	bool "Mshare"
> +	depends on MMU
> +	help
> +	  Enable msharefs: A pseudo filesystem that allows multiple processes
> +	  to share kernel resources for mapping shared pages. A file created on
> +	  msharefs represents a shared region where all processes mapping that
> +	  region will map objects within it with shared page table entries and
> +	  VMAs. Ioctls are used to configure and map objects into the shared
> +	  region.
> +
>  source "mm/damon/Kconfig"
>  
>  endmenu
> diff --git a/mm/Makefile b/mm/Makefile
> index ef54aa615d9d..4af111b29c68 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -48,6 +48,10 @@ ifdef CONFIG_64BIT
>  mmu-$(CONFIG_MMU)	+= mseal.o
>  endif
>  
> +ifdef CONFIG_MSHARE
> +mmu-$(CONFIG_MMU)	+= mshare.o
> +endif
> +
>  obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
>  			   maccess.o page-writeback.o folio-compat.o \
>  			   readahead.o swap.o truncate.o vmscan.o shrinker.o \
> diff --git a/mm/mshare.c b/mm/mshare.c
> new file mode 100644
> index 000000000000..f703af49ec81
> --- /dev/null
> +++ b/mm/mshare.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Enable cooperating processes to share page table between
> + * them to reduce the extra memory consumed by multiple copies
> + * of page tables.
> + *
> + * This code adds an in-memory filesystem - msharefs.
> + * msharefs is used to manage page table sharing
> + *
> + *
> + * Copyright (C) 2024 Oracle Corp. All rights reserved.
> + * Author:	Khalid Aziz <khalid@kernel.org>

Probably needs a new year or year range and another author?

> + *
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/fs_context.h>
> +#include <uapi/linux/magic.h>
> +
> +static const struct file_operations msharefs_file_operations = {
> +	.open			= simple_open,
> +};
> +
> +static const struct super_operations mshare_s_ops = {
> +	.statfs		= simple_statfs,
> +};
> +
> +static int
> +msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +	struct inode *inode;
> +
> +	sb->s_blocksize		= PAGE_SIZE;
> +	sb->s_blocksize_bits	= PAGE_SHIFT;
> +	sb->s_maxbytes		= MAX_LFS_FILESIZE;
> +	sb->s_magic		= MSHARE_MAGIC;
> +	sb->s_op		= &mshare_s_ops;
> +	sb->s_time_gran		= 1;
> +
> +	inode = new_inode(sb);
> +	if (!inode)
> +		return -ENOMEM;
> +
> +	inode->i_ino = 1;
> +	inode->i_mode = S_IFDIR | 0777;
> +	simple_inode_init_ts(inode);
> +	inode->i_op = &simple_dir_inode_operations;
> +	inode->i_fop = &simple_dir_operations;
> +	set_nlink(inode, 2);
> +
> +	sb->s_root = d_make_root(inode);
> +	if (!sb->s_root)
> +		return -ENOMEM;

I don't know the recovery here, but what about inode and inode link
count?

> +
> +	return 0;
> +}
> +
> +static int
> +msharefs_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_nodev(fc, msharefs_fill_super);
> +}
> +
> +static const struct fs_context_operations msharefs_context_ops = {
> +	.get_tree	= msharefs_get_tree,
> +};
> +
> +static int
> +mshare_init_fs_context(struct fs_context *fc)
> +{
> +	fc->ops = &msharefs_context_ops;
> +	return 0;
> +}
> +
> +static struct file_system_type mshare_fs = {
> +	.name			= "msharefs",
> +	.init_fs_context	= mshare_init_fs_context,
> +	.kill_sb		= kill_litter_super,
> +};
> +
> +static int __init
> +mshare_init(void)
> +{
> +	int ret;
> +
> +	ret = sysfs_create_mount_point(fs_kobj, "mshare");
> +	if (ret)
> +		return ret;
> +
> +	ret = register_filesystem(&mshare_fs);
> +	if (ret)
> +		sysfs_remove_mount_point(fs_kobj, "mshare");
> +
> +	return ret;
> +}
> +
> +core_initcall(mshare_init);
> -- 
> 2.47.1
> 

