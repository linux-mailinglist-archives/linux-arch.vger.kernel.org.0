Return-Path: <linux-arch+bounces-12744-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E86BFB04237
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 16:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990A616F496
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204E2594B4;
	Mon, 14 Jul 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRagxvKU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5D2594AA;
	Mon, 14 Jul 2025 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504787; cv=none; b=Ve717bSpwyNKjsQLbozXgQN2jPUn0iIgz+IVDxd/WpAZiERBDOmxfMFAIDmuaEe4XNkly6HgVfJBONf8ZR4B9et0y04dr3ht+8jGzHWlqFn3bRotUszLZnVbdlzqzGhDG1veDmBB3voEHbjS6UkqK6hn3eb0lgFLqM/QFVrGjE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504787; c=relaxed/simple;
	bh=Xi87K1n3E3/9eEQwywuM1RQ8TuihTQgkIKzC4BoyTEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB128lIaz6HVjsXizx9mv3hZIoOfks3j2yhLBUjg9a/jxnbBgoXhPMxK9mAum2S4GPqIvvvKGuBb9CaemC5050PbLqremBVP78BaEeyzOAh8OW/ZqnNmvf4uSjoAf6inTwExrYqsnbIctk1DVY7Xg9NkUBhuuBOKajAnHxM7kG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRagxvKU; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7dfd667e539so318344285a.2;
        Mon, 14 Jul 2025 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752504785; x=1753109585; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6qnE2JyrBpFNh6aD4UkpO19Juwdqz7o/U9HH2b1z+dI=;
        b=IRagxvKU+dRwnsfCgTfXzFTE4/vhWnsAS34nq0tWGH6X9d0kNXPJzi1p/oiKcgAxIX
         1w5S37sAa6aYr1Avvddi3KPY+uzKEPQJsKnZLtO2TFV12/oPl6nWrxYhPfrxETlAPELg
         VI2RFwWApEaii0Ud3VlPZaVej3Oh5sATpoIBkFfxYI7KGPM+CKrindwm+knv8EOGXNHs
         eldjyuPLk4A9efZfDQIoSvH7m/uyshltD6q1bUHIIqbkGn59e1SJmu3s7X9b0tLQVIB4
         zOwZ+GGOLnJjlnZoS/+b35+o1vlfBxr/cLhqHSp94J8jj/dEuLsDOr+UKB8f0FsXgdGz
         3l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504785; x=1753109585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qnE2JyrBpFNh6aD4UkpO19Juwdqz7o/U9HH2b1z+dI=;
        b=FEKW8lGmxkW/c4amv/o4Ldqh/weuBVLQXe4EvguLRdfIr/DNeeiUAQ+J5i8X9QtVlb
         hiGSoRKHLQW++KAHegJd+22FWaraiviWF3WpFir19TdzQSyW2vo6ZtBG8j+zXVJq+4vW
         /wxuVud+wf7Oae9hOXr00ASYNsSu4oxg/pleShzBJTnMQTqz6CkMC8OxKjhqwLMya11R
         6qRgN4el7iiGlsSk7e+A4A+ZX6CpVXnWerTPYBMKK/xTVyBjry8lUTM45mxmQE5B9QKc
         9pj/SIvDif0wX+16NiMnLpzfUvPgYUDaJNgqFkA1MzPPAYysG43RK5z/8hzSESWG8r4Z
         yyRg==
X-Forwarded-Encrypted: i=1; AJvYcCU4oHSF7o9CiujoHq2IBL+PKWjHw85uURzWY/TqPOquFRcZM7py4m9KLkhTBSyFnb3MwBY0ZRWMSv31IJhHdV8=@vger.kernel.org, AJvYcCVoksUcZTF5RhzltRIQd7Rseme1GqNEIqJymXlE/0EuSyaQLdPcj1meSv0Or8T91fh1PKTOEYOdn2cPzL/N@vger.kernel.org, AJvYcCXbaJ526yJuIkVh3fitWeVOzabropsYymANCvn1j2jeT8q3Z0n0/lo2Vp3AYfuZ1nLC7KZvFURa22xQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxX560tqRcAVwFvmMPuuaZYx7bstrzxlLnkI5Pjk/iotxpmrk/L
	TLnVsOFEGl/03KZXhZJ7+ptbvcAPwvIwAkvo37GExnaDAr5Lav7ysGpY
X-Gm-Gg: ASbGncui3m+NQM30EANhxv8JGqxOUPzH7wO2lec7FW20kfq0BW+xtn9mzZZPtWBhqGS
	mUWlUPKotYe1ftbBYGXsqOTC+Ug8v/gZh2lXyJkl7P1lKBFLrYHqsZAMeFLDP2rw5ECjG0LVOdl
	DuADh1Pq6ir7pdHusFxa/E1f4JeIvUt0lX0qd64Jry0AhKOqpT1UnMZL9dS2j08L035yogwQPC0
	7WZ4yohGcyRPhqz4HwHZjkCJhmOA5wCwOgdeT61wTj049K4SIy5OhdB96dQ6p2MghonRunDJ/kP
	uRCzGNNZkQQFF/31FcdajBQJQslo6S+LrSFrssGLVR9ffvWnIuT+YMdlQXfD+hLAoxiLWFq0r3K
	eKh1Gut+7qY7DBZvH2320MFl5l9yCbI+wbEbMfOprUc4G2iNi0lSi6rkZ3i153UDKX5YH34Ps0H
	HziiW/9NJ+0zxm
X-Google-Smtp-Source: AGHT+IGypP/MybZIZ90NbN1IElm2htDIEQjwnBX1LF2MTvz7nWTRAhC3SjCrLmKlr166NWslnLCaUA==
X-Received: by 2002:a05:620a:40cc:b0:7e2:3a27:a117 with SMTP id af79cd13be357-7e23a27a4d6mr866347785a.55.1752504784611;
        Mon, 14 Jul 2025 07:53:04 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e332a794c3sm41568185a.10.2025.07.14.07.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:53:04 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6B252F40066;
	Mon, 14 Jul 2025 10:53:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 14 Jul 2025 10:53:03 -0400
X-ME-Sender: <xms:zxl1aOuAotqCyuRmLoGEdbhMkdl8aLt6jHiBOrbXuFpeznCkxfR3rQ>
    <xme:zxl1aEvnVbdWlAjpjOdQlaV6MyHbzHmaErNVa4l_BMs8ymIgojh_YwJHw3yRmKRpF
    KNA90czcWDs346V5Q>
X-ME-Received: <xmr:zxl1aCowqL3TpmwqvoZqBx-iY4ltN_LVzHO_jw8FI0tDTtNtqlZYywfZyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtieevkeejffffueehleethedtjeduieekgffhveeugeejjeeihfekvdegvdev
    gfenucffohhmrghinhepsggvlhhofidrshgrfhgvthihnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphht
    thhopedvkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhighhuvghlrdhojh
    gvuggrrdhsrghnughonhhishesghhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhi
    nheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhig
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrd
    hlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    rghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:zxl1aAMoVZOSJsH5MKPLSnVoiQEIatbmb3aNLMoNXig-JJnkiPkD7w>
    <xmx:zxl1aAk_RDbPnpZE-0AIOWtxvASesWcpQeOIbI372bBB4Ac6g2BzsA>
    <xmx:zxl1aKtUYoJlOcATb67oqfITdqaNY7l_BMcW6KPaNXq4Ha5fYafZ5w>
    <xmx:zxl1aPmOm6FYkArE_XREcCUknIo2lB7rB9STHOBwqK7FdzIt4A25Lw>
    <xmx:zxl1aDn0EUhwvjQ906NDPDBfpr3v4TCYHigKgfSyBfkuHRWbFbcGxNhM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 10:53:02 -0400 (EDT)
Date: Mon, 14 Jul 2025 07:53:01 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,	Lyude Paul <lyude@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 4/9] rust: sync: atomic: Add generic atomics
Message-ID: <aHUZzdbUSkN_4v2G@Mac.home>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-5-boqun.feng@gmail.com>
 <DBBPI9ZJVO64.3A83G118BMVLI@kernel.org>
 <aHUSgXW9A6LzjBIS@Mac.home>
 <CANiq72mFa0bM_DZV2tHViU0SKqNG_tX6AxBWz4AQ=2UmBrt=nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mFa0bM_DZV2tHViU0SKqNG_tX6AxBWz4AQ=2UmBrt=nQ@mail.gmail.com>

On Mon, Jul 14, 2025 at 04:34:39PM +0200, Miguel Ojeda wrote:
> On Mon, Jul 14, 2025 at 4:22 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Hmm.. why? This is the further information about what the above
> > "Examples" section just mentioned?
> 
> I think Benno may be trying to point out is may be confusing what
> "this" may be referring to, i.e. is it referring to something concrete
> about the example, or about `from_ptr` as a whole / in all cases?
> 

Ok, how about I do this:

diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
index 26d9ff3f7c35..e40010394536 100644
--- a/rust/kernel/sync/atomic/generic.rs
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -135,6 +135,9 @@ pub const fn new(v: T) -> Self {

     /// Creates a reference to an atomic `T` from a pointer of `T`.
     ///
+    /// This usually is used when when communicating with C side or manipulating a C struct, see
+    /// examples below.
+    ///
     /// # Safety
     ///
     /// - `ptr` is aligned to `align_of::<T>()`.
@@ -185,9 +188,6 @@ pub const fn new(v: T) -> Self {
     /// // no data race.
     /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
     /// ```
-    ///
-    /// However, this should be only used when communicating with C side or manipulating a C
-    /// struct.
     pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
     where
         T: Sync,

?

Regards,
Boqun

> Cheers,
> Miguel

