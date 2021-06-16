Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0433A8EA5
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 04:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhFPCDn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 22:03:43 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:35431 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhFPCDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 22:03:43 -0400
Received: by mail-ed1-f47.google.com with SMTP id ba2so517130edb.2;
        Tue, 15 Jun 2021 19:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=3hLHK5T+cSmgYtqFNHhD8O3b5QvMtN/O2XANsFUDnBg=;
        b=HLfBJ/w+4cjE+PSFB6yJrorzYfTg3OdGE7KiUWjU6AtTPXTNRE9Ae0CYKSrfkMkUu5
         fhpAHEz80SdBLyikd7tiRteS6sf0crc9/Qy2ciZphgSZxFWdp0lHV8qT/4WeoG9qstX+
         HRQyCXv/B+uB/QQtGdLK4OoK4wuGNLsdbD9cW3XVl9P90S3EDA462gI7jWB65lzN0c8e
         0Kqxo+6Lq44I5AEFY646Lyh819zRTJoL2XhNlY+69aaQqR0UdcZ5+UMv6DLn+7qlsN6o
         B7RXE31VNR6zmMS0egApxQTybQgC9wHcu14+gRB+mFrYvp3lFWkOiEidg91XMQZDrz2R
         anEg==
X-Gm-Message-State: AOAM533Y02cWm9P60tI059H0zmJWJDGsuP5Nm3+T2NV8IFdq4kHf+zpb
        Md9lGVW4KNzQl6qFIBeHjkXKalYlgSk=
X-Google-Smtp-Source: ABdhPJzOmNvGNe5p+nSw9fh9WScgTrVq438vD4tB0PlEHyBoLHx94X3s8VSrhZL9KpBaHhqrZz+11Q==
X-Received: by 2002:a05:6402:1801:: with SMTP id g1mr1202223edy.305.1623808896257;
        Tue, 15 Jun 2021 19:01:36 -0700 (PDT)
Received: from localhost (net-37-119-128-179.cust.vodafonedsl.it. [37.119.128.179])
        by smtp.gmail.com with ESMTPSA id u12sm556020edv.43.2021.06.15.19.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 19:01:35 -0700 (PDT)
Date:   Wed, 16 Jun 2021 04:01:32 +0200
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        David Laight <David.Laight@aculab.com>,
        Gary Guo <gary@garyguo.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>
Subject: Re: [PATCH 1/3] riscv: optimized memcpy
Message-ID: <20210616040132.7fbdf6fe@linux.microsoft.com>
In-Reply-To: <CAEUhbmX_wsfU9FfRJoOPE0gjUX=Bp7OZWOZDyMNfO6=M-fX_0A@mail.gmail.com>
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
        <20210615023812.50885-2-mcroce@linux.microsoft.com>
        <6cff2a895db94e6fadd4ddffb8906a73@AcuMS.aculab.com>
        <CAEUhbmV+Vi0Ssyzq1B2RTkbjMpE21xjdj2MSKdLydgW6WuCKtA@mail.gmail.com>
        <1632006872b04c64be828fa0c4e4eae0@AcuMS.aculab.com>
        <CAEUhbmU0cPkawmFfDd_sPQnc9V-cfYd32BCQo4Cis3uBKZDpXw@mail.gmail.com>
        <CANBLGcxi2mEA5MnV-RL2zFpB2T+OytiHyOLKjOrMXgmAh=fHAw@mail.gmail.com>
        <CAEUhbmX_wsfU9FfRJoOPE0gjUX=Bp7OZWOZDyMNfO6=M-fX_0A@mail.gmail.com>
Organization: Microsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 16 Jun 2021 08:33:21 +0800
Bin Meng <bmeng.cn@gmail.com> wrote:

> On Wed, Jun 16, 2021 at 12:12 AM Emil Renner Berthing
> <kernel@esmil.dk> wrote:
> >
> > On Tue, 15 Jun 2021 at 15:29, Bin Meng <bmeng.cn@gmail.com> wrote:
> > > ...
> > > Yes, Gary Guo sent one patch long time ago against the broken
> > > assembly version, but that patch was still not applied as of
> > > today.
> > > https://patchwork.kernel.org/project/linux-riscv/patch/20210216225555.4976-1-gary@garyguo.net/
> > >
> > > I suggest Matteo re-test using Gary's version.
> >
> > That's a good idea, but if you read the replies to Gary's original
> > patch
> > https://lore.kernel.org/linux-riscv/20210216225555.4976-1-gary@garyguo.net/
> > .. both Gary, Palmer and David would rather like a C-based version.
> > This is one attempt at providing that.
> 
> Yep, I prefer C as well :)
> 
> But if you check commit 04091d6, the assembly version was introduced
> for KASAN. So if we are to change it back to C, please make sure KASAN
> is not broken.
> 
> Regards,
> Bin
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

I added a small benchmark for memcpy() and memset() in lib/test_string.c:

memcpy_align_selftest():

#define PG_SIZE	(1 << (MAX_ORDER - 1 + PAGE_SHIFT))

	page1 = alloc_pages(GFP_KERNEL, MAX_ORDER-1);
	page2 = alloc_pages(GFP_KERNEL, MAX_ORDER-1);

	for (i = 0; i < sizeof(void*); i++) {
		t0 = ktime_get();
		memset(dst + i, 0, PG_SIZE - i);
		t1 = ktime_get();
		printk("Strings selftest: memset(dst+%d): %llu Mb/s\n", i,
			PG_SIZE * (1000000000l / 1048576l) / (t1-t0));
	}

memset_align_selftest():
	page = alloc_pages(GFP_KERNEL, MAX_ORDER-1);
	for (i = 0; i < sizeof(void*); i++) {
		for (j = 0; j < sizeof(void*); j++) {
			t0 = ktime_get();
			memcpy(dst + j, src + i, PG_SIZE - max(i, j));
			t1 = ktime_get();
			printk("Strings selftest: memcpy(src+%d, dst+%d): %llu Mb/s\n",
				i, j, PG_SIZE * (1000000000l / 1048576l) / (t1-t0));
		}
	}

And I ran it agains the three implementations, current, Gary's assembler
and mine in C.

Current:
[   38.980687] Strings selftest: memcpy(src+0, dst+0): 231 Mb/s
[   39.021612] Strings selftest: memcpy(src+0, dst+1): 113 Mb/s
[   39.062191] Strings selftest: memcpy(src+0, dst+2): 114 Mb/s
[   39.102669] Strings selftest: memcpy(src+0, dst+3): 114 Mb/s
[   39.127423] Strings selftest: memcpy(src+0, dst+4): 209 Mb/s
[   39.167836] Strings selftest: memcpy(src+0, dst+5): 115 Mb/s
[   39.208305] Strings selftest: memcpy(src+0, dst+6): 114 Mb/s
[   39.248712] Strings selftest: memcpy(src+0, dst+7): 115 Mb/s
[   39.288144] Strings selftest: memcpy(src+1, dst+0): 118 Mb/s
[   39.309190] Strings selftest: memcpy(src+1, dst+1): 260 Mb/s
[   39.349721] Strings selftest: memcpy(src+1, dst+2): 114 Mb/s
[...]
[   41.289423] Strings selftest: memcpy(src+7, dst+5): 114 Mb/s
[   41.328801] Strings selftest: memcpy(src+7, dst+6): 118 Mb/s
[   41.349907] Strings selftest: memcpy(src+7, dst+7): 259 Mb/s

[   41.377735] Strings selftest: memset(dst+0): 241 Mb/s
[   41.397882] Strings selftest: memset(dst+1): 265 Mb/s
[   41.417666] Strings selftest: memset(dst+2): 272 Mb/s
[   41.437169] Strings selftest: memset(dst+3): 277 Mb/s
[   41.456656] Strings selftest: memset(dst+4): 277 Mb/s
[   41.476125] Strings selftest: memset(dst+5): 278 Mb/s
[   41.495555] Strings selftest: memset(dst+6): 278 Mb/s
[   41.515002] Strings selftest: memset(dst+7): 278 Mb/s

Gary's
[   27.438112] Strings selftest: memcpy(src+0, dst+0): 232 Mb/s
[   27.461586] Strings selftest: memcpy(src+0, dst+1): 224 Mb/s
[   27.484691] Strings selftest: memcpy(src+0, dst+2): 229 Mb/s
[   27.507693] Strings selftest: memcpy(src+0, dst+3): 230 Mb/s
[   27.530758] Strings selftest: memcpy(src+0, dst+4): 229 Mb/s
[   27.553840] Strings selftest: memcpy(src+0, dst+5): 229 Mb/s
[   27.576793] Strings selftest: memcpy(src+0, dst+6): 231 Mb/s
[   27.599862] Strings selftest: memcpy(src+0, dst+7): 230 Mb/s
[   27.622888] Strings selftest: memcpy(src+1, dst+0): 230 Mb/s
[   27.643964] Strings selftest: memcpy(src+1, dst+1): 259 Mb/s
[   27.666926] Strings selftest: memcpy(src+1, dst+2): 231 Mb/s
[...]
[   28.831726] Strings selftest: memcpy(src+7, dst+5): 230 Mb/s
[   28.854790] Strings selftest: memcpy(src+7, dst+6): 229 Mb/s
[   28.875844] Strings selftest: memcpy(src+7, dst+7): 260 Mb/s

[   28.903666] Strings selftest: memset(dst+0): 240 Mb/s
[   28.923533] Strings selftest: memset(dst+1): 269 Mb/s
[   28.943100] Strings selftest: memset(dst+2): 275 Mb/s
[   28.962554] Strings selftest: memset(dst+3): 277 Mb/s
[   28.982009] Strings selftest: memset(dst+4): 277 Mb/s
[   29.001412] Strings selftest: memset(dst+5): 278 Mb/s
[   29.020894] Strings selftest: memset(dst+6): 277 Mb/s
[   29.040383] Strings selftest: memset(dst+7): 276 Mb/s

Mine:
[   33.916144] Strings selftest: memcpy(src+0, dst+0): 222 Mb/s
[   33.939520] Strings selftest: memcpy(src+0, dst+1): 226 Mb/s
[   33.962666] Strings selftest: memcpy(src+0, dst+2): 229 Mb/s
[   33.985749] Strings selftest: memcpy(src+0, dst+3): 229 Mb/s
[   34.008748] Strings selftest: memcpy(src+0, dst+4): 231 Mb/s
[   34.031970] Strings selftest: memcpy(src+0, dst+5): 228 Mb/s
[   34.055065] Strings selftest: memcpy(src+0, dst+6): 229 Mb/s
[   34.078068] Strings selftest: memcpy(src+0, dst+7): 231 Mb/s
[   34.101177] Strings selftest: memcpy(src+1, dst+0): 229 Mb/s
[   34.122995] Strings selftest: memcpy(src+1, dst+1): 247 Mb/s
[   34.146072] Strings selftest: memcpy(src+1, dst+2): 229 Mb/s
[...]
[   35.315594] Strings selftest: memcpy(src+7, dst+5): 229 Mb/s
[   35.338617] Strings selftest: memcpy(src+7, dst+6): 230 Mb/s
[   35.360464] Strings selftest: memcpy(src+7, dst+7): 247 Mb/s

[   35.388929] Strings selftest: memset(dst+0): 232 Mb/s
[   35.409351] Strings selftest: memset(dst+1): 260 Mb/s
[   35.429434] Strings selftest: memset(dst+2): 266 Mb/s
[   35.449460] Strings selftest: memset(dst+3): 267 Mb/s
[   35.469479] Strings selftest: memset(dst+4): 267 Mb/s
[   35.489481] Strings selftest: memset(dst+5): 268 Mb/s
[   35.509443] Strings selftest: memset(dst+6): 269 Mb/s
[   35.529449] Strings selftest: memset(dst+7): 268 Mb/s

Leaving out the first memcpy/set of every test which is always slower, (maybe
because of a cache miss?), the current implementation copies 260 Mb/s when
the low order bits match, and 114 otherwise.
Memset is stable at 278 Mb/s.

Gary's implementation is much faster, copies still 260 Mb/s when euqlly placed,
and 230 Mb/s otherwise. Memset is the same as the current one.

Mine has the same speed of Gary's one when the low order bits mismatch, but
it's slower when equally aligned, it stops at 247 Mb/s.
Memset is slighty slower ad 269 Mb/s.


I'm not familiar with RISC-V assembly, but looking at Gary's assembler and I
think that he manually unrolled the loop by copying 16 uint64_t at time
using 16 registers.
I managed to do the same with a small change in the C code and a pragma directive:

This for memcpy():

	if (distance) {
		unsigned long last, next;
		int i;

		s.u8 -= distance;

		for (; count >= bytes_long * 8 + mask; count -= bytes_long * 8) {
			next = s.ulong[0];
			for (i = 0; i < 8; i++) {
				last = next;
				next = s.ulong[i + 1];

				d.ulong[i] = last >> (distance * 8) |
					next << ((bytes_long - distance) * 8);
			}

			d.ulong += 8;
			s.ulong += 8;
		}

		s.u8 += distance;
	} else {
		/* 8 byte wide copy */
		int i;
		for (; count >= bytes_long * 8; count -= bytes_long * 8) {
#pragma GCC unroll 8
			for (i = 0; i < 8; i++)
				d.ulong[i] = s.ulong[i];
			d.ulong += 8;
			s.ulong += 8;
		}
	}

And this for memset:

		for (; count >= bytes_long * 8; count -= bytes_long * 8) {
#pragma GCC unroll 8
			for (i = 0; i < 8; i++)
				dest.ulong[i] = cu;

			dest.ulong += 8;
		}

And the generated machine code is very, very similar to Gary's one!
And these are the result:

[   35.898366] Strings selftest: memcpy(src+0, dst+0): 231 Mb/s
[   35.920942] Strings selftest: memcpy(src+0, dst+1): 236 Mb/s
[   35.943171] Strings selftest: memcpy(src+0, dst+2): 241 Mb/s
[   35.965291] Strings selftest: memcpy(src+0, dst+3): 242 Mb/s
[   35.987374] Strings selftest: memcpy(src+0, dst+4): 244 Mb/s
[   36.009554] Strings selftest: memcpy(src+0, dst+5): 242 Mb/s
[   36.031721] Strings selftest: memcpy(src+0, dst+6): 242 Mb/s
[   36.053881] Strings selftest: memcpy(src+0, dst+7): 242 Mb/s
[   36.075949] Strings selftest: memcpy(src+1, dst+0): 243 Mb/s
[   36.097084] Strings selftest: memcpy(src+1, dst+1): 258 Mb/s
[   36.119269] Strings selftest: memcpy(src+1, dst+2): 242 Mb/s
[...]
[   37.242433] Strings selftest: memcpy(src+7, dst+5): 242 Mb/s
[   37.264571] Strings selftest: memcpy(src+7, dst+6): 242 Mb/s
[   37.285609] Strings selftest: memcpy(src+7, dst+7): 260 Mb/s

[   37.313633] Strings selftest: memset(dst+0): 237 Mb/s
[   37.333682] Strings selftest: memset(dst+1): 266 Mb/s
[   37.353375] Strings selftest: memset(dst+2): 273 Mb/s
[   37.373000] Strings selftest: memset(dst+3): 274 Mb/s
[   37.392608] Strings selftest: memset(dst+4): 274 Mb/s
[   37.412220] Strings selftest: memset(dst+5): 274 Mb/s
[   37.431848] Strings selftest: memset(dst+6): 274 Mb/s
[   37.451467] Strings selftest: memset(dst+7): 274 Mb/s

This version is even faster than the assembly one, but it won't work for
copies/set smaller that at least 64 bytes, or even 128. With small buffers
it will copy bytes one at time, so I don't know if it's worth it.

What is preferred in your opinion, an implementation which is always fast
with all sizes, or one which is a bit faster but slow with small copies?

-- 
per aspera ad upstream
