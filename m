Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88CD5F5CF3
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 00:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJEW6S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 18:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJEW6Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 18:58:16 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD198558B;
        Wed,  5 Oct 2022 15:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1665010694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FH/xvI9lOkldwTbZAr62QCVYh4Ug3VQeWONFLC6P8aQ=;
  b=PP5jrP1eIvvcwvI0njs8Svz/UdLLjKUjdH+Z4sCVjIm5nel0IyiIOqBP
   xxqrw1xmPkGqGx/GN3j0ncbDt40341ryaaCusPMUfeY4tpxkw6Dtj3p8D
   mNrscc5P8ZjRlSWPTPsOVLsN/w20jQnOBkDQWaU/I0BVlvp68eZQXiuay
   o=;
X-IronPort-RemoteIP: 104.47.74.43
X-IronPort-MID: 81712605
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:T7ixcqmIqVe/wO71eSgBR/fo5gypIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xJOXTqAbqqMamLwKt8jb96/8kwPusCExoVlTwBt/n1kESMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6UqicUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS9XuDgNyo4GlC5wRmOKgQ1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfRnh38
 uMmazc2VBWSuL3mwZ+Kauk8iZF2RCXrFNt3VnBI6xj8Vapja7aTBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxovy6Pl2Sd05C0WDbRUvWMSd9YgQCzo
 WXe8n6iKhobKMae2XyO9XfEaurnzXqkAdhMTODQGvhCrXyQgUUYJCEtTGCH+diwlkmGC/xjA
 hlBksYphe1onKCxdfHnXha75mbCsxITVtFXFuc3wACL1qfQpQ2eAwAsRCVAbtMmvdUxXzUC2
 VqAntevDjtq2JWVUXu15KaIqin0Mi8QRUcPfj4eZREI79nqvMc4iRenZs5uDKOvnPX0Hz/qy
 jyHpSR4gK8c5eYR27i9+VnfqzOqqILAQgM86kPQRG3NxgB0aZWuYIurwVPb9/FFLZucCF6bs
 xAsl8GA4aYOBJeWmSqlROQLAaHv5vCZPTmaillqd7Er7xyk/3+ue9AW7DwWDEdrNoAYfjjte
 2fcvApQ4NlYO37CRat2ZZ+hTsEv5av+HN/mEPfOYbJmbId8dQqK5gl0aEKQ1nyrm08p+Yk5M
 JuSb4ClCHcGIatixTuyAewa1NcDxCk4w2P7Spf8wBCql7GZYRa9RboZMFyLZ8g87aiepx7S/
 coZPMyPoz1bUevjcmze64UTBU4FIGJ9Bp3srcFTMOmZLWJOG2oqI/DWxrwldspumKE9vuTJ5
 HC5XglDyEfjiHjANy2Oa3Z+ePXuW4pyqTQwOilEFVuy0n4iaICH46AYeJ86O7Ig8YRL0vN1T
 fgMfcrGE/1JRRzG/SgQad/2q4kKXBaigAWUJSu+SDw+eYNwAQnI8cXjZQzh6G8FCS/fnc8jv
 7qI1Q7BR5cHAQN4A67+cPuxwleZoHMC3ulgN2PBON9fUEz29oRgbSD85tc1JMgLbxDE3Dabz
 Q++ABEEqO2LqIgwmPHViqSUh4OoFfZiBE1cHnmd4bveHSzb/WflwpVJTuuUbxjaTmr//Kjkb
 uJQp9nsYKMvn1tQtYd4VbFxwsoW6Nz1rKJcyRpME3DCblDtAbRlSlGB2cRAnrdAyr9QpU29X
 Ufn0ttdObPPMcfhHVg5LQ8pKO+E0Jk8gCHK8dw2LV/86Ssx+6CIOW1XPh+DjwRHIbd1OZ9jy
 uAk0OYM4hK+zARsKdaPiCNd7UyNKGANV+MssZRyKITskAAm1nlGfpqaDCLqiLmLatNRIgwpL
 yWSia7qmbtR3AzBfmA1GHyL2vBS7bwKuRZX3BoLP1WhhNXInLk00QdX/DBxSR5apj1D0uRuK
 i1nMEZdO6qD5XFridJFUmTqHBtObDWI5wn6y1YPmyvIUmGpUHDAKCs2PuPlwawC22dVfzwe9
 rfIzm/gCWruZJupgnB0XlN5ofv+S9A37hfFhM2sA8WCGd89fCbhhaitI2EPrnMLHP8MuaEOn
 sEylM4YVEExHXd4T3ETY2VC6YktdQ==
IronPort-HdrOrdr: A9a23:5pnH8KHsyfrn8a6IpLqFFpLXdLJyesId70hD6qkvc3Fom52j/f
 xGws5x6fatskdrZJkh8erwW5Vp2RvnhNNICPoqTM2ftW7dySeVxeBZnMHfKljbdxEWmdQtsp
 uIH5IeNDS0NykDsS+Y2nj2Lz9D+qjgzEnAv463oBlQpENRGthdBmxCe2Sm+zhNNW177O0CZf
 +hD6R8xwaISDAyVICWF3MFV+/Mq5nik4/nWwcPA1oK+RSDljSh7Z/9Cly90g0FWz1C7L8++S
 yd+jaJp5mLgrWe8FvxxmXT55NZlJ/IzcZCPtWFjow4OyjhkQGhYaVmQvmnsCouqO+ixV42mJ
 2Vyi1Qf/hb2jf0RCWYsBHt0w7v3HIH7GLj80aRhT/OsNH0XzUzDutGnMZ8fgHC40Qtkdlg2O
 Zg3n6ftbBQERTc9R6NqeTgZlVPrA6ZsHAimekcgzh0So0FcoJcqoQZ4Qd8DIoANDiS0vFkLM
 BeSOXnoNpGe1KTaH7U+kN1xsa3Y3g1FhCaBmAfp82u1SRMlnwR9Tpc+CVfpAZFyHsOcegD2w
 32CNUwqFiIdL5PUUtJPpZHfSJwMB2XffuDChPJHb2tLtB7B5uEke+K3Fxy3pDoRHVA9upNpH
 yKOmkoylIaagbgD9aD04ZM9Q2ISGKhXS71wsUb/JRhvKbgLYCbeBFrZWpe5PdImc9vdPHzSr
 K2ItZbEvXjJWzhFcJA2BD/QYBbLT0bXNcOstg2VlqSqoaTQ7ea/dDzYbLWPv7gADwkUmTwDj
 8KWyXyPtxJ6gSuVmXjiBbcVnvxcgj0/I52EqLd4+8PobJ9frFko0wQkxC098uLITpNvug/e1
 Z/OqruluehqWy/7Q/znhFU09pmfzNoCZnbIgB3TFUxQjLJmJ44yqWiUHEX2mebLRliSM6TGB
 JDpj1MiNCKE6A=
X-IronPort-AV: E=Sophos;i="5.95,162,1661832000"; 
   d="scan'208";a="81712605"
Received: from mail-bn8nam04lp2043.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 18:58:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCMWUaNzxzJOD4ZILbM4VOakevoVfEmM0YKWnXYL9AaXBxqhhWjRH0eIdZLnEg1rp9Lio+aKCeH2u/5d7rOGgdLYPDTV2FsbFB7yz8p+JFQgzeM3MjFhVUjt3mJY63lMyzyiBXSa8S4OVb/7IsQ21X4oxRsYzoxe7EnYyqHkL/noGPuVza/NwTc1pdUpdYbMDc1fbTyQiL/lnYWthpLr4BC7vOxOJJi5pLrARiqDd5o21rIJxJ1ZiTF2BEUWoFHSav8blg0BkWb7JdquUshIA6tx8eYwcBQTifL6Nh8t123veoLMxdF37Tlnr6yVk5fAJrZf4D7ZUweECcajjJTEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH/xvI9lOkldwTbZAr62QCVYh4Ug3VQeWONFLC6P8aQ=;
 b=INk+c255CAJXmAJv6A4mh6utII2gzOhNdhLfqhhUBKqBmPw28TOYl1FnXZXegONDm5Tg7RmuJeuDUfOihG68u4+lis9VroCgBO04CvsVIgtG5XHGf9lAs/jKalGYZNg7ILUAy5AK08oXOX/uy9dVt882203SQrxGutRAl1nxG0Wi6I0mKmdCdPaQ4d2hgHgwKmmHaU7uZX7tdek3okCA8JnFXoz8aSj3L4/aemecbo+in2mtdFuihG/J7ZUnOy0iOrXDuVfss5AgOqnX2636rNEc/zF750P+e3Rk0mABgl5DM+4WyEfxCv4VT3Ll2gyTDN4q//Ks8jqBSSnWN1ElSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH/xvI9lOkldwTbZAr62QCVYh4Ug3VQeWONFLC6P8aQ=;
 b=hxPHBw0bmNMf3BRh6Vjd8UHmAGG87H18T8RB3M/G+Ub55vQ4rx9P/dQyelY7dD3LXFAI7fwapx48UqaXTwsCbKLCBQ3r2XFJlIa05khs4PeVcDS1H6Rf0vuOb9NguGAGXtcZYiSKCp/UfMUSrbt+u8pVfjayMi4x4Qsj9OiHhPM=
Received: from BN7PR03MB3618.namprd03.prod.outlook.com (2603:10b6:406:c3::27)
 by PH0PR03MB5814.namprd03.prod.outlook.com (2603:10b6:510:38::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 5 Oct
 2022 22:58:05 +0000
Received: from BN7PR03MB3618.namprd03.prod.outlook.com
 ([fe80::e026:95ff:3651:8e37]) by BN7PR03MB3618.namprd03.prod.outlook.com
 ([fe80::e026:95ff:3651:8e37%6]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 22:58:05 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 26/39] x86/cet/shstk: Introduce routines modifying
 shstk
Thread-Topic: [PATCH v2 26/39] x86/cet/shstk: Introduce routines modifying
 shstk
Thread-Index: AQHY2EP4TXYAyvUmfUWnvmP4OfP5eq3/F+WAgAFQYoCAAAMMgA==
Date:   Wed, 5 Oct 2022 22:58:05 +0000
Message-ID: <8031fb5f-ca53-d89e-1e29-262514552708@citrix.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-27-rick.p.edgecombe@intel.com>
 <052e3e8c-0bb0-fd2d-9f67-08801a72261c@citrix.com>
 <fe5d52cebe4aaca0234856f789b3153f202eb9cf.camel@intel.com>
In-Reply-To: <fe5d52cebe4aaca0234856f789b3153f202eb9cf.camel@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB3618:EE_|PH0PR03MB5814:EE_
x-ms-office365-filtering-correlation-id: 942cc831-42a5-4603-d816-08daa725104f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zmGUe1VlKRcQpHq+OlkflHKUkdszyK1KrHJB7I+82T0csgvCtwQCeN01aJ/KPffFvBx6+Bj6g24YRmza/NHG9uTuhccsnCv+nIgYUXlgw3zzgtRlvfrR2Z1GGtaCbO7O2GIMPoeNyBiZavwBYwXj1USU/+EndiBByhE331HccFCKhEAbuUTi3HWqY/DGpI9hZ5Tz4sE2NLGcwRBypoL1Y5gSI76gLFkV/ggU4EbPJl5glaSsxdCfSym0VT2W2COPr7vu5JrTrBZOEbB5xZyulCswCq26Yc5PnJ2Jw59asYzIubo5rm5RddO3tLu2QQXTBxkyDhDV8Xt35Mxs9dDT3NPRFC4c9LoQ5XKhIdyahhtA91bVaZ42GOALdUx7EoiCBH3SKuA8YzTb193Uyj/En2C3PQs7RSSv1v8Z9CEOBHFPbDvs4dsduO6BOw0vIWR6s050G90yHR82MzhhmbyR+ZjlHMxvHoir03dP4Ok0LjTVUM35eK8U2POnfbGGeEMM1tevOyiLkVEH0hkHu0Dir6SzmU5WXMfd+ghazelhMTVn0PmAyWGhfu+4f/SKbnoqNLMbU+qZp0lcxqaZwxjmqq/0ESqCVyKz9tVX6mWiGFpgC5DDV5LsogGeJh27SE6i6NgSo1bZST+LTM8hkojaKy2hBwizEQ7gpZXG+geqDGfr7Jmll/CnPxQeE4sgqeSF0Qp3e9Aq5Z6nfH5XPTFyQFOPQLt+KSF5ggvtP112imdK2o7QwE2fpWcWdl/wI+9ds+TjqU+oE5zr5iExuBYvcGO8/4jvoS+W/eOWE5s4dpYy5Tdu9UhVcDxY9a//nwIunRlvXmlMd/olXSgWzpGxQoCJogw75HH/jFkPJy5jYvaEPFYwvdNaZpUA+GiklIis
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB3618.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199015)(921005)(2616005)(7406005)(38070700005)(38100700002)(31696002)(86362001)(122000001)(186003)(41300700001)(82960400001)(8936002)(7416002)(71200400001)(66476007)(316002)(5660300002)(66446008)(66946007)(64756008)(4326008)(110136005)(8676002)(76116006)(66556008)(26005)(6506007)(6512007)(53546011)(2906002)(91956017)(6486002)(478600001)(36756003)(31686004)(17423001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDRWdnZGT0paWndISHBIaDU5MVBEUTdZYzRrUE1PRzV3NkxoVjZFTFdzSzgy?=
 =?utf-8?B?RUxZZEtnTytaK1R1Z0QzRE9rNE9rYk9XdWR0TC82SVIwc01uSTB0bll6cXZp?=
 =?utf-8?B?SHRnRFVFeVEvaDJIMnorUy9sWE5HU2t1SmQvM2E2T0JsOXhYTjhlVzJFOWor?=
 =?utf-8?B?NWcxS2VqQUh2cCtOTzhKZTl4ajlXaFJsNUJPcE9Pa3BjMTF4a1FJTGZlMFF3?=
 =?utf-8?B?ZzNHZWNEeW5WT2NaY29hRWFaeEZxSkMrUEpCYjRXU3BadStoUHVqdm9GY1pJ?=
 =?utf-8?B?clhnem5hazhMR1FGdFhTRC9Pb3RPTVVyUDhOTHJjcVN5VDFvcWQxby9LT1dN?=
 =?utf-8?B?a3BBTWl4NDRjdCtvbG5DTEUxdjFnM0h2VjRXUm5uNVB3U1kwWG9BRVAyVktE?=
 =?utf-8?B?OThqRnVCMkY1VTNnZ0RRVWg1SitjY2lYeDhCbmZkbzIzd3JhekFxYW5hQmhq?=
 =?utf-8?B?WmpsYWRIZEZKcDhlSFhIMmJMY09YUUtCenRHWkc3cEpQU3hZdk80dk9WOGJY?=
 =?utf-8?B?RTFxYXZoR0czS2U4YVNFaklWRTJkc3Q2bytub2RoOEpHcldhYU1jTk1BU1p1?=
 =?utf-8?B?ZHNwVWs2VzNaaGVIbDFlcDFFMUNaMEdoMFNPM3NtbDZEdytwTmE5ZlVBRGJz?=
 =?utf-8?B?THVqYVNxcS9EeEFGckxjU0hrTGJHSDNQZGd2WXZCSytxcUxPZWordWNLd3Bi?=
 =?utf-8?B?Tmt6d2g1Q2QwYWxHeXd2MUxZRjVoQlc4L1JyeElPRWN1WjlPTWpUTFFWQWc1?=
 =?utf-8?B?SDhUYTQwcmlLbVZQMjB1aFZkNHVOSjNPeEQ5WUtTUlFCWEs4S3ArclJHOHpO?=
 =?utf-8?B?blhhZVVqRk42dUVLOXNGc29RQTQ3ZWZzUXp3bUoxNzdQMEpYcUp4M25BZTNj?=
 =?utf-8?B?YXdBVFJNWWp6N0g3SFY0ZmNIUFB4cmZMbnhwZEc2blp1WkNFNmNXZ0FzVFpw?=
 =?utf-8?B?dmpNUTZZMkJBQmtsR1FZNlJQRW1XVHMzUnJuUjJ5dnMybzhZcUV3RVd6d3BC?=
 =?utf-8?B?aHdQbFd1TzdxUGZRWlhGTlpLb0xYMzM5ZDM3bk1iU0o2WTJaazZ3UkJvUGt5?=
 =?utf-8?B?anNmSGVHSGl6TTNlcHRsODZkT3UvdFVpWnJ2Mjg1V3pnR0JqTFErSlJXWFBC?=
 =?utf-8?B?YmFSb21ScFNrVWlhUHlYU0F4MzRQRmpmU1MrTGdIMzd0a2RBK05zMG5CbE55?=
 =?utf-8?B?QkpHaDVDV0wrU09nNWg3WVdSZzUvZ0FzbXlZOE1UNm9vcU1CcUVXUHkrUURa?=
 =?utf-8?B?cWJLY09BTnRSamt6ZE9BRCtyd05jcWZTMS92MEZXbmNmcU04MEw0ZzdYb1dF?=
 =?utf-8?B?cytkWkxrTzZyTitKU2thUkZTdWNnSG4yRU5ZQWhsVUVNNXI5ellkL29CTWNy?=
 =?utf-8?B?T3RKYksxZ2FyRmh5dDN6SGNGcmptWW1OTnBDNmdmcWxxRGM2ZnplV3JqWUVO?=
 =?utf-8?B?azUzMUxWYTFHWXAyalg3eThBYmhWRWtTWlhzVHN3a1pMNVF0OFhJWVRtcEhF?=
 =?utf-8?B?NExuQnNmTitGMStrSEJtdWJqQ0pqL296TGsya2xmZEZOaXFSSllyR2xEcWFM?=
 =?utf-8?B?VUFrVHJQOXJVTjl5YzlUMFhaWWhpc0RKMXA4QmVDWlBua21SNEJQOUt0SG55?=
 =?utf-8?B?ZTc5Si9oeTVob3Ura2M4b09PZEdOb29vUzJURjc4eHRQdmg0TnpzdmhkY1Jr?=
 =?utf-8?B?Rk1tajBOZ1BzNXJoRkRKRWg1NFJ2eWIrZ3M5SlJIU3FGb1N3Wk5Gb1VEQmY4?=
 =?utf-8?B?ZmpzMWQ0c0tFbFVNd05GVThsUGNrVHNaTTBDUmdLL0hLWGNRSFNmbGxNZE5k?=
 =?utf-8?B?ZDJvU2tOMHNROFRoT21Rc1VLckMvMXN2SUV4QjBJMHZyRWE2UmFvK1A5Z1NX?=
 =?utf-8?B?QjlLbHlBTjhuQ3R6NFBFclgrR3RHMkpXN1JDZkRVbHVCY29QbkNZMU80M1VM?=
 =?utf-8?B?RFhsejZQREJXKzFDMjlyemxuU1VxZXM2VyszbnFCbGphK1JpU0MxSGIxSElK?=
 =?utf-8?B?cDFYdmxHS1R1N2liZEZFL0VySEhkMHIxQkoxVGhDdWR4cDliYUs3L1BRYzYv?=
 =?utf-8?B?R2gvNEhjT0dTUUhYdGttdWhmU0N0b25iZTIrSGMvN2QyYlRzQ2xGL0EwQUlE?=
 =?utf-8?Q?U5hMUPLYrRQ/XmlnVHdvqfDcU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <947B0D2AEB1F724BBDE479873A7CA653@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UDVQSHdJSzVBY2JYN205azB0Nlh0YlgwWTFFMnkzOTJqMUpFN0w2Tnp4OGhF?=
 =?utf-8?B?WkwxdDRwQW1KdkNDUVBlTlRHQ3NIR2tVNis1c28yWlZGRUlVSjhRbnFBWUs4?=
 =?utf-8?B?Nkt5dWR0NUVEb1l1Tm5UUzZxUXlSYXVWbTR4T0hCRE1MU3JObzBqa3V0WVpX?=
 =?utf-8?B?SDhoNnJwalQxZzJLR2NXblcrWkkwSDdHQ2VjQ0FlOWFHU0VhRHJwY3NvMTFM?=
 =?utf-8?B?N3U4ekRlS1VOdHZRaDZ4TjV0aU9tVFBhMW42TDdJSkxndEgzdTBtZk1NNERN?=
 =?utf-8?B?QjdLVkQzVUtSdFg5MGNlS1dTbmo3eEg4bUhudWo5bWxjbENLZS9vRGlScnlR?=
 =?utf-8?B?Q2xHVkhLbis2c0prN0xQeXBNTEZQNjM1Q05aYitjVnBGWG9wbjFOZGpxMHpa?=
 =?utf-8?B?dkpPZTVtU0VPZzhKOGRvdktpTjV1QkJYUnVPVzFxWkk5QTdYaUFmSTBCRGFa?=
 =?utf-8?B?cWpiaythak8xTEo3a0QyeFpMVkNvV0JKeWZTNmRiR25PYVg4WjRGY3J0T2t1?=
 =?utf-8?B?RlBocHpxMmorZEs3R3R5dUdOeGF3VitNbkpTNll3eGZ4TGMxQzlobFdhM3RX?=
 =?utf-8?B?bjZyeE04bncwbG1kaDhTK3ZUOThyYTJ5UUxFZVZ2RmcvRnhHemk2N3ZsTCtZ?=
 =?utf-8?B?WWZyVEk3ZTRsMFlUMlEzMXd0L1RSaE9OeHlmdGlETU05aTlST0laOWdrenpj?=
 =?utf-8?B?NVdvUG9nWFl4M0tPN1BPUnpwb25JTGZMTEFrMUVTakJQbldnWjBMOWdnQ2RR?=
 =?utf-8?B?MlN5cGtsbStudEhvdEZ4SXMvRVJEdXBWc2JOQ2pZd1dVcXIrTDVNSWEyaUx6?=
 =?utf-8?B?alFDa0l4czc4ODNCQ1N1S3BLQVJTT2ZzMWN3N3lONE5wWk1ueEhZQURQNFJw?=
 =?utf-8?B?SXp3MnI0dkkrbWpqZ2dPRTNGK1lvNGF4dk1SVzByTWZtb0RzMW9TL0tNUCtY?=
 =?utf-8?B?R1kxNy9KY2x1THFxTmhrUnM4bGJBeDZNR3ZDYTRIR1NmM0xsaVg0MDhqeHZa?=
 =?utf-8?B?cXdjcDBjMFJGNVUwQUFNSkwzakNONTlHakd3VUV5amFmTlpCZnJDbDVMMmZH?=
 =?utf-8?B?OUZDU2F3ZmFnbGhKN3Nlc1M2NmxUTk5BRFBJMkdOVEFNZEtFOHZkbmhvS3lp?=
 =?utf-8?B?ZmR1YmxVQXFYZXZYSnVFd0lVblBRS1dwNW9VQlVoYmQvaTdIOVNBYXJoNnV2?=
 =?utf-8?B?L2UvRUV4OTJac2VvSG5zaDMrUTdncisrNThWemIrOUJyYzRUMkRpeHJGYkZw?=
 =?utf-8?B?RElZNDcxbnJJa0FnaFg5blpIa2ZmeldFaWxybkpOaFNCbVJmWmxaazFXU2R2?=
 =?utf-8?B?Q2tGUVlMNUYxTG0ybHI3UkhMbzd0blNmTTlhSGRpUE1kLzBPeVlGMXBlaFgy?=
 =?utf-8?B?U3U2TWorSWRtWVpuWjhESzZxZ1doMkR3SjhiOXJxNS83ZTBRTEZZaUNndUlS?=
 =?utf-8?B?dkhydzdqNUZXTXF5SndzZC83VXp2VDBscEZPRzViUFhZK1ZLR3NITWEzbUJ1?=
 =?utf-8?B?RGErb3pkY0dFWVp2VTYwMDNGb3U3L2U0elkxV0NYSzhmckVIL3ovOHF0eUlX?=
 =?utf-8?B?YU5BY1ByQ2FkNDArL2VseHVTLytNNEVCZDNBOFFCZjdHSTJTMXNMZzJmMklS?=
 =?utf-8?B?NEdmQUV0dEt5cEU5YzlBMDJVMUZ3RkR4RzRVS0UyeXB5VXRMMHhmNHF2NXZL?=
 =?utf-8?B?bDAyb0lqeWFmTTdPZVhHZXg3ZGR4cnlDN2d0aE5HZmEyTWVwV3dUL2lXanZo?=
 =?utf-8?B?ZWRnQlFmNFQ5eXNDcDQyWTE3UzNKQnBTNEg0R1VwVXdIaE9PbTc1cmNXai9j?=
 =?utf-8?B?c01XWHhGRlRvS3ljWnNDSDRNM0tKcnY0RXlwbS9maWhFNWMvM3JkS0NtNmJq?=
 =?utf-8?B?V0JnK3M1dVcwVFpmM3lKVGdycnV5bzQ1S3AvNy9UQ1FXcDQ3VGZEN3BUZmRi?=
 =?utf-8?B?WmJNbEg1TlJlcm5HZTFlZ1lzc0M5dFM3NjJmVEdEQm9iYmYvWGRrU0thVmxJ?=
 =?utf-8?B?TExpSGw5UGdGSlRIc2s4TzZBbUdLVlZvZ0I2ek1XZGcwaVVRTVlLaVNFRGc3?=
 =?utf-8?B?K0JuMENmTFVCOVRsMzNHY3AvT3I2bVN5aXM2alpON1JHSjRJVnlDckszWC9X?=
 =?utf-8?B?cFFnTmtONzliMk1QQXpZb0RuK1lBSkdaUWJsZ25PRjkrcnI2L00xekNzR0Nw?=
 =?utf-8?B?VWNXWWZmK2c5UlkvcDRVdUJWUTJYOWt2cThsZys0cndERmtzQ1VJdWZjam1F?=
 =?utf-8?B?VTZYeUdmSTRPdjdPenZJQkJMbDRsYThnRGNkZ1pmaFpYRmd6ZDdTZ2lFeWRa?=
 =?utf-8?B?elBrb1I5VHMrcHpMcWxkQXFkRFRreklrbnR5NEM0MHZXaDFnR3FKaXQxcGdm?=
 =?utf-8?Q?Ej7V5l5Tqud5CnJ0m1kxUWPF1Y5+P2XYJ7cP+zFKJdLut?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: u19Q231VMWvRTcSPvLXe6+5YUuYrNL9yoaUtMUd9KRVhLZmF+E6Z12BSEdB122wVT3s/TuGAXz4Engx8pptioJ/vpZNredYJVhA7fSLJZZXnQ5sxOdEM3XIEKBoGT/+WTKRUdWy8pGZIMFGH+F+eCttEw/OJWODGVpI=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3618.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942cc831-42a5-4603-d816-08daa725104f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 22:58:05.5018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dV9BomRwk7lfGZtg2j2zGE7xze9G6EzYCyLnK2PP3R44IxV1/CBs/abi+Ype0OGmnFp+qynmT8moDalxTiJXWwkl1Uzsvtr5x3p7NTTVf7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5814
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDUvMTAvMjAyMiAyMzo0NywgRWRnZWNvbWJlLCBSaWNrIFAgd3JvdGU6DQo+IE9uIFdlZCwg
MjAyMi0xMC0wNSBhdCAwMjo0MyArMDAwMCwgQW5kcmV3IENvb3BlciB3cm90ZToNCj4+IE9uIDI5
LzA5LzIwMjIgMjM6MjksIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPj4+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9zcGVjaWFsX2luc25zLmgNCj4+PiBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaA0KPj4+IGluZGV4IDM1ZjcwOWY2MTlmYi4uZjA5NmY1MmJk
MDU5IDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMu
aA0KPj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaA0KPj4+IEBA
IC0yMjMsNiArMjIzLDE5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjbHdiKHZvbGF0aWxlIHZvaWQg
Kl9fcCkNCj4+PiAgICAgICAgICAgICAgICA6IFtwYXhdICJhIiAocCkpOw0KPj4+ICAgfQ0KPj4+
ICAgDQo+Pj4gKyNpZmRlZiBDT05GSUdfWDg2X1NIQURPV19TVEFDSw0KPj4+ICtzdGF0aWMgaW5s
aW5lIGludCB3cml0ZV91c2VyX3Noc3RrXzY0KHU2NCBfX3VzZXIgKmFkZHIsIHU2NCB2YWwpDQo+
Pj4gK3sNCj4+PiArICAgICBhc21fdm9sYXRpbGVfZ290bygiMTogd3J1c3NxICVbdmFsXSwgKCVb
YWRkcl0pXG4iDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgX0FTTV9FWFRBQkxFKDFiLCAl
bFtmYWlsXSkNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICA6OiBbYWRkcl0gInIiIChhZGRy
KSwgW3ZhbF0gInIiICh2YWwpDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgOjogZmFpbCk7
DQo+PiAiMTogd3Jzc3EgJVt2YWxdLCAlW2FkZHJdXG4iDQo+PiBfQVNNX0VYVEFCTEUoMWIsICVs
W2ZhaWxdKQ0KPj4gOiBbYWRkcl0gIittIiAoKmFkZHIpDQo+PiA6IFt2YWxdICJyIiAodmFsKQ0K
Pj4gOjogZmFpbA0KPj4NCj4+IE90aGVyd2lzZSB5b3UndmUgZmFpbGVkIHRvIHRlbGwgdGhlIGNv
bXBpbGVyIHRoYXQgeW91IHdyb3RlIHRvICphZGRyLg0KPj4NCj4+IFdpdGggdGhhdCBmaXhlZCwg
aXQncyBub3Qgdm9sYXRpbGUgYmVjYXVzZSB0aGVyZSBhcmUgbm8gdW5leHByZXNzZWQNCj4+IHNp
ZGUNCj4+IGVmZmVjdHMuDQo+IE9rLCB0aGFua3MhDQoNCk9uIGZ1cnRoZXIgY29uc2lkZXJhdGlv
biwgaXQgc2hvdWxkIGJlICI9bSIgbm90ICIrbSIsIHdoaWNoIGlzIGV2ZW4gbGVzcw0KY29uc3Ry
YWluZWQsIGFuZCBldmVuIGVhc2llciBmb3IgYW4gZW50ZXJwcmlzaW5nIG9wdGltaXNlciB0byB0
cnkgYW5kIGRvDQpzb21ldGhpbmcgdXNlZnVsIHdpdGguDQoNCn5BbmRyZXcNCg==
