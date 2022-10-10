Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594FD5F9FB2
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 15:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJJN4v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 09:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJJN4t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 09:56:49 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2DC67464;
        Mon, 10 Oct 2022 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1665410208;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=phI1DcSJt4wW8qXPx53JFwq0D+FVcXNHWWzwWBNo+wM=;
  b=Du1NvTEbJCrlDv7UDG4cLL1L/vHSP0WM7jvwZEpgoON68MTAR4SJx00Q
   BJKY5E8EyKQcr3HH1Ky9VizvMBl9GoTkNR5y6l/i6NSEdP6UWi6gQGe2x
   qlP3uZZ8c9YDSTHMW8xdDSgbuECEJStfo73IxqFNvYVQEmIScn9Vl8+EP
   4=;
X-IronPort-RemoteIP: 104.47.58.169
X-IronPort-MID: 84900055
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:48AiFKld1Yomvz8H4m0eirPo5gyqIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIcXG2COKreZWOjL91wb9+y9E1XucPRm4djTwFt+ygyFiMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6UqicUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS9XuDgNyo4GlC5wRnPagR1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfHkYJ9
 9g0C2ExUSuarsKa3aqcVrdoiZF2RCXrFNt3VnBI6xj8VK9ja7aTBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqsy6Kkl0ZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXOnCdpKTODlnhJsqEy5wi9DUEIZbwWcjMSJm2WaUPIYe
 1NBr0LCqoB3riRHVOLVUQK1oXuJpDYGVtZQGvF84waIooLX7guCDW8DTRZKaMYhsc4rQHotz
 FDht8noDj8pqPuYRX2Q/bCRpz6aOC4JIGtEbigBJSMVs4fLo4wpiB/LCNF5H8adjsX8MSPh3
 zeQ6iM5gt07kcEPx42//FbanyiroJnZCAI4ji3SX2Sq6StjaYKlbpDu4l/ehd5ELYCEXhyCs
 WIClsy28u8DF9eOmTaLTeFLG6umj96JOSPRx15mGYIs8Ryp+ni+bcZR5i1zIAFiNcNsUTLyc
 VX7ow5d5JZPenCtaMdfZ4O3FtRvxLLrFfz7Wf3OKNlDeJ58cEmA5i4GTUqR2X391UE0kIkhN
 pqBN8WhF3AXDeJg1jXeb+4H17MDzzo4yWmVSZ2T5xC6zb22Z3OPT7oBdlyUYYgR5riFpgrV+
 sxYLcKixBBWUem4aS7SmaYZNXgDKXk2A8Cwp8E/XuGEOAF7HmY/I/DUyLIlPYdimsx9kubO4
 2H4VkhT4ETwiGeBKgiQbH1nLrT1Uv5XqXM9IDxpOFOA2GYqaoXp670QH7M3f71h6OtkyeVcQ
 PwMesHGCfNKIhzY9jUfbJD7o8pzfRKkrQOIIyehJjM4evZITAvT8NL4Vg/w8m8IAzbfnc4/o
 LDm1RnSX5cfVSxlFs/dbP/pxFS01VAbke57QQ3BJ9hPUErp+YlubSf2i5cfJMUBJj3Zyzea3
 hrQChAdzcHVqpE49PHUjr/CpJXBO/NzAkdADUHa67isPCXX92blxpVPOM6ScS3bUGrs0KSka
 /9cw/z1PLsAhlkim4ZxD7ZsyKsW4trkvbhByQp4Wn7MajyDCLpmJHmu0s5IualAgLRevGOeW
 UOV+91ef66JJd/oFVkPDA4kaPmTk/AShjTWq/8yJS3S5ih++/yCVl9fPgOFoC1bMLZxdogix
 I8JuskW7Uq2jh4nNP6PiywS/GOJRlQDWK4PuZYdD4vmzAEszzlqbIbVDC7/5rmAbNJDNkRsK
 TiR7ILYn6xA7knPaXw+ET7Kx+U1rZYHvRdQ1l4ZD1CInMfVwPo21wdW6jM5UkJeyRAv+/h6J
 GktKQtuJayI/D5yrMlFQ22oXQpGAXWx61G0wFsEkmKfXlSAV2rRIWl7MuGIlH316EpZdzlfu
 buemGDsVG+zeNmrh3VjH0l4t/bkUNp9sBXYn9yqFNiEGJ98Zif5hqipZiwDrB6P7d4NuXArb
 NJCpI5YAZAX/wZJy0HnI+F2DYgtdS0=
IronPort-HdrOrdr: A9a23:ZIRQiq0Q5haVRFOOomPrlAqjBRFyeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ4uxpOMG7MBDhHQYc2/hdAV7QZnidhILOFvAv0WKC+UyrJ8SazIJgPM
 hbAs9D4bHLbGSSyPyKmDVQcOxQj+VvkprY49s2pk0FJW4FV0gj1XYBNu/xKDwVeOAyP+tcKH
 Pq3Lsjm9PPQxQqR/X+IkNAc/nIptXNmp6jSwUBHQQb5A6Hii7twKLmEjCDty1uEg9n8PMHyy
 zoggb57qKsv7WQ0RnHzVLe6JxQhZ/I1sZDPsqRkcIYQw+cyjpAJb4RGIFqjgpF5d1H22xa1O
 UkZC1QePib3kmhPF1dZyGdnTUIngxeskMKgmXo/EcL6faJOA7STfAxy76xOyGplXbJ9rtHod
 129nPcuJxNARzamiPho9DOShFxj0Kx5WEviOgJkhVkIMIjgZJq3PsiFXluYeE9NTO/7JpiHP
 hlDcna6voTeVSGb2rBtm0qxNC3RHw8EhqPX0BH46WuonNrtWE8y1FdyN0Un38G+p54Q55Y5/
 7cOqAtkL1VVMcZYa90Ge9ES8qqDW7GRw7KLQupUBzaPbBCP2iIp4/84b0z6u3vcJsUzIEqkJ
 CES19cvX5aQTObNSRP5uw/zvngehTPYd228LAu23FQgMyNeJP7dSueVVspj8ys5/0CH8yzYY
 fABK5r
X-IronPort-AV: E=Sophos;i="5.95,173,1661832000"; 
   d="scan'208";a="84900055"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2022 09:56:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NywwbpVkvUwbrxp3k32toGeQmKMbKZOn4e8dItDqG2WpX8VlyOhhd5DE7Rzf3hBygSKeqslvx+ziHrfebkBmYmdejH0uou+urJLUnWH0ITxDBtBN2JjUuawoSGMQEqCFscinl7xGoJ5/q0wOSiUNWuYkpvEOno0rlXOn9yEUdbBrSjjvNSUs2xMQev5acaXHbJadrDb47GnbIYU3US7vnpk9zFBoTxCEUMHwb6nN85CtBN+rhKrMxEJ9N5IByUxb2jbEvSvdSif6SiVAaQRzxJWe1b0+rMtxvCLL8oKUNIPCaBjzplYNy/PYvIccIQDp4V61YxUOfNkGG4rDbYiYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phI1DcSJt4wW8qXPx53JFwq0D+FVcXNHWWzwWBNo+wM=;
 b=GpgnKnI0K+3IhaxkLjLHrz81BYuRCbWjzE4GrCCJ+3+wgC2GPUvWlIIllANEpx630NfZbLVyPmtPcfkTHW3QmSy+HXby5NXNVwTVAH8r37ZnU61/5Eu+1Ai/Z+fNI6rzYYPHF96oTOuws6cZlJaU81TiYe/vD13fGVWhxBKmsZD0eVaSXdxrxg6XnR4wnDA2qNWpNYRXmgxVsosz+r/FPAschuLsXb2vdwe2MbDiFpJzD8GpA7muS7UDrSxuca8i2gUxR4Nh6quFqNBmSZe7+ZUWV+Zi+D8RyylpQGaf+QAsqeIzMCC4WcnuQo1MvUOfN7TXUiJCGEooO53r8bt2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phI1DcSJt4wW8qXPx53JFwq0D+FVcXNHWWzwWBNo+wM=;
 b=FIlM6AvSMHthOQKU8zUxVK7+VTXaT3JR9hX0wGmfbTbfVsgKTTXXGiagVn4cHSfnTqbIT5aHYy9S+dhG/3bjcPlcPM92PIZDH2NbatHfAR9x+OJnJjeFzN4eU+3C1aixe6MSXMmjlaIIbKWDk8GH0XJt87E3pzHSdpRQkF6tP0Y=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SA1PR03MB6596.namprd03.prod.outlook.com (2603:10b6:806:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 10 Oct
 2022 13:56:39 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44%3]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 13:56:39 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Florian Weimer <fweimer@redhat.com>
CC:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "joao.moreira@intel.com" <joao.moreira@intel.com>,
        John Allen <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "eranian@google.com" <eranian@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH v2 18/39] mm: Add guard pages around a shadow stack.
Thread-Topic: [PATCH v2 18/39] mm: Add guard pages around a shadow stack.
Thread-Index: AQHY2EPhEQwcvkF0f0Gd0+5UmjC5K63/FHWAgAiEIeaAABB4gIAAAixigAAEeQA=
Date:   Mon, 10 Oct 2022 13:56:39 +0000
Message-ID: <ac7155c0-2ef5-2f86-5f87-22ede5383016@citrix.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-19-rick.p.edgecombe@intel.com>
 <202210031127.C6CF796@keescook>
 <37ef8d93-8bd2-ae5e-4508-9be090231d06@citrix.com>
 <87bkqj26zp.fsf@oldenburg.str.redhat.com>
 <6e75eb27-c16b-ccfe-08b9-856edeff51eb@citrix.com>
 <87tu4bztj1.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87tu4bztj1.fsf@oldenburg.str.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|SA1PR03MB6596:EE_
x-ms-office365-filtering-correlation-id: b4ca56f3-f6f8-48da-1b2a-08daaac740e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oj8EB1YD3PtdcB0xHPWqmz0UdI74PqcyCiQ9SCDq02nnsXQQAfFzFFeB7ATE/bqQ2uu69d3Cawi4d+BtQZ62+yiQdF0yK+KJ9r+VAtp775zfEH0DklDgXRxsI3NHhjJFFT2+QJxK7iSsUc8pbKruxG0amfZdcZlktTuNqo71sZVok5/bXNPIyaWfn63uc5CqCy2YfU230lvlKFxqthojdpaLIYpDgvh+msr1gdSfjxHUUyLRxPdvyCm1wefO3Pyhi+usdRPI7s03fxq2pcTOC7lZWHAyWJfVxaXJkmagkmIe5dy4EqBiDtTNlsGno3mrrXz/TRzKT1pxyc9mM6k7vbzKsYfunfuVjOL3jNZKet8fmINhogaIGoE+IPF9c+xWBqcZU9jla1Jxkd6S/63EmU0c9cdApmmwKciRKXGpgnHDeY/AOEx6Krs5tKYWrqBhGhuGDpsmSsvEY+5gNmDb6enlPlv05/hFOI0ke243Q8mR3DojLd5RRKAnHLoTMce4glf4Z6MUEpi6wmQenPeHgHOk4XJnLsZikuDtwM45QLXIgVBsNWwngkgCo3Ezax/+fVs1bGDGSMvIrs+zT0KPhYhzYirLcEDQfO94AaWj+rJGUEN0uBue1PyDeFnEAeZx2xCuXj568TXpN+FtgM30m3vGiIJNO+YpiZccPqZhd1x56Av/Cx3oMCJ42BgTjE3ZdIBV99V2yopHXRF8emaeDB7Zg6+4K5Z+kcJv4LcztTZzizZX/DLfsAj08P1QrsMmjWD6JoDUGVWTWTFzJ5LjJwp+6oG3MjH0Tx3jhs35ne0AyChlqqw7ckip1V0/hL1GUuEbTaa3YIt4E9UTeAb6jURjVAFsRPadtT4jnqXrpt0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(31686004)(122000001)(7416002)(7406005)(71200400001)(38070700005)(4744005)(66556008)(107886003)(6512007)(2906002)(966005)(478600001)(6486002)(82960400001)(86362001)(4326008)(6916009)(41300700001)(64756008)(83380400001)(8936002)(66946007)(54906003)(66476007)(8676002)(91956017)(5660300002)(38100700002)(26005)(6506007)(36756003)(53546011)(316002)(66446008)(2616005)(76116006)(186003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWVRNXV0Nk9iZEppaW5lbWlqTHBVVUdxR2FlcEhLSURMcFUrZUljWWswMzh3?=
 =?utf-8?B?eS8rc01qRFRqcGdIQVhlVHA3YUI0Y2N6RzV3dno1VWVDWHBRWUZDcnljdzEv?=
 =?utf-8?B?RXF5U2Vqb1ZOSzkvSzFDU2RPaUkyRCtmUmNremdya0R0QytkNDFCN2w1d0pS?=
 =?utf-8?B?Nk56RFNNZENwaU8vdURsd1AzdDJWVW1rNGVxTGUyZkFBbEFWMnJWUWs3eDU4?=
 =?utf-8?B?RUh3SDB6WFgrWUlyNFBiUFlCY2tPRytEdm9YQjhyL1dEQ0xHWDluakVMWm9K?=
 =?utf-8?B?SlQ0SlQrV0ZLTzVhNk1QR08ySjVXMStXdVFySEIwak0zcXV3cTlDK0JhQW5G?=
 =?utf-8?B?cjZKVS9xbmlrdFdONElHa09SOGdSTmdFTjVQR3RtSXpIY0hTaVRpdFJJV0NW?=
 =?utf-8?B?YnNidzV0d0V6T2k5UTA1b0NESm5uK2JpbzVQQlgwbHJTMFh6MjZJa3ZsSDMx?=
 =?utf-8?B?dVdBaFByamRDVGVMU1JYYTFuUVhMSjZXOTNBZVBKcnovZTE4VTJtQkp0dmxq?=
 =?utf-8?B?RUZnVmFKRjZvcVhHQlJyM0FjZnpMUmNsTS9hS0JjWThtTlAzUVc1OWMrMXcv?=
 =?utf-8?B?ZldhZ21HKzc4ZUE5UzVLK09tWSs0alovbTNmOTd2WFlkYWRkMmZsUExBREk1?=
 =?utf-8?B?NDNVQzhhUG1zTUh6L1U1aDcwSTBzNnFHQ3pBcEl4bUF5V01ldDZudGsrNHBJ?=
 =?utf-8?B?YnU1eDJ3RHR1QWVUVkxsellKb1cxTmN3ZldPNDVkYmZDbnpoaFNickxObERy?=
 =?utf-8?B?UXFRMWZ5TEVEVk9SSWZaeEcwZUJUaXdrUmxtNW03bkljVG1XYll2S1lDYmxi?=
 =?utf-8?B?WFhRSWNZUWMwbFljVGlKMklVRmFDeVdEOEdjZmQ5ZGZzcnRJWTJXS2ZURnZZ?=
 =?utf-8?B?MVdmL3ZjWXhRVHdYWHZQaDUzUHE0UE1RWjVVeW1idmN0OUQweHROQU95QTNU?=
 =?utf-8?B?cElTVXZqcFBZTk9NUmRiaU1HMFpzNFBteXl1WUFuQzBjeUFGdzh6UHV6ZEZ2?=
 =?utf-8?B?WjJKaGxXUmh3ckIwU20vYVhHOVo1SHNnQ3JCRVQyNjJMMUxwUTNFL0ZkYXdp?=
 =?utf-8?B?MWdIcDV0WUxtelJkVkwvdGZQMnU5SzJoTktDU0d3WmJ2MCtLd2JJWDFhamdr?=
 =?utf-8?B?RHAyQ3FjTVRUV2hpNGtTL01IUjhPc0Qzd1RNbnExQm01djZhcmhkc21kR1Nj?=
 =?utf-8?B?bGFmZlFhMlp6QStGWDZtbUhkSzRQUC90YmdXbzIvcUg1b1VocHBSSkdrZGd3?=
 =?utf-8?B?Yms1Q0dSLzJnQzduY3dCeEpBYTh0UExNZDNpanFsWUQ1aTdtV0FHQjJTUitL?=
 =?utf-8?B?MFQzcUpPbUIrOUc0dnlBWWdnSDJZc2FMMmRvN2ZpYXFnRUdSblF4K0Q0L2Nt?=
 =?utf-8?B?NFNKYlp1U3IxdE13MFhySEg0Y3ZGR1c3QzVjUXhVcGF3Z0JPQld5VFdtWHVm?=
 =?utf-8?B?L256SzZMMVc3ZkxoUVpzOWRud2RvR0tNc24rMlZhQWhwOGhWMW5INU9PS09s?=
 =?utf-8?B?OFd3VFpiMzZMSjdpK2tLVGdkdTJFUU9TNW5ieGErL2VRSC82cnY5MVRRUW9i?=
 =?utf-8?B?blFkTTRsWmtUZXdPOHRZUXdKcVZmTi9saExaN29RYXIzMEorNjB4YTQzdThV?=
 =?utf-8?B?VHVqQjhPTUJ4YkxlVWd0WnhwYnFRRWRxbHZrVXV3ZUhXZDkxN0NmRkRYcXNu?=
 =?utf-8?B?THBMRDZENmFEc21wMjZ4OVJLU08zZHpVNHNwOUpRYWt2WklHOVczb0JkTVZ3?=
 =?utf-8?B?STZhazh4M1RhQ1NKcEczZ0xnOWhRYzNQeEZ4SmNJRk9BUmF0cmticHVIaVRq?=
 =?utf-8?B?VFEwcEZnWSs4N0pzL1Y1QnlneEJuR3JOa1Rkd2psNUc3Y25maGxxTmFYSzFZ?=
 =?utf-8?B?Qk1aYmRuZG0wZlVkZ2RTYnhUTHovUHRrTC9YbFlGVXNwQlplQjNmd2Z3NCtT?=
 =?utf-8?B?VFlmVll6Qm5iZ25Md2pONHBQSy9ZMUMwOFpxa3loQmJTNzRjVlVkTkswMWpr?=
 =?utf-8?B?UlVNV2M1d1llQWxacU95Q29RRzZwN2RrLytoZ05ieEVld00xVTZVcTNJVjF6?=
 =?utf-8?B?QWhDTEplc2VaV1ZrbFI0YWFiN05CT1R6KzNOL1hCelJYSmdFaGZPRHJVblV0?=
 =?utf-8?Q?ZfXRJXpn1TJw1gQJ3aPohpM81?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97A3535636FB7F49B091B70CB88E3333@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ca56f3-f6f8-48da-1b2a-08daaac740e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 13:56:39.0357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AC8WflGJj2/jAwYPKwWyGfswEXLKAw+UEvUM2kwawu+oZTl/HmHiD54TaFyFH+k5efKwt8t07OOyH/02KCIlSMpgFmWwTmJAnt4HTPnm9g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6596
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMTAvMTAvMjAyMiAxNDo0MCwgRmxvcmlhbiBXZWltZXIgd3JvdGU6DQo+ICogQW5kcmV3IENv
b3BlcjoNCj4NCj4+PiBQT1NJWCBkb2VzIG5vdCBhcHBlYXIgdG8gcmVxdWlyZSBQUk9UX05PTkUg
bWFwcGluZ3MNCj4+PiBmb3IgdGhlIHN0YWNrIGd1YXJkIHJlZ2lvbiwgZWl0aGVyLiAgSG93ZXZl
ciwgdGhlDQo+Pj4gcHRocmVhZF9hdHRyX3NldGd1YXJkc2l6ZSBtYW51YWwgcGFnZSBwcmV0dHkg
Y2xlYXJseSBzYXlzIHRoYXQgaXQncyBnb3QNCj4+PiB0byBiZSB1bnJlYWRhYmxlIGFuZCB1bndy
aXRlYWJsZS4gIEhlbmNlIG15IHF1ZXN0aW9uLg0KPj4gSG1tLsKgIElmIHRoYXQncyB3aGF0IHRo
ZSBtYW51YWxzIHNheSwgdGhlbiBmaW5lLg0KPj4NCj4+IEJ1dCBob25lc3RseSwgeW91IGRvbid0
IGdldCB2ZXJ5IGZhciBhdCBhbGwgd2l0aG91dCBmYXVsdGluZyBvbiBhDQo+PiByZWFkLW9ubHkg
c3RhY2suDQo+IEkgZ3Vlc3Mgd2UgY2FuIHVwZGF0ZSB0aGUgbWFudWFsIHBhZ2UgcHJvYWN0aXZl
bHkuICBJdCBkb2VzIGxvb2sgbGlrZSBhDQo+IHRlbXB0aW5nIG9wdGltaXphdGlvbi4NCg0KSGVy
ZSdzIG9uZSBJIHByZXBhcmVkIGVhcmxpZXIsIGRpc2N1c3NpbmcgZ2V0dGluZyBzdXBlcnZpc29y
IHNoYWRvdw0Kc3RhY2tzIHdvcmtpbmcgaW4gWGVuLg0KDQpodHRwOi8veGVuYml0cy54ZW4ub3Jn
L3Blb3BsZS9hbmRyZXdjb29wL1hlbi1DRVQtU1MucGRmDQoNClRoaXMgb3B0aW1pc2F0aW9uIHR1
cm5lZCBvdXQgdG8gYmUgdmVyeSBoZWxwZnVsIGJ5IGJlaW5nIGFibGUgdG8gcHV0IHRoZQ0Kc2hh
ZG93IHN0YWNrcyBpbiB3aGF0IHdlcmUgcHJldmlvdXNseSB0aGUgZ3VhcmQgaG9sZXMsIG1lYW5p
bmcgd2UgZGlkbid0DQphY3R1YWxseSBuZWVkIHRvIGFsbG9jYXRlIGFueSBtb3JlIG1lbW9yeSBm
b3IgdGhlIHN0YWNrcy4NCg0KfkFuZHJldw0K
