Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1541424A39C
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 17:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgHSPzy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 19 Aug 2020 11:55:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:60175 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbgHSPzx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Aug 2020 11:55:53 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-16-hHSNbmghP5KK9A30MkCOpQ-1; Wed, 19 Aug 2020 16:55:49 +0100
X-MC-Unique: hHSNbmghP5KK9A30MkCOpQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 19 Aug 2020 16:55:47 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 19 Aug 2020 16:55:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>
CC:     "'Eric W. Biederman'" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Christoph Hewllig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Ley Foon Tan" <ley.foon.tan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Stafford Horne" <shorne@gmail.com>,
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tom Zanussi" <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "uclinux-h8-devel@lists.sourceforge.jp" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 00/11] Introduce kernel_clone(), kill _do_fork()
Thread-Topic: [PATCH 00/11] Introduce kernel_clone(), kill _do_fork()
Thread-Index: AQHWdjo738I4JRuBMEmE9DxJ3r/Mo6k/jYog///0u4CAABKhYA==
Date:   Wed, 19 Aug 2020 15:55:47 +0000
Message-ID: <ee30fecfbd534c19a6bfd11d2c4b8263@AcuMS.aculab.com>
References: <20200818173411.404104-1-christian.brauner@ubuntu.com>
 <20200818174447.GV17456@casper.infradead.org>
 <20200819074340.GW2674@hirez.programming.kicks-ass.net>
 <20200819084556.im5zfpm2iquzvzws@wittgenstein>
 <20200819111851.GY17456@casper.infradead.org>
 <87a6yq222c.fsf@x220.int.ebiederm.org>
 <20200819134629.mvd4nupme7q2hmtz@wittgenstein>
 <87mu2qznlv.fsf@x220.int.ebiederm.org>
 <df7f7e17a730405ea182ec778eec22e1@AcuMS.aculab.com>
 <20200819154521.GE17456@casper.infradead.org>
In-Reply-To: <20200819154521.GE17456@casper.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matthew Wilcox
> Sent: 19 August 2020 16:45
> 
> On Wed, Aug 19, 2020 at 03:41:48PM +0000, David Laight wrote:
> > Does linux have an O(1) (or do I mean o(1)) pid allocator?
> > Or does it have to do a linear scan to find a gap??
> 
> O(log(n)).  It uses the IDR allocator, so 'n' in this case is the
> number of PIDs currently allocated, and it's log_64 rather than log_2
> (which makes no difference to O() but does make a bit of a difference
> to performance)

Still worse that O(1) - when that is just replacing a variable
with a value read out of an array.
Made pid lookup a trivial O(1) as well.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

