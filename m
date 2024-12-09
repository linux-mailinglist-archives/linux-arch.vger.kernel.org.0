Return-Path: <linux-arch+bounces-9324-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743FA9E9680
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 14:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4269283D67
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 13:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14271ACEDF;
	Mon,  9 Dec 2024 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGWQniFT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B8427447;
	Mon,  9 Dec 2024 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749285; cv=none; b=GsF9mAGW/o9tleHOeEFCzOoyq4PMmvpTVKMxrCMfIRDXs0uL8qO9FjjQkSQ5t94UHWiCSx85YcLIKpDxjpinn7214Pcinkiw+YtkwRYqy5e3Fg+H2yZ6QzSsQLNO5RHrtZtD4Kyixgia8dH1MMRedPkwsJUjk6dtVoZvZqjwNQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749285; c=relaxed/simple;
	bh=q4xNiD+1h6n/gmqa9KIJktFHTf/n6lA09xO7+iOB9PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPEq2lCmSTaUBHMvgiQX+GnsAqnVswr9lpg6PccOkcyfXUQ7aZwRQ3eTdgdhH0YKaYAt+x8e0/bLl//0hDzgegYljfSD0PNUMR/ZFubXxFF4kRhRw+tcLx2QBiCS/OjJIHe0R8PUlgcjGX+8GPiAihm5I1nQlJOcM9gxTIYJZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGWQniFT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30229d5b1caso5114281fa.2;
        Mon, 09 Dec 2024 05:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733749282; x=1734354082; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q4xNiD+1h6n/gmqa9KIJktFHTf/n6lA09xO7+iOB9PY=;
        b=NGWQniFTDneahKVPWaKS09sj+98L/fOLtk4su397Z59FVyc0lTaOtAqUVyJuRBQieB
         o0i7axOKnTRr8XmSzwP+ylJqJZA2hQOQRyWndig5z2kecuwcVXKnC7XUR0FdIj3EA/MW
         dqbC6m89bhnm9RZpqsVcRTmIDjdeTvAm1DtsF5jpJwEjziaVCbWNBcU/eckG4We8xHQ3
         i7R1fPVOW0ZNXuWtTB7W5oZtoQDghnVZRpyPR1v4XRx/ufpP7qUdKejjzloXdy9ZJfiY
         ScXCXHxhEPME70lhRtHfBYQw5Y8xQkMbDGJ8AMyVhvtk7XxUWPDRW1rMk8FbL42WFiqx
         qFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749282; x=1734354082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4xNiD+1h6n/gmqa9KIJktFHTf/n6lA09xO7+iOB9PY=;
        b=L5dQ7fy6Syl5EuKgj2/EghNwd3sJhW6H8XxB1uEtQkTbp9+1/U0cu26e7rSsyK1/sd
         c88WzVAq6G1iDnSMLdRmN+BI/vmZwqesY6IzjASyoG4k1AEkLA7gpEyUtENCycuvC+8C
         Jv6Pf+W9b3jVc+7EMe5DMRXJOXmqY5SqnwXsM9Ik0+MJEWpzA20AjGBIB/2DwFVm/nGi
         e9g+Z8bj8MyrgZKl368wT4KSljPXnnNAhR8Q8HDdliOZvTATUeT5teZrTZC7B4KXm9Ru
         +vOY0NiO6CO+MdTxzQ9cOi9uUZ3ORngMIr/AV+545c/1uv0eWQwk0qR1MytWxa87Es1t
         WH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/6mYdtJxEqsv5WpVPSGwlVRWIfm6WowchS5ZYJBhC5bawBXfqqhu6b0oZErc2B3atg1PObr+BTEGZIvkK@vger.kernel.org, AJvYcCWBT7u1lC+mapOTw680aYu278xEItglVZSyfqCuImcAXkLwHmg2iB90alXfRroFa+U3KgDdRnD6KjO355D8fZw=@vger.kernel.org, AJvYcCWYYybbzt0sYGSF7X0mfC6ydrUotOnqLbpqj4iCNUZWYHmxY48J0ZP49mGUiwP6KUbX8iW1l30Jjr/s@vger.kernel.org, AJvYcCXvbxF0wp+lHkFYPLkYh6oMhl1MFgOmpiJ/UvGhB0mo6SuCN8+35v2Y5b4cGaPFQ8Zn2s/vceTo@vger.kernel.org
X-Gm-Message-State: AOJu0YySSirB2UCjNWo0wNsAlI3Cp2+QvwRX2wJuJaQxJLASX47UM4OA
	9HYbFP23XaaZ1e3sMDrQgZnBwR5O4Ov52h9jpuPSlnyaQPs76TBCKUZSIYOLysTUSWe61gpr18L
	Cj1H2Dwhbcg1YxQuklaZ+jURpGBaVlb/y0aU=
X-Gm-Gg: ASbGncvo8voOGJuelyy9zKv/RC5h1NwS/cuHjTILxdMW98iSyb7CPdKEeOb8RJiaXdW
	6uFY1PGEW11FudUj77l9AVVfEmTmboeE=
X-Google-Smtp-Source: AGHT+IGe1WstGRWqGSFuoCPDZFOtP3fDmU5Xj4kLOejwoz6WX1eM9hdJD2mx6/c+7+IVgAVWdxA8ME0SNhuOKo7Zq34=
X-Received: by 2002:a2e:bc05:0:b0:302:2bd8:2687 with SMTP id
 38308e7fff4ca-3022bd82cffmr6815311fa.12.1733749281481; Mon, 09 Dec 2024
 05:01:21 -0800 (PST)
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
Date: Mon, 9 Dec 2024 14:01:09 +0100
Message-ID: <CAFULd4YHuiyzuzAwuZxsp_kRca-hnR+NqHU8cfk8JDqATMNSMQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] compiler.h: Introduce TYPEOF_UNQUAL() macro
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-arch@vger.kernel.org, 
	netdev@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: multipart/mixed; boundary="0000000000000dce5f0628d5f635"

--0000000000000dce5f0628d5f635
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

Yes, the attached patch compiles and boots OK.

Uros.

--0000000000000dce5f0628d5f635
Content-Type: text/plain; charset="US-ASCII"; name="unqual_scalar_typeof.diff.txt"
Content-Disposition: attachment; filename="unqual_scalar_typeof.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m4h1jn2x0>
X-Attachment-Id: f_m4h1jn2x0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY29tcGlsZXJfdHlwZXMuaCBiL2luY2x1ZGUvbGlu
dXgvY29tcGlsZXJfdHlwZXMuaAppbmRleCA1ZDY1NDQ1NDU2NTguLjg3YTljZTNlYmQxMyAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9jb21waWxlcl90eXBlcy5oCisrKyBiL2luY2x1ZGUvbGlu
dXgvY29tcGlsZXJfdHlwZXMuaApAQCAtNDg2LDE1ICs0ODYsMTkgQEAgc3RydWN0IGZ0cmFjZV9s
aWtlbHlfZGF0YSB7CiAgKiBfX3VucXVhbF9zY2FsYXJfdHlwZW9mKHgpIC0gRGVjbGFyZSBhbiB1
bnF1YWxpZmllZCBzY2FsYXIgdHlwZSwgbGVhdmluZwogICoJCQkgICAgICAgbm9uLXNjYWxhciB0
eXBlcyB1bmNoYW5nZWQuCiAgKi8KKworI2lmIGRlZmluZWQoQ09ORklHX0NDX0hBU19UWVBFT0Zf
VU5RVUFMKSAmJiAhZGVmaW5lZChfX0NIRUNLRVJfXykKKyMgZGVmaW5lIF9fdW5xdWFsX3NjYWxh
cl90eXBlb2YoeCkgX190eXBlb2ZfdW5xdWFsX18oeCkKKyNlbHNlCiAvKgogICogUHJlZmVyIEMx
MSBfR2VuZXJpYyBmb3IgYmV0dGVyIGNvbXBpbGUtdGltZXMgYW5kIHNpbXBsZXIgY29kZS4gTm90
ZTogJ2NoYXInCiAgKiBpcyBub3QgdHlwZS1jb21wYXRpYmxlIHdpdGggJ3NpZ25lZCBjaGFyJywg
YW5kIHdlIGRlZmluZSBhIHNlcGFyYXRlIGNhc2UuCiAgKi8KLSNkZWZpbmUgX19zY2FsYXJfdHlw
ZV90b19leHByX2Nhc2VzKHR5cGUpCQkJCVwKKyAjZGVmaW5lIF9fc2NhbGFyX3R5cGVfdG9fZXhw
cl9jYXNlcyh0eXBlKQkJCQlcCiAJCXVuc2lnbmVkIHR5cGU6CSh1bnNpZ25lZCB0eXBlKTAsCQkJ
XAogCQlzaWduZWQgdHlwZToJKHNpZ25lZCB0eXBlKTAKIAotI2RlZmluZSBfX3VucXVhbF9zY2Fs
YXJfdHlwZW9mKHgpIHR5cGVvZigJCQkJXAorICNkZWZpbmUgX191bnF1YWxfc2NhbGFyX3R5cGVv
Zih4KSB0eXBlb2YoCQkJCVwKIAkJX0dlbmVyaWMoKHgpLAkJCQkJCVwKIAkJCSBjaGFyOgkoY2hh
cikwLAkJCQlcCiAJCQkgX19zY2FsYXJfdHlwZV90b19leHByX2Nhc2VzKGNoYXIpLAkJXApAQCAt
NTAzLDYgKzUwNyw3IEBAIHN0cnVjdCBmdHJhY2VfbGlrZWx5X2RhdGEgewogCQkJIF9fc2NhbGFy
X3R5cGVfdG9fZXhwcl9jYXNlcyhsb25nKSwJCVwKIAkJCSBfX3NjYWxhcl90eXBlX3RvX2V4cHJf
Y2FzZXMobG9uZyBsb25nKSwJXAogCQkJIGRlZmF1bHQ6ICh4KSkpCisjZW5kaWYKIAogLyogSXMg
dGhpcyB0eXBlIGEgbmF0aXZlIHdvcmQgc2l6ZSAtLSB1c2VmdWwgZm9yIGF0b21pYyBvcGVyYXRp
b25zICovCiAjZGVmaW5lIF9fbmF0aXZlX3dvcmQodCkgXAo=
--0000000000000dce5f0628d5f635--

