Return-Path: <linux-arch+bounces-11577-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8852A9CBD8
	for <lists+linux-arch@lfdr.de>; Fri, 25 Apr 2025 16:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45929E03A1
	for <lists+linux-arch@lfdr.de>; Fri, 25 Apr 2025 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F9D25229A;
	Fri, 25 Apr 2025 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoedJdCG"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB91E519
	for <linux-arch@vger.kernel.org>; Fri, 25 Apr 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591853; cv=none; b=ZCM5xOKMFupY8XFR+MVBFw7ZRP1kqBaLA9nuh6G7e5QV/dPa8o1i+6/BqdGf66TLg8ESaAlvwSYzOhsMDHfS2yHPgaAi12CPlzadKmrorV8W0jIq5qurSOjcEA0kXf+Xj2gll1NTb9zyOCGPE9FItNWNQs3MVJHdbnH9vBq2qZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591853; c=relaxed/simple;
	bh=12ddBMZQ18J7y93eq2KLvViZaVM9zxPfD5eeT2ec/EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XA2joR9ng/b0NBrzuTYY4GbH3Y24x+KaqRP4sarET7WXBl8WXG2xLvpKMbJ2w1/bpl51x6+C5GITme38NmDD+4ShX5ESbuZO3barb4SjYZPEH+UuloEwdjbr3MMRyBJSC20GbzZvXJX/8/7ABTOt9Wa8pYZUJEsHVwNcWY5ZXio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QoedJdCG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745591850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ujk3/IGYnXx3Wxmgegzw/+bFfTW+UygvpTNGj7Kcyas=;
	b=QoedJdCGNEROI4u2j8z1slQVY2mizt03HtB5NezB+Gjy5DTwFcZqDavcIbBBIWTcfcjUT2
	1OTPG4ObhZH+qintw7qN3mraQLNThK5TwzAv3mTozYTMcT85zN4ZhkpL2h0HOHMYgk2/6U
	i5PFeteSFNyyeoeauWMdFhxsvu7byJ0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-vQMZhn0OOvmBHt2rziqw9A-1; Fri, 25 Apr 2025 10:37:28 -0400
X-MC-Unique: vQMZhn0OOvmBHt2rziqw9A-1
X-Mimecast-MFC-AGG-ID: vQMZhn0OOvmBHt2rziqw9A_1745591848
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d6c65dc52so16682825e9.1
        for <linux-arch@vger.kernel.org>; Fri, 25 Apr 2025 07:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745591847; x=1746196647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ujk3/IGYnXx3Wxmgegzw/+bFfTW+UygvpTNGj7Kcyas=;
        b=oi63ZCoKWwA1XrH6bQh8/PVnxbFRjx1PKK3h7VYITpDk5WC3KM8D22eMsVJm7yr1jY
         /AsoHkyhynL5EXNfO2HLuX/4lGPu1vD0xn32htYitzPGZ3bpBmMqCOlf/19Eshf75q0p
         I6zHPJMnCDC0XY5uqqdPz3qM5EJGhcbm0qfNv5reIF/kOY5WgPKrKUhA2PvljLLEDqtF
         S/pVkY6cqGREA/5diwmpKYcoWmDGaXUGZiyyZ93i2XWiVUyuT7twU9QuB3CxRinnnA1o
         7LCcsp7m7f1LfKw27SjM3jPQ0TbTVLXvIqsvJr/WlTGeY0GbMUayfTHzpqW+pBM66BMw
         wSsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlm/oKWeOfS3mQj82RDcW0Gn22/ch3Ovon1gVKQf3sEp2rXutrjeaXmGe4I9VodqRDdyLeWCHOxdlo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51fH8o4WApWbbzOVEJVaU55uwy+zXoaGqyZ0is3vFBsHqezKV
	p/Rc7yLeg6Ce/duKN75ifkvUNQdPPxTE4MfNh0ki4G1XE6kG5KNzB0UxEcotHrpXjyOmExVdYLs
	C4spkAabHo1nDNLW0jLk/DIKCYTlHTaCKtfgL2k59OLVnoEAowY7GZUtHpno=
X-Gm-Gg: ASbGnctpD/Mjm4cvXRe3qq6Cz8NSO6n+pnFykOWuj6DocT2096TqNznaQ2KRKcBREEF
	M91+ie72TGnxgpTWsMdcwewfF/YIYI/wbJkjS2gVjy/2IdiULK6dZuTgY4kwxTpFw2EiCm1IpB0
	qzbluUqXaR3hVW168vgvxT4RoXKoQtOQyNhwrWKPSaUXAM19Ux6LxHfJtd6bVugIYc3fmMYfeGI
	lI4QERRLANVmKBLSXJ6x47OPExuOub+syWH3oDRtIs5d9FbvjcI/1gJtawYUWOgpdZZqEnJQxN8
	WcAjnfKSGU3mIx8L3qzXBXyQDg==
X-Received: by 2002:a5d:47ad:0:b0:39e:cbca:8a4b with SMTP id ffacd0b85a97d-3a074e0e1a8mr2130280f8f.6.1745591847616;
        Fri, 25 Apr 2025 07:37:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHQ8vRI/X7PrO43k0DiFqkqa4Uk8XRAM7d2gJ9xafb1xfkOT7jJlK6mrbxxsPSXHf+XLM2Jg==
X-Received: by 2002:a5d:47ad:0:b0:39e:cbca:8a4b with SMTP id ffacd0b85a97d-3a074e0e1a8mr2130242f8f.6.1745591847204;
        Fri, 25 Apr 2025 07:37:27 -0700 (PDT)
Received: from t14ultra (109-81-82-22.rct.o2.cz. [109.81.82.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a530a6e9sm26807935e9.16.2025.04.25.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 07:37:26 -0700 (PDT)
Date: Fri, 25 Apr 2025 16:37:47 +0200
From: Jan Stancek <jstancek@redhat.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 08/19] vdso/gettimeofday: Prepare do_hres_timens() for
 introduction of struct vdso_clock
Message-ID: <aAueO89ng7GX2iyl@t14ultra>
References: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
 <20250303-vdso-clock-v1-8-c1b5c69a166f@linutronix.de>
 <aApGPAoctq_eoE2g@t14ultra>
 <20250424173908-ffca1ea2-e292-4df3-9391-24bfdaab33e7@linutronix.de>
 <CAASaF6xsMOWkhPrzKQWNz5SXaROSpxzFVBz+MOA-MNiEBty7gQ@mail.gmail.com>
 <20250425104552-07539a73-8f56-44d2-97a2-e224c567a2fc@linutronix.de>
 <CAASaF6yxThX3HTHgY_AGqNr7LJ-erdG09WV5-HyfN1fYN9pStQ@mail.gmail.com>
 <20250425152733-0ff10421-b716-4a55-9b60-cb0a71769e56@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250425152733-0ff10421-b716-4a55-9b60-cb0a71769e56@linutronix.de>

On Fri, Apr 25, 2025 at 03:40:55PM +0200, Thomas Weiﬂschuh wrote:

<snip>

>
>Some more information:
>
>The crash comes from the address arithmetic in "vc = &vc[CS_RAW]" going wrong.

That appears to be because it's not doing any arithmetic, but using value
from some linker-generated symbol (I'll refer to it as "7a8").

The below is presumably the check that compares clk != CLOCK_MONOTONIC_RAW,
CLOCK_MONOTONIC_RAW is 4. And it should choose between first and second vdso_clock
in 2nd vvar page:

# readelf -a /root/kernel-ark/arch/arm64/kernel/vdso/vdso.so.dbg | grep 7a8
     25: 00000000000007a8     0 NOTYPE  LOCAL  DEFAULT    7 $d

objdump -d -S:
  658:   17ffffef        b       614 <__cvdso_clock_gettime_data.constprop.0+0x104>
                 vc = &vc[CS_HRES_COARSE];
  65c:   58000a62        ldr     x2, 7a8 <__cvdso_clock_gettime_data.constprop.0+0x298>
  660:   7100101f        cmp     w0, #0x4
  664:   10e7cce3        adr     x3, fffffffffffd0000 <vdso_u_data+0x10000>
  668:   9a821063        csel    x3, x3, x2, ne  // ne = any
         while (unlikely((seq = READ_ONCE(vc->seq)) & 1))
  66c:   b9400065        ldr     w5, [x3]
...
  7a8:   fffd00e0        .word   0xfffd00e0
  7ac:   ffffffff        .word   0xffffffff


(gdb) r
Thread 2.1 "a.out" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0xfffff7ff2dc0 (LWP 44638)]
0x0000fffff7fa066c in ?? ()

(gdb) disassemble 0x0000fffff7fa0658,0x0000fffff7fa067c
--Type <RET> for more, q to quit, c to continue without paging--
    0x0000fffff7fa0658:  b       0xfffff7fa0614
    0x0000fffff7fa065c:  ldr     x2, 0xfffff7fa07a8
    0x0000fffff7fa0660:  cmp     w0, #0x4
    0x0000fffff7fa0664:  adr     x3, 0xfffff7f70000
    0x0000fffff7fa0668:  csel    x3, x3, x2, ne  // ne = any
=> 0x0000fffff7fa066c:  ldr     w5, [x3]

$x3 here is using correct vvar runtime address, but $x2 uses
a bogus one from "7a8". And when it tries to load from it, it crashes:

(gdb) info proc map
process 44638
Mapped address spaces:

Start Addr         End Addr           Size               Offset             Perms File
0x0000000000400000 0x0000000000410000 0x10000            0x0                r-xp  /root/ltp/testcases/kernel/syscalls/clock_gettime/a.out
0x0000000000410000 0x0000000000420000 0x10000            0x0                r--p  /root/ltp/testcases/kernel/syscalls/clock_gettime/a.out
0x0000000000420000 0x0000000000430000 0x10000            0x10000            rw-p  /root/ltp/testcases/kernel/syscalls/clock_gettime/a.out
0x0000fffff7d80000 0x0000fffff7f30000 0x1b0000           0x0                r-xp  /usr/lib64/libc.so.6
0x0000fffff7f30000 0x0000fffff7f40000 0x10000            0x1a0000           r--p  /usr/lib64/libc.so.6
0x0000fffff7f40000 0x0000fffff7f50000 0x10000            0x1b0000           rw-p  /usr/lib64/libc.so.6
0x0000fffff7f60000 0x0000fffff7fa0000 0x40000            0x0                r--p  [vvar]
0x0000fffff7fa0000 0x0000fffff7fb0000 0x10000            0x0                r-xp  [vdso]
0x0000fffff7fb0000 0x0000fffff7fe0000 0x30000            0x0                r-xp  /usr/lib/ld-linux-aarch64.so.1
0x0000fffff7fe0000 0x0000fffff7ff0000 0x10000            0x20000            r--p  /usr/lib/ld-linux-aarch64.so.1
0x0000fffff7ff0000 0x0000fffff8000000 0x10000            0x30000            rw-p  /usr/lib/ld-linux-aarch64.so.1
0x0000fffffffd0000 0x0001000000000000 0x30000            0x0                rw-p  [stack]

$x3 was the beginning of 2nd vvar page (1st vdso_clock), and $x2 looks
like it should have been 2nd vdso_clock, but the value that is used is not
the address of vvar during runtime. 

vdso_clock has size 224 == 0xe0 (according to pahole)

(gdb) x/2x 0xfffff7fa07a8
0xfffff7fa07a8: 0xfffd00e0      0xffffffff
(gdb) p/x $x2
$1 = 0xfffffffffffd00e0
(gdb) x/1x $x2
0xfffffffffffd00e0:     Cannot access memory at address 0xfffffffffffd00e0

But it does match the symbol value from vdso.so:

# readelf -a /root/kernel-ark/arch/arm64/kernel/vdso/vdso.so.dbg | grep vdso_u
     37: fffffffffffc0000     0 NOTYPE  LOCAL  DEFAULT    1 vdso_u_data
     39: fffffffffffc0000     0 NOTYPE  LOCAL  DEFAULT  ABS vdso_u_time_data
     40: fffffffffffe0000     0 NOTYPE  LOCAL  DEFAULT  ABS vdso_u_rng_data

>>> print(hex(0xfffffffffffc0000+65536+224))
0xfffffffffffd00e0 -> and this is address where it crashes

Regards,
Jan

>This should just do "vc = vc + 1", advancing the pointer by sizeof(*vc).
>But I get these example values of "vc" before and after the arithmetic:
>0x00ffffbc060000 -> 0xfffffffffffd00e8
>Which is obviously wrong.
>
>The arithmetic can be fixed with any one of the following changes:
>* OPTIMIZER_HIDE_VAR() as above
>* Replacement of -mcmodel=tiny with -mcmode=small in arch/arm64/kernel/vdso/Makefile
>  -mcmodel=tiny is supposed to cover 1MiB programs, the vDSO only needs 300KiB here
>* Removal of the (clk != CLOCK_MONOTONIC_RAW) case
>
>Shuffling code around, even without any impact on semantics, sometimes fixes
>the issue. Compiling the vDSO with UBSAN didn't show anything.
>
>
>Thomas
>
>> > > > > [1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
>> > > > > [2] https://koji.fedoraproject.org/koji/buildinfo?buildID=2704401
>> > > >
>> >
>>
>


