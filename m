Return-Path: <linux-arch+bounces-12671-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 127BEB020CE
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 17:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04A91C8514B
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259A82ED16B;
	Fri, 11 Jul 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VccFEfCm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737792E7BD4;
	Fri, 11 Jul 2025 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248826; cv=none; b=gWbwh2cvjjFCbAJ72Nv8wjOhn7MilX0XRmbsPgg4NSR/eR+jswcgPCcwJGZ48JiwXVVhcbTVULLdwuvLmRUL+CBLTiCY1j8EV1clVOR15qdlVpUCx4l9/fr3uh0nuBopxrPB7btd+8JoGpnQVsq6OqCHgTVrn7ymBxjceMyHWM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248826; c=relaxed/simple;
	bh=2Nh8QxkXw0V2Fc735JNOnhnIyUYWwQyxa7yIKpxASWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fa2jCOgYtRii5UaQ7eVe3icWmaw8pnbcJsES5Zx6p5coXN3CbXAH6TzUVWQLjSRQmDbm+vJuICgBy7MA2ASPgOPysMnGfPAMqquIeQqS2jFlFhXxI1zY9iTz5syL9R+kVPhWrYel24dNQzavNhgtUWY+YgCfPVvGlPkLWF0hfZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VccFEfCm; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso18357946d6.3;
        Fri, 11 Jul 2025 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752248823; x=1752853623; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VLMgwaCu/YbQoZ28wKXJbxPWWcQ4iAAOMGkARakw1GA=;
        b=VccFEfCmB3zhRVpWos9+eNxQhTcUpwSqdGL0nUv7PMxPMduyybjMU0g1ype5dfYeFa
         fi61M0wFk7Ddyi1x+WWRcq2jQLac+FfkE8a/dcQvxJ79J819uFLIAR/OQbTdFVGw8Qn3
         856zLDJHHgo46DnMfedNAmafVoQ3ZMRixPFK5Ny3DzMoKVaqyz60eGnBDA6d4AG1letg
         N9biiZjtIsS6XJOyxVd+DtFrQmtM4hq6fSLfL1sXqi3gATSYMkJjL/AhW/LgD1oFoSdu
         tVGZDb41AEy0bQwyXWoKdChBMtcA3WcgAs7/3ERM/BnOdhMhK5qB+eyrVKV3UbB1xwto
         i7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248823; x=1752853623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLMgwaCu/YbQoZ28wKXJbxPWWcQ4iAAOMGkARakw1GA=;
        b=uLZ+ACDcRNF7wD7ymwpmkwQyuImg0vVJl9RkoZRQrfgEkfn2oe299j5y15ztJFxevj
         TI4vfClPM+4wPn5/0IBpX78RQ5rFWTWZfs4dg0sFHmr8h95w5A3OAFJHEd8so1jL4P1a
         zeR/dbvRt79atoJq0TZplr7haHSofQoFAzMIbtFVxbEBvgWK5p3L6BsaZYvAychuBGPJ
         G1PQ6ax0LXL9H95GZ5wO6o8gcWMc3pMeWxYmRxYCVK8hYKE48jGKZWwTGhpRJGwRLA8h
         3K18BYdtxHLtYdX9yKCLNI6uN95iLtd5JedAKKLYNgNG8bbcrOCakr3BPFN3uJVfmAZL
         m3RA==
X-Forwarded-Encrypted: i=1; AJvYcCU/M9kPaDpl/s1r4p/q92fwz9S4QDWJxcsEmp1Z86lvhNxSOcwdI4opDXNGYjzEnQLaw7d+361/Gd/7seUEkPU=@vger.kernel.org, AJvYcCWnlVaIm6TEm4nwmdQeFJm3vqR7s/ObAI9WzK/OdS4f5bc8zMs55cLENDft87pzOuWgRROgZURiMihy@vger.kernel.org, AJvYcCXpWg1F89pim/fkqtw0atO+PaX7HXxE1nn/5r3mfETc+Fmmvtno5Bw9hyktTnznxAIlJjJuh90twZ63HwjO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzrx+Hiqsq15B1QFrMQSGJ9EDoQR2yRZeltfCnYM1MjR4Hf4aI
	XDrX5C1j45NGbTiaVIoEH98EI+KUGdvpUYpUjTwywi0CQFxWUC30nL19
X-Gm-Gg: ASbGncuSZFCCUbWbv1o/Pm5THCMT3RZnYBA7E6dcwZOwvf7WU2/IdNJPP8rhyR3vsTC
	M3yz5oM0z87+7SfjTFELn5XFDKhUhXxEyjE2dckR0Ntv9ZrusN9eTQSdLX4WOhMhHz6rUv+gBcb
	MZSCyIZ/ljhusx0ViR6n4SMEsBEsIghrPk+JcmCcPSrHS/Qf+NefqQ0i8H2uMo/Q2gCaX+Y263j
	PVSiEKEiuVFVqV0lRG/rvTxhtFJADdnqaYZJLzTxXqY4nUVYJGSXtcYcJ0YOLWz1JoJFTmjbs0g
	6DuONd1EhI5dDJCqSiRuxyHIb2vOYMZttRR5XToFiLp31XpLEKhxyGJRVXvnv7wyClSVc33iPAw
	e3SdlnS2zMfI2Vs8XopkPPdIS++GQLMA1+GjHoMo4PWw5s/4Ope/FiZPl+bHVcpjlENCuCbBlM3
	CMvPcwcq3a6Hka5dJkqE/YUQo=
X-Google-Smtp-Source: AGHT+IGD27pr09cflx9frzlgFAEaJ4AeFDZGrtrkynny/esKSQ0wpel1jyRetyn3dDVhnw+i2wYpQQ==
X-Received: by 2002:ad4:5f8e:0:b0:6e8:fe16:4d44 with SMTP id 6a1803df08f44-704a702e122mr56408506d6.31.1752248823001;
        Fri, 11 Jul 2025 08:47:03 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d3d3b0sm20963706d6.80.2025.07.11.08.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:47:02 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C75A2F4006A;
	Fri, 11 Jul 2025 11:47:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 11 Jul 2025 11:47:01 -0400
X-ME-Sender: <xms:9TFxaLfoAuUzSgkJdsc_R_Q37-SP3uv9Kwku44mVQJ3GZLdXkpUOzg>
    <xme:9TFxaD2_-u3Ar8XALMADKUune2_1vpn-MzPQOune0kf2OWcxXJ4xy75cZjID6RGew
    ZyzAgAWtZjXl0LgTw>
X-ME-Received: <xmr:9TFxaEDp6SeAaYOlRppcEgQpO34hHcBeZ4M09naATqb1XO9R2vVdsoOwxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeekhedtgfejteetueelveduhfehffevteeitefhleetteetfeejleejfefgudel
    ueenucffohhmrghinhepfhhfihdrrhhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrg
    hnughonhhishesghhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrd
    guvghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgr
    rhihghhuohdrnhgvth
X-ME-Proxy: <xmx:9TFxaOTDrVx2RvfOXizuR7D4-A2mjWI5QXuLzjPPv0kLentSBirg9g>
    <xmx:9TFxaGJmncVZFV-1QKB_Nb0K9S8jOxb8MgO8oaKdnLQNkhwkzmV1VQ>
    <xmx:9TFxaFGl6-Vbgrec-C2j0Vt0fjwxrXiL99rnXZlYsm_Dv9ZWSQwUag>
    <xmx:9TFxaNLUSMzLAe60re4pibZTX_gx_PClVURYLpeHJYljl8Qt_92v-A>
    <xmx:9TFxaJ5SQvmd-G7SG5iqcO4NXyJoSb-R3vnngkJ4Ouy0qmv_dxeM5C8D>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 11:47:01 -0400 (EDT)
Date: Fri, 11 Jul 2025 08:46:59 -0700
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
	Alan Stern <stern@rowland.harvard.edu>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 9/9] rust: sync: atomic: Add Atomic<{usize,isize}>
Message-ID: <aHEx85VKv4F_9S61@Mac.home>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-10-boqun.feng@gmail.com>
 <DB93Q0CXTA0G.37LQP5VCP9IGP@kernel.org>
 <CANiq72m9AeqFKHrRniQ5Nr9vPv2MmUMHFTuuj5ydmqo+OYn60A@mail.gmail.com>
 <aHEasoyGKJrjYFzw@Mac.home>
 <CANiq72kvZ7-fMoE9g7SBUrBZy4QMbSL1p8KgBqGhOkenrsr=3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kvZ7-fMoE9g7SBUrBZy4QMbSL1p8KgBqGhOkenrsr=3w@mail.gmail.com>

On Fri, Jul 11, 2025 at 04:40:15PM +0200, Miguel Ojeda wrote:
> On Fri, Jul 11, 2025 at 4:07 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Thanks Miguel.
> >
> > Maybe we can do even better: having a type alias mapping to the exact
> > i{32,64,128} based on kernel configs? Like
> >
> > (in kernel/lib.rs or ffi.rs)
> >
> > // Want to buy a better name ;-)
> > #[cfg(CONFIG_128BIT)]
> > type isize_mapping = i128;
> > #[cfg(CONFIG_64BIT)]
> > type isize_mapping = i64;
> > #[cfg(not(any(CONFIG_128BIT, CONFIG_64BIT)))]
> > type isize_mapping = i32;
> >
> > similar for usize.
> >
> > Thoughts?
> 
> Yeah, I wondered about that too, but I don't know how common it will
> be (so you may want to keep it local anyway), and I wasn't sure what

Sounds good, I will put it locally.

> to call it either, because e.g. something like `isize_mapping` sounds
> like we are talking about `c_long`.
> 
> What we want is a Rust fixed-width integer of the same size of `isize`
> -- so I think you should try to pick a word that evokes a bit that
> part. Something like `fixed_isize` or words like `underlying` or
> `repr` perhaps?
> 

I end up calling it `isize_atomic_repr`, and create the diff as below:

------------>8
diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 7ff87b2b49d6..bb0d3d49e3f7 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -53,14 +53,21 @@ fn delta_into_repr(d: Self::Delta) -> Self::Repr {
     }
 }

+#[allow(non_camel_case_types)]
+#[cfg(not(CONFIG_64BIT))]
+type isize_atomic_repr = i32;
+#[allow(non_camel_case_types)]
+#[cfg(CONFIG_64BIT)]
+type isize_atomic_repr = i64;
+
+crate::static_assert!(core::mem::size_of::<isize>() == core::mem::size_of::<isize_atomic_repr>());
+crate::static_assert!(core::mem::align_of::<isize>() == core::mem::align_of::<isize_atomic_repr>());
+
 // SAFETY: For 32bit kernel, `isize` has the same size and alignment with `i32` and is round-trip
 // transmutable to it, for 64bit kernel `isize` has the same size and alignment with `i64` and is
 // round-trip transmutable to it.
 unsafe impl generic::AllowAtomic for isize {
-    #[cfg(not(CONFIG_64BIT))]
-    type Repr = i32;
-    #[cfg(CONFIG_64BIT)]
-    type Repr = i64;
+    type Repr = isize_atomic_repr;
 }

 // SAFETY: `isize` is always sound to transmute back from `i32` or `i64` when their sizes are the


Seems good?

Regards,
Boqun

> Cheers,
> Miguel

