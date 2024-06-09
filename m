Return-Path: <linux-arch+bounces-4761-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42591901450
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 05:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EBB1C20B47
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 03:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C305AD23;
	Sun,  9 Jun 2024 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SIHebmCA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB74C79
	for <linux-arch@vger.kernel.org>; Sun,  9 Jun 2024 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717902716; cv=none; b=W5AhiR67fhGiDBt5o604Ay8LP2/W5WIw2Iw+fC9woEm1T8OgJxkkCwRuiTdQaPUdiCEy+GT04JMiFIosr09Yak1Ue9dMbNTljtSiuo/G1KlPfwBMBJ0YgmSdwSnCuwktbjPcKdAWrOV2WTmZGKlTTtaCR6SNrRQD0xe52QIb7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717902716; c=relaxed/simple;
	bh=Ro+ub4ifFKSZnb+ejWJ/xsVvSkhd//wMcVYHKFO+dzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScE9Sb83qXthf02qcV2bVnixzn2FCJUR85sqb6z6sDZNrXgnKyggw4mAsV67SuiN+Ssruvaf+NB3+LN0HLrdQZ1mERddxqj+k3te4A97402uOP20yXpROOmQ8PWtQKvxW4O+qX/HyvrlbhII5OE/FvmBS499euTuBMNIwEVTcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SIHebmCA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so4183966a12.2
        for <linux-arch@vger.kernel.org>; Sat, 08 Jun 2024 20:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717902711; x=1718507511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7dUoCR65nMgbX7LmvgfZWZMvg21MHj7Khg3DNyY50c=;
        b=SIHebmCAAjHeKOmVHFnO0nUH0PHiJuJyZbym03QbwX5JYwryUZEVAuxrmfaD2w6SUH
         wDi3ocoR0RGcVCFiLPeSwC/7CjS2fdnEEpDwVffhACpIEYL2/EiRAdgrtKeSYwDwWUHo
         NPSUtvvt7rNzOXCkKNrQQsP1gZFqinTiKVQk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717902711; x=1718507511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7dUoCR65nMgbX7LmvgfZWZMvg21MHj7Khg3DNyY50c=;
        b=gSdozEzjSMWqNiW8VAqTwrsMxXSlN5r/jWBcxPP5fI2BUXYwGHMi2NM3QSqbfhDyn/
         OwM1AxQ0NitJTKM3wIWiy8LJlMojfaBdy2LH+TuWO55/9akH1FOWbCAIUsTrNPj9k5sW
         ldGseQlAK3QjoA2jU8mkOn9+CNn/oxxTL1Bw94Cj+s+9WLihHmb99W9gz7bsrC2SB0sU
         U5bF+KddMdP6JIYn0+Z/IeZUT+Bu1bu2h7G9iS3MAWojvl7bhwAWwCWJjuWLlSUf52KT
         OZlgMA5AGMlGn45A9PKXy640YS26PB93wFpdP+h6S0eUK0vlhE1N+mjiYiygaSr5kIUQ
         Lh0g==
X-Forwarded-Encrypted: i=1; AJvYcCXQygWDNuob4rGbV5sWkxMVbuFxtZKjTwPnXFX/I6919l5XXudEgzLVemGzSGeN4YXx2aKMSlJeuejOH0dj/gjnpDhD0RUCMOHE/w==
X-Gm-Message-State: AOJu0Yz65NSskCohwLZAVaJaD09JPPNlQVWO9qcyLxyNiOeXxkDDxDod
	/BTv9LRKtZU74OlH/2NsXjAqePfjuAx0ZK1m95ICozZi61ugWib/OnhDsGYDfVtybIxuar0pgtT
	Mg6w=
X-Google-Smtp-Source: AGHT+IGHR6yRcouDZvgJfkMX1eE4Hm7MfB8woQcG69DPpNFgiWH2JmN2IcgqRL+ZV21X1xTQPZBQOQ==
X-Received: by 2002:a17:907:1ca3:b0:a68:ed2e:ebfc with SMTP id a640c23a62f3a-a6cdc1de0acmr516510466b.67.1717902711562;
        Sat, 08 Jun 2024 20:11:51 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8072ac1fsm465879666b.222.2024.06.08.20.11.50
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 20:11:50 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so4183944a12.2
        for <linux-arch@vger.kernel.org>; Sat, 08 Jun 2024 20:11:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHNqZ+w3LlhG6ED34LPH0U2nAkZHwyk9WuRW9NCSav8R5lOY3PelsxLA4dt3g3/DIF8Sw4UH6nHdNLFyHk7nFHxuWQi5tSmoIYEA==
X-Received: by 2002:a17:906:f858:b0:a6e:f869:dfcd with SMTP id
 a640c23a62f3a-a6ef869e146mr209955566b.6.1717902709744; Sat, 08 Jun 2024
 20:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org> <CAHk-=wjiJvGW70_A93oN_f48J0pn4MeVbWVmBPBiTh2XiSpwpg@mail.gmail.com>
In-Reply-To: <CAHk-=wjiJvGW70_A93oN_f48J0pn4MeVbWVmBPBiTh2XiSpwpg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 8 Jun 2024 20:11:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPSnaCczHp3Jy=kFjfqJa7MTQg6jht_FwZCxOnpsi4Vw@mail.gmail.com>
Message-ID: <CAHk-=wiPSnaCczHp3Jy=kFjfqJa7MTQg6jht_FwZCxOnpsi4Vw@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="000000000000c61ba5061a6c64c4"

--000000000000c61ba5061a6c64c4
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Jun 2024 at 13:55, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Think of this patch mostly as a "look, adding another architecture
> isn't *that* hard - even if the constant value is spread out in the
> instructions".

.. and here's a version that actually works. It wasn't that bad.

Or rather, it wouldn't have been that bad had I not spent *ages*
debugging a stupid cut-and-paste error where I instead of writing
words 0..3 of the 64-bit large constant generation, wrote words 0..2
and then overwrote word 2 (again) with the data that should have gone
into word 3. Causing the top 32 bits to be all wonky. Oops. Literally.

That stupid typo caused like two hours of wasted time.

But anyway, this patch actually works for me. It still doesn't do any
I$/D$ flushing, because it's not needed in practice, but it *should*
probably do that.

             Linus

--000000000000c61ba5061a6c64c4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-arm64-add-runtime-const-support.patch"
Content-Disposition: attachment; 
	filename="0001-arm64-add-runtime-const-support.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lx6yvkv70>
X-Attachment-Id: f_lx6yvkv70

RnJvbSA4ODc4MjFlMWNmMzJjNTA1ZDJiYzlmYjlkY2VlNDVjZjFlMmY2NWU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFNhdCwgOCBKdW4gMjAyNCAxMzoyMjozMSAtMDcwMApTdWJqZWN0OiBb
UEFUQ0hdIGFybTY0OiBhZGQgJ3J1bnRpbWUgY29uc3QnIHN1cHBvcnQKClNpZ25lZC1vZmYtYnk6
IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBhcmNo
L2FybTY0L2luY2x1ZGUvYXNtL3J1bnRpbWUtY29uc3QuaCB8IDc1ICsrKysrKysrKysrKysrKysr
KysrKysrKysrCiBhcmNoL2FybTY0L2tlcm5lbC92bWxpbnV4Lmxkcy5TICAgICAgICB8ICAzICsr
CiAyIGZpbGVzIGNoYW5nZWQsIDc4IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBh
cmNoL2FybTY0L2luY2x1ZGUvYXNtL3J1bnRpbWUtY29uc3QuaAoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2Fz
bS9ydW50aW1lLWNvbnN0LmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAw
Li5hYjVmOThiYzk0MmUKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNt
L3J1bnRpbWUtY29uc3QuaApAQCAtMCwwICsxLDc1IEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMCAqLworI2lmbmRlZiBfQVNNX1JVTlRJTUVfQ09OU1RfSAorI2RlZmluZSBf
QVNNX1JVTlRJTUVfQ09OU1RfSAorCisjZGVmaW5lIHJ1bnRpbWVfY29uc3RfcHRyKHN5bSkgKHsJ
CQkJXAorCXR5cGVvZihzeW0pIF9fcmV0OwkJCQkJXAorCWFzbSgiMTpcdCIJCQkJCQlcCisJCSJt
b3Z6ICUwLCAjMHhjZGVmXG5cdCIJCQkJXAorCQkibW92ayAlMCwgIzB4ODlhYiwgbHNsICMxNlxu
XHQiCQkJXAorCQkibW92ayAlMCwgIzB4NDU2NywgbHNsICMzMlxuXHQiCQkJXAorCQkibW92ayAl
MCwgIzB4MDEyMywgbHNsICM0OFxuXHQiCQkJXAorCQkiLnB1c2hzZWN0aW9uIHJ1bnRpbWVfcHRy
XyIgI3N5bSAiLFwiYVwiXG5cdCIJXAorCQkiLmxvbmcgMWIgLSAuXG5cdCIJCQkJXAorCQkiLnBv
cHNlY3Rpb24iCQkJCQlcCisJCToiPXIiIChfX3JldCkpOwkJCQkJXAorCV9fcmV0OyB9KQorCisj
ZGVmaW5lIHJ1bnRpbWVfY29uc3Rfc2hpZnRfcmlnaHRfMzIodmFsLCBzeW0pICh7CQlcCisJdW5z
aWduZWQgbG9uZyBfX3JldDsJCQkJCVwKKwlhc20oIjE6XHQiCQkJCQkJXAorCQkibHNyICV3MCwl
dzEsIzEyXG5cdCIJCQkJXAorCQkiLnB1c2hzZWN0aW9uIHJ1bnRpbWVfc2hpZnRfIiAjc3ltICIs
XCJhXCJcblx0IglcCisJCSIubG9uZyAxYiAtIC5cblx0IgkJCQlcCisJCSIucG9wc2VjdGlvbiIJ
CQkJCVwKKwkJOiI9ciIgKF9fcmV0KQkJCQkJXAorCQk6InIiICgwdSsodmFsKSkpOwkJCQlcCisJ
X19yZXQ7IH0pCisKKyNkZWZpbmUgcnVudGltZV9jb25zdF9pbml0KHR5cGUsIHN5bSwgdmFsdWUp
IGRvIHsJXAorCWV4dGVybiBzMzIgX19zdGFydF9ydW50aW1lXyMjdHlwZSMjXyMjc3ltW107CVwK
KwlleHRlcm4gczMyIF9fc3RvcF9ydW50aW1lXyMjdHlwZSMjXyMjc3ltW107CVwKKwlydW50aW1l
X2NvbnN0X2ZpeHVwKF9fcnVudGltZV9maXh1cF8jI3R5cGUsCVwKKwkJKHVuc2lnbmVkIGxvbmcp
KHZhbHVlKSwgCQlcCisJCV9fc3RhcnRfcnVudGltZV8jI3R5cGUjI18jI3N5bSwJCVwKKwkJX19z
dG9wX3J1bnRpbWVfIyN0eXBlIyNfIyNzeW0pOwkJXAorfSB3aGlsZSAoMCkKKworLy8gMTYtYml0
IGltbWVkaWF0ZSBmb3Igd2lkZSBtb3ZlIChtb3Z6IGFuZCBtb3ZrKSBpbiBiaXRzIDUuLjIwCitz
dGF0aWMgaW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwXzE2KHVuc2lnbmVkIGludCAqcCwgdW5z
aWduZWQgaW50IHZhbCkKK3sKKwl1bnNpZ25lZCBpbnQgaW5zbiA9ICpwOworCWluc24gJj0gMHhm
ZmUwMDAxZjsKKwlpbnNuIHw9ICh2YWwgJiAweGZmZmYpIDw8IDU7CisJKnAgPSBpbnNuOworfQor
CitzdGF0aWMgaW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwX3B0cih2b2lkICp3aGVyZSwgdW5z
aWduZWQgbG9uZyB2YWwpCit7CisJdW5zaWduZWQgaW50ICpwID0gbG1fYWxpYXMod2hlcmUpOwor
CV9fcnVudGltZV9maXh1cF8xNihwLCB2YWwpOworCV9fcnVudGltZV9maXh1cF8xNihwKzEsIHZh
bCA+PiAxNik7CisJX19ydW50aW1lX2ZpeHVwXzE2KHArMiwgdmFsID4+IDMyKTsKKwlfX3J1bnRp
bWVfZml4dXBfMTYocCszLCB2YWwgPj4gNDgpOworfQorCisvLyBJbW1lZGlhdGUgdmFsdWUgaXMg
NSBiaXRzIHN0YXJ0aW5nIGF0IGJpdCAjMTYKK3N0YXRpYyBpbmxpbmUgdm9pZCBfX3J1bnRpbWVf
Zml4dXBfc2hpZnQodm9pZCAqd2hlcmUsIHVuc2lnbmVkIGxvbmcgdmFsKQoreworCXVuc2lnbmVk
IGludCAqcCA9IGxtX2FsaWFzKHdoZXJlKTsKKwl1bnNpZ25lZCBpbnQgaW5zbiA9ICpwOworCWlu
c24gJj0gMHhmZmMwZmZmZjsKKwlpbnNuIHw9ICh2YWwgJiA2MykgPDwgMTY7CisJKnAgPSBpbnNu
OworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgcnVudGltZV9jb25zdF9maXh1cCh2b2lkICgqZm4p
KHZvaWQgKiwgdW5zaWduZWQgbG9uZyksCisJdW5zaWduZWQgbG9uZyB2YWwsIHMzMiAqc3RhcnQs
IHMzMiAqZW5kKQoreworCXdoaWxlIChzdGFydCA8IGVuZCkgeworCQlmbigqc3RhcnQgKyAodm9p
ZCAqKXN0YXJ0LCB2YWwpOworCQlzdGFydCsrOworCX0KK30KKworI2VuZGlmCmRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2tlcm5lbC92bWxpbnV4Lmxkcy5TIGIvYXJjaC9hcm02NC9rZXJuZWwvdm1s
aW51eC5sZHMuUwppbmRleCA3NTVhMjJkNGY4NDAuLjU1YThlMzEwZWExMiAxMDA2NDQKLS0tIGEv
YXJjaC9hcm02NC9rZXJuZWwvdm1saW51eC5sZHMuUworKysgYi9hcmNoL2FybTY0L2tlcm5lbC92
bWxpbnV4Lmxkcy5TCkBAIC0yNjQsNiArMjY0LDkgQEAgU0VDVElPTlMKIAkJRVhJVF9EQVRBCiAJ
fQogCisJUlVOVElNRV9DT05TVChzaGlmdCwgZF9oYXNoX3NoaWZ0KQorCVJVTlRJTUVfQ09OU1Qo
cHRyLCBkZW50cnlfaGFzaHRhYmxlKQorCiAJUEVSQ1BVX1NFQ1RJT04oTDFfQ0FDSEVfQllURVMp
CiAJSFlQRVJWSVNPUl9QRVJDUFVfU0VDVElPTgogCi0tIAoyLjQ1LjEKCg==
--000000000000c61ba5061a6c64c4--

