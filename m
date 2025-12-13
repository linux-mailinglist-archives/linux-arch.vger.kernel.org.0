Return-Path: <linux-arch+bounces-15388-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1BCBA670
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 08:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614813091A36
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 07:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E766A23BCF7;
	Sat, 13 Dec 2025 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="a+SWfhFi"
X-Original-To: linux-arch@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18465212B0A;
	Sat, 13 Dec 2025 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765609840; cv=none; b=fC8sHE088tZ1XbGh2MBU/pL+Nifi0QV4rJyK2lptx+OEWs1RXvv7KJPAWndtQyl4IYiYgEJPx2b9IiPuwfnMMOk4754BfW3v+0aWzuJaRl9MvmObxJUVLgmCHCr0ExLn4qquz+GYehcuUcteSCDfBOMAOy52jMOZYPbgshqIREk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765609840; c=relaxed/simple;
	bh=o9fJXDtXoVKnzhNQS1ylDA8uNXeuK84gVZGRdlqfvSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O1St/QZQqe9uar8xYMcrmKSESTLOQvt7ordKJcT5RrK859aapBqqBWQCKM6ekJOHyGtQtYeEkYGpZ/4eeBR1hmSihtwV/S1v96SRdcjqLc4VKPFarfcdFYOf6njaQzCItiJvOXIsnhplGHOVASHNmiqMyCLeTQa8lnOHNO2Q7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=a+SWfhFi; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765609839; x=1797145839;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o9fJXDtXoVKnzhNQS1ylDA8uNXeuK84gVZGRdlqfvSA=;
  b=a+SWfhFiXMgL08aqV6lOgN1M8bYD3xtA2fq/xgCcDe+A7kI2JSRIwt0a
   Fp/RKuckDw/winljMCuNIsr3Or63Qk8F0UoZwuPZQgq3oLg01GJkHeybt
   gxqjo52UoCV3/f9N3n9YfYjnKfxK+17yTpvIVJfzwcyQHKhCki0coqWhc
   oNTR7MDUMxjkRF55+oNUVTsU2WCcXNczBKvUm6WBRTlW7RG4auwIFgOTo
   5TYudDgSccEnyk2ElHy+bZWWCTEoivnyVqn8yGWDwyaXHnvj+vwFAWKvD
   c7qT3RF1cxyDnU1i5UP6rYk7vdQYep2risGpqu2ibNDV6FSsVMj5jvfus
   w==;
X-CSE-ConnectionGUID: IArTKZvNTse5aI0KzG9AZQ==
X-CSE-MsgGUID: kwnkf6iXRHa0M3DtExxWHQ==
X-IronPort-AV: E=Sophos;i="6.21,145,1763424000"; 
   d="scan'208";a="8795544"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2025 07:10:36 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:26686]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.135:2525] with esmtp (Farcaster)
 id 0748e64d-5e43-4bf2-9d47-0b42a67cdd9d; Sat, 13 Dec 2025 07:10:36 +0000 (UTC)
X-Farcaster-Flow-ID: 0748e64d-5e43-4bf2-9d47-0b42a67cdd9d
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 13 Dec 2025 07:10:36 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Sat, 13 Dec 2025
 07:10:27 +0000
Message-ID: <e4d1c333-7e22-47ee-81a0-2efc4ca6b17c@amazon.com>
Date: Sat, 13 Dec 2025 16:10:22 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] liveupdate: list all file handler versions in vmlinux
 section
To: Pratyush Yadav <pratyush@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Pasha Tatashin" <pasha.tatashin@soleen.com>, Mike Rapoport
	<rppt@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Samiullah
 Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, David
 Rientjes <rientjes@google.com>, Jason Miu <jasonmiu@google.com>
CC: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
References: <20251211042624.175517-1-pratyush@kernel.org>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20251211042624.175517-1-pratyush@kernel.org>
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGkgUHJhdHl1c2gsCgpPbiAxMC4xMi4yNSAyMDoyNiwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6Cj4g
QXMgbGl2ZSB1cGRhdGUgZXZvbHZlcywgdGhlcmUgd2lsbCBiZSBhIG5lZWQgdG8gdXBkYXRlIHRo
ZSBzZXJpYWxpemF0aW9uCj4gZm9ybWF0cyBmb3IgdGhlIGRpZmZlcmVudCBmaWxlIHR5cGVzLiBU
aGlzIGNvdWxkIGJlIGZvciBhZGRpbmcgbmV3Cj4gZmVhdHVyZXMsIGZvciBzdXBwb3J0aW5nIGEg
Y2hhbmdlIGluIGJlaGF2aW91ciwgb3IgdG8gZml4IGJ1Z3MuCj4KPiBJZiB0aGUgY3VycmVudCBr
ZXJuZWwgZG9lcyBub3QgdW5kZXJzdGFuZCB0aGUgc2FtZSBzZXQgb2YgdmVyc2lvbnMgYXMKPiB0
aGUgbmV4dCBrZXJuZWwsIGxpdmUgdXBkYXRlIHdpbGwgaW5ldml0YWJseSBmYWlsLiBUaGUgbmV4
dCBrZXJuZWwgd2lsbAo+IGJlIHVuYWJsZSB0byB1bmRlcnN0YW5kIHRoZSBoYW5kZWQgb3ZlciBk
YXRhIGFuZCB3aWxsIGJlIHVuYWJsZSB0bwo+IHJlc3RvcmUgbWVtb3J5LCBkZXZpY2VzLCBJT01N
VSBwYWdlIHRhYmxlcywgZXRjLgo+Cj4gTGlzdCB0aGUgc2V0IG9mIHZlcnNpb25zIHRoZSBrZXJu
ZWwgdW5kZXJzdGFuZHMgaW4gYSBzZWN0aW9uIGluIHZtbGludXguCj4gVGhpcyBjYW4gdGhlbiBi
ZSB1c2VkIGJ5IHVzZXJzcGFjZSB0b29saW5nIHRvIG1ha2Ugc3VyZSB0aGUgc2V0IG9mIGZpbGUK
PiBkZXNjcmlwdG9ycyBpdCB1c2VzIGhhdmUgdGhlIHNhbWUgdmVyc2lvbiBiZXR3ZWVuIGJvdGgg
a2VybmVscy4gSWYgdGhlcmUKPiBpcyBhIG1pc21hdGNoLCB0aGUgdG9vbGluZyBjYW4gY2F0Y2gg
dGhpcyBlYXJseSBhbmQgYWJvcnQgbGl2ZSB1cGRhdGUKPiBiZWZvcmUgaXQgaXMgdG9vIGxhdGUu
Cj4KPiBUaGUgdmVyc2lvbnMgYXJlIGxpc3RlZCBpbiBhIHNlY3Rpb24gY2FsbGVkICIubGl2ZXVw
ZGF0ZV92ZXJzaW9ucyIuIFRoZQo+IHNlY3Rpb24gaGFzIGEgaGVhZGVyIHRoYXQgY29udGFpbnMg
YSBtYWdpYyBudW1iZXIgYW5kIHRoZSB2ZXJzaW9uIG9mIHRoZQo+IGRhdGEgZm9ybWF0LiBUaGUg
bGlzdCBvZiB2ZXJzaW9uIHN0cmluZ3MgZGlyZWN0bHkgZm9sbG93IHRoaXMgaGVhZGVyLgo+IE9u
bHkgdGhlIHZlcnNpb24gc3RyaW5ncyBhcmUgbGlzdGVkLCBhbmQgaXQgaXMgdXAgdG8gdXNlcnNw
YWNlIHRvIG1hcAo+IHRoZW0gdG8gZmlsZSBkZXNjcmlwdG9yIHR5cGVzLgo+Cj4gVGhlIGZvcm1h
dCBvZiB0aGUgc2VjdGlvbiBoYXMgdGhlIHNhbWUgQUJJIHJ1bGVzIGFzIHRoZSByZXN0IG9mIExV
TyBBQkkuCj4KPiBJbnRyb2R1Y2UgYSBMSVZFVVBEQVRFX0ZJTEVfSEFORExFUiBtYWNybyB0aGF0
IG1ha2VzIGl0IGVhc3kgdG8gZGVmaW5lIGEKPiBmaWxlIGhhbmRsZXIgd2hpbGUgYWxzbyBhZGRp
bmcgaXRzIHZlcnNpb24gc3RyaW5nIHRvIHRoZSByaWdodCBzZWN0aW9uLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogUHJhdHl1c2ggWWFkYXYgPHByYXR5dXNoQGtlcm5lbC5vcmc+CgoKVG8gc3VwcG9ydCBt
dWx0aS12ZXJzaW9uIHByZXNlcnZhdGlvbiBhbmQgcmVzdW1lLCBob3cgYWJvdXQgeW91IGFkZCBh
IAoicHJvZmlsZSIgaGludCB0byB0aGUgaGFuZGxlcnM/IFRoZW4geW91IGNhbiB0YWcgdGhlIGhh
bmRsZXJzIHdpdGggCiJjdXJyZW50IiBhbmQgYSAicHJldmlvdXMiLiBZb3UgdGhlbiBleHBvc2Ug
b25lIHNlY3Rpb24gdGFibGUgd2l0aCAKc3VwcG9ydGVkIHZlcnNpb25zIHBlciBwcm9maWxlLiBB
bmQgdGhhdCBtZWFucyB5b3UgY2FuIGZyb20gdXNlciBzcGFjZSAKc2VsZWN0IHRoZSBsb2NhbCBw
cm9maWxlIHRvIHNlcmlhbGl6ZSBhbmQgbWF0Y2ggdGhhdCBhZ2FpbnN0IHRoZSB0YXJnZXQgCnBy
b2ZpbGUgb2YgdGhlIHRhcmdldCBzeXN0ZW0uCgpJdCBhbHNvIGFsbG93cyB5b3UgdG8gc3VwcG9y
dCBtb3JlICJwcm9maWxlcyIsIHN1Y2ggYXMgZWxhYm9yYXRlIApkb3duc3RyZWFtIHZlcnNpb24g
Y29tYmluYXRpb25zLCB0aGF0IHVwc3RyZWFtIHdpbGwgbm90IGhhdmUgdG8gY2FyZSBhYm91dC4K
CgpBbGV4CgoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFu
eSBHbWJIClRhbWFyYS1EYW56LVN0ci4gMTMKMTAyNDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVu
ZzogQ2hyaXN0b2YgSGVsbG1pcywgQW5kcmVhcyBTdGllZ2VyCkVpbmdldHJhZ2VuIGFtIEFtdHNn
ZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0
LUlEOiBERSAzNjUgNTM4IDU5Nwo=


