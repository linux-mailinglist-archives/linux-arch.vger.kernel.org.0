Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C33F36D9CF
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbhD1OtX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 28 Apr 2021 10:49:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:22054 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238429AbhD1OtW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 10:49:22 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-213-Q40LSYhmNgio6b75f9Ipug-1; Wed, 28 Apr 2021 15:48:34 +0100
X-MC-Unique: Q40LSYhmNgio6b75f9Ipug-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 28 Apr 2021 15:48:32 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 28 Apr 2021 15:48:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yu-cheng Yu' <yu-cheng.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
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
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        "Haitao Huang" <haitao.huang@intel.com>
Subject: RE: [PATCH v26 0/9] Control-flow Enforcement: Indirect Branch
 Tracking
Thread-Topic: [PATCH v26 0/9] Control-flow Enforcement: Indirect Branch
 Tracking
Thread-Index: AQHXO6ae1Nsozyj+DkCGokhshY0p/arKAkvw
Date:   Wed, 28 Apr 2021 14:48:32 +0000
Message-ID: <0e03c50ea05440209d620971b9db4f29@AcuMS.aculab.com>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
In-Reply-To: <20210427204720.25007-1-yu-cheng.yu@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu
> Sent: 27 April 2021 21:47
> 
> Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> return/jump-oriented programming attacks.  Details are in "Intel 64 and
> IA-32 Architectures Software Developer's Manual" [1].
...

Does this feature require that 'binary blobs' for out of tree drivers
be compiled by a version of gcc that adds the ENDBRA instructions?

If enabled for userspace, what happens if an old .so is dynamically
loaded?
Or do all userspace programs and libraries have to have been compiled
with the ENDBRA instructions?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

