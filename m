Return-Path: <linux-arch+bounces-4856-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3A6905E7C
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2024 00:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A58DB20CEA
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 22:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4E612CD88;
	Wed, 12 Jun 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BpZ8GN36"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB812CDA5
	for <linux-arch@vger.kernel.org>; Wed, 12 Jun 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718231150; cv=none; b=Vd1dYD3EQQh795vEZuL5HoEORPd+6Rbwy0SLRYOOQC45l+3AUl05JK7/FG/vp/9U+9A10VDuqinvG9GF3MvKofopprp50Up1xcMeZpEX5Swy8rftRbLHXg4CAcJ2P3FSC7u4SUIw80uIcBchPAqLJdPPikI0T2l5gFost4VVDyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718231150; c=relaxed/simple;
	bh=A10PWhJaScq0T+vZsTNJwKbAbZ7nlQlEUFiAqdpeFdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIcjdYjBN+X9v+HrPWHyFk8YDj1i1dU1GXJpp8tIp4KvXc+mDYrcgtxq2LTbHTv4JKTyyi2/45aBo2FSTKrSuzIhPHjsURaUa1A3W62J2pFIk2k1EDKQgpHe5UsjZEDEuoKP3io/UoK+51RKZocoZmnlG+vZ7hwggh40lvkYCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BpZ8GN36; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bc1261e8fso482232e87.0
        for <linux-arch@vger.kernel.org>; Wed, 12 Jun 2024 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718231147; x=1718835947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9VcA85nBfAJ5pqIO2zRB3DwRkzoK3bQ4ckXVVcF3yZw=;
        b=BpZ8GN36C3W1OebJxQOEQ3MEeORzk78+iUxKSkc9cylcxYXU2jT3ybvMvEbkFqgcDB
         SJE1l1CW3ryfxSDOQ7D+aRco8xK7rHsDUwntSqhuH3r3oWUbQ344UAy1r4QnEJFZMWHh
         ck5G3Z61u65IFPoJH9Ixa6Ojf1iBJZvNetmWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718231147; x=1718835947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VcA85nBfAJ5pqIO2zRB3DwRkzoK3bQ4ckXVVcF3yZw=;
        b=WpmCTvQsN7oJxYNqMUJWUVop2pw5J8HWJM4T7TXPTTbUS+3yAE+0pJNaeixMY/us/1
         P73K/YZ/yqNsmIfMTOhd2t8Ss2uGpZcBFSEwzAP1o7i12F02fZcIQLJKADZNYaGmWeBO
         vFTMw4R50Z3DSAUCaG4DJXVqag1jpNp40H3Aqubcd0rNYw1amogpIJWLlB8Ze/cvmubw
         KeSG3gdct+9a6uMzXjLpZByXTRUxj7U2aw0G/ZxBxoPGbS0kBCQkOrodoLxSVG+rAjUx
         vRxcXlN6XTEd5+9BrxVKf9pq/aAY9+QWLLC/jg/qsak20rOBxF6xNwCD+hm+TwvB0LZD
         bz6w==
X-Forwarded-Encrypted: i=1; AJvYcCWKAAp2ixlXl7I+TAuYpvRII3U/rKnTaSQ2MKm8oB1vSC/HeomdfGCeNW+MsoGMvhA2O80bGT9sqlht1pYtTUaOCDlOQecqtjUWzw==
X-Gm-Message-State: AOJu0YzVWNqADZZ49IRb34TFrjmbDfqN0qfADP+px9USH/2aGw4VawiG
	LunpK06V316AFSR8awrVxHXkAJAIvIh3wCXgj9n0vBOC1qxsvJB6o7Y2LwqJqTf7SEJd+d4mNiF
	FxYvBoQ==
X-Google-Smtp-Source: AGHT+IFmTgzQnGL6FXqxp+RmHP/YpE+soqEqiAlUWPwZqn41t8IEK0sFYvBJoDi7lI/fyS8B98DxQA==
X-Received: by 2002:a05:6512:694:b0:52c:99cc:eef4 with SMTP id 2adb3069b0e04-52c9a3b960cmr2584177e87.4.1718231146691;
        Wed, 12 Jun 2024 15:25:46 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca288e6dfsm4213e87.307.2024.06.12.15.25.43
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 15:25:44 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52962423ed8so483035e87.2
        for <linux-arch@vger.kernel.org>; Wed, 12 Jun 2024 15:25:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUKXmKqdlKmBO+wu9BeTGErzxjOKN1k3O422bN1RoNQdWVvD+3sH3ptsFLPYPKq3pXzpkY971b8gLKaMgy+3R0n4H36hOC//ihLQ==
X-Received: by 2002:a05:6512:31cf:b0:52c:a22e:8ffc with SMTP id
 2adb3069b0e04-52ca22e933fmr120725e87.58.1718231143517; Wed, 12 Jun 2024
 15:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <Zmnr3BjBkV4JxsIj@J2N7QTR9R3.cambridge.arm.com> <CAHk-=wg1AffeA6HLwZG9gbnFUACuzT-pyzao6BfQeZiCFt752Q@mail.gmail.com>
In-Reply-To: <CAHk-=wg1AffeA6HLwZG9gbnFUACuzT-pyzao6BfQeZiCFt752Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Jun 2024 15:25:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9_a757XQKJZyuWXM8yEZcSCCqzdnzxxFU3LEQcukxdQ@mail.gmail.com>
Message-ID: <CAHk-=wh9_a757XQKJZyuWXM8yEZcSCCqzdnzxxFU3LEQcukxdQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] arm64 / x86-64: low-level code generation issues
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000f4689f061ab8dc01"

--000000000000f4689f061ab8dc01
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 13:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll send out a new version of the arm64 patches with the KCSAN build
> failure fixed (with the simple no-op save/restore functions by making
> KCSAN and SW PAN mutually incompatible), and with the virtual address
> fix you pointed out in the other email.

Actually, unless somebody really wants to see the whole series again,
here's just the diff between the end result of the series.

The actual changes are done in the relevant commits (ie the "asm goto
for get_user()" one for the KCSAN issue, and the "arm64 runtime
constant" commit for the I$ fixup).

Holler if you want to see the full series again.

It might be worth noting that I initially made the arm64 KCSAN support
have a "depend on !ARM64_SW_TTBR0_PAN" condition, but decided that
it's actually better to do it the other way around, and make
ARM64_SW_TTBR0_PAN depend on KCSAN not being enabled.

That way we're basically more eagerly disabling the thing that should
go away, and we're also having the KCSAN code be checked for
allmodconfig builds.

But hey, it's a judgement call.

               Linus

--000000000000f4689f061ab8dc01
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lxcec86u0>
X-Attachment-Id: f_lxcec86u0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvS2NvbmZpZyBiL2FyY2gvYXJtNjQvS2NvbmZpZwppbmRl
eCA1ZDkxMjU5ZWU3YjUuLmI2ZTg5MjAzNjRkZSAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9LY29u
ZmlnCisrKyBiL2FyY2gvYXJtNjQvS2NvbmZpZwpAQCAtMTY0OSw2ICsxNjQ5LDcgQEAgY29uZmln
IFJPREFUQV9GVUxMX0RFRkFVTFRfRU5BQkxFRAogCiBjb25maWcgQVJNNjRfU1dfVFRCUjBfUEFO
CiAJYm9vbCAiRW11bGF0ZSBQcml2aWxlZ2VkIEFjY2VzcyBOZXZlciB1c2luZyBUVEJSMF9FTDEg
c3dpdGNoaW5nIgorCWRlcGVuZHMgb24gIUtDU0FOCiAJaGVscAogCSAgRW5hYmxpbmcgdGhpcyBv
cHRpb24gcHJldmVudHMgdGhlIGtlcm5lbCBmcm9tIGFjY2Vzc2luZwogCSAgdXNlci1zcGFjZSBt
ZW1vcnkgZGlyZWN0bHkgYnkgcG9pbnRpbmcgVFRCUjBfRUwxIHRvIGEgcmVzZXJ2ZWQKZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5oIGIvYXJjaC9hcm02
NC9pbmNsdWRlL2FzbS9ydW50aW1lLWNvbnN0LmgKaW5kZXggOGRjODNkNDhhMjAyLi5kZGU0YzEx
ZWMwZDUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5o
CisrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5oCkBAIC01MCw2ICs1
MCwxMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwXzE2KF9fbGUzMiAqcCwg
dW5zaWduZWQgaW50IHZhbCkKIAkqcCA9IGNwdV90b19sZTMyKGluc24pOwogfQogCitzdGF0aWMg
aW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwX2NhY2hlcyh2b2lkICp3aGVyZSwgdW5zaWduZWQg
aW50IGluc25zKQoreworCXVuc2lnbmVkIGxvbmcgdmEgPSAodW5zaWduZWQgbG9uZyl3aGVyZTsK
KwljYWNoZXNfY2xlYW5faW52YWxfcG91KHZhLCB2YSArIDQqaW5zbnMpOworfQorCiBzdGF0aWMg
aW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwX3B0cih2b2lkICp3aGVyZSwgdW5zaWduZWQgbG9u
ZyB2YWwpCiB7CiAJX19sZTMyICpwID0gbG1fYWxpYXMod2hlcmUpOwpAQCAtNTcsNyArNjMsNyBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwX3B0cih2b2lkICp3aGVyZSwgdW5z
aWduZWQgbG9uZyB2YWwpCiAJX19ydW50aW1lX2ZpeHVwXzE2KHArMSwgdmFsID4+IDE2KTsKIAlf
X3J1bnRpbWVfZml4dXBfMTYocCsyLCB2YWwgPj4gMzIpOwogCV9fcnVudGltZV9maXh1cF8xNihw
KzMsIHZhbCA+PiA0OCk7Ci0JY2FjaGVzX2NsZWFuX2ludmFsX3BvdSgodW5zaWduZWQgbG9uZylw
LCAodW5zaWduZWQgbG9uZykocCArIDQpKTsKKwlfX3J1bnRpbWVfZml4dXBfY2FjaGVzKHdoZXJl
LCA0KTsKIH0KIAogLyogSW1tZWRpYXRlIHZhbHVlIGlzIDYgYml0cyBzdGFydGluZyBhdCBiaXQg
IzE2ICovCkBAIC02OCw3ICs3NCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBfX3J1bnRpbWVfZml4
dXBfc2hpZnQodm9pZCAqd2hlcmUsIHVuc2lnbmVkIGxvbmcgdmFsKQogCWluc24gJj0gMHhmZmMw
ZmZmZjsKIAlpbnNuIHw9ICh2YWwgJiA2MykgPDwgMTY7CiAJKnAgPSBjcHVfdG9fbGUzMihpbnNu
KTsKLQljYWNoZXNfY2xlYW5faW52YWxfcG91KCh1bnNpZ25lZCBsb25nKXAsICh1bnNpZ25lZCBs
b25nKShwICsgMSkpOworCV9fcnVudGltZV9maXh1cF9jYWNoZXMod2hlcmUsIDEpOwogfQogCiBz
dGF0aWMgaW5saW5lIHZvaWQgcnVudGltZV9jb25zdF9maXh1cCh2b2lkICgqZm4pKHZvaWQgKiwg
dW5zaWduZWQgbG9uZyksCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3VhY2Nl
c3MuaCBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vdWFjY2Vzcy5oCmluZGV4IDM3YWJkODkzYzZl
ZS4uMWYyMTE5MGQ0ZGI1IDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3VhY2Nl
c3MuaAorKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaApAQCAtNDI0LDYgKzQy
NCwxNCBAQCBzdGF0aWMgX19tdXN0X2NoZWNrIF9fYWx3YXlzX2lubGluZSBib29sIHVzZXJfYWNj
ZXNzX2JlZ2luKGNvbnN0IHZvaWQgX191c2VyICpwdAogI2RlZmluZSB1bnNhZmVfZ2V0X3VzZXIo
eCwgcHRyLCBsYWJlbCkgXAogCV9fcmF3X2dldF9tZW0oImxkdHIiLCB4LCB1YWNjZXNzX21hc2tf
cHRyKHB0ciksIGxhYmVsLCBVKQogCisvKgorICogS0NTQU4gdXNlcyB0aGVzZSB0byBzYXZlIGFu
ZCByZXN0b3JlIHR0YnIgc3RhdGUuCisgKiBXZSBkbyBub3Qgc3VwcG9ydCBLQ1NBTiB3aXRoIEFS
TTY0X1NXX1RUQlIwX1BBTiwgc28KKyAqIHRoZXkgYXJlIG5vLW9wcy4KKyAqLworc3RhdGljIGlu
bGluZSB1bnNpZ25lZCBsb25nIHVzZXJfYWNjZXNzX3NhdmUodm9pZCkgeyByZXR1cm4gMDsgfQor
c3RhdGljIGlubGluZSB2b2lkIHVzZXJfYWNjZXNzX3Jlc3RvcmUodW5zaWduZWQgbG9uZyBlbmFi
bGVkKSB7IH0KKwogLyoKICAqIFdlIHdhbnQgdGhlIHVuc2FmZSBhY2Nlc3NvcnMgdG8gYWx3YXlz
IGJlIGlubGluZWQgYW5kIHVzZQogICogdGhlIGVycm9yIGxhYmVscyAtIHRodXMgdGhlIG1hY3Jv
IGdhbWVzLgo=
--000000000000f4689f061ab8dc01--

