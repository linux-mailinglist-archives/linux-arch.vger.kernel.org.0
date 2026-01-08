Return-Path: <linux-arch+bounces-15703-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FF3D010D4
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 06:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B30A3002849
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 05:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DFB299937;
	Thu,  8 Jan 2026 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOJdckbg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F16254841
	for <linux-arch@vger.kernel.org>; Thu,  8 Jan 2026 05:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767849474; cv=none; b=k7t1LhreP7/zA84PdfgyMLzhWjlpTHEZtSXfyHiv5gcTVa8mhYQBouSm7BQJ6fL3dfMVs+DsWIFpHcmQoL1yTX1G2f4DNCJlvJH7vqxTw/iQGzyG4lm+rbxwmO+oKIQURfd5IGQoswOa3D3Rd4Cu0Yu1PSwQ8LaL1QX2inYkkE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767849474; c=relaxed/simple;
	bh=zfaWPieax6RU5tc9kXenF3uSle8+R4n2eeM43ti+8dc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kUjDnA9ybJK7VZiVpcsiofPtSReMihqKdo41NL3u4/XiDnGHM1QT60e4DGlfICYY4TSXmZX7NCQK/KYifVEYY/huD2dr+l9twjuZdrR0L9AsqqbJuY4PGAvvlqhdgSf1EkafuSRJ7mEymhUBG+i6GhETDoVxaac3QQXPFDZjG2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOJdckbg; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c565b888dso2441343a91.0
        for <linux-arch@vger.kernel.org>; Wed, 07 Jan 2026 21:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767849473; x=1768454273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfaWPieax6RU5tc9kXenF3uSle8+R4n2eeM43ti+8dc=;
        b=GOJdckbgrwovKu7QZNYc45CZO4h6dYiJi114Kprv+6KXmPvzH120ej0WhvDOcpqRjh
         0CCoaJat85cMi2kv18bCY/QRGmuPQkslQvCJ9lhrU2sXaribDk1uaKw5z6nr6q0sE6Pm
         YpVZcjiBnEVOt8BDMGgmZm9S44YUuMUoW2UyT8DQj2u19QgQrLHAGa6N4Wv7c05P7maN
         XZwqOp+hIVAmbxx78q9G/UaG1um8dhbBPVYeU2LHwoaM3Z5EG5hjtadgNzRy3NHNm+2T
         JrwDgcF7hzMkzXpKGYsMS8tigBz/I/wRolHo5oZZvcXJL1lPmu1QbTucVlOa1hl9A9yC
         qnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767849473; x=1768454273;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfaWPieax6RU5tc9kXenF3uSle8+R4n2eeM43ti+8dc=;
        b=WO52gn6EJ+LG5GRq1gFl99pfGTcyO8GajAJ/PqFPb1DK5hIHnYIXD2DZ6+x7lhxsg4
         IC81s4qlb4uKvRGREybHpJWGPA2GnSeUkmA/UeE2PwAxi3RcC5TV3Nm+tIYkTxU1aqg4
         WPabOiB1vViKqxfzkM4+xVkDnIVCaDW5q31hQ21cNOWS44zbuhfpIoytxs8AcrRHxFFz
         j0AXpMqiqSZ74mYZN3BfCKEwGOnazmWoi70luNEA4cEBx3/aZTil/bKAZn2glxSCB2L/
         aryyPfXW6cjoMY81L8/BZpHImzcRHLDgLVJEcBble7cOAkdOvwYwdKTeI5JgeEV1vLIN
         mC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeEbCMk1zzR7+hbFl6BBlFUMFXGOyyzLNR96CBOCBb7Y2AO2/waJenLRu3RcRrJjABH2ZE7fL0/kg2@vger.kernel.org
X-Gm-Message-State: AOJu0YzdE1VV4l6t2rUi/MXQ4hrHdY1JidSY15PXCu/g58e70DzUViYE
	MljKXFWRHyYq6JuOltFpveOtRprkppqprnIIPI1czxYZFiGni9E/B7lp
X-Gm-Gg: AY/fxX7gvCuikRbpoOVXJYekPdkZStsno1MuQYtAi3GAlx7FTu0UM0Oe0Qsm+HbPQQV
	ZALOCK+WHiPUi3WBC3Sy7QaMQm/OazAQ+mgpPlyN8BVtQl6xeXIagJH0lzsXpoyhrF0oXZOV/+G
	+u8XOTfo3BLC5zvewBUFPX/uDwjqDOpGafFRhviRL3YCLI6/owNpdRuyhfhgMP8D4aL7hKRVIYF
	8VkeHySed/yBgNZA6rMVi7WZeEceQ3EdMBvLeVjfsSq2IWPrUdgC99WmvniH36sE4vsXclVqCul
	TDCbubQsuUusL9v6pnx5HCPiJC4wIn+CcWtBYTG9XztsUcnTG7PKAw6PrAi17Kz9DykikyMg3wq
	Axes6+eHe6xfuJTorh5EdK3D5z2JXqOnQU/B1R/TUSzkRcBOogqlWnLkNUabV/p1mAqcmVhMNae
	7QX9S/UDzqSkNGEDaPVyrbyFxTgYkksyR6YWnWUaNwN7JZpP04U1AtcrxeUSYI5i0ZnL8=
X-Google-Smtp-Source: AGHT+IFqdc9Sd7yWqiw47jt+H/HlOGVUHh9gcMNodk0QnAMZEsYFII0+WLMvRHm2kVCJFhGfJZZobw==
X-Received: by 2002:a17:90b:3905:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-34f68c621c8mr5149473a91.26.1767849472591;
        Wed, 07 Jan 2026 21:17:52 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfd27953sm6624573a12.11.2026.01.07.21.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 21:17:51 -0800 (PST)
Date: Thu, 08 Jan 2026 14:17:40 +0900 (JST)
Message-Id: <20260108.141740.733187589346821469.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com, ojeda@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 dakr@kernel.org, gary@garyguo.net, lossin@kernel.org, tmgross@umich.edu,
 acourbot@nvidia.com, rust-for-linux@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v1] rust: sync: atomic: Add i32-backed Flag for atomic
 booleans
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72kRipkW-djNqUy3hSb9Dy5LJOr1QgFAaY8vT6KjrMcDEg@mail.gmail.com>
References: <20260101102718.2073674-1-fujita.tomonori@gmail.com>
	<CANiq72kRipkW-djNqUy3hSb9Dy5LJOr1QgFAaY8vT6KjrMcDEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gU3VuLCA0IEphbiAyMDI2IDEzOjA3OjI2ICswMTAwDQpNaWd1ZWwgT2plZGEgPG1pZ3VlbC5v
amVkYS5zYW5kb25pc0BnbWFpbC5jb20+IHdyb3RlOg0KDQo+IE9uIFRodSwgSmFuIDEsIDIwMjYg
YXQgMTE6MjfigK9BTSBGVUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5j
b20+IHdyb3RlOg0KPj4NCj4+ICsvLy8gQW4gYXRvbWljIGZsYWcgdHlwZSBiYWNrZWQgYnkgYGkz
MmAuDQo+IA0KPiBBIGZldyBuaXRzIEkgbm90aWNlZCB3aGlsZSByZWFkaW5nIHRoZSB0aHJlYWQ6
IGludHJhLWRvYyBsaW5rcyB3aGVyZQ0KPiBwb3NzaWJsZS9zaW1wbGUsIGkuZS4gaWYgc29tZSBv
ZiB0aGVtIHJlcXVpcmUgc29tZXRoaW5nIGludm9sdmVkIHRvDQo+IG1ha2UgdGhlbSB3b3JrLCBw
bGVhc2UgaWdub3JlIGl0IQ0KDQpBaCwgZ29vZCBjYXRjaC4gSSBvdmVybG9va2VkIHRoYXQuIEkn
bGwgZml4Lg0KDQoNCj4+ICsvLy8gIyMgRXhhbXBsZXMNCj4gDQo+IEZpcnN0IGxldmVsIGhlYWRl
ciwgaS5lLiBgI2AuDQoNClNvcnJ5LCB3aWxsIGZpeC4NCg0KPj4gKy8vLyB1c2Uga2VybmVsOjpz
eW5jOjphdG9taWM6OntBdG9taWMsIEZsYWcsIFJlbGF4ZWR9Ow0KPj4gKy8vLyBsZXQgZmxhZyA9
IEF0b21pYzo6bmV3KEZsYWc6OkNsZWFyKTsNCj4gDQo+IEdlbmVyYWxseSB3ZSBsZWF2ZSBhIG5l
d2xpbmUgYWZ0ZXIgdGhlIGB1c2VgcyBibG9jayBpbiBleGFtcGxlcy4NCg0KVW5kZXJzdG9vZCwg
d2lsbCBhZGQgYSBibGFuayBsaW5lLg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXchDQo=

