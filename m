Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C37ACB14
	for <lists+linux-arch@lfdr.de>; Sun, 24 Sep 2023 19:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjIXRcF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Sep 2023 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjIXRcD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Sep 2023 13:32:03 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528EA109;
        Sun, 24 Sep 2023 10:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1695576696; x=1696181496; i=frank.scheiner@web.de;
 bh=1jVLbmeGm1r0R9T377qSsQRKRbGQva98bCeYistbNgI=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
 b=kWDtqL9DpmRkQOKNqZ9cHjWFqNWMjeb0Qww62nop+Q6/eYk+WeOMEjV0I0axUdr8jEnOT4DNpHD
 8cQtB6dicKwPjuYbkQOkQLJlR1XqSNztMNniJSV66hixTffJHhlmBAW9kzmq8Jl3woZOr6ZvP6D0D
 cmWkKeUqUb58CEsXXuw+Jy9E+ZgP0Y98gxGe0OPsrQaCAmT4Ofo9lU3ilwnOMSNOZ9yRZpTCq8WdN
 P42X0KGCOJL/ZWrfxqcDB1dSxbHOhgKcAIDGCJ3RWzDX1vc0QLkDV+ieUxmg5Jbs3Q6qvUjmZnMUy
 djlsau7dSYljzIj8fujdP4Gvr3k72ubBfFow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.30] ([217.247.45.129]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xeb-1rgVHH07mt-01558g; Sun, 24
 Sep 2023 19:31:36 +0200
Message-ID: <273eb7ed-9897-2350-946e-989f586580bc@web.de>
Date:   Sun, 24 Sep 2023 19:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: ia64 maintainership (resend)
To:     =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>,
        linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org
References: <CAHtyXDfvS4OYLjOqALy74vR4w9DOFjJ9z8UOFeDpyjv7_PHNXw@mail.gmail.com>
Content-Language: en-US
Cc:     debian-ia64 <debian-ia64@lists.debian.org>, ia64@gentoo.org
From:   Frank Scheiner <frank.scheiner@web.de>
In-Reply-To: <CAHtyXDfvS4OYLjOqALy74vR4w9DOFjJ9z8UOFeDpyjv7_PHNXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:WW6qauD397rf+lResLrpQoEGPBbd5qCvMzilH4Byx+EYEMPznLb
 Pa/uOK1cgyjDSKz8xydPrImDVhZDSiQ10DfVMJFUMIvTJHYuRBmsbhyHhFNpX0/BtvGbNE+
 jRsgRyam/vsSD0BY+jdfobCLp4dRhQSknbwkrPEp7/WAQ2MVh2LHj/MWIvVroybSz5VLOrK
 EYGARg+2jW3xmQs+KV7vw==
UI-OutboundReport: notjunk:1;M01:P0:hpOc7Tu/cIw=;0EAdEcRraaywO3tELkhnVeHU5jq
 dS8lHqi05CKdwb6xr8lydKOCjNSMhh60Gv6PY/cH5jS7CwtganMJzLjlbE14+836sOrxLHeMg
 Z8WX022tbBJZiWJOfH5m03WE2OW+y+OCFbNM995Qyz7LJ9tmFs62HrNBuCSLdpcAJPtVlkUrb
 i6LuQTI9FsGJb2ciZXyz+PjglL/WNmwdUQg0y0zw7iM6+VWU+uJmuA5kaGWHjVlRUBKxdVEpa
 e8GL8QjlYqvfYBIKQDOLszPIMMCJ4obSp2z0MznX5DaYzZ+2xmEi9R9TtbEEsrvL26jub9sjB
 0pzdkoEjgFIKcjyw/UUTME/p5giXvTRUmKNtoQ3GH/g3FnZ4DvcbXbKMkyR7CataZOZocB89J
 lXy58mrKrVCEkiRG7An02w+sAsdI36DDLaHqk+7aAyiQNCNELfILP6EmHfubyreaUwv2+/x6S
 utKPUnUofq4NfcH1oiykJucn+cTmKtJuGXBpkGBkm6CNPo6oiKbM/+/jaON+9NE8lMHTWGWpn
 k/pNVOJNJKUk+EfOkA8V9Mnt3YcJiaQ4rtqXoQ2ixoCz6nqwv2M6+5Yr5xYpGU7S85kBTR+UB
 wEQZK3HbpiwckVgZRLLAzoswVcd4MySWyu5mqfF6MSlAUzLVcE/p1ssIyXgJE6TbOzoAzn8on
 BhqTsne/CDdTLXHbFGEue+1zhIICI+h77bsp3kDpOKgepJ3As1cb428ildrO24VdUoYNOrOmT
 3aahcNhRyfBv9YrvkWcT5GdJbvK4ZrcWJnfJo3Mw/S50KfvNYCPD2PfvCr10rGVr7FO6Mf5BB
 Loh2FzRj1UkmjLZUK9t2a+PMh0bNu96ctdG27JG5l/piRs/kWmUpYBTmHpD4U7tdG+SLZA4lV
 p7AcbC4wEBXGzti86u+6Qkm2YqCu1uJ5tjAbmhrc1Yt8GaxmPiXLfhHYHBdJoTchkTfVhHGA1
 BoQh7gBzNM3AEn1ER2e3fJlBfv8=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RGVhciBUb21hcywNCg0KT24gMjQuMDkuMjMgMTk6MjAsIFRvbcOhxaEgR2xvemFyIHdyb3Rl
Og0KPiBIZWxsbyBsaW51eC1pYTY0LA0KPiANCj4gSSBub3RpY2VkIGZvbGxvd2luZyB0aGUg
bmV3cyBvZiB0aGUgcHJvcG9zYWwgdG8gcmVtb3ZlIGlhNjQgZnJvbSB0aGUNCj4ga2VybmVs
IHRoYXQgdGhlIGFyY2hpdGVjdHVyZSBoYXMgbm8gbWFpbnRhaW5lci4gSSdkIGJlIGhhcHB5
IHRvDQo+IHZvbHVudGVlciB0byBtYWludGFpbiB0aGUgYXJjaGl0ZWN0dXJlLCBzaG91bGQg
dGhlIGRlY2lzaW9uIG9mIHJlbW92YWwNCj4gYmUgcmV2ZXJzZWQuDQo+IA0KPiBJJ20gbm90
IHRoZSBpZGVhbCBjYW5kaWRhdGUsIHNpbmNlIEkgbmV2ZXIgY29udHJpYnV0ZWQgYW55dGhp
bmcgdG8gdGhlDQo+IGNvZGUsIGJ1dCBJIGhhdmUgYW4gSXRhbml1bSBtYWNoaW5lIHJ1bm5p
bmcgTGludXggdG8gdGVzdCBvbiwgc29tZQ0KPiBzcGFyZSB0aW1lLCBhbmQgSSd2ZSBjb250
cmlidXRlZCBhIGZldyBwYXRjaGVzIGFzIGEgcGFydCBvZiBteSBqb2Igb2YNCj4ga2VybmVs
IGRldmVsb3BlciBhdCBSZWQgSGF0Lg0KPiANCj4gSSdtIGFsc28gYSBjb250cmlidXRvciB0
byBUMiBTREUsIGEgc291cmNlLWJhc2VkIGNvbW11bml0eSBMaW51eA0KPiBkaXN0cmlidXRp
b24gc3VwcG9ydGluZyB2YXJpb3VzIGFyY2hpdGVjdHVyZXMgaW5jbHVkaW5nIEFscGhhLCBI
UA0KPiBQQS1SSVNDLCBhbmQgSXRhbml1bS4gSSBoYXZlIGludGVyZXN0IGluIHRoZSBhcmNo
aXRlY3R1cmUsIGhhdmluZyBkb25lDQo+IHNvbWUgZXhwZXJpbWVudHMgb24gaXQgd2l0aCBj
b2RlIHBlcmZvcm1hbmNlLg0KPiANCj4gVG9tYXMgR2xvemFyDQo+IA0KPiBQUzogT3JpZ2lu
YWwgZW1haWwgZ290IHNlbnQgaW4gbXVsdGlwYXJ0IGZvcm1hdCBieSBtaXN0YWtlLCByZS1z
ZW5kaW5nDQo+IGFzIHBsYWluIHRleHQsIHNvcnJ5IGFib3V0IHRoYXQuDQoNCkdyZWF0ISBJ
J2QgYmUgaGFwcHkgdG8gc3VwcG9ydCB5b3Ugd2l0aCBteSBrZXJuZWwgdGVzdGluZy4NCg0K
QWxzbyBDQ2luZyB0aGlzIHRvIERlYmlhbidzIGFuZCBHZW50b28ncyBpYTY0IGxpc3RzLg0K
DQpDaGVlcnMsDQpGcmFuaw0K
