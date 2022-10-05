Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8D35F5574
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 15:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJENdC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 5 Oct 2022 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJENdA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 09:33:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D027A745
        for <linux-arch@vger.kernel.org>; Wed,  5 Oct 2022 06:32:58 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-220-Ey5VsqheNgyO3SFDIVsBNQ-1; Wed, 05 Oct 2022 14:32:55 +0100
X-MC-Unique: Ey5VsqheNgyO3SFDIVsBNQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 5 Oct
 2022 14:32:53 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 5 Oct 2022 14:32:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>
CC:     'Dave Hansen' <dave.hansen@intel.com>,
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
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
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
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: RE: [PATCH v2 24/39] x86/cet/shstk: Add user-mode shadow stack
 support
Thread-Topic: [PATCH v2 24/39] x86/cet/shstk: Add user-mode shadow stack
 support
Thread-Index: AQHY12Njz3/HZpf9jkaO+WwIiUYgJ63+BXnggACK/wCAAT4eAA==
Date:   Wed, 5 Oct 2022 13:32:53 +0000
Message-ID: <b1d59744f54743a4a8131787580d181a@AcuMS.aculab.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-25-rick.p.edgecombe@intel.com>
 <202210031203.EB0DC0B7DD@keescook>
 <474d3aca-0cf0-8962-432b-77ac914cc563@intel.com>
 <4b9c6208d1174c27a795cef487eb97b5@AcuMS.aculab.com>
 <202210041229.99F8CB38B@keescook>
In-Reply-To: <202210041229.99F8CB38B@keescook>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kees Cook
> Sent: 04 October 2022 20:32
...
> Oh, yes! I do this all the time with FORTIFY shenanigans. Right, so,
> instead of a macro, the "cannot be un-inlined" could be enforced with
> this (untested):
> 
> static __always_inline void set_clr_bits_msrl(u32 msr, u64 set, u64 clear)
> {
> 	u64 val, new_val;
> 
> 	BUILD_BUG_ON(!__builtin_constant_p(msr) ||
> 		     !__builtin_constant_p(set) ||
> 		     !__builtin_constant_p(clear));

You can reduce the amount of text the brain has to parse
by using:

	BUILD_BUG_ON(!__builtin_constant_p(msr + set + clear));

Just requires the brain to do a quick 'oh yes'...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

