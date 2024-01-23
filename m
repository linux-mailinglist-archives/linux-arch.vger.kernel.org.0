Return-Path: <linux-arch+bounces-1436-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17828380F3
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 03:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5286328DE0C
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 02:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D83A13BEBD;
	Tue, 23 Jan 2024 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9ZWPZfF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E98013AA39;
	Tue, 23 Jan 2024 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971975; cv=none; b=AusIaTo8IRJ7lcxlKtVUlYZUV9GLQMcWzy1QbgvHnZ4R6gL38MRDBITrUcYzPIGDzTtYu6MfleJO0zdbBO8OljyBgSq92h5Ce3ZuBQfvV85bjpa4lO/z/AZQZFlvds7DHFdiuat+vLGQbcID6WubD+kdF5AWAi22iwGG3KROBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971975; c=relaxed/simple;
	bh=0zOOxVBNBW4qBweDclWnban+lMJxMRSlx4+NvMtrNR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9/YlOnRRPqS+JCnOxGKJ41OGcOf7dwr96+yRSoSYZ0/5RRt2ezXTAGkGPi6fGD1UG06LX4jZ5Kpvhgh9NzDCsudB9CveI6jrEBY4LjnMNd/I2KKZrrJIgf/yVh+8dEMpWtivW5mfCkqNwyHLORDHTY3zhlMUaBTRt0ti0tVm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9ZWPZfF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d6ff29293dso22762285ad.0;
        Mon, 22 Jan 2024 17:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705971972; x=1706576772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Dww+c2ua5vGiOnRP836ljW2S8BcprbVDvaDWfIZ2I50=;
        b=j9ZWPZfFQ/SVCDSZhuixfE+zqccEylRqEiRUmXiE1FRx7hYZ5MsbRMVbCOkAvwHN+p
         dlkHfqexH155VKFEy8Z5LoQrzkcZcJzFl4clnYhpi7ANAJ4mmfanE0TyGIohfCCKNUqD
         uALIduZIVBinq3QDrdxo5+niDEoUY853ZbzaNnwFix3t/undXlUsIRzR4D8fTA4o+32l
         AgEQvrhpY7QfHc3dELJkRpLuteGxUBN0xVvZjsN18wN+HPi9bJAQQPBUTQLaFxDc639R
         /lbyHwyPw6EKwvIM4KPcgrtLmeHm0s3cja9SacMeSCVfceJzDngd2TRD55Oo8uKN71Dn
         0rIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705971972; x=1706576772;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dww+c2ua5vGiOnRP836ljW2S8BcprbVDvaDWfIZ2I50=;
        b=YMmNHvy9SctjgJ39ZMcXSPuZawzG/oQxFtpog6145U25Jji/7+I5GBAye/f4GacKbl
         81PuuqvXX+Et18adMnZhAMawGFCvCi5wsOwHvSZ6XDknZvTkA00dMQem2sHAFfi/SrUL
         seu0F3zuYOO/a2ia2R7gorKmEe+BGjFy24jY/a9Hr+/VJ41PU6jH0GNt69RCiEqoOKd1
         E59nfJggHraSOb5/8guzZkpy5I4S5PzX4QYMv0AGvl/6s+QUasb7uzLOEagelh2IP/Yv
         3wJgo7YWYirOTx4giKZJzWrlN7SnYUC786CedXKK+bLx89tJO9ha5QXsgyygW+gR/xz5
         h5wQ==
X-Gm-Message-State: AOJu0YxW52zpbWW5vdiLCEkAqT12LlnXnpUZn3PJMP1vobj/z+0S+XyF
	NV9imm3NVIA0qY13iiAErEndfdIrre7t5DhuubVDa2/g0cuvxHFV
X-Google-Smtp-Source: AGHT+IH/bOAlBbcgqc0pZiK0H0ofcW2HeJVBCsA8LLR7upvg31tLkkhH156+Hj1H9pzRS3twibcG7w==
X-Received: by 2002:a17:902:e890:b0:1d7:3533:9687 with SMTP id w16-20020a170902e89000b001d735339687mr2217792plg.42.1705971972221;
        Mon, 22 Jan 2024 17:06:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902e29100b001d73228cd99sm4163522plc.99.2024.01.22.17.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 17:06:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e548f697-650e-4333-9f39-19a472b7d90a@roeck-us.net>
Date: Mon, 22 Jan 2024 17:06:09 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/5] kunit: Add tests for csum_ipv6_magic and
 ip_fast_csum
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: David.Laight@aculab.com, Conor Dooley <conor@kernel.org>,
 samuel.holland@sifive.com, xiao.w.wang@intel.com,
 Evan Green <evan@rivosinc.com>, guoren@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>
References: <be959a4bb660466faba5ade7976485c8@AcuMS.aculab.com>
 <mhng-b5f26a34-7632-4423-9f07-3224170bae9f@palmer-ri-x1c9>
 <Za8AXnKCm4cPyVbp@ghost>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Za8AXnKCm4cPyVbp@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 15:55, Charlie Jenkins wrote:
> On Mon, Jan 22, 2024 at 03:39:16PM -0800, Palmer Dabbelt wrote:
>> On Mon, 22 Jan 2024 13:41:48 PST (-0800), David.Laight@ACULAB.COM wrote:
>>> From: Guenter Roeck
>>>> Sent: 22 January 2024 17:16
>>>>
>>>> On 1/22/24 08:52, David Laight wrote:
>>>>> From: Guenter Roeck
>>>>>> Sent: 22 January 2024 16:40
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On Mon, Jan 08, 2024 at 03:57:06PM -0800, Charlie Jenkins wrote:
>>>>>>> Supplement existing checksum tests with tests for csum_ipv6_magic and
>>>>>>> ip_fast_csum.
>>>>>>>
>>>>>>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>>>>>>> ---
>>>>>>
>>>>>> With this patch in the tree, the arm:mps2-an385 qemu emulation gets a bad hiccup.
>>>>>>
>>>>>> [    1.839556] Unhandled exception: IPSR = 00000006 LR = fffffff1
>>>>>> [    1.839804] CPU: 0 PID: 164 Comm: kunit_try_catch Tainted: G                 N 6.8.0-rc1 #1
>>>>>> [    1.839948] Hardware name: Generic DT based system
>>>>>> [    1.840062] PC is at __csum_ipv6_magic+0x8/0xb4
>>>>>> [    1.840408] LR is at test_csum_ipv6_magic+0x3d/0xa4
>>>>>> [    1.840493] pc : [<21212f34>]    lr : [<21117fd5>]    psr: 0100020b
>>>>>> [    1.840586] sp : 2180bebc  ip : 46c7f0d2  fp : 21275b38
>>>>>> [    1.840664] r10: 21276b60  r9 : 21275b28  r8 : 21465cfc
>>>>>> [    1.840751] r7 : 00003085  r6 : 21275b4e  r5 : 2138702c  r4 : 00000001
>>>>>> [    1.840847] r3 : 2c000000  r2 : 1ac7f0d2  r1 : 21275b39  r0 : 21275b29
>>>>>> [    1.840942] xPSR: 0100020b
>>>>>>
>>>>>> This translates to:
>>>>>>
>>>>>> PC is at __csum_ipv6_magic (arch/arm/lib/csumipv6.S:15)
>>>>>> LR is at test_csum_ipv6_magic (./arch/arm/include/asm/checksum.h:60
>>>>>> ./arch/arm/include/asm/checksum.h:163 lib/checksum_kunit.c:617)
>>>>>>
>>>>>> Obviously I can not say if this is a problem with qemu or a problem with
>>>>>> the Linux kernel. Given that, and the presumably low interest in
>>>>>> running mps2-an385 with Linux, I'll simply disable that test. Just take
>>>>>> it as a heads up that there _may_ be a problem with this on arm
>>>>>> nommu systems.
>>>>>
>>>>> Can you drop in a disassembly of __csum_ipv6_magic ?
>>>>> Actually I think it is:
>>>>
>>>> It is, as per the PC pointer above. I don't know anything about arm assembler,
>>>> much less about its behavior with THUMB code.
>>>
>>> Doesn't look like thumb to me (offset 8 is two 4-byte instructions) and
>>> the code I found looks like arm to me.
>>> (I haven't written any arm asm since before they invented thumb!)
>>>
>>>>> ENTRY(__csum_ipv6_magic)
>>>>> 		str	lr, [sp, #-4]!
>>>>> 		adds	ip, r2, r3
>>>>> 		ldmia	r1, {r1 - r3, lr}
>>>>>
>>>>> So the fault is (probably) a misaligned ldmia ?
>>>>> Are they ever supported?
>>>>>
>>>>
>>>> Good question. My primary guess is that this never worked. As I said,
>>>> this was just intended to be informational, (probably) no reason to bother.
>>>>
>>>> Of course one might ask if it makes sense to even keep the arm nommu code
>>>> in the kernel, but that is of course a different question. I do wonder though
>>>> if anyone but me is running it.
>>>
>>> If it is an alignment fault it isn't a 'nommu' bug.
>>>
>>> And traditionally arm didn't support misaligned transfers (well not
>>> in anyway any other cpu did!).
>>> It might be that the kernel assumes that all ethernet packets are
>>> aligned, but the test suite isn't aligning the buffer.
>>> Which would make it a test suite bug.
>>
>>  From talking to Evan and Vineet, I think you're right and this is a test
>> suite bug: specifically the tests weren't respecting NET_IP_ALIGN.  That
>> didn't crop up for ip_fast_csum() as it just uses ldr which supports
>> misaligned accesses on the M3 (at least as far as I can tell).
>>
>> So I think the right fix is something like
>>
>>     diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
>>     index 225bb7701460..2dd282e27dd4 100644
>>     --- a/lib/checksum_kunit.c
>>     +++ b/lib/checksum_kunit.c
>>     @@ -5,6 +5,7 @@
>>      #include <kunit/test.h>
>>      #include <asm/checksum.h>
>>     +#include <asm/checksum.h>
>>      #include <net/ip6_checksum.h>
>>      #define MAX_LEN 512
>>     @@ -15,6 +16,7 @@
>>      #define IPv4_MAX_WORDS 15
>>      #define NUM_IPv6_TESTS 200
>>      #define NUM_IP_FAST_CSUM_TESTS 181
>>     +#define SUPPORTED_ALIGNMENT (1 << NET_IP_ALIGN)
>>      /* Values for a little endian CPU. Byte swap each half on big endian CPU. */
>>      static const u32 random_init_sum = 0x2847aab;
>>     @@ -486,7 +488,7 @@ static void test_csum_fixed_random_inputs(struct kunit *test)
>>      	__sum16 result, expec;
>>      	assert_setup_correct(test);
>>     -	for (align = 0; align < TEST_BUFLEN; ++align) {
>>     +	for (align = 0; align < TEST_BUFLEN; align += SUPPORTED_ALIGNMENT) {
>>      		memcpy(&tmp_buf[align], random_buf,
>>      		       min(MAX_LEN, TEST_BUFLEN - align));
>>      		for (len = 0; len < MAX_LEN && (align + len) < TEST_BUFLEN;
>>     @@ -513,7 +515,7 @@ static void test_csum_all_carry_inputs(struct kunit *test)
>>      	assert_setup_correct(test);
>>      	memset(tmp_buf, 0xff, TEST_BUFLEN);
>>     -	for (align = 0; align < TEST_BUFLEN; ++align) {
>>     +	for (align = 0; align < TEST_BUFLEN; align += SUPPORTED_ALIGNMENT) {
>>      		for (len = 0; len < MAX_LEN && (align + len) < TEST_BUFLEN;
>>      		     ++len) {
>>      			/*
>>     @@ -553,7 +555,7 @@ static void test_csum_no_carry_inputs(struct kunit *test)
>>      	assert_setup_correct(test);
>>      	memset(tmp_buf, 0x4, TEST_BUFLEN);
>>     -	for (align = 0; align < TEST_BUFLEN; ++align) {
>>     +	for (align = 0; align < TEST_BUFLEN; align += SUPPORTED_ALIGNMENT) {
>>      		for (len = 0; len < MAX_LEN && (align + len) < TEST_BUFLEN;
>>      		     ++len) {
>>      			/*
>>
>> but I haven't even build tested it...
> 
> This doesn't fix the test_csum_ipv6_magic test case that was causing the
> initial problem, but the same trick can be done in that test.
> 

The above didn't (and still doesn't) fail for me. The following fixes the problem.
So, yes, I guess the problem has to do with alignment. I don't know if NET_IP_ALIGN
would do the trick, though - it works, but it seems to me that the definition of
NET_IP_ALIGN is supposed to address potential performance issues, not mandatory
IP header alignment.

Thanks,
Guenter

---
diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index 225bb7701460..c8730af2a474 100644
--- a/lib/checksum_kunit.c
+++ b/lib/checksum_kunit.c
@@ -591,6 +591,8 @@ static void test_ip_fast_csum(struct kunit *test)
         }
  }

+#define SUPPORTED_ALIGNMENT (1 << NET_IP_ALIGN)
+
  static void test_csum_ipv6_magic(struct kunit *test)
  {
  #if defined(CONFIG_NET)
@@ -607,7 +609,7 @@ static void test_csum_ipv6_magic(struct kunit *test)
         const int csum_offset = sizeof(struct in6_addr) + sizeof(struct in6_addr) +
                             sizeof(int) + sizeof(char);

-       for (int i = 0; i < NUM_IPv6_TESTS; i++) {
+       for (int i = 0; i < NUM_IPv6_TESTS; i+=SUPPORTED_ALIGNMENT) {
                 saddr = (const struct in6_addr *)(random_buf + i);
                 daddr = (const struct in6_addr *)(random_buf + i +
                                                   daddr_offset);



