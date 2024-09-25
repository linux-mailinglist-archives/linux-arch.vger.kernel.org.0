Return-Path: <linux-arch+bounces-7440-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF949867A2
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 22:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A91284F51
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 20:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52401149013;
	Wed, 25 Sep 2024 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P60DPxvk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qBvwj0QI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A32208CA;
	Wed, 25 Sep 2024 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295936; cv=fail; b=h7SUtpIu69Gri//b2L5RC4vQHlY871z/1LecSvZ+ZbvMtggoDofbMg6pR8N2CTT2s35qe5I8yqbMP/QGXjdyLukRuWUEB87n8Wt+mfzGhS3yrNyGgKFmZRF3DgnNMoPZjeTKHZCHmWAw5Ay96lLH71Anvc/yRyqBoEp5Qo1Ci5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295936; c=relaxed/simple;
	bh=BQrmaKxVHiDrpPM7tpna8AUd6ROisv5eQKRaBT+ZNFI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ES0G/uyXU9mFB92JMLP1Bps9f5i1/oWeAehVA1c2Vuy795spbjTPildvZwTxZzksBHV7PEQ9EJyk+BAEpTiTLxcH/iEjL0ToSpOlM7PoEcT6pU29Pvoa14NQam/wmZekxcsP34OnHIH8GS1S6FD6cYd9W84opRQh+WBwptFAjyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P60DPxvk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qBvwj0QI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PJBWlU030661;
	Wed, 25 Sep 2024 20:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=3R7hP0C0MQnZie+h5NSI4aKuROEOcmz/7YHtHvA/wy8=; b=
	P60DPxvkCtZU2Js42ezSnFFiSoY+G26gDILtp6sVRkt6V3WKlXN1uv6sugbBxK38
	ezONSLWOAlOQpnhccXyEy87Spvi1GvUNA/+eWuC9DHUObaGt8S9+oyVx3PI5qdxm
	mBEyI3HZHxAIJlu2OpXyEwan6bOT/qxhu/KFdrhPNqgYWGHJ37OPlwbCxm1XtWGG
	42Z53tMu8zwHBhndP5zb7ewtr6rWTM2GljpWPvPf46APWZ1xfDtA8fYYcpe9JA6X
	8upvlxx+E81H7ocfqsQ5EUESxvzcaZIwM+aLJtI3GwYSEm7BqgoPR+cke5j6liVn
	gOl0ISwmb5lV7AIbAppdNw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41snrt8w26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 20:25:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48PK2w86009712;
	Wed, 25 Sep 2024 20:25:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkaw6kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 20:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjg5HN/PI8DxzVA94J2JdPOFKcsMdNEz9NbalPj2Rc9YI9I2uOFl1j5j9IENi1hYNiGmtF2kchVLAPkxF7Yk2Gb1vtqJ2e4PDTXMqVUplHQ7oOLoLQnPBPfbQ9SUoAzaIayBGmHauQJouszG9vD8zZMzxud2oP/rOcWO4CLpIlTHeMTBuCC3l7gFTbKL7pWWyMht5qG1b+hwu7FBMakTCOw8Db0w5sLB55vAyKFAO04suMgmZZx6JCO8R9OZJEB6av1WCcbgBCqPVDg/5DZz1F9X3eStZamLlZfrX5PNOcFqSfWT7zIifrZA5fn/RchITy7cg+KsLDWwo06Oc7JxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3R7hP0C0MQnZie+h5NSI4aKuROEOcmz/7YHtHvA/wy8=;
 b=DXxl4pChnxwpMctKqdcdbgHiu9n5llbu0Tl2Cj3nudlOzwZO2m/5k40i8Oo3/hXMmorV1zJp6LdIUF26mzWxSZyj45/FG0Pm33pTagikFUttjeIE6lNRyoXDyoe6yBWa2guuA5CbhWSFd9ocgyreDMIywHbPny3SZWAy02us6QqKO6Qoxb1W3JyoPrf2rMOHtZSItoFghUW0OiSupR69Gwc/cPIKwV5u1tFQx+9XnioZXXrEKJPn0aURAiNFfyN27tlD9cj5f16Jb3nqu0knB2hF3RYdJf6iBDzSnE/FJd1QyHC48fn75dN+tLhiJig1WklfOZqIe6dR0a8eOxPUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3R7hP0C0MQnZie+h5NSI4aKuROEOcmz/7YHtHvA/wy8=;
 b=qBvwj0QItTgSFDZ2RR8SrALuq16nBzUcaBTxN50XwqQxNjekgjghH+weo9eOrKKVqg3t3Gl++OpHzJImVTjXLK6B3/9zyjXfnlRb97SyyXwtyxZUufrlo04aT/XYHu7K/ZgXkzHg4bjkHROe4uJhnjWDQAst7mu3f/Z7mRFhmJ8=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BLAPR10MB4834.namprd10.prod.outlook.com (2603:10b6:208:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.5; Wed, 25 Sep
 2024 20:24:57 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%6]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 20:24:57 +0000
Message-ID: <4eca972d-a462-4cc5-9238-5d63485e1af4@oracle.com>
Date: Wed, 25 Sep 2024 22:24:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 27/28] x86/kernel: Switch to PIE linking for the core
 kernel
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky
 <boris.ostrovsky@oracle.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Justin Stitt <justinstitt@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
        rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-57-ardb+git@google.com>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 xsFNBE4DTU8BEADTtNncvO6rZdvTSILZHHhUnJr9Vd7N/MSx8U9z0UkAtrcgP6HPsVdsvHeU
 C6IW7L629z7CSffCXNeF8xBYnGFhCh9L9fyX/nZ2gVw/0cVDCVMwVgeXo3m8AR1iSFYvO9vC
 Rcd1fN2y+vGsJaD4JoxhKBygUtPWqUKks88NYvqyIMKgIVNQ964Qh7M+qDGY+e/BaId1OK2Z
 92jfTNE7EaIhJfHX8hW1yJKXWS54qBMqBstgLHPx8rv8AmRunsehso5nKxjtlYa/Zw5J1Uyw
 tSl+e3g/8bmCj+9+7Gj2swFlmZQwBVpVVrAR38jjEnjbKe9dQZ7c8mHHSFDflcAJlqRB2RT1
 2JA3iX/XZ0AmcOvrk62S7B4I00+kOiY6fAERPptrA19n452Non7PD5VTe2iKsOIARIkf7LvD
 q2bjzB3r41A8twtB7DUEH8Db5tbiztwy2TGLD9ga+aJJwGdy9kR5kRORNLWvqMM6Bfe9+qbw
 cJ1NXTM1RFsgCgq7U6BMEXZNcsSg9Hbs6fqDPbbZXXxn7iA4TmOhyAqgY5KCa0wm68GxMhyG
 5Q5dWfwX42/U/Zx5foyiORvEFxDBWNWc6iP1h+w8wDiiEO/UM7eH06bxRaxoMEYmcYNeEjk6
 U6qnvjUiK8A35zDOoK67t9QD35aWlNBNQ2becGk9i8fuNJKqNQARAQABzShWZWdhcmQgTm9z
 c3VtIDx2ZWdhcmQubm9zc3VtQG9yYWNsZS5jb20+wsF4BBMBAgAiBQJX+8E+AhsDBgsJCAcD
 AgYVCAIJCgsEFgIDAQIeAQIXgAAKCRALzvTY/pi6WOTDD/46kJZT/yJsYVT44e+MWvWXnzi9
 G7Tcqo1yNS5guN0d49B8ei9VvRzYpRsziaj1nAQJ8bgGJeXjNsMLMOZgx4b5OTsn8t2zIm2h
 midgIE8b3nS73uNs+9E1ktJPnHClGtTECEIIwQibpdCPYCS3lpmoAagezfcnkOqtTdgSvBg9
 FxrxKpAclgoQFTKpUoI121tvYBHmaW9K5mBM3Ty16t7IPghnndgxab+liUUZQY0TZqDG8PPW
 SuRpiVJ9buszWQvm1MUJB/MNtj1rWHivsc1Xu559PYShvJiqJF1+NCNVUx3hfXEm3evTZ9Fm
 TQJBNaeROqCToGJHjdbOdtxeSdMhaiExuSnxghqcWN+76JNXAQLlVvYhHjQwzr4me4Efo1AN
 jinz1STmmeeAMYBfHPmBNjbyNMmYBH4ETbK9XKmtkLlEPuwTXu++7zKECgsgJJJ+kvAM1OOP
 VSOKCFouq1NiuJTDwIXQf/zc1ZB8ILoY/WljE+TO/ZNmRCZl8uj03FTUzLYhR7iWdyfG5gJ/
 UfNDs/LBk596rEAtlwn0qlFUmj01B1MVeevV8JJ711S1jiRrPCXg90P3wmUUQzO0apfk1Np6
 jZVlvsnbdK/1QZaYo1kdDPEVG+TQKOgdj4wbLMBV0rh82SYM1nc6YinoXWS3EuEfRLYTf8ad
 hbkmGzrwcc7BTQROA01PARAA5+ySdsvX2RzUF6aBwtohoGYV6m2P77wn4u9uNDMD9vfcqZxj
 y9QBMKGVADLY/zoL3TJx8CYS71YNz2AsFysTdfJjNgruZW7+j2ODTrHVTNWNSpMt5yRVW426
 vN12gYjqK95c5uKNWGreP9W99T7Tj8yJe2CcoXYb6kO8hGvAHFlSYpJe+Plph5oD9llnYWpO
 XOzzuICFi4jfm0I0lvneQGd2aPK47JGHWewHn1Xk9/IwZW2InPYZat0kLlSDdiQmy/1Kv1UL
 PfzSjc9lkZqUJEXunpE0Mdp8LqowlL3rmgdoi1u4MNXurqWwPTXf1MSH537exgjqMp6tddfw
 cLAIcReIrKnN9g1+rdHfAUiHJYhEVbJACQSy9a4Z+CzUgb4RcwOQznGuzDXxnuTSuwMRxvyz
 XpDvuZazsAqB4e4p/m+42hAjE5lKBfE/p/WWewNzRRxRKvscoLcWCLg1qZ6N1pNJAh7BQdDK
 pvLaUv6zQkrlsvK2bicGXqzPVhjwX+rTghSuG3Sbsn2XdzABROgHd7ImsqzV6QQGw7eIlTD2
 MT2b9gf0f76TaTgi0kZlLpQiAGVgjNhU2Aq3xIqOFTuiGnIQN0LV9/g6KqklzOGMBYf80Pgs
 kiObHTTzSvPIT+JcdIjPcKj2+HCbgbhmrYLtGJW8Bqp/I8w2aj2nVBa7l7UAEQEAAcLBXwQY
 AQIACQUCTgNNTwIbDAAKCRALzvTY/pi6WEWzD/4rWDeWc3P0DfOv23vWgx1qboMuFLxetair
 Utae7i60PQFIVj44xG997aMjohdxxzO9oBCTxUekn31aXzTBpUbRhStq78d1hQA5Rk7nJRS6
 Nl6UtIcuLTE6Zznrq3QdQHtqwQCm1OM2F5w0ezOxbhHgt9WTrjJHact4AsN/8Aa2jmxJYrup
 aKmHqPxCVwxrrSTnx8ljisPaZWdzLQF5qmgmAqIRvX57xAuCu8O15XyZ054u73dIEYb2MBBl
 aUYwDv/4So2e2MEUymx7BF8rKDJ1LvwxKYT+X1gSdeiSambCzuEZ3SQWsVv3gn5TTCn3fHDt
 KTUL3zejji3s2V/gBXoHX7NnTNx6ZDP7It259tvWXKlUDd+spxUCF4i5fbkoQ9A0PNCwe01i
 N71y5pRS0WlFS06cvPs9lZbkAj4lDFgnOVQwmg6Smqi8gjD8rjP0GWKY24tDqd6sptX5cTDH
 pcH+LjiY61m43d8Rx+tqiUGJNUfXE/sEB+nkpL1PFWzdI1XZp4tlG6R7T9VLLf01SfeA2wgo
 9BLDRko6MK5UxPwoYDHpYiyzzAdO24dlfTphNxNcDfspLCgOW1IQ3kGoTghU7CwDtV44x4rA
 jtz7znL1XTlXp6YJQ/FWWIJfsyFvr01kTmv+/QpnAG5/iLJ+0upU1blkWmVwaEo82BU6MrS2 8A==
In-Reply-To: <20240925150059.3955569-57-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0453.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::33) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|BLAPR10MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a401bfc-20e5-4bb0-87dd-08dcdda01efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1ZyOUJrRGtUeVpWNGtPT1JSTnRpc0hrQlB6WlI0SjBkUGVvc3ZXUjJsem5E?=
 =?utf-8?B?Mk4vcVhYQXh3TTh4RUxqTXNNWmRhN1F1amkzYU4rTUQvaGRpN25xRTNmQlRQ?=
 =?utf-8?B?WTA5VUd4L0tWSHI1N2lhZXphN2FwM0hLTGM1K0xYbkgyL00zRmVCUjZoUUtz?=
 =?utf-8?B?cEE4T00zQkJPaWRwMFRkQUIyTHJmbmN0eEU3SzdsbGw0ZFlNZzZDa0ljQ3Bv?=
 =?utf-8?B?M0x5MU1nUGRUMkhhbUNMQW9sMjIzd1ZDMHN0K3pxRm1ialc1MFFEV21QaHg0?=
 =?utf-8?B?bFYvV0dTR3U1bjhHa3cvaFhkTjc1WFliMm9sL1VBV3hjMFQwQWJEZWpPVllC?=
 =?utf-8?B?VU9nUDRzSnk4Yk9ZVktZYTE4T0dQYmlWNUI2ZXljclByaldmbS9wcWtENlE3?=
 =?utf-8?B?UGFiRUtEUHhMVnQxSzNNRTRSUS9vMkxxeTZreEJSejczc3IxSG05RWYreUNz?=
 =?utf-8?B?aWFGVzNMaGJYc2hsc3FJVEFqNDhRdmhtcGhQVTVpUDNhMDk4Vy96enJVT1gx?=
 =?utf-8?B?OEFIVkVYd1R2ZnBkOEtqeVR1bU5USWs3Wnhsc1daSXNOZitZaWNXcEZldHd5?=
 =?utf-8?B?NC9Sek1RN2ZHRm53THVvaE5wWkJVaC9MN1FEZlRzL2dnbjlYc0RzU2RtMWdn?=
 =?utf-8?B?OERSbXJ3L3B0VG5ZVVgwbVdGQTE3bEdBVHRLbWtxbE5ucWMyL2VMV05DTUtU?=
 =?utf-8?B?SzhwT0dNNTR0aE5Zb0NvYktFVFhLNlNwNWlWZW4wMFlxYW50UVRkSFpvTnhQ?=
 =?utf-8?B?dHk0emg3WkxObzc1OVpzSGlqRmtoVkpHcUFUSHhRckpnME43UE80bjdzam00?=
 =?utf-8?B?aTJ0c3hSQ0RnZ01FSE9SV3J0VCswbytpcFNDVitBanVUMDUwaVpvcGhISEpT?=
 =?utf-8?B?QUs0Z0owU1dTUW9CWVhUN3RrUFlVemY3Q1NMbXNEOXEyamtEa25Va1FIcXVz?=
 =?utf-8?B?SHY1YkpWaUswbGZsT0ZPaVNwNzBMQSs3YkovTnJ4eWpwQ29UZkRXb1VocEh5?=
 =?utf-8?B?WTJJZkc4OVQ0NDhMbTdYTVVkV3lTdTQwNnhTbS9EVEJzR1ZlaWJqbDdJUjdG?=
 =?utf-8?B?dFUwZDllVnBYVEwrenhlOFRIdnBmTWJCNzdta25UV0ZFYkVMeEFTdXg4SFE0?=
 =?utf-8?B?a2N0enR4VWdIV3I1WnlwWVEvMWgranpFSXFQYk9lR1BTaW82QXhlQ05ZY1FU?=
 =?utf-8?B?eWU3c1BMTE9hSC9kSnduWHVDUHEwVnMvckJEdlVqMjAwSWRGOEtpdjlFQU1m?=
 =?utf-8?B?VjdPQ1dCdEZnRVVSd1FIZW16MnZqdGNGK0VMNDJkUGFRMGJPSk5McVlGaFgy?=
 =?utf-8?B?QVplWnhuNEczMTZuYVdnRjdEcW5TZnlOdmlmd3lROFVIL0JlSGdldzErK2Vv?=
 =?utf-8?B?Z0NIK1ZXajhBc1o2c1FzWXdxdlQwR3dXQzRhcXFGUkY1WFk5dFp0VzhnNTFW?=
 =?utf-8?B?OGZsUzVVL1p0c0xBWUlZa3NKaXJLK2RicWE5T0JCeFJyWjljc0tvL0FoTHdh?=
 =?utf-8?B?ZHNWbFZvZVlxcndEMEREeVhxZndva3ZxQllEYWwycmw0NUd2TGx1Z3h0OTg1?=
 =?utf-8?B?cyt5TjJqN24wQzRiUjFNMGI1Q0NVL1N4ZGpZVm1sK2d5K0RBWTFOWUgyeVB2?=
 =?utf-8?B?NDBRWk8vVFdLTWFjTGIwcUFFOUZhZlp6S0NSU3BTS0s0dmd6T0hEcDZvWFQy?=
 =?utf-8?B?QjZPZ3FvcVdYZVMrYXB1L1JReGlVdnBKcVJQUXc0VHB3VGR2K3NuVmgyRGhM?=
 =?utf-8?B?REtMMG5BaEliR3lXUzZCOHRETzAxMFhLYWFQZzBzSUlxWW1pNHFuOVBjMlVR?=
 =?utf-8?B?WTlSaUtZbDBQdlV2MWFhZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnR3OEV6RURwVmlPNlZRcjUrdXlhbCtBSmtJSHJETjVlUEhIWnYrek0zYTV5?=
 =?utf-8?B?a21saXFEeHRieXcyV0NYdmExUEZ0c3lLcUZRQ3RrVEVrc21BVGlSNnVTeGFa?=
 =?utf-8?B?MVVTd3FESjFvcDhaZU00NnhEMjIxbHFwTWZPMXI4REdncjUyRkdaSTdjaUpC?=
 =?utf-8?B?ZFhSeGEzOWpRQTNFWGRvMnJLclFuYnJreTBxcGUwaXJUcFg5QjA1RjFwdkFm?=
 =?utf-8?B?QmYyU0NqdWZ4TSt6d21yd3hmemZQbmpyemg3bUVUTE4wL2tNTzMzV0NGTGQy?=
 =?utf-8?B?a1dqUFl0SnZaRWpvQ0xWT2tFVmlmbGdaNzlNNnRMYXRrNXRWSnU1TWp3azMx?=
 =?utf-8?B?L01jTUQyekR0QnBHTGk1bVVabTVlVnU3TE5Wa3F4T0FITXlQdC85VStjejJQ?=
 =?utf-8?B?QXJwNytNSTA5N0hmaFRqVWRyUlg3UUhla1ZoYlRQSVFGZ29sN2FOSXU5NTVk?=
 =?utf-8?B?M05HWmtxMlN4VFNsT2lhMWhIdGZBSmJ1YjZnMWxsQldpaE9TTVRmT2xsNjdV?=
 =?utf-8?B?RkJGK2FyR2ZCbzZYcFJWOXFhQVFLV1EvNnM0cXcwSnlzV1U4NHhzL1IwSUE0?=
 =?utf-8?B?a000QUNpQy9ENWVFK0JCSEs3QWNFYW1QZkxVNysvWTFyOUhwS1p2Yk9raThu?=
 =?utf-8?B?cnVQRW9oZWVCRlBaNDVQMjcrcmhMZTZpWXhmRmwrSkZxZmVUdTlBcjJNZHNq?=
 =?utf-8?B?TkhrZU1INFhRN2hTeEdDZU1ZUlFaK0xxc3lrRjc0bUJxN0VMODFDVlhxclcz?=
 =?utf-8?B?MXorbTFWZDE4Y0ZzMkxNYlFhSHVvVXlnM0Z3S2FCV1RjaWpNaVJHM1dGSkFO?=
 =?utf-8?B?OGtxU2lrZ3hBVmlPTHFyZEZjUmZqWXN5TFJRL1pTRW8xcTAzc3ZNWm0xRG1I?=
 =?utf-8?B?eFd3OWVDMTBBSGI0eVkyNkdDdC9Oc054TFZMUE9yU0JPbjZKN1NyekhzUm90?=
 =?utf-8?B?SzJWNnVlM0ZBNHJ3bE9OWWRSK29uS203NG5jU2h6NHJFd3NYMEdScjJwQnpx?=
 =?utf-8?B?M1JHU1cwUThwTFZMUFJ6NDU4WFAwTVpsaDlmZ01nQ0FGSmwzRmREMHc0cXcw?=
 =?utf-8?B?UVdDVU81UkpxQTcva3FobEorSTdDZkZPWmRUMjd6VTMvWkhuemtXVk5IOXVD?=
 =?utf-8?B?NXBQdHpFV096Sm9jRU9CcVdiaFBDUXYrWFVrK09PYnM2dkdNcW9TUktBQ2tn?=
 =?utf-8?B?OUpndGdSSzdrRG50YkpFMk9TV3NUWm9IcW96ZXlxS2JPdURZcWVvemFReG51?=
 =?utf-8?B?TVc2dGtFWVI2djhVR2phaXdoVVZGTlQ0ZHRVWFI5dm1JRUZHWitPREZ1SDM3?=
 =?utf-8?B?U05FaVhMNGdxZjhaaUV0OHIxNzVRR1IzVW9hQ2lZMjN6Y0dIdmg1SVJIbXFX?=
 =?utf-8?B?SkJUaVBTQ0Vjb2FWbXl0RkhiQnZqTkJ5L1ZyV3IzT2xXY0p4d3VTd0ZqOERZ?=
 =?utf-8?B?cmlQNE01VnU2TWRMcDFPbmF6eTl2cVZMSGZ4bnl2Mk80Z2JkNjllNVdBaytF?=
 =?utf-8?B?TXkxMlEzbXdHMGQyLzRSVmltU0pCY081c2pQYms1ZS9uaGZQWmo4bDY3Tkp5?=
 =?utf-8?B?Nm1qRGdPek1UdUxCalpQbzV3aDFnU1JsOXlSTnZUWUYwMWlMRFVpcEpGUzVz?=
 =?utf-8?B?RUdXdDgxeXVzdjRIRkFhSGM1V1g1UzhxNGdyQk5maTNva3BHeTJieklhc3Jr?=
 =?utf-8?B?TTA2SkdqRlRsTGYwK0lkVVM1dmgxbmYvL2tVZWlMT2phcW1qajdzR1I2NTdr?=
 =?utf-8?B?M1JvVGptVDFIbkc1cGx0eWNERmFvb3RYMkhZY2JuTVZRYnFUbGw3OXVpT3B2?=
 =?utf-8?B?VFJ3UGVvMzhnWGhMajZId1ZCOXM0eHI1MUhQbVRqK0J0L0FkZ3RqWFFjQUs5?=
 =?utf-8?B?enNEa20wMjRBM3dxRjVPWDRTZGlaWTB1a2VIOURzclJzTFFORTBaajB6LzI3?=
 =?utf-8?B?aW1iRnhhS2lIV1ArZ0VrTmNJNU9oZkc0S05kanY4ZktTbXdzSUFPei9YNUtV?=
 =?utf-8?B?bi83RVEvSVo4b1NWcHhodmJ3L3I1UzRYZWttV1o0dE1aV3B2djFHaUlZZFNB?=
 =?utf-8?B?ZjF3Q0VjQmVCZURqNDRGaDlDaXVmVDhNVDluQTViTmJCT1piYnJpelRNV1FV?=
 =?utf-8?B?Vm1OMDBxMVIvNjVJeUk1N3RtaitpLzVwUTBxU3ExZVBhb0JTc2FsRW16MXJM?=
 =?utf-8?Q?CS2GmHgSQb92sBX3ja97hSE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	78MpzZ2aRtX6b/5+avfWHVeCwig66hEh8tZy7Ib5LZDQIlVM4rKZFaPzLkfGxzbnVBUfWxztrVwpTKmedbCwYwmgNoNqACP2JXBpEAHQtKqfL+jBcy/iIIM3KVN68HiwKI5AHqIEHVBsdvx4rRKlxi4t0nWUhjDA0fLfJp4dJt3+43zVqaVZQTW1dJVSRMxq/DC3W+7bge9NJQKwz32ekdRRu3TX73dFSH8nMeH+wzLxsqFx9tYmuqq6BKCko9sgLIeY28t4n9E7tNzMkW+z5zyQlBO+O/VqdoLUaTPHqYaCg9TigwpZzQxdS1C/c158ecIDsJcDqRpxv5QYA02HlrPRiUX7a+3zgQ5/AZx40oobqe8EEosuOLfnPCRRGeSbFUWkNYa31E8lhxyNOu0WM1/AIe+o70R3dHZ64KyxrcG9zJaylIWED6558/sJYzbTGqD3JMa9hI0YqxmM08Z7viwR7KoyrL5gyYK5Araa2pJL2TP1DZR74kjifZMsghYA7ELtXOvFUYYkt0T/+Hnc/fRyKXZaC32CEvm413EnEwt2bEjj+p+1wykfSrD7IYkIssGJieKt5FxqCR71tY2CZgR9XqZRzRiELT9rO742ZYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a401bfc-20e5-4bb0-87dd-08dcdda01efb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 20:24:56.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XW0eE13rqFjaygUHGq72++G+szpr8qfqwgBzTz1mzZMPeEMB+iTO0coO2GhoO9vHqD34L/CdGqN+C1ic72UT8iuT4esOH1zTZOU3u1ySog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-25_12,2024-09-25_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409250144
X-Proofpoint-GUID: YAPQV6BtA94Lg5eEQjM3XTvQU4wAyMUL
X-Proofpoint-ORIG-GUID: YAPQV6BtA94Lg5eEQjM3XTvQU4wAyMUL


On 25/09/2024 17:01, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Build the kernel as a Position Independent Executable (PIE). This
> results in more efficient relocation processing for the virtual
> displacement of the kernel (for KASLR). More importantly, it instructs
> the linker to generate what is actually needed (a program that can be
> moved around in memory before execution), which is better than having to
> rely on the linker to create a position dependent binary that happens to
> tolerate being moved around after poking it in exactly the right manner.
> 
> Note that this means that all codegen should be compatible with PIE,
> including Rust objects, so this needs to switch to the small code model
> with the PIE relocation model as well.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   arch/x86/Kconfig                        |  2 +-
>   arch/x86/Makefile                       | 11 +++++++----
>   arch/x86/boot/compressed/misc.c         |  2 ++
>   arch/x86/kernel/vmlinux.lds.S           |  5 +++++
>   drivers/firmware/efi/libstub/x86-stub.c |  2 ++
>   5 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 54cb1f14218b..dbb4d284b0e1 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2187,7 +2187,7 @@ config RANDOMIZE_BASE
>   # Relocation on x86 needs some additional build support
>   config X86_NEED_RELOCS
>   	def_bool y
> -	depends on RANDOMIZE_BASE || (X86_32 && RELOCATABLE)
> +	depends on X86_32 && RELOCATABLE
>   
>   config PHYSICAL_ALIGN
>   	hex "Alignment value to which kernel should be aligned"
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 83d20f402535..c1dcff444bc8 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -206,9 +206,8 @@ else
>                   PIE_CFLAGS-$(CONFIG_SMP) += -mstack-protector-guard-reg=gs
>           endif
>   
> -        # Don't emit relaxable GOTPCREL relocations
> -        KBUILD_AFLAGS_KERNEL += -Wa,-mrelax-relocations=no
> -        KBUILD_CFLAGS_KERNEL += -Wa,-mrelax-relocations=no $(PIE_CFLAGS-y)
> +        KBUILD_CFLAGS_KERNEL	+= $(PIE_CFLAGS-y)
> +        KBUILD_RUSTFLAGS_KERNEL	+= -Ccode-model=small -Crelocation-model=pie
>   endif
>   
>   #
> @@ -264,12 +263,16 @@ else
>   LDFLAGS_vmlinux :=
>   endif
>   
> +ifdef CONFIG_X86_64
> +ldflags-pie-$(CONFIG_LD_IS_LLD)	:= --apply-dynamic-relocs
> +ldflags-pie-$(CONFIG_LD_IS_BFD)	:= -z call-nop=suffix-nop
> +LDFLAGS_vmlinux			+= --pie -z text $(ldflags-pie-y)
> +
>   #
>   # The 64-bit kernel must be aligned to 2MB.  Pass -z max-page-size=0x200000 to
>   # the linker to force 2MB page size regardless of the default page size used
>   # by the linker.
>   #
> -ifdef CONFIG_X86_64
>   LDFLAGS_vmlinux += -z max-page-size=0x200000
>   endif
>   
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 89f01375cdb7..79e3ffe16f61 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -495,6 +495,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
>   		error("Destination virtual address changed when not relocatable");
>   #endif
>   
> +	boot_params_ptr->kaslr_va_shift = virt_addr - LOAD_PHYSICAL_ADDR;
> +
>   	debug_putstr("\nDecompressing Linux... ");
>   
>   	if (init_unaccepted_memory()) {
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index f7e832c2ac61..d172e6e8eaaf 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -459,6 +459,11 @@ xen_elfnote_phys32_entry_offset =
>   
>   	DISCARDS
>   
> +	/DISCARD/ : {
> +		*(.dynsym .gnu.hash .hash .dynamic .dynstr)
> +		*(.interp .dynbss .eh_frame .sframe)
> +	}
> +
>   	/*
>   	 * Make sure that the .got.plt is either completely empty or it
>   	 * contains only the lazy dispatch entries.
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index f8e465da344d..5c03954924fe 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -912,6 +912,8 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
>   	if (status != EFI_SUCCESS)
>   		return status;
>   
> +	boot_params_ptr->kaslr_va_shift = virt_addr - LOAD_PHYSICAL_ADDR;
> +
>   	entry = decompress_kernel((void *)addr, virt_addr, error);
>   	if (entry == ULONG_MAX) {
>   		efi_free(alloc_size, addr);

This patch causes a build failure here (on 64-bit):

   LD      .tmp_vmlinux2
   NM      .tmp_vmlinux2.syms
   KSYMS   .tmp_vmlinux2.kallsyms.S
   AS      .tmp_vmlinux2.kallsyms.o
   LD      vmlinux
   BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol bpf_lsm_key_free
FAILED elf_update(WRITE): invalid section entry size
make[5]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 255
make[5]: *** Deleting file 'vmlinux'
make[4]: *** [Makefile:1153: vmlinux] Error 2
make[3]: *** [debian/rules:74: build-arch] Error 2
dpkg-buildpackage: error: make -f debian/rules binary subprocess 
returned exit status 2
make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
make[1]: *** [/home/opc/linux-mainline-worktree2/Makefile:1544: 
bindeb-pkg] Error 2
make: *** [Makefile:224: __sub-make] Error 2

The parent commit builds fine. With V=1:

+ ldflags='-m elf_x86_64 -z noexecstack --pie -z text -z 
call-nop=suffix-nop -z max-page-size=0x200000 --build-id=sha1 
--orphan-handling=warn --script=./arch/x86/kernel/vmlinux.lds 
-Map=vmlinux.map'
+ ld -m elf_x86_64 -z noexecstack --pie -z text -z call-nop=suffix-nop 
-z max-page-size=0x200000 --build-id=sha1 --orphan-handling=warn 
--script=./arch/x86/kernel/vmlinux.lds -Map=vmlinux.map -o vmlinux 
--whole-archive vmlinux.a .vmlinux.export.o init/version-timestamp.o 
--no-whole-archive --start-group --end-group .tmp_vmlinux2.kallsyms.o 
.tmp_vmlinux1.btf.o
+ is_enabled CONFIG_DEBUG_INFO_BTF
+ grep -q '^CONFIG_DEBUG_INFO_BTF=y' include/config/auto.conf
+ info BTFIDS vmlinux
+ printf '  %-7s %s\n' BTFIDS vmlinux
   BTFIDS  vmlinux
+ ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
WARN: resolve_btfids: unresolved symbol bpf_lsm_key_free
FAILED elf_update(WRITE): invalid section entry size

I can send the full config off-list if necessary, but looks like it
might be enough to set CONFIG_DEBUG_INFO_BTF=y.


Vegard

