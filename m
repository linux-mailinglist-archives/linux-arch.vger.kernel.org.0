Return-Path: <linux-arch+bounces-6676-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4125961397
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 18:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5391F2447B
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24D01C6F5A;
	Tue, 27 Aug 2024 16:05:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32E964A;
	Tue, 27 Aug 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774707; cv=none; b=QAFFA9+wyjWN6db1RcvqHaYl4EN/oH6x5kKfB6XWN3Zg4uYQAM+Nr2qKcpL2Nn2GdzFNgXw7XqDSEV0GE813DKUc0iN+osBzHBCrrpjzZcG6HtW3l2EQVwAxiKrkYF6pMEV1hxMZ4kar3Dyu9hN4L4qXhCYOSP6gdye+var5C24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774707; c=relaxed/simple;
	bh=8fbPAKIpZ2IbypYF/uGc6tpQpTFWAd6gZKF4R05KHgo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=VenDBJK1e8O3egxsZdTL6Z4km3H2poTooto03ggH7JcTPrP0fBlCB90w80c5ZUH4HUEI4D/1JAMsxlKbs60ECzGo4/xz/K2xEj2RMgYHn6D8rYOw1BWfB/iMLuJ1vTPhJvVwID6oqDKIcXFJOwTmPwdE1KkmkOHb845MUBt5lIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2608DDA7;
	Tue, 27 Aug 2024 09:05:31 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFE4F3F762;
	Tue, 27 Aug 2024 09:05:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------QEwA5gt7zV1lGdR6NrQpIERR"
Message-ID: <17437f43-9d1f-4263-888e-573a355cb0b5@arm.com>
Date: Tue, 27 Aug 2024 17:05:01 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] random: vDSO: Redefine PAGE_SIZE and PAGE_MASK
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Arnd Bergmann <arnd@arndb.de>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Linux-Arch <linux-arch@vger.kernel.org>
References: <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>
 <defab86b7fb897c88a05a33b62ccf38467dda884.1724747058.git.christophe.leroy@csgroup.eu>
 <Zs2RCfMgfNu_2vos@zx2c4.com>
 <cb66b582-ba63-4a5a-9df8-b07288f1f66d@app.fastmail.com>
 <0f9255f1-5860-408c-8eaa-ccb4dd3747fa@csgroup.eu>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <0f9255f1-5860-408c-8eaa-ccb4dd3747fa@csgroup.eu>

This is a multi-part message in MIME format.
--------------QEwA5gt7zV1lGdR6NrQpIERR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christophe,

On 27/08/2024 11:49, Christophe Leroy wrote:

...


>>
>> These are still two headers outside of the vdso/ namespace. For arm64
>> we had concluded that this is never safe, and any vdso header should
>> only include other vdso headers so we never pull in anything that
>> e.g. depends on memory management headers that are in turn broken
>> for the compat vdso.
>>
>> The array_size.h header is really small, so that one could
>> probably just be moved into the vdso/ namespace. The minmax.h
>> header is already rather complex, so it may be better to just
>> open-code the usage of MIN/MAX where needed?
> 
> It is used at two places only so yes can to that.
>

Could you please clarify where minmax is needed? I tried to build Jason's master
tree for x86, commenting the header and it seems building fine. I might be
missing something.

> Same for ARRAY_SIZE(->reserved) by the way, easy to do opencode, we also have it
> only once
> 

I have a similar issue to figure out why linux/array_size.h and
uapi/linux/random.h are needed. It seems that I can build the object without
them. Could you please explain?

In general, the philosophy adopted to split the headers is to extract the set of
functions used by vDSOs from the linux headers and place them in the vdso headers.
Consequently the linux header includes to vdso one. E.g.: linux/time64.h
includes vdso/time64.h.

IMHO we should follow the same approach, if at all for consistency, unless there
is a valid reason.

...

>>
>> Including uapi/linux/mman.h may still be problematic on
>> some architectures if they change it in a way that is
>> incompatible with compat vdso, but at least that can't
>> accidentally rely on CONFIG_64BIT or something else that
>> would be wrong there.
> 
> Yes that one is tricky. Because uapi/linux/mman.h includes asm/mman.h with the
> intention to include uapi/asm/mman.h but when built from the kernel in reality
> you get arch/powerpc/include/asm/mman.h and I had to add some ifdefery to
> kick-out kernel oddities it contains that pull additional kernel headers.
> 
> diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
> index 17a77d47ed6d..42a51a993d94 100644
> --- a/arch/powerpc/include/asm/mman.h
> +++ b/arch/powerpc/include/asm/mman.h
> @@ -6,7 +6,7 @@
> 
>  #include <uapi/asm/mman.h>
> 
> -#ifdef CONFIG_PPC64
> +#if defined(CONFIG_PPC64) && !defined(BUILD_VDSO)
> 
>  #include <asm/cputable.h>
>  #include <linux/mm.h>
> 

I agree with Arnd here. uapi/linux/mman.h can cause us problems in the long run.

I am attaching a patch to provide my view on how to minimize the headers
included and use only the vdso/ namespace. Please, before using the code,
consider that I conducted very limited testing.

Note: It should apply clean on Jason's tree.

Let me know your thoughts.

> 
> Christophe

-- 
Regards,
Vincenzo
--------------QEwA5gt7zV1lGdR6NrQpIERR
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-random-VDSO-Use-only-headers-from-the-vdso-namespace.patch"
Content-Disposition: attachment;
 filename*0="0001-random-VDSO-Use-only-headers-from-the-vdso-namespace.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxOTMzMDI4ZWFlZWJjNWMwNTMzMDkzNzljNDNkZGVhNWI0NjBjMjVlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBWaW5jZW56byBGcmFzY2lubyA8dmluY2Vuem8uZnJh
c2Npbm9AYXJtLmNvbT4KRGF0ZTogVHVlLCAyNyBBdWcgMjAyNCAxNjo0NDozMiArMDEwMApT
dWJqZWN0OiBbUEFUQ0hdIHJhbmRvbTogVkRTTzogVXNlIG9ubHkgaGVhZGVycyBmcm9tIHRo
ZSB2ZHNvLyBuYW1lc3BhY2UKClRoZSBWRFNPIGltcGxlbWVudGF0aW9uIGluY2x1ZGVzIGhl
YWRlcnMgZnJvbSBvdXRzaWRlIG9mIHRoZQp2ZHNvLyBuYW1lc3BhY2UuCgpSZWZhY3RvciB0
aGUgY29kZSB0byBtYWtlIHN1cmUgdGhhdCB0aGUgZ2VuZXJpYyBsaWJyYXJ5IHVzZXMgb25s
eSB0aGUKYWxsb3dlZCBuYW1lc3BhY2UuCgpTaWduZWQtb2ZmLWJ5OiBWaW5jZW56byBGcmFz
Y2lubyA8dmluY2Vuem8uZnJhc2Npbm9AYXJtLmNvbT4KLS0tCiBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS92ZHNvL2dldHJhbmRvbS5oIHwgIDIgKysKIGFyY2gveDg2L2luY2x1ZGUvYXNtL3Zk
c28vbW1hbi5oICAgICAgfCAxNSArKysrKysrKysrKysrKysKIGFyY2gveDg2L2luY2x1ZGUv
YXNtL3Zkc28vcGFnZS5oICAgICAgfCAxNSArKysrKysrKysrKysrKysKIGluY2x1ZGUvdmRz
by9nZXRyYW5kb20uaCAgICAgICAgICAgICAgfCAgMSArCiBpbmNsdWRlL3Zkc28vbW1hbi5o
ICAgICAgICAgICAgICAgICAgIHwgIDcgKysrKysrKwogaW5jbHVkZS92ZHNvL3BhZ2UuaCAg
ICAgICAgICAgICAgICAgICB8ICA3ICsrKysrKysKIGxpYi92ZHNvL2dldHJhbmRvbS5jICAg
ICAgICAgICAgICAgICAgfCAyMCArKysrKystLS0tLS0tLS0tLS0tLQogNyBmaWxlcyBjaGFu
Z2VkLCA1MyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBhcmNoL3g4Ni9pbmNsdWRlL2FzbS92ZHNvL21tYW4uaAogY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gveDg2L2luY2x1ZGUvYXNtL3Zkc28vcGFnZS5oCiBjcmVhdGUgbW9kZSAxMDA2
NDQgaW5jbHVkZS92ZHNvL21tYW4uaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvdmRz
by9wYWdlLmgKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92ZHNvL2dldHJh
bmRvbS5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdmRzby9nZXRyYW5kb20uaAppbmRleCBi
OTZlNjc0Y2FmZGUuLjQ1N2YyMzdiZDYwMiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vdmRzby9nZXRyYW5kb20uaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92ZHNv
L2dldHJhbmRvbS5oCkBAIC03LDYgKzcsOCBAQAogCiAjaWZuZGVmIF9fQVNTRU1CTFlfXwog
CisjaW5jbHVkZSA8dmRzby9kYXRhcGFnZS5oPgorCiAjaW5jbHVkZSA8YXNtL3VuaXN0ZC5o
PgogI2luY2x1ZGUgPGFzbS92dmFyLmg+CiAKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3Zkc28vbW1hbi5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdmRzby9tbWFuLmgK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi40YzkzNmM5ZDExYWIK
LS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92ZHNvL21tYW4uaApA
QCAtMCwwICsxLDE1IEBACisKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
ICovCisjaWZuZGVmIF9fQVNNX1ZEU09fTU1BTl9ICisjZGVmaW5lIF9fQVNNX1ZEU09fTU1B
Tl9ICisKKyNpZm5kZWYgX19BU1NFTUJMWV9fCisKKyNpbmNsdWRlIDx1YXBpL2xpbnV4L21t
YW4uaD4KKworI2RlZmluZSBWRFNPX01NQVBfUFJPVAlQUk9UX1JFQUQgfCBQUk9UX1dSSVRF
CisjZGVmaW5lIFZEU09fTU1BUF9GTEFHUwlNQVBfRFJPUFBBQkxFIHwgTUFQX0FOT05ZTU9V
UworCisjZW5kaWYgLyogIV9fQVNTRU1CTFlfXyAqLworCisjZW5kaWYgLyogX19BU01fVkRT
T19NTUFOX0ggKi8KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Zkc28vcGFn
ZS5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdmRzby9wYWdlLmgKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi5iMGFmOGZiZWYyN2MKLS0tIC9kZXYvbnVsbAor
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92ZHNvL3BhZ2UuaApAQCAtMCwwICsxLDE1IEBA
CisKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovCisjaWZuZGVmIF9f
QVNNX1ZEU09fUEFHRV9ICisjZGVmaW5lIF9fQVNNX1ZEU09fUEFHRV9ICisKKyNpZm5kZWYg
X19BU1NFTUJMWV9fCisKKyNpbmNsdWRlIDxhc20vcGFnZV90eXBlcy5oPgorCisjZGVmaW5l
IFZEU09fUEFHRV9NQVNLCVBBR0VfTUFTSworI2RlZmluZSBWRFNPX1BBR0VfU0laRQlQQUdF
X1NJWkUKKworI2VuZGlmIC8qICFfX0FTU0VNQkxZX18gKi8KKworI2VuZGlmIC8qIF9fQVNN
X1ZEU09fUEFHRV9IICovCmRpZmYgLS1naXQgYS9pbmNsdWRlL3Zkc28vZ2V0cmFuZG9tLmgg
Yi9pbmNsdWRlL3Zkc28vZ2V0cmFuZG9tLmgKaW5kZXggYThiN2MxNGIwYWUwLi45Y2Y2NTI1
MmVlODggMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdmRzby9nZXRyYW5kb20uaAorKysgYi9pbmNs
dWRlL3Zkc28vZ2V0cmFuZG9tLmgKQEAgLTcsNiArNyw3IEBACiAjZGVmaW5lIF9WRFNPX0dF
VFJBTkRPTV9ICiAKICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgorI2luY2x1ZGUgPGFzbS92
ZHNvL2dldHJhbmRvbS5oPgogCiAjZGVmaW5lIENIQUNIQV9LRVlfU0laRSAgICAgICAgIDMy
CiAjZGVmaW5lIENIQUNIQV9CTE9DS19TSVpFICAgICAgIDY0CmRpZmYgLS1naXQgYS9pbmNs
dWRlL3Zkc28vbW1hbi5oIGIvaW5jbHVkZS92ZHNvL21tYW4uaApuZXcgZmlsZSBtb2RlIDEw
MDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjk1ZTNkYTcxNGM2NAotLS0gL2Rldi9udWxsCisr
KyBiL2luY2x1ZGUvdmRzby9tbWFuLmgKQEAgLTAsMCArMSw3IEBACisvKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLworI2lmbmRlZiBfX1ZEU09fTU1BTl9ICisjZGVm
aW5lIF9fVkRTT19NTUFOX0gKKworI2luY2x1ZGUgPGFzbS92ZHNvL21tYW4uaD4KKworI2Vu
ZGlmCS8qIF9fVkRTT19NTUFOX0ggKi8KZGlmZiAtLWdpdCBhL2luY2x1ZGUvdmRzby9wYWdl
LmggYi9pbmNsdWRlL3Zkc28vcGFnZS5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAw
MDAwMDAwMDAwMC4uZjE4ZTMwNDk0MWNiCi0tLSAvZGV2L251bGwKKysrIGIvaW5jbHVkZS92
ZHNvL3BhZ2UuaApAQCAtMCwwICsxLDcgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wICovCisjaWZuZGVmIF9fVkRTT19QQUdFX0gKKyNkZWZpbmUgX19WRFNPX1BB
R0VfSAorCisjaW5jbHVkZSA8YXNtL3Zkc28vcGFnZS5oPgorCisjZW5kaWYJLyogX19WRFNP
X1BBR0VfSCAqLwpkaWZmIC0tZ2l0IGEvbGliL3Zkc28vZ2V0cmFuZG9tLmMgYi9saWIvdmRz
by9nZXRyYW5kb20uYwppbmRleCA5MzhjYTUzOWFhYTYuLjA5MzZmZDFjYTZjZSAxMDA2NDQK
LS0tIGEvbGliL3Zkc28vZ2V0cmFuZG9tLmMKKysrIGIvbGliL3Zkc28vZ2V0cmFuZG9tLmMK
QEAgLTMsMTkgKzMsMTEgQEAKICAqIENvcHlyaWdodCAoQykgMjAyMi0yMDI0IEphc29uIEEu
IERvbmVuZmVsZCA8SmFzb25AengyYzQuY29tPi4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KICAq
LwogCi0jaW5jbHVkZSA8bGludXgvYXJyYXlfc2l6ZS5oPgotI2luY2x1ZGUgPGxpbnV4L21p
bm1heC5oPgogI2luY2x1ZGUgPHZkc28vZGF0YXBhZ2UuaD4KICNpbmNsdWRlIDx2ZHNvL2dl
dHJhbmRvbS5oPgogI2luY2x1ZGUgPHZkc28vdW5hbGlnbmVkLmg+Ci0jaW5jbHVkZSA8YXNt
L3Zkc28vZ2V0cmFuZG9tLmg+Ci0jaW5jbHVkZSA8dWFwaS9saW51eC9tbWFuLmg+Ci0jaW5j
bHVkZSA8dWFwaS9saW51eC9yYW5kb20uaD4KLQotI3VuZGVmIFBBR0VfU0laRQotI3VuZGVm
IFBBR0VfTUFTSwotI2RlZmluZSBQQUdFX1NJWkUgKDFVTCA8PCBDT05GSUdfUEFHRV9TSElG
VCkKLSNkZWZpbmUgUEFHRV9NQVNLICh+KFBBR0VfU0laRSAtIDEpKQorI2luY2x1ZGUgPHZk
c28vbW1hbi5oPgorI2luY2x1ZGUgPHZkc28vcGFnZS5oPgogCiAjZGVmaW5lIE1FTUNQWV9B
TkRfWkVST19TUkModHlwZSwgZHN0LCBzcmMsIGxlbikgZG8gewkJCQlcCiAJd2hpbGUgKGxl
biA+PSBzaXplb2YodHlwZSkpIHsJCQkJCQlcCkBAIC02OCw3ICs2MCw3IEBAIHN0YXRpYyBf
X2Fsd2F5c19pbmxpbmUgc3NpemVfdAogX19jdmRzb19nZXRyYW5kb21fZGF0YShjb25zdCBz
dHJ1Y3QgdmRzb19ybmdfZGF0YSAqcm5nX2luZm8sIHZvaWQgKmJ1ZmZlciwgc2l6ZV90IGxl
biwKIAkJICAgICAgIHVuc2lnbmVkIGludCBmbGFncywgdm9pZCAqb3BhcXVlX3N0YXRlLCBz
aXplX3Qgb3BhcXVlX2xlbikKIHsKLQlzc2l6ZV90IHJldCA9IG1pbl90KHNpemVfdCwgSU5U
X01BWCAmIFBBR0VfTUFTSyAvKiA9IE1BWF9SV19DT1VOVCAqLywgbGVuKTsKKwlzc2l6ZV90
IHJldCA9IG1pbl90KHNpemVfdCwgSU5UX01BWCAmIFZEU09fUEFHRV9NQVNLIC8qID0gTUFY
X1JXX0NPVU5UICovLCBsZW4pOwogCXN0cnVjdCB2Z2V0cmFuZG9tX3N0YXRlICpzdGF0ZSA9
IG9wYXF1ZV9zdGF0ZTsKIAlzaXplX3QgYmF0Y2hfbGVuLCBuYmxvY2tzLCBvcmlnX2xlbiA9
IGxlbjsKIAlib29sIGluX3VzZSwgaGF2ZV9yZXRyaWVkID0gZmFsc2U7CkBAIC03OSwxNSAr
NzEsMTUgQEAgX19jdmRzb19nZXRyYW5kb21fZGF0YShjb25zdCBzdHJ1Y3QgdmRzb19ybmdf
ZGF0YSAqcm5nX2luZm8sIHZvaWQgKmJ1ZmZlciwgc2l6ZV8KIAlpZiAodW5saWtlbHkob3Bh
cXVlX2xlbiA9PSB+MFVMICYmICFidWZmZXIgJiYgIWxlbiAmJiAhZmxhZ3MpKSB7CiAJCXN0
cnVjdCB2Z2V0cmFuZG9tX29wYXF1ZV9wYXJhbXMgKnBhcmFtcyA9IG9wYXF1ZV9zdGF0ZTsK
IAkJcGFyYW1zLT5zaXplX29mX29wYXF1ZV9zdGF0ZSA9IHNpemVvZigqc3RhdGUpOwotCQlw
YXJhbXMtPm1tYXBfcHJvdCA9IFBST1RfUkVBRCB8IFBST1RfV1JJVEU7Ci0JCXBhcmFtcy0+
bW1hcF9mbGFncyA9IE1BUF9EUk9QUEFCTEUgfCBNQVBfQU5PTllNT1VTOworCQlwYXJhbXMt
Pm1tYXBfcHJvdCA9IFZEU09fTU1BUF9QUk9UOworCQlwYXJhbXMtPm1tYXBfZmxhZ3MgPSBW
RFNPX01NQVBfRkxBR1M7CiAJCWZvciAoc2l6ZV90IGkgPSAwOyBpIDwgQVJSQVlfU0laRShw
YXJhbXMtPnJlc2VydmVkKTsgKytpKQogCQkJcGFyYW1zLT5yZXNlcnZlZFtpXSA9IDA7CiAJ
CXJldHVybiAwOwogCX0KIAogCS8qIFRoZSBzdGF0ZSBtdXN0IG5vdCBzdHJhZGRsZSBhIHBh
Z2UsIHNpbmNlIHBhZ2VzIGNhbiBiZSB6ZXJvZWQgYXQgYW55IHRpbWUuICovCi0JaWYgKHVu
bGlrZWx5KCgodW5zaWduZWQgbG9uZylvcGFxdWVfc3RhdGUgJiB+UEFHRV9NQVNLKSArIHNp
emVvZigqc3RhdGUpID4gUEFHRV9TSVpFKSkKKwlpZiAodW5saWtlbHkoKCh1bnNpZ25lZCBs
b25nKW9wYXF1ZV9zdGF0ZSAmIH5WRFNPX1BBR0VfTUFTSykgKyBzaXplb2YoKnN0YXRlKSA+
IFZEU09fUEFHRV9TSVpFKSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAKIAkvKiBIYW5kbGUgdW5l
eHBlY3RlZCBmbGFncyBieSBmYWxsaW5nIGJhY2sgdG8gdGhlIGtlcm5lbC4gKi8KLS0gCjIu
MzQuMQoK

--------------QEwA5gt7zV1lGdR6NrQpIERR--

