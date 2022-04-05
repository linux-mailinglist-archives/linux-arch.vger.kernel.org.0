Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648A94F4288
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 23:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbiDEPEC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 11:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389094AbiDEOnP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 10:43:15 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6457217A8F;
        Tue,  5 Apr 2022 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1649164855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nPT7jC9A8CnrEzqW+VbdWOaZNZqFgP7wrgukoekQr6M=;
  b=JAyu9rw6psUdUsiAx2rWk55CAoYk1LQ9XY+donamFvXj1BxqrSOU+uZd
   q5jyJWXU4cLRI0rGzvN9wzm9Cb/Sh2NeVQGyhWdlgbsyvHTn4jPZyICm8
   F9b+uqdaPMpvcoSHC/rFBAXPY5qjA7WCT5ZssSVW5crO0UtizqjHY72bF
   Q=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 68060920
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:jjvDC6pIpgZy9Yumua1b/EFNA2BeBmLRYhIvgKrLsJaIsI4StFCzt
 garIBmCOa7bYTT1Loojb4u+/RwOvsLQmoNhQVM6+Ss3FygX8puZCYyVIHmrMnLJJKUvbq7GA
 +byyDXkBJppJpMJjk71atANlVEliefQAOCU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvR4
 Y6q+aUzBXf+s9JKGjNMg068gEsHUMTa4Fv0aXRnOJinFHeH/5UkJMp3yZOZdhMUcaENdgKOf
 M7RzanRw4/s10xF5uVJMFrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKv+Zvrgc91Zk
 b1wWZKMpQgBIfzcld9DURRkHX9DN4hM0afiESWimJnGp6HGWyOEL/RGCUg3OcsT+/ptAHEI/
 vsdQNwPRknd3aTsmuv9E7QywJR4RCXoFNp3VnVI5DfVF/s5B7vERL3H/4Rw1zYsnMFeW/3ZY
 qL1bBIxPEyeO0wVYj/7Dro8l8y3gWLBbwFZ8lCJhas2oDPUyzR+he2F3N39JYXRGJQ9clyjj
 m3N9Ez2CRpcO9qCjz2f/RqEgu7JgDO+UZgZFJWm+fNwxl6e3GoeDFsRT1TTiea4jkqWWN9FL
 UEQvC00osAa/0W3R938WVu9qWSFuBcHc9NKFqsx7wTl4q/d+Q2QAEABRyRKYdpgr9NebT4nz
 FKMjpXtBDpzt7u9QGiYsLyTqFuaPSkTMH9HZiIeSwYBy8fsrZt1jR/VSNtnVqmvgbXdHTD23
 iDPpTI7wrYel8gG042//EvbmHStoJbTRwI47wmRWXiqhit8bZyNZIGy71Xfq/FaI+6xR0ONt
 lAHltKY4eRICouC/ASVQeMWH7Cgz/mAOTzYx1VoGvEJ8j23+Di5YJxU6TdyDE5zN4APfjqBS
 FfepQ5L9rdSOnWwZKN6ao73DN4lpYD7B93vUfTfdZxIa5dgXAad+WdlYkv493C9zmAvnLs5N
 JPddtyjZV4dEalhwD+8b+gY2L4vgCs5wAv7S9b1xhWh3L6aZVaaTL4ENB2FaeVR0U+fiFyLq
 ZAFbZLMkkgBFr2lCsXKzWINBU9bPXUAW5L7l8IJS+SmKCN+PVF8FtaElNvNZLdZt6hSk+7J+
 FS0VUlZ1EfziBX7FOmaVpxwQOixBMgi9BrXKQRpZA/1gCZ7Pe5D+Y9FL/MKka8bGPuPJBKeZ
 90MYI2+D/tGUVwrEBxNPMCm/OSOmPlG7D9i3hZJghBiJPaMpCSTo7cImzcDEgFUU0JbUuNk/
 tWdOvvzG8ZreuibJJ++hAiT512wp2MBv+l5QlHFJNJeEG21rtQ7c3ap0qJreJ1QQfkm+td8/
 1zLafv/jbOTy7LZDfGT3fzUx2tXO7UW8rVm85nzsu/taHiyEpuLyo5cSueYFQ0xp0uvkJhOk
 d59lqmmWNVexQ4im9MlT95DkPJvj/Oy9uQy5lk1Qx32g6GDV+oIzo+uhpIU6MWgB9Zx5GOLZ
 6540oIDY+/UZ5q5TgV5ychMRr3r6Mz4UwL6tJwdCE77+DV27PyAV0BTNAOLkytTMP1+N4ZN/
 AvrkJd+B9CX4vbyDuu7sw==
IronPort-HdrOrdr: A9a23:Ii12Wa70elhEQN21kwPXwM3XdLJyesId70hD6qkRc20yTiX2rb
 HLoB1273/JYU8qOU3I+urwX5VoI0m3yXcd2+B4VotKOjOW21dAR7sSiLcKrQeQeREWwdQx6U
 6wScZD4IyZNzdHZZiT2mWFL+o=
X-IronPort-AV: E=Sophos;i="5.90,236,1643691600"; 
   d="scan'208";a="68060920"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pamac/+AlWoYf7PeWGWgWsbFNqmRJnwau+2iD6DZa3r/udIZuSQ8NWuL7SEE8NqGAWV/hpObgHPtoaMan06HVmLwVFEPktWgRlQe18PGJKxpp7861FKAZfCySQqH29s1TzKrCLhPoZZgDraYpOs6AeygQYS4MwH6mtBxVYzzr+5c75hMAp/cRcFv5PIuSEdXY84dv0iCr4d80yNmjN62/Hk/W576GgbfkEGthGShSt8NX0T5K4fCoBA0xgiEU494MsvIRAiZErf5wduZzp1ccNeblXKaR/I7VogRnuvlKxx4mzbNmRvozLo0TpNCEVv+Qy9HFZpDvhZvzv9Re/xl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPT7jC9A8CnrEzqW+VbdWOaZNZqFgP7wrgukoekQr6M=;
 b=BqC1wTjkP4fIWHktHigC4t6Yus9ai249r9jZ7dUh8tDxwHGPbEp3Cn17umKYKtbBuft6E0+ANdbrvDt1mTRPW73ecWLCs0XCD7zB0byU41XgSHN5KFsb6nhWgN/SzM5lMKM2iEaXKAgiZocuWVwaXC/jIhRD0XBXXbEPhssLrV0pJLOJxZpiea+B9DoDuparpuU//lwgWTi0ImR7qIZL+N//DB9EI5byUb7A4z/nYZBb9sTchmy8DLxgPDnm8SxI5BaeBEjUhPqfbqs30WB31QHVyqZFWNmYhyHjS3PzZBAOen5WAmO+9rkOOOyN5I/n5Bp8dv/oUDif+1hV+3naIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPT7jC9A8CnrEzqW+VbdWOaZNZqFgP7wrgukoekQr6M=;
 b=F842tLFqgx9NNPXgUDgWGebuCIUKMTXGqpeXBSnwCxBiFHdxZOuOljreXgNEmXsnIIKxq0i28WZEJaPFyhXV44xJ2OV0ld8OBGNy4EuXVnOtJTanFv+e5IurlBolh05/coOB//wo9V/C88uSq29V1aMSTKt6nJChlVRwzhvXKwc=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "maz@kernel.org" <maz@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "opendmb@gmail.com" <opendmb@gmail.com>,
        "Andrew Pinski" <pinskia@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: GCC 12 miscompilation of volatile asm (was: Re: [PATCH] arm64/io:
 Remind compiler that there is a memory side effect)
Thread-Topic: GCC 12 miscompilation of volatile asm (was: Re: [PATCH]
 arm64/io: Remind compiler that there is a memory side effect)
Thread-Index: AQHYSOvqbmoChfXhzEOrs+lafwM0eqzhSZmAgAAEfYA=
Date:   Tue, 5 Apr 2022 13:20:50 +0000
Message-ID: <7988e82a-8494-a954-0a79-7f86d34a96ad@citrix.com>
References: <20220401164406.61583-1-jeremy.linton@arm.com>
 <Ykc0xrLv391/jdJj@FVFF77S0Q05N> <Ykw7UnlTnx63z/Ca@FVFF77S0Q05N>
 <Ykw+bVS9WY/JfoYO@FVFF77S0Q05N>
In-Reply-To: <Ykw+bVS9WY/JfoYO@FVFF77S0Q05N>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45d46dfc-06c3-40a8-f672-08da17071ad5
x-ms-traffictypediagnostic: DM5PR03MB2842:EE_
x-microsoft-antispam-prvs: <DM5PR03MB2842EEE373750B8E22E84254BAE49@DM5PR03MB2842.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rUytiTGyOBCBsz/lFKJNY/RKiPSZk/ee5KAkzKO3EFR1KCsqSoWdvwkp7V6O+2XPcVLg2ANvF1ENdk095QnfGZVnsOcHXuLQ0ghxAz7QkiCbpBn032un3MZQAL8vs6LATj4TFdx4cTjNVBzj88XHT5QR0eUv2jvfS8jn5Lo/cviDKs9KiXN3DKgXbfXBG2prjv7eF6sJQeKy8EO3Tjkej+Os3Wnl7VdO1vxAiKQwAMBHie4nwgiSdILcz000g3qW5gn+i5NMBeb7JfGYk3JlYrxUwBz9kEXUjEHheW4fFcuS7uk/ytWgzJLCdzvupMcQ6nFx2gTlpao8tA7Pbsz92jnxmGWE2Qka8H13mrH8ZuD7leL53AaJVtY/BU0riYuZY8qsbrV/i0mMOo792EHIfF3RrHQzKvvvOodtq1uKJvolov/d2MYKjpnw6U/Xv0Vbe9jpgWRny1edz2V9/7gjqb1WNRakWRn184e2CoY8qJ44VFaje55DQUlH4IJA35G3mJGlMD00JCII0e3ykp/eUqa+KxEl5cKjepDxcl2tmmgoZjepq4u42uuxvDGvAV8I2E44wpfzUhZNIU1Fy1jPG5fzNcTBUT+Pc2mNHdaEyBBhcLc3tzHsdiNDiERbk0PRsf/+d4lHnvtf5QLd8Lvbdfv0uNBkD3BuiA9Nbk43qhEIrgF2wycnn0XF/vmarcrxHOFI9gat1OmuBfVb2jP3LhwPknJ4/ik0XE64myLaVQQwKUSfvipe7dvUh9vuEpTv7EyolIMsTgbpD8Vchyz2SPqR6UjXI3dr7vJsJkQ1nEgN8wsgw3sNDNUQwWdVcstHTzhqxAdp5EyDhcVS5/uumxmjHD4/bpmoAEvn+fvZyms=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(31686004)(6486002)(2906002)(86362001)(31696002)(5660300002)(6506007)(38070700005)(54906003)(53546011)(4326008)(82960400001)(8676002)(508600001)(64756008)(36756003)(6512007)(122000001)(316002)(2616005)(4744005)(66476007)(66446008)(186003)(26005)(76116006)(66556008)(7416002)(91956017)(110136005)(66946007)(8936002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE1va2Vra1NTMG9WeFh0aVdJVkNMTWsxZ0U0SHEwUmdiU2ZOSXEvdFpua001?=
 =?utf-8?B?MzN6YUcrL2F4RndNbE5FVitrcVdYd2Z0SzMrTEdQV3FKcUVQcVNUaS9jSXdI?=
 =?utf-8?B?ZG03WDBuZlZWK0xCSU51ZitpQmY5d2NEcStVNkVqSTBPR3QrZm5SRUtDNEZs?=
 =?utf-8?B?Z2MyN005RFB2Uk5TQVVBbzA0Q2ExOWh0bXRVVWpZcFhCVlJhSUdTWHEyNno4?=
 =?utf-8?B?NkV2TXo4NXlqVWZ0NlNXTGM3QUlJNm9HOFRVUDRWdHhUcm9CcEZmMERsbCtB?=
 =?utf-8?B?REk5MW41Q1lLM0xkTzV5aHlzd0ZkVk82NmVERWlES2RrQUszS0k3Qm1YRGZN?=
 =?utf-8?B?UGFkNFVVUHgzc25jNkUvWUhTTWtKRVc1aGNRY0x6YVNZbmplOXBmY3ZCdTI5?=
 =?utf-8?B?MjlXSUJKeDRicWdaL2gxRkYrbmhyRUpxRGtFaEJYdkNHalNmWlhJVlhiYmFz?=
 =?utf-8?B?U25zMXF2amUyeHcvNXYvTm0xb2kyMDFEZmlaVEFzSFQxeS9vUEpyV0xpeEVo?=
 =?utf-8?B?VkZmT0hGeE81Y1hJV0lub1lIdGxIV0ZNeDVsWWJ0SUFoQ0kwTGFvUEhQUjA0?=
 =?utf-8?B?ajVVeG81OUY4bzJQZ3Uyc3ZaSThVY3JXVzV2emNZRXRyNHZCektzQUU1SkdL?=
 =?utf-8?B?bDdPempVdkR3MUpvOHdMQU1tNVkyMTJWMVY1ZDNBTk5wMHZkMFQ4aERJZmRy?=
 =?utf-8?B?azhjbjB5bjg3MENzTlhRU0lYb2E2ZnNBSVUyTVloWDdHNEtIUGJRTC9WTExD?=
 =?utf-8?B?ckc4enA1dWFoZVRMMW9BM0JEei9RM3JFSW9WK1FCWDEzNncxZ1kwazdyQ0lo?=
 =?utf-8?B?Z3ljSTJLNmJQRCtOUGdkZFl1eS9UMWVsMVNXdGV4OENJSXpKVEMzWUYweGUr?=
 =?utf-8?B?S0lqbTNtLzB5bXFCYlBYZ0RMV1JUWXZ5TkNpcklhWVNObkMwQ1dFZ3Q0RE5H?=
 =?utf-8?B?dHdxZ1dQSHBBTXNYeGpoR2RoclJBVFplbms5M3A2cGFocTNJVlVpTmRBR0xP?=
 =?utf-8?B?MjVuOW0wRmJGaDUvQUUzZXN4UjBTUVowSzA3aVVsNDFNamsrYlNHQ0tSU2xR?=
 =?utf-8?B?WEJVd1dGb0ZtT3RUOEwwN0hrSk1ZNGR3V2hzbml3cmdCWXJEYTM1ZmIzZmFv?=
 =?utf-8?B?aEQzZmxES3lld2RDdlRTMWw5Z29pREJFbmFDNVdZejhuZ0RqRmtxc1Vqb29O?=
 =?utf-8?B?TnpDYStKOEh1TkZJUjBVczNudnR4UEdXTnRzMHlDNlh5S1lJWXFsUTIyT3li?=
 =?utf-8?B?L2hYTkxFTTdXbmNGRmNod2YwS0ZuQlZwV2dkZVhBdFJ3UHlGNGhkZG15blFt?=
 =?utf-8?B?RjRWZzVNeWF1bjdVdTZpNHRMYk9tUjdCM1k1QVBBaGtzejdlUzR5VnBxZk5m?=
 =?utf-8?B?V3BaSEdMUzZlV3RVRFRHenBIUnZrM2tJQnAyYjNWRGV1cDJPOEpPOFFtMDdY?=
 =?utf-8?B?K2FvMFFwOFdRMitubVlZSGdIZUFzVEVWbGF3VlRUb01BNnlrNzJCNGtCektI?=
 =?utf-8?B?OWpXaTlTWUUrdEVTU0tBZ3BIMS9WS1FkWkVpdVZncU53ZXhCODVsYXhJRHc2?=
 =?utf-8?B?U2FHdDRqSWx5ckV3bkFTdnBsa2g5RnRUNVQ5bkZpWmxLekN6cmNKZUNTdmhq?=
 =?utf-8?B?Z0daZG9haFBrM0xVMFVudTdlSDZUcy8yOHpJVm9aOFFhUE0xVHIzUUNhdXhG?=
 =?utf-8?B?WXdkMi91aHFzLzV4MG1oMUJjZmdzUlA3UUg5aW41aVJMc2FOdjRHZnJSUEJY?=
 =?utf-8?B?Tm40d1NocEh4S0lCSDBOVW5ERmR3RXBuRVBDSFUwc0J4eXBGa1lxR3hPL2p5?=
 =?utf-8?B?MFgybHVqc0RHQVJIbC9hZGJjZTV0bjZvL0M2ZzZUNWJQc21jdmh6emxlbWNW?=
 =?utf-8?B?aGxOTis3QUhyQzVjVFhIMVFvbU52bTBQc1JQV3FMUWZBWWdrQ3kzenRDRFFP?=
 =?utf-8?B?QjMyV2wvZ2xtVDVCRHBuVFJKd1orTEpBN2RXRW1JQ3dwUUc4WXY1RDIrcWdE?=
 =?utf-8?B?UTYzdUVodVlTTFhoZHVMb0J0dVdVbkNqbDNPMWJhWXZaUDNrWnpvQ0VJNTcw?=
 =?utf-8?B?cWpsL3QvVXRxbkNQcFpuWlgvOUoxSTBjeFdsdVlKa3NGWXhrS1cwbUlUdFcw?=
 =?utf-8?B?NW5sQ0FJdC9odTBpclJmNWlESTF2c09MMHhyU1NML2IzN1hkU0hpa09ua1k3?=
 =?utf-8?B?MzI2VllWTFFucXZJUHZJWDFpTFNzWWUwMUwzWmpuZ3Z4Um9rYlVHUXByTEJF?=
 =?utf-8?B?WktHbkJMbDZtL09adHZ4Y3VLTlRaYjVvckFWMmlSL1QzdjZYeUVDWS9ETE5s?=
 =?utf-8?B?eFplZElIeGV5ZEd0aUdPUUlBeGFOYlRPck51dzVIcys2SmNMTUs1S2pmL2Zp?=
 =?utf-8?Q?eLH5Cr2HmQcAh1zw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D6B5437B626AE438314D0415891CE3F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d46dfc-06c3-40a8-f672-08da17071ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 13:20:50.7848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CjMWXvMP6Ki99Q/Z5+2pF5L3+WL+EywQvlqCh93it+Hl4whj38pqEGBBj1v/YlCWrnqJDCeEDUw8E/cNW9M+mCg95V8xTqoE3YS+6dlRag8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2842
X-OriginatorOrg: citrix.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDUvMDQvMjAyMiAxNDowNCwgTWFyayBSdXRsYW5kIHdyb3RlOg0KPiBPbiBUdWUsIEFwciAw
NSwgMjAyMiBhdCAwMTo1MTozMFBNICswMTAwLCBNYXJrIFJ1dGxhbmQgd3JvdGU6DQo+IE15IHg4
Nl82NCB0ZXN0IGNhc2UgaXM6DQo+DQo+IFBlciBjb21waWxlciBleHBsb3JlciAoaHR0cHM6Ly9n
b2Rib2x0Lm9yZy96L2N2ZWZmOWhxNSkgR0NDIHRydW5rIGN1cnJlbnRseQ0KPiBjb21waWxlcyB0
aGlzIGFzOg0KPg0KPiB8IG1zcl9ybXdfc2V0X2JpdHM6DQo+IHwgICAgICAgICBtb3YgICAgIHJj
eCwgcmRpDQo+IHwgICAgICAgICByZG1zcg0KPiB8ICAgICAgICAgc2FsICAgICByZHgsIDMyDQo+
IHwgICAgICAgICBtb3YgICAgIGVheCwgZWF4DQo+IHwgICAgICAgICBvciAgICAgIHJheCwgcnNp
DQo+IHwgICAgICAgICBvciAgICAgIHJheCwgcmR4DQo+IHwgICAgICAgICBtb3YgICAgIHJkeCwg
cmF4DQo+IHwgICAgICAgICBzaHIgICAgIHJkeCwgMzINCj4gfCAgICAgICAgIHdybXNyDQo+IHwg
ICAgICAgICByZXQNCj4gfCBmdW5jX3dpdGhfbXNyX3NpZGVfZWZmZWN0czoNCj4gfCAgICAgICAg
IHJldA0KPg0KDQpZZWFoLi4uIHRoYXQgY29kZSBnZW4gaXMgdmVyeSBicm9rZW4gZm9yIGZ1bmNf
d2l0aF9tc3Jfc2lkZV9lZmZlY3RzKCkuDQoNCn5BbmRyZXcNCg==
