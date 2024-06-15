Return-Path: <linux-arch+bounces-4914-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F18C909874
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2024 15:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE7C1C211EA
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2024 13:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2083E482EB;
	Sat, 15 Jun 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="a6Ry6rT2"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622B482DD;
	Sat, 15 Jun 2024 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718457177; cv=none; b=MC/mE3TlMAfB4G0CoePKl8ttK7BpvYdcHa44rARXH7T1T8Nlt/XEmI233fu3RpkLL7MDQRAG3l7aiav8SxuSykZzXh67h3x7AB3VmuBTOkh+UVeKAWB3eYl6F7YAnrfliw1Pg4JcJbThWDlhI3YskAyDmop6WjQJeNhPyE2jTns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718457177; c=relaxed/simple;
	bh=B+byxdDHxjrZUhpBVbkIuJhaf9FOb7tIpn08cQRB8iM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmuVaFlBqGFUPgcBmBJc63JIp0PxQvMk+E8qsN+LwKKqz90G48xwxRS/beKkraaCRXMlXSrGFrhN2SvnwWJzTXROY1YyFDqygxxmZDvsGmUtmCiju2OqwN7DmuwccSw+JOxNaTIci1CpSpm8VtbTRMLWK6cIJckgjBi43uYbm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=a6Ry6rT2; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1718457173;
	bh=B+byxdDHxjrZUhpBVbkIuJhaf9FOb7tIpn08cQRB8iM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=a6Ry6rT2Apvt4esGBXHHCYGl+lmnmJFUzPirbfSunfg+oXAcQs8xwTW9f5eLcBgms
	 iYUxGB2K/y9ItZAU8fK7CrrAqYXa99c1090+H8h/Ne56B4zOPCxlQ3oEgYBTKmXpo4
	 UcvDb5qu7Rl1A9v9ohnGe9O3lzo+fvyM6ylpIcm4=
Received: from [IPv6:240e:457:1130:3532:fcd1:d9f4:2ad1:565c] (unknown [IPv6:240e:457:1130:3532:fcd1:d9f4:2ad1:565c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 4550066EDB;
	Sat, 15 Jun 2024 09:12:41 -0400 (EDT)
Message-ID: <a70e8b062fc422e351fe2369b9979a623fa05dfa.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
From: Xi Ruoyao <xry111@xry111.site>
To: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li
 <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org,  loongson-kernel@lists.loongnix.cn,
 stable@vger.kernel.org
Date: Sat, 15 Jun 2024 21:12:26 +0800
In-Reply-To: <08ff168afc09fd108ec489a3c9360d4e704fa7dc.camel@xry111.site>
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
	 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
	 <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
	 <fcdeb993-37d6-42e0-8737-3be41413f03d@app.fastmail.com>
	 <CAAhV-H4s_utEOtFDwjPTqxnMWTVjWhmS7bEVRX+t8HK5QDA8Vg@mail.gmail.com>
	 <a21a0878-021e-4990-a59d-b10f204a018b@app.fastmail.com>
	 <CAAhV-H7OR5tkbjj-BPLStneXFr=1DUaFvvh8+a5Bk_jhCAP25Q@mail.gmail.com>
	 <cdef45d36d0e71da5f0534b3783b81c82405bda3.camel@xry111.site>
	 <CAAhV-H4R_HJAB0baqUgA8ucbwWNVN4sc9EV91zAk9Ch302_7zg@mail.gmail.com>
	 <56ace686-d4b4-4b4c-a8a6-af06ec0d48f2@app.fastmail.com>
	 <08ff168afc09fd108ec489a3c9360d4e704fa7dc.camel@xry111.site>
Content-Type: multipart/mixed; boundary="=-YxhasIhtdyR/P3cgOt/8"
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-YxhasIhtdyR/P3cgOt/8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2024-06-15 at 20:12 +0800, Xi Ruoyao wrote:
> On Sat, 2024-06-15 at 13:47 +0200, Arnd Bergmann wrote:
>=20
> /* snip */
>=20
> > > > > We can only wait for the seccomp side to be fixed now? Or we can =
get
> > > > > this patch upstream for LoongArch64 at the moment, and wait for
> > > > > seccomp to fix RISCV32 (and LoongArch32) in future?
> > > >=20
> > > > I'm wondering why not just introduce a new syscall or extend statx =
with
> > > > a new flag, as we've discussed many times.=C2=A0 They have their ow=
n
> > > > disadvantages but better than this, IMO.
> > > We should move things forward, in any way. :)
> >=20
> > Wouldn't it be sufficient to move the AT_EMPTY_PATH hack
> > from vfs_fstatat() to vfs_statx() so we can make them
> > behave the same way?
> >=20
> > As far as I can tell, the only difference between the two is
> > that fstatat64() and similar already has added the check for
> > zero-length strings in order to make using vfs_fstatat()
> > fast and safe when called from glibc stat().
>=20
> Do you mean https://git.kernel.org/torvalds/c/9013c51c630a?=C2=A0 It (onl=
y
> partially) fix the performance issue but it won't help seccomp.=C2=A0 The
> problem is you cannot check if the string is zero-length with seccomp.
> Thus seccomp cannot audit fstatat properly as well.
>=20
> In [Firefox] *all* fstatat (and statx) calls are trapped and *the signal
> handler* audit this fstatat call.=C2=A0 If flags & AT_EMPTY_PATH and path=
 is
> zero-length, it calls fstat to do the job.=C2=A0 But on LoongArch there i=
s no
> way to "do the job" as the only stat-family call is statx.
>=20
> [Firefox]:https://searchfox.org/mozilla-central/source/security/sandbox/l=
inux/SandboxFilter.cpp#364

Just spent some brain cycles to make a quick hack adding a new statx
flag.  Patch attached.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

--=-YxhasIhtdyR/P3cgOt/8
Content-Disposition: attachment; filename="0001-RFC-vfs-Add-AT_FORCE_EMPTY_PATH.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-RFC-vfs-Add-AT_FORCE_EMPTY_PATH.patch";
	charset="UTF-8"

RnJvbSAxNmQwMmExYzQ0ZTVlZWQyZWYyYTJjYzMyMjBkMGE3NGIzNWRmODIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBYaSBSdW95YW8gPHhyeTExMUB4cnkxMTEuc2l0ZT4KRGF0ZTog
U2F0LCAxNSBKdW4gMjAyNCAyMDo0NDowNCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIFJGQzogdmZz
OiBBZGQgQVRfRk9SQ0VfRU1QVFlfUEFUSAoKSXQgYmVoYXZlcyBhcyBpZiBBVF9FTVBUWV9QQVRI
IHdpdGggYW4gZW1wdHkgcGF0aCAodGhlIGlucHV0IHBhdGggd2lsbApiZSBpZ25vcmVkKS4KCkl0
J3MgYmV0dGVyIHRoYW4gQVRfRU1QVFlfUEFUSCBmb3IgaW1wbGVtZW50aW5nIGZzdGF0IHdpdGgg
c3RhdHggKGl0J3MKbmVlZGVkIGFmdGVyIDIwMzcgZm9yIDMyLWJpdCBzeXN0ZW1zKSBiZWNhdXNl
IHRoZXJlJ3Mgbm8gbmVlZCB0byBjb3B5CmZyb20gdXNlciwgYW5kIGl0J3MgYXVkaXRhYmxlIGJ5
IHNlY2NvbXAgKHRob3VnaCBwZXJzb25hbGx5IEknbSByZWFsbHkKbm90IGEgZmFuIGlmIHNlY2Nv
bXApLgoKU2lnbmVkLW9mZi1ieTogWGkgUnVveWFvIDx4cnkxMTFAeHJ5MTExLnNpdGU+Ci0tLQog
ZnMvbmFtZWkuYyAgICAgICAgICAgICAgICAgfCA4ICsrKysrKystCiBmcy9zdGF0LmMgICAgICAg
ICAgICAgICAgICB8IDQgKysrLQogaW5jbHVkZS9saW51eC9uYW1laS5oICAgICAgfCA0ICsrKysK
IGluY2x1ZGUvdHJhY2UvbWlzYy9mcy5oICAgIHwgMSArCiBpbmNsdWRlL3VhcGkvbGludXgvZmNu
dGwuaCB8IDMgKysrCiA1IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbmFtZWkuYyBiL2ZzL25hbWVpLmMKaW5kZXggMzdmYjBh
OGFhMDlhLi4yZjAxMmVjOGYwNzIgMTAwNjQ0Ci0tLSBhL2ZzL25hbWVpLmMKKysrIGIvZnMvbmFt
ZWkuYwpAQCAtMTQ3LDcgKzE0NywxMyBAQCBnZXRuYW1lX2ZsYWdzKGNvbnN0IGNoYXIgX191c2Vy
ICpmaWxlbmFtZSwgaW50IGZsYWdzLCBpbnQgKmVtcHR5KQogCWtuYW1lID0gKGNoYXIgKilyZXN1
bHQtPmluYW1lOwogCXJlc3VsdC0+bmFtZSA9IGtuYW1lOwogCi0JbGVuID0gc3RybmNweV9mcm9t
X3VzZXIoa25hbWUsIGZpbGVuYW1lLCBFTUJFRERFRF9OQU1FX01BWCk7CisJaWYgKCEoZmxhZ3Mg
JiBMT09LVVBfRk9SQ0VfRU1QVFkpKQorCQlsZW4gPSBzdHJuY3B5X2Zyb21fdXNlcihrbmFtZSwg
ZmlsZW5hbWUsIEVNQkVEREVEX05BTUVfTUFYKTsKKwllbHNlIHsKKwkJbGVuID0gMDsKKwkJa25h
bWVbMF0gPSAnXDAnOworCX0KKwogCWlmICh1bmxpa2VseShsZW4gPCAwKSkgewogCQlfX3B1dG5h
bWUocmVzdWx0KTsKIAkJcmV0dXJuIEVSUl9QVFIobGVuKTsKZGlmZiAtLWdpdCBhL2ZzL3N0YXQu
YyBiL2ZzL3N0YXQuYwppbmRleCA3MGJkM2U4ODhjZmEuLmJlODFmYzEyYmQzYSAxMDA2NDQKLS0t
IGEvZnMvc3RhdC5jCisrKyBiL2ZzL3N0YXQuYwpAQCAtMjEwLDYgKzIxMCw4IEBAIGludCBnZXRu
YW1lX3N0YXR4X2xvb2t1cF9mbGFncyhpbnQgZmxhZ3MpCiAJCWxvb2t1cF9mbGFncyB8PSBMT09L
VVBfQVVUT01PVU5UOwogCWlmIChmbGFncyAmIEFUX0VNUFRZX1BBVEgpCiAJCWxvb2t1cF9mbGFn
cyB8PSBMT09LVVBfRU1QVFk7CisJaWYgKGZsYWdzICYgQVRfRk9SQ0VfRU1QVFlfUEFUSCkKKwkJ
bG9va3VwX2ZsYWdzIHw9IExPT0tVUF9FTVBUWSB8IExPT0tVUF9GT1JDRV9FTVBUWTsKIAogCXJl
dHVybiBsb29rdXBfZmxhZ3M7CiB9CkBAIC0yMzcsNyArMjM5LDcgQEAgc3RhdGljIGludCB2ZnNf
c3RhdHgoaW50IGRmZCwgc3RydWN0IGZpbGVuYW1lICpmaWxlbmFtZSwgaW50IGZsYWdzLAogCWlu
dCBlcnJvcjsKIAogCWlmIChmbGFncyAmIH4oQVRfU1lNTElOS19OT0ZPTExPVyB8IEFUX05PX0FV
VE9NT1VOVCB8IEFUX0VNUFRZX1BBVEggfAotCQkgICAgICBBVF9TVEFUWF9TWU5DX1RZUEUpKQor
CQkgICAgICBBVF9TVEFUWF9TWU5DX1RZUEUgfCBBVF9GT1JDRV9FTVBUWV9QQVRIKSkKIAkJcmV0
dXJuIC1FSU5WQUw7CiAKIHJldHJ5OgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9uYW1laS5o
IGIvaW5jbHVkZS9saW51eC9uYW1laS5oCmluZGV4IDk2N2FhOWVhOWY5Ni4uZDE5ZTUxNjYxMDFi
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L25hbWVpLmgKKysrIGIvaW5jbHVkZS9saW51eC9u
YW1laS5oCkBAIC00NSw5ICs0NSwxMyBAQCBlbnVtIHtMQVNUX05PUk0sIExBU1RfUk9PVCwgTEFT
VF9ET1QsIExBU1RfRE9URE9UfTsKICNkZWZpbmUgTE9PS1VQX0lOX1JPT1QJCTB4MTAwMDAwIC8q
IFRyZWF0IGRpcmZkIGFzIGZzIHJvb3QuICovCiAjZGVmaW5lIExPT0tVUF9DQUNIRUQJCTB4MjAw
MDAwIC8qIE9ubHkgZG8gY2FjaGVkIGxvb2t1cCAqLwogI2RlZmluZSBMT09LVVBfTElOS0FUX0VN
UFRZCTB4NDAwMDAwIC8qIExpbmthdCByZXF1ZXN0IHdpdGggZW1wdHkgcGF0aC4gKi8KKwogLyog
TE9PS1VQXyogZmxhZ3Mgd2hpY2ggZG8gc2NvcGUtcmVsYXRlZCBjaGVja3MgYmFzZWQgb24gdGhl
IGRpcmZkLiAqLwogI2RlZmluZSBMT09LVVBfSVNfU0NPUEVEIChMT09LVVBfQkVORUFUSCB8IExP
T0tVUF9JTl9ST09UKQogCisvKiBJZiB0aGlzIGlzIHNldCwgTE9PS1VQX0VNUFRZIG11c3QgYmUg
c2V0IGFzIHdlbGwuICovCisjZGVmaW5lIExPT0tVUF9GT1JDRV9FTVBUWQkweDgwMDAwMCAvKiBD
b25zaWRlciBwYXRoIGVtcHR5LiAqLworCiBleHRlcm4gaW50IHBhdGhfcHRzKHN0cnVjdCBwYXRo
ICpwYXRoKTsKIAogZXh0ZXJuIGludCB1c2VyX3BhdGhfYXRfZW1wdHkoaW50LCBjb25zdCBjaGFy
IF9fdXNlciAqLCB1bnNpZ25lZCwgc3RydWN0IHBhdGggKiwgaW50ICplbXB0eSk7CmRpZmYgLS1n
aXQgYS9pbmNsdWRlL3RyYWNlL21pc2MvZnMuaCBiL2luY2x1ZGUvdHJhY2UvbWlzYy9mcy5oCmlu
ZGV4IDczOGI5N2YyMmYzNi4uNDY0ODk0MjZmMThhIDEwMDY0NAotLS0gYS9pbmNsdWRlL3RyYWNl
L21pc2MvZnMuaAorKysgYi9pbmNsdWRlL3RyYWNlL21pc2MvZnMuaApAQCAtMTE5LDQgKzExOSw1
IEBACiAJCXsgTE9PS1VQX05PX1hERVYsCSJOT19YREVWIiB9LCBcCiAJCXsgTE9PS1VQX0JFTkVB
VEgsCSJCRU5FQVRIIiB9LCBcCiAJCXsgTE9PS1VQX0lOX1JPT1QsCSJJTl9ST09UIiB9LCBcCisJ
CXsgTE9PS1VQX0ZPUkNFX0VNUFRZLAkiRk9SQ0VfRU1QVFkiIH0sIFwKIAkJeyBMT09LVVBfQ0FD
SEVELAkiQ0FDSEVEIiB9KQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2ZjbnRsLmgg
Yi9pbmNsdWRlL3VhcGkvbGludXgvZmNudGwuaAppbmRleCBjMGJjYzE4NWZhNDguLjcxZDNkYzky
Yzg2ZSAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2ZjbnRsLmgKKysrIGIvaW5jbHVk
ZS91YXBpL2xpbnV4L2ZjbnRsLmgKQEAgLTExMyw2ICsxMTMsOSBAQAogI2RlZmluZSBBVF9TVEFU
WF9ET05UX1NZTkMJMHg0MDAwCS8qIC0gRG9uJ3Qgc3luYyBhdHRyaWJ1dGVzIHdpdGggdGhlIHNl
cnZlciAqLwogCiAjZGVmaW5lIEFUX1JFQ1VSU0lWRQkJMHg4MDAwCS8qIEFwcGx5IHRvIHRoZSBl
bnRpcmUgc3VidHJlZSAqLworI2RlZmluZSBBVF9GT1JDRV9FTVBUWV9QQVRICTB4MTAwMDAJLyog
SWdub3JlIHBhdGggYW5kIGJlaGF2ZSBhcyBpZgorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEFUX0VNUFRZX1BBVEggaXMgc2V0IGFuZCBwYXRoCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXMgZW1wdHkgKi8KIAogLyogRmxhZ3Mg
Zm9yIG5hbWVfdG9faGFuZGxlX2F0KDIpLiBXZSByZXVzZSBBVF8gZmxhZyBzcGFjZSB0byBzYXZl
IGJpdHMuLi4gKi8KICNkZWZpbmUgQVRfSEFORExFX0ZJRAkJQVRfUkVNT1ZFRElSCS8qIGZpbGUg
aGFuZGxlIGlzIG5lZWRlZCB0bwotLSAKMi40NS4yCgo=


--=-YxhasIhtdyR/P3cgOt/8--

