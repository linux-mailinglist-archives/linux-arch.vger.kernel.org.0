Return-Path: <linux-arch+bounces-9352-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B869EB69A
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 17:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF31160EE3
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545011C07C2;
	Tue, 10 Dec 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPXQkT5e"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7F1A3BA1;
	Tue, 10 Dec 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848646; cv=none; b=YjO+JnVuzfLdsGfyoe4aa1QQXLkXXB72c1+vumaYu90L9UbIaSkfiEVUPwM5S5J9XRv8fp2cYrW5T4hehj9RgdtRQssUFoOraULfaJCxcaq1Ewiezl3jGG+j1BtRpMk24pL5r+RcBSPSqvvAiwlrqA1TQ7wGJLnhc4pxwBPMZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848646; c=relaxed/simple;
	bh=bMaWMUz5V3ffO6Fby9ugSZR/xOrKRSiA3Zeu/M2/xfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfiBnaSSekB7NcoKDR9WAMPOlNDcdANLdzEYfMtw47zOxOQc6fZ0nNZj951p9QwKCJhCRN3gN6U/LvAuJ8H+TjHO+8SB/CZEwpDSm2a0n7ZCZNxbW3EMhGqrD/1zitpUwm0T1Jyrd91W92YRNbfkWNF3UX6Z99g+9Kgz4tQiTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPXQkT5e; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30227ccf803so18584321fa.2;
        Tue, 10 Dec 2024 08:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733848642; x=1734453442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mMr2qVhA4J2Ksp2znQVcePx2ayh49sbpV9PFu6+5bZw=;
        b=lPXQkT5eLbSJihPkq8nL0G8RkVzHzRoxK5mOatJadWIYXOxVDxpn+B/NjAsr3sNkyW
         1cOGWBUM5DRxAknBLIIa5/A6cn7p9apbJyoJY2cMcfyqNdMJmMpKTp3JSDPexsdvavMs
         5A+p1IsBU7sMkhEMTAjkU9wVpTHamZClnZMpUD+ekJn57j2QdyqlhkalHW1p+PH98SlX
         NVO4E10KbKrtbbotRq0efHbzE6alEW2Dxj24B3MKZedyTM0yBpAAVZr5zdXKimdq2u7+
         Zr8TjDW/hNkxGRvO/JDpak679tjOrtPnPQ6QhFNRe+jiirI/iLSsZE5ER/mC8JIZcB4p
         nEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848642; x=1734453442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMr2qVhA4J2Ksp2znQVcePx2ayh49sbpV9PFu6+5bZw=;
        b=t3VqFKAyh/iCq8qnFGWP+G27/0aq73Zt7kpOaAlPc5AtRJmLAruSeGmx1BO7twHDTi
         tiiwQUrDPTrSHNMhn86hK2i9HGubV7CN0dRLJT/mIpqj5mcNwjNDsLjXpq4hS+4ffOwZ
         tiszA4Die3jB2y7RkgUPHIhWMDdhB7sPytKysJz3ZAVHnBuyIdnsEJDPaedDsIbNjtQz
         g1aExzpVYkbROFnqsKwokSe2AGfz8FOavv2bao+MtAv3CxWtJErBuhG/32p9C2VrRYKN
         7hgyZ9Pm+LXsmYcunJ5b2bKX8BJ7mJHzGNP9HtNZzrPWp1n12jnkJLMIpVM2o6shTEZU
         nnCw==
X-Forwarded-Encrypted: i=1; AJvYcCUIA1APIB+1IXaJSTYld/QCmEc+YQtiTxQU+0hiXS1IJ7dl3+SbEoivIoGLL3Rt+dyv1Jvqf5ol@vger.kernel.org, AJvYcCVAtMZwqvBaghoKPvWhxRe+dogpLB5F85HKRwxWfq9wGoSwj2OrY6kSANwIYysufOyMdQ13Op8MIXPA@vger.kernel.org, AJvYcCVS1daRC6bzX4QHacuXx/Axq+TYWzUsmvsvavZ1spW2QHxesWHYfTT/OqrsDUj1guESVbxvG4pzPN+tS23toYk=@vger.kernel.org, AJvYcCWsAMbak7iBv9MOlSQ3bdWPsrNby2V/vIyRjiEZ0fmnrWcAG6PKoxEImYU5NSUfjPgXf6MB+1wcUzlKZM1v@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80Bl/eCnReMrBbhcMMYZPNkDJoWLNFA3qinKBehRBL/ZpLhU8
	1ZWrEEvIWJM5/QBsLYrK5aFKqp4HYkloFMc2eWMz6TPz/0ZfiFDLNOIL79b00FI5tPmx/C1Q2i8
	ZU194xuOhgBdPeZb0trwY2S6tRHQ=
X-Gm-Gg: ASbGnct6exCBj4xdRBsNdU2qWnitw9JO2TT5yDWfxOvxcBTQYE5uwg4bj8L3Yto0dY/
	8gAATxVLCoIkAz3+xTa3QA4+lfW3U9aSeoSU=
X-Google-Smtp-Source: AGHT+IHiGI51RueWOS5PEJQEG+4Gh2nJXRo4OsJkgCK1jqR6c9JsfhkuPRwhfJ6Gu9P1fz4wuUEMdL6zMVunaz4Mo1A=
X-Received: by 2002:a05:651c:150c:b0:300:41a8:125b with SMTP id
 38308e7fff4ca-30041a813f7mr47506931fa.37.1733848642191; Tue, 10 Dec 2024
 08:37:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208204708.3742696-1-ubizjak@gmail.com> <20241208204708.3742696-3-ubizjak@gmail.com>
 <20241209113039.GN21636@noisy.programming.kicks-ass.net>
In-Reply-To: <20241209113039.GN21636@noisy.programming.kicks-ass.net>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 10 Dec 2024 17:37:10 +0100
Message-ID: <CAFULd4Y7-_Zax3S-m3H6ok9SvsBgS7DmJjSu=3VZ1hyzT71jjg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] compiler.h: Introduce TYPEOF_UNQUAL() macro
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-arch@vger.kernel.org, 
	netdev@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000069a3ca0628ed186b"

--00000000000069a3ca0628ed186b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 12:30=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, Dec 08, 2024 at 09:45:17PM +0100, Uros Bizjak wrote:
> > Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof operator
> > when available, to return unqualified type of the expression.
> >
> > Current version of sparse doesn't know anything about __typeof_unqual__=
()
> > operator. Avoid the usage of __typeof_unqual__() when sparse checking
> > is active to prevent sparse errors with unknowing keyword.
>
> Ooooh, new toys.
>
> I suppose __unqual_scalar_typeof() wants to be using this when
> available?

Not only that, the new toy enables clang to check kernel's address
spaces in a generic way using address_space attribute.

Please find attached a follow-up patch that enables __percpu checks
for all targets, supported by clang. Clang is a little bit pickier
than gcc about named address space declarations (it warns for use of
duplicated address space attribute), so the patch in addition to the
obvious

+#  define __percpu_qual        __attribute__((address_space(3)))

also fixes a couple of macros that could result in a duplicated
address space attribute.

The patch, applied as a follow-up to the series, survives allyesconfig
compilation with clang-19 and produces a bootable kernel. The patch
was tested only for x86_64 target, for other targets a couple of
trivial fixes would be necessary (a cast or a substitution of typeof()
with TYPEOF_UNQUAL()).

AFAICS, the same approach using clang's address_space attribute can be
implemented to also check other address spaces: __user, __iommu  and
__rcu.

Uros.

--00000000000069a3ca0628ed186b
Content-Type: text/plain; charset="US-ASCII"; name="percpu-clang.diff.txt"
Content-Disposition: attachment; filename="percpu-clang.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m4iomhgl0>
X-Attachment-Id: f_m4iomhgl0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvcGVyY3B1LmggYi9pbmNsdWRlL2FzbS1n
ZW5lcmljL3BlcmNwdS5oCmluZGV4IDAyYWVjYTIxNDc5YS4uNDEwOWQ4MjhhNTY0IDEwMDY0NAot
LS0gYS9pbmNsdWRlL2FzbS1nZW5lcmljL3BlcmNwdS5oCisrKyBiL2luY2x1ZGUvYXNtLWdlbmVy
aWMvcGVyY3B1LmgKQEAgLTE2LDcgKzE2LDEyIEBACiAgKiBzcGFjZSBxdWFsaWZpZXIpLgogICov
CiAjaWZuZGVmIF9fcGVyY3B1X3F1YWwKLSMgZGVmaW5lIF9fcGVyY3B1X3F1YWwKKyMgaWYgX19o
YXNfYXR0cmlidXRlKGFkZHJlc3Nfc3BhY2UpICYmIFwKKyAgICAgZGVmaW5lZChDT05GSUdfQ0Nf
SEFTX1RZUEVPRl9VTlFVQUwpICYmICFkZWZpbmVkKF9fQ0hFQ0tFUl9fKQorIyAgZGVmaW5lIF9f
cGVyY3B1X3F1YWwJCV9fYXR0cmlidXRlX18oKGFkZHJlc3Nfc3BhY2UoMykpKQorIyBlbHNlCisj
ICBkZWZpbmUgX19wZXJjcHVfcXVhbAorIyBlbmRpZgogI2VuZGlmCiAKICNpZmRlZiBDT05GSUdf
U01QCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RldmljZS5oIGIvaW5jbHVkZS9saW51eC9k
ZXZpY2UuaAppbmRleCA2NjdjYjZkYjkwMTkuLjFkNmE1NWQ1MjUwYSAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9saW51eC9kZXZpY2UuaAorKysgYi9pbmNsdWRlL2xpbnV4L2RldmljZS5oCkBAIC00MzEs
OSArNDMxLDkgQEAgc3RhdGljIGlubGluZSBpbnQgX19kZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQo
c3RydWN0IGRldmljZSAqZGV2LCB2b2lkICgqYWN0aW9uKSgKICAqIFJFVFVSTlM6CiAgKiBQb2lu
dGVyIHRvIGFsbG9jYXRlZCBtZW1vcnkgb24gc3VjY2VzcywgTlVMTCBvbiBmYWlsdXJlLgogICov
Ci0jZGVmaW5lIGRldm1fYWxsb2NfcGVyY3B1KGRldiwgdHlwZSkgICAgICBcCi0JKCh0eXBlb2Yo
dHlwZSkgX19wZXJjcHUgKilfX2Rldm1fYWxsb2NfcGVyY3B1KChkZXYpLCBzaXplb2YodHlwZSks
IFwKLQkJCQkJCSAgICAgIF9fYWxpZ25vZl9fKHR5cGUpKSkKKyNkZWZpbmUgZGV2bV9hbGxvY19w
ZXJjcHUoZGV2LCB0eXBlKQkJCQkgICAgXAorCSgoVFlQRU9GX1VOUVVBTCh0eXBlKSBfX3BlcmNw
dSAqKV9fZGV2bV9hbGxvY19wZXJjcHUoKGRldiksIFwKKwkJCQlzaXplb2YodHlwZSksIF9fYWxp
Z25vZl9fKHR5cGUpKSkKIAogdm9pZCBfX3BlcmNwdSAqX19kZXZtX2FsbG9jX3BlcmNwdShzdHJ1
Y3QgZGV2aWNlICpkZXYsIHNpemVfdCBzaXplLAogCQkJCSAgIHNpemVfdCBhbGlnbik7CmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3BlcmNwdS5oIGIvaW5jbHVkZS9saW51eC9wZXJjcHUuaApp
bmRleCA1MmI1ZWE2NjNiOWYuLmMzYmYwNDBhYmE2NiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51
eC9wZXJjcHUuaAorKysgYi9pbmNsdWRlL2xpbnV4L3BlcmNwdS5oCkBAIC0xNDgsMTMgKzE0OCwx
MyBAQCBleHRlcm4gdm9pZCBfX3BlcmNwdSAqcGNwdV9hbGxvY19ub3Byb2Yoc2l6ZV90IHNpemUs
IHNpemVfdCBhbGlnbiwgYm9vbCByZXNlcnZlZAogCWFsbG9jX2hvb2tzKHBjcHVfYWxsb2Nfbm9w
cm9mKF9zaXplLCBfYWxpZ24sIHRydWUsIEdGUF9LRVJORUwpKQogCiAjZGVmaW5lIGFsbG9jX3Bl
cmNwdV9nZnAodHlwZSwgZ2ZwKQkJCQkJXAotCSh0eXBlb2YodHlwZSkgX19wZXJjcHUgKilfX2Fs
bG9jX3BlcmNwdV9nZnAoc2l6ZW9mKHR5cGUpLAlcCisJKFRZUEVPRl9VTlFVQUwodHlwZSkgX19w
ZXJjcHUgKilfX2FsbG9jX3BlcmNwdV9nZnAoc2l6ZW9mKHR5cGUpLCBcCiAJCQkJCQlfX2FsaWdu
b2ZfXyh0eXBlKSwgZ2ZwKQogI2RlZmluZSBhbGxvY19wZXJjcHUodHlwZSkJCQkJCQlcCi0JKHR5
cGVvZih0eXBlKSBfX3BlcmNwdSAqKV9fYWxsb2NfcGVyY3B1KHNpemVvZih0eXBlKSwJCVwKKwko
VFlQRU9GX1VOUVVBTCh0eXBlKSBfX3BlcmNwdSAqKV9fYWxsb2NfcGVyY3B1KHNpemVvZih0eXBl
KSwJXAogCQkJCQkJX19hbGlnbm9mX18odHlwZSkpCiAjZGVmaW5lIGFsbG9jX3BlcmNwdV9ub3By
b2YodHlwZSkJCQkJCVwKLQkoKHR5cGVvZih0eXBlKSBfX3BlcmNwdSAqKXBjcHVfYWxsb2Nfbm9w
cm9mKHNpemVvZih0eXBlKSwJXAorCSgoVFlQRU9GX1VOUVVBTCh0eXBlKSBfX3BlcmNwdSAqKXBj
cHVfYWxsb2Nfbm9wcm9mKHNpemVvZih0eXBlKSwgXAogCQkJCQlfX2FsaWdub2ZfXyh0eXBlKSwg
ZmFsc2UsIEdGUF9LRVJORUwpKQogCiBleHRlcm4gdm9pZCBmcmVlX3BlcmNwdSh2b2lkIF9fcGVy
Y3B1ICpfX3BkYXRhKTsK
--00000000000069a3ca0628ed186b--

