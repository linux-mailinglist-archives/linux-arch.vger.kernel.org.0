Return-Path: <linux-arch+bounces-4758-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A226901378
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jun 2024 22:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E921C20C78
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jun 2024 20:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C31D554;
	Sat,  8 Jun 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YQ5fiA/i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F111C6BE
	for <linux-arch@vger.kernel.org>; Sat,  8 Jun 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717880128; cv=none; b=P+7JCnBX46gU96cu/qceWSt46hoMqbBLwo6Mq8iAqdRco02hEXNQXzxEwadA4/N3ATY4JA+jwgB7WCEGXtcpQI9kZl/BlYnlFtL/UolM7EUgeiOvxsesNxass26YcsG0yVVzXuVeOwGcJIh1xZMiTmQEssY8SbYQdhCJmsRE1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717880128; c=relaxed/simple;
	bh=85qXbyqX6RxIt4uYLrSaAWXRZLFbmQAyyxDKG3decKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RreMcslfyPUoltGH+D1IMI0Fu3IlpTgLPzsbSWlKlZjA4mkq9LuAjuD2YVRHmxCT2WB3dQbS4rw5QZcVEfcPDzYCqNlgxBjlZQRuKRa3DwgT84C5ixISVpSmV7d/mpgEyR2Bo/aSuFv6PrHioeZ56hKlXjQXwNww6/7m9Eq2NKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YQ5fiA/i; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52c32d934c2so862335e87.2
        for <linux-arch@vger.kernel.org>; Sat, 08 Jun 2024 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717880124; x=1718484924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8fZXZV0kR4ym1XRcBTj6zdWLTsFZy0CZQ2wcW79A4Pg=;
        b=YQ5fiA/i9irEZv950RSdF+rt1Q/nv0owxU5c2taFyR9SX5KN64c+AN0WKrr2ViIJv+
         ZRGAVMLeYhfyDW9E1zmpcir+XT+EIy2/jKRwVZqm3eYUyX2zeoyijsUwyj+izMS/+v3m
         PtmzSG44bHWQU/+fk4scIfw1KPRf2uIdpLLfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717880124; x=1718484924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fZXZV0kR4ym1XRcBTj6zdWLTsFZy0CZQ2wcW79A4Pg=;
        b=Ugcl4SyvrtI8nvditXzvCnAfLWodgnt/X+glk+tC5+mlxhFXPsxUemk6EqoNdbNyJq
         SGXddW5xNZNBxc1Z6lnyZFiH98wwtK4Mt1EU5OH43zau3sdGn6Q1KLAyHUWeHWh0bx2G
         oFk3qBPnH2q1Js+cGL7cewz9H+3MOD13CbloL0NPNMmETVbM2yHCi6RsQcS5Hd8jGUJ4
         X9sBFNeCGPkompkVP+BkyLJX3Ch1i0dg1nCS8cNgT3m5MfoO7ltXBdtytFpBbChaLEmj
         FOrVq7w6YV2pmwMt9we/RS5J0mLYOBrhZ8K/mwFBYImOtKAGzbE5GS3XLnBZJ5NZNRbA
         rhCA==
X-Forwarded-Encrypted: i=1; AJvYcCVfW0bqbPl3aUkqjmkWr07N2Rcj4ubKWtuuO3AuNUOeBBxacUCNQHZIuLvQbO7xoOGCsbKsfTJWvaHcESwQjrjzQdo75MUC0K9G2g==
X-Gm-Message-State: AOJu0YyuARxjc7EXfGk5HM6g+JeYwtDpidlAjizhrQNGa9Jv1XS/igJ6
	wgfs0KYvWtohF7I+newKh1T+DQS50v+CEsdsGCFl15psGzUGEgD+19YKqhgvRwF1mu/ykPqdQY1
	R/D8=
X-Google-Smtp-Source: AGHT+IGWDKSui7Eo8z9tU5W7Sazu92zXVHP4c5/i+vUdvhbtoiPjUCwI0eUHKpVmsQC8T3A6NP74zQ==
X-Received: by 2002:a05:6512:b1f:b0:52c:845e:3194 with SMTP id 2adb3069b0e04-52c845e322dmr603231e87.29.1717880123611;
        Sat, 08 Jun 2024 13:55:23 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d8b280esm99661366b.149.2024.06.08.13.55.22
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 13:55:22 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6efae34c83so103304066b.0
        for <linux-arch@vger.kernel.org>; Sat, 08 Jun 2024 13:55:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJdg8+W8qxSFIMQ+yBBLuJkWzTN/p0hv6HcvVCxR1G0ej/HU6NmSG93Ncg7rT/ROHYSOxsKgBF0sKDftnZiTEyYJ8CVz6sHAOW4A==
X-Received: by 2002:a17:906:585:b0:a6f:1235:d82 with SMTP id
 a640c23a62f3a-a6f12350ed3mr42380466b.13.1717880121989; Sat, 08 Jun 2024
 13:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
In-Reply-To: <20240608193504.429644-2-torvalds@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 8 Jun 2024 13:55:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjiJvGW70_A93oN_f48J0pn4MeVbWVmBPBiTh2XiSpwpg@mail.gmail.com>
Message-ID: <CAHk-=wjiJvGW70_A93oN_f48J0pn4MeVbWVmBPBiTh2XiSpwpg@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="0000000000007054e4061a6722a6"

--0000000000007054e4061a6722a6
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Jun 2024 at 12:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Needs more comments and testing, but it works, and has a generic
> fallback for architectures that don't support it.

.. and here is the TOTALLY UNTESTED patch to implement the arm64
version of runtime constants.

It almost certainly does not work. I'm too scared to test it.  I may
start to recognize arm64 instructions, but rewriting them on the fly
is another thing entirely, and I'm fairly sure this needs an  I$ sync
and probably modifying the instructions using another address even
during early boot.

So this is a "throw it over the fence to the actually competent arm64
people" patch.

Catalin, Will? This depends on the infrastructure that I added in

   https://lore.kernel.org/all/20240608193504.429644-2-torvalds@linux-foundation.org/

which is actually tested on the x86-64 side.

I did test that the code generation looks superficially sane, and this generates

        mov     x1, #0xcdef
        movk    x1, #0x89ab, lsl #16
        movk    x1, #0x4567, lsl #32
        movk    x1, #0x123, lsl #48
        ...
        lsr     w0, w25, #12
        ldr     x0, [x1, x0, lsl #3]

for the dcache hash lookup (those constants are obviously the ones
that get rewritten after the hash table has been allocated and the
size becomes fixed).

And honestly, I may have gotten even the simple part of instruction
rewriting wrong (ie maybe I'm filling in the wrong bit locations - I'm
reading the architecture manual, not actually *testing* anything).

Think of this patch mostly as a "look, adding another architecture
isn't *that* hard - even if the constant value is spread out in the
instructions".

                Linus

--0000000000007054e4061a6722a6
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-arm64-add-runtime-const-support.patch"
Content-Disposition: attachment; 
	filename="0001-arm64-add-runtime-const-support.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lx6lemy50>
X-Attachment-Id: f_lx6lemy50

RnJvbSBiZWZjM2Q0OTM2NmZiMDQ5YjY1Njc5ZmIzN2ZhNzAzZmU0MTlhN2U4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFNhdCwgOCBKdW4gMjAyNCAxMzoyMjozMSAtMDcwMApTdWJqZWN0OiBb
UEFUQ0hdIGFybTY0OiBhZGQgJ3J1bnRpbWUgY29uc3QnIHN1cHBvcnQKCk1vbW15IG1vbW15IEkn
bSBzY2FyZWQKLS0tCiBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL3J1bnRpbWUtY29uc3QuaCB8IDcz
ICsrKysrKysrKysrKysrKysrKysrKysrKysrCiBhcmNoL2FybTY0L2tlcm5lbC92bWxpbnV4Lmxk
cy5TICAgICAgICB8ICAzICsrCiAyIGZpbGVzIGNoYW5nZWQsIDc2IGluc2VydGlvbnMoKykKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL3J1bnRpbWUtY29uc3QuaAoK
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5oIGIvYXJj
aC9hcm02NC9pbmNsdWRlL2FzbS9ydW50aW1lLWNvbnN0LmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMDAwMDAwLi43ZDQwMmFlNmQzYzIKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNo
L2FybTY0L2luY2x1ZGUvYXNtL3J1bnRpbWUtY29uc3QuaApAQCAtMCwwICsxLDczIEBACisvKiBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLworI2lmbmRlZiBfQVNNX1JVTlRJTUVf
Q09OU1RfSAorI2RlZmluZSBfQVNNX1JVTlRJTUVfQ09OU1RfSAorCisjZGVmaW5lIHJ1bnRpbWVf
Y29uc3RfcHRyKHN5bSkgKHsJCQkJXAorCXR5cGVvZihzeW0pIF9fcmV0OwkJCQkJXAorCWFzbSgi
MTpcdCIJCQkJCQlcCisJCSJtb3Z6ICUwLCAjMHhjZGVmXG5cdCIJCQkJXAorCQkibW92ayAlMCwg
IzB4ODlhYiwgbHNsICMxNlxuXHQiCQkJXAorCQkibW92ayAlMCwgIzB4NDU2NywgbHNsICMzMlxu
XHQiCQkJXAorCQkibW92ayAlMCwgIzB4MDEyMywgbHNsICM0OFxuXHQiCQkJXAorCQkiLnB1c2hz
ZWN0aW9uIHJ1bnRpbWVfcHRyXyIgI3N5bSAiLFwiYVwiXG5cdCIJXAorCQkiLmxvbmcgMWIgLSAu
XG5cdCIJCQkJXAorCQkiLnBvcHNlY3Rpb24iCQkJCQlcCisJCToiPXIiIChfX3JldCkpOwkJCQkJ
XAorCV9fcmV0OyB9KQorCisjZGVmaW5lIHJ1bnRpbWVfY29uc3Rfc2hpZnRfcmlnaHRfMzIodmFs
LCBzeW0pICh7CQlcCisJdW5zaWduZWQgbG9uZyBfX3JldDsJCQkJCVwKKwlhc20oIjE6XHQiCQkJ
CQkJXAorCQkibHNyICV3MCwldzEsIzEyXG5cdCIJCQkJXAorCQkiLnB1c2hzZWN0aW9uIHJ1bnRp
bWVfc2hpZnRfIiAjc3ltICIsXCJhXCJcblx0IglcCisJCSIubG9uZyAxYiAtIC5cblx0IgkJCQlc
CisJCSIucG9wc2VjdGlvbiIJCQkJCVwKKwkJOiI9ciIgKF9fcmV0KQkJCQkJXAorCQk6InIiICgw
dSsodmFsKSkpOwkJCQlcCisJX19yZXQ7IH0pCisKKyNkZWZpbmUgcnVudGltZV9jb25zdF9pbml0
KHR5cGUsIHN5bSwgdmFsdWUpIGRvIHsJXAorCWV4dGVybiBzMzIgX19zdGFydF9ydW50aW1lXyMj
dHlwZSMjXyMjc3ltW107CVwKKwlleHRlcm4gczMyIF9fc3RvcF9ydW50aW1lXyMjdHlwZSMjXyMj
c3ltW107CVwKKwlydW50aW1lX2NvbnN0X2ZpeHVwKF9fcnVudGltZV9maXh1cF8jI3R5cGUsCVwK
KwkJKHVuc2lnbmVkIGxvbmcpKHZhbHVlKSwgCQlcCisJCV9fc3RhcnRfcnVudGltZV8jI3R5cGUj
I18jI3N5bSwJCVwKKwkJX19zdG9wX3J1bnRpbWVfIyN0eXBlIyNfIyNzeW0pOwkJXAorfSB3aGls
ZSAoMCkKKworLy8gMTYtYml0IGltbWVkaWF0ZSBmb3Igd2lkZSBtb3ZlIChtb3Z6IGFuZCBtb3Zr
KSBpbiBiaXRzIDUuLjIwCitzdGF0aWMgaW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwXzE2KHVu
c2lnbmVkIGludCAqcCwgdW5zaWduZWQgaW50IHZhbCkKK3sKKwl1bnNpZ25lZCBpbnQgaW5zbiA9
ICpwOworCWluc24gJj0gMHhmZmUwMDAxZjsKKwlpbnNuIHw9ICh2YWwgJiAweGZmZmYpIDw8IDU7
CisJKnAgPSBpbnNuOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwX3B0
cih2b2lkICp3aGVyZSwgdW5zaWduZWQgbG9uZyB2YWwpCit7CisJX19ydW50aW1lX2ZpeHVwXzE2
KHdoZXJlLCB2YWwpOworCV9fcnVudGltZV9maXh1cF8xNih3aGVyZSs0LCB2YWwgPj4gMTYpOwor
CV9fcnVudGltZV9maXh1cF8xNih3aGVyZSs4LCB2YWwgPj4gMzIpOworCV9fcnVudGltZV9maXh1
cF8xNih3aGVyZSsxMiwgdmFsID4+IDQ4KTsKK30KKworLy8gSW1tZWRpYXRlIHZhbHVlIGlzIDUg
Yml0cyBzdGFydGluZyBhdCBiaXQgIzE2CitzdGF0aWMgaW5saW5lIHZvaWQgX19ydW50aW1lX2Zp
eHVwX3NoaWZ0KHZvaWQgKndoZXJlLCB1bnNpZ25lZCBsb25nIHZhbCkKK3sKKwl1bnNpZ25lZCBp
bnQgaW5zbiA9ICoodW5zaWduZWQgaW50ICopd2hlcmU7CisJaW5zbiAmPSAweGZmYzBmZmZmOwor
CWluc24gfD0gKHZhbCAmIDYzKSA8PCAxNjsKKwkqKHVuc2lnbmVkIGludCAqKXdoZXJlID0gaW5z
bjsKK30KKworc3RhdGljIGlubGluZSB2b2lkIHJ1bnRpbWVfY29uc3RfZml4dXAodm9pZCAoKmZu
KSh2b2lkICosIHVuc2lnbmVkIGxvbmcpLAorCXVuc2lnbmVkIGxvbmcgdmFsLCBzMzIgKnN0YXJ0
LCBzMzIgKmVuZCkKK3sKKwl3aGlsZSAoc3RhcnQgPCBlbmQpIHsKKwkJZm4oKnN0YXJ0ICsgKHZv
aWQgKilzdGFydCwgdmFsKTsKKwkJc3RhcnQrKzsKKwl9Cit9CisKKyNlbmRpZgpkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9rZXJuZWwvdm1saW51eC5sZHMuUyBiL2FyY2gvYXJtNjQva2VybmVsL3Zt
bGludXgubGRzLlMKaW5kZXggNzU1YTIyZDRmODQwLi41NWE4ZTMxMGVhMTIgMTAwNjQ0Ci0tLSBh
L2FyY2gvYXJtNjQva2VybmVsL3ZtbGludXgubGRzLlMKKysrIGIvYXJjaC9hcm02NC9rZXJuZWwv
dm1saW51eC5sZHMuUwpAQCAtMjY0LDYgKzI2NCw5IEBAIFNFQ1RJT05TCiAJCUVYSVRfREFUQQog
CX0KIAorCVJVTlRJTUVfQ09OU1Qoc2hpZnQsIGRfaGFzaF9zaGlmdCkKKwlSVU5USU1FX0NPTlNU
KHB0ciwgZGVudHJ5X2hhc2h0YWJsZSkKKwogCVBFUkNQVV9TRUNUSU9OKEwxX0NBQ0hFX0JZVEVT
KQogCUhZUEVSVklTT1JfUEVSQ1BVX1NFQ1RJT04KIAotLSAKMi40NS4xCgo=
--0000000000007054e4061a6722a6--

