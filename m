Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961DC24A35D
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 17:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgHSPl4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 19 Aug 2020 11:41:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:53695 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbgHSPly (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Aug 2020 11:41:54 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-261-02K0BOUyNletrE0M2eR4fA-1; Wed, 19 Aug 2020 16:41:50 +0100
X-MC-Unique: 02K0BOUyNletrE0M2eR4fA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 19 Aug 2020 16:41:48 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 19 Aug 2020 16:41:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Eric W. Biederman'" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
CC:     Matthew Wilcox <willy@infradead.org>,
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
Thread-Index: AQHWdjo738I4JRuBMEmE9DxJ3r/Mo6k/jYog
Date:   Wed, 19 Aug 2020 15:41:48 +0000
Message-ID: <df7f7e17a730405ea182ec778eec22e1@AcuMS.aculab.com>
References: <20200818173411.404104-1-christian.brauner@ubuntu.com>
        <20200818174447.GV17456@casper.infradead.org>
        <20200819074340.GW2674@hirez.programming.kicks-ass.net>
        <20200819084556.im5zfpm2iquzvzws@wittgenstein>
        <20200819111851.GY17456@casper.infradead.org>
        <87a6yq222c.fsf@x220.int.ebiederm.org>
        <20200819134629.mvd4nupme7q2hmtz@wittgenstein>
 <87mu2qznlv.fsf@x220.int.ebiederm.org>
In-Reply-To: <87mu2qznlv.fsf@x220.int.ebiederm.org>
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

From: Eric W. Biederman
> Sent: 19 August 2020 16:01
...
> >> Further the design decisions of pids keeps us densly using pids.  So I
> >> expect it will be a while before we even come close to using 30 bits of
> >> pid space.
> >
> > Also because it's simply annoying to have to type really large pid
> > numbers on the shell. Yes yes, that's a very privileged
> > developer-centric complaint but it matters when you have to do a quick
> > kill -9. Chromebook users obviously won't care about how large their
> > pids are for sure.
> 
> Actually that is one of the reasons (possibly the primary reason) that
> we have chosen to keep pid numbers dense.

It also helps keep the ps output under 80 cols.

> There may be fewer users of unix shells then their used to be, and we
> may now have pidfds.  But until people stop using pids in shells it is a
> very valid reason to keep them densly packed.

ISTM that the upper limit should be increased automatically
when the number of allocated pids gets large enough that they
are likely to run out (or get reused very quickly).

Does linux have an O(1) (or do I mean o(1)) pid allocator?
Or does it have to do a linear scan to find a gap??

I made the NetBSD pid allocator/lookup use pid_array[pid & mask]
then check the high bits matched (incremented on allocate).
With a FIFO free list through the unused entries.
Fairly easy to double the size and 'unzip' when getting full.
And then allocate extra high bits to keep plenty of free
values in circulation.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

