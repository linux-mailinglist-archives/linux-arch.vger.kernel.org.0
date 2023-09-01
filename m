Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2378F8AF
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 08:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348387AbjIAGpd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Sep 2023 02:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbjIAGpc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2023 02:45:32 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD9410D1;
        Thu, 31 Aug 2023 23:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0ePXFkBGtlfJUAyvPUBKJiQ8Kml58OkUgPLXV5FZQ85Hdf15gC5yxIYdMaMJlEOMuR/AtoGlUtDr9n0E5jU2HZOU6zvKdGKdF3DJl/FGCmyKx5W9KIqkgndhIoNBN3Y+YW4Z0pkNuxzkMScMaErChskizDIFK47vIJu1maZqlW/Mrw8wDYinA9bouxwTt5l6xwvfh80iY0iSATB3Qk6ekV61YtsjzaO/wkKLtWtSP4PRJ8ivVxl/XUDrRYdLw5NfVtNYHWBv6kFBlqBbgvtWSAC7RydOM86otVbcQylfGNMVqAbPzf8uHs6YeWhgY/PyzkTXRtqEFhCh+ciz2J7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu5gbz8EepPvyYZOA0lKAGjgfVOKdIY5V+fEfmutbyw=;
 b=Vs77WxL0YYlHLwFYr+6gVmVe/Jg8E6JpTNPOcMwlQWiufVfLyHRPwljP7I2VgDTGS8poUdlGPPefoTZQwQfoGBoCTbxPtpfg00f0jgxmK4rDeqqrhyZnMBHVjHDh/nFptVFn3EMe4xVGK4NX3sgvDmQR0T9dF4GVJHHUbDUO1kE587wYMXrPumxsnJjD7OleoYocj4TdynTf+qnqidEYPLpzUfhmZhF1/fwJFKpyZMFt2zknhB0wbvg5EioCZbcfTg0TZYcM41LWBO5nCTk9+WMXAUtIOzWbAK6aOUVXXNGwCt0N1mST60tYbUuFiAsboEsOcQlVCi0GI3wW33Gw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu5gbz8EepPvyYZOA0lKAGjgfVOKdIY5V+fEfmutbyw=;
 b=26KBid15o5S/RCVR3V96/hiEIwRFXTX8ro6s6ngwUmtjwSZNS7+dlillLSqX85AESihLIkmK+VmvkxVCKspda32qHVG7PaH1E5d7iSQpW1hbeN/cqeo62H9maV7CxaihQm1qadckefsK6t3gPIQxzKrUq9wvhl5fy9OuU/rmmaEz5gwwLcuy3L6ZIi52pLwjyRqnmaRJjIinoWahalCQ06iSvi+YBvlxF/gra0b5nWSGP0Jybr6jxi3llr8PK7UeZXm0Dv8flxv2EKI43KbE7D7kPmGMFtKGn7I4bKVL0kYRpc2tZQD8hXAmd7PqmQoLV5B9H7PRH/r+t6MzeZOODA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU0PR04MB9564.eurprd04.prod.outlook.com (2603:10a6:10:316::14)
 by AM9PR04MB8161.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 06:45:25 +0000
Received: from DU0PR04MB9564.eurprd04.prod.outlook.com
 ([fe80::a818:c656:57a0:cc6b]) by DU0PR04MB9564.eurprd04.prod.outlook.com
 ([fe80::a818:c656:57a0:cc6b%5]) with mapi id 15.20.6745.021; Fri, 1 Sep 2023
 06:45:25 +0000
Message-ID: <dde4c21b-c5e1-722e-5629-87bfbf8d9c24@suse.com>
Date:   Fri, 1 Sep 2023 08:45:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Framebuffer mmap on PowerPC
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <5501ba80-bdb0-6344-16b0-0466a950f82c@suse.com>
 <aea5e33a-1251-3188-6222-719fe9358762@csgroup.eu>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.com>
In-Reply-To: <aea5e33a-1251-3188-6222-719fe9358762@csgroup.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------OTupODJeWMXfDUq5N2tA8wKw"
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To DU0PR04MB9564.eurprd04.prod.outlook.com
 (2603:10a6:10:316::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9564:EE_|AM9PR04MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 869c3b6e-9ef2-430c-85fd-08dbaab705b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfo3yUrO+CVhaGSHOcVgX7ZfbCtOOw1fp3yKvVjhVxKtxRrGz9YBm/a5yEa/C/Y6T5jaBUXhd4TCAsBHwGvd4EoSzCjQwMoSaqg3CMiRJa1iUQ0fFkz9CzuJJBDvFaJRqnm/sEDb9tghSW5Z02vl3i8PDWGvmHddmbSL8O/e8goWyDwIbP9/V4WBv5UwckN7htFo4SmcpBDb+ZcmmqXQl0E7mHFevbKuTw5eIZrKVoFDCGL5mWYnTZW8CaLZDogoK0mEYTvYxQXC3GXbMZIhw1nlF/BqTyh2N7LXVHwXOVzvJjzkalWG8cEZayFVC26JR2+ibQCCZGxJFZabwsOKZpbwVNPhULNchrOaVgI5q5DSHcDZxRaqgcALOHdJfwje7d62PH8VpnDQSWfenQG3jp9OaaApnfqlAZBHVNcWA6b1JMHLlEalkO6EXOFCXcx4HSyhTnKcMu0KSLnHLsquymNl6Jm4JkSa76LWQ2v2lOEKfI4U2URkXzoEaWqS44PVoKuwak20QRkJVQlv42uNfn8Wo6Hxlt2+z1whcRbfGaxmslMfy0P8NlbApWdh/R5M+S9I+JyXrruTq5ETQDjJuYhtwRE0aSAZ95QbI+jm0FDiZDPHIa6wAto9clp2xa6Q1tvKUFBNUC768WF9zBsdvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9564.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199024)(1800799009)(186009)(6486002)(33964004)(6506007)(6666004)(6512007)(966005)(478600001)(83380400001)(21480400003)(66574015)(2616005)(2906002)(235185007)(54906003)(66476007)(66556008)(316002)(41300700001)(66946007)(110136005)(5660300002)(4326008)(8676002)(8936002)(36756003)(3480700007)(31696002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWtVSkhiNG9UMGZCdGRnSjFVVkRyeWgxOEdMb1RFV0VaanduWE9yckxGVEFE?=
 =?utf-8?B?dHc3MmlyRXV4NnVyRDQvcEpGL013TlRpc3NhSzJpZUZIai81Z1RYcURMVTdJ?=
 =?utf-8?B?THpHS29ld3FTc3NzRzBjNHlCaUduSFMvd1oxMzBhREtJcDlXYXpweFZQNEti?=
 =?utf-8?B?UGpaNXdpTWlqaDh2WjFFamtkSitsbGNkUkhHcTlPc09USHlFa3FkQm5wOG9E?=
 =?utf-8?B?aHppOEVTcVNtaUsrVTVOWG82dDVaSHlLUEprak1DTGdvTjg0L1BEQWMrQ2d1?=
 =?utf-8?B?RjZXMUVZN25JeFpKaFhiYk5jMlVPV0NhcU5jOTdzRGh2aDM0ZjV3RCtZbnlv?=
 =?utf-8?B?NitKY29OTXB4MlU0RVJiSDBTWU1JOG5Gejk4MmI2VUNVMFNpcHhnK1NDQm9w?=
 =?utf-8?B?aFk5N3BkbjltNHkzZm1JcmRHTUdiUXYwTmFqZ0FCVGV2c0pqNU5BYlhNbEFn?=
 =?utf-8?B?b2RlWE9BaHpVUUZhZzhUd0xwOXhyS2dpYTdrZGNHSkxKQ214Y28zc0lIdDFE?=
 =?utf-8?B?enR5YTFURVh5L0xyM21VR2RaaUVwenl0T3poUVprekdOV295UytmS3NnNDRS?=
 =?utf-8?B?RjFKVTJGb1ZPcE5rTWY2OFp5a1BvbGx1TEU0SS9kMm1ZaDIrWlFCZklkRkh1?=
 =?utf-8?B?NzZRcHBXWGJIZmUxdXZBQjB6YXVVd2JCN3A1NWM1WkFNTUZ1TUZqTWw5c1ZH?=
 =?utf-8?B?cXh1QlJlZ3JCTlJaQnZ4UnFWVlRqLy82blpjSTZ6elY2VUs4cXNEbnp0QkRO?=
 =?utf-8?B?dCswa1ZhYVlQUlg3a2dIamhNME5yZUxSSUljcmVoZDYzZWVwb2l0SEEvSUs2?=
 =?utf-8?B?bnJSd1ZvNHNpaEd0dzZ3N0FrNlNwVlF2SXYycDdVRHZHa2d2SVJWQlMveTlK?=
 =?utf-8?B?Yzh6OWcvdVAwWXNQUXVpOFFlSEF1blFiWEVBS0syQk1Xdi9TL3Vib1QyZmJO?=
 =?utf-8?B?b2R2djhIRmVIM0hLbE0renRnZXFCMzVHMkRCVnR1Q0Y1dXBSZWZMUUlxNzBn?=
 =?utf-8?B?ME10RE5jYi9CUGt0RjVIcEE2WjJTa2tPU3BscytnVnNVaFUwL0t3TnFrU2tB?=
 =?utf-8?B?bVRQN1RzSEtvbk9OL0R4SFdFM01heTlQWUdrVklCa3BKSlpEZXltcTV1amM2?=
 =?utf-8?B?Vm9BV0dnV0FUblNacW1vK0I2L3dGV2kxbVFJV1A3aVk2cnZiMFRkUUxiSGgr?=
 =?utf-8?B?Nk9COTFxS0V0Q2x4VGVUaHhTMVdya3NsVDZJWGM1Yy9SekJOS0pDR2ZRZ2R4?=
 =?utf-8?B?YjZzN0FId1RxNFBtZmc4SWUrOVorYVU4dkNxaElrVU9rKzF4WCtZd3VFODgv?=
 =?utf-8?B?NTdRa0R3ZTh4TWdtNkRRUjVuYmZ5cW1LT3pueFhNRzc4T3Naa3FvVkN6N2Ix?=
 =?utf-8?B?Z1ZDeGpuT2hqa1NlTUM5OU1objRjanhHSGpVMkF6TTVkekxpZXowdjgvcXlZ?=
 =?utf-8?B?ZndERUQ5am8yOTV3U0l4UEJtLzhhWlR2MWNOd25HN3Q3dWRyRTBLWGhVUEcz?=
 =?utf-8?B?L0N6emhuajVpelhBK1Jrd09NaUp0K1gxWWl6MnE2bUxCaS9tUFFRMlVENXl2?=
 =?utf-8?B?eElSMXVRT0NSQWtXdHRqS1k2Q0F1eGdqSExMSG1ibzFhVDl4M2FKUEpzMFZI?=
 =?utf-8?B?SHgwNkxjZGhWUkdDdTNZYi9HRGJsNlVucWtSUG1wcVRYS2pxd3RKL0ZwVGo4?=
 =?utf-8?B?RDE3UU03NnprNTF5bXNNcGx0d0MrMU4veWhFZGtaVVZ2MUY5Sm1wbHdJaWly?=
 =?utf-8?B?TjBGSHJXODhWUGoxSE12TWF3bUh5UzJKTUx3SnNTdk1pdTJJWVNTUUwxbFhJ?=
 =?utf-8?B?UEc0S0FvVStRRms3L1gyQU8yMi9DMFlnVm16UndvdlZpZVdFRkQyVENmbDBw?=
 =?utf-8?B?Wng3Z0xvNzBTUTBnd3dvdmVHeDErUDZjOXFEVU4yZ29CUnVDc3FucHI5c0l6?=
 =?utf-8?B?KzUzYjRPemVScGJQaDBoT3R1WjhaVDYrc1hMTHBEZDlvSDhQOFJzaVlEZEVi?=
 =?utf-8?B?Nkl5N0tsVzlDTGNxMnJKT1l0a29EYllVWkxoSWxTY1ovWlVjMDQzYkVPeDlG?=
 =?utf-8?B?UWF4OGxUa1I4N2pJQm82OEVLWXFSYk1xYy80cHpSOGJaOUt2dldqMUNwZGQz?=
 =?utf-8?B?RUdjU0hxalhYMWVMc2tDSFR3eCt1Y3A5VitzY29RSmRsZEdjcDJ0bTA1dzh2?=
 =?utf-8?Q?ax4UYRw7u4N3VJ9A2wOVXVAkWhO4dBMXtg9PzOG0CRQA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869c3b6e-9ef2-430c-85fd-08dbaab705b3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9564.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 06:45:25.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQxL8rbUJoBlHyLANYlFDT58dv0jnjW0QSd1HUVQogqwxx7ACXy3akgVDlKX0OvH909lqu2hfcnwHRNjb4p/Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8161
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--------------OTupODJeWMXfDUq5N2tA8wKw
Content-Type: multipart/mixed; boundary="------------Fcdct9vzfFRonhBaiyJ3FqcS";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Message-ID: <dde4c21b-c5e1-722e-5629-87bfbf8d9c24@suse.com>
Subject: Re: Framebuffer mmap on PowerPC
References: <5501ba80-bdb0-6344-16b0-0466a950f82c@suse.com>
 <aea5e33a-1251-3188-6222-719fe9358762@csgroup.eu>
In-Reply-To: <aea5e33a-1251-3188-6222-719fe9358762@csgroup.eu>

--------------Fcdct9vzfFRonhBaiyJ3FqcS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMzEuMDguMjMgdW0gMTk6Mzggc2NocmllYiBDaHJpc3RvcGhlIExlcm95Og0K
PiANCj4gDQo+IExlIDMxLzA4LzIwMjMgw6AgMTY6NDEsIFRob21hcyBaaW1tZXJtYW5uIGEg
w6ljcml0wqA6DQo+PiBIaSwNCj4+DQo+PiB0aGVyZSdzIGEgcGVyLWFyY2hpdGVjdHVyZSBm
dW5jdGlvbiBjYWxsZWQgZmJfcGdwcm90ZWN0KCkgdGhhdCBzZXRzDQo+PiBWTUEncyB2bV9w
YWdlX3Byb3QgZm9yIG1tYXBlZCBmcmFtZWJ1ZmZlcnMuIE1vc3QgYXJjaGl0ZWN0dXJlcyB1
c2UgYQ0KPj4gc2ltcGxlIGltcGxlbWVudGF0aW9uIGJhc2VkIG9uIHBncHJvdF93cml0ZWNv
bWluZSgpIFsxXSBvcg0KPj4gcGdwcm90X25vbmNhY2hlZCgpLiBbMl0NCj4+DQo+PiBPbiBQ
UEMgdGhpcyBmdW5jdGlvbiB1c2VzIHBoeXNfbWVtX2FjY2Vzc19wcm90KCkgYW5kIHRoZXJl
Zm9yZSByZXF1aXJlcw0KPj4gdGhlIG1tYXAgY2FsbCdzIGZpbGUgc3RydWN0LiBbM10gUmVt
b3ZpbmcgdGhlIGZpbGUgYXJndW1lbnQgd291bGQgaGVscA0KPj4gd2l0aCBzaW1wbGlmeWlu
ZyB0aGUgY2FsbGVyIG9mIGZiX3BncHJvdGVjdCgpLiBbNF0NCj4+DQo+PiBXaHkgaXMgdGhl
IGZpbGUgZXZlbiByZXF1aXJlZCBvbiBQUEM/DQo+Pg0KPj4gSXMgaXQgcG9zc2libGUgdG8g
cmVwbGFjZSBwaHlzX21lbV9hY2Nlc3NfcHJvdCgpIHdpdGggc29tZXRoaW5nIHNpbXBsZXIN
Cj4+IHRoYXQgZG9lcyBub3QgdXNlIHRoZSBmaWxlIHN0cnVjdD8NCj4gDQo+IExvb2tzIGxp
a2UgcGh5c19tZW1fYWNjZXNzX3Byb3QoKSBkZWZhdWx0cyB0byBjYWxsaW5nIHBncHJvdF9u
b25jYWNoZWQoKQ0KPiBzZWUNCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgv
djYuNS9zb3VyY2UvYXJjaC9wb3dlcnBjL21tL21lbS5jI0wzNw0KPiBidXQgZm9yIGEgZmV3
IHBsYXRmb3JtcyB0aGF0J3Mgc3VwZXJzZWVkZWQgYnkNCj4gcGNpX3BoeXNfbWVtX2FjY2Vz
c19wcm90KCksIHNlZQ0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni41
L3NvdXJjZS9hcmNoL3Bvd2VycGMva2VybmVsL3BjaS1jb21tb24uYyNMNTI0DQo+IA0KPiBI
b3dldmVyLCBhcyBmYXIgYXMgSSBjYW4gc2VlIHBjaV9waHlzX21lbV9hY2Nlc3NfcHJvdCgp
IGRvZXNuJ3QgdXNlIGZpbGUNCj4gc28geW91IGNvdWxkIGxpa2VseSBkcm9wIHRoYXQgYXJn
dW1lbnQgb24gcGh5c19tZW1fYWNjZXNzX3Byb3QoKSBvbg0KPiBwb3dlcnBjLiBCdXQgd2hl
biBJIGZvciBpbnN0YW5jZSBsb29rIGF0IGFybSwgSSBzZWUgdGhhdCB0aGUgZmlsZQ0KPiBh
cmd1bWVudCBpcyB1c2VkLCBzZWUNCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGlu
dXgvdjYuNS9zb3VyY2UvYXJjaC9hcm0vbW0vbW11LmMjTDcxMw0KDQpSaWdodCwgSSd2ZSBz
ZWVuIHRoZXNlIHZhcmlvdXMgaW1wbGVtZW50YXRpb25zLiBMdWNraWx5LCB0aGUgQVJNIA0K
ZnJhbWVidWZmZXJzIHVzZSBhIHBsYWluIHBncHJvdF93cml0ZWNvbWJpbmUoKSB3aXRob3V0
IGFueSByZWZlcmVuY2VzIG9uIA0KdG8gZmlsZS4NCg0KPiANCj4gU28sIHRoZSBzaW1wbGVz
dCBpcyBtYXliZSB0aGUgZm9sbG93aW5nLCBhbGx0aG91Z2ggdGhhdCdzIHByb2JhYmx5IHdv
cnRoDQo+IGEgY29tbWVudDoNCg0KQ291bGQgd2UgZHJvcCB0aGUgZmlsZSBhcmd1bWVudCBm
cm9tIFBQQydzIGludGVybmFsIGZ1bmN0aW9ucyBhbmQgDQpwcm92aWRlIHRoaXMgaW50ZXJm
YWNlIHRvIGZiX3BncHJvdGVjdCgpPyBwaHlzX21lbV9hY2Nlc3NfcHJvdCgpIHdvdWxkIA0K
YmUgYSB0cml2aWFsIHdyYXBwZXIgYXJvdW5kIHRoYXQgaW50ZXJuYWwgQVBJLiBJJ2QgcHJv
dmlkZSBhIHBhdGNoIHRvIGRvIA0KdGhhdC4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0K
PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9mYi5oIGIvYXJj
aC9wb3dlcnBjL2luY2x1ZGUvYXNtL2ZiLmgNCj4gaW5kZXggNWYxYTJlNWY3NjU0Li44Yjli
ODU2ZjQ3NmUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9mYi5o
DQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9mYi5oDQo+IEBAIC02LDEwICs2
LDkgQEANCj4gDQo+ICAgICNpbmNsdWRlIDxhc20vcGFnZS5oPg0KPiANCj4gLXN0YXRpYyBp
bmxpbmUgdm9pZCBmYl9wZ3Byb3RlY3Qoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdA0KPiB2
bV9hcmVhX3N0cnVjdCAqdm1hLA0KPiAtCQkJCXVuc2lnbmVkIGxvbmcgb2ZmKQ0KPiArc3Rh
dGljIGlubGluZSB2b2lkIGZiX3BncHJvdGVjdChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZt
YSwgdW5zaWduZWQNCj4gbG9uZyBvZmYpDQo+ICAgIHsNCj4gLQl2bWEtPnZtX3BhZ2VfcHJv
dCA9IHBoeXNfbWVtX2FjY2Vzc19wcm90KGZpbGUsIG9mZiA+PiBQQUdFX1NISUZULA0KPiAr
CXZtYS0+dm1fcGFnZV9wcm90ID0gcGh5c19tZW1fYWNjZXNzX3Byb3QoTlVMTCwgb2ZmID4+
IFBBR0VfU0hJRlQsDQo+ICAgIAkJCQkJCSB2bWEtPnZtX2VuZCAtIHZtYS0+dm1fc3RhcnQs
DQo+ICAgIAkJCQkJCSB2bWEtPnZtX3BhZ2VfcHJvdCk7DQo+ICAgIH0NCj4gDQo+IA0KPiBD
aHJpc3RvcGhlDQo+IA0KPiANCj4+DQo+PiBCZXN0IHJlZ2FyZHMNCj4+IFRob21hcw0KPj4N
Cj4+DQo+PiBbMV0NCj4+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjUv
c291cmNlL2luY2x1ZGUvYXNtLWdlbmVyaWMvZmIuaCNMMTkNCj4+IFsyXQ0KPj4gaHR0cHM6
Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNS9zb3VyY2UvYXJjaC9taXBzL2luY2x1
ZGUvYXNtL2ZiLmgjTDExDQo+PiBbM10NCj4+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L3Y2LjUvc291cmNlL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9mYi5oI0wxMg0K
Pj4gWzRdDQo+PiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni41L3NvdXJj
ZS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYyNMMTI5OQ0KPj4NCj4+DQoNCi0t
IA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0Ug
U29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2LCA5
MDQ2MSBOdWVybmJlcmcsIEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFuZHJldyBNeWVycywg
QW5kcmV3IE1jRG9uYWxkLCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgwOSAoQUcgTnVlcm5i
ZXJnKQ0K

--------------Fcdct9vzfFRonhBaiyJ3FqcS--

--------------OTupODJeWMXfDUq5N2tA8wKw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmTxiIIFAwAAAAAACgkQlh/E3EQov+Co
Sg/+JDA6NmO3JyWU2kXMq0aMsgOhtcqalvXTa/XVZ8Q7lWpAvgIX0RUjmRG+t0JHjj7+r9+Pr32I
xfUUhuZrian5AsVhvxjXOy94g4MeEeC6VDkxreUg87UB6+Jl7qt0M9YUlu0w6gA0XooM1jm61DK5
EKui2qNBI66pBorYAI2ssPY0UlYvBl68mkfN/oV/oBTfI6OpygXDYgNfLDnCh/zm24Tpa7Qd6zRm
2C8XnwK1Arvhu01Xx5CMSAZn6euOqQP/j3hbE0pqlYLYUWOZK2ai/iSS6CBXBMkF++xp1Ymdh2QF
wPIc86/k6ErKfbg7JAfyaH8hVCyHq3Gvu04bRp///ZqkwyB/rzlnw7g3AHjvsIdCLSIkK9mKBfR1
y616ZYv8CVDaAPkEewD0luG4CXKFEqT0pvj5uKQEMEQ81GEj4X+qU1CKwlCDF/n5+ZZJ5Loashno
bt6J9tUyliNTsrSYaIMZzayWKbHRGZKj5V/KTJrpXZLJhv2O6HwKXPyH73TqbHY44pI+LtCz6HXc
gRLEX/Xvlzlle/4dgvs+jYqGWS15xKD2ySiD7ncuZXRhQkBJ480wRWmHeJYfOU0InA9XEtCkwWNx
TS2udOlFcVO3jCW1HfYHzh4pdB9/Jqq+teJ7NcM3UxJZLCYdynryOIfzuSqetY+vWweiPj96gqMp
4XU=
=QF6l
-----END PGP SIGNATURE-----

--------------OTupODJeWMXfDUq5N2tA8wKw--
