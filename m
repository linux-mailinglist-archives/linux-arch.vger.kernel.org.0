Return-Path: <linux-arch+bounces-12665-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F2B01E6D
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 15:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B117BB610
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B639B2882B6;
	Fri, 11 Jul 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c84Cy64R"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7592AD21;
	Fri, 11 Jul 2025 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241547; cv=none; b=f1Rc5L3IKM1EQa9Y4sWkz6vDTh1s3ccJKIXfJOchDT/O9jisW2KSCfwYk3SA+fRM3BaNgQTKao3WdzQckYZx/IkCzAWlpZGbMRqhkLx/icDkTXA66UNmBa7BilABGfF0WuD4JJgR7JCcUu7t4zlDVcOd0UaUmeBxIbBV+dvUNkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241547; c=relaxed/simple;
	bh=3jTI8lmVPJdNIpsEXo25Ia6BaFfUuorZSAB0PZFfdNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALnYVqT18aXiH2WUiMXIDpPeiXF4hRZpQSUeNCyjVq09Vtl1rHrd/yA4YjsJ41dpV5/IbUlNBtl28P2hSTqmdstYryIApSLcCm7ZtErhMX+rGHDuJMqueQVzeDMee5k0j+iFcN7FM5mQX4fdhJ2Tptg6iOWYoNSYwYICY+a1fAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c84Cy64R; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234ae2bf851so4102465ad.1;
        Fri, 11 Jul 2025 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752241545; x=1752846345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cqaeziKytPI8w8vAt41vJYQ/P2vPeYWtQ7a6fagfqLI=;
        b=c84Cy64RLdlTeAG40KtYfJ2tfYnUlOOUyLItyLSzl74QcbZ3ZYsIFMzzB1H+sI9JOn
         dinFqSykJy8Ar7F7oHuuB46ici5zcD6IpAE5teQLn2yzS0GSnZeZWpG7SeZMVFFIKmfg
         Zf2fD2k1KpUYQby3+ZrY8TeaXH8xD03Q+XtrgmUw12Wex7OOKx6sKF6p+/dw8EHmbfU3
         6lULuz8Bc5D030nctdPdRhJh+0P/kwImEtuTrIQ7qnfc2JoFo+IpIr4P+F663AsnrQ95
         nXJaHwpIGJh95mUmbHv9OBL0sJf10ZdLHMLqnKPH4sRZA7esonKUKeOuSSvsDcPvTnkj
         uJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241545; x=1752846345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqaeziKytPI8w8vAt41vJYQ/P2vPeYWtQ7a6fagfqLI=;
        b=u+4vl+pcEYqvkCpX6e5wdxQyD818SehrmvGTJIMPf1q2a9rx8bUVh3tsq6PuLR5XbQ
         3JRZ/ESehpum5xvyPRWkDpRT/JjS7gtFZD1R9KLJZ9hLYK9wpMf0rsDMpQeatemNlxwc
         79vxZRy4lSAToFE6d/90nGFytyAVTz/33yFxhpyYHD7EA8/EdCDahmzMaEWQWQSJ84JJ
         TGvs497DmeQclTh10ecjOrLCgDziGoVsvxinLbXg0ixivdJdk7uPF8j5hIwH137M/e9g
         WdIGycf1Wn/69YQNnA5lHJM5HhUKeEkzS2JQSVKoNzQnR8O/2qfBtTGmBv2g8JqcKAnE
         Edpw==
X-Forwarded-Encrypted: i=1; AJvYcCVhvKDtztpJYkS7YQWiPmuEEugx3PCCyb/NehROuXp1gqrGI8xgw31tXgkX5Z39FTMpKKDGZ5+n1cH+@vger.kernel.org, AJvYcCXUw3ZeIt1z7rN6wokEiap0C+pB0lqtkJw94dgsI6hbX5PcRzRdlGB2eqcjbIcDCRBIs1q3/CS5RzvHCT94d7M=@vger.kernel.org, AJvYcCXu6v7rRX1rQk10agMyR6uN8dkl3jXqliS/4ifwZX2qB6OJgqVHFEfh2hGjDD91kkgq4to1+YGKq1jWJKBz@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxLBGQ3D0mjRYMJnSij0pgcUGB2uGVFQb8STrK9izgsNzGJpy
	VI04BQLqLbtro/t5sKdDH2UzV4Dbme5E4mT0f0iIKu5VWVuCSXuLBxcJFI4Y5VSpIpsWmuGROOJ
	TGdX7XFHLv48OK/oevRxBFImbPxJo9VI=
X-Gm-Gg: ASbGnctwqMtqu+NzmYUSByf0wNOX1yOn8+sFKA4E0supsWy0k5dcbZ+rCPPLySqenQq
	CcCzr8Tp6KshnnlNao/n8rGn0DaHST8lDKTgrhtwg3FFdXgphqNWKxE5yNMvPlwUPQoMon4xJE1
	HrcMgCTD5wbdSBWriid7wgflG2PZHaXoy3pCMou8TIQAtMwued9+peAfv4rh6DksghU263nNcNC
	myIYpOn
X-Google-Smtp-Source: AGHT+IFV5Q6XDMeNyxbrDaCqcTK/9CG4eq2MIFX5PPvQTMRtWGgXyj0wXcXbQyG2lvhVf12L4lT6ldVNfl1A8tpHFxU=
X-Received: by 2002:a17:902:e742:b0:234:bfe3:c4a3 with SMTP id
 d9443c01a7336-23def6f8af8mr14692945ad.0.1752241545448; Fri, 11 Jul 2025
 06:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710060052.11955-1-boqun.feng@gmail.com> <20250710060052.11955-10-boqun.feng@gmail.com>
 <DB93Q0CXTA0G.37LQP5VCP9IGP@kernel.org>
In-Reply-To: <DB93Q0CXTA0G.37LQP5VCP9IGP@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 11 Jul 2025 15:45:32 +0200
X-Gm-Features: Ac12FXyFrHk4Z1-8N4fJ4rpIjk16rCRk0lkV3gm2SvE-JFQCE4Eus7CzluwDG1Q
Message-ID: <CANiq72m9AeqFKHrRniQ5Nr9vPv2MmUMHFTuuj5ydmqo+OYn60A@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] rust: sync: atomic: Add Atomic<{usize,isize}>
To: Benno Lossin <lossin@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev, 
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
	Mitchell Levy <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: multipart/mixed; boundary="000000000000e0c02e0639a78652"

--000000000000e0c02e0639a78652
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 11:00=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>
> Do we have a static assert with these cfgs that `isize` has the same
> size as these?
>
> If not, then it would probably make sense to add them now.

Yeah, according to e.g. Matthew et al., we may end up with 128-bit
pointers in the kernel fairly soon (e.g. a decade):

    https://lwn.net/Articles/908026/

I rescued part of what I wrote in the old `mod assumptions` which I
never got to send back then -- most of the `static_asserts` are
redundant now that we define directly the types in the `ffi` crate (I
mean, we could still assert that `size_of::<c_char>() =3D=3D 1` and so on,
but they are essentially a tautology now), so I adapted the comments.
Please see below (draft).

Cheers,
Miguel

--000000000000e0c02e0639a78652
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-rust-ffi-assert-sizes-and-clarify-128-bit-situation.patch"
Content-Disposition: attachment; 
	filename="0001-rust-ffi-assert-sizes-and-clarify-128-bit-situation.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mcyv696x0>
X-Attachment-Id: f_mcyv696x0

RnJvbSBhZmQ1OGYzODA4YmQ0MWNmYjkyYmYxYWNkZjJhMTkwODFhNDM5Y2EzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWd1ZWwgT2plZGEgPG9qZWRhQGtlcm5lbC5vcmc+CkRhdGU6
IEZyaSwgMTEgSnVsIDIwMjUgMTU6Mjc6MjcgKzAyMDAKU3ViamVjdDogW1BBVENIXSBydXN0OiBm
Zmk6IGFzc2VydCBzaXplcyBhbmQgY2xhcmlmeSAxMjgtYml0IHNpdHVhdGlvbgoKTGluazogaHR0
cHM6Ly9sd24ubmV0L0FydGljbGVzLzkwODAyNi8KU2lnbmVkLW9mZi1ieTogTWlndWVsIE9qZWRh
IDxvamVkYUBrZXJuZWwub3JnPgotLS0KIHJ1c3QvZmZpLnJzIHwgMzIgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvcnVzdC9mZmkucnMgYi9ydXN0L2ZmaS5ycwppbmRleCBkNjBhYWQ3OTJhZjQuLmJi
ZGE1NmMyOGNhOCAxMDA2NDQKLS0tIGEvcnVzdC9mZmkucnMKKysrIGIvcnVzdC9mZmkucnMKQEAg
LTM4LDExICszOCw0MyBAQCBtYWNyb19ydWxlcyEgYWxpYXMgewogCiAgICAgLy8gSW4gdGhlIGtl
cm5lbCwgYGludHB0cl90YCBpcyBkZWZpbmVkIHRvIGJlIGBsb25nYCBpbiBhbGwgcGxhdGZvcm1z
LCBzbyB3ZSBjYW4gbWFwIHRoZSB0eXBlIHRvCiAgICAgLy8gYGlzaXplYC4KKyAgICAvLworICAg
IC8vIEl0IGlzIGxpa2VseSB0aGF0IHRoZSBhc3N1bXB0aW9uIHRoYXQgYGxvbmdgIGlzIHRoZSBz
aXplIG9mIGEgQ1BVIHJlZ2lzdGVyL3BvaW50ZXIgd2lsbCBzdGF5CisgICAgLy8gd2hlbiBzdXBw
b3J0IGZvciAxMjgtYml0IGFyY2hpdGVjdHVyZXMgaXMgYWRkZWQsIHRodXMgdGhlc2Ugd2lsbCBz
dGlsbCBtYXBwZWQgdG8gYHtpLHV9c2l6ZWAuCiAgICAgY19sb25nID0gaXNpemU7CiAgICAgY191
bG9uZyA9IHVzaXplOwogCisgICAgLy8gU2luY2UgYGxvbmdgIHdpbGwgbGlrZWx5IGJlIDEyOC1i
aXQgZm9yIDEyOC1iaXQgYXJjaGl0ZWN0dXJlcywgYGxvbmcgbG9uZ2Agd2lsbCBsaWtlbHkgYmUK
KyAgICAvLyBpbmNyZWFzZWQuIFRodXMgdGhlc2UgbWF5IGhhcHBlbiB0byBiZSBlaXRoZXIgNjQt
Yml0IG9yIDEyOC1iaXQgaW4gdGhlIGZ1dHVyZSwgYW5kIHRodXMgbmV3CisgICAgLy8gY29kZSBz
aG91bGQgYXZvaWQgcmVseWluZyBvbiB0aGVtIGJlaW5nIDY0LWJpdC4KICAgICBjX2xvbmdsb25n
ID0gaTY0OwogICAgIGNfdWxvbmdsb25nID0gdTY0OwogfQogCisvLyBUaHVzLCBgbG9uZ2AgbWF5
IGJlIDMyLWJpdCwgNjQtYml0IG9yIDEyOC1iaXQuCitjb25zdCBfOiAoKSA9IHsKKyAgICBhc3Nl
cnQhKAorICAgICAgICBjb3JlOjptZW06OnNpemVfb2Y6OjxjX2xvbmc+KCkKKyAgICAgICAgICAg
ID09IGlmIGNmZyEoQ09ORklHXzEyOEJJVCkgeworICAgICAgICAgICAgICAgIGNvcmU6Om1lbTo6
c2l6ZV9vZjo6PHUxMjg+KCkKKyAgICAgICAgICAgIH0gZWxzZSBpZiBjZmchKENPTkZJR182NEJJ
VCkgeworICAgICAgICAgICAgICAgIGNvcmU6Om1lbTo6c2l6ZV9vZjo6PHU2ND4oKQorICAgICAg
ICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAgICAgICBjb3JlOjptZW06OnNpemVfb2Y6Ojx1MzI+
KCkKKyAgICAgICAgICAgIH0KKyAgICApOworfTsKKworLy8gQW5kIGBsb25nIGxvbmdgIG1heSBi
ZSA2NC1iaXQgb3IgMTI4LWJpdC4KK2NvbnN0IF86ICgpID0geworICAgIGFzc2VydCEoCisgICAg
ICAgIGNvcmU6Om1lbTo6c2l6ZV9vZjo6PGNfbG9uZ2xvbmc+KCkKKyAgICAgICAgICAgID09IGlm
IGNmZyEoQ09ORklHXzY0QklUKSB7CisgICAgICAgICAgICAgICAgY29yZTo6bWVtOjpzaXplX29m
Ojo8dTY0PigpCisgICAgICAgICAgICB9IGVsc2UgeworICAgICAgICAgICAgICAgIGNvcmU6Om1l
bTo6c2l6ZV9vZjo6PHUxMjg+KCkKKyAgICAgICAgICAgIH0KKyAgICApOworfTsKKwogcHViIHVz
ZSBjb3JlOjpmZmk6OmNfdm9pZDsKCmJhc2UtY29tbWl0OiBkN2I4ZjhlMjA4MTNmMDE3OWQ4ZWY1
MTk1NDFhMzUyN2U3NjYxZDNhCi0tIAoyLjUwLjEKCg==
--000000000000e0c02e0639a78652--

