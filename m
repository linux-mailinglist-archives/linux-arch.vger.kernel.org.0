Return-Path: <linux-arch+bounces-4724-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822C48FDC99
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 04:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9191C21FB7
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 02:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384C03D9E;
	Thu,  6 Jun 2024 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M4p+POTb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DE64C97
	for <linux-arch@vger.kernel.org>; Thu,  6 Jun 2024 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640076; cv=none; b=NTv6NmbzhJ8P5WUeRQMh5EdQSajX1O9ovjYPtxOVGEhVCsQFJJDgD5MVRyejEVeuD733z+dTznDgRgxuvaqD9T78LBdYf6c1uqNTSKfUML5GpoVrqzvQysJgixbc+gSLpE8So+AUBuO6/3Q2RYttE0f076ds6xnrxD2CZQinoP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640076; c=relaxed/simple;
	bh=jJ1X2rrBj+Wtlt7/H9XLEC0aysxB1IX2gyQrFx5+n8g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bownRfkl298qVs47ZhtuPGpd40Xtyj6787/Ajn7ImJQdeJ73i8sEA82MPjkM4UxGbqmnt4FIJqdppHvPMUhfIJmwLa+6fD6+zss1ePRpk7canaKp6C5mDBMw9sKsQ8RGG52jietQajIOVuyyxjRT38lJFkiYgYGVWCKjkeZQ88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M4p+POTb; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48bcfe2b414so125386137.3
        for <linux-arch@vger.kernel.org>; Wed, 05 Jun 2024 19:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717640073; x=1718244873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bCjmJemJaC/r3A5yP/YUZm9N50FkxLYExZk7WySE00s=;
        b=M4p+POTbvJjIZO7v2GVsjqvZVqoTRWbiAmdFqCGymIw5JPyUw9V7k3SOTGj7ALYcf7
         qQg7S1CFjBYBpbEWsRpKT6XR5n3iwi7N6T/5Ormz7dwLcS/8BaGpQCzdLPVBN1TQPUp/
         ++Qvq0Tr2yaV/rbEAWtrljyPoJj8NdSAhD3a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717640073; x=1718244873;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCjmJemJaC/r3A5yP/YUZm9N50FkxLYExZk7WySE00s=;
        b=YcRmenrpCx69HORcKa7x07zoGpn8joRfNgX07d3JgKEqliJYsDt68xUA4me1iMkwZD
         V/fOaGW7xp+87/nLbSm8uM1lIMRvqcn1vDr8yxqCxL48qH7pOzsNXnLxG776D62ul977
         iErbjUJAhO9EsWBJVPiSRDQ9YIiIFkV3j4oeSzccqVbS0sCPGW8DcZgtDAqEByqJaJE3
         ICc8b5bDsIZ75KIGXuERsKPTNGZxXX5kyd/rad5hx5p4Pjz3MfO6BuHIKw9KJkixZxAU
         35f6iR41/TKUnuko2YqOCo6UnXMEGa0njLxSLG66FoNWROQ9MbTwCw7Oeeg5SusUcjGs
         sLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1YgI3CoO4CTtfE/l2wLd3r3aGE21Q0mkCKGWYxIn21OcvnAE1SDf8znmNkXXbosWrmp3c06gfvjxte693vQgjYJxCTEo1SmONCQ==
X-Gm-Message-State: AOJu0YzfkVqsbO103HKpjYyMYrND0qoM1gBxRewSwsXQtK4GViMjOdIq
	9/QtoCDwSa9bGjEx8DKtO29bZxzZxZ0FGSedyeoF53WB4PSNfu+noDyQ2ybf8Ekpe1e0VQbcBYf
	Yrx0=
X-Google-Smtp-Source: AGHT+IG47YiTpmNQtHw5Bpc3LeU8mujxBBF2T/vckqeN6ui5NQrbKVNifeJ4lMIS2Hxptkq4c8eVdQ==
X-Received: by 2002:a05:6102:2ac3:b0:48b:aa77:795b with SMTP id ada2fe7eead31-48c04aab940mr5744062137.23.1717640072615;
        Wed, 05 Jun 2024 19:14:32 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-80b5eb494e3sm60972241.30.2024.06.05.19.14.31
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 19:14:31 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4eb076bec24so194137e0c.1
        for <linux-arch@vger.kernel.org>; Wed, 05 Jun 2024 19:14:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxR9CypXDycKQN/LCNAOVbaPSVH7AkoIkfu8dlifVpbJSk/uI2iTloeoBwxkRMgFEYMQSDQY6oHalf9ewoZeSNSdyU2j9Iib2pQA==
X-Received: by 2002:a05:6102:2173:b0:48b:ad47:b0e5 with SMTP id
 ada2fe7eead31-48c048f6cfdmr4235750137.11.1717640071226; Wed, 05 Jun 2024
 19:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Jun 2024 19:14:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFSz=usMPHHGAQBnJRVAFfuH4gFHtgyLe0YET75zYRzA@mail.gmail.com>
Message-ID: <CAHk-=whFSz=usMPHHGAQBnJRVAFfuH4gFHtgyLe0YET75zYRzA@mail.gmail.com>
Subject: Horrendous "runtime constant" hack - current patch x86-64 only
To: Peter Anvin <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: "the arch/x86 maintainers" <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000004c664e061a2f3e15"

--0000000000004c664e061a2f3e15
Content-Type: text/plain; charset="UTF-8"

Ok, this attached patch is so absolutely disgusting that it is almost
a work of art.

I spent some time last week doing arm64 profiles, and on the loads I
tested, I saw my old enemy __d_lookup_rcu(). The hash table lookup
ends up being expensive. Not a huge surprise.

That said, the expense of the hash table lookup is only partially the
memory accesses of the hashtable itself.  A noticeable part of the
cost is in looking up the address of the hash table.

That annoys me. It has annoyed me before. It's a "runtime constant".
In fact, it's two runtime constants: the address of the hash table,
and the shift count that turns the dentry name hash into the index
into the hash table (approximates a mask).

It's disgusting having the profile point to the "load constant from memory".

Peter Anvin at some point had some rather complex patch to do
"constant alternatives". I couldn't find it, but I didn't search very
hard because I remembered it being pretty significant in size, and I
went "how hard can it be".

Now, I did the profiling on arm64, but then when it came to rewriting
instructions I went back to x86-64 just because while I'm trying to
get better at reading arm64 asm, I don't want to deal with the pain of
huge constants (and a very slow boot for testing).

I'm posting this disgusting patch here because I need to take a break
from this insanity, and maybe somebody else is interested.

And yes, this needs to be behind some "CONFIG_RUNTIME_CONSTANTS"
config variable, with fallback to the same old code.

And yes, that static_shift_right_32() thing is odd. It takes and
returns an 'unsigned long', but then operates on the low 32 bits of
it, and clears the upper 32 bits (on 64-bit architectures). That's
purely because this is what x86-64 code generation wants to turn that
whole op into just a single instruction.

The static_const_init() sizes are also hardcoded, "knowing" what the layout is.

So this is all just a truly disgusting tech demo, but it generates
very pretty code in d_lookup_rcu().

Tested in the sense that it works for me in one particular
configuration using clang. The code from gcc looks fine to me too, but
that's from just quick "let's check".

Actually extending this to arm64 (and possibly other architectures)
would need some more cleanups and abstracting this all more. I didn't
look if other core kernel code might want to use this, I was literally
just concentrating on making __d_lookup_rcu() look pretty (and you
need to get rid of debug build options for it to do that)

               Linus

--0000000000004c664e061a2f3e15
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-x86-start-on-static_const-infrastructure.patch"
Content-Disposition: attachment; 
	filename="0001-x86-start-on-static_const-infrastructure.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lx2mgydf0>
X-Attachment-Id: f_lx2mgydf0

RnJvbSA3ZTkwZmRlZTZkYmEwNjc5YjlhOTAxMGJhZGJlYmU1ODUwZDNlMmYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgNCBKdW4gMjAyNCAxMjozMDowMiAtMDcwMApTdWJqZWN0OiBb
UEFUQ0hdIHg4Njogc3RhcnQgb24gJ3N0YXRpY19jb25zdCcgaW5mcmFzdHJ1Y3R1cmUKClRoaXMg
aXMgdmVyeSBoYWNreSBpbmRlZWQKLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zdGF0aWNfY29u
c3QuaCB8IDMyICsrKysrKysrKysrKysrKysrCiBmcy9kY2FjaGUuYyAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tCiBpbmNsdWRlL2FzbS1n
ZW5lcmljL3ZtbGludXgubGRzLmggICB8IDEzICsrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgOTMg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3g4
Ni9pbmNsdWRlL2FzbS9zdGF0aWNfY29uc3QuaAoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3N0YXRpY19jb25zdC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vc3RhdGljX2NvbnN0
LmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi45YjE1NjBmMzI5NTUK
LS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zdGF0aWNfY29uc3QuaApA
QCAtMCwwICsxLDMyIEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLwor
I2lmbmRlZiBfQVNNX1NUQVRJQ19DT05TVF9ICisjZGVmaW5lIF9BU01fU1RBVElDX0NPTlNUX0gK
KworI2RlZmluZSBzdGF0aWNfbG9uZyhzeW0pICh7CQkJCQlcCisJbG9uZyBfX3JldDsJCQkJCQlc
CisJYXNtKCJtb3ZxICUxLCUwXG4xOlxuIgkJCQkJXAorCQkiLnB1c2hzZWN0aW9uIC5zdGF0aWNf
Y29uc3Quc3olYzIsXCJhXCJcblx0IglcCisJCSIubG9uZyAxYiAtICVjMiAtIC5cblx0IgkJCVwK
KwkJIi5sb25nICgiICNzeW0gIikgLSAuXG4iCQkJXAorCQkiLnBvcHNlY3Rpb24iCQkJCQlcCisJ
CToiPXIiIChfX3JldCkJCQkJCVwKKwkJOiJpIiAoKHVuc2lnbmVkIGxvbmcpMHgwMTIzNDU2Nzg5
YWJjZGVmdWxsKSwJXAorCQkgImkiIChzaXplb2YobG9uZykpKTsJCQkJXAorCV9fcmV0OyB9KQor
CisjZGVmaW5lIHN0YXRpY19wdHIoeCkgKCh0eXBlb2YoeCkpc3RhdGljX2xvbmcoeCkpCisKKy8v
IFRoZSAndHlwZW9mJyB3aWxsIGNyZWF0ZSBhdCBfbGVhc3RfIGEgMzItYml0IHR5cGUsIGJ1dAor
Ly8gd2lsbCBoYXBwaWx5IGFsc28gdGFrZSBhIGJpZ2dlciB0eXBlIGFuZCB0aGUgJ3NocmwnIHdp
bGwKKy8vIGNsZWFyIHRoZSB1cHBlciBiaXRzCisjZGVmaW5lIHN0YXRpY19zaGlmdF9yaWdodF8z
Mih2YWwsIHN5bSkgKHsJCQlcCisJdHlwZW9mKDB1Kyh2YWwpKSBfX3JldCA9ICh2YWwpOwkJCQlc
CisJYXNtKCJzaHJsICQxMiwlazBcbjE6XG4iCQkJCVwKKwkJIi5wdXNoc2VjdGlvbiAuc3RhdGlj
X2NvbnN0LnN6MSxcImFcIiBcblx0IglcCisJCSIubG9uZyAxYiAtIDEgLSAuXG5cdCIJCQkJXAor
CQkiLmxvbmcgKCIgI3N5bSAiKSAtIC5cbiIJCQlcCisJCSIucG9wc2VjdGlvbiIJCQkJCVwKKwkJ
OiIrciIgKF9fcmV0KSk7CQkJCQlcCisJX19yZXQ7IH0pCisKKyNlbmRpZgpkaWZmIC0tZ2l0IGEv
ZnMvZGNhY2hlLmMgYi9mcy9kY2FjaGUuYwppbmRleCA0MDcwOTUxODhmODMuLmI5NjBiODNkZmE4
YSAxMDA2NDQKLS0tIGEvZnMvZGNhY2hlLmMKKysrIGIvZnMvZGNhY2hlLmMKQEAgLTEwMCw5ICsx
MDAsMTIgQEAgc3RhdGljIHVuc2lnbmVkIGludCBkX2hhc2hfc2hpZnQgX19yb19hZnRlcl9pbml0
OwogCiBzdGF0aWMgc3RydWN0IGhsaXN0X2JsX2hlYWQgKmRlbnRyeV9oYXNodGFibGUgX19yb19h
ZnRlcl9pbml0OwogCi1zdGF0aWMgaW5saW5lIHN0cnVjdCBobGlzdF9ibF9oZWFkICpkX2hhc2go
dW5zaWduZWQgaW50IGhhc2gpCisjaW5jbHVkZSA8YXNtL3N0YXRpY19jb25zdC5oPgorCitzdGF0
aWMgaW5saW5lIHN0cnVjdCBobGlzdF9ibF9oZWFkICpkX2hhc2godW5zaWduZWQgbG9uZyBoYXNo
bGVuKQogewotCXJldHVybiBkZW50cnlfaGFzaHRhYmxlICsgKGhhc2ggPj4gZF9oYXNoX3NoaWZ0
KTsKKwlyZXR1cm4gc3RhdGljX3B0cihkZW50cnlfaGFzaHRhYmxlKSArCisJCXN0YXRpY19zaGlm
dF9yaWdodF8zMihoYXNobGVuLCBkX2hhc2hfc2hpZnQpOwogfQogCiAjZGVmaW5lIElOX0xPT0tV
UF9TSElGVCAxMApAQCAtNDk1LDcgKzQ5OCw3IEBAIHN0YXRpYyB2b2lkIF9fX2RfZHJvcChzdHJ1
Y3QgZGVudHJ5ICpkZW50cnkpCiAJaWYgKHVubGlrZWx5KElTX1JPT1QoZGVudHJ5KSkpCiAJCWIg
PSAmZGVudHJ5LT5kX3NiLT5zX3Jvb3RzOwogCWVsc2UKLQkJYiA9IGRfaGFzaChkZW50cnktPmRf
bmFtZS5oYXNoKTsKKwkJYiA9IGRfaGFzaChkZW50cnktPmRfbmFtZS5oYXNoX2xlbik7CiAKIAlo
bGlzdF9ibF9sb2NrKGIpOwogCV9faGxpc3RfYmxfZGVsKCZkZW50cnktPmRfaGFzaCk7CkBAIC0y
MTA0LDcgKzIxMDcsNyBAQCBzdGF0aWMgbm9pbmxpbmUgc3RydWN0IGRlbnRyeSAqX19kX2xvb2t1
cF9yY3Vfb3BfY29tcGFyZSgKIAl1bnNpZ25lZCAqc2VxcCkKIHsKIAl1NjQgaGFzaGxlbiA9IG5h
bWUtPmhhc2hfbGVuOwotCXN0cnVjdCBobGlzdF9ibF9oZWFkICpiID0gZF9oYXNoKGhhc2hsZW5f
aGFzaChoYXNobGVuKSk7CisJc3RydWN0IGhsaXN0X2JsX2hlYWQgKmIgPSBkX2hhc2goaGFzaGxl
bik7CiAJc3RydWN0IGhsaXN0X2JsX25vZGUgKm5vZGU7CiAJc3RydWN0IGRlbnRyeSAqZGVudHJ5
OwogCkBAIC0yMTcxLDcgKzIxNzQsNyBAQCBzdHJ1Y3QgZGVudHJ5ICpfX2RfbG9va3VwX3JjdShj
b25zdCBzdHJ1Y3QgZGVudHJ5ICpwYXJlbnQsCiB7CiAJdTY0IGhhc2hsZW4gPSBuYW1lLT5oYXNo
X2xlbjsKIAljb25zdCB1bnNpZ25lZCBjaGFyICpzdHIgPSBuYW1lLT5uYW1lOwotCXN0cnVjdCBo
bGlzdF9ibF9oZWFkICpiID0gZF9oYXNoKGhhc2hsZW5faGFzaChoYXNobGVuKSk7CisJc3RydWN0
IGhsaXN0X2JsX2hlYWQgKmIgPSBkX2hhc2goaGFzaGxlbik7CiAJc3RydWN0IGhsaXN0X2JsX25v
ZGUgKm5vZGU7CiAJc3RydWN0IGRlbnRyeSAqZGVudHJ5OwogCkBAIC0yMjc3LDcgKzIyODAsNyBA
QCBFWFBPUlRfU1lNQk9MKGRfbG9va3VwKTsKIHN0cnVjdCBkZW50cnkgKl9fZF9sb29rdXAoY29u
c3Qgc3RydWN0IGRlbnRyeSAqcGFyZW50LCBjb25zdCBzdHJ1Y3QgcXN0ciAqbmFtZSkKIHsKIAl1
bnNpZ25lZCBpbnQgaGFzaCA9IG5hbWUtPmhhc2g7Ci0Jc3RydWN0IGhsaXN0X2JsX2hlYWQgKmIg
PSBkX2hhc2goaGFzaCk7CisJc3RydWN0IGhsaXN0X2JsX2hlYWQgKmIgPSBkX2hhc2gobmFtZS0+
aGFzaF9sZW4pOwogCXN0cnVjdCBobGlzdF9ibF9ub2RlICpub2RlOwogCXN0cnVjdCBkZW50cnkg
KmZvdW5kID0gTlVMTDsKIAlzdHJ1Y3QgZGVudHJ5ICpkZW50cnk7CkBAIC0yMzk3LDcgKzI0MDAs
NyBAQCBFWFBPUlRfU1lNQk9MKGRfZGVsZXRlKTsKIAogc3RhdGljIHZvaWQgX19kX3JlaGFzaChz
dHJ1Y3QgZGVudHJ5ICplbnRyeSkKIHsKLQlzdHJ1Y3QgaGxpc3RfYmxfaGVhZCAqYiA9IGRfaGFz
aChlbnRyeS0+ZF9uYW1lLmhhc2gpOworCXN0cnVjdCBobGlzdF9ibF9oZWFkICpiID0gZF9oYXNo
KGVudHJ5LT5kX25hbWUuaGFzaF9sZW4pOwogCiAJaGxpc3RfYmxfbG9jayhiKTsKIAlobGlzdF9i
bF9hZGRfaGVhZF9yY3UoJmVudHJ5LT5kX2hhc2gsIGIpOwpAQCAtMzExMCw2ICszMTEzLDM4IEBA
IHN0YXRpYyBpbnQgX19pbml0IHNldF9kaGFzaF9lbnRyaWVzKGNoYXIgKnN0cikKIH0KIF9fc2V0
dXAoImRoYXNoX2VudHJpZXM9Iiwgc2V0X2RoYXNoX2VudHJpZXMpOwogCisjZGVmaW5lIHN0YXRp
Y19jb25zdF9pbml0KHN6LCBzeW1ib2wpIFwKKwlzdGF0aWNfY29uc3RfaW5pdF92YWx1ZShzeiwg
JnN5bWJvbCwgKHVuc2lnbmVkIGxvbmcpKHN5bWJvbCkpCisKKyNkZWZpbmUgc3RhdGljX2NvbnN0
X2luaXRfdmFsdWUoc3osIGFkZHIsIHZhbCkgZG8gewlcCisJZXh0ZXJuIHMzMiBfX3N0YXRpY19j
b25zdF9zeiMjc3o7CQlcCisJZXh0ZXJuIHMzMiBfX3N0YXRpY19jb25zdF9lbmRfc3ojI3N6OwkJ
XAorCXN0YXRpY19jb25zdF9maXh1cChzeiwgYWRkciwgdmFsLCAJCVwKKwkJJl9fc3RhdGljX2Nv
bnN0X3N6IyNzeiwJCQlcCisJCSZfX3N0YXRpY19jb25zdF9lbmRfc3ojI3N6KTsJCVwKK30gd2hp
bGUgKDApCisKKyNpbmNsdWRlIDxhc20vdGV4dC1wYXRjaGluZy5oPgorCitzdGF0aWMgdm9pZCBz
dGF0aWNfY29uc3RfZml4dXAodW5zaWduZWQgc2l6ZSwKKwl2b2lkICphZGRyLCB1bnNpZ25lZCBs
b25nIHZhbCwKKwlzMzIgKnN0YXJ0LCBzMzIgKmVuZCkKK3sKKwl3aGlsZSAoc3RhcnQgPCBlbmQp
IHsKKwkJdW5zaWduZWQgbG9uZyB3aGVyZSwgc3ltOworCisJCXdoZXJlID0gc3RhcnRbMF0gKyAo
dW5zaWduZWQgbG9uZykoc3RhcnQrMCk7CisJCXN5bSA9IHN0YXJ0WzFdICsgKHVuc2lnbmVkIGxv
bmcpKHN0YXJ0KzEpOworCQlzdGFydCArPSAyOworCisJCWlmIChzeW0gIT0gKHVuc2lnbmVkIGxv
bmcpYWRkcikKKwkJCWNvbnRpbnVlOworCisJCS8vIEhBQ0sgSEFDSyBIQUNLLiBUaGlzIGlzIGxp
dHRsZS1lbmRpYW4gb25seQorCQl0ZXh0X3Bva2VfZWFybHkoKHZvaWQgKil3aGVyZSwgJnZhbCwg
c2l6ZSk7CisJfQorfQorCiBzdGF0aWMgdm9pZCBfX2luaXQgZGNhY2hlX2luaXRfZWFybHkodm9p
ZCkKIHsKIAkvKiBJZiBoYXNoZXMgYXJlIGRpc3RyaWJ1dGVkIGFjcm9zcyBOVU1BIG5vZGVzLCBk
ZWZlcgpAQCAtMzEyOSw2ICszMTY0LDkgQEAgc3RhdGljIHZvaWQgX19pbml0IGRjYWNoZV9pbml0
X2Vhcmx5KHZvaWQpCiAJCQkJCTAsCiAJCQkJCTApOwogCWRfaGFzaF9zaGlmdCA9IDMyIC0gZF9o
YXNoX3NoaWZ0OworCisJc3RhdGljX2NvbnN0X2luaXQoMSwgZF9oYXNoX3NoaWZ0KTsKKwlzdGF0
aWNfY29uc3RfaW5pdCg4LCBkZW50cnlfaGFzaHRhYmxlKTsKIH0KIAogc3RhdGljIHZvaWQgX19p
bml0IGRjYWNoZV9pbml0KHZvaWQpCkBAIC0zMTU3LDYgKzMxOTUsOSBAQCBzdGF0aWMgdm9pZCBf
X2luaXQgZGNhY2hlX2luaXQodm9pZCkKIAkJCQkJMCwKIAkJCQkJMCk7CiAJZF9oYXNoX3NoaWZ0
ID0gMzIgLSBkX2hhc2hfc2hpZnQ7CisKKwlzdGF0aWNfY29uc3RfaW5pdCgxLCBkX2hhc2hfc2hp
ZnQpOworCXN0YXRpY19jb25zdF9pbml0KDgsIGRlbnRyeV9oYXNodGFibGUpOwogfQogCiAvKiBT
TEFCIGNhY2hlIGZvciBfX2dldG5hbWUoKSBjb25zdW1lcnMgKi8KZGlmZiAtLWdpdCBhL2luY2x1
ZGUvYXNtLWdlbmVyaWMvdm1saW51eC5sZHMuaCBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvdm1saW51
eC5sZHMuaAppbmRleCA1NzAzNTI2ZDZlYmYuLjMxYzE2N2I0MjUyZCAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9hc20tZ2VuZXJpYy92bWxpbnV4Lmxkcy5oCisrKyBiL2luY2x1ZGUvYXNtLWdlbmVyaWMv
dm1saW51eC5sZHMuaApAQCAtOTQ0LDYgKzk0NCwxOCBAQAogI2RlZmluZSBDT05fSU5JVENBTEwJ
CQkJCQkJXAogCUJPVU5ERURfU0VDVElPTl9QT1NUX0xBQkVMKC5jb25faW5pdGNhbGwuaW5pdCwg
X19jb25faW5pdGNhbGwsIF9zdGFydCwgX2VuZCkKIAorI2RlZmluZSBTVEFUSUNfQ09OU1RfU0la
RShzKQkJCQkJCVwKKwlfX3N0YXRpY19jb25zdF9zeiMjcyA9IC47CQkJCQlcCisJS0VFUCgqKC5z
dGF0aWNfY29uc3Quc3ojI3MpKQkJCQkJXAorCV9fc3RhdGljX2NvbnN0X2VuZF9zeiMjcyA9IC47
CisKKyNkZWZpbmUgU1RBVElDX0NPTlNUUwkJCQkJCQlcCisJLiA9IEFMSUdOKDgpOwkJCQkJCQlc
CisJU1RBVElDX0NPTlNUX1NJWkUoMSkJCQkJCQlcCisJU1RBVElDX0NPTlNUX1NJWkUoMikJCQkJ
CQlcCisJU1RBVElDX0NPTlNUX1NJWkUoNCkJCQkJCQlcCisJU1RBVElDX0NPTlNUX1NJWkUoOCkK
KwogLyogQWxpZ25tZW50IG11c3QgYmUgY29uc2lzdGVudCB3aXRoIChrdW5pdF9zdWl0ZSAqKSBp
biBpbmNsdWRlL2t1bml0L3Rlc3QuaCAqLwogI2RlZmluZSBLVU5JVF9UQUJMRSgpCQkJCQkJCVwK
IAkJLiA9IEFMSUdOKDgpOwkJCQkJCVwKQEAgLTExNjAsNiArMTE3Miw3IEBACiAJLmluaXQuZGF0
YSA6IEFUKEFERFIoLmluaXQuZGF0YSkgLSBMT0FEX09GRlNFVCkgewkJXAogCQlJTklUX0RBVEEJ
CQkJCQlcCiAJCUlOSVRfU0VUVVAoaW5pdHNldHVwX2FsaWduKQkJCQlcCisJCVNUQVRJQ19DT05T
VFMJCQkJCQlcCiAJCUlOSVRfQ0FMTFMJCQkJCQlcCiAJCUNPTl9JTklUQ0FMTAkJCQkJCVwKIAkJ
SU5JVF9SQU1fRlMJCQkJCQlcCi0tIAoyLjQ1LjEuMjA5LmdjNmYxMjMwMGRmCgo=
--0000000000004c664e061a2f3e15--

