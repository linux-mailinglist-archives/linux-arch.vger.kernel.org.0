Return-Path: <linux-arch+bounces-12412-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3762EAE17AB
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 11:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDF11BC1E2F
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905E8280A5A;
	Fri, 20 Jun 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMN4bv7t"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4E30E830;
	Fri, 20 Jun 2025 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412209; cv=none; b=tzpTXzpFblchAymAaleAPua75LM3kNRMgxc2ybwFx84gZVS8LXNdQsUHLYlxK2yPkdp89oK9lIr8e4ixCG7cjKDXj8qxHmygRchs8VFP4XWAuZfhclGdEDg2yrDsfcFjoLQayk8XxIlm4FrJHTOsM3KrmWuXShZ/mOAoFyOGkTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412209; c=relaxed/simple;
	bh=FuOrTJYV1TyVcLzYLdvi5tZy8xh4xKDKJ3Sg9dm0nak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D42stPzP0svUK7UhH8kXeV4qT95j4xcWD87nBGtqeOtFdcf6tVtV4G6aKNn/QAsA0UsAxvAZ1j3ABq5/3NkUta7bJy3EYTY/zs2FSU6GLKHKo8SVJziwJI07IpghSgpryUvCXelNf72qpH6zDcaIgaQKo8jLhJ+SHJiNFxjfldY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMN4bv7t; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313756c602fso191936a91.3;
        Fri, 20 Jun 2025 02:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750412207; x=1751017007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7wAC0jk/TixklVdDrxl3rlcFerlxjtSOFBZZ7j6Irus=;
        b=cMN4bv7t+5rVYjFw7OZsb2eZTSC+jM6CHW6rpC8caT9yCSiqlNpZmsBH1633AftZzf
         fVrEIpflJGMUAP5J66im8JMuCd1adHjhot6JovoxDCtUu5fRXe9LKE6gDfST96THHS+V
         +oZxRejPW6RKsQlTvD2vlvrPurdc3fghFXgq0Fp+4A/jYBqcav85FF2MSZ/SF1fViUtw
         iooxfrbu873NQ9RDxYtlv5cog3unYD0R0KT4MTpi/4DHEkPDhT4J6xYPqTm78/tYNHVL
         u+9YPAALMCYuRhcYAJHMfZ85RNt3rQZCOKq+ZJsmSiSsFjeuIcduJvHrzlqDPYKNp0D7
         g5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750412207; x=1751017007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wAC0jk/TixklVdDrxl3rlcFerlxjtSOFBZZ7j6Irus=;
        b=L6tz3xVmC1S4jq0ED42nNjLzim04/nZ/9H0SRwd5P3zjywDSBQ+Zto7mX+xe8Be3+m
         2e/GlSGLXu0DvLxs+tRMwGyo5ZwWFYGmc4Xe++4op93+8qAeFrwQkSG2I6/kQ1kQqV8Z
         BZKd4IEOQpg+OnlzQAWyxioiN7ZWhvscobZOnrbVxoexS8G+2mExf/VvtNMaEA+LMk74
         XRUhrRrC3xK+wjcmN28RvHClQSSGhX6WrJU27L34Yba7Lvu8HoAdjv3V2Uzv/WYwuoh6
         O7hA5APswF+OLf2nkECssJ7f1oY05HALnDWA8+cz24eOLYKWiXi1231bWOJ7YvGN+fXf
         eHug==
X-Forwarded-Encrypted: i=1; AJvYcCU3BYNNcxpnjhrMHGXNE39gyKLpTXHN8NWiRSVXc/fUWI6U8thF1StUcb1g4UbLPwn75F5rlEzP5A4E@vger.kernel.org, AJvYcCV8qKTv7deT3ZMhsJgchIi5gr8yguIZuRn7agEWPUbg7CL3zx58oBzEChTmmrHeUChdl4hYuUlbPco1xUia7B0=@vger.kernel.org, AJvYcCWFvXJwhdnr2Mp/YLczGjAnRek2leKtb59z5RFEi/hHapB9iXp/AT6EUyB2mI2FdJEXuJvF2t4f251noeKg@vger.kernel.org, AJvYcCXvYFskQ6EdM2W6V4Bs7JbPvYqLdvh/cYEAortDwF1u3sDKE2ORGIFPeR3kgBRdzL/3Vck2D+LmCbpGO7ZaPrjm@vger.kernel.org
X-Gm-Message-State: AOJu0YxSdSynAQPSsHxIBuQNHixNksCaKemVcMH/L8pAFpcxnNQSNMIJ
	joNgzvjuHqsCkKRQfySMSzHQtEjSZbBkH+UQKaUjpObVMuml73tUQSO6PjyO8gjGsCnUfLtrO7n
	vMycdrFKg/kPEg2iqaxjERYH/1IGUJ44=
X-Gm-Gg: ASbGncumSk6tV7JcmqQJ9q7/DM+GgKejM7Mlfi/eEWS5pi3nKKVelJ1oSmOWD65nmNB
	FK21jXIQgR09/gHQzC6h8EFcmrXLWUJpLLc638d4BwrpeHce9H3gcax5CvKwJd2kwM2USlj9ukn
	p0KKoN+6aYRZrL/11JrqAqW7l3dptGLeKaeipClEYunQ==
X-Google-Smtp-Source: AGHT+IErmtjg+qV/f7L/+kcv6/HmRz1EzHIDT7AGQ80FANhBmxuvff1/k1x66DZEdVanCBXpBXa0VvV+WwWlLoI0aMc=
X-Received: by 2002:a17:90b:2dc8:b0:313:2f9a:13c0 with SMTP id
 98e67ed59e1d1-3159d628b10mr1572415a91.1.1750412207139; Fri, 20 Jun 2025
 02:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619-rust-panic-v1-1-ad1a803962e5@google.com> <CANiq72=ORd8Y=BiMCWEN7sdjLTGrepnLd58AObVHEPcZE_NVAg@mail.gmail.com>
In-Reply-To: <CANiq72=ORd8Y=BiMCWEN7sdjLTGrepnLd58AObVHEPcZE_NVAg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Jun 2025 11:36:34 +0200
X-Gm-Features: Ac12FXwWRyOtO7_L2Yxf7CvhqMQMdmMs9HlEkDMLDzUlEEnWHFKhBuDi7KW2WNU
Message-ID: <CANiq72nVJ4wL0eWY1C40hqYaOXuLjLFJZePjMh=n1YzZXCTPrw@mail.gmail.com>
Subject: Re: [PATCH] panic: improve panic output from Rust panics
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d156250637fd99bc"

--000000000000d156250637fd99bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 6:10=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Yeah, I don't think we should do that.

By the way, if we are OK with just moving the line down, then we could
keep using `BUG()` taking advantage of `BUGFLAG_NO_CUT_HERE`.

Well, at least for x86 it seems straightforward -- see diff -- to get
output like e.g.:

    [    0.609779] ------------[ cut here ]------------
    [    0.609855] rust_kernel: panicked at samples/rust/rust_minimal.rs:29=
:9:
    [    0.609855] my Rust panic message
    [    0.610474] kernel BUG at rust/helpers/bug.c:7!
    [    0.610992] Oops: invalid opcode: 0000 [#1] SMP NOPTI

Cheers,
Miguel

--000000000000d156250637fd99bc
Content-Type: text/x-patch; charset="US-ASCII"; name="bug_rust.patch"
Content-Disposition: attachment; filename="bug_rust.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mc4ly27b0>
X-Attachment-Id: f_mc4ly27b0

RnJvbSAyNWYzMDNkNDM4MWQzYjU4YzBlMDhmNmNmNTI0MzU3NTA5ZDkzNmJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWd1ZWwgT2plZGEgPG9qZWRhQGtlcm5lbC5vcmc+CkRhdGU6
IFRodSwgMTkgSnVuIDIwMjUgMTg6NDM6NTIgKzAyMDAKU3ViamVjdDogW1BBVENIXSAuLi4KCi0t
LQogYXJjaC94ODYvaW5jbHVkZS9hc20vYnVnLmggfCA3ICsrKysrLS0KIHJ1c3QvaGVscGVycy9i
dWcuYyAgICAgICAgIHwgMiArLQogcnVzdC9rZXJuZWwvbGliLnJzICAgICAgICAgfCAzICsrKwog
MyBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vYnVnLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9i
dWcuaAppbmRleCBmMGU5YWNmNzI1NDcuLjFkODYyZTE2ODQ5YiAxMDA2NDQKLS0tIGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vYnVnLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vYnVnLmgKQEAg
LTc5LDEyICs3OSwxNSBAQCBkbyB7CQkJCQkJCQkJXAogI2VuZGlmIC8qIENPTkZJR19HRU5FUklD
X0JVRyAqLwoKICNkZWZpbmUgSEFWRV9BUkNIX0JVRwotI2RlZmluZSBCVUcoKQkJCQkJCQlcCisj
ZGVmaW5lIEJVR19GTEFHUyhmbGFncykJCQkJCVwKIGRvIHsJCQkJCQkJCVwKIAlpbnN0cnVtZW50
YXRpb25fYmVnaW4oKTsJCQkJXAotCV9CVUdfRkxBR1MoQVNNX1VEMiwgMCwgIiIpOwkJCQlcCisJ
X0JVR19GTEFHUyhBU01fVUQyLCBmbGFncywgIiIpOwkJCQlcCiAJX19idWlsdGluX3VucmVhY2hh
YmxlKCk7CQkJCVwKIH0gd2hpbGUgKDApCisjZGVmaW5lIEJVRygpIEJVR19GTEFHUygwKQorI2Rl
ZmluZSBCVUdfUlVTVCgpIEJVR19GTEFHUyhCVUdGTEFHX05PX0NVVF9IRVJFKQorCgogLyoKICAq
IFRoaXMgaW5zdHJ1bWVudGF0aW9uX2JlZ2luKCkgaXMgc3RyaWN0bHkgc3BlYWtpbmcgaW5jb3Jy
ZWN0OyBidXQgaXQKZGlmZiAtLWdpdCBhL3J1c3QvaGVscGVycy9idWcuYyBiL3J1c3QvaGVscGVy
cy9idWcuYwppbmRleCBlMmQxM2JhYmM3MzcuLmVmOWJlNmEwYzU5YiAxMDA2NDQKLS0tIGEvcnVz
dC9oZWxwZXJzL2J1Zy5jCisrKyBiL3J1c3QvaGVscGVycy9idWcuYwpAQCAtNCw1ICs0LDUgQEAK
CiBfX25vcmV0dXJuIHZvaWQgcnVzdF9oZWxwZXJfQlVHKHZvaWQpCiB7Ci0JQlVHKCk7CisJQlVH
X1JVU1QoKTsKIH0KZGlmZiAtLWdpdCBhL3J1c3Qva2VybmVsL2xpYi5ycyBiL3J1c3Qva2VybmVs
L2xpYi5ycwppbmRleCA2YjQ3NzRiMmIxYzMuLmM1ZTJhYjVkYTczOSAxMDA2NDQKLS0tIGEvcnVz
dC9rZXJuZWwvbGliLnJzCisrKyBiL3J1c3Qva2VybmVsL2xpYi5ycwpAQCAtMTk3LDYgKzE5Nyw5
IEBAIHB1YiBjb25zdCBmbiBhc19wdHIoJnNlbGYpIC0+ICptdXQgYmluZGluZ3M6Om1vZHVsZSB7
CiAjW2NmZyhub3QoYW55KHRlc3RsaWIsIHRlc3QpKSldCiAjW3BhbmljX2hhbmRsZXJdCiBmbiBw
YW5pYyhpbmZvOiAmY29yZTo6cGFuaWM6OlBhbmljSW5mbzwnXz4pIC0+ICEgeworICAgIHVuc2Fm
ZSB7CisgICAgICAgIGJpbmRpbmdzOjpfcHJpbnRrKHN0cjo6Q1N0cjo6ZnJvbV9ieXRlc193aXRo
X251bF91bmNoZWNrZWQoYmluZGluZ3M6OkNVVF9IRVJFKS5hc19wdHIoKSk7CisgICAgfQogICAg
IHByX2VtZXJnISgie31cbiIsIGluZm8pOwogICAgIC8vIFNBRkVUWTogRkZJIGNhbGwuCiAgICAg
dW5zYWZlIHsgYmluZGluZ3M6OkJVRygpIH07CgpiYXNlLWNvbW1pdDogZTA0Yzc4ZDg2YTk2OTlk
MTM2OTEwY2ZjMGJkY2YwMTA4N2UzMjY3ZQotLQoyLjUwLjAK
--000000000000d156250637fd99bc--

