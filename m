Return-Path: <linux-arch+bounces-8828-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F889BAADA
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 03:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEDB1B20A54
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 02:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA69622087;
	Mon,  4 Nov 2024 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="I0gkvfMV"
X-Original-To: linux-arch@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C35223A0;
	Mon,  4 Nov 2024 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730687692; cv=none; b=M5LHli9iHT2Yd5GIzdcJWz8YgExfnB6MEIUcYjZvbm1HA3L5xFrc7Mf3+sf1sedkLopWif/1PadgWABb4j4v64r+ektHvb1w+qm8fvcllx6Hdofhpm/PK5nAyrJe94zwiaxVjbN+8QIZbPPMGubqU1sUmKZOyIl4rZ4VYPEZPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730687692; c=relaxed/simple;
	bh=LBnwjIu01qb3uMzu5oQLZ1sXef4WJoJ8ZJ5HXkRpTng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwJT/M97aBAplMtI2f+9zjc054wEKEciVaHp516glwRhXaZKSjwyHTnD35MCTM6w/CD+Dp3SrbvzvaEVjH6yH8J+dF5NhE+GYF+0DxgLgpjtoHV/m09s/CZQimWkY5EDaJOBgovhGvKDrhdBW8UVhVEWkbYEQmBWy25bvRDa3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=I0gkvfMV; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1730687664;
	bh=LBnwjIu01qb3uMzu5oQLZ1sXef4WJoJ8ZJ5HXkRpTng=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=I0gkvfMVE/MguKNe6G+/LMNLVFqz7dkh0IDG0vDntK4CNMqCoz50Tqhzb3M0pX6yE
	 GsMB3HypNccbL/ypubSF6JPJFS7ckgk4c83b82I4kXeEhlwYuJQ9JJSgbhKj4ZgSzt
	 6AVc0wlL51Wy3m4xPQdNrps/E4wW0CWhuFCKwvFc=
X-QQ-mid: bizesmtp90t1730687661tfnba8nb
X-QQ-Originating-IP: zCt886bJnOZxcI98vSCU01cM2iwZOisAeH5BvJ3W5y4=
Received: from [10.20.6.66] ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Nov 2024 10:34:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13360692648225194716
Message-ID: <E7AED86A89FD886F+263304da-0529-4b4c-9e23-ea2e5e3cef2c@uniontech.com>
Date: Mon, 4 Nov 2024 10:34:18 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/18] loongarch/crc32: expose CRC32 functions through
 lib
To: Eric Biggers <ebiggers@kernel.org>
Cc: ardb@kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, kernel@xen0n.name, chenhuacai@kernel.org,
 xry111@xry111.site, sparclinux@vger.kernel.org, x86@kernel.org
References: <20241025191454.72616-7-ebiggers@kernel.org>
 <DA8BCDFFEACDA1C6+20241103133655.217375-1-wangyuli@uniontech.com>
 <20241103135730.GA813@quark.localdomain>
Content-Language: en-US
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <20241103135730.GA813@quark.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yPwlqMleUVPPs6iT7orBXJ4O"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NJaUjScZH2N7a7NYy0D7VCbmSeGLx0tfSNnPIdmY8W3aBXPu4v2xCqAQ
	jZipcnxD3tMymurqF0dyyArNJuyEYQSYWIhvd96iVv5dFL/JF0L3ocxMejDQn0hVXvn8rN7
	+5pU6R09CR0VbNJZj7AzjnMTMo/IIpSt3YCe2CX1NlOQkQcmwQQXkHcevimyhnxUOSQUdHL
	KDGRfqEqhYc/aJw1IzAfSUY6+9VgcX4jmo1Gr96IJQ8s7y/ilbw0j8VCZ7H2DT1Pvs/tB4e
	ekUk8RTcz7s5sFdfjcMG6/eGPUX+n2zQFjp5uI2SbotPCT9pVMPt7DLUhMl/DrXW6luFNXA
	hI/Yg1WVu9C6bo6jmuP2Bl+rfMg6u9iTgCCD73u7Tz1WB+6GnQcg8J97laTWk4WjK5qRvr/
	zJ9wwB3bobVwtQa2KnVsT3LjKTC6jhHst4XrMbQGc4u2teo1hd7/vsARb5JBJnr//+6Iki0
	mSbMqqUWgGw7OjiPI5qr3ic6l8Qd8s1X1CAZ3Ofr91x0YP65DBzyJrg8/mzanypklNphKaC
	OBLIU/VR++OOBh0kkh0EQiwP2SlOY3WNpLCxg4qFDCOJA6+9+BSvLdl8BPMt6BnDQ9Z3cIN
	uCjdtyjJdFYP5AORvjbKztvSAWebeNc6U+m305g/Z5chllfo5uHqyeLmwBI3Xidwk3HeKqw
	6bjDxcYzZ1t5Or8vxm8nR4DFuVBvQ7vF6Fbc3ntE2543J5IAazBKZs2NMOu2NYxksxUwSm9
	BCtGt6xnGG7zuK7iGq6hYvucs3rL/vzGuSygtuKAkt+6qM1On+EYGAdkkJnilb6jz0WABkD
	KlkHLhvGe3qqqgaj+vevFro+84ECKnrul3pSYpaZJVnIv9iYUvCmgfp6KHjtchYiHHxt888
	rO5O7tzHkYIvY4kJVQbKNgurE2PxFlZA+WUKTOM0CogUmlA0WyANz5cvy7VsCORR600tW8i
	vvGkSyDxDVXyqxkw9ebPRS1R2/bLzZsxXsj91/8rDh49CAjfhXSMlc4vT5WwS3Qv0MZUmLN
	mTEMn4sR+hcykQiwEx4rmOnFY6qrqI4E0zlix+1w==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yPwlqMleUVPPs6iT7orBXJ4O
Content-Type: multipart/mixed; boundary="------------cIiC60yt0DtrRFabfn26CCc3";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: ardb@kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, kernel@xen0n.name, chenhuacai@kernel.org,
 xry111@xry111.site, sparclinux@vger.kernel.org, x86@kernel.org
Message-ID: <263304da-0529-4b4c-9e23-ea2e5e3cef2c@uniontech.com>
Subject: Re: [PATCH v2 06/18] loongarch/crc32: expose CRC32 functions through
 lib
References: <20241025191454.72616-7-ebiggers@kernel.org>
 <DA8BCDFFEACDA1C6+20241103133655.217375-1-wangyuli@uniontech.com>
 <20241103135730.GA813@quark.localdomain>
In-Reply-To: <20241103135730.GA813@quark.localdomain>

--------------cIiC60yt0DtrRFabfn26CCc3
Content-Type: multipart/mixed; boundary="------------YiihG54060SCpWIarDHBVU6V"

--------------YiihG54060SCpWIarDHBVU6V
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPbiAyMDI0LzExLzMgMjE6NTcsIEVyaWMgQmlnZ2VycyB3cm90ZToNCj4gT24gU3VuLCBO
b3YgMDMsIDIwMjQgYXQgMDk6MzY6NTVQTSArMDgwMCwgV2FuZ1l1bGkgd3JvdGU6DQo+PiBF
dmVuIHRob3VnaCB0aGUgbmFycm93ZXIgQ1JDIGluc3RydWN0aW9ucyBkb2Vzbid0IHJlcXVp
cmUgR1JMRU49NjQsIHRoZXkgc3RpbGwgKmFyZW4ndCogcGFydCBvZiBMQTMyIChMb29uZ0Fy
Y2ggcmVmZXJlbmNlIG1hbnVhbCB2MS4xMCwgVm9sdW1lIDEsIFRhYmxlIDItMSkuDQo+PiBM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMGE3ZDBhOWUtYzU2ZS00ZWUyLWE4
M2ItMDAxNjRhNDUwYWJlQHhlbjBuLm5hbWUvDQo+Pg0KPj4gVGhlcmVmb3JlLCB3ZSBjb3Vs
ZCBub3QgZGlyZWN0bHkgYWRkIEFSQ0hfSEFTX0NSQzMyIHRvIGNvbmZpZyBMT09OR0FSQ0gu
DQo+Pg0KPiBUaGVyZSdzIHN0aWxsIGEgcnVudGltZSBDUFUgZmVhdHVyZSBjaGVjayBvZiBj
cHVfaGFzKENQVV9GRUFUVVJFX0NSQzMyKS4NCj4gU2VlIGFyY2gvbG9vbmdhcmNoL2xpYi9j
cmMzMi1sb29uZ2FyY2guYy4gIFNvIGl0J3MgdGhlIHNhbWUgYXMgYmVmb3JlLg0KPiBBUkNI
X0hBU19DUkMzMiBqdXN0IG1lYW5zIHRoYXQgdGhlIGZpbGUgd2lsbCBiZSBjb21waWxlZC4N
Cj4NCj4gSWYgeW91J3JlIHRyeWluZyB0byBzYXkgdGhhdCB5b3UgdGhpbmsgdGhpcyBmaWxl
IHNob3VsZCBiZSBidWlsdCBvbmx5IHdoZW4NCj4gQ09ORklHXzY0QklUPXksIHRoZW4gdGhh
dCB3b3VsZCBiZSBhbiBleGlzdGluZyBidWcgc2luY2UgdGhlIGV4aXN0aW5nIGZpbGUNCj4g
YXJjaC9sb29uZ2FyY2gvY3J5cHRvL2NyYzMyLWxvb25nYXJjaC5jIHdhcyBidWlsdCBmb3Ig
Ym90aCAzMi1iaXQgYW5kIDY0LWJpdC4NCj4gQnV0IGlmIHlvdSB0aGluayB0aGlzIGlzIGEg
YnVnLCBJIGNhbiBmaXggdGhpcyB0b28uDQo+DQo+IC0gRXJpYw0KPg0KDQpBY3R1YWxseSwg
bXkgb3JpZ2luYWxseSBtZWFuIGlzIHRoYXQgZGlyZWN0bHkgZGVjbGFyaW5nIExvb25nQXJj
aCANCkFSQ0hfSEFTX0NSQzMyIHdpdGhvdXQgZGlzdGluZ3Vpc2hpbmcgYmV0d2VlbiAzMi1i
aXQgYW5kIDY0LWJpdCBtaWdodCANCm1pc2xlYWQgdGhvc2UgcmVhZGluZyB0aGUgY29kZS4g
QW5kIGl0J3Mgbm90IHJpZ29yb3VzLg0KSG93ZXZlciwgYWNjb3JkaW5nIHRvIEh1YWNhaSBD
aGVuJ3MgcmVjZW50IHJlcGx5LCB0aGVyZSBhcmUgbWFueSBzaW1pbGFyIA0KaXNzdWVzIGFu
ZCB0aGV5IHdvbid0IGNhdXNlIGJ1aWxkIGVycm9ycyBmb3Igbm93Lg0KTGluazogDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FBaFYtSDVLYVhCci1UZHBEYkp3Y3JfTDBfbWJT
dz00SjMwdXdRMnhuMllEcz1IZzJRQG1haWwuZ21haWwuY29tLw0KU28sIHRoaXMgY2hhbmdl
IHNob3VsZCBiZSBmaW5lIGZvciBub3cuDQoNClJldmlld2VkLWJ5OiBXYW5nWXVsaSA8d2Fu
Z3l1bGlAdW5pb250ZWNoLmNvbT4NCg0KVGhhbmtzLA0KLS0gDQpXYW5nWXVsaQ0K
--------------YiihG54060SCpWIarDHBVU6V
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------YiihG54060SCpWIarDHBVU6V--

--------------cIiC60yt0DtrRFabfn26CCc3--

--------------yPwlqMleUVPPs6iT7orBXJ4O
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZygyqgUDAAAAAAAKCRDF2h8wRvQL7u9/
AQCzme1hyYUbPe1s4tK4FtfJbQ1qS/eQ5ZNWEjUnEivrLwEA0UMghFUFO/92QNK3/a3a7O8QrCGS
Ov5jILXFpAVfTgw=
=fG9N
-----END PGP SIGNATURE-----

--------------yPwlqMleUVPPs6iT7orBXJ4O--

