Return-Path: <linux-arch+bounces-1435-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9110D837962
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 01:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B5D1F26C5E
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 00:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F63F5B5D7;
	Mon, 22 Jan 2024 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zH0MpLQn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB15B202
	for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2024 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967716; cv=none; b=m37SzdC0RFSuFsFyDOtTkk0Wiu5Up+uEkv5UvcGTAlE0t/fta3rtvYZcu2bM8eKevDWkOIop+HcqNPErepeWmhyT/CGnpzlV71d9Km25h+wFhcws7eN4lMPXNpKBHaMXPkVqpl50AixLQAJRdcOHbJ0hZ8civUrVn0kMLTmDrvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967716; c=relaxed/simple;
	bh=KAzyQ5ylbIcWiznTnx0Xl3VSYEGyHF95ErcUKU5EJPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh7kTzu0ZZ8w9OfxNkd1uPxH+RHpc9Blj3+flhh28EiGnrXWOwtjBIb0qlfjfH6llYWGObNVuR9FbvgIlJk0LkjGIn3quk8gJmoNBc0b1jqsjGQ7nqcZ5DvSDIijYlFSjItMQJs/qhR1zCxc92xIX8IFH03PP0FBvGRgb9N+6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zH0MpLQn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d70b0e521eso27111215ad.1
        for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2024 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705967713; x=1706572513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RGk235mHGOuLFyUX2ZxszOcar+oRQLJEt08BYqJiusU=;
        b=zH0MpLQnWuk73iOnGC4chtYUxJa0qO5/WwuPz8h7L1ZipoHEBYvGsrLYoHkEAXOJQS
         70rboSeJIaBWx5L418caG3bU/3yoJz5s5awiQxmOSH0aD4vocPHQMUCZlkcrEg0M9lbB
         7na9sl+drtu8tpOb+Akza6iIz5ETJLNc9MrQHGU7Z8ir5pAeIYkQJ8aeh7yQBCWhBB2M
         2xkzIpXzRDgNll0hZXlmOLwPned2k0efDsKMBIDGGyDThndmIP+DONXBiOHPF9Ak9GYP
         TOo2Y3CoZSjRTaIfJtcXxgbk/Pc6UFZQvR32IobcDoqDW/s8VgN1eT30opbbUTo9/cis
         xgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705967713; x=1706572513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGk235mHGOuLFyUX2ZxszOcar+oRQLJEt08BYqJiusU=;
        b=RJE/2/Mc3OwdDrYuyrt0b/OXvaC0jArw4UiHX9I9OuUJY/RKPSZDvHZYqnLtu/YEmU
         ceOzfVPIIbFE2PSuH4/wPfZWTLA/R5YEVNDnXBCPlKelPjSWesjDT2Ci6x4bbTfXCtyF
         l0Atjsl+BiOCeo0PDB7wo36O1rNoDC0NZ6aDNuKYevX42NhBCSVz7lhvJ84H380xc+3s
         3n73jA75gffukkscno56JDYVgFmrqqNL12fuXfETGCHcFq3Lt9zJnKihnYCW6+rTORvd
         cgh9G1ODeVbA1n3LuupG+X0dWFKAm5DfW8xbY3/PkBNaSXkE9lGrj+G59xz0vBEXohbM
         7BEA==
X-Gm-Message-State: AOJu0YySLH532HiPUzqlbgE4jt85cM+M+NJRGta78k56I/hWvCfZwjSq
	3cCW7bBFnlfgjOr3mZSZt/rXkxn9M+6DQJwBIqO2NSKP14EjrXB9MEC6pLzE89U=
X-Google-Smtp-Source: AGHT+IGlfX9GLJ1dnOiKn3TDuB3TFlx7HAkf+GG7l4UHuUlr4oOT5ppL6HIemKoYEiunX/cBMMzKrg==
X-Received: by 2002:a17:903:228c:b0:1d5:4df7:17d6 with SMTP id b12-20020a170903228c00b001d54df717d6mr5807722plh.95.1705967713277;
        Mon, 22 Jan 2024 15:55:13 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902e18b00b001d7283bc6c6sm5038148pla.61.2024.01.22.15.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 15:55:12 -0800 (PST)
Date: Mon, 22 Jan 2024 15:55:10 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: David.Laight@aculab.com, linux@roeck-us.net,
	Conor Dooley <conor@kernel.org>, samuel.holland@sifive.com,
	xiao.w.wang@intel.com, Evan Green <evan@rivosinc.com>,
	guoren@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v15 5/5] kunit: Add tests for csum_ipv6_magic and
 ip_fast_csum
Message-ID: <Za8AXnKCm4cPyVbp@ghost>
References: <be959a4bb660466faba5ade7976485c8@AcuMS.aculab.com>
 <mhng-b5f26a34-7632-4423-9f07-3224170bae9f@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-b5f26a34-7632-4423-9f07-3224170bae9f@palmer-ri-x1c9>

On Mon, Jan 22, 2024 at 03:39:16PM -0800, Palmer Dabbelt wrote:
> On Mon, 22 Jan 2024 13:41:48 PST (-0800), David.Laight@ACULAB.COM wrote:
> > From: Guenter Roeck
> > > Sent: 22 January 2024 17:16
> > > 
> > > On 1/22/24 08:52, David Laight wrote:
> > > > From: Guenter Roeck
> > > >> Sent: 22 January 2024 16:40
> > > >>
> > > >> Hi,
> > > >>
> > > >> On Mon, Jan 08, 2024 at 03:57:06PM -0800, Charlie Jenkins wrote:
> > > >>> Supplement existing checksum tests with tests for csum_ipv6_magic and
> > > >>> ip_fast_csum.
> > > >>>
> > > >>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > >>> ---
> > > >>
> > > >> With this patch in the tree, the arm:mps2-an385 qemu emulation gets a bad hiccup.
> > > >>
> > > >> [    1.839556] Unhandled exception: IPSR = 00000006 LR = fffffff1
> > > >> [    1.839804] CPU: 0 PID: 164 Comm: kunit_try_catch Tainted: G                 N 6.8.0-rc1 #1
> > > >> [    1.839948] Hardware name: Generic DT based system
> > > >> [    1.840062] PC is at __csum_ipv6_magic+0x8/0xb4
> > > >> [    1.840408] LR is at test_csum_ipv6_magic+0x3d/0xa4
> > > >> [    1.840493] pc : [<21212f34>]    lr : [<21117fd5>]    psr: 0100020b
> > > >> [    1.840586] sp : 2180bebc  ip : 46c7f0d2  fp : 21275b38
> > > >> [    1.840664] r10: 21276b60  r9 : 21275b28  r8 : 21465cfc
> > > >> [    1.840751] r7 : 00003085  r6 : 21275b4e  r5 : 2138702c  r4 : 00000001
> > > >> [    1.840847] r3 : 2c000000  r2 : 1ac7f0d2  r1 : 21275b39  r0 : 21275b29
> > > >> [    1.840942] xPSR: 0100020b
> > > >>
> > > >> This translates to:
> > > >>
> > > >> PC is at __csum_ipv6_magic (arch/arm/lib/csumipv6.S:15)
> > > >> LR is at test_csum_ipv6_magic (./arch/arm/include/asm/checksum.h:60
> > > >> ./arch/arm/include/asm/checksum.h:163 lib/checksum_kunit.c:617)
> > > >>
> > > >> Obviously I can not say if this is a problem with qemu or a problem with
> > > >> the Linux kernel. Given that, and the presumably low interest in
> > > >> running mps2-an385 with Linux, I'll simply disable that test. Just take
> > > >> it as a heads up that there _may_ be a problem with this on arm
> > > >> nommu systems.
> > > >
> > > > Can you drop in a disassembly of __csum_ipv6_magic ?
> > > > Actually I think it is:
> > > 
> > > It is, as per the PC pointer above. I don't know anything about arm assembler,
> > > much less about its behavior with THUMB code.
> > 
> > Doesn't look like thumb to me (offset 8 is two 4-byte instructions) and
> > the code I found looks like arm to me.
> > (I haven't written any arm asm since before they invented thumb!)
> > 
> > > > ENTRY(__csum_ipv6_magic)
> > > > 		str	lr, [sp, #-4]!
> > > > 		adds	ip, r2, r3
> > > > 		ldmia	r1, {r1 - r3, lr}
> > > >
> > > > So the fault is (probably) a misaligned ldmia ?
> > > > Are they ever supported?
> > > >
> > > 
> > > Good question. My primary guess is that this never worked. As I said,
> > > this was just intended to be informational, (probably) no reason to bother.
> > > 
> > > Of course one might ask if it makes sense to even keep the arm nommu code
> > > in the kernel, but that is of course a different question. I do wonder though
> > > if anyone but me is running it.
> > 
> > If it is an alignment fault it isn't a 'nommu' bug.
> > 
> > And traditionally arm didn't support misaligned transfers (well not
> > in anyway any other cpu did!).
> > It might be that the kernel assumes that all ethernet packets are
> > aligned, but the test suite isn't aligning the buffer.
> > Which would make it a test suite bug.
> 
> From talking to Evan and Vineet, I think you're right and this is a test
> suite bug: specifically the tests weren't respecting NET_IP_ALIGN.  That
> didn't crop up for ip_fast_csum() as it just uses ldr which supports
> misaligned accesses on the M3 (at least as far as I can tell).
> 
> So I think the right fix is something like
> 
>    diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
>    index 225bb7701460..2dd282e27dd4 100644
>    --- a/lib/checksum_kunit.c
>    +++ b/lib/checksum_kunit.c
>    @@ -5,6 +5,7 @@
>     #include <kunit/test.h>
>     #include <asm/checksum.h>
>    +#include <asm/checksum.h>
>     #include <net/ip6_checksum.h>
>     #define MAX_LEN 512
>    @@ -15,6 +16,7 @@
>     #define IPv4_MAX_WORDS 15
>     #define NUM_IPv6_TESTS 200
>     #define NUM_IP_FAST_CSUM_TESTS 181
>    +#define SUPPORTED_ALIGNMENT (1 << NET_IP_ALIGN)
>     /* Values for a little endian CPU. Byte swap each half on big endian CPU. */
>     static const u32 random_init_sum = 0x2847aab;
>    @@ -486,7 +488,7 @@ static void test_csum_fixed_random_inputs(struct kunit *test)
>     	__sum16 result, expec;
>     	assert_setup_correct(test);
>    -	for (align = 0; align < TEST_BUFLEN; ++align) {
>    +	for (align = 0; align < TEST_BUFLEN; align += SUPPORTED_ALIGNMENT) {
>     		memcpy(&tmp_buf[align], random_buf,
>     		       min(MAX_LEN, TEST_BUFLEN - align));
>     		for (len = 0; len < MAX_LEN && (align + len) < TEST_BUFLEN;
>    @@ -513,7 +515,7 @@ static void test_csum_all_carry_inputs(struct kunit *test)
>     	assert_setup_correct(test);
>     	memset(tmp_buf, 0xff, TEST_BUFLEN);
>    -	for (align = 0; align < TEST_BUFLEN; ++align) {
>    +	for (align = 0; align < TEST_BUFLEN; align += SUPPORTED_ALIGNMENT) {
>     		for (len = 0; len < MAX_LEN && (align + len) < TEST_BUFLEN;
>     		     ++len) {
>     			/*
>    @@ -553,7 +555,7 @@ static void test_csum_no_carry_inputs(struct kunit *test)
>     	assert_setup_correct(test);
>     	memset(tmp_buf, 0x4, TEST_BUFLEN);
>    -	for (align = 0; align < TEST_BUFLEN; ++align) {
>    +	for (align = 0; align < TEST_BUFLEN; align += SUPPORTED_ALIGNMENT) {
>     		for (len = 0; len < MAX_LEN && (align + len) < TEST_BUFLEN;
>     		     ++len) {
>     			/*
> 
> but I haven't even build tested it...

This doesn't fix the test_csum_ipv6_magic test case that was causing the
initial problem, but the same trick can be done in that test.

- Charlie

> 
> > 
> > 	David
> > 
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)

