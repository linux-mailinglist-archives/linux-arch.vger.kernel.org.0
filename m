Return-Path: <linux-arch+bounces-12255-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CA5AD05F5
	for <lists+linux-arch@lfdr.de>; Fri,  6 Jun 2025 17:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34961BA008D
	for <lists+linux-arch@lfdr.de>; Fri,  6 Jun 2025 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB7328C5CC;
	Fri,  6 Jun 2025 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMGAp+k5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FF428C2D8;
	Fri,  6 Jun 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224642; cv=none; b=lGq9+UCEpGYHCS32qScp8wsTQ/h7kYkmIr4LHcgozPWWOCRCfiSg887ci+JfhFPnmTAWLtsP6fWXRFCqKpcjbJzaKFjoSJTSJhf/AanQ2KM88S7aXQh5KHrORb6XOMb15q58oxdHJ/KNswLAbKNZMJu5ZCNpsjo0Z38VyuutHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224642; c=relaxed/simple;
	bh=lB7lYnSbEiy3QlbxWlsGm9NoOotpmKsaXkCsatuLtCU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=j5MS2ph4PlloO8GF4KZCjOUw9DIiyI9H7am2oY/efr229Pa6+zTSE5gMlC8VvVylX7H0tkDDfmEYKtZmPqqeZmOev7/e71QWsmPOoSRxrrY/ZmnDITNHjRYPTKi4D9FLNVZeEDBabIO2Gn3BAhqlft8XDaY4DwBRVwIc/UROVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMGAp+k5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749224641; x=1780760641;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=lB7lYnSbEiy3QlbxWlsGm9NoOotpmKsaXkCsatuLtCU=;
  b=dMGAp+k5q9eIA56QE3vf+mjdl1tNwg8QY8i7qtE8Xf4XpxIShrerWI6f
   l+BbffjZvLhPPvwVfIJP++M8m/qsqjMoqHYwsLDImZiiSvUBqmrzkoKoE
   rq52BzQEyQRdc4lm/XR7yR9BgyNy/QSVp/khR04BvG/nEURVWfG+3WDyx
   S1ppBAbDoH4tV4e9zRVOMCXvjou+7KQAU7JDEEFIXlrSQv6/TLybKdEy2
   cnHJbsXB5nqTthGy5GWsCPi+4HohwdL8xHw1fZ1J7B2UU5A9dOzBStqWw
   5R+zOxJZPD1wa+/0KlkbMG/1B20JDHVHdpthXD/c5WmQ/OLLDevjvJOne
   g==;
X-CSE-ConnectionGUID: Hx6NfXDoQV2rFOW5onEi2g==
X-CSE-MsgGUID: KOLghiviTI6+vjqhqKbxPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51456348"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208,223";a="51456348"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 08:44:00 -0700
X-CSE-ConnectionGUID: ENqPB+5XQGiQY/yi1cX9fQ==
X-CSE-MsgGUID: AsKefRFdRIGewsNhJnZ6bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208,223";a="149693365"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.111.31]) ([10.125.111.31])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 08:43:58 -0700
Content-Type: multipart/mixed; boundary="------------N9L4FQ8octb0E0gpQ8FX8oQZ"
Message-ID: <6412d84a-edc3-4723-89f1-b2017fb0d1ea@intel.com>
Date: Fri, 6 Jun 2025 08:43:57 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Large modules with 6.15 [was: [PATCH v4 6/6] percpu/x86: Enable
 strict percpu checks via named AS qualifiers]
To: Jiri Slaby <jirislaby@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-arch@vger.kernel.org,
 netdev@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20250127160709.80604-1-ubizjak@gmail.com>
 <20250127160709.80604-7-ubizjak@gmail.com>
 <02c00acd-9518-4371-be2c-eb63e5d11d9c@kernel.org>
 <b27d96fc-b234-4406-8d6e-885cd97a87f3@intel.com>
 <CAFULd4Ygz8p8rD1=c-S2MjJniP6vjVNMsWG_B=OjCVpthk0fBg@mail.gmail.com>
 <9767d411-81dc-491b-b6da-419240065ffe@kernel.org>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <9767d411-81dc-491b-b6da-419240065ffe@kernel.org>

This is a multi-part message in MIME format.
--------------N9L4FQ8octb0E0gpQ8FX8oQZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/25 02:17, Jiri Slaby wrote:
> Given this is the second time I hit a bug with this, perhaps introduce
> an EXPERIMENTAL CONFIG option, so that random users can simply disable
> it if an issue occurs? Without the need of patching random userspace and
> changing random kernel headers?

What about something like the attached (untested) patch? That should at
least get folks back to the old, universal working behavior even when
using new compilers.
--------------N9L4FQ8octb0E0gpQ8FX8oQZ
Content-Type: text/x-patch; charset=UTF-8; name="CC_USE_TYPEOF_UNQUAL1.patch"
Content-Disposition: attachment; filename="CC_USE_TYPEOF_UNQUAL1.patch"
Content-Transfer-Encoding: base64

RnJvbSAwOGQ5OGI0ZmEwOGJhNzZiZTk2ZTQwNmI1M2FlNjk5NDY4NDJmNmE5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXgu
aW50ZWwuY29tPgpEYXRlOiBGcmksIDYgSnVuIDIwMjUgMDg6MzM6MjkgLTA3MDAKU3ViamVj
dDogW1BBVENIXSBjb21waWxlci5oOiBFbmFibGUgY29uZmlnIGNob2ljZSBmb3IgdXNpbmcg
dW5xdWFsaWZpZWQgY2FzdHMKClRZUEVPRl9VTlFVQUwoKSBoYXMgYSBub2JsZSBnb2FsIG9m
IGxldHRpbmcgbm9ybWFsIGNvbXBpbGVycyBkbyBtb3JlCm9mIHRoZSBqb2Igbm9ybWFsbHkg
cmVzZXJ2ZWQgZm9yIHNwYXJzZS4gQnV0IGl0IGhhcyBjYXVzZWQgKG9yCmV4cG9zZWQpIGEg
bnVtYmVyIG9mIG5hc3R5IGJ1Z3MgYW5kIGlzIG5vdCBxdWl0ZSByZWFkeSBmb3IgcHJpbWUg
dGltZS4KRXZlbiBuYXN0aWVyLCBzb21lIG9mIHRoZXNlIGlzc3VlcyBuZWVkIHNlcGFyYXRl
IHVzZXJzcGFjZSBmaXhlcy4KClJpZ2h0IG5vdywgX190eXBlb2ZfdW5xdWFsX18gd2lsbCBi
ZSB3aGVuZXZlciB0aGUgY29tcGlsZXIgc3VwcG9ydHMKaXQuIFJlc3RyaWN0IGl0IHRvIGNh
c2VzIHdoZXJlIHVzZXJzIGhhdmUgb3B0ZWQgaW4gd2l0aCBhIG5ldyBLY29uZmlnCm9wdGlv
bi4gVGhpcyBvcHRpb24gY2FuIGVpdGhlciBiZSByZW1vdmVkIG9yIGhhdmUgaXRzIGRlZmF1
bHQgcG9sYXJpdHkKZmxpcHBlZCB3aGVuIHVzZXJzcGFjZSBpcyB3aWRlbHkgZml4ZWQgdXAu
CgpTaWduZWQtb2ZmLWJ5OiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwu
Y29tPgotLS0KIGluY2x1ZGUvbGludXgvY29tcGlsZXIuaCB8ICAyICstCiBpbml0L0tjb25m
aWcgICAgICAgICAgICAgfCAxMSArKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9jb21waWxlci5oIGIvaW5jbHVkZS9saW51eC9jb21waWxlci5oCmluZGV4IDI3NzI1ZjFh
YjVhYmMuLjNlZmE5M2Y4ZWNhNjYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvY29tcGls
ZXIuaAorKysgYi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLmgKQEAgLTIzMiw3ICsyMzIsNyBA
QCB2b2lkIGZ0cmFjZV9saWtlbHlfdXBkYXRlKHN0cnVjdCBmdHJhY2VfbGlrZWx5X2RhdGEg
KmYsIGludCB2YWwsCiAgKiBYWFg6IFJlbW92ZSB0ZXN0IGZvciBfX0NIRUNLRVJfXyBvbmNl
CiAgKiBzcGFyc2UgbGVhcm5zIGFib3V0IF9fdHlwZW9mX3VucXVhbF9fKCkuCiAgKi8KLSNp
ZiBDQ19IQVNfVFlQRU9GX1VOUVVBTCAmJiAhZGVmaW5lZChfX0NIRUNLRVJfXykKKyNpZiBk
ZWZpbmVkKENPTkZJR19DQ19VU0VfVFlQRU9GX1VOUVVBTCkgJiYgQ0NfSEFTX1RZUEVPRl9V
TlFVQUwgJiYgIWRlZmluZWQoX19DSEVDS0VSX18pCiAjIGRlZmluZSBVU0VfVFlQRU9GX1VO
UVVBTCAxCiAjZW5kaWYKIApkaWZmIC0tZ2l0IGEvaW5pdC9LY29uZmlnIGIvaW5pdC9LY29u
ZmlnCmluZGV4IDYzZjU5NzRiOWZhNmUuLjc0ZTVlOGQ2NDA3NTAgMTAwNjQ0Ci0tLSBhL2lu
aXQvS2NvbmZpZworKysgYi9pbml0L0tjb25maWcKQEAgLTE0ODksNiArMTQ4OSwxNyBAQCBj
b25maWcgQ0NfT1BUSU1JWkVfRk9SX1NJWkUKIAogZW5kY2hvaWNlCiAKK2NvbmZpZyBDQ19V
U0VfVFlQRU9GX1VOUVVBTAorCWJvb2wgIlVzZSBjb21waWxlci1wcm92aWRlZCB1bnF1YWxp
ZmllZCBjYXN0cyAoRVhQRVJJTUVOVEFMKSIKKwlkZXBlbmRzIG9uIEVYUEVSVAorCWhlbHAK
KwkgIE5ld2VyIGNvbXBpbGVycyBoYXZlIHRoZSBhYmlsaXR5IHRvIGRvICJ1bnF1YWxpZmll
ZCIgY2FzdHMgd2hpY2gKKwkgIHN0cmlwIG91dCB0eXBlIHF1YWxpZmllcnMgbGlrZSAnY29u
c3QnLiBLZXJuZWwgYnVpbGRzIGNhbgorCSAgbGV2ZXJhZ2UgdGhlc2UgdG8gZG8gbW9yZSBz
dHJpY3QgdHlwZSBjaGVja2luZyB3aXRoIG5vcm1hbAorCSAgY29tcGlsZXJzIGluc3RlYWQg
b2YgcmVzb3J0aW5nIHRvIHVzaW5nIHNwYXJzZS4KKworCSAgSWYgdW5zdXJlLCBzYXkgTiBo
ZXJlLgorCiBjb25maWcgSEFWRV9MRF9ERUFEX0NPREVfREFUQV9FTElNSU5BVElPTgogCWJv
b2wKIAloZWxwCi0tIAoyLjM0LjEKCg==

--------------N9L4FQ8octb0E0gpQ8FX8oQZ--

