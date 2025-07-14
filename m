Return-Path: <linux-arch+bounces-12743-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2B3B041D1
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 16:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C981A63B65
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6036025A65A;
	Mon, 14 Jul 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N38RO0qr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE325A2DA;
	Mon, 14 Jul 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503695; cv=none; b=szK1OrzpHz3iwjxZueYyJF1tkILlTAVFXHFIP1nJz/fyzi8nL44do8yWFF60ixhIp06oy++tMKdTfSxDGZnu7s3N5vNwKWRLd+jCgdPRPlJsxiHea9YPakTQvtIZYEoXirzhn88Y+8mvDAeplYHkYujpNUwxbL2kLB5Fx0LMezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503695; c=relaxed/simple;
	bh=mF3qRqePN5gnZ8MStWoEp89ODWeu5IRb/uRaK7APojg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usQiUZi//U+8ven/hHC70b1SxYR3Acvce5Ra87qFyl26TXz/7157wubH7fWLceU6k6EpmZQ+XonPm5OQOzBycADBOKCYeepr2C02R36PSc79sSZVZeWGbMWtXnd5mMnJ+PJw5RBC+nqoa0l26BvHW0eUqlZebqaz73Zqfe6PdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N38RO0qr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31306794b30so702811a91.2;
        Mon, 14 Jul 2025 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752503693; x=1753108493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF3qRqePN5gnZ8MStWoEp89ODWeu5IRb/uRaK7APojg=;
        b=N38RO0qr5eBx+RVLL9cfu8KobtE9Wy1EfE3mER01ZzmhocdjJHwstiRFHaGg4MdreS
         QF7Jd7r9gsiwOeN96ZDHvBIXAJ4IQnoDp4aeav7aqA2cBIGoX+oJ15XviukgEJDsnDvf
         BwKRpEIQED7KSiWJHmZcR82gGC+waFARJuihVttJ9hBa4WhZAbdkAfFu8R6tpYrFqM0O
         UtN9SxjFSn849g6zRLRSxeQ8qb+MdVP7SZQSQ62H0V7cyBg+h+dQwZMEbrWrYm5S9ArJ
         vbJgTuAi3CNmUgrDwH0hma+sEO15QwOJz3/3fNV3vTDG9ZELHHa9oqCQPeLZAzXVDqSv
         aTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503693; x=1753108493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mF3qRqePN5gnZ8MStWoEp89ODWeu5IRb/uRaK7APojg=;
        b=thTcKzjUTVMD79WZWvHjm6I42Ap2WvdwMGp1giGvJIraWwP0awyPdMcfm+urzuJCOm
         Er0bVwOhsuALu2Vx6kzJfUpOfu+Y0rDBetqjTQ6j3qqOoGVhZImysmgowxRImEvwo3yl
         365aLuUXCovo53CVZN33HCWhVh2E+sEM7eW6KahWo+k6EDEKF52X8U7SSxUuMuN9TN9j
         OepBaUqHyOVeSXry7Y4zuxO7NMoH16jbehRuLdIsstJCk6CzT1Jge8iYGr7GjyJy+OZK
         GmUMCkxkXi4ja8RZwpuVAWyx30ZrFgmS2aRVJJqIzDxfeJNFThgyqpgPYptlieu6KZ1Z
         ajAg==
X-Forwarded-Encrypted: i=1; AJvYcCVoi1zc015z/q2H6rp0YK2dGhLYrEjs6IYD5vaCRelQgPTQ/k6Ocv9Dh+yjFpemAkKyeSkCFRdHcc0ZqrPc@vger.kernel.org, AJvYcCWqCi+TnpK7OS4aPPgGBVMsZrCEUnEwNNEWJKjgqyc/Lvmr1t7mz3gAl5y9nN5wKRSuYF1zDyGmAfFx@vger.kernel.org, AJvYcCXwQBXrlXn1ajChwU6JeI4tbsSWlCTvujJSuEq0E222IrQEnofGbQy15sM1PlrQ+hkUzVMAyq3tHPdEIytht9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWANBgrYsmD6Q/yhHBbIVVnYQbemHo6oA6R7VYf/Tq+f4QPzbz
	WFxselPcwdT71vu8vd2dkdOClRdsY5sb8EE/v09YrwXPKGN4PxQKDCTCyEQwqoVTTi84DDRM1Om
	hWdC6QNRaqLEiuRaqp6PtYooRgQV2lPQ=
X-Gm-Gg: ASbGncvj9nWC/x652j8y9+/8WyKhmAyGh0x9neJK11bz+IVMQ0rZ0RqRkSSfAwvL3lw
	P6C9c1B9tOS6q4NkV+mhG80T3QKlSHg8NjDgh8XYi+VqSlF/M1s8doZWMMXpsTLi+pxYA8Lcoq0
	3ax4JmYNnNCBIsKLsfiuKmU84WNAoMelAMiUy4Y9z9RbUjlkd1hxQdMs44ri7dGVi+ekMFjpqVq
	QXUcFSn
X-Google-Smtp-Source: AGHT+IFoHk5jjWFWj2oU0bOYyeJP/eIsZ9IWh9rMq8AQzMClOPCmhJDbvXOLbquXElXUXPlBEPNn4yN7x8jDS3qcJEU=
X-Received: by 2002:a17:90a:d407:b0:311:9c9a:58e8 with SMTP id
 98e67ed59e1d1-31c4f568682mr6380610a91.7.1752503692830; Mon, 14 Jul 2025
 07:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714053656.66712-1-boqun.feng@gmail.com> <20250714053656.66712-5-boqun.feng@gmail.com>
 <DBBPI9ZJVO64.3A83G118BMVLI@kernel.org> <aHUSgXW9A6LzjBIS@Mac.home>
In-Reply-To: <aHUSgXW9A6LzjBIS@Mac.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Jul 2025 16:34:39 +0200
X-Gm-Features: Ac12FXxkgaL6r2gvTrv2PgM8CpWlTlMhBK68CPg5GyVvkjv7u-DyRww_DjHEeO8
Message-ID: <CANiq72mFa0bM_DZV2tHViU0SKqNG_tX6AxBWz4AQ=2UmBrt=nQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] rust: sync: atomic: Add generic atomics
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
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
	Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 4:22=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Hmm.. why? This is the further information about what the above
> "Examples" section just mentioned?

I think Benno may be trying to point out is may be confusing what
"this" may be referring to, i.e. is it referring to something concrete
about the example, or about `from_ptr` as a whole / in all cases?

Cheers,
Miguel

