Return-Path: <linux-arch+bounces-1967-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F36DF8459E0
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 15:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2408D1C20B0D
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D227C5D473;
	Thu,  1 Feb 2024 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XhWePwvS"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E75D479;
	Thu,  1 Feb 2024 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797073; cv=fail; b=b7CIpOtmkfmEJCsbswhvo2KXLaJGbSdYMUolruK/PaoQUVReUW2MYqe/dn+OtLZHoI6nHuYkZ0SCNvDHW6MPd7jowtDKHN6EYf/W+8JjRRsQArQ2RCPX7Bz+64Zb9dlqDw0hMXFqF5Zaf8DXYb+/KXgNChvPnz2Ph4d26s3txYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797073; c=relaxed/simple;
	bh=LMUGm3ix9ttsqVjpCKCZytySqtdYzKo4G3kSmO4MP6U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X9btfPw4H2MoMh/Z885aF8IRqWJAA7tNgslmvpJOsrI9N6g9CW4e3xYDFJWwkrgmnyLlyR8pbCO5wungVVfc2mZVlYUZ3vZUZm5s9O/rk3yDt5as71Q4YrDYCrZr7WFhD7+wu+dp6pj59QDnoVofZRQ4KFxHcMHo/H4na7uz2uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XhWePwvS; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUCGWsaX1zZC6EVoH+K64rbHGd429bSdyMIN0KhYRcJ3+PFXm6PW3g8Jyre6VJ/JvCXg1obKHwY3b/5Z2blzVUdIKp4Zc5rzgPBD1YY0MEH2jS2ADLvMWKn4WYebphsVobET/SdHYxU/cPsTmL6SgO0UnEPYJ1mNVBaYGVTwAkia18812QGvguX6J/MKtBxoHnBqum5qYSDrYJYSupQJeEX4FQU7zkTdFsbrTVr1c3UJ0cYB0A56exY9+4gYXwfw64P4pOJ8nREMuhNQwf27NGLaWQcY1j7jYdJVPeFfeTSkoUwk5AiV6Zg7d9z9/EeEwH4nLb09RkClWRuNQ25uRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOVgJPMnMs9+i2kP0I51K5ilgoQ6/rWb4pzCzE6DchM=;
 b=htJe3cMIYwOpFYa/tL0uZQXq8va8t9QvfqslW1z5WEWoZY9e0JHe3ua302pVJgf4UEmfod64IkvTE8PZkvrAG9CiNTKsmRnsRY9wA7s0rGNJ88DMkBoNcdT5FpBaCH5kYG7P2sQobXrPrc0/bQAJCsP4+psOhFVeOpRT4GoGde2iHDWc+u2rrGflfeAmlWZSlquLTPEYrn9MPpEK2AO3YjP4mHBC9YncofsFCZW7rLGqN0DUgTMGC8MQo9wnwkFOKjBG3BKJFZI3sQNIAWOu4nmFjUF5BvkIKRVtIHLhkZlbx/dhqxoL8CDgktdFEKQNXdApzWqiiedSsrz7aRr5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOVgJPMnMs9+i2kP0I51K5ilgoQ6/rWb4pzCzE6DchM=;
 b=XhWePwvSU1KYan5Nd2kQUp1c3FK6gwN0j1rTTeP/57yMkuEE0cwYjg8hELRSrlXd/tYoq0xx7rCN5MBFaxICwf1Dk/+MtsOBT+xMCmvFshMTtM3V9vKeLsrbD8NSz2OMfTgcsN9uve31QlMkc7QJb4Gi3JoswrdGLpxr+7MmW60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Thu, 1 Feb
 2024 14:17:48 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7270.009; Thu, 1 Feb 2024
 14:17:48 +0000
Message-ID: <8b38ef82-ec2b-4845-9732-15713a0e2a85@amd.com>
Date: Thu, 1 Feb 2024 08:17:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/19] x86/boot: Move mem_encrypt= parsing to the
 decompressor
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 Kevin Loughlin <kevinloughlin@google.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>,
 Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-23-ardb+git@google.com>
 <20240131083511.GIZboGP8jPIrUZA8DF@fat_crate.local>
 <CAMj1kXG9W0XeEVR4tXDDg0Ai9XPsZGrTJaSRYUqgTV-xtFxjdQ@mail.gmail.com>
 <20240131092952.GCZboTECip8DbWtYtz@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 xsFNBFaNZYkBEADxg5OW/ajpUG7zgnUQPsMqWPjeAxtu4YH3lCUjWWcbUgc2qDGAijsLTFv1
 kEbaJdblwYs28z3chM7QkfCGMSM29JWR1fSwPH18WyAA84YtxfPD8bfb1Exwo0CRw1RLRScn
 6aJhsZJFLKyVeaPO1eequEsFQurRhLyAfgaH9iazmOVZZmxsGiNRJkQv4YnM2rZYi+4vWnxN
 1ebHf4S1puN0xzQsULhG3rUyV2uIsqBFtlxZ8/r9MwOJ2mvyTXHzHdJBViOalZAUo7VFt3Fb
 aNkR5OR65eTL0ViQiRgFfPDBgkFCSlaxZvc7qSOcrhol160bK87qn0SbYLfplwiXZY/b/+ez
 0zBtIt+uhZJ38HnOLWdda/8kuLX3qhGL5aNz1AeqcE5TW4D8v9ndYeAXFhQI7kbOhr0ruUpA
 udREH98EmVJsADuq0RBcIEkojnme4wVDoFt1EG93YOnqMuif76YGEl3iv9tYcESEeLNruDN6
 LDbE8blkR3151tdg8IkgREJ+dK+q0p9UsGfdd+H7pni6Jjcxz8mjKCx6wAuzvArA0Ciq+Scg
 hfIgoiYQegZjh2vF2lCUzWWatXJoy7IzeAB5LDl/E9vz72cVD8CwQZoEx4PCsHslVpW6A/6U
 NRAz6ShU77jkoYoI4hoGC7qZcwy84mmJqRygFnb8dOjHI1KxqQARAQABzSZUb20gTGVuZGFj
 a3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPsLBmQQTAQoAQwIbIwcLCQgHAwIBBhUIAgkK
 CwQWAgMBAh4BAheAAhkBFiEE3Vil58OMFCw3iBv13v+a5E8wTVMFAmWDAegFCRKq1F8ACgkQ
 3v+a5E8wTVOG3xAAlLuT7f6oj+Wud8dbYCeZhEX6OLfyXpZgvFoxDu62OLGxwVGX3j5SMk0w
 IXiJRjde3pW+Rf1QWi/rbHoaIjbjmSGXvwGw3Gikj/FWb02cqTIOxSdqf7fYJGVzl2dfsAuj
 aW1Aqt61VhuKEoHzIj8hAanlwg2PW+MpB2iQ9F8Z6UShjx1PZ1rVsDAZ6JdJiG1G/UBJGHmV
 kS1G70ZqrqhA/HZ+nHgDoUXNqtZEBc9cZA9OGNWGuP9ao9b+bkyBqnn5Nj+n4jizT0gNMwVQ
 h5ZYwW/T6MjA9cchOEWXxYlcsaBstW7H7RZCjz4vlH4HgGRRIpmgz29Ezg78ffBj2q+eBe01
 7AuNwla7igb0mk2GdwbygunAH1lGA6CTPBlvt4JMBrtretK1a4guruUL9EiFV2xt6ls7/YXP
 3/LJl9iPk8eP44RlNHudPS9sp7BiqdrzkrG1CCMBE67mf1QWaRFTUDPiIIhrazpmEtEjFLqP
 r0P7OC7mH/yWQHvBc1S8n+WoiPjM/HPKRQ4qGX1T2IKW6VJ/f+cccDTzjsrIXTUdW5OSKvCG
 6p1EFFxSHqxTuk3CQ8TSzs0ShaSZnqO1LBU7bMMB1blHy9msrzx7QCLTw6zBfP+TpPANmfVJ
 mHJcT3FRPk+9MrnvCMYmlJ95/5EIuA1nlqezimrwCdc5Y5qGBbbOwU0EVo1liQEQAL7ybY01
 hvEg6pOh2G1Q+/ZWmyii8xhQ0sPjvEXWb5MWvIh7RxD9V5Zv144EtbIABtR0Tws7xDObe7bb
 r9nlSxZPur+JDsFmtywgkd778G0nDt3i7szqzcQPOcR03U7XPDTBJXDpNwVV+L8xvx5gsr2I
 bhiBQd9iX8kap5k3I6wfBSZm1ZgWGQb2mbiuqODPzfzNdKr/MCtxWEsWOAf/ClFcyr+c/Eh2
 +gXgC5Keh2ZIb/xO+1CrTC3Sg9l9Hs5DG3CplCbVKWmaL1y7mdCiSt2b/dXE0K1nJR9ZyRGO
 lfwZw1aFPHT+Ay5p6rZGzadvu7ypBoTwp62R1o456js7CyIg81O61ojiDXLUGxZN/BEYNDC9
 n9q1PyfMrD42LtvOP6ZRtBeSPEH5G/5pIt4FVit0Y4wTrpG7mjBM06kHd6V+pflB8GRxTq5M
 7mzLFjILUl9/BJjzYBzesspbeoT/G7e5JqbiLWXFYOeg6XJ/iOCMLdd9RL46JXYJsBZnjZD8
 Rn6KVO7pqs5J9K/nJDVyCdf8JnYD5Rq6OOmgP/zDnbSUSOZWrHQWQ8v3Ef665jpoXNq+Zyob
 pfbeihuWfBhprWUk0P/m+cnR2qeE4yXYl4qCcWAkRyGRu2zgIwXAOXCHTqy9TW10LGq1+04+
 LmJHwpAABSLtr7Jgh4erWXi9mFoRABEBAAHCwXwEGAEKACYCGwwWIQTdWKXnw4wULDeIG/Xe
 /5rkTzBNUwUCZYMCBQUJEqrUfAAKCRDe/5rkTzBNU7pAD/9MUrEGaaiZkyPSs/5Ax6PNmolD
 h0+Q8Sl4Hwve42Kjky2GYXTjxW8vP9pxtk+OAN5wrbktZb3HE61TyyniPQ5V37jto8mgdslC
 zZsMMm2WIm9hvNEvTk/GW+hEvKmgUS5J6z+R5mXOeP/vX8IJNpiWsc7X1NlJghFq3A6Qas49
 CT81ua7/EujW17odx5XPXyTfpPs+/dq/3eR3tJ06DNxnQfh7FdyveWWpxb/S2IhWRTI+eGVD
 ah54YVJcD6lUdyYB/D4Byu4HVrDtvVGUS1diRUOtDP2dBJybc7sZWaIXotfkUkZDzIM2m95K
 oczeBoBdOQtoHTJsFRqOfC9x4S+zd0hXklViBNQb97ZXoHtOyrGSiUCNXTHmG+4Rs7Oo0Dh1
 UUlukWFxh5vFKSjr4uVuYk7mcx80rAheB9sz7zRWyBfTqCinTrgqG6HndNa0oTcqNI9mDjJr
 NdQdtvYxECabwtPaShqnRIE7HhQPu8Xr9adirnDw1Wruafmyxnn5W3rhJy06etmP0pzL6frN
 y46PmDPicLjX/srgemvLtHoeVRplL9ATAkmQ7yxXc6wBSwf1BYs9gAiwXbU1vMod0AXXRBym
 0qhojoaSdRP5XTShfvOYdDozraaKx5Wx8X+oZvvjbbHhHGPL2seq97fp3nZ9h8TIQXRhO+aY
 vFkWitqCJg==
In-Reply-To: <20240131092952.GCZboTECip8DbWtYtz@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::8) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8fb886-1ab2-49fc-017c-08dc2330910e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rxIaEj5fI3y0OWhFNYwiNUQ+uisyMMEnfRLDCVU63SqXKXEsvkWVobdYIxxf/INT0EIEobJWWHICPNfBoo7C7IQFNDxHlopKqcbanv357TpQB8b+fUC5ji2VCFJtT7twwX6in11RuYWfj/XoxTYqYLI7DKVE7+RXjtCOtVyATBEtlUo6EiIZXlwQuZXhYE2VZNpdWoc1sawToheiXaQO8KzCl0Yg9kAVeuch9cP9CO72QETEVAwvWMtrt0r6hVjzy+qRSNfL1LUXULxw/eaLemSgPVH/7eyhpnTDueXGIeEIlHBKysVfAsqUOrjZY+tQeQ0kBviVZ+gke4qSfJlBxDuY+E2qxj6gpHMkVPKn8b5zHa1D1SQWYGbY7YYKkxBQCbUbyj3xr9S/pXzGtJtrR2HJjYavU8WeA5cIJ0nSN84T2k93R2x7Ps3EsIUCb6Cuz4ZbuXWYo9vGiQZcJw3xbJOga9OKB/QpxAXTqHYU+OaWKNdwQfP+uW9Rv2xoTXxbbpmdsdsmL1pCMYRjqWELAwVJ94V7cq1/+qVOz2ak7VnZM2Esdaio4CLkRLEAXWN/ixGlXk5v6Hdaw01zDMM6Qm9jAaffkumibjPWJY76Hn6DinzFxOjx5a63eKs2JISVCjVo4UF7L4KSPR7SSKlD2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(316002)(8936002)(54906003)(66476007)(110136005)(66556008)(8676002)(4326008)(66946007)(6486002)(478600001)(31696002)(86362001)(7416002)(2906002)(5660300002)(41300700001)(4744005)(36756003)(31686004)(83380400001)(26005)(2616005)(38100700002)(6666004)(6506007)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVRsdHVLbnQ2YlZ2TytyMWFYM3JWKzROZC82MkpLWXF0anJad3hObzM1U29V?=
 =?utf-8?B?SmphMmovTnZsT0lQZXFwcW9YQXh4VldZZDNHS2xhYk05NmUraDFrT3lGVFdh?=
 =?utf-8?B?MW9SVmFjeUc0UnVNZXVRSFVxRklmSjQwRk96ZXFpeE12azUrQ1JnckN3UEZQ?=
 =?utf-8?B?YmV6WXh3eGl5UmhvUWRPUko4d0JQY0JVWWpOUUhLYys2Wm5lbys5d0R4L0tQ?=
 =?utf-8?B?RFVoU2N1Nkd0QXJIQ2VrZ2RSc1ZBVlM0NXdHbmRwWGgxbUdjVzZ3QjNxa0RW?=
 =?utf-8?B?Yi9lUzROaFgrc0tiWms2bDBqeXoxMyt2Si9LNXZ6aW1KYlh2SFJ0SHVicGVX?=
 =?utf-8?B?UXNCajdEbUkvTlloMVkxY0FlZHAra3NvQlNMQ2IvNTZIVEVwMGo2WUVsYTQ4?=
 =?utf-8?B?QlRNVE9UUk40eWpkaEtxdlUzSjJ4azBLUjhwT1liTUhia0pRcVJqRWRtYStF?=
 =?utf-8?B?NElLSmhhWnUyVmpTbFFtQlJuZEFRbHErVE1laHhZeFpyZHBsdGhVREZIQ09S?=
 =?utf-8?B?aGdzcHdpcTRORXBaSW53Z3JpMkRwN0Z6cWNMWWxjUHYxblZ3blFWQ2tkdDNv?=
 =?utf-8?B?dWpEdHFQT3AxYXJKU0dFTHQyRURKcWEvallRVUIwZzRoaVNUeTZic0ZOaVlv?=
 =?utf-8?B?ZE5Gd2pESGtFd29PaVFjSFZtU3k2TStVSXRDZkZpMUlSNkVqRHRkUGE3MEdG?=
 =?utf-8?B?SFFXVkRYLzU4V3BEcDlsc0pPMi81NnNBdVg0dUJOaCtFUTFkcDQyc0xjd1ZZ?=
 =?utf-8?B?dEMybmRvek9tRTlqYURJTzlWQjZla1FocnNKQVo4b0ZFUjlDUERYRDkzV0xW?=
 =?utf-8?B?LzY4SkVGRU0vQW1sdXlITmtha2ZpUXVOWUE3UzliNmp2QzB0eTB5WWV5ZVZU?=
 =?utf-8?B?ZUNaMWgxTWFFRHNFVWNUL3ZQemFScjZ5Y2tsdUNqSUdBMGhaUWFRczN6Sloz?=
 =?utf-8?B?MGU5cGNYbmJta1ZuSjdnYmc5NExsclExdlNiVHZSZ1ExS0lpUjFVeUt3MWRX?=
 =?utf-8?B?ZlZTdDFnd3dzNVV3Q2RJVUZXSUYwK0E4M0pXQ290STJVdWxsL0pDNkJDU3Av?=
 =?utf-8?B?WHRURzlCU0FSQk11RVJ4SkUwSXZwNzJ1WStGWWphcGFhK05mMm1xWUZIYjRY?=
 =?utf-8?B?Y1phRHdIK1RPUElMNkxGcFMzS0g4Wnd2MXJBZHIwNlpvNndJUldORi9ZVFhu?=
 =?utf-8?B?TVlPeG96RHJmVEdocTJyYzVvZ2s0Z2Z3bWJlTy9IdWFWazdrRDVxeEFVTWlM?=
 =?utf-8?B?N2JhY0JXRUxFcFRkaHZtdVpxOW1ZVWhibExTRkk1Q2NqTHBEVUN1OTQxY0NH?=
 =?utf-8?B?dWZiUElVcTZXRi81cW1JMmF1Sm80SlNuUG5WVW9tZkpqN2dkdHJ4SHgwNmRj?=
 =?utf-8?B?TGNWQXVYQkhhNnlPK0dMMDkwYTVscmJvRlZyOEs5QU92dGh1UGMxN2lNWFBt?=
 =?utf-8?B?ODgveHBFQjdRWlMvVHZwUEhnVG1NZGdpaEowbWZmTStkSW13Z2Z4RXQvS1h6?=
 =?utf-8?B?TXEyTCtVNk5oU3NBUG1ORExrTGxoUjdlMyt2ZVFiMVVabDJvSG5GazcxRHlo?=
 =?utf-8?B?WGZNTG5lOGxhYU53VVFjbFlVbFhpNW16akVJanhVN0pXM1BobE9CTGtFTHNY?=
 =?utf-8?B?WEhlVjlDVSt1N3JleFhQSFFXelBwV2RYYkptNmJwM0g3cnJ3MHNzZVZ2dXk4?=
 =?utf-8?B?SWdrdjFOOUdhSlNNUFpoQzBwVkdTRjU0N0c0MDgrVkl2cU1GYjZjVW9uZVdR?=
 =?utf-8?B?c3g3SDN3V3RjbzhJY09YMGV4d0lQU20zVE9rakdHUGFWSXJVUjRSZU9LZE52?=
 =?utf-8?B?cTExWDZYSVVVcEw2SmVMM1VFa0NPTmpTNmhya293b29zSU5NY0pxcTNTbEtE?=
 =?utf-8?B?U0NvWU4zSTZaYVFsa3V1eWQrSjNhZ3JlTXY5RnNnYlRkTXc0RDNUSS81K0JK?=
 =?utf-8?B?cVhsSG1sOStXZVkwUjhwcVRPcWRQMGxlc05TZnFNMC92cDFDYkJmSzdveWJI?=
 =?utf-8?B?aWIxajVSSnVBL3JRS3pEUEllL0dLYTZkaENUMHNTR0pOU3Y0LzNKSkpSVlV0?=
 =?utf-8?B?Zy9FMXh0SGI5RU9zeSsvWjcyQTFoWEtWNkNrbHNXdkN6MlBjWk5KVjQzeUNr?=
 =?utf-8?Q?TIF53UoAuCjDKAN799PTdb/DA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8fb886-1ab2-49fc-017c-08dc2330910e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 14:17:48.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIfYgVWXQFklxchb4cy3tJTLGITCTG6I4DxfsFLL3ikpj4wv0BhiWOblw9elIdfia0I/17OK4PzRNdEEaIy7dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515

On 1/31/24 03:29, Borislav Petkov wrote:
> On Wed, Jan 31, 2024 at 10:12:13AM +0100, Ard Biesheuvel wrote:
>> The reason we need two flags is because there is no default value to
>> use when the command line param is absent.
> 
> I think absent means memory encryption disabled like with every other
> option which is not present...
> 
>> There is CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT but that one is AMD
> 
> ... yes, and I'm thinking that it is time we kill this. I don't think
> anything uses it. It was meant well at the time.
> 
> Let's wait for Tom to wake up first, though, as he might have some
> objections...

I don't know if anyone is using the AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT 
config option, but I don't have an issue removing it.

Thanks,
Tom

> 
> Thx.
> 

