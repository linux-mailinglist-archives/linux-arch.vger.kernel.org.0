Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C195FEFEF
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 16:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJNON1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 10:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiJNON1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 10:13:27 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120087.outbound.protection.outlook.com [40.107.12.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837931D2F74;
        Fri, 14 Oct 2022 07:13:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClIJjXcv+UK98eOb5h657C9NLw3fN4Q4XPw5TE6LE+XujqnlrJm37HO6ojTZDsgXKhJQWEBq2rM7+FC0L282iL5FmM2QiO+h+1vqZon6zlmhKO6dyMUQ0Zb8dgyXO+xCfnI3LNaioOYxsu02aNEj+lm014o5cfI2ERue8JS3eWdIxuZdgNUYbQkKhTmKAZ0c7JUZV141Ev0ePlJ6rK+QNzQn1LCtAmxuvsW4y+R2QbWgLsb7Nj1ms1AGhV0HIX6+/8LbHp/ov5TbYldkWe/Bsxx3lnWA44vxVfWi4+d5PdeuI1Qid1eFwVhbi1Q/tzxatppR8LVEghq4GKGwuxlg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mceC29l5+ymhj75Oa1TPnuL2rE5w3rijgZK53PzPVGs=;
 b=TrRuHxm0Au0Chex6IL+TkkloWnvIEB/KE/jhTf/H+N1TRTuamw7zxa6Eg4bzLRm81EwPJUfyldXobA/3rqMquGYQ97UmD19V/w7dXO7UtOQjgZ5lBdlrby/UGG5UWbe5nbRGlLxqjpbKuGWQERCTpAhMCmMa9DcSlTF4iEtlB/wNuOtQctbOTrYGXVIImh0YhnkNCuZp/Yim+624Y3XXjm+qvtqbcEkQzL04ZnO0MrT7K2Kawnxewq64vhCrloEwhabWil4Pigx1O0qrNJxoXLO6pXiXPB+YuzGCCBt25kunQlYeUiabaH+en5dpNrGDsA+CQwRgjvcmEV4ucpVarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mceC29l5+ymhj75Oa1TPnuL2rE5w3rijgZK53PzPVGs=;
 b=Xdq2GsMqJsYqAvJKZeFQ3iOO+y6C6m1TrH1z8rfmIUtg17Caya8DjSnqi+FZilJbuPcsyJ4vBFGnqkRC//Ktd9XmxZlQ5G0yTcZGd7uBZXJmrkvW9bje5Mzy88wuD2QyyicMpsuUM3NUCVaC2dy733DsDS8e4GcFyrMUiSwrqYfAnApa2Og6b7l3ixp/IXyYjBqbh0+oUqN0d2GFjcULpLr7upKjnwD7knKE8tZcieD3k/Rf1s08C92as4YJ+qsmVACPRhaGK2wqHqNY6jnCzHzQfPqjdxEBjrRmpe4kHnbNMkbww80VQNnGw/xAWI5vbaFu554SL5EB37naOM4SHQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3210.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 14:13:20 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af%6]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 14:13:20 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Davide Ciminaghi <ciminaghi@gnudd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 0/9] gpio: Get rid of ARCH_NR_GPIOS (v2)
Thread-Topic: [PATCH v2 0/9] gpio: Get rid of ARCH_NR_GPIOS (v2)
Thread-Index: AQHYvsmBxynpZuGTuEmTfLBqWwtXK63Twy4AgAAEhACACyiggIAABvgAgC85UAA=
Date:   Fri, 14 Oct 2022 14:13:20 +0000
Message-ID: <da8e0775-7d3e-d6fa-e1ff-395769d35614@csgroup.eu>
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
 <CAMRc=MehcpT84-ucLbYmdVTAjT86bNb9NEfV6npCmPZHqbsArw@mail.gmail.com>
 <b348a306-3043-4ccc-9067-81759ab29143@www.fastmail.com>
 <CACRpkdbazHcUassRMqZ2oHmama3nWEZ3U3bB-y-3dmo3jgFPWg@mail.gmail.com>
 <a7cb856c-8a3f-4737-ae9e-b75c306ad88e@www.fastmail.com>
In-Reply-To: <a7cb856c-8a3f-4737-ae9e-b75c306ad88e@www.fastmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB3210:EE_
x-ms-office365-filtering-correlation-id: cff2d154-6f72-4f52-40f0-08daadee3faa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pnh7Q/ExjYvIUvqM+ilPIbCPe0v737CzKRreG/4XPoyKr7bn0ufZMzm4nKNPBJJDFI3ThqR/zohqp5MpJ4D1ClM6fLrYOGgO0GfxEWDznIcbd5Eu4Tx25DkUQe8MkhrR/YObidW63SFTUG8OwT6x88VFO3rFrG36NQAdp2x4Y82Mtln5VhbNwUV4FanX4Vcd9fGIxQu0ojYPEGfdxrdYpA4lTebzqL0aQSjBfx/H25sgZwt1Tu4LRh+bvNF0v7UejylIxeLef8uO2hxNT65zT6+O4kbNhSeL5I2F8GRGi29/PYAd1BBc++JRDm0MABwUYPtd4NGYQTT8YW5SAYkds8XtPrRTF4+fGBii4q1PsHQfWoV1mh3wbSuHxlu/IuvRAy7auqVa470H27zOvMLgVhdk7hXieI+Ypy59PLrhKqRQs04gSg7pGysdItwSYv+qD2hPl4VUMVxNxVPfwu7zidf5i0HiTYxKNEhlbdfqn6AAgnEd5mIKWlpxW8s98NN0DpL6k7xvfCVKLfIBUzS/eJQxMZS6bWN3W23618VZ4BAIN9/+dcILcDNz5UZK6f6hzTKa+y+qTYmbEJ3KPncRH57u/VfBGVXM1Xh1M0wPkUg/Eg4ic8FPIif3K5jt7WJe4qUjm29c50W5sKNqiTNQ9Vq5NApiR9djN1L7IXD/lE3/oV0q6IThnph/p8ClIYCTQ6GfU9Sbw153PL0DEFB//X273zQESYgSFn/Tv/CXh24vuxi3sNbXHjmOd4janrcH/EljFfkMprBEqMYAzQ+WMc3+Hj60O76rPjFa8ABAfRXKSj6BzWnyRLBsRD4S6G+9mUe7eeMMNxcuJaWTsG522U8FEwgGbLYV53Cu6kMlaMS8AGz3kzsa+5iaIkrfLg7gIxrz5t6ethBwTEy/p0ZZ9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(8676002)(2906002)(31686004)(8936002)(76116006)(316002)(41300700001)(4326008)(66946007)(66556008)(66476007)(91956017)(110136005)(54906003)(66446008)(64756008)(71200400001)(478600001)(966005)(6486002)(38100700002)(122000001)(6506007)(26005)(53546011)(6512007)(2616005)(7416002)(5660300002)(44832011)(83380400001)(31696002)(86362001)(38070700005)(36756003)(186003)(26583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2d2bmltMXJ4Z2xxa040bzZaNUo1cGU0VUtIZ1ZoRngzMll3UDIvakV0YUY2?=
 =?utf-8?B?YnZ4QXdCZ0RjWG1HbDB3eGhkVWlvc290dS9USHJQaGtkekFSbVREck5sUkVs?=
 =?utf-8?B?emIrQUNXa2orUHUxVGxrT1k2ZjhXN1h5bWlsRks0MDBYWGNZN3k4V1kyQUZl?=
 =?utf-8?B?OUxEYXhkUzk2YXBDaGlkWW9YQlprcGtvYjZLSkVuaXdJWW93ODZEdVlZZ3U2?=
 =?utf-8?B?Ly8wUW5VMkRmZ2FjczcwdHBvQnJzR0t2d3ZQQ01sdjdFYjRtUGtXRHA2c3hO?=
 =?utf-8?B?QlVmNEJkcm81WXIwRFphN0lTZEFaZWl0NDhiOU5sdDhlaUt0OXdkYmUvS3ZU?=
 =?utf-8?B?bVIrU1BXQnE0VFQ2OWNvK0NqcnZlQWk5MGQvempqb01oZ1Nod2l4SnErREhv?=
 =?utf-8?B?VUhaNHZOVnZXYm5nVjdWOERxRWN3Nk1ycTJJQnV2aVBSVU1IVk5tV2dYbHQ4?=
 =?utf-8?B?cXYrQTBOTVRpek1vM2h5THJsWXNUcmlxNnRMSmtab2ZGU0NUdHczSXVUZGlD?=
 =?utf-8?B?SzVhZHIwMTRwWmpmWndsOHIwSmJTeG42bWFld2x0STByR1ZBQXF5Wm9UdSs4?=
 =?utf-8?B?SFliVkVCYzFwSzVWU2ZKSGx2V3loWGdVbFlRWXVmbjVBdm9NMzd2dUFaQU9Q?=
 =?utf-8?B?R041UjlYcG5WRExnekE2c2dzc09seXIvS1hpUmR5VkQ5QWtxYktoSXJQSDNz?=
 =?utf-8?B?cnVHY0xBMVREQzBJN1pEYnpMQXRNeWMrVHBmY29aY0FzZm4yV3Uva1gyYkRq?=
 =?utf-8?B?RWJhOFY1SEJwV0kxcGNML1dvZldMUjhtOEZWazk0SkJ6UnJ4S1I1TUVBTUhw?=
 =?utf-8?B?dld4NnNoeGdtUDVJZHkxeVBsdVhTMkxEYlExcUEvYllxSVFoUk82dC9ONmlw?=
 =?utf-8?B?WmNJZU5XYi8rQlcwR1ZKeEptZnIvMW1EbE1DS2ljQkw3OEJIbUx2bmt6VE9T?=
 =?utf-8?B?U3ZDYTRYa3JXT3ljYWlBZUh4TTBBdDdRSnN4dHpCZlE2dTBEMEJNQXRiQjRa?=
 =?utf-8?B?WE9GYkk4anpUbWk1OHZON1Nid1dCOEJYelhYcmZ2RzZTRnN0NGlSL0Y0K0lm?=
 =?utf-8?B?YW1vNUs3eW9udEo4TElrMklHZUkrdjJnNWdwVURuUnE2U09kbldaQVlsWE5P?=
 =?utf-8?B?bFpwMWhQak16Z3UxbGQrckgzV3ZTM1g2ak13dEY0NUJXdlVJTVJqbDRpUG5z?=
 =?utf-8?B?UzkvcmpDc2sxVnBvNjl5ZUJJOFo5T01jTGpZSWc5bDJCYTYrYXZ2Z0Q2ZGxa?=
 =?utf-8?B?QVE5Nlk4Mnh5ckpra00xRGt6bnBIZDVhelJaMDZtWndCNFpFWGZkbnJYSUJJ?=
 =?utf-8?B?Rm8rTy9OeE1LV0pUWHBCVEt1NEhuUFhWTDgxSmlNK2RhUlhVb1ZXZnltNE9v?=
 =?utf-8?B?YWExNzk2dmVzUG9QUEczMnJQYXE5SXZHYTBkUThWYkpMSlNld0xQZkZBMmwy?=
 =?utf-8?B?Tis3R2dQcXdsd0xDaVNLa2l5YllQWFlsQy9RcmJ6UmdSOXAzSVE5cVJBSGll?=
 =?utf-8?B?OVlIRFE5MWROMnJ4VEtFbEpTYndSMWQvTnR4U29VSFYrTnNtd3EvZVFZZ2th?=
 =?utf-8?B?ZG5PM2ROZnNkU2dvUFEvSkxKdFNuZmVBamh6UUdFaUtOaitiQURXTGc4ekYx?=
 =?utf-8?B?blVRNUgzWEZWY2JuWW02NmxYNmRGa2UvQzJmM2hhRDZ2ZnNPZklWYURVQUJZ?=
 =?utf-8?B?RmxQMjkraVpJVEJKbG9SdW11SDlNOW1ZaWh4UzU0ZGc1MnZJR0gxZ0x2eDMx?=
 =?utf-8?B?aDljaXduaUdlcm03RDRBYkhxNDhlUVhMS1JkdWVwTmtVQkNrMVg2NlBSMzBo?=
 =?utf-8?B?Q2lrRUZCcDJOT2J1Zi9GN1ZmY0VIdjJtUW90cEdJTm9UU3YrY1FNRVg4QlM5?=
 =?utf-8?B?ODBjTWR2QjlxNXJaTUpra0hKa1Fjd05MampvT0wyUkNoVkZqbmFPK3pnODB4?=
 =?utf-8?B?SlNDdFNyeG1sT09qRml0WEpDNjlRc1pZUDFPY2hKa05SMFdYdG9PSkVxa0Ey?=
 =?utf-8?B?enVzVWs5dVQvaSt6RTdmeUpzVnd6WkE4ZkZsNjhWbUhvSG93MWJVSm1HQURt?=
 =?utf-8?B?K3pMZHhpaWJwVW5SNlBnQUtjT3JaYWNGVnVpZzhRQTlCcE1BbHBsaEttMEds?=
 =?utf-8?B?dUQ5ZEpjNUdjTmxVdmlYdVhLaHptSldjS1VsSFNBL0dNL05RTWQzMU9uUm1v?=
 =?utf-8?Q?CL6+KHr2CbnbiKiERGS1U8c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <125723A7FC9FE54B999FDF3F8EA579EA@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cff2d154-6f72-4f52-40f0-08daadee3faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 14:13:20.7665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7r0RjZtKTCMKUBATE4QdMTTgJzOIup5JwRVVBU+DbjaXaFijaTwPdtBXbm3REAasd7PyrAssAzCjvPIAJC5AS8UdW7GHEcgw5AUSvCSTYU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3210
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgTGludXMsDQoNCkxlIDE0LzA5LzIwMjIgw6AgMTU6MDMsIEFybmQgQmVyZ21hbm4gYSDDqWNy
aXTCoDoNCj4gT24gV2VkLCBTZXAgMTQsIDIwMjIsIGF0IDI6MzggUE0sIExpbnVzIFdhbGxlaWog
d3JvdGU6DQo+PiBPbiBXZWQsIFNlcCA3LCAyMDIyIGF0IDEyOjE1IFBNIEFybmQgQmVyZ21hbm4g
PGFybmRAYXJuZGIuZGU+IHdyb3RlOg0KPj4+Pj4gICBkcml2ZXJzL2dwaW8vZ3Bpby1zdGEyeDEx
LmMgICAgICAgICAgICAgIHwgNDExIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAoLi4uKQ0K
Pj4+IHN0YTJ4MTEgaXMgYW4geDg2IGRyaXZlciwgc28gbm90IG15IGFyZWEsIGJ1dCBJIHRoaW5r
IGl0IHdvdWxkIGJlDQo+Pj4gYmVzdCB0byBraWxsIG9mZiB0aGUgZW50aXJlIHBsYXRmb3JtIHJh
dGhlciB0aGFuIGp1c3QgaXRzIGdwaW8NCj4+PiBkcml2ZXIsIHNpbmNlIGV2ZXJ5dGhpbmcgbmVl
ZHMgdG8gd29yayB0b2dldGhlciBhbmQgaXQncyBjbGVhcmx5DQo+Pj4gbm90IGZ1bmN0aW9uYWwg
YXQgdGhlIG1vbWVudC4NCj4+Pg0KPj4+ICQgZ2l0IGdyZXAgLWwgU1RBMlgxMQ0KPj4+IERvY3Vt
ZW50YXRpb24vYWRtaW4tZ3VpZGUvbWVkaWEvcGNpLWNhcmRsaXN0LnJzdA0KPj4+IGFyY2gveDg2
L0tjb25maWcNCj4+PiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zdGEyeDExLmgNCj4+PiBhcmNoL3g4
Ni9wY2kvTWFrZWZpbGUNCj4+PiBhcmNoL3g4Ni9wY2kvc3RhMngxMS1maXh1cC5jDQo+Pj4gZHJp
dmVycy9hdGEvYWhjaS5jDQo+Pj4gZHJpdmVycy9ncGlvL0tjb25maWcNCj4+PiBkcml2ZXJzL2dw
aW8vTWFrZWZpbGUNCj4+PiBkcml2ZXJzL2dwaW8vZ3Bpby1zdGEyeDExLmMNCj4+PiBkcml2ZXJz
L2kyYy9idXNzZXMvS2NvbmZpZw0KPj4+IGRyaXZlcnMvbWVkaWEvcGNpL01ha2VmaWxlDQo+Pj4g
ZHJpdmVycy9tZWRpYS9wY2kvc3RhMngxMS9LY29uZmlnDQo+Pj4gZHJpdmVycy9tZWRpYS9wY2kv
c3RhMngxMS9NYWtlZmlsZQ0KPj4+IGRyaXZlcnMvbWVkaWEvcGNpL3N0YTJ4MTEvc3RhMngxMV92
aXAuYw0KPj4+IGRyaXZlcnMvbWVkaWEvcGNpL3N0YTJ4MTEvc3RhMngxMV92aXAuaA0KPj4+IGRy
aXZlcnMvbWZkL0tjb25maWcNCj4+PiBkcml2ZXJzL21mZC9NYWtlZmlsZQ0KPj4+IGRyaXZlcnMv
bWZkL3N0YTJ4MTEtbWZkLmMNCj4+PiBpbmNsdWRlL2xpbnV4L21mZC9zdGEyeDExLW1mZC5oDQo+
Pj4NCj4+PiBSZW1vdmluZyB0aGUgb3RoZXIgc3RhMngxMSBiaXRzIChtZmQsIG1lZGlhLCB4ODYp
IHNob3VsZA0KPj4+IHByb2JhYmx5IGJlIGRvbmUgdGhyb3VnaCB0aGUgcmVzcGVjdGl2ZSB0cmVl
LCBidXQgaXQgd291bGQNCj4+PiBiZSBnb29kIG5vdCB0byBmb3JnZXQgdGhvc2UuDQo+Pg0KPj4g
QW5keSBpcyBwcmV0dHkgbXVjaCBkZWZhdWx0IHg4NiBwbGF0Zm9ybSBkZXZpY2UgbWFpbnRhaW5l
ciwgbWF5YmUNCj4+IGhlIGNhbiBBQ0sgb3IgYnJpZWYgdXMgb24gd2hhdCBoZSBrbm93cyBhYm91
dCB0aGUgc3RhdHVzIG9mDQo+PiBTVEEyeDExPw0KPiANCj4gSSB0aGluayB0aGUgZXhwbGFuYXRp
b24gZ2l2ZW4gYnkgRGF2aWRlIGFuZCBBbGVzc2FuZHJvDQo+IHdhcyByYXRoZXIgZGV0YWlsZWQg
YWxyZWFkeToNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvWXczTFFqaFpXbVph
VTJOMUBhcmNhbmEuaS5nbnVkZC5jb20vDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
WXczREtDdURvUGtDYXF4RUBhcmNhbmEuaS5nbnVkZC5jb20vDQo+IA0KDQpJIGNhbid0IHNlZSB0
aGlzIHNlcmllcyBpbiBuZWl0aGVyIGxpbnVzIHRyZWUgbm9yIGxpbnV4LW5leHQuDQoNCkZvbGxv
d2luZyB0aGUgQUNLIGZyb20gQW5keSArIHRoZSBhYm92ZSBleHBsYW5hdGlvbnMgZnJvbSBBcm5k
LCBkbyB5b3UgDQpwbGFuIHRvIG1lcmdlIHRoaXMgc2VyaWVzIGFueXRpbWUgc29vbiA/DQoNCkRv
IHlvdSBuZWVkIGFueXRoaW5nIG1vcmUgZnJvbSBtZSA/DQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ==
